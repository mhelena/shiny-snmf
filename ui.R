library(shiny)

shinyUI(fluidPage(
  
  titlePanel("snmf"),
  
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
      plotOutput('ancestralPopulationVector')
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
      numericInput("lambdaValue", "gif:", 0)
    ),
    mainPanel(
      plotOutput('histogram')
    )
  ),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("selectedQ", "q:", 0.1)
    ),
    mainPanel(
      plotOutput('falseDiscoveryControl')
    )
  )
  
))


