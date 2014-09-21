# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("Which iris you have?"),
  
  sidebarPanel(
    h2("Instructions"),
    p("This site is designed for determining your iris specie. Input your flower parameters with sliders below and get the result."),
    h2("Your iris parameters"),
    sliderInput("sepal_length", "Sepal Length",
                min=4, max=8, step=0.1, value=5.1),
    sliderInput("sepal_width", "Sepal Width",
                min=2, max=4.5, step=0.1, value=3.5),
    sliderInput("petal_length", "Petal Length",
                min=1, max=7, step=0.1, value=1.4),
    sliderInput("petal_width", "Petal Width",
                min=0.1, max=2.5, step=0.1, value=0.2)
  ),
  
  mainPanel(
    h2("Results"),
    p("Your iris is"),
    verbatimTextOutput("specie"),
    p("Dataset plot"),
    plotOutput("distPlot")
  )
))
