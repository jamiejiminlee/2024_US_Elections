#### Preamble ####
# Purpose: Prepares polling data for analysis in the 2024 US Presidential Election model by filtering the raw dataset to retain only high-quality polls and focuses on estimates for Donald Trump and Kamala Harris.
# Author: Jimin Lee, Sarah Ding, Xiyan Chen
# Date: 19 October 2024 
# Contact: jamiejimin.lee@mail.utoronto.ca, sarah.ding@mail.utoronto.ca, xiyan.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: Downloaded data from url "https://projects.fivethirtyeight.com/polls/president-general/2024/national/"
# Any other information needed? N/A

#### Workspace setup ####
library(tidyverse)
library(janitor)
library(lubridate)
library(readr)
library(dplyr)

#### Prepare Dataset ####
clean_poll_data <- read_csv("data/01-raw_data/raw_data.csv") |>
  clean_names()

# Replace "nebraska-cd20" with "nebraska"
clean_poll_data <- clean_poll_data |>
  mutate(state = str_replace(state, "Nebraska-CD20", "Nebraska"))

# Filter data to Harris estimates based on high-quality polls after she declared
clean_poll_data <- clean_poll_data |>
  filter(numeric_grade >= 3, transparency_score > 5, candidate_name %in% c("Donald Trump", "Kamala Harris"))
  
head(clean_poll_data)

#### Save data ####
write_csv(clean_poll_data, "data/02-analysis_data/analysis_data.csv")

