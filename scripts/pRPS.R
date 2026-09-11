# Libraries
library(tidyverse)
library(ggdark)

# Load data
db <- read.csv("./input/RPS.csv") %>% 
  group_by(histotype, PMID) %>%
  summarise(N = sum(number), .groups = "drop") %>%
  group_by(histotype) %>%
  mutate(total = sum(N)) %>%
  ungroup() %>%
  mutate(percentage = N / sum(N))

# Plot stacked bars with each bar scaled to the histology's share of all cases.
ggplot(db, aes(
  x = reorder(histotype, total),
  y = percentage,
  fill = as.factor(PMID)
)) +
  geom_col(position = "stack") +
  coord_flip() +
  scale_y_continuous(labels = scales::percent_format()) +
  scale_fill_discrete(labels = c(
  "26727100" = "Gronchi 2016",
  "25915910" = "Tan 2016"
)) +
  labs(
    title = 'Retroperitoneal Sarcomas',
    x = 'Histotype',
    y = 'Percentage of all cases',
    fill = 'Publication'
  ) #+
  #dark_theme_gray()

ggsave('output/RPS.png', 
       width = 5,
       height = 3,
       dpi = 600)
