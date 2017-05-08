library(shiny)

shinyUI(fluidPage(
  
  titlePanel("SNMF"),
  
  sidebarLayout(
    sidebarPanel( 
      fileInput("genoFile", 
                "Choose geno File",
                accept = c(".geno")),
                  
      sliderInput("k",
                  "K:",
                  min = 1,
                  max = 20,
                  value = c(1,10))
      ),
    mainPanel(
      plotOutput('plot1')
    )
  ),
  
  sidebarLayout(
    sidebarPanel(

      sliderInput("selectedk",
                  "Pick K:",
                  min = 1,
                  max = 20,
                  value = 2)
    ),
    mainPanel(
      plotOutput('qMatrixPlot')
    )
  ),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("lambdaValue", "Lambda:", 0)
    ),
    mainPanel(
      plotOutput('histogram')
    )
  )
  
))


