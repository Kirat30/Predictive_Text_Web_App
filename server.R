#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tm)
library(waiter)

shinyServer(function(input, output, session) {
    
    waitress <- Waitress$
        new(theme = "overlay-percent")$
        start()
    
    bigram <- readRDS("data/twogram.rds")
    waitress$inc(24)
    quadgram <-  readRDS("data/fourgram.rds")
    waitress$inc(25)
    cnvstart <- readRDS("data/start.rds")
    waitress$inc(25)
    trigram <-  readRDS("data/threegram.rds")
    waitress$inc(25)
    
    waiter_hide()
    waitress$close()
    
    predictWord <- function(primeSentence){
        primeSentence <- tolower(primeSentence)
        primeSentence <- Boost_tokenizer(primeSentence)
        ln <<- length(primeSentence)
        if(ln>=3){
            tripredict(primeSentence)
        }else if(ln==2){
            bipredict(primeSentence)
        }else if(ln==1){
            unipredict(primeSentence)
        }else{
            nullpredict()
        }
    }
    
    tripredict <- function(sentence){
        cols <- which(quadgram[1,]==sentence[ln-2])
        cols <- cols[which(quadgram[2,cols]==sentence[ln-1])]
        cols <- cols[which(quadgram[3,cols]==sentence[ln])]
        if(!is.na(quadgram[4,cols[1]])){
            append(cols,c("", ""))
            prdWords <- quadgram[4,cols[1:3]]
            return(prdWords)
        }else{
            bipredict(sentence)
        }
    }
    
    bipredict <- function(sentence){
        cols <- which(trigram[1,]==sentence[ln-1])
        cols <- cols[which(trigram[2,cols]==sentence[ln])]
        if(!is.na(trigram[3,cols[1]])){
            append(cols,c("", ""))
            prdWords <- trigram[3,cols[1:3]]
            return(prdWords)
        }else{
            unipredict(sentence)
        }
        
    }
    
    unipredict <- function(sentence){
        cols <- which(bigram[1,]==sentence[ln])
        if(!is.na(bigram[2,cols[1]])){
            append(cols,c("", ""))
            prdWords <- bigram[2,cols[1:3]]
            return(prdWords)
        }else{
            ln <<- ln-1
            tripredict(sentence)
        }
        
    }
    
    nullpredict <- function(){
        return(sample(cnvstart,3,replace = FALSE))
    }
    
    rd <- reactive({
        words <- return(predictWord(primeSentence = input$mainbox))
        
        words[1]
    })
    
    observeEvent(input$mainbox, {
        updateActionButton(session = session,inputId = "prd1", label = rd()[1])
    })
    observeEvent(input$mainbox, {
        updateActionButton(session = session,inputId = "prd2", label = rd()[2])
    })
    observeEvent(input$mainbox, {
        updateActionButton(session = session,inputId = "prd3", label = rd()[3])
    })
    observeEvent(input$prd1, {
        updateTextInput(session = session, inputId = "mainbox", value = paste(input$mainbox,rd()[1],sep = " "))
    })
    observeEvent(input$prd2, {
        updateTextInput(session = session, inputId = "mainbox", value = paste(input$mainbox,rd()[2],sep = " "))
    })
    observeEvent(input$prd3, {
        updateTextInput(session = session, inputId = "mainbox", value = paste(input$mainbox,rd()[3],sep = " "))
    })
    
    
})
