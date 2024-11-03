#### Preamble ####
# Purpose: Prepares polling data for analysis in the 2024 US Presidential Election model by filtering the raw dataset to retain only high-quality polls and focuses on estimates for Donald Trump and Kamala Harris.
# Author: Jimin Lee, Sarah Ding, Xiyan Chen
# Date: 19 October 2024 
# Contact: jamiejimin.lee@mail.utoronto.ca, sarah.ding@mail.utoronto.ca, xiyan.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: Downloaded data from url "https://projects.fivethirtyeight.com/polls/president-general/2024/national/"
# Any other information needed? N/A

# Load the necessary libraries
library(tidyverse)
library(janitor)
library(lubridate)
library(arrow)

# Define battleground states
battleground_states <- c("Arizona", "Georgia", "Michigan", "Nevada", 
                         "North Carolina", "Pennsylvania", "Wisconsin")

# Load the dataset
poll_data <- read_csv("data/01-raw_data/raw_data.csv") |>
  clean_names()  

# Filter and select relevant columns, including only battleground states
clean_poll_data <- poll_data |>
  select(state, start_date, end_date, pollster, numeric_grade, transparency_score, candidate_name, pct) |>
  filter(
    !is.na(state),
    !is.na(numeric_grade),
    !is.na(transparency_score),
    numeric_grade >= 2.5,          # numeric_grade threshold
    transparency_score > 5,        # transparency_score threshold
    candidate_name %in% c("Donald Trump", "Kamala Harris"),
    state %in% battleground_states   # Filter to include only battleground states
  ) |>
  mutate(
    start_date = as.Date(start_date, format = "%m/%d/%y"),
    end_date = as.Date(end_date, format = "%m/%d/%y"),
    end_date_num = as.numeric(end_date - min(end_date, na.rm = TRUE))
  ) |>
  filter(start_date > as.Date("2024-07-21"))  # Filter for start_date after July 21st

# Replace "Nebraska CD-2" with "Nebraska" if it appears in the data
clean_poll_data <- clean_poll_data |>
  mutate(state = str_replace(state, "Nebraska CD-2", "Nebraska"))

# Aggregate pct values by averaging for unique combinations, while keeping additional columns
clean_poll_data <- clean_poll_data |>
  group_by(state, end_date, end_date_num) |>
  summarize(
    Trump_pct = mean(pct[candidate_name == "Donald Trump"], na.rm = TRUE),
    Harris_pct = mean(pct[candidate_name == "Kamala Harris"], na.rm = TRUE),
    start_date = first(start_date),
    pollster = first(pollster),
    numeric_grade = first(numeric_grade),
    transparency_score = first(transparency_score),
    .groups = "drop"
  ) |>
  filter(Trump_pct > 0 & Harris_pct > 0)  # Retain rows with both candidates’ support data

#### Save Data ####
write_parquet(clean_poll_data, "data/02-analysis_data/analysis_data.parquet")

