#### Preamble ####
# Purpose: Generates a simulated dataset for polling data in the 2024 US Presidential Election.
# Author: Jimin Lee, Sarah Ding, Xiyan Chen
# Date: 19 October 2024
# Contact: jamiejimin.lee@mail.utoronto.ca, sarah.ding@mail.utoronto.ca, xiyan.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: Downloaded data from url "https://projects.fivethirtyeight.com/polls/president-general/2024/national/"
# Any other information needed? N/A


#### Workspace setup ####
library(tidyverse)
set.seed(853)


#### Simulate data ####
# Define State names
states <- c(
  "California", "Washington", "Pennsylvania", "New York", "Oregon", "Florida",
  "Texas", "Alabama", "New Jersey", "Utah", "Colorado", "Alaska"
)

# Define Pollster
pollsters <- c("CNN", "ActiVote", "Beacon/Shaw", "Morning Consult", "Other")

# Define Parties
parties <- c("DEM", "REP", "Other")

# Define candidates
candidates <- c("Donald Trump", "Kamala Harris", "Other")


# Create a dataset by randomly assigning states and parties to divisions
simulated_data <- tibble(
  poll_id = 1:1000,
  pollster = sample(pollsters, size = 1000, replace = TRUE),
  state = sample(states, size = 1000, replace = TRUE),
  sample_size = sample(500:3000, size = 1000, replace = TRUE),
  candidate = sample(candidates, size = 1000, replace = TRUE),
  support_percent = runif(1000, min = 40, max = 60)
)

simulated_data <- simulated_data %>%
  group_by(poll_id) %>%
  mutate(support_percent = if_else(candidate == "Donald Trump",
                                   runif(1, 45, 55),
                                   100 - runif(1,45,55)))

head(simulated_data)

#### Save data ####
write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")

