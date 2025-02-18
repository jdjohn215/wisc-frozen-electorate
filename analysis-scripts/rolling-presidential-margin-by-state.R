library(tidyverse)

state.margins <- read_csv("data/dem-rep_pres-vote-shares_by-state_1856to2024.csv")

margin.sum <- state.margins |>
  group_by(state) |>
  arrange(state, year) |>
  mutate(cum_margin_7 = zoo::rollsum(x = abs(margin), k = 7, align = "right", fill = NA),
         cum_margin_3 = zoo::rollsum(x = abs(margin), k = 3, align = "right", fill = NA))

margin.sum |>
  arrange(cum_margin_3)

margin.sum |>
  arrange(cum_margin_3) |>
  select(last_year = year, state, cumulative_margin_3 = cum_margin_3)
