#### Preamble ####
# Purpose: Models the predicted outcome for the 2024 US Presidential Election
# Author: Jimin Lee, Sarah Ding, Xiyan Chen
# Date: 19 October 2024
# Contact: jamiejimin.lee@mail.utoronto.ca, sarah.ding@mail.utoronto.ca, xiyan.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: Downloaded data from url "https://projects.fivethirtyeight.com/polls/president-general/2024/national/"
# Any other information needed? N/A


#### Modeling Script ####
# Load necessary libraries
library(tidyverse)
library(rstanarm)
library(splines)


# Load cleaned data
clean_poll_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

# Fit Trump model with time spline and state random effects
trump_model <- brm(
  Trump_pct ~ ns(end_date_num, df = 4) + (1 | state),  # Natural spline with 4 degrees of freedom
  data = clean_poll_data,
  family = gaussian(),
  prior = c(
    prior(normal(0, 5), class = "b"),
    prior(normal(0, 10), class = "Intercept")
  ),
  seed = 1234,
  iter = 3000,
  chains = 4,
  control = list(adapt_delta = 0.95)
)

# Fit Harris model with time spline and state random effects
harris_model <- brm(
  Harris_pct ~ ns(end_date_num, df = 4) + (1 | state),
  data = clean_poll_data,
  family = gaussian(),
  prior = c(
    prior(normal(0, 5), class = "b"),
    prior(normal(0, 10), class = "Intercept")
  ),
  seed = 1234,
  iter = 3000,
  chains = 4,
  control = list(adapt_delta = 0.95)
)



# Save the models
saveRDS(trump_model, "models/trump_model.rds")
saveRDS(harris_model, "models/harris_model.rds")


