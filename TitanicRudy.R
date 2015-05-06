
## Load Libraries
library(class)
library(e1071)


## Data read
setwd("D:/Titanic/kaggle")
traindata <- read.csv("train.csv", header = TRUE, stringsAsFactors = FALSE)
testdata <- read.csv("test.csv", header = TRUE, stringsAsFactors = FALSE)

## Data Preperation
## transform PClass
traindata$Pclass <- factor(traindata$Pclass)

## transform Sex
traindata$Sex <- factor(traindata$Sex)

## transfrom age to factors, missing, young adults and old
age <- traindata$Age
age[is.na(age)] <- -1
traindata$Age <- cut(age,c(-3,0,16,60,120),labels=c("unknown","young","adults","old"))

## transform Fare to factors
traindata$Fare<-cut(traindata$Fare,c(-0.1,5,15,60,600),labels = c("free","cheap","normal","expensive"))

## Cabin, extract Deck Level and unknown
traindata$Cabin <- factor(substr(traindata$Cabin,1,1))

## Embarked replace "" with random port C
traindata$Embarked <- factor(gsub("","C",traindata$Embarked))

## Family Size
traindata$Family <- factor(1 + traindata$SibSp + traindata$Parch)


##Estimates:
y <- traindata$Survived
x <- traindata[c(3,5,6,10:13)]

probabilities <- naiveBayes(x,y)
