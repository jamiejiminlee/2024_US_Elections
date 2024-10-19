#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Jimin Lee, 
# Date: 19 October 2024 
# Contact: jamiejimin.lee@mail.utoronto.ca 
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)
library(janitor)
library(lubridate)
library(readr)
library(dplyr)

#### Prepare Dataset ####
clean_poll_data <- read_csv("data/01-raw_data/raw_data.csv") |>
  clean_names()

# Filter data to Harris estimates based on high-quality polls after she declared
clean_poll_data <- clean_poll_data |>
  filter(numeric_grade >= 3, transparency_score > 5, candidate_name %in% c("Donald Trump", "Kamala Harris"))
  
head(clean_poll_data)

#### Save data ####
write_csv(clean_poll_data, "data/02-analysis_data/analysis_data.csv")

