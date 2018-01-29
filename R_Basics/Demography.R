?read.csv()


#Method 1: Select The file Manually
stats <- read.csv(file.choose())
stats


#Method2: Set WD and Read data 
getwd()

#Windows
setwd("G:\\UDEMY\\R\\DATA")

getwd()

rm(stats)

stats <- read.csv("DemographicData.csv")
stats



#--------------------------------------Exploring
stats


nrow(stats)
#Imported 195 rows
ncol(stats)
#IMported 5 columns

head(stats, n=10)

tail(stats, n = 8)



str(stats)  #structure -> str()   runif() random variable uniformly distributed

summary(stats)



#----Using the $ sign
stats
head(stats)
stats[3,3]

stats[3, "Birth.rate"]

stats$Internet.users

stats$Internet.users[2]



levels(stats$Income.Group)

levels(stats$Country.Name)



#-----------Bsic Operations with a DataFrame

stats[1:10,] #subsetting

#Remember how the [] works

stats[1,]

is.data.frame(stats[1,]) # no need for drop=F

stats [,1]

is.data.frame(stats[,1, drop=F])  #need drop=F

#multiply columns


stats$Birth.rate*stats$Internet.users
stats$Birth.rate+stats$Internet.users


#add column
head(stats)
stats$MyCalc <- stats$Birth.rate*stats$Internet.users


# test of knowledge

stats$xyz  <- 1:5
head(stats, n=12)


#remove column

head(stats)
stats$MyCalc <- NULL
stats$xyz   <- NULL

head(stats)

#-------------Filtering Data Frames

head(stats)
filter <- stats$Internet.users < 2
stats[1:100,]
stats[filter,]

stats[stats$Internet.users>40,]
stats[stats$Birth.rate>40,]

stats[stats$Birth.rate>40 & stats$Internet.users<2,]

stats[stats$Income.Group == "High income",]
levels(stats$Income.Group)
stats[stats$Country.Name == "Malta",]



#-------------introduction to qplot
?qplot
library(ggplot2)
?qplot

qplot(data=stats,x=Internet.users)
qplot(data=stats, x=Income.Group, y= Birth.rate)

qplot(data=stats, x=Income.Group, y= Birth.rate, size=I(3))


qplot(data=stats, x=Income.Group, y= Birth.rate, size=I(3),
      colour=I("blue"))

qplot(data=stats, x=Income.Group, y= Birth.rate, geom="boxplot")


#--------------Visualizing qplot1

qplot(data=stats, x=Internet.users, y=Birth.rate)

qplot(data=stats, x=Internet.users, y=Birth.rate,
      size=I(4))
qplot(data=stats, x=Internet.users, y=Birth.rate,
      colour=I("red"), size=I(4))

qplot(data=stats, x=Internet.users, y=Birth.rate,
      colour=Income.Group, size=I(4))
 

#--------------creating dataframes
mydf <- data.frame(Countries_2012_Dataset,Codes_2012_Dataset,Regions_2012_Dataset)

head(mydf)
colnames(mydf)  <- c("Country", "Codes", "Region")
head(mydf)
rm(mydf)


mydf <- data.frame(Country=Countries_2012_Dataset,Code=Codes_2012_Dataset,Region=Regions_2012_Dataset)
head(mydf)
tail(mydf)

summary(mydf)

#--------------merging dataframes
head(stats)
head(mydf)


merged  <- merge(stats,mydf,by.x="Country.Code", by.y = "Code")

head(merged)

merged$Country <- NULL
str(merged)

head(merged)
tail(merged)


#--------------Visualizing qplot2
qplot(data = merged,  x=Internet.users, y=Birth.rate,
      colour=Region, size=I(5), shape=I(16))


#-----Transparency

qplot(data = merged,  x=Internet.users, y=Birth.rate,
      colour=Region, size=I(5), shape=I(19),
      alpha=I(0.6))


#----Title

qplot(data = merged,  x=Internet.users, y=Birth.rate,
      colour=Region, size=I(5), shape=I(19),
      alpha=I(0.6),
      main="Birth Rate vs Internet users")







