#1-Load packages
library("quanteda")
library("tidyverse")
library("data.table")


#2-Get files
setwd("/Users/keithpost/Documents/Coursera/10-Data Science Capstone")
USblogs<-readLines("./final/en_US/en_US.blogs.txt")
UStweets<-readLines("./final/en_US/en_US.twitter.txt")
USnews<-readLines("./final/en_US/en_US.news.txt")


#3-Sample data
#Train data
set.seed(57)
blog_keep<-rbinom(899288,1,.1)
tweet_keep<-rbinom(2360148,1,.1)
news_keep<-rbinom(1010242,1,.1)

#turn logical vectors into vector positions
blogs_incl<-which(blog_keep==1)
tweets_incl<-which(tweet_keep==1)
news_incl<-which(news_keep==1)

#subset data with vector positions
blogs_train<-USblogs[blogs_incl]
tweets_train<-UStweets[tweets_incl]
news_train<-USnews[news_incl]
text_train<-c(blogs_train,tweets_train,news_train) #combine the three subsetted datasets


#4-Data Cleaning
#remove non-ASCII characters
text_train<-gsub("[^\x20-\x7E]", "",text_train)

#creating a corpus
corp<-corpus(text_train) #turns subsetted text into a corpus

#cleaning and creating tokens
toks<-tokens(corp,remove_punc=TRUE,remove_separators=TRUE)
train_toks<-tokens_tolower(toks)

#remove obscene language
badwords<-readLines("badwords.txt")
train_toks_bwr<-tokens_remove(train_toks,badwords) #removes offensive words


#5-Build n-grams and frequency tables
#bigrams
samp_2grams<-tokens_ngrams(train_toks_bwr,n=2,concatenator=" ") 
train_2grams<-as.character(samp_2grams) 

pre_bigrams1<-word(train_2grams[1:2448112],1,1)
pre_bigrams2<-word(train_2grams[2448113:4896225],1,1)
pre_bigrams3<-word(train_2grams[4896226:7344338],1,1)
pre_bigrams4<-word(train_2grams[7344339:9792450],1,1)
pre_bigrams<-c(pre_bigrams1,pre_bigrams2,pre_bigrams3,pre_bigrams4)

last_bigrams1<-word(train_2grams[1:2448112],-1,-1)
last_bigrams2<-word(train_2grams[2448113:4896225],-1,-1)
last_bigrams3<-word(train_2grams[4896226:7344338],-1,-1)
last_bigrams4<-word(train_2grams[7344339:9792450],-1,-1)
last_bigrams<-c(last_bigrams1,last_bigrams2,last_bigrams3,last_bigrams4)

dt_bigrams<-data.table(pre_bigrams,last_bigrams)
dt_bigrams_freq<-dt_bigrams %>% 
	group_by(pre_bigrams,last_bigrams) %>% 
	summarize(n=n()) %>%
	mutate(freq=n/sum(n)) %>%
	select(pre_bigrams,last_bigrams,freq)
saveRDS(dt_bigrams_freq,"dt_bigrams_freq.rds")

#trigrams
samp_3grams<-tokens_ngrams(train_toks_bwr,n=3,concatenator=" ") 
train_3grams<-as.character(samp_3grams)

pre_trigrams1<-word(train_3grams[1:2341232],1,2)
pre_trigrams2<-word(train_3grams[2341233:4682463],1,2)
pre_trigrams3<-word(train_3grams[4682464:7023694],1,2)
pre_trigrams4<-word(train_3grams[7023695:9364926],1,2)
pre_trigrams<-c(pre_trigrams1,pre_trigrams2,pre_trigrams3,pre_trigrams4)

last_trigrams1<-word(train_3grams[1:2341232],-1,-1)
last_trigrams2<-word(train_3grams[2341233:4682463],-1,-1)
last_trigrams3<-word(train_3grams[4682464:7023694],-1,-1)
last_trigrams4<-word(train_3grams[7023695:9364926],-1,-1)
last_trigrams<-c(last_trigrams1,last_trigrams2,last_trigrams3,last_trigrams4)

dt_trigrams<-data.table(pre_trigrams,last_trigrams)
dt_trigrams_freq<-dt_trigrams %>% 
	group_by(pre_trigrams,last_trigrams) %>% 
	summarize(n=n()) %>%
	mutate(freq=n/sum(n)) %>%
	select(pre_trigrams,last_trigrams,freq)
saveRDS(dt_trigrams_freq,"dt_trigrams_freq.rds")

#4grams
samp_4grams<-tokens_ngrams(train_toks_bwr,n=4,concatenator=" ") 
train_4grams<-as.character(samp_4grams)

pre_4grams1<-word(train_4grams[1:2237016],1,3)
pre_4grams2<-word(train_4grams[2237017:4474033],1,3)
pre_4grams3<-word(train_4grams[4474034:6711050],1,3)
pre_4grams4<-word(train_4grams[6711051:8948066],1,3)
pre_4grams<-c(pre_4grams1,pre_4grams2,pre_4grams3,pre_4grams4)

last_4grams1<-word(train_4grams[1:2237016],-1,-1)
last_4grams2<-word(train_4grams[2237017:4474033],-1,-1)
last_4grams3<-word(train_4grams[4474034:6711050],-1,-1)
last_4grams4<-word(train_4grams[6711051:8948066],-1,-1)
last_4grams<-c(last_4grams1,last_4grams2,last_4grams3,last_4grams4)

dt_4grams<-data.table(pre_4grams,last_4grams)
dt_4grams_freq<-dt_4grams %>% 
	group_by(pre_4grams,last_4grams) %>% 
	summarize(n=n()) %>%
	mutate(freq=n/sum(n)) %>%
	select(pre_4grams,last_4grams,freq)
saveRDS(dt_4grams_freq,"dt_4grams_freq.rds")


#5grams
samp_5grams<-tokens_ngrams(train_toks_bwr,n=5,concatenator=" ") 
train_5grams<-as.character(samp_5grams)

pre_5grams1<-word(train_5grams[1:2136553],1,4)
pre_5grams2<-word(train_5grams[2136554:4273106],1,4)
pre_5grams3<-word(train_5grams[4273107:6409659],1,4)
pre_5grams4<-word(train_5grams[6409660:8546212],1,4)
pre_5grams<-c(pre_5grams1,pre_5grams2,pre_5grams3,pre_5grams4)

last_5grams1<-word(train_5grams[1:2136553],-1,-1)
last_5grams2<-word(train_5grams[2136554:4273106],-1,-1)
last_5grams3<-word(train_5grams[4273107:6409659],-1,-1)
last_5grams4<-word(train_5grams[6409660:8546212],-1,-1)d
last_5grams<-c(last_5grams1,last_5grams2,last_5grams3,last_5grams4)

dt_5grams<-data.table(pre_5grams,last_5grams)
dt_5grams_freq<-dt_5grams %>% 
	group_by(pre_5grams,last_5grams) %>% 
	summarize(n=n()) %>%
	mutate(freq=n/sum(n)) %>%
	select(pre_5grams,last_5grams,freq)
saveRDS(dt_5grams_freq,"dt_5grams_freq.rds")