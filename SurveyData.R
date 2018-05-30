#Zach Thomas
#HCDE 313 Spring 2018
#University of Washington, Seattle
#Data from survey of Dorm students on dining habits

#Cleaning Data
library(dplyr)
library(ggplot2)

#Set working directory
setwd("c:/Users/zacht/Documents/HCDE/HCDE313_SurveyData")

#import data
survey.data <- read.csv("2018-05-29-Dorm_dining_habits_at_UW.csv", stringsAsFactors = FALSE)

#Remove irellavant data
survey.data <- survey.data[-c(1,2,6,20), -c(1,2)]
survey.data[,3] <- paste0(survey.data[,3], survey.data[,4])
survey.data <- as.data.frame(lapply(survey.data, function(y) gsub("777", "", y)))
survey.data <- survey.data[,-c(4)]

#Function for adding a row with average values of numeric numbers
addAverage <- function(input.data) {
  input.data[,c(4:12,14:16)] <- as.data.frame(lapply(input.data[,c(4:12,14:16)], function(y) gsub("[^0-9]", "", y)), stringsAsFactors = FALSE)
  input.data[,c(4:12,14:16)] <- as.data.frame(lapply(input.data[,c(4:12,14:16)], function(y) as.character(y)), stringsAsFactors = FALSE)
  input.data[,c(4:12,14:16)] <- as.data.frame(lapply(input.data[,c(4:12,14:16)], function(y) as.double(y)), stringsAsFactors = FALSE)
  final.data <- rbind(input.data, c(NA,NA,NA,mean(input.data[,4]),mean(input.data[,5]),mean(input.data[,6]),mean(input.data[,7]),
                       mean(input.data[,8]),mean(input.data[,9]),mean(input.data[,10]),mean(input.data[,11]),mean(input.data[,12]),
                       NA,mean(input.data[,14]),mean(input.data[,15]),mean(input.data[,16]),NA,NA,NA), stringsAsFactors = FALSE)
  return(final.data)
}

#Fixing Column names
colnames(survey.data) <- c("dorm", "cooking.frequency", "meal", "cultivate", "local.point", "district.market", "husky.den", "food.trucks","the.8",
                           "the.nook","by.george","facilities","utensils.own", "produce", "bulk.food", "utensils.buy", "meal.plan","dont.cook","cook")

#Filtering by dorm
alder <- filter(survey.data, dorm == "Alder Hall") %>% 
  addAverage()
elm <- filter(survey.data, dorm == "Elm Hall") %>% 
  addAverage()
haggett <- filter(survey.data, dorm == "Haggett Hall") %>% 
  addAverage()
maple <- filter(survey.data, dorm == "Maple Hall") %>% 
  addAverage()
mcmahon <- filter(survey.data, dorm == "McMahon Hall") %>% 
  addAverage()
mercer <- filter(survey.data, dorm == "Mercer Court") %>% 
  addAverage()
stevens <- filter(survey.data, dorm == "Stevens Court") %>% 
  addAverage()
terry <- filter(survey.data, dorm == "Terry Hall") %>% 
  addAverage()


#Seperate by preferred dining option (Opt out entirely, below lowest currently offered, level currently offered)
opt.out <- filter(survey.data, meal.plan == "I would choose to opt out of the dining plan entirely.") %>% 
  addAverage()
low.plan <- filter(survey.data, meal.plan == "I would choose a dining plan level below the current Level 1.") %>% 
  addAverage()
curr.plan <- filter(survey.data, meal.plan == "I would choose a dining plan level currently available.") %>% 
  addAverage()

