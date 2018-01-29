getwd()
setwd("G:/UDEMY/SDS/R Advanced")
setwd("./Weather Data")
getwd()
Chicago <- read.csv("Chicago-F.csv", row.names = 1)
Houston <- read.csv("Houston-F.csv", row.names = 1)
NewYork <- read.csv("NewYork-F.csv", row.names = 1)
SanFrancisco <- read.csv("SanFrancisco-F.csv", row.names = 1)
Chicago
Houston
NewYork
SanFrancisco
#These are dataframe
is.data.frame(Chicago)
typeof(Chicago)

#Lets convert to matrices:
Chicago <- as.matrix(Chicago)
Houston <- as.matrix(Houston)
NewYork <- as.matrix(NewYork)
SanFrancisco <- as.matrix(SanFrancisco)

is.matrix(Chicago)

#Lets put all into a list;

Weather <- list(Chicago=Chicago,Houston=Houston,NewYork=NewYork,SanFrancisco=SanFrancisco)
Weather


#Lets try sample
Weather[[3]]
Weather[3]
Weather$Houston

apply()
tapply()


#Using apply
?apply
apply(Chicago, 1, mean)
#Check
mean(Chicago["DaysWithPrecip",])
#analyze onr city
Chicago
apply(Chicago, 1, max)
apply(Chicago, 1, min)
#for Practice:
apply(Chicago, 2, max)
apply(Chicago,2, min)

#Compare:
apply(Chicago, 1, mean)
apply(NewYork, 1, mean)
apply(Houston, 1, mean)
apply(SanFrancisco, 1, mean)
                                  #<<< (nearly) deliv 1: but there is a faster way

#Recreating the apply function with loops (advanced topic)
Chicago
#find the mean of every row:
#1. via loops

output <- NULL #Preparing an empty vector
for(i in 1:5) {#run cycle
  output[i] <- mean(Chicago[i,])
  }
output

names(output) <- rownames(Chicago)
output

#2. via apply function
apply(Chicago, 1, mean)
apply(SanFrancisco, 1, mean)
apply(NewYork, 1, mean)
apply(Houston,1, mean)

#Using lapply
?lapply

Chicago
t(Chicago)
Weather

lapply(Weather,t)  #t(Chicago), t(NewYork), t(Houston), t(SanFrancisco)
mynewlist <- lapply(Weather, t)
mynewlist
#example 2
Chicago
rbind(Chicago, NewRow = 1:12)

lapply(Weather, rbind, NewRow = 1:12)

#example 3
?rowMeans
rowMeans(Chicago) #identical to: apply(chicago, 1, mean)
lapply(Weather, rowMeans)
            #<<< (nearly) deliv 1: even better, but will improve further
#rowMeans
#colMeans
#rowSums
#colSums

lapply(Weather, rowSums)


#Combining lapply with the [] operator
Weather
Weather$Chicago[1,1]
lapply(Weather, "[", 1,1)
Weather
lapply(Weather, "[",1, )
Weather

col3 <- lapply(Weather, "[", , 3)
col3
t(col3)

#Adding your own functions
lapply(Weather, rowMeans)
lapply(Weather, function(x) x[1,] )

lapply(Weather, function(x) x[5,] )
lapply(Weather, function(x) x[,12] )
lapply(Weather, function(z) z[1,]-z[2,])
lapply(Weather, function(z) round((z[1,]-z[2,])/z[2,],2))

                                        #<<Deliv2 : temp fluctuations Will improve

#Using sapply()

Weather
#AvgHigh_F for July:
lapply(Weather, "[", 1, 7)
sapply(Weather, "[", 1, 7)         

#AvgHigh_F for 4th quarter:
lapply(Weather, "[", 1, 10:12)
sapply(Weather, "[", 1, 10:12)

#Another example:
lapply(Weather, rowMeans)
sapply(Weather,rowMeans)
round(sapply(Weather, rowMeans),2) #<<< Deliv 1. Answer!'

#Another example
lapply(Weather, function(z) round((z[1,]-z[2,])/z[2,],2))
sapply(Weather, function(z) round((z[1,]-z[2,])/z[2,],2))   #<<< Deliv 2. Answer!'  

library(ggplot2)

#By the way
sapply(Weather, rowMeans, simplify = F) #same as lapply

#Nesting Apply functions
Weather
lapply(Weather, rowMeans)
Chicago
apply(Chicago, 1, max)
#apply across whole lists:
lapply(Weather, apply, 1, max)#preferred approach
#tidy up
sapply(Weather, apply, 1, max)  #<< deliv 3 
sapply(Weather, apply, 1, min)  #<< deliv 4

#Very advanced tutorial!
#which.max and which.min
?which.max
which.max(Chicago[1,])
names(which.max(Chicago[1,]))

#by the sounds of it:
#we will have: apply - to iterate over rows of the matrix
#and we will have: lapply or sapply - to iterate over components of the list
apply(Chicago, 1, function(x) names(which.max(x)))
lapply(Weather, function(y) apply(y, 1, function(x) names(which.max(x))))
sapply(Weather, function(y) apply(y, 1, function(x) names(which.max(x))))











