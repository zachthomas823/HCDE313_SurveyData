#Zach Thomas
#HCDE 313 Spring 2018
#University of Washington, Seattle
#Data from survey of Dorm students on dining habits

#Cleaning Data
library(dplyr)

#Set working directory
setwd("c:/Users/zacht/Documents/HCDE/HCDE313_SurveyData")

#import data
survey.data <- read.csv("2018-05-29-Dorm_dining_habits_at_UW.csv", stringsAsFactors = FALSE)

#Remove irellavant data
survey.data <- survey.data[-c(1,2,6,20), -c(1,2)]
survey.data[,3] <- paste0(survey.data[,3], survey.data[,4])
survey.data <- as.data.frame(lapply(survey.data, function(y) gsub("777", "", y)))
survey.data <- survey.data[,-c(4)]

#Add average values of numeric numbers
survey.data[,c(4:12, 14:16)] <- as.data.frame(lapply(survey.data[,c(4:12,14:16)], function(y) gsub("[^0-9]", "", y)))
survey.data[,c(4:12, 14:16)] <- as.data.frame(lapply(survey.data[,c(4:12,14:16)], function(y) as.numeric(y)), stringsAsFactors = FALSE)
survey.data <- rbind(survey.data, c(NA,NA,NA,mean(survey.data[,4]),mean(survey.data[,5]),mean(survey.data[,6]),mean(survey.data[,7]),
                     mean(survey.data[,8]),mean(survey.data[,9]),mean(survey.data[,10]),mean(survey.data[,11]),mean(survey.data[,12]),
                     NA,mean(survey.data[,14]),mean(survey.data[,15]),mean(survey.data[,16]),NA,NA,NA), stringsAsFactors = FALSE) 

#Fixing Column names
colnames(survey.data) <- c("dorm", "cooking.frequency", "meal", "cultivate", "local.point", "district.market", "husky.den", "food.trucks",
                           "the.8","the.nook","by.george","utensils.own", "produce", "bulk.food", "utensils.buy", "meal.plan","dont.cook","cook")