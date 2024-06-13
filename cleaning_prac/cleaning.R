#Load library
library(tidyverse)

#Import dataset
messy_dives<-read_csv('cleaning_prac/whales-dives-messy.csv')

#Look at the clean data
library(dplyr)
library(readr)
dives <- read_csv('https://raw.githubusercontent.com/databrew/intro-to-data-science/main/data/whales-dives.csv')
head(dives)

#Rename
names(messy_dives)<-c(
  'species', #'Species.ID',
  'behavior', #'bhvr',
  'prey.volume', #'PreyVolume',
  'prey.depth', #'PreyDepth',
  'dive.time', #'Dive_Time',
  'surface.time', #'Surfacetime',
  'blow.interval', #'Blow.Interval',
  'blow.number', #'Blow_number_count',
  'year', #'YEAR',
  'month', #'month',
  'day', #'day',
  'sit' #'sit'
)
#Re-do year, month, day , create ID, also drop those 4
messy_dives <- messy_dives %>% 
  mutate(year = ifelse(nchar(year)==2, paste0("20", year), year)) %>% 
  mutate(day=ifelse(nchar(day)==1, paste0("0", day), day)) %>% 
  mutate(month=ifelse(nchar(month)==1, paste0("0", month), month)) %>% 
  mutate(sit=substr(sit,10, 12)) %>%
  arrange(year, month, day) %>% 
  mutate(id=paste0(year, month, day, sit)) %>% 
  select(-sit,-month,-year,-day) %>% 
  select(last_col(), everything())

#Drop NA, FW
messy_dives<- messy_dives %>% 
  drop_na() %>% 
  filter(species %in% c("FW", "FinW", "HW", "Hw")) %>% 
  filter(behavior %in% c("FEED", "OTHER"))

  