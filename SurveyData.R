#Zach Thomas
#HCDE 313 Spring 2018
#University of Washington, Seattle
#Data from survey of Dorm students on dining habits

#Cleaning Data

library(dplyr)

#Set working directory
setwd("c:/Users/zacht/Documents/HCDE/HCDE313_SurveyData")
#import data

survey.data <- read.csv("2018-05-29-Dorm_dining_habits_at_UW.csv")
