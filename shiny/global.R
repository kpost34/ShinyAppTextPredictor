source("/Users/keithpost/Documents/Coursera/Data Science Specialization/10-Data Science Capstone/ShinyAppTextPredictor/functions/textpred.R")
library(data.table)

#load data
dt_bigrams_freq<-data.table(readRDS("/Users/keithpost/Documents/Coursera/Data Science Specialization/10-Data Science Capstone/ShinyAppTextPredictor/data/dt_bigrams_freq.rds"))
dt_trigrams_freq<-data.table(readRDS("/Users/keithpost/Documents/Coursera/Data Science Specialization/10-Data Science Capstone/ShinyAppTextPredictor/data/dt_trigrams_freq.rds"))
dt_4grams_freq<-data.table(readRDS("/Users/keithpost/Documents/Coursera/Data Science Specialization/10-Data Science Capstone/ShinyAppTextPredictor/data/dt_4grams_freq.rds"))
dt_5grams_freq<-data.table(readRDS("/Users/keithpost/Documents/Coursera/Data Science Specialization/10-Data Science Capstone/ShinyAppTextPredictor/data/dt_5grams_freq.rds"))
