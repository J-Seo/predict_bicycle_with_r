
#title: "서재형 542_(bicycle)analysis"
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
data <- read.csv('/Users/jaehyungseo/Desktop/SJH542_final(bicycle)/dataset/SJH542_c(bicycle).csv')
dim(data)
str(data)

X <- data[,c(1:7)]
Y <- data[,c(8)]

# preprocessing, nearZeroVar
nzv <- nearZeroVar(X, saveMetrics = TRUE)
nzv

# New Dataset

summary(Y)

myM <- data.frame(X, Y)
myM <- transform(myM, Y = cut(Y, breaks = c(0,100,200,300,500,1000),
                 include.lowest = TRUE,
                 right = TRUE,
                 labels = c("very low", "low", "moderate", "high", "very high")))

# Data spliting 
myM <- dataPartitionFUN(myM)

trData <- myM[[1]]
teData <- myM[[2]]
               
# Modeling (random forest default)
model.rf <- caret::train(as.factor(Y) ~ ., method = "rf", data = trData) 
model.rf

# Modeling (random forest K-fold)
my_trControl1 <- trainControl(method = "cv", number = 5)
model.rf_k <- train(Y ~., method = 'rf', data = trData, trControl = my_trControl1)
model.rf_k

# Modeling (random forest Repeated cross validation)
my_trControl2 <- trainControl(method = 'repeatedcv',
                              number = 5,
                              repeats = 3)

model.rf_cv <- train(Y ~., method = 'rf', data = trData, trControl = my_trControl2)
model.rf_cv

# Modeling(rpart Repeated cross validation)
model.rp <- train(Y ~., data = trData, method = 'rpart',
                  trControl = my_trControl2)

# Modeling(neural network Repeated cross validation)
model.nn <- train(Y ~., data = trData, method = 'nnet',
                  trControl = my_trControl2)

# confusionMatrix - random forest
Predict.Y <- predict(model.rf_cv, teData)
print(confusionMatrix(Predict.Y, teData$Y))

# Random Forest evaluation
test.rf <- test_rocFUN(model.rf_cv, teData)
test.rf

# R Partition mechine evaluation
test.rp <- test_rocFUN(model.rp, teData)
test.rp

# Neural Network evaluation
test.nn <- test_rocFUN(model.nn, teData)
test.nn

# Compare models
model.list <- resamples(list(rf = model.rf_cv, rpart = model.rp, nnet = model.nn))
summary(model.list)
bwplot(model.list, metric = "Accuracy")



