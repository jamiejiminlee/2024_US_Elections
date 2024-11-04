#### Preamble ####
# Purpose: Tests the structure and validity of the simulated Australian 
  #electoral divisions dataset.
# Author: Rohan Alexander
# Date: 26 September 2024
# Contact: rohan.alexander@utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)

analysis_data <- read_csv("data/00-simulated_data/simulated_data.csv")
# Test 1: Check Support Percentage Consistency
test_support_percentage <- function(data) {
  support_summary <- data %>%
    group_by(candidate) %>%
    summarise(avg_support = mean(support_percent), .groups = 'drop')
  
  # Check that the support for "Donald Trump" is between 45 and 55
  trump_support <- support_summary %>% filter(candidate == "Donald Trump") %>% pull(avg_support)
  kamala_support <- support_summary %>% filter(candidate == "Kamala Harris") %>% pull(avg_support)
  
  if (trump_support >= 45 && trump_support <= 55) {
    message("Test 1 Passed: Donald Trump's support percentage is within the expected range.")
  } else {
    stop("Test 1 Failed: Donald Trump's support percentage is outside the expected range.")
  }
  
  # Check that Kamala Harris' support is correctly calculated as well
  if (kamala_support >= 45 && kamala_support <= 55) {
    message("Test 1 Passed: Kamala Harris' support percentage is within the expected range.")
  } else {
    stop("Test 1 Failed: Kamala Harris' support percentage is outside the expected range.")
  }
}

# Run the test
test_support_percentage(simulated_data)


# Test 2: Check Sample Size Range
test_sample_size <- function(data) {
  if (all(data$sample_size >= 500 & data$sample_size <= 3000)) {
    message("Test 2 Passed: All sample sizes are within the expected range.")
  } else {
    stop("Test 2 Failed: There are sample sizes outside the expected range of 500 to 3000.")
  }
}

# Run the test
test_sample_size(simulated_data)

