# Joseph Lux
# Ch 12 Solutions

remove(list = ls())
library(mdsr)

db <- src_scidb("airlines")

flights <- tbl(db, "flights")
carriers <- tbl(db, "carriers")
flights
carriers

# Start of Excercise 12.1 (Using 2014 data)

flights %>%
  filter(year == 2014 & month == 5 & day == 14 & dest == "DFW") %>%
  summarize(N=n())

# SELECT * 
# FROM flights 
# WHERE year = 2014 AND month = 5 AND day = 14 AND dest = "DFW";

# End of Excerciese 12.1

# Start of Excercise 12.2 (Using 2011 data)

flights %>% 
  filter(year == 2011 & origin == "SFO" & dest == "JFK") %>% 
  group_by(cancelled) %>%
  summarize(Total_Flights=n())

# SELECT 
#   cancelled, 
#   count(*) AS Total_Flights
# FROM flights
# WHERE year = 2011 AND origin = "SFO" AND dest = "JFK"
# GROUP BY cancelled;

# End of Excercise 12.2 

# Start of Excercise 12.3 (Using 2013 data)

flights %>%
  filter(year == 2013 & origin == "ORD") %>%
  group_by(dest) %>%
  summarize(num_flights = n()) %>%
  arrange(desc(num_flights))

# SELECT 
#   count(*) AS num_flights 
# FROM flights
# WHERE year = 2013 AND origin = "ORD"
# GROUP BY dest
# ORDER BY num_flights desc


# End of Excercise 12.3 

# Start of Excercise 12.4 (Using 2014 data)
# It was unclear whether we should be using the destination airport or origin
# airport with the largest average arrival delay, but it is simple to do either

flights %>% 
  filter(year == 2014) %>%
  group_by(dest) %>% 
  summarize(average_delay = sum(arr_delay)/n()) %>% 
  arrange(desc(average_delay))

flights %>% 
  filter(year == 2014) %>%
  group_by(origin) %>% 
  summarize(avg_arr_delay = sum(arr_delay)/n()) %>% 
  arrange(desc(avg_arr_delay))

# SELECT 
#   avg(arr_delay) as avg_arr_delay
# FROM flights
# WHERE year = 2014
# GROUP BY origin 
# ORDER BY avg_arr_delay desc
  
# End of Excercise 12.4

# Start of Excercise 12.5 (Using 2012 data)

flights %>%
  filter(year == 2012 & (origin == "BDL" | dest == "BDL")) %>%
  summarize(N=n())

# SELECT 
#   count(*) 
# FROM flights
# WHERE year = 2012 AND (origin = "BDL" OR dest = "BDL")

# End of Excercise 12.5

# Start of Excercise 12.6 (Using 2010 data)

flights %>% 
  filter(year == 2010 & month == 9 & day == 26 & origin == "JFK" & dest == "LAX") %>%
  select(carrier, flight)

# SELECT 
#   carrier, 
#   flight
# FROM flights 
# WHERE year == 2010 AND month == 9 AND day == 26 AND origin == "JFK" AND dest == "LAX"

# End of Excercise 12.6 

# Start of Excercise 12.10 (Using 2012 data)

glimpse(flights)

flights %>%
  filter(year == 2012 & (origin == "JFK" | origin == "LGA" | origin == "EWR")) %>%
  group_by(origin) %>%
  summarize(N=n(), 
            pct_cancelled=sum(cancelled)/n(), 
            pct_diverted=sum(diverted)/n(),
            avg_dep_delay = sum(dep_delay)/n(), 
            avg_arr_delay = sum(arr_delay)/n())

# SELECT 
#   avg(cancelled) as pct_cancelled
#   avg(diverted) as pct_cancelled
#   avg(dep_delay) as avg_dep_delay
#   avg(arr_delay) as avg_arr_delay
# FROM flights
# WHERE year = 2012 AND (origin = "JFK" OR origin = "LGA" OR origin = "EWR")
 
# It seems that JFK would be the best airport to take because it has the lowest percentage
# of flights cancelled, it has a low average departure delay, and it has the lowest 
# average arrival delay
  
# End of Excercise 12.10 
  
  
  