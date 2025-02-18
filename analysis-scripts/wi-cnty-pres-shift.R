library(tidyverse)

wi.cnty.pres <- read_csv("data/wi-cnty-pres-votes_1852-2024.csv")

wi.winning.margin <- wi.cnty.pres |>
  group_by(year, countyname) |>
  arrange(desc(pct)) |>
  mutate(p2 = paste0("p", row_number())) |>
  ungroup() |>
  filter(p2 %in% c("p1", "p2")) |>
  pivot_wider(names_from = p2, values_from = c(pct, party)) |>
  group_by(countyname) |>
  mutate(margin = pct_p1 - pct_p2,
         countyname = str_remove_all(countyname, coll("."))) |>
  arrange(year, countyname)

unique(wi.winning.margin$countyname)

shifts <- wi.winning.margin |>
  group_by(countyname) |>
  arrange(countyname, year) |>
  mutate(shift = if_else(party_p1 == lag(party_p1, 1, order_by = year),
                         margin - lag(margin, n = 1, order_by = year),
                         margin + lag(margin, n = 1, order_by = year)),
         abs_shift = abs(shift))
annual.shifts <- shifts |>
  filter(year > 1848) |>
  group_by(year) |>
  summarise(counties = n(),
            mean_shift = mean(abs_shift, na.rm = T),
            median_shift = median(abs_shift, na.rm = T),
            median_shift_wt = Hmisc::wtd.quantile(abs_shift, total, probs = 0.5),
            mean_shift_wt = weighted.mean(abs_shift, total, na.rm = T),
            sd_shift = sd(abs_shift, na.rm = T))
annual.shifts |> arrange(median_shift_wt)
