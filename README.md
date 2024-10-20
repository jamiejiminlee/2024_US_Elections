# Forecasting the 2024 US Presidential Election: Trump vs. Harris

## Overview

This repo documents the steps and processes used in creating the paper "Forecasting the 2024 Election: Trump Dominates the South, Harris Leads in the Midwest".

## File Structure

The repo is structured as:

-   `data/raw_data` contains the raw data as obtained from "National: President: General Election: 2024 Polls | FiveThirtyEight".
-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models. 
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.


## Statement on LLM usage

Aspects of the code were written with the help of the auto-complete tool, ChatGPT. The abstract and introduction were written with the help of ChatGPT and the entire chat history is available in inputs/llms/usage.txt.

## Some checks

- [ ] Change the rproj file name so that it's not starter_folder.Rproj
- [ ] Change the README title so that it's not Starter folder
- [ ] Remove files that you're not using
- [ ] Update comments in R scripts
- [ ] Remove this checklist