myplot <- function(z,who=1:10){
  matplot(t(z[who,,drop=F]), type="b", pch=15:18, col=c(1:4,6), main="baketball Player Analysis" )
  legend("bottomleft", inset =0.01, legend=Players[who],col=c(1:4,6), pch=15:18, horiz = F)
}


myplot(FreeThrows)
myplot(FreeThrowAttempts)

#. Free Throw Attempts/Games

myplot(FreeThrowAttempts/Games)

#. Free Throw Accuracy

myplot(FreeThrows/FreeThrowAttempts)

myplot(FieldGoals/FieldGoalAttempts)

#3. Player style Patterns Excl. Free Throws
myplot((Points -FreeThrows)/FieldGoals)



