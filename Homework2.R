# Joseph Lux Homework 2
# 2/5/20

remove(list = ls())

install.packages("mdsr")
library(mdsr)

# Start of Excercise 4.2

library(nycflights13)
glimpse(flights)

prop_cancelled <- flights %>% group_by(month) %>%
  summarize(prop_cancelled = sum(is.na(tailnum)/n()))

ggplot(data = prop_cancelled, aes(x=month, y=prop_cancelled)) + geom_line() + scale_x_continuous(breaks=1:12)

# End of Excercise 4.2

# Start of Excercise 4.3

flights %>% group_by(tailnum) %>%
  summarize(
    numFlight=n()
  ) %>% arrange(desc(numFlight))

# End of Exercise 4.3

# Start of Exercise 4.4 

flightsYear <- flights %>% inner_join(planes, by=c("tailnum" = "tailnum"))
flightsYear %>% select(tailnum, year.y) %>% arrange(year.y)
glimpse(flightsYear)

# End of Excercies 4.4 

# Start of Exercise 4.6

weather
glimpse(weather)

weather_July_2013 <- weather %>% select(year, month, temp, wind_speed, dewp, humid, precip, visib) %>% filter(year == 2013, month == 7)
weather_July_2013
ggplot(data = weather_July_2013, aes(x=temp)) + geom_histogram(binwidth = 3)

ggplot(weather_July_2013, aes(x = wind_speed, y = temp)) + geom_point()
ggplot(weather_July_2013, aes(x=wind_speed)) + geom_dotplot()

ggplot(data = weather_July_2013, aes(x=dewp, y=humid)) + geom_point() + geom_smooth(method=lm)

ggplot(data=weather_July_2013, aes(x=precip, y=visib)) + geom_point() + geom_smooth(method=lm)

# End of Exercise 4.6

# Start of Exercise 4.7

weather %>% filter(precip > 0)

mean_visib <- weather %>% group_by(day) %>% summarize(mean_visibility=mean(visib))
ggplot(data = mean_visib, aes(x=day, y=mean_visibility)) + geom_point()

mean_visib <- weather %>% group_by(month) %>% summarize(mean_visibility=mean(visib))
ggplot(data = mean_visib, aes(x=month, y=mean_visibility)) + geom_line() + geom_point() + scale_x_continuous(breaks=1:12)

# End of Excercise 4.7

# Start of Excercise 4.17

glimpse(Violations)

Violations %>% 
  group_by(zipcode) %>%
  summarize(total_inspec = n(), median_score = median(score))




