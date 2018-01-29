getwd()
setwd("G:/UDEMY/SDS/R Advanced")

#Basic input : fin <- read.csv("Future-500.csv")

fin <- read.csv("Future-500.csv", na.strings = c(""))
fin

head(fin, 20)
tail(fin, 10)

str(fin)
summary(fin)

#changing from non-factor to factor:

fin$ID <- factor(fin$ID)
summary(fin)
str(fin)

fin$Inception <- factor(fin$Inception)
summary(fin)
str(fin)

#Factor Variable Trap(FVT)
#converting into Numerics For Characters:
a <- c("12", "13", "14", "12", "12")
a
typeof(a)

b <- as.numeric(a)
b
typeof(b)

#converting into Numerics For Characters:
z <- factor(c("12", "13", "14", "12", "12"))
z
typeof(z)
y <- as.numeric(z)
y

typeof(y)
#-------  Correct way

x<-as.numeric(as.character(z))
x
typeof(x)

#FVT Example

head(fin)
str(fin)

#fin$Profit <- factor(fin$Profit) #Dangerous

head(fin)
str(fin)

summary(fin)

#fin$Profit <- as.numeric(fin$Profit)  #Dangerous
str(fin)
head(fin)

#sub() and gsub()
?sub

fin$Expenses <- gsub(" Dollars", "", fin$Expenses)
fin$Expenses <- gsub(",", "", fin$Expenses)
head(fin)

str(fin)


fin$Revenue <- gsub("\\$", "", fin$Revenue)
fin$Revenue <- gsub(",", "", fin$Revenue)
head(fin)
str(fin)


fin$Growth <- gsub("%", "", fin$Growth)
head(fin)
str(fin)


fin$Expenses <- as.numeric(fin$Expenses)
fin$Revenue <- as.numeric(fin$Revenue)
fin$Growth <- as.numeric(fin$Growth)
str(fin)
summary(fin)


#What is an NA?

?NA

getwd()

fin


#Locate Missing Data
#Updated import to: fin <- read.csv("Future-500.csv", na.strings=c(""))
head(fin,24)
complete.cases(fin)
fin[!complete.cases(fin),]
str(fin)


#Filtering: using which() for non-missing data

head(fin)
fin[fin$Revenue == 9746272,]
which(fin$Revenue == 9746272)
?which
fin[which(fin$Revenue == 9746272),]

head(fin)
fin[fin$Employees==45,]
fin[which(fin$Employees==45),]

#Filtering: using is.na() for missing data
head(fin, 24)

fin$Expenses == NA 
fin [fin$Expenses == NA,]

is.na()

a <- c(1,24,543,NA,76,45,NA)
is.na(a)

is.na(fin$Expenses)
fin[is.na(fin$Expenses), ]

fin[is.na(fin$Industry), ]

#Removing records with missing data

fin_backup <- fin


fin[!complete.cases(fin),]
fin[is.na(fin$Industry),]
fin[!is.na(fin$Industry),] #opposite

fin <- fin[!is.na(fin$Industry),]

fin
fin[!complete.cases(fin),]


#Resetting the dataframe index
fin
rownames(fin) <- 1:nrow(fin)
fin

fin
rownames(fin) <- NULL
fin

#Replacing Missing Data: Factual Analysis
fin[!complete.cases(fin),]

fin[is.na(fin$State),]

fin[is.na(fin$State) & fin$City == "New York",]
fin[is.na(fin$State) & fin$City == "New York","State"] <- "NY"

#check:
fin[c(11,377),]

fin[!complete.cases(fin),]

fin[is.na(fin$State),]

fin[is.na(fin$State) & fin$City == "San Francisco","State"] <- "CA"

#check:
fin[c(82,265),]

fin[!complete.cases(fin),]

#Replacing Missing Data: Median Imputation Method (Part 1)
fin[!complete.cases(fin),]

med_emp_retail <- median(fin[fin$Industry == "Retail", "Employees"],na.rm = TRUE)
med_emp_retail

fin[is.na(fin$Employees) & fin$Industry == "Retail",]
fin[is.na(fin$Employees) & fin$Industry == "Retail", "Employees"] <- med_emp_retail


# Check:
fin[3,]

med_emp_finserv <- median(fin[fin$Industry == "Financial Services", "Employees"], na.rm = TRUE)
med_emp_finserv

fin[is.na(fin$Employees) & fin$Industry == "Financial Services",]
fin[is.na(fin$Employees) & fin$Industry == "Financial Services", "Employees"] <- med_emp_finserv

#Check:
fin[330,]



#Replacing Missing Data: Median Imputation Method (Part 2)

fin[!complete.cases(fin),]
med_growth_constr <- median(fin[fin$Industry == "Construction", "Growth"], na.rm = TRUE)
med_growth_constr

fin[is.na(fin$Growth) & fin$Industry == "Construction",]
fin[is.na(fin$Growth) & fin$Industry == "Construction", "Growth"] <- med_growth_constr

fin[8,]

fin[!complete.cases(fin),]

#Mini-exercise
#Revenue:

med_revenue_constr  <- median(fin[fin$Industry == "Construction", "Revenue"], na.rm = TRUE)
med_revenue_constr

fin[is.na(fin$Revenue) & fin$Industry == "Construction",]
fin[is.na(fin$Revenue) & fin$Industry == "Construction", "Revenue"] <- med_revenue_constr
fin[8,]
fin[42,]

fin[!complete.cases(fin),]

#Expenses:

med_expense_constr  <- median(fin[fin$Industry == "Construction", "Expenses"], na.rm = TRUE)
med_expense_constr

fin[is.na(fin$Expenses) & fin$Industry == "Construction" & is.na(fin$Profit),]
fin[is.na(fin$Expenses) & fin$Industry == "Construction" & is.na(fin$Profit), "Expenses"] <- med_expense_constr
fin[8,]
fin[42,]

fin[!complete.cases(fin),]

# Replacing missing value using Deriving value method:
# Revenue - Expenses = Profit
# Expenses = Revenue - Profit
fin[is.na(fin$Profit), "Profit"] <- fin[is.na(fin$Profit), "Revenue"] - fin[is.na(fin$Profit), "Expenses"]
fin[is.na(fin$Expenses), "Expenses"] <- fin[is.na(fin$Expenses), "Revenue"] - fin[is.na(fin$Expenses), "Profit"]

fin[!complete.cases(fin),]
fin[8,]
fin[c(8,42),]

fin[15,]

#visualization:
library(ggplot2)
#A scatterplot classified by industry showing revenue, expenses, profit
p <- ggplot(data = fin)
p
p + geom_point(aes(x=Revenue, y= Expenses,
                   colour= Industry, size=Profit))


#A scatterplot that includes industry trends for the expenses~revenue relationship
p + geom_point(aes(x=Revenue, y=Expenses,
                   colour=Industry))+
  geom_smooth(aes(x=Revenue, y=Expenses,
                  colour=Industry))

#2
d <- ggplot(data = fin,aes(x=Revenue, y=Expenses,
                           colour=Industry))
d + geom_point()+
  geom_smooth(fill=NA, size=1.2)


#BoxPlots showing growth by industry
f <- ggplot(data = fin, aes(x=Industry, y=Growth,
                            colour=Industry))
f + geom_boxplot(size=1)

f + geom_jitter() +
  geom_boxplot(size=1, alpha=0.5, outlier.color = NA)
 





















