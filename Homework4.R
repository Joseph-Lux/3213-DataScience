# Joseph Lux 
# Chapter 05 Solutions
# 02/18/20

remove(list = ls())

install.packages("mdsr")
library(mdsr)
library(dplyr)
# Start of Excercise 5.2

# Write a function count_seasons() that, when given a teamID, 
# will count the number of seasons the team played in the 'Teams' 
# data frame from the Lahman package.

library(Lahman)

count_seasons <- function(x) {
  # x is given teamID
  Teams %>% filter(teamID == x) %>% summarize(total_seasons = n())
}

# End of Excercise 5.2

# Start of Excercise 5.3

bk_teams_list <- c("BR1", "BR2", "BR3", "BR4", "BRO", "BRP", "BRF")

sapply(bk_teams_list, FUN = count_seasons)

# End of Excercise 5.3

# Start of Excercise 5.6
# ERROR: CANNOT FIND OBJECT ds1

library(xtable)

tab <- xtable(ds1)
print(tab, floating=FALSE)

# End of Excercise 5.6

# Start of Excercise 5.7

myData <- read.delim("/Users/josephlux/Documents/School/DataScience/Exercise5-7data.txt", sep=",")
myData

myData %>% gather(key = type, value = val, meanL, sdL, meanR, sdR)
paste(as.character(sex), type, sep=".")
selecr(grp, type, val)
myData %>% spread(key=type, value=val)

# End of Excercise 5.7

# Start of Excercise 5.8

HELPrct
head(HELPrct)
glimpse(HELPrct)

ggplot(data=HELPrct, aes(x=age,y=cesd)) +
  geom_point() +
  facet_grid(~substance) +
  geom_smooth()


# HELPrct %>% 
#   group_by(substance) %>%
#   do(reg_mod())

# End of Excercise 5.8

# Start of Excercise 5.10

fec <- read.csv("/Users/josephlux/Downloads/Homework03/independent_expenditure_2012_short_fixed.csv")
glimpse(fec)

fec_data <- fec %>% 
  group_by(cand_name, sup_opp) %>%
  summarize(total_exp = sum(exp_amo)) %>%
  filter(total_exp > 4000000)
fec_data

ggplot(data = fec_data, aes(x=cand_name, y=total_exp/1000000)) + 
  geom_col() + 
  coord_flip() +
  ylab("Money Spent (millions of USD)") + 
  xlab("")

ggplot(data = fec_data, aes(x=cand_name, y=total_exp/1000000, fill=sup_opp)) + 
  geom_col() + 
  coord_flip() +
  ylab("Money Spent (millions of USD)") + 
  xlab("")

# End of Excercise 5.10

# Start of Excercise 5.11

# So, without actually preparing appropriate .csv datasets or being able to successfully 
# respond to Exercise 5.11, write R/ggplot2 etc code, by assuming one has “candidate_id” 
# as a primary key in a .csv file named
# “house_winners_2012.csv” along with columns
# “candidate_name”, “number_of_votes”, “party”, “percentage_of_votes”
# 
# and that one has “candidate_id” as a primary key in a .csv file named 
# “percentage_dollars_supporting.csv” along with a column “percentage_of_dollar_supporting”

house_winners_2012 <- read.csv("house_winners_2012.csv")
percentage_dollars_supporting <- read.csv("percentage_dollars_supporting.csv")

house_winners_2012 <- house_winners_2012 %>% 
  inner_join(percentage_dollars_supporting) %>%
  filter(party = "Democrat")

ggplot(data = house_winners_2012, 
       aes(x=percentage_of_dollars_supporting, y=percentage_of_votes)) +
  size(total_votes) +
  fill(total_spent) +
  geom_smooth() +
  xlab("Percentage of Money supporting Democratic candidate") + 
  ylab("Percentage of Votes Earned by Democratic candidate")


# End of Excercise 5.11












  