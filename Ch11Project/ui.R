#ui.R
beatles_names <- c("John", "Paul", "George", "Ringo")

shinyUI(bootstrapPage(
  h3("Frequency of Beatles names over time"),
  numericInput("startyear", "Enter starting year",
               value = 1960, min = 1880, max = 2014, step = 1),
  numericInput("endyear", "Enter ending year",
               value = 1970, min = 1881, max = 2014, step = 1),
  checkboxGroupInput('names', 'Names to display:',
                     sort(unique(beatles_names)),
                     selected = c("George", "Paul")),
  plotOutput("plot")
))
