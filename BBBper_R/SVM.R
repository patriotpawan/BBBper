library('caret')
library('e1071')

#Data
summary(data)

set.seed(155)

#Factorizarion of Binary dataset
training[["BBB"]]=factor(training[["BBB"]])

#Support Vector Machine
trctrl <- trainControl(method="repeatedcv", number=10, repeats=3)
model <- train(BBB~., data = training, method="svmLinear",
             trControl=trctrl, preProcess="center", tuneLength=10)
model

#Data Testing
test_pred<-predict(model, newdata=testing)
test_pred

#COnfusion matrix
confusionMatrix(table(test_pred, testing$BBB))

#Grid extension
grid<-expand.grid(C=c(0,0.01,0.05, 0.1, 0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2, 5, 6, 7, 8, 9, 10))

#Model training using grid values
model_grid<-train(BBB~., data = training, method="svmLinear",
                  trControl=trctrl, preProcess=c("center"),
                  tuneGrid=grid, tuneLength=10)
model_grid
plot(model_grid)

#Model testing using grid value
test_pred_grid<-predict(model_grid, newdata = testing)
test_pred_grid

confusionMatrix(table(test_pred_grid, testing$BBB))
