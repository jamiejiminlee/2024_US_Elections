#### Preamble ####
# Purpose: Models the predicted outcome for the 2024 US Presidential Election
# Author: Jimin Lee, Sarah Ding, Xiyan Chen
# Date: 19 October 2024
# Contact: jamiejimin.lee@mail.utoronto.ca, sarah.ding@mail.utoronto.ca, xiyan.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: Downloaded data from url "https://projects.fivethirtyeight.com/polls/president-general/2024/national/"
# Any other information needed? N/A

# Load necessary libraries
library(tidyverse)
library(rstanarm)
library(splines)
library(arrow)  # For reading/writing parquet files
library(brms)

# Create a dataset for Donald Trump
trump_data <- clean_poll_data %>%
  select(state, end_date, Trump_pct) %>%
  rename(pct = Trump_pct)

# Convert end_date to numeric (days since the minimum date)
trump_data <- trump_data %>%
  mutate(end_date_num = as.numeric(end_date - min(end_date, na.rm = TRUE)))

# Fit a Bayesian model for Donald Trump using natural splines for end_date_num
trump_model <- brm(
  bf(pct / 100 ~ ns(end_date_num, df = 4) + (1 | state)),  # Natural splines for end_date_num
  data = trump_data,
  family = Beta(link = "logit"),  # Use beta regression for proportions
  prior = c(
    prior(normal(0, 5), class = "b"),
    prior(normal(0, 10), class = "Intercept")
  ),
  seed = 1234,
  iter = 3000,
  chains = 4,
  control = list(adapt_delta = 0.95)
)

# Save the Trump model if needed
saveRDS(trump_model, "models/trump_model.rds")

# Create a dataset for Kamala Harris
harris_data <- clean_poll_data %>%
  select(state, end_date, Harris_pct) %>%
  rename(pct = Harris_pct)

# Convert end_date to numeric (days since the minimum date)
harris_data <- harris_data %>%
  mutate(end_date_num = as.numeric(end_date - min(end_date, na.rm = TRUE)))


# Fit a Bayesian model for Kamala Harris using natural splines for end_date_num
harris_model <- brm(
  bf(pct / 100 ~ ns(end_date_num, df = 4) + (1 | state)),  # Natural splines for end_date_num
  data = harris_data,
  family = Beta(link = "logit"),  # Use beta regression for proportions
  prior = c(
    prior(normal(0, 5), class = "b"),
    prior(normal(0, 10), class = "Intercept")
  ),
  seed = 1234,
  iter = 3000,
  chains = 4,
  control = list(adapt_delta = 0.95)
)

# Save the Harris model if needed
saveRDS(harris_model, "models/harris_model.rds")

