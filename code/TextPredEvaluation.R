#1-Load packages
library(quanteda)
library(tidyverse)
library(data.table)


#2-Load n-gram files
dt_bigrams_freq<-data.table(readRDS("/Users/keithpost/Documents/Coursera/Data Science Specialization/10-Data Science Capstone/ShinyAppTextPredictor/text_pred_app/data/dt_bigrams_freq.rds"))
dt_trigrams_freq<-data.table(readRDS("/Users/keithpost/Documents/Coursera/Data Science Specialization/10-Data Science Capstone/ShinyAppTextPredictor/text_pred_app/data/dt_trigrams_freq.rds"))
dt_4grams_freq<-data.table(readRDS("/Users/keithpost/Documents/Coursera/Data Science Specialization/10-Data Science Capstone/ShinyAppTextPredictor/text_pred_app/data/dt_4grams_freq.rds"))
dt_5grams_freq<-data.table(readRDS("/Users/keithpost/Documents/Coursera/Data Science Specialization/10-Data Science Capstone/ShinyAppTextPredictor/text_pred_app/data/dt_5grams_freq.rds"))


#3-Source text prediction model
source("/Users/keithpost/Documents/Coursera/Data Science Specialization/10-Data Science Capstone/ShinyAppTextPredictor/functions/textpred.R")


#4-Preliminary Evaluation of Model
#general testing and processing speed
textpred("they sure like")
system.time(textpred("they sure like"))
textpred("i sincerely wish that you")
system.time(textpred("i sincerely wish that you"))	
textpred("now if only I")
system.time(textpred("now if only I"))
#reasonable predictions and fast processing speed


#5-Preprocess Testing Data
#Create test sample using "random" sampling technique from training data
set.seed(57)
blog_keep<-rbinom(899288,1,.1)
tweet_keep<-rbinom(2360148,1,.1)
news_keep<-rbinom(1010242,1,.1)

#turn logical vectors into vector positions
blogs_nontrain<-which(blog_keep==0)
tweets_nontrain<-which(tweet_keep==0)
news_nontrain<-which(news_keep==0)

#size of "nontrain" data
length(blogs_nontrain) 
length(tweets_nontrain) 
length(news_nontrain) 

#create strings of 0s and 1s from non-train data
set.seed(88)
blog_keep_test<-rbinom(890428,1,.001)
tweet_keep_test<-rbinom(2336334,1,.001)
news_keep_test<-rbinom(1000036,1,.001)

#turn logical vectors into vector positions
blogs_incl_test<-which(blog_keep_test==1)
tweets_incl_test<-which(tweet_keep_test==1)
news_incl_test<-which(news_keep_test==1)

#subset data with vector positions
blogs_test<-USblogs[blogs_incl_test]
tweets_test<-UStweets[tweets_incl_test]
news_test<-USnews[news_incl_test]
text_test<-c(blogs_test,tweets_test,news_test) #combine the three subsetted datasets

#Data Cleaning
#remove non-ASCII characters
text_test<-gsub("[^\x20-\x7E]", "",text_test)

#creating a corpus
corptest<-corpus(text_test) #turns subsetted text into a corpus

#cleaning and creating tokens
tokst<-tokens(corptest,remove_punc=TRUE,remove_separators=TRUE)
test_toks<-tokens_tolower(tokst)

#remove obscene language
badwords<-readLines("/Users/keithpost/Documents/Coursera/Data Science Specialization/10-Data Science Capstone/ShinyAppTextPredictor/text_pred_app/data/badwords.txt")
test_toks_bwr<-tokens_remove(test_toks,badwords) #removes offensive words

#convert to proper object
clean_char_test<-sapply(test_toks_bwr,paste,collapse=" ") #to character vector
clean_corptest<-corpus(clean_char_test) #to corpus
saveRDS(clean_corptest,"/Users/keithpost/Documents/Coursera/Data Science Specialization/10-Data Science Capstone/ShinyAppTextPredictor/text_pred_app/data/corptest.rds")


#6-Source evaluation function
source("/Users/keithpost/Documents/Coursera/Data Science Specialization/10-Data Science Capstone/ShinyAppTextPredictor/functions/acceval.R")


#7-Evaluate model
set.seed(35)
acceval(clean_corptest,n=200) 
#using a sample size of 200, the model was 16, 23, and 28.5% accurate for 1st, top 2, and top 3 word choices
