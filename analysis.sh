#!/bin/bash

# -------------------------------------------------------
# Script Name: analysis.sh
# Author: Akhilesh Gondaliya
# Purpose:
#   This script performs statistical and popularity analysis on the cleaned dataset.
#   Specifically, it:
#     - Identifies the most frequent game mechanic and domain
#     - Calculates Pearson correlation between:
#         a) Year published and average rating
#         b) Game complexity and average rating
#   These insights are useful for understanding trends in game popularity and design.
# Usage:
#   ./analysis.sh cleaned_input.tsv
# -------------------------------------------------------

if [ $# -ne 1 ]; then
    echo "Usage: $0 <cleaned_input.tsv>"
    exit 1
fi

input="$1"

awk -F'\t' '
BEGIN {
    OFS = "\t"
}
NR==1 {
    for (i=1; i<=NF; i++) {
        if ($i == "Mechanics") m = i
        if ($i == "Domains") d = i
        if ($i == "Year Published") y = i
        if ($i == "Average Rating") r = i
        if ($i == "Complexity Average") c = i
    }
    next
}
{
    # Count appearances of each mechanic
    split($m, mech, ",")
    for (i in mech) {
        gsub(/^\s+|\s+$/, "", mech[i])
        if (mech[i] != "") mech_count[mech[i]]++
    }

    # Count appearances of each domain
    split($d, dom, ",")
    for (i in dom) {
        gsub(/^\s+|\s+$/, "", dom[i])
        if (dom[i] != "") dom_count[dom[i]]++
    }

    # Correlation: Year Published vs Average Rating
    if ($y != "" && $r != "") {
        yv = $y + 0
        rv = $r + 0
        sum_y += yv; sum_r1 += rv; sum_yr += yv * rv
        sum_y2 += yv * yv; sum_r1_2 += rv * rv
        n1++
    }

    # Correlation: Complexity Average vs Average Rating
    if ($c != "" && $r != "") {
        cv = $c + 0
        rv2 = $r + 0
        sum_c += cv; sum_r2 += rv2; sum_cr += cv * rv2
        sum_c2 += cv * cv; sum_r2_2 += rv2 * rv2
        n2++
    }
}
END {
    for (k in mech_count) if (mech_count[k] > maxm) { maxm = mech_count[k]; topm = k }
    for (k in dom_count) if (dom_count[k] > maxd) { maxd = dom_count[k]; topd = k }

print "The most popular game mechanics is " topm " found in " maxm " games"
print "The most game domain is " topd " found in " maxd " games"

    # Pearson correlation: Year vs Rating
    num1 = n1 * sum_yr - sum_y * sum_r1
    den1 = sqrt((n1 * sum_y2 - sum_y^2) * (n1 * sum_r1_2 - sum_r1^2))
    corr1 = (den1 ? num1 / den1 : "N/A")
    print "The correlation between the year of publication and the average rating is " corr1

    # Pearson correlation: Complexity vs Rating
    num2 = n2 * sum_cr - sum_c * sum_r2
    den2 = sqrt((n2 * sum_c2 - sum_c^2) * (n2 * sum_r2_2 - sum_r2^2))
    corr2 = (den2 ? num2 / den2 : "N/A")
    print "The correlation between the complexity of a game and its average rating is " corr2
}
' "$input"
