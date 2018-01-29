#import the data
getwd()
setwd('G://UDEMY//R//Homework//Section6')
getwd()


mov <-read.csv("Section6-Homework-Data.csv")

#data exploration
head(mov)
summary(mov)
str(mov)


#activate ggplot2
#install.packages("ggplot2")
library(ggplot2)


#cool insight
ggplot(data = mov, aes(x=Day.of.Week)) + geom_bar()

#filter #1 for the data frame
filt <-(mov$Genre == "action")|(mov$Genre == "adventure")|(mov$Genre == "animation")|(mov$Genre == "comedy")|(mov$Genre == "drama")
mov2 <- mov[filt,]
mov2


#filter #2
filt2 <- mov$Studio %in% c("Buena Vista Studios", "WB", "FOX", "Universal", "Sony", "Paramount Pictures")
filt
filt2
mov2 <- mov[filt&filt2,]
mov2


#prepare the plot's data and aes layers:
p <- ggplot(data = mov2,  aes(x=Genre, y=Gross...US))
p

#add geometries
p + geom_point()
q <- p + geom_jitter(aes(size=Budget...mill., colour=Studio)) +
  geom_boxplot(alpha=0.7, outlier.colour = NA) 
q

#non-data ink
q<- q +
  xlab("Genre") +
  ylab("Gross % US") + 
  ggtitle("Domestic Gross % by Genre")
  
q
  
#Theme
q <- q +
  theme(
    axis.title.x = element_text(colour = "Blue", size = 30),
    axis.title.y = element_text(colour = "Blue", size = 30),
    axis.text.x = element_text(size = 20),
    axis.text.y = element_text(size = 20),
    
    plot.title = element_text(size = 40),
    
    legend.title = element_text(size = 20),
    legend.text = element_text(size = 20),
    
    text = element_text(family="Comic Sans MS")
    
  )
  
q


#final Touch

q$labels$size <- "Budget $M"

q




