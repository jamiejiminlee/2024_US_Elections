#### Preamble ####
# Purpose: Reads and saves data "Presidential General Election Polls - Current Cycle" from Projects 538
# Author: Jimin Lee, Sarah Ding, Xiyan Chen
# Date: 19 October 2024 
# Contact: jamiejimin.lee@mail.utoronto.ca, sarah.ding@mail.utoronto.ca, xiyan.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: Downloaded data from url "https://projects.fivethirtyeight.com/polls/president-general/2024/national/"
# Any other information needed? N/A


#### Workspace setup ####
library(tidyverse)


#### Download data ####
raw_data <- read_csv("/Users/jamielee/Downloads/president_polls.csv")


#### Save data ####
# [...UPDATE THIS...]
# change the_raw_data to whatever name you assigned when you downloaded it.
write_csv(raw_data, "data/01-raw_data/raw_data.csv")