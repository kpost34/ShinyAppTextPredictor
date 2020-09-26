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


#5-Build n-grams 
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
saveRDS(dt_bigrams,"/Users/keithpost/Documents/Coursera/10-Data Science Capstone/dt_bigrams.rds")

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
saveRDS(dt_trigrams,"/Users/keithpost/Documents/Coursera/10-Data Science Capstone/dt_trigrams.rds")

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
saveRDS(dt_4grams,"/Users/keithpost/Documents/Coursera/10-Data Science Capstone/dt_4grams.rds")

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
last_5grams4<-word(train_5grams[6409660:8546212],-1,-1)
last_5grams<-c(last_5grams1,last_5grams2,last_5grams3,last_5grams4)

dt_5grams<-data.table(pre_5grams,last_5grams)
saveRDS(dt_5grams,"/Users/keithpost/Documents/Coursera/10-Data Science Capstone/dt_5grams.rds")


#6-Process data: remove low frequency stems and pwords and condense data
#bigrams
#load data
dt_bigrams<-data.table(readRDS("/Users/keithpost/Documents/Coursera/10-Data Science Capstone/dt_bigrams.rds"))

#compute stem counts and filter out unique stems (n=1)
dtbi_highf<-
	dt_bigrams %>% 
	add_count(pre_bigrams,name="fwn") %>%
	filter(fwn>1)

#compute pword counts and freqs, sort data, and condense data based on distinct bigrams
dtbi_highfreqs<-
	dtbi_highf %>%
	add_count(pre_bigrams,last_bigrams,name="l1n") %>%
	mutate(l1freq=l1n/fwn) %>%
	mutate(l1freq=round(l1freq,6)) %>%
	arrange(desc(fwn),pre_bigrams,desc(l1freq)) %>%
	distinct(pre_bigrams,last_bigrams,.keep_all=TRUE) 

#keep the three most frequent pwords for each stem and list only the stem and pwords in final table
dtbi_final<-dtbi_highfreqs %>%
	group_by(pre_bigrams) %>%
	slice_max(order_by=c(pre_bigrams,l1freq),n=3,with_ties=FALSE) %>%
	ungroup() %>%
	select(pre_bigrams,last_bigrams)

#save processed data
saveRDS(dtbi_final,"/Users/keithpost/Documents/Coursera/10-Data Science Capstone/ShinyAppTextPredictor/dt_bigrams_freq.rds")

#trigrams
#load data
dt_trigrams<-data.table(readRDS("/Users/keithpost/Documents/Coursera/10-Data Science Capstone/dt_trigrams.rds"))

#compute stem counts and filter out unique stems (n=1)
dttri_highf<-
	dt_trigrams %>% 
	add_count(pre_trigrams,name="f2n") %>%
	filter(f2n>1)

#compute pword counts and freqs, sort data, and condense data based on distinct trigrams
dttri_highfreqs<-
	dttri_highf %>%
	add_count(pre_trigrams,last_trigrams,name="l1n") %>%
	mutate(l1freq=l1n/f2n) %>%
	mutate(l1freq=round(l1freq,6)) %>%
	arrange(desc(f2n),pre_trigrams,desc(l1freq)) %>%
	distinct(pre_trigrams,last_trigrams,.keep_all=TRUE) 

#keep the three most frequent pwords for each stem and list only the stem and pwords in final table
dttri_final<-dttri_highfreqs %>%
	group_by(pre_trigrams) %>%
	slice_max(order_by=c(pre_trigrams,l1freq),n=3,with_ties=FALSE) %>%
	ungroup() %>%
	select(pre_trigrams,last_trigrams)

#save processed data
saveRDS(dttri_final,"/Users/keithpost/Documents/Coursera/10-Data Science Capstone/ShinyAppTextPredictor/dt_trigrams_freq.rds")

#4grams
#load data
dt_4grams<-data.table(readRDS("/Users/keithpost/Documents/Coursera/10-Data Science Capstone/dt_4grams.rds"))

#compute stem counts and filter out unique stems (n=1)
dt4_highf<-
	dt_4grams %>% 
	add_count(pre_4grams,name="f3n") %>%
	filter(f3n>1)

#compute pword counts and freqs, sort data, and condense data based on distinct 4grams
dt4_highfreqs<-
	dt4_highf %>%
	add_count(pre_4grams,last_4grams,name="l1n") %>%
	mutate(l1freq=l1n/f3n) %>%
	mutate(l1freq=round(l1freq,6)) %>%
	arrange(desc(f3n),pre_4grams,desc(l1freq)) %>%
	distinct(pre_4grams,last_4grams,.keep_all=TRUE) 

#keep the three most frequent pwords for each stem and list only the stem and pwords in final table
dt4_final<-dt4_highfreqs %>%
	group_by(pre_4grams) %>%
	slice_max(order_by=c(pre_4grams,l1freq),n=3,with_ties=FALSE) %>%
	ungroup() %>%
	select(pre_4grams,last_4grams)

#save processed data
saveRDS(dt4_final,"/Users/keithpost/Documents/Coursera/10-Data Science Capstone/ShinyAppTextPredictor/dt_4grams_freq.rds")

#5grams
#load data
dt_5grams<-data.table(readRDS("/Users/keithpost/Documents/Coursera/10-Data Science Capstone/dt_5grams.rds"))

#compute stem counts and filter out unique stems (n=1)
dt5_highf<-
	dt_5grams %>% 
	add_count(pre_5grams,name="f4n") %>%
	filter(f4n>1)

#compute pword counts and freqs, sort data, and condense data based on distinct 4grams
dt5_highfreqs<-
	dt5_highf %>%
	add_count(pre_5grams,last_5grams,name="l1n") %>%
	mutate(l1freq=l1n/f4n) %>%
	mutate(l1freq=round(l1freq,6)) %>%
	arrange(desc(f4n),pre_5grams,desc(l1freq)) %>%
	distinct(pre_5grams,last_5grams,.keep_all=TRUE) 

#keep the three most frequent pwords for each stem and list only the stem and pwords in final table
dt5_final<-dt5_highfreqs %>%
	group_by(pre_5grams) %>%
	slice_max(order_by=c(pre_5grams,l1freq),n=3,with_ties=FALSE) %>%
	ungroup() %>%
	select(pre_5grams,last_5grams)

#save processed data
saveRDS(dt5_final,"/Users/keithpost/Documents/Coursera/10-Data Science Capstone/ShinyAppTextPredictor/dt_5grams_freq.rds")