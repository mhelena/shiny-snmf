library(shiny)

pageWithSidebar(
  
  headerPanel('SNMF'),
  
  sidebarPanel(
    
    fileInput("genoFile", "Choose geno File",
              accept = c(".geno")),
    
    sliderInput("k",
                "K:",
                min = 1,
                max = 20,
                value = c(1,20))
    
    #selectInput('xcol', 'X Variable', names(iris)),
    #selectInput('ycol', 'Y Variable', names(iris), selected=names(iris)[[2]]),
    #numericInput('clusters', 'Cluster count', 3, min = 1, max = 9)
  ),
  
  mainPanel(
    textOutput("text1"),
    plotOutput('plot1')
  )
  
)
