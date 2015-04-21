library(shiny)
library(ggplot2)

setwd("~/Projects/R/Data Products")
if(!exists("stormData")) {
  stormData <- read.csv("repdata_data_StormData.csv", sep=",")  
}

stormData$year <- format(as.Date(stormData$BGN_DATE, format = "%m/%d/%Y %H:%M:%S"), "%Y")
                         
stormDataTX <- subset(stormData, STATE == "TX")
stormDataCA <- subset(stormData, STATE == "CA")
stormDataNY <- subset(stormData, STATE == "NY")
stormDataOH <- subset(stormData, STATE == "OH")
stormDataTN <- subset(stormData, STATE == "TN")
stormDataSC <- subset(stormData, STATE == "SC")

shinyServer(function(input, output) {
  
  output$error_message <- renderText({
    input$goBtn
    isolate({
      stateList <- input$selectState
      paste(stateList, "")  
    })  
  })
  
  output$distPlot <- renderPlot({ 
    input$goBtn
    isolate({
      
      stateList <- input$selectState

      pData <- c()
      
      for(i in 1:length(stateList)) {
        if(stateList[i] == 1) {
          pData <- rbind(pData, stormDataTX)
        }
        
        if(stateList[i] == 2) {
          pData <- rbind(pData, stormDataCA)
        }
        
        if(stateList[i] == 3) {
          pData <- rbind(pData, stormDataNY)
        }
        
        if(stateList[i] == 4) {
          pData <- rbind(pData, stormDataOH)
        }
        
        if(stateList[i] == 5) {
          pData <- rbind(pData, stormDataTN)
        }
        
        if(stateList[i] == 6) {
          pData <- rbind(pData, stormDataSC)
        }  
      }
      
      ggplot(pData, aes(x=year)) + geom_histogram(binwidth=.5, title="Record Frequency By Year") + 
        theme(text = element_text(size=10), axis.text.x = element_text(angle=90, vjust=1))      
    })
  })
  
}
)
