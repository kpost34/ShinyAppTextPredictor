acceval<-function(corpus,n){
	require("quanteda")
	require("stringr")
	wordframe<-data.frame(pred1=character(),pred2=character(),pred3=character(),correct=character(),score=integer(),stringsAsFactors=FALSE)
	corpsamp<-corpus_sample(corpus,size=n,replace=FALSE)
	for(i in 1:n){
		w<-sample(2:ntoken(corpsamp[i]),1)
		text<-word(corpsamp[i],1,w-1)
		preds<-textpred(text)
		wordframe[i,4]<-word(corpsamp[i],w)
		wordframe[i,seq_along(preds)]<-preds
		wordframe[is.na(wordframe)]<-"00000"
		if(wordframe$pred1[i]==wordframe$correct[i]){wordframe$score[i]<-1}
		else if(wordframe$pred2[i]==wordframe$correct[i]){wordframe$score[i]<-2}
		else if(wordframe$pred3[i]==wordframe$correct[i]){wordframe$score[i]<-3}
		else{wordframe$score[i]<-"0"}
	}
		fwacc<-(length(which(wordframe$score==1))/n)*100
		swacc<-(length(which(wordframe$score==1|wordframe$score==2))/n)*100
		twacc<-(length(which(wordframe$score>0))/n)*100
	output<-list(predicted_and_actual_words=wordframe,first_word_accuraccy=paste0(fwacc,"%"),second_word_accuracy=paste0(swacc,"%"),third_word_accuracy=paste0(twacc,"%"))
	print(output)
<<<<<<< HEAD
}
=======
}
>>>>>>> 7a0732e5dbaab07cac1483b876a119d0045bb774
