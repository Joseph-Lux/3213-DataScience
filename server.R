#server.R
library(mdsr)
library(babynames)
library(shiny)
library(plotly)
Beatles <- babynames %>%
  filter(name %in% c("John", "Paul", "George", "Ringo") & sex == "M")

shinyServer(function(input, output) {
  output$plot <- renderPlot({
    ds <- Beatles %>%
      filter(year >= input$startyear, year <= input$endyear, 
             name %in% input$names)
    
    ggplot(data = ds, aes(x = year, y = prop, color = name)) +
      geom_line(size = 2)
  })
})