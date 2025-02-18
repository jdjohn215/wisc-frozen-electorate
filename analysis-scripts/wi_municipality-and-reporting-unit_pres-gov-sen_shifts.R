library(tidyverse)

muni.shifts <- read_csv("data/pres-gov-sen_muni-avg-shifts_wi_2004-2024.csv")

muni.shifts |>
  ggplot(aes(year, median_shift_wt)) +
  geom_point() +
  geom_line(color = "gray") +
  ggrepel::geom_text_repel(aes(label = round(median_shift_wt, 2))) +
  labs(title = "Average shift since the previous election",
       subtitle = paste("Each point shows how much the median municipality",
                        "shifted in its vote since the previous election, to either party.",
                        "Municipalities are weighted by total votes cast.")) +
  facet_wrap(facets = ~office)

rep.unit.shifts <- read_csv("data/pres-gov-sen_reporting-unit-avg-shifts_wi_1994-2024.csv")

avg.shifts.rep.unit |>
  ggplot(aes(year, median_shift_wt)) +
  geom_point() +
  geom_line(color = "gray") +
  ggrepel::geom_text_repel(aes(label = round(median_shift_wt, 2))) +
  scale_x_continuous(breaks = seq(1992, 2024, 4)) +
  labs(title = "Average shift since the previous election",
       subtitle = paste("Each point shows how much the median reporting unit",
                        "shifted in its vote since the previous election, to either party.",
                        "Reporting units are weighted by total votes cast.")) +
  facet_wrap(facets = ~office)
