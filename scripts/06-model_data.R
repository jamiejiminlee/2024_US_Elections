#### Preamble ####
# Purpose: Models the predicted outcome for the 2024 US Presidential Election
# Author: Jimin Lee, Sarah Ding, Xiyan Chen
# Date: 19 October 2024
# Contact: jamiejimin.lee@mail.utoronto.ca, sarah.ding@mail.utoronto.ca, xiyan.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: Downloaded data from url "https://projects.fivethirtyeight.com/polls/president-general/2024/national/"
# Any other information needed? N/A
#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
# Load the cleaned polling data
clean_poll_data <- read_csv("/Users/jamielee/2024_US_Elections/data/02-analysis_data/analysis_data.csv")


### Prepare Model Data ####
# Aggregating polling percentages for Trump and Harris by state
state_average <- clean_poll_data %>%
  group_by(state) %>%
  summarise(
    Trump_pct = mean(pct[candidate_name == "Donald Trump"], na.rm = TRUE),
    Harris_pct = mean(pct[candidate_name == "Kamala Harris"], na.rm = TRUE)
  )

# Create a binary outcome for prediction: 1 if Trump is predicted to win, 0 if Harris
state_average <- state_average %>%
  mutate(winner = ifelse(Trump_pct > Harris_pct, 1, 0))

#### Bayesian Logistic Regression Model with Regularization ####
# Using a regularized logistic regression model from rstanarm to avoid convergence issues
logistic_model <- stan_glm(winner ~ Trump_pct + Harris_pct, data = state_average, family = binomial, 
                           prior = student_t(df = 7), chains = 4, iter = 2000)

# Display the summary of the model
summary(logistic_model)

#### Save Model ####
# Save the trained logistic model for future use
saveRDS(logistic_model, file = "models/first_model.rds")

