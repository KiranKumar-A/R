# R-Specific programming loop
x <- rnorm(5)
x
for(i in x){
  print(i)
}

print(x[1])
print(x[2])
print(x[3])
print(x[4])
print(x[5])


# Conventional programming loop
for (j in 1:5){
print(x[j])
}


N <- 1000000
a <- rnorm(N)
b <- rnorm(N)


#vectorised approach

c <- a * b

#De-vectorised approach
d <- rep(NA,N)
for(i in 1:N){
  d[i] <- a[i] *b[i]
}




