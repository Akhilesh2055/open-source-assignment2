# Assignment 2 – Open Source Script

**Author:** Akhilesh Gondaliya  
**Student ID:** 24644642  
**Date:** 18 May 2025  
**Repository:** GitHub – Open Source Assignment 2

---

## Overview

This project includes three shell scripts developed as part of Assignment 2 for Open Source Programming. The objective is to analyze a dataset of board games and generate insights by cleaning, processing, and analyzing the data using basic Unix utilities and shell scripting.

The scripts are:
- `empty_cells.sh`: Checks and reports the number of empty cells in each column.
- `preprocess.sh`: Cleans and standardizes the dataset.
- `analysis.sh`: Analyzes the cleaned dataset to answer four core research questions.

---

## Script Descriptions

### 1. `empty_cells.sh`
**Purpose:**  
Scans a TSV or TXT dataset and prints the number of missing entries per column. This helps identify data quality issues.

**Usage:**  
```bash
./empty_cells.sh <input_file>
```

---

### 2. `preprocess.sh`
**Purpose:**  
Cleans the dataset by:
- Converting semicolons to tabs.
- Fixing line endings from DOS to UNIX format.
- Replacing decimal commas with periods.
- Removing non-ASCII characters.
- Generating unique IDs for empty ID fields.

**Usage:**  
```bash
./preprocess.sh <input_file> > cleaned_file.tsv
```

---

### 3. `analysis.sh`
**Purpose:**  
Processes the cleaned dataset to:
- Identify the most common mechanics and domains.
- Compute Pearson correlations:
  - Year Published vs. Average Rating
  - Complexity vs. Average Rating

**Usage:**  
```bash
./analysis.sh <cleaned_input_file>
```

---

## Sample Output

```bash
Most popular mechanic: Hand Management (48 games)
Most popular domain: Strategy Games (77 games)
Year vs Rating correlation: 0.226
Complexity vs Rating correlation: 0.426
```

---

## Notes

- All scripts follow Unix standards for text processing and scripting style.
- The code is written using only techniques and commands discussed in class.
- Each script includes detailed comments to improve readability and maintainability.

---

## Git and Commit Strategy

This repository reflects active use of Git with:
- Descriptive commit messages.
- Multiple commits showing the development process.
- Structured branches (if applicable).

---

## License

This project is submitted as part of university coursework and is not intended for redistribution.
