library(shiny)

# Define server logic required to output predicted text
server<-function(input, output) {

  predtext<-reactive({
    words<-as.character(input$box1)
    textpred(words)
  })

  output$pred1<-renderText({
    if(input$showWord1){
      predtext()[1]
    }
  })
  output$pred2<-renderText({
    if(input$showWord2){
      predtext()[2]
    }
  })
  output$pred3<-renderText({
    if(input$showWord3){
      predtext()[3]
    }
  })
  output$doc<-renderText({
    paste("This Shiny application is motivated by SwiftKey's text",
          "prediction software. The purpose of this project was to",
          "develop an algorithm that could predict the next word",
          "when given a sample of text. A 10% sample of texts from",
          "a massive corpus (> 4.2 million texts, > 119 million",
          "words) of blogs, tweets, and news articles was processed",
          "(e.g., removing profanity, punctuation, white space)",
          "before training an n-gram model with a Stupid Back-Off",
          "smoothing technique that could predict the next word.",
          "Test out the app by typing in a sample of text, selecting",
          "the top 1-3 choices for the next word, and clicking submit.",sep="\n")
  })
}