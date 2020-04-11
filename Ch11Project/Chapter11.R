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

# devtools::install_github("hrbrmstr/streamgraph")
library(streamgraph)
Beatles %>% streamgraph(key = "name", value = "n", date = "year") %>%
  sg_fill_brewer("Accent")


#############################################
#
# 11.2 Dynamic Visualization using ggvis
#
#############################################

John <- filter(Beatles, name == "John")
glimpse(John)

# Something wrong with this function, presumably with the 
# format() function which causes it not to display correctly
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
runApp('/Users/josephlux/Documents/School/DataScience')

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
download.file("http://simonsoftware.se/other/xkcd.ttf",
              dest = "~/Library/Fonts/xkcd.ttf", mode = "wb")
font_import(pattern = "[X/x]kcd", prompt = FALSE)
loadfonts()
beatles_plot + theme_xkcd()

###################################
#
# 11.6 Examples
#
###################################

#Start of Exercise 11.1
library(macleish)
annotations <- bind_rows(
  #Vernal Equinox
  data.frame(x = as.POSIXlt(2015-03-20, tz = "", origin = "2015-04-20"), y = -5,
             label = paste("Vernal Equinox: March 20, 2015"), adj = 0),
  #Autumnal Equinox
  data.frame(x = as.POSIXlt(2015-09-23, tz = "", origin = "2015-04-20"), y = -8,
             label = paste("Autumnal Equinox: September 23, 2015"), adj = 0),
  #Summer Solstice
  data.frame(x = as.POSIXlt(2015-06-21, tz = "", origin = "2015-04-20"), y = -11,
             label = paste("Summer Solstice: June 21, 2015"), adj = 0),
  #Winter Solstice
  data.frame(x = as.POSIXlt(2015-12-21, tz = "", origin = "2015-04-20"), y = -14,
             label = paste("Winter Solstice: December 21, 2015"), adj = 0)
  
)

temperatureGraph <- ggplot(data = whately_2015, aes(x = when, y = temperature)) + geom_point() + xlab("Date/Time") + ylab("Temperature")
temperatureGraph <- temperatureGraph + geom_text(data = annotations, aes(x = x, y = y, label = label), hjust = "left", size = 3)
temperatureGraph

#End of Exercise 11.1

#Start of Exercise 11.3

#Converting to plotly messes with the annotations for some reason
ggplotly(temperatureGraph)

#End of Exercise 11.3