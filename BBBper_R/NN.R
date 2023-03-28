library(neuralnet)

# Data
str(data)

# Neural Networks
set.seed(333)
n <- neuralnet(BBB~.,
               data = training,
               hidden = c(8,5,3,1),
               err.fct = "ce",
               linear.output = FALSE,
               lifesign = 'full',
               rep = 5,
               algorithm = "rprop+",
               stepmax = 100000)
plot(n, rep = 3)

# Confusion Matrix & Misclassification Error - training data
output <- compute(n, training[,-11], rep = 3)
p1 <- output$net.result
pred1 <- ifelse(p1>0.5, 1, 0)
tab1 <- table(pred1, training$BBB)
tab1
1-sum(diag(tab1))/sum(tab1)

# Confusion Matrix & Misclassification Error - testing data
output <- compute(n, testing[,-11], rep = 3)
p2 <- output$net.result
confusionMatrix(table(p2, testing$BBB))
pred2 <- ifelse(p2>0.5, 1, 0)
tab2 <- table(pred2, testing$BBB)
tab2
1-sum(diag(tab2))/sum(tab2)
