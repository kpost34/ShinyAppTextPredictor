textpred<-function(text){
	require("quanteda")
	require("stringr")
	require("dplyr")
	text<-gsub("[[:punct:]]+","",text)
	text<-trimws(gsub(pattern="\\s+"," ",text))
	text<-tolower(text)
	if(ntoken(text)>4) {text<-word(text,-4,-1)}
	if(ntoken(text)==4){
		t3_5grams<-dt_5grams_freq %>% 
			filter(pre_5grams==text) 
		if(nrow(t3_5grams)==0){
			text<-word(text,-3,-1)
		}
		else{
			return(noquote(t3_5grams$last_5grams))
		}
	}
	if(ntoken(text)==3){
		t3_4grams<-dt_4grams_freq %>% 
			filter(pre_4grams==text) 
		if(nrow(t3_4grams)==0){
			text<-word(text,-2,-1)
		}
		else{
			return(noquote(t3_4grams$last_4grams))
		}
	}
	if(ntoken(text)==2){
		t3_trigrams<-dt_trigrams_freq %>% 
			filter(pre_trigrams==text) 
		if(nrow(t3_trigrams)==0){
			text<-word(text,-1,-1)
		}
		else{
			return(noquote(t3_trigrams$last_trigrams))
		}
	}
	if(ntoken(text)==1){
		t3_bigrams<-dt_bigrams_freq %>% 
			filter(pre_bigrams==text) 
		if(nrow(t3_bigrams)==0){
			return(print(noquote("<Unk>")))
		}
		else{return(noquote(t3_bigrams$last_bigrams))
		}
	}
}
