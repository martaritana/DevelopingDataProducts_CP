# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(ggplot2)
library(lattice)
library(grid)
library(gridExtra)
library(caret)
library(rpart)

data(iris)
# We load precalculated model instead of fitting one every time the server loads.
# The model was precalculated with following code:
# modelFit <- train(Species ~ ., data=iris, method="rpart")
# save(modelFit, "modelFit.RData")
load("modelFit.RData")
inputIris <- NULL

shinyServer(function(input, output) {
  
  output$distPlot <- renderPlot({
    inputIris <<- data.frame(Sepal.Length=as.numeric(input$sepal_length),
                            Sepal.Width=as.numeric(input$sepal_width),
                            Petal.Length=as.numeric(input$petal_length),
                            Petal.Width=as.numeric(input$petal_width))
    inputIris$Species <<- predict(modelFit, newdata=inputIris)
    Origin <- rep(1, nrow(iris))
    Origin <- c(Origin, 2)
    Origin <- as.factor(Origin)
    levels(Origin) <- c("dataset", "your iris")
    plotData <- rbind(iris, inputIris)
    p1 <- qplot(Sepal.Length, Sepal.Width, data=plotData, colour=Species, shape=Origin, size=Origin)
    p2 <- qplot(Petal.Length, Petal.Width, data=plotData, colour=Species, shape=Origin, size=Origin)
    grid.arrange(p1, p2, nrow=1)
  })
  
  output$specie <- renderPrint({ as.character(inputIris$Species) })
  
})
