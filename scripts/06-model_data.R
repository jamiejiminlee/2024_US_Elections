#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
clean_poll_data <- read_csv("/Users/jamielee/2024_US_Elections/data/02-analysis_data/analysis_data.csv")

### Model data ####
# Predicting the election outcome:
# We'll assume that the higher pct in a state between Trump and Harris determines the winner. 
# We can use the difference in pct as a predictor for which candidate wins each state. 

# Create a binary outcome for prediction:m 1 if Trump is predicted to win, 0 if Harris
state_average <- state_average |>
  mutate(winner = ifelse(Trump_pct > Harris_pct, 1, 0))

# Create a linear model using pct differences to predict the outcome
linear_model <- lm(winner ~ Trump_pct + Harris_pct, data = state_average)

summary(linear_model)

#### Save model ####
saveRDS(
  linear_model,
  file = "models/first_model.rds"
)


