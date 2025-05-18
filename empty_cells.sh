#!/bin/bash

# ------------------------------------------------------------------
# Author: Akhilesh Gondaliya
# Script: empty_cells.sh
# Purpose: Count number of empty cells per column in a TSV or semicolon file
# Usage: ./empty_cells.sh <filename>
# ------------------------------------------------------------------

if [ $# -ne 1 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

file="$1"

# Detect delimiter
first_line=$(head -n 1 "$file")
if [[ "$first_line" == *";"* ]]; then
    delimiter=";"
else
    delimiter=$'\t'
fi

# Run awk to count empty fields (trimmed)
awk -v FS="$delimiter" '
function trim(s) {
    gsub(/^[ \t\r]+|[ \t\r]+$/, "", s)
    return s
}

NR==1 {
    for (i=1; i<=NF; i++) {
        header[i] = $i
        empty[i] = 0
    }
    next
}

{
    for (i=1; i<=NF; i++) {
        value = trim($i)
        if (value == "") {
            empty[i]++
        }
    }
}

END {
    for (i=1; i<=length(header); i++) {
        printf "%-20s: %d\n", header[i], empty[i]
    }
}
' "$file"
