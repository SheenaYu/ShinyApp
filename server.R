library(shiny)

library(datasets)
data(state.x77)
st <- as.data.frame(state.x77)
colnames(st)[4] = "Life.Exp"        
colnames(st)[6] = "HS.Grad"

shinyServer(
        function(input, output) {
                output$inputValue <- renderPrint({
                        paste0("Murder = ", input$murder, 
                               ", HS.Grad = ", input$hsgrad, ", Frost = ", input$frost)
                })
                
                fit3 <- lm(Life.Exp ~ Murder + HS.Grad + Frost, data=st)
                
                output$prediction <- renderPrint({
                        
                        newdata3 <- data.frame(Murder = input$murder, HS.Grad = input$hsgrad, Frost = input$frost)
                        pred3 <- predict(fit3, newdata3, interval = ("predict"))
                        if(pred3[2] < 0){
                                pred3[2] = 0
                        }
                        print("Life Expectancy Prediction: ")
                        print(pred3[1])
                        print("The confidence interval:") 
                        print(paste0("(", pred3[2], ", ", pred3[3], ")" ))
                })
                
                output$plot <- renderPlot({
                        print("Residual Diagnostics")
                        plot(fit3, which = 1)
                })
                
                output$summary <- renderPrint({
                        print("summary:")
                        summary(fit3)
                })
        } 
)
