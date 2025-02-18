library(tidyverse)

annual.correlations <- read_csv("data/wi-senate-executive-correlations.csv")

annual.correlations |>
  ggplot(aes(year, correlation, color = exec_type)) +
  geom_point(show.legend = F) +
  facet_wrap(facets = ~exec_type) +
  labs(title = "Correlation between US Senate and Presidential/Gubernatorial Elections",
       subtitle = str_wrap("among Wisconsin counties since 1914, only includes years where the Democratic & Republican candidates were the top-two vote-getters for both offices", 120),
       caption = "Calculations and graph by John Johnson (@jdjmke) using data collected from ICPRS, Dave Leip's Atlas of American Elections, & the State of Wisconsin",
       x = NULL,
       y = "pearson's correlation coefficient") +
  scale_x_continuous(breaks = seq(1916, 2024, 4)) +
  theme_bw() +
  theme(plot.title.position = "plot",
        strip.text = element_text(face = "bold", size = 12),
        plot.title = element_text(face = "bold", size = 16),
        axis.text.x = element_text(angle = -90, vjust = 0.5))
ggsave("graphics/senate-executive-correlations.png", width = 8.6, height = 6)
