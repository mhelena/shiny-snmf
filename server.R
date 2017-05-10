library(shiny)
source("https://bioconductor.org/biocLite.R")
biocLite("LEA")
library(LEA)

source("helpers.R")
source("falseDiscoveriesControl.R")

function(input, output, session) {

  snmfObject <- reactive({
    
    inFile <- input$genoFile
    if (is.null(inFile))
      return(NULL)
    
    ext <- tools::file_ext(inFile$name)
    file.rename(inFile$datapath,
                paste(inFile$datapath, ext, sep="."))
    filePath <- paste(inFile$datapath, ext, sep=".")
    print(paste("The location: ", filePath))
    
    krange <- c( input$k[1] : input$k[2])
    
    snmf(filePath,
         K=krange,
         ploidy = 2,
         repetitions = 1,
         entropy = TRUE,
         project = "new")
    
  })
  
  fstValues <- reactive({
    fst.values = fst(snmfObject(), K=input$selectedk)
    fst.values[fst.values < 0] = 0.000001
    
    fst.values
  })
  
  adjPValues <- reactive({
    #fst.values = fst(snmfObject(), K=input$selectedk)
    fst.values = fstValues()
    
    #convert fst values into z-scores (absolute values) 
    n = dim(Q(snmfObject(), K = input$selectedk))[1]
    #fst.values[fst.values < 0] = 0.000001
    K = input$selectedk
    z.scores = sqrt(fst.values*(n-K)/(1-fst.values))
    
    lambda = median(z.scores^2)/qchisq(1/2, df = K-1)
    
    if (input$lambdaValue < 1) {
      updateNumericInput(session, "lambdaValue", value = lambda)
    }
    
    #adj.p.values = pchisq(z.scores^2/input$lambdaValue, df = K-1, lower = FALSE)
    pchisq(z.scores^2/input$lambdaValue, df = K-1, lower = FALSE)
  })
  
  output$text1 <- renderText({ 
    paste("You have chosen a K range that goes from",
          input$k[1], "to", input$k[2])
  })
  
  output$plot1 <- renderPlot({
    
    inFile <- input$genoFile
    if (is.null(inFile))
      return(NULL)
    
    plot(snmfObject())
  })
  
  output$qMatrixPlot <- renderPlot({

    inFile <- input$genoFile
    if (is.null(inFile))
      return(NULL)
      
    barplot(t(Q(snmfObject(), K = input$selectedk)),
            col = 2:3,
            ylab = "Ancestry coefficients",
            xlab = "Sampled individuals")
  })
  
  output$histogram <- renderPlot({
    
    inFile <- input$genoFile
    if (is.null(inFile))
      return(NULL)
    
    hist(adjPValues(), col = "red")
  })
  
  output$falseDiscoveryControl <- renderPlot({
    inFile <- input$genoFile
    if (is.null(inFile))
      return(NULL)
    
    falseDiscoveriesControl(snmfObject(), input$selectedk, adjPValues(), fstValues())
  })

}
