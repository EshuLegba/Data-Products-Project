### server.R

library(shiny)
library(datasets)

mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))
mpgData$vs <- factor(mpgData$vs, labels = c("V-Engine", "Straight"))


# Define server logic for random distribution application
shinyServer(function(input, output) {
    
    formulaText <- reactive({
        paste("mpg ~", input$variable)
    })    

    formulaText2 <- reactive({
        paste("mpg ~ as.factor(", input$variable,")")
    })    
    
    # Return the formula text for printing as a caption
    output$caption <- renderText({
        formulaText()
    })
    
    # Generate a plot of the requested variable against mpg and
    # only include outliers if requested
    output$mpgPlot <- renderPlot({
        boxplot(as.formula(formulaText()),
                data = mpgData,
                outline = input$outliers)
    })

    
    # Generate a summary of the data
    output$summary <- renderPrint({
        summary(mpgData)
    })
    
    # Generate an HTML table view of the data
    output$table <- renderTable({
        head(mpgData,input$n)
    })

    # Generate a simple linear model of the data
    output$slm <- renderPrint({
        lm(as.formula(formulaText2()),
                data = mpgData)
    })
    
    
})