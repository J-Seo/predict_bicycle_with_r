
#title: "서재형 542_(bicycle)cleansing"
#author: "jaehyungSeo"
#ID: "2014130542"
#date: "12/20/2019"
#class: "BUS256 (2019F)"


# load Ppckages  
rm(list=ls())
options(width=300, scipen=999)

library(tidyverse) 
library(readxl)
library(writexl)
library(caret)
library(reshape)
library(pROC)  
library(ROCR)
library(ggplot2)
library(knitr)

setwd('/Users/jaehyungseo/Desktop/SJH542_final(bicycle)')
source('/Users/jaehyungseo/Desktop/SJH542_final(bicycle)/source_dataMining.R')

# load dataset
data <- read.csv('/Users/jaehyungseo/Desktop/SJH542_final(bicycle)/dataset/SJH542_(bicycle)d.csv')
dim(data)
str(data)

# Cleansing 

data$Y <- data$cnt
data$cnt <- NULL

Y <- data[,14] ## Class variable
data_rv <- data[,c(9:13)] ## removing unimportant variables
head(data_rv)

## data normalizing
data_rv <- transform(data_rv,
                     temp = (temp - min(temp))/ (max(temp) - min(temp)),
                     htemp = (htemp - min(htemp))/ (max(htemp) - min(htemp)),
                     atemp = (atemp - min(atemp))/ (max(atemp) - min(atemp)),
                     hum = (hum - min(hum))/ (max(hum) - min(hum)),
                     wind = (wind - min(wind))/ (max(wind) - min(wind))
)

head(data_rv)

hist(data_rv$temp)
hist(data_rv$atemp)
hist(data_rv$htemp)
hist(data_rv$hum)
hist(data_rv$wind)

# merge data (time + weather variables)
X <- cbind(data[, c(5:6)], data_rv)

newM <- data.frame(X,Y) 

# save data
write.csv(newM, file = "dataset/SJH542_c(bicycle).csv", row.names = FALSE)

