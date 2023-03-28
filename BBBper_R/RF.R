library(randomForest)
library(caret)

#Data Factorization
data$BBB <- as.factor(data$BBB)
table(data$BBB)

# Random Forest
set.seed(225)
rf <- randomForest(BBB~., data=training,
                   ntree = 200,
                   mtry = 4,
                   importance = TRUE,
                   proximity = TRUE)
print(rf)

# Prediction & Confusion Matrix - train data
p1 <- predict(rf, training)
confusionMatrix(p1, training$BBB)

# Prediction & Confusion Matrix - test data
p3 <- predict(rf, pd_bbbper)
confusionMatrix(p2, testing$BBB)

an <- predict(rf, ann)
View(an)
write.csv()
write.csv(an, "annu.csv")

View(training)

# Error rate of Random Forest
plot(rf)

# Tune mtry
mtry <- tuneRF(data[-7],data$BBB, ntreeTry=500,
               stepFactor=1.5,improve=0.01, trace=TRUE, plot=TRUE)
best.m <- mtry[mtry[, 2] == min(mtry[, 2]), 1]
print(mtry)
print(best.m)

# No. of nodes for the trees
hist(treesize(rf),
     main = "No. of Nodes for the Trees",
     col = "green")

# Variable Importance
varImpPlot(rf,
           sort = T,
           n.var = 10,
           main = "Top 10 - Variable Importance")
importance(rf)
varUsed(rf)

# Partial Dependence Plot
partialPlot(rf, training, Torsons, "1")

# Extract Single Tree
getTree(rf, 1, labelVar = TRUE)

# Multi-dimensional Scaling Plot of Proximity Matrix
MDSplot(rf, training$BBB)
train_x <- training$BBB
test_x <-testing$BBB
