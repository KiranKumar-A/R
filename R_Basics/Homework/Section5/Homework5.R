#load data
getwd()
setwd("G://UDEMY//R//Homework//Section5")

data  <- read.csv("Section5-Homework-Data.csv")
data


head(data)
tail(data)

str(data)

### Insight into next section
data$Year
temp <- factor(data$Year)
temp
levels(temp)


# Fill tha data frame
data$Year == 1960
data1960  <- data[data$Year == 1960,]

data2013 <- data[data$Year == 2013,]

#check row counts
nrow(data1960)   #187
nrow(data2013)   #187.   Equal Split

#Create the addition dataframes

add1960  <- data.frame(Code=Country_Code, Life.Exp=Life_Expectancy_At_Birth_1960)
add2013 <- data.frame(Code=Country_Code, Life_Exp=Life_Expectancy_At_Birth_2013)

# Check Summary
summary(add1960)
summary(add2013)

#merge the pairs of dataframes

merged1960  <-  merge(data1960, add1960, by.x ="Country.Code", by.y ="Code")
merged2013  <-  merge(data2013, add2013, by.x ="Country.Code", by.y ="Code")

#Check the new structure
str(merged1960)
str(merged2013)

#delte columns

merged1960$Year  <- NULL
merged2013$Year  <- NULL

#Visualisation Time
library(ggplot2)

#visualize the 1960 dataset
qplot(data= merged1960, x= Fertility.Rate, y= Life.Exp,
      colour =Region, size=I(5), alpha=I(0.6),
      main="LifeExpectancy vs Fertility (1960)")

qplot(data= merged2013, x= Fertility.Rate, y= Life.Exp,
      colour =Region, size=I(5), alpha=I(0.6),
      main="LifeExpectancy vs Fertility (2013)")







