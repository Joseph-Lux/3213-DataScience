# Joseph Lux 
# Chapter 11 Code
# 03/31/20

####################
# plotly example
####################

library(mdsr)
library(babynames)
Beatles <- babynames %>%
  filter(name %in% c ("John", "Paul", "George", "Ringo") & sex == "M")
beatles_plot <- ggplot(data = Beatles, aes(x = year, y = n)) +
  geom_line(aes(color = name), size = 2)
beatles_plot

library(plotly)
ggplotly(beatles_plot)

####################
# DT example
####################

library(DT)
datatable(Beatles, options = list(pageLength=25))

####################
# dygraphs example
####################

library(dygraphs)
Beatles %>%
  filter(sex == "M") %>%
  select(year, name, prop) %>%
  tidyr::spread(key = name, value = prop) %>%
  dygraph(main = "Popularity of Beatles names over time") %>%
  dyRangeSelector(dateWindow = c("1940", "1980"))

####################
# steamgraphs example
####################

#devtools::install_github("hrbrmstr/streamgraph")
library(streamgraph)
Beatles %>% streamgraph(key = "name", value = "n", date = "year") %>%
  sg_fill_brewer("Accent")


#############################################
#
# 11.2 Dynamic Visualization using ggvis
#
#############################################

John <- filter(Beatles, name == "John") %>%
  as.data.frame() # This cast is needed. The format() function only works with data frames, not tibbles.
glimpse(John)

all_values <- function(x){
  if (is.null(x)) return(NULL)
  row <- John[John$year == x$year, ]
  paste0(names(row), ": ", format(row), collapse = "<br />")
}

library(ggvis)
John %>%
  ggvis(~n, ~prop, fill = ~year) %>%
  layer_points() %>%
  add_tooltip(all_values, "hover")

#############################################
#
# 11.3 Interactive Web apps with Shiny
#
#############################################

library(shiny)
runApp('C:\\code\\open_source\\3213-DataScience\\Ch11Project')

#############################################
#
# 11.4 Further customization
#
#############################################

# From taking a look at some of the output, it's pretty obvious
# that the organization of the themes has changed somewhat
length(theme_grey())

theme_grey()["panel.background"]
# The next line is different
theme_grey()["panel.grid"]

beatles_plot
beatles_plot + theme_bw()
beatles_plot + theme(panel.background = element_rect(fill = "cornsilk"),
                     panel.grid.major = element_line(color = "dodgerblue"))

# Creating your own theme:
theme_mdsr <- function(base_size = 12, base_family = "Arial") {
  theme_grey(base_size = base_size, base_family = base_family) %+replace%
    theme(
      axis.text = element_text(size = rel(0.8)),
      axis.ticks = element_line(colour = "black"),
      legend.key = element_rect(colour = "grey80"),
      panel.background = element_rect(fill = "whitesmoke", colour = NA),
      panel.border = element_rect(fill = NA, colour = "grey50"),
      panel.grid = element_line(colour = "grey80", size = 0.2),
      #panel.grid = element_line(colour = "grey92", size = 0.5),
      strip.background = element_rect(fill = "grey80", colour = "grey50",
                                      size = 0.2)
      
    )
}
# I had to change my font from Bookman to Arial. 
# Error otherwise

beatles_plot + facet_wrap(~name) + theme_mdsr()

library(ggthemes)
library(xkcd)
beatles_plot + theme_solarized()
beatles_plot + theme_tufte()
beatles_plot + theme_fivethirtyeight()
beatles_plot + theme_excel()

# Using file path for MacOS
# Windows users can skip this line. It's easier to just directly download the font.
download.file("http://simonsoftware.se/other/xkcd.ttf",
              dest = "~/Library/Fonts/xkcd.ttf", mode = "wb")

# Run this line for MacOS / linus
font_import(pattern = "[X/x]kcd", prompt = FALSE)

# Run this line for Windows. The path will need to be changed to work on your computer.
font_import(path="C:\\Users\\InsertYourUsername\\AppData\\Local\\Microsoft\\Windows\\Fonts", pattern = "[X/x]kcd", prompt = FALSE)

loadfonts()
beatles_plot + theme_xkcd()

###################################
#
# 11.6 Examples
#
###################################

#Start of Exercise 11.1
library(macleish)
library(lubridate)
annotations <- bind_rows(
  #Vernal Equinox
  data.frame(x = ymd("2015-03-20", tz="utc"), y = -2,
             label = paste("Vernal Equinox:\nMarch 20, 2015"), adj = 0),
  #Autumnal Equinox
  data.frame(x = ymd("2015-09-23", tz="utc"), y = 19,
             label = paste("Autumnal Equinox:\nSeptember 23, 2015"), adj = 0),
  #Summer Solstice
  data.frame(x = ymd("(2015-06-21", tz="utc"), y = 15,
             label = paste("Summer Solstice:\nJune 21, 2015"), adj = 0),
  #Winter Solstice
  data.frame(x = ymd("2015-12-21", tz="utc"), y = 5,
             label = paste("Winter Solstice:\nDecember 21, 2015"), adj = 0)
  
)

# I switched from using geom_point to geom_smooth b/c the former was lagging my computer
temperatureGraph <- ggplot(data = whately_2015, aes(x = when, y = temperature)) + geom_smooth(color="grey") + xlab("Date/Time") + ylab("Temperature (°C)")
temperatureGraph <- temperatureGraph + geom_text(data = annotations, aes(x = x, y = y, label = label), hjust = "right", size = 3)
temperatureGraph

#End of Exercise 11.1

#Start of Exercise 11.3

#Converting to plotly messes with the annotations for some reason
ggplotly(temperatureGraph)

#End of Exercise 11.3