
library(readr)
library(tidyverse)

db <- read_delim("input/pinieux2021.csv", 
                 delim = ";", 
                 escape_double = FALSE, 
                 col_types = cols(`2013` = col_integer(), 
                                  `2014` = col_integer(), 
                                  `2015` = col_integer(), 
                                  `2016` = col_integer()),
                 trim_ws = TRUE)
pop <- read_delim("input/frenchPop1316.csv", 
                            delim = ";", 
                  escape_double = FALSE, 
                  col_types = cols(french_population = col_integer(), 
                                   year = col_character()), 
                  trim_ws = TRUE)


db %>% mutate(tot = `2013`+`2014`+`2015`+`2016`) %>% 
  ggplot(mapping = aes(
    x = reorder(histotype, tot),
    y = tot, 
    fill = site)) +
  geom_col() +
  coord_flip() + 
  labs( title = 'Sarcoma in France',
        subtitle = 'Total number of sarcomas from 2013 to 2016',
        caption = 'Data from Pinieux et al. PLOS ONE 2021', 
        x = 'Histotype', 
        y = 'Number of cases', 
        fill = 'Site') +  theme(legend.position = "bottom")


  
