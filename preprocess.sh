#!/bin/bash

# -------------------------------------------------------
# Script Name: preprocess.sh
# Author: Akhilesh Gondaliya
# Purpose:
#   This script cleans and standardizes the board games dataset by:
#     - Changing delimiter from semicolon to tab
#     - Fixing line endings from Windows (\r) to Unix style
#     - Converting European decimal commas to dots
#     - Removing non-ASCII characters (to avoid parsing issues)
#     - Generating new IDs for rows where the ID is missing
#   This prepares the dataset for analysis.
# Usage:
#   ./preprocess.sh input_file.csv > cleaned_output.tsv
# -------------------------------------------------------

if [ $# -ne 1 ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

input="$1"

# Find the highest existing ID to ensure new IDs are unique and not duplicated
max_id=$(tr -d '\r' < "$input" | awk -F';' '
    NR > 1 && $1 ~ /^[0-9]+$/ && $1+0 > max { max = $1+0 }
    END { print (max ? max : 0) }
')

# Process the input file
tr -d '\r' < "$input" | \
sed 's/;/\t/g' | \
sed 's/\([0-9]\),\([0-9]\)/\1.\2/g' | \
tr -cd '\11\12\15\40-\176\n' | \
awk -F'\t' -v OFS='\t' -v start_id="$max_id" '
    BEGIN { id = start_id }
    NR==1 { print; next }
    {
        if ($1 == "") {
            id++
            $1 = id
        }
        print
    }
'
