#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tm)
library(waiter)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    use_waitress(),
    
    titlePanel("Darta Science Capstone Text Predictor by Kirt Preet Singh"),
    
    sidebarLayout(
        sidebarPanel(
            "The text predictor application exploits a model which is a combination of N-grams model and Katz's back-off model. The predictions will be made on the basis of latest 3 words, and following the backoff approach will go down for fewer number of latest words. The added special feature is that if none of the latest words could contribute to a prediction, then the algorithm is designed such that, it will take a single step back at a time and predict on the those basis, thus offering room for correction in response to the bogus/unlikely input(s) by the user."
        ),
        
        mainPanel(
            textInput(inputId = "mainbox",label = "Enter text here:",value = ""),
            actionButton(inputId = "prd1",label = ""),
            actionButton(inputId = "prd2",label = ""),
            actionButton(inputId = "prd3", label = "")
        )
    )
))
