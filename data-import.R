
######################################################
# Author: Hung Vo (An Evaluator Analytics)
# Date: 30/09/2020
# 
# Run this script first to import the DASS-42 data set.
######################################################

# load packages
library(tidyverse)
library(janitor)
library(ggstatsplot)
library(patchwork)
library(ggpubr)

# ================= READ IN THE DASS-42 DATA FILE =================

# import csv file
dass_raw <- read.csv(file = "./data/data.csv",
                     sep = "\t",
                     header = TRUE) %>% 
    janitor::clean_names()

# new variables and recoding for the DaSS-42 data
dass_data <- dass_raw %>% 
    mutate(respondent_id = row_number(),
           depression_total_score = q3a + q5a + q10a + q13a + q16a + q17a + q21a + q24a + q26a + q31a + q34a + q37a + q38a + q42a,
           anxiety_total_score = q2a + q4a + q7a + q9a + q15a + q19a + q20a + q23a + q25a + q28a + q30a + q36a + q40a + q41a,
           stress_total_score = q1a + q6a + q8a + q11a + q12a + q14a + q18a + q22a + q27a + q29a + q32a + q33a + q35a + q39a,
           dass_total_score = depression_total_score + anxiety_total_score + stress_total_score)
