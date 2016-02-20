library(shiny)
library(datasets)

## ui.R for the shiny app project
shinyUI(
        pageWithSidebar(
                # Application title 
                headerPanel("Life expectancy prediction"),
                
                sidebarPanel(
                        
                        sliderInput('murder', 'Murder rate per 100,000 population',value = 4, min = 1, max = 16, step = 0.02),
                        sliderInput('hsgrad', '% high-school graduates',value = 50, min = 30, max = 70, step = 0.1),
                        numericInput('frost', 'mean number of days with minimum temperature below freezing', value = 20,
                                     min = 0, max = 200, step = 1),
                        submitButton('Submit and Predict', icon('refresh')),
                        br(),
                        p("This app loads the data set 'state.x77' and trains a linear model with 3 variables, 
                          murder rate, percent of high school graduates and days of frost. There are 3 tabs of output, prediction,
                          plot and summary. Prediction gives the predicted value and a 95% confidence interval.
                          Plot and summary show the fitting information of the linear model.")
                ), 
                mainPanel(
                        h3('Results of prediction'),
                        h4('You entered'), 
                        verbatimTextOutput("inputValue"), 
                        tabsetPanel(
                                tabPanel("Prediction", verbatimTextOutput("prediction")),
                                tabPanel("Plot", plotOutput("plot")), 
                                tabPanel("Summary", verbatimTextOutput("summary")) 
                        )
                )
        )
)