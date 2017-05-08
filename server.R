library(shiny)
source("https://bioconductor.org/biocLite.R")
biocLite("LEA")
library(LEA)

function(input, output, session) {

  # Combine the selected variables into a new data frame
  #selectedData <- reactive({
  #  iris[, c(input$xcol, input$ycol)]
  #})

  #clusters <- reactive({
  #  kmeans(selectedData(), input$clusters)
  #})
  
  output$text1 <- renderText({ 
    paste("You have chosen a K range that goes from",
          input$k[1], "to", input$k[2])
  })
  
  output$plot1 <- renderPlot({
    #palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
    #  "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

    #par(mar = c(5.1, 4.1, 0, 1))
    #plot(selectedData(),
    #     col = clusters()$cluster,
    #     pch = 20, cex = 3)
    #points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
    
    inFile <- input$genoFile
    
    if (is.null(inFile))
      return(NULL)
    
    ext <- tools::file_ext(inFile$name)
    file.rename(inFile$datapath,
                paste(inFile$datapath, ext, sep="."))
    fileLocation <- paste(inFile$datapath, ext, sep=".")
    print(paste("The location: ", fileLocation[1]))
    #return(NULL)
    
    krange <- c( input$k[1] : input$k[2])
    
    snmf.object = snmf(fileLocation,
                       K=krange,
                       ploidy = 2,
                       repetitions = 1,
                       entropy = TRUE,
                       project = "new")
    
    #return(NULL)
    plot(snmf.object)
  })

}
