#### Preamble ####
# Purpose: Conducts data quality tests on simulated_data to ensure the quality and validity of simulated data
# Authors: Jimin Lee, Sarah Ding, Xiyann Chen
# Date: 4 November 2024
# Contact: jamiejimin.lee@mail.utoronto.ca, sarah.ding@mail.utoronto.ca, xiyan.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: R Packages (tidyverse, janitor, lubridate, arrow, testthat), simulated_data
# Additional Information: N/A


# Load necessary libraries
library(tidyverse)

# Load the simulated data
simulated_data <- read_csv("data/00-simulated_data/simulated_data.csv")

#### Testing script ####

# Test 1: Check the number of rows and columns
test_that("Simulated data has the correct number of rows and columns", {
  expect_equal(nrow(simulated_data), 1000)
  expect_equal(ncol(simulated_data), 6)  # poll_id, pollster, state, sample_size, candidate, support_percent
})

# Test 2: Check for unique poll IDs
test_that("Poll IDs are unique", {
  expect_equal(length(unique(simulated_data$poll_id)), 1000)
})

# Test 3: Verify sample sizes are within specified range
test_that("Sample sizes are within the range of 500 to 3000", {
  expect_true(all(simulated_data$sample_size >= 500 & simulated_data$sample_size <= 3000))
})

# Test 4: Verify support percentages based on candidate
test_that("Support percentages are correctly assigned", {
  # Check support percentages for Donald Trump
  trump_support <- simulated_data %>% filter(candidate == "Donald Trump") %>% pull(support_percent)
  expect_true(all(trump_support >= 45 & trump_support <= 55))
  
  # Check support percentages for Kamala Harris and Others
  other_support <- simulated_data %>% filter(candidate != "Donald Trump") %>% pull(support_percent)
  expect_true(all(other_support >= 40 & other_support <= 60))
})

# Test 5: Check distributions of candidates, states, and pollsters
test_that("Distribution of candidates, states, and pollsters is as expected", {
  expect_true(all(candidates %in% unique(simulated_data$candidate)))
  expect_true(all(states %in% unique(simulated_data$state)))
  expect_true(all(pollsters %in% unique(simulated_data$pollster)))
})

# Test 6: Check for NA values in the dataset
test_that("There are no NA values in the simulated data", {
  expect_true(all(!is.na(simulated_data)))
})



