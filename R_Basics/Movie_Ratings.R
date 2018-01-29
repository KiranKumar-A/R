#-------Factors

getwd()
setwd("G://UDEMY//R//DATA")
getwd()


movies <- read.csv("Movie-Ratings.csv")
head(movies)
colnames(movies) <- c("Film", "Genre", "CriticRating", "AudienceRating", "BudgetMillions", "Year")
head(movies)
tail(movies)
str(movies)
summary(movies)


factor(movies$Year)
movies$Year <- factor(movies$Year)

summary(movies)
str(movies)

#-----------Aesthetics

library(ggplot2)

ggplot(data = movies, aes(x=CriticRating, y=AudienceRating))

#-----------Add Geometry

ggplot(data = movies, aes(x=CriticRating, y=AudienceRating)) +
  geom_point()


#-----------Add Colour

ggplot(data = movies, aes(x=CriticRating, y=AudienceRating, 
                          colour=Genre)) +
  geom_point()

#-----------Add Size

ggplot(data = movies, aes(x=CriticRating, y=AudienceRating, 
                          colour=Genre, size=Genre)) +
  geom_point()

#-----------Add Size --Better way

ggplot(data = movies, aes(x=CriticRating, y=AudienceRating, 
                          colour=Genre, size=BudgetMillions)) +
  geom_point()

#>>>>This  #1 (we will improve It)



p <- ggplot(data = movies, aes(x=CriticRating, y=AudienceRating, 

                                                        colour=Genre, size=BudgetMillions))
#point
p + geom_point()

#lines
p + geom_line()


#multiple Layers

p + geom_point() + geom_line()

p + geom_line() + geom_point()




###------------ Overriding Aesthetics


q  <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                              colour=Genre,size=BudgetMillions))

#add geom layer
q + geom_point()

#overriding aesthetics
#ex1
q + geom_point(aes(size=CriticRating))

#ex2
q + geom_point(aes(colour=BudgetMillions))

#q remains the same
q+geom_point()

#ex3
q+geom_point(aes(x=BudgetMillions)) +
  xlab("Budget Millions $$$")


#Ex4
p + geom_line() + geom_point()

#reduce line size

p + geom_line(size=1) + geom_point()


#------------ mapping vs setting

r <- ggplot(data = movies, aes(x=CriticRating, y=AudienceRating))
r + geom_point()

#Add colour
#1. Mapping (What we've done so far)

r + geom_point(aes(colour=Genre))

#2. Setting:
r + geom_point(colour="DarkGreen")

#Error:
#r + geom_point(aes(colour= "DarkGreen"))

#1. Mapping
r + geom_point(aes(size=BudgetMillions))

#2. Setting
r + geom_point(size=10)

#Error:
#r + geom_point(aes(size=10))


#-----------Histograms and Density Charts

s  <- ggplot(data = movies, aes(x=BudgetMillions))
s + geom_histogram(binwidth = 10)

#add colour
s + geom_histogram(binwidth = 10, aes(fill=Genre))

#add a border
s + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black")
#>>>>chart3 (We willl improcve)

#Some times we need density Charts:

s + geom_density(aes(fill=Genre))

s + geom_density(aes(fill=Genre), position = "stack")

#-----------------Starting layer tips

t <- ggplot(data = movies, aes(x=AudienceRating))
t + geom_histogram(binwidth = 10, fill="white", colour="Blue")

#-----another way
t <- ggplot(data=movies)
t + geom_histogram(binwidth = 10, 
                   aes(x=AudienceRating), 
                   fill ="white",colour="Blue")


#>>> 4
t + geom_histogram(binwidth = 10, 
                   aes(x=CriticRating), 
                   fill ="white",colour="Blue")


#>>>>5
t <- ggplot()

#--------statistical Transformations

?geom_smooth


u <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,
                             colour=Genre))
u + geom_point() + geom_smooth(fill = NA)


#---boxplots


u <- ggplot(data=movies, aes(x=Genre, y=AudienceRating,
                             colour=Genre))
u + geom_boxplot()
u + geom_boxplot(size=1.2)
u + geom_boxplot(size=1.2) + geom_point()

#tip/hack:
u + geom_boxplot(size=1.2) + geom_jitter()

#another way:
u + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5)
#>>> Chart 6

#--------------using facets

v <- ggplot(data = movies, aes(x=BudgetMillions))
v + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black")

#facets
v + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black") +
  facet_grid(Genre~., scales = "free")


#scattrplots:

w <- ggplot(data = movies, aes(x=CriticRating, y = AudienceRating,
                               colour = Genre))
w + geom_point(size=3)

#facets
w + geom_point(size=3)+
  facet_grid(Genre~.)

w + geom_point(size=3) +
  facet_grid(.~Year)

w + geom_point(size=3)+
  facet_grid(Genre~Year)

w + geom_point(size=3)+
  geom_smooth() +
  facet_grid(Genre~Year)

w + geom_point(aes(size=BudgetMillions))+
  geom_smooth() +
  facet_grid(Genre~Year)

#1  (Improve can be done)

#-------- Coordinates

#limits and Zoom

m <- ggplot(data = movies, aes(x=CriticRating, y=AudienceRating,
                               size=BudgetMillions,
                               colour=Genre))

m + geom_point()

m + geom_point() +
  xlim(50,100) +
  ylim(50,100)

#wont work well always

n <- ggplot(data=movies, aes(x=BudgetMillions))
n + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black") +
  ylim(0,50)

#instead -zoom:
n + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black") +
  coord_cartesian(ylim = c(0,50))

#Improve No.1
w + geom_point(aes(size=BudgetMillions))+
  geom_smooth() +
  facet_grid(Genre~Year) + 
  coord_cartesian(ylim = c(0,100))


#------Thenme
o  <- ggplot(data = movies, aes(x=BudgetMillions))
h <- o + geom_histogram(binwidth = 10, aes(fill = Genre), colour="Black")
h
### Add labels

h + xlab("Money Axis") + ylab("Number of movies")

# Label Formatting
h + 
  xlab("Money Axis") + 
  ylab("Number of movies") +
  theme(axis.title.x = element_text(colour="DarkGreen", size = 30),
        axis.title.y = element_text(colour="Red", size=30))


# Tick Mark Formatting
h + 
  xlab("Money Axis") + 
  ylab("Number of movies") +
  theme(axis.title.x = element_text(colour="DarkGreen", size = 30),
        axis.title.y = element_text(colour="Red", size=30),
        axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 10))

?theme


# Legend Formatting
h + 
  xlab("Money Axis") + 
  ylab("Number of movies") +
  theme(axis.title.x = element_text(colour="DarkGreen", size = 30),
        axis.title.y = element_text(colour="Red", size=30),
        axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 10),
        
        legend.title = element_text(size = 30),
        legend.text = element_text(size = 20),
        legend.position = c(1,1),
        legend.justification = c(1,1))

# TitleFormatting
h + 
  xlab("Money Axis") + 
  ylab("Number of movies") +
  ggtitle("Movie Budget Distribution")+
  theme(axis.title.x = element_text(colour="DarkGreen", size = 30),
        axis.title.y = element_text(colour="Red", size=30),
        axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 10),
        
        legend.title = element_text(size = 30),
        legend.text = element_text(size = 20),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        
        
        plot.title = element_text(colour="DarkBlue",
                                 size=40, family = "Arial" ))

?font_family
