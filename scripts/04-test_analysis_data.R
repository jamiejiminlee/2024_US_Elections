#### Preamble ####
# Purpose: Conducts data quality tests on claen_poll_data to insure quality and validity of data being used for trump_model.rds and harris_model.rds
# Author: Jimin Lee, Sarah Ding, Xiyann Chen
# Date: 26 September 2024
# Contact: jamiejimin.lee@mail.utoronto.ca, sarah.ding@mail.utoronto.ca, xiyan.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: R Packages (tidyverse, janitor, lubridate, arrow, testthat), clean_poll_data
# Additional Information: N/A


#### Workspace setup ####
library(tidyverse)
library(testthat)
library(arrow)

clean_poll_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

# Test 1: Check for Required Columns
test_required_columns <- function(data) {
  required_columns <- c("state", "start_date", "end_date", "pollster", 
                        "numeric_grade", "transparency_score", 
                        "Trump_pct", "Harris_pct")
  missing_columns <- setdiff(required_columns, colnames(data))
  if (length(missing_columns) > 0) {
    stop(paste("Test Failed: Missing columns:", paste(missing_columns, collapse = ", ")))
  } else {
    message("Test Passed: All required columns are present.")
  }
}

# Run the test
test_required_columns(clean_poll_data)

# Test 2: Check Data Types
test_data_types <- function(data) {
  expected_types <- list(
    state = "character",
    start_date = "Date",
    end_date = "Date",
    pollster = "character",
    numeric_grade = "numeric",
    transparency_score = "numeric",
    Trump_pct = "numeric",
    Harris_pct = "numeric"
  )
  
  for (col in names(expected_types)) {
    if (!inherits(data[[col]], expected_types[[col]])) {
      stop(paste("Test Failed: Column", col, "is not of type", expected_types[[col]]))
    }
  }
  message("Test Passed: All columns have expected data types.")
}

# Run the test
test_data_types(clean_poll_data)

# Test 3: Check for NA Values in Critical Columns
test_na_values <- function(data) {
  critical_columns <- c("state", "start_date", "end_date", "Trump_pct", "Harris_pct")
  na_counts <- sapply(data[critical_columns], function(x) sum(is.na(x)))
  if (any(na_counts > 0)) {
    stop(paste("Test Failed: NA values found in columns:", 
               paste(names(na_counts[na_counts > 0]), collapse = ", ")))
  } else {
    message("Test Passed: No NA values in critical columns.")
  }
}

# Run the test
test_na_values(clean_poll_data)

# Test 4: Check Percentage Range
test_percentage_range <- function(data) {
  if (any(data$Trump_pct < 0 | data$Trump_pct > 100)) {
    stop("Test Failed: Trump_pct values are outside the range [0, 100].")
  }
  if (any(data$Harris_pct < 0 | data$Harris_pct > 100)) {
    stop("Test Failed: Harris_pct values are outside the range [0, 100].")
  }
  message("Test Passed: Percentages for Trump and Harris are within the expected range.")
}

# Run the test
test_percentage_range(clean_poll_data)

# Test 5: Check Numeric Grades and Transparency Scores
test_grades_and_scores <- function(data) {
  if (any(data$numeric_grade < 2.5)) {
    stop("Test Failed: Some numeric_grade values are below the minimum threshold of 2.5.")
  }
  if (any(data$transparency_score <= 5)) {
    stop("Test Failed: Some transparency_score values are not greater than 5.")
  }
  message("Test Passed: All numeric grades and transparency scores meet the required thresholds.")
}

# Run the test
test_grades_and_scores(clean_poll_data)

