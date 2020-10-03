
# dass-42-analysis

An analysis of the DASS-42 self-report instrument from Open Psychometrics.

## Purpose

This analysis is intended to explore the Depression Anxiety Stress Scale (DASS-42; Lovibond & Lovibond, 1996) self-report instrument. The data has been sourced from [Open Psychometrics](https://openpsychometrics.org/). The first preliminary analysis specifically explores how depression and anxiety scores differ across the personality items within the Ten Item Personality Inventory (TIPI; Gosling, Rentfrow, & Swann Jr, 2003).

## Usage

1. Run the `data-import.R` script to read in the DASS-42 csv data file.
2. Run the `eda.R` script to undertake the exploratory analysis. There is a line in this script that can alternatively run the data import stage for you if needed:

```
# run import script
source("data-import.R")
```

## Disclaimer

The analysis in this repository is only exploratory and caution is warranted when interpreting the results. Credit goes to Open Psychometrics for making this data openly available to the public.

## References

Gosling, S. D., Rentfrow, P. J., & Swann Jr, W. B. (2003). A very brief measure of the big-five personality domains. Journal of Research in Personality, 37(6), 504–528.

Lovibond, S. H., & Lovibond, P. F. (1996). Manual for the depression anxiety stress scales. Psychology Foundation of Australia.