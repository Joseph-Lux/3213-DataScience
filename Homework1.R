# Joseph Lux Homework 1
# 1/27/19

remove(list = ls())

install.packages("mdsr")
library(mdsr)

# Start of Excercise 3.1

library(mosaic)

height_plot <- ggplot(Galton, aes(father,height))
height_plot <- height_plot + geom_point() 
height_plot <- height_plot + geom_smooth(method="lm")
height_plot <- height_plot + facet_wrap(~ sex)
height_plot + xlab("Father Height") + ylab("Child Height")
  
# End of Excercise 3.1

# Start of Excercise 3.2

trail_plot <- ggplot(data = RailTrail, aes(hightemp, volume))
trail_plot + geom_point() + geom_smooth(method="lm") + facet_wrap(~ weekday, labeller=label_both)

# End of Excercise 3.2

# Start of Excercise 3.3

library(babynames)

BabynamesDist <- make_babynames_dist()
angelica <- BabynamesDist %>% filter(name == "Angelica" & sex == "F")
name_plot <- ggplot(data = angelica, aes(x = year, y = prop))
name_plot <- name_plot + geom_line()
name_plot + xlab(NULL) + ylab("Proportion of Girls Named Angelica")

# I'm not sure how to fix the ragged edge on the geom_line() function. 
# geom_area() had the same problem, so I'm not sure how to fix it outside of 
# switching to something like a bar graph with a discrete x axis.

# UPDATE: The jagged edges were created because the male sex is very low, so the
# two graphs are connected. If you differenciate between males and females in some way, 
# it fixes the problem

# The graph shows a sharp rise in popularity of the name Angelica starting around the 
# year 1970. Presumably, something increased the popularity of the name for that short
# period of time, but the only event I could find was that the town's town hall 
# was added to the National Register of Historic Places in 1972.

# End of excercise 3.3

# Start of Excercise 3.5

mlb_plot <- ggplot(data = MLB_teams, aes(yearID, WPct))
mlb_plot <- mlb_plot + geom_line()
mlb_plot <- mlb_plot + aes(color = teamID)
mlb_plot <- mlb_plot + facet_grid(~lgID)
mlb_plot <- mlb_plot + aes(size = normAttend) 
# I didn't know whether or not to include the above line because it makes it 
# essentially unreadable, but the problem said to try to incorporate as many 
# variables as you can into the plot
mlb_plot + xlab(NULL) + ylab("Win Percentage")

# Answer:

ggplot(MLB_teams) + 
  geom_point(aes(x=payroll/1000000, y=WPct, color = teamID, size=metroPop, 
                 shape=lgID, alpha=normAttend)) +
  facet_wrap(~yearID, ncol=1) +
  xlab("Payroll (Millions of USD)") + 
  ylab("Team Winning Percentage")

# End of Excercise 3.5

# Start of Excercise 3.8

library(macleish)

weather_plot <- ggplot(data = whately_2015, aes(as.Date(when), temperature))
weather_plot + geom_line(size = 0.3, color = "darkgray") + 
  geom_smooth() + xlab(NULL) + ylab("Temperature") + scale_x_date()
# UPDATE: as.Date() converts the time signature to a date object
# UPDATE: scale_x_date() scales the x axis to view data as a date

# End of Excercise 3.8

