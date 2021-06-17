Text Predictor Shiny App
========================================================
author: Keith Post
date: 9/28/20
autosize: false




Motivation
========================================================
+ Machine-learning algorithms are everywhere in society, including gps, streaming services, and search engines  
+ Wouldn't it be cool to instantly predict the next word in a phrase from your phone or computer using a simple algorithm?  
+ Well, now you can!  
+ Introducing...the Text Predictor shiny app!!


How the Model Works
========================================================
<font size="5.5"> 
+ The Text Predictor is an n-gram model with stupid back-off  
+ n-grams are single words (unigrams) or multiple, consecutive words (e.g., bigrams, trigrams) derived from splitting up text 
+ n-grams can be separated into stems (n-1) and last words  

```r
word("they are so",1,-2) #extracts stem
```

```
[1] "they are"
```
+ Text Predictor was trained on a 10% sample of > 4.2 mill. texts (i.e., blogs, articles, tweets); user text is matched to a stem in the corpus
+ Top 3 choices for next word are returned based on last-word probabilities, e.g., 
    

```r
textpred("i can't believe")
```

```
[1] that i    how 
```
</font>
<font size="5.5"> 
+ If no match occurs, Text Predictor 'backs off' to an n-1 model and repeats the process
</font>


Predictive Performance and Speed
========================================================
<font size="5.8"> 
+ Word prediction is highly accurate
    * Predictive performance measured with Accuracy Evaluator (acceval.R)
    * 200 texts from the test dataset were sampled and 1st, 2nd, and 3rd-word accuracies for Text Predictor's prediction of randomly removed words were measured 

```
$first_word_accuraccy
[1] "12%"

$second_word_accuracy
[1] "16.5%"

$third_word_accuracy
[1] "20%"
```
+ Word prediction is incredibly fast as well (see average processing speeds below for haphazard samples of 1-4grams)

<center>

|n-gram|unigram|bigram|trigram|4gram|
|---|:--:|:--:|:--:|:--:
|Mean processing speed (s)|0.0946|0.1024|0.1006|0.0996|

</center>
</font>

How the App Works
========================================================
+ [Open app in a separate tab] (https://keithhpost.shinyapps.io/shinyapptextpredictor/?_ga=2.159148664.376912172.1601144118-703276549.1600845238)
+ Type your text in the box
+ Check the box(es) for the number of predicted words and click submit
+ Predicted words are displayed to the right/below
+ How it works  
  * Shiny app feeds your text into textpred(), which returns the 1st, 2nd, and/or 3rd choices for the next word based on the boxes checked  
  * Visit my [Github repo](https://github.com/kpost34/ShinyAppTextPredictor) to see the code used to develop this app


