library(shiny)

# Define UI for application 
ui<-fluidPage(

    # Application title
    titlePanel("Text Predictor"),

    # Sidebar with checkbox input 
    sidebarLayout(
        sidebarPanel(
            textAreaInput("box1","Enter text here"),
            submitButton("Submit"),
            checkboxInput("showWord1","Show most likely word",value=TRUE),
            checkboxInput("showWord2","Show second-most likely word",value=TRUE),
            checkboxInput("showWord3","show third-most likely word",value=TRUE)
        ),
        mainPanel(
            tabsetPanel(type="tabs",
                tabPanel("Predicted text",  
                    h3("Predicted text"),
                    h4("1st choice"),
                    textOutput("pred1"),
                    h4("2nd choice"),
                    textOutput("pred2"),
                    h4("3rd choice"),
                    textOutput("pred3")),
                tabPanel("Documentation",br(),verbatimTextOutput("doc")),
                tabPanel("Code",tags$div(
                            "If you would like to see the code for this Shiny app, please visit my",
                            tags$a(href="https://github.com/kpost34/ShinyAppTextPredictor", 
                                   "Github repo"),"."))
                
            )
        )
    )
)
