matplot(FieldGoalAttempts,FieldGoals)
?matplot
FieldGoals

t(FieldGoals)

matplot(t(FieldGoals), type="b", pch=15:18, col=c(1:4,6))
legend("bottomleft", inset =0.0001, legend=Players,col=c(1:4,6), pch=15:18, horiz = F)



matplot(t(FieldGoals/FieldGoalAttempts), type="b", pch=15:18, col=c(1:4,6))
legend("bottomleft", inset =0.0001, legend=Players,col=c(1:4,6), pch=15:18, horiz = F)

round(Salary/Points,2)





