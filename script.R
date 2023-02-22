
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


