### ui.R

library(shiny)

# Define UI for random distribution application 
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Data Products Project"),
    
    # Sidebar with instructions
    sidebarLayout(
        sidebarPanel(
            HTML("Exploration of miles per gallon 
                     versus different automotive features.
                     <br>
                     <strong>Click</strong> on a panel to see a box plot, 
                     summary statistics, data table,  
                     or a simple linear model.
                     <br>
                     <strong>Select</strong> the feature to be compared 
                     in the box plot and the linear 
                     model using the select box below. 
                     <strong>Select</strong> the number of rows to be 
                     displayed in the data table by
                     using the slider bar below." ),
            br(),
            selectInput("variable", "Variable:",
                        c("Cylinders" = "cyl",
                          "Displacement" = "disp",
                          "Rear Axle Ratio" = "drat",
                          "Weight (lb/1000)" = "wt",
                          "Quarter Mile Time" = "qsec",
                          "V orStraight Engine" = "vs",
                          "Transmission" = "am",
                          "# of Forward Gears" = "gear",
                          "# of Carburetors" = "carb")),
            checkboxInput("outliers", "Show outliers", FALSE),
            br(),
            sliderInput("n", 
                        "Number of observations:", 
                        value = 6,
                        min = 1, 
                        max = 32),
            width = 3
        ),
        
        # Show a tabset that includes a plot, summary, and table view
        # of the generated distribution
        mainPanel(
            tabsetPanel(type = "tabs", 
                        tabPanel("Plot", h3(textOutput("caption")), plotOutput("mpgPlot")), 
                        tabPanel("Summary", verbatimTextOutput("summary")), 
                        tabPanel("Table", tableOutput("table")),
                        tabPanel("Simple Linear Model", verbatimTextOutput("slm"))
            )
        )
    )
))