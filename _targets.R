# Modes Of Inference

# Packages
library(targets)
library(tarchetypes)
library(tidyverse)
library(data.table)
library(gt)

# Source
tar_source('R')

# Variables
path <- 'data/publications.csv'

# Targets
c(
  tar_target(
    prepared,
    prep_data(path)
  ),
  tar_target(
    likelihood_ratios,
    calc_likelihood_ratios(prepared)
  ),
  tar_target(
    over_time,
    calc_over_time(prepared)
  ),
  tar_target(
    plot_fig_1,
    fig_1(likelihood_ratios)
  ),
  tar_target(
    tab_1,
    table_1(over_time)
  ),
  tar_target(
    plot_fig_s1,
    fig_s1(likelihood_ratios)
  ),
  tar_quarto(
    results,
    file.path('results', 'results.qmd')
  )
)
