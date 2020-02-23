## Packages Upload
rm(list=ls())         # to clean the memeory
setwd("/home/falco.bargaglistoffi/Desktop/R_files/zombie_hunting/Working_Data/")
memory.limit(size=10000000)
options(java.parameters = "-Xmx15000m")
library(rJava)
library(bartMachine)
library(haven)
library(plyr)
library(dplyr)
library(PRROC)
library(rpart)
library(party)
library(caret)
library(devtools)
library(SuperLearner)
library(Metrics)
library(pROC)
library(Hmisc)

 
f1_score <- function(predicted, expected, positive.class) {
  cm = as.matrix(table(expected, predicted))
  
  precision <- diag(cm) / colSums(cm)
  recall <- diag(cm) / rowSums(cm)
  f1 <-  ifelse(precision + recall == 0, 0, 2 * precision * recall / (precision + recall))
  f1 <- f1[positive.class]
  
  #Assuming that F1 is zero when it's not possible compute it
  f1[is.na(f1)] <- 0
  
  return(f1)
}


balanced_accuracy <- function(c.matrix) {
  sum(diag(c.matrix))/sum(c.matrix);  # "overall" proportion correct  
  first.row <- c.matrix[1,1] / (c.matrix[1,1] + c.matrix[1,2])  
  second.row <- c.matrix[2,2] / (c.matrix[2,1] + c.matrix[2,2])  
  acc <- (first.row + second.row)/2 # "balanced" proportion correct  
  return(acc)
}

  

## Data Upload

data <- read_dta("analysis_data_indicators.dta")
  


names(data)[names(data) == 'GUO___BvD_ID_number'] <- 'guo'
data$control <- ifelse(data$guo=="", 0, 1)
data$nace <- as.factor(data$nace)
data$area <- as.factor(data$area)
levels(data$nace) <- floor(as.numeric(levels(data$nace))/100) # nace from 4 to 2 digits
data_italy <- data[which(data$iso=="IT"),] # get just Italian data
  


lagged_variables <- c("failure", "iso", "control", "nace", "shareholders_funds", "added_value", "cash_flow", "ebitda", "fin_rev", "liquidity_ratio", "total_assets", "depr", "long_term_debt", "employees", "materials", "loans", "wage_bill", "tfp_acf", "fixed_assets", "tax", "current_liabilities", "current_assets", "fin_expenses", "int_paid", "solvency_ratio", "net_income", "revenue", "consdummy", "capital_intensity", "fin_cons100", "inv", "ICR_failure", "interest_diff", "NEG_VA", "real_SA", "Z_score", "misallocated_fixed", "profitability", "area", "dummy_patents", "dummy_trademark", "financial_sustainability", "liquidity_return", "int_fixed_assets")
data_lagged <- data_italy[lagged_variables]
  


predictors <- c("control", "nace", "shareholders_funds", "added_value", "cash_flow", "ebitda", "fin_rev", "liquidity_ratio", "total_assets", "depr", "long_term_debt", "employees", "materials", "loans", "wage_bill", "tfp_acf", "fixed_assets", "tax", "current_liabilities", "current_assets", "fin_expenses", "int_paid", "solvency_ratio", "net_income", "revenue", "consdummy", "capital_intensity", "fin_cons100", "inv", "ICR_failure", "interest_diff", "NEG_VA", "real_SA", "misallocated_fixed", "profitability", "area", "dummy_patents", "dummy_trademark", "financial_sustainability", "liquidity_return", "int_fixed_assets")
formula <- as.formula(paste("as.factor(failure) ~", paste(predictors, collapse="+")))
  



omitted <- na.omit(data_lagged)
set.seed(2020)
index <- sample(seq_len(nrow(omitted)), size = nrow(omitted)*0.9) 
train <- omitted[index,]
test <- omitted[-index,]
  



# Machine Learning Analysis

## Logit

 
system.time({
  logit <- glm(formula, data= train,  na.action = "na.omit", family=binomial(link='logit'))
})
  

 
fitted.prob.logit <- predict(logit, newdata=test, type='response')
  

 
#Roc
fitted.logit <- as.numeric(fitted.prob.logit)
fg.logit <- fitted.logit[test$failure==1]
bg.logit <- fitted.logit[test$failure==0]
  

 
roc_logit <- roc.curve(scores.class0 = fg.logit, scores.class1 = bg.logit, curve = T)
plot(roc_logit)
  

 
pr_logit <- pr.curve(scores.class0 = fg.logit, scores.class1 = bg.logit, curve = T)
plot(pr_logit) 
  

 
fitted.logit <- ifelse(fitted.prob.logit>0.5,1,0)
f1_logit <- f1_score(fitted.logit, test$failure, positive.class="1")
  

 
balanced_accuracy_logit <- balanced_accuracy(as.matrix(table(fitted.logit, test$failure)))
accuracy_logit <- as.data.frame(rbind(postResample(fitted.logit, test$failure)))
  

 
logit_fit <- as.data.frame(cbind(roc_logit$auc, pr_logit$auc.integral, f1_logit, balanced_accuracy_logit, accuracy_logit$Rsquared))
colnames(logit_fit) <- c("AUC", "PR", "f1-score", "BACC", "Rsquared")
logit_fit
  

## Classification Tree

 
set.seed(2020)
system.time({
  c.tree <- ctree(formula, data=train, control = ctree_control(testtype = "MonteCarlo",
                                                               mincriterion = 0.90, nresample = 1000))
})
  

 
fitted.results.tree <- as.matrix(unlist(predict(c.tree, newdata = test, type='prob')))
fitted.prob.tree <-  fitted.results.tree[seq_along(fitted.results.tree) %%2 == 0]
  

 
#Roc
fg.tree<-fitted.prob.tree[test$failure==1]
bg.tree<-fitted.prob.tree[test$failure==0]
  

 
roc_ctree <- roc.curve(scores.class0 = fg.tree, scores.class1 = bg.tree, curve = T)
plot(roc_ctree) 
  

 
pr_ctree <- pr.curve(scores.class0 = fg.tree, scores.class1 = bg.tree, curve = T)
plot(pr_ctree) 
  

 
fitted.ctree <- predict(c.tree, newdata = test, type='response')
f1_ctree <- f1_score(fitted.ctree, test$failure, positive.class="1")
  

 
balanced_accuracy_ctree <- balanced_accuracy(as.matrix(table(fitted.ctree, test$failure)))
accuracy_ctree <- as.data.frame(rbind(postResample(as.double(fitted.ctree), test$failure)))
  

 
ctree_fit <- as.data.frame(cbind(roc_ctree$auc, pr_ctree$auc.integral, f1_ctree, balanced_accuracy_ctree, accuracy_ctree$Rsquared))
colnames(ctree_fit) <- c("AUC", "PR", "f1-score", "BACC", "Rsquared")
ctree_fit
  

## Random Forest

 
set.seed(2020)

system.time({
  rf <- randomForest(formula, data=train, importance = FALSE, ntree=200)
})
  

 
# Fitted results Random Forest
fitted.prob.rf <- predict(rf,newdata=test, type='prob') 
fitted.prob.rf <- fitted.prob.rf[,2]
  

 
#Roc
fg.rf<-fitted.prob.rf[test$failure==1]
bg.rf<-fitted.prob.rf[test$failure==0]
  

 
roc_rf <- roc.curve(scores.class0 = fg.rf, scores.class1 = bg.rf, curve = T)
plot(roc_rf)
  

 
pr_rf<-pr.curve(scores.class0 = fg.rf, scores.class1 = bg.rf, curve = T)
plot(pr_rf)
  

 
fitted.rf <- ifelse(fitted.prob.rf > 0.5, 1, 0)
f1_rf <- f1_score(fitted.rf, test$failure, positive.class="1")
  

 
balanced_accuracy_rf <- balanced_accuracy(as.matrix(table(fitted.rf, test$failure)))
accuracy_rf <- as.data.frame(rbind(postResample(as.double(fitted.rf), test$failure)))
  

 
rf_fit <- as.data.frame(cbind(roc_rf$auc, pr_rf$auc.integral, f1_rf, balanced_accuracy_rf, accuracy_rf$Rsquared))
colnames(rf_fit) <- c("AUC", "PR", "f1-score", "BACC", "Rsquared")
rf_fit
  

## Super Learner

 
SL.library <- c("SL.glm",  "SL.randomForest", "SL.rpartPrune") 
  

train$X <-(train[predictors])
set.seed(123)
system.time({
  SL <- SuperLearner(Y=train$failure, X=train$X,
                     SL.library = SL.library,
                     verbose = FALSE,
                     method = "method.NNLS",
                     family = binomial())
})
coef(SL)
  

 
test$X <-(test[predictors])
sl.fitted <- predict.SuperLearner(SL, test$X, X = train$X, Y = train$failure, onlySL = TRUE)
  

 
#Roc
fg.sl<-sl.fitted$pred[test$failure==1] 
bg.sl<-sl.fitted$pred[test$failure==0]
  

 
roc_sl<-roc.curve(scores.class0 = fg.sl, scores.class1 = bg.sl, curve = T)
plot(roc_sl) 
  

 
pr_sl<-pr.curve(scores.class0 = fg.sl, scores.class1 = bg.sl, curve = T)
plot(pr_sl)
  

 
fitted.sl <- ifelse(sl.fitted$pred > 0.5, 1, 0)
f1_sl <- f1_score(fitted.sl, test$failure, positive.class="1")
  

 
balanced_accuracy_sl <- balanced_accuracy(as.matrix(table(fitted.sl, test$failure)))
accuracy_sl <- as.data.frame(rbind(postResample(as.double(fitted.sl), test$failure)))
  

 
sl_fit <- as.data.frame(cbind(roc_sl$auc, pr_sl$auc.integral, f1_sl, balanced_accuracy_sl, accuracy_sl$Rsquared))
colnames(sl_fit) <- c("AUC", "PR", "f1-score", "BACC", "Rsquared")
sl_fit
  

## BART-mia

 
set.seed(2020)
sample <- sample(seq_len(nrow(data_italy)), size = nrow(omitted), replace=FALSE) 
data_italy_bart <- data_italy[sample,]
  

 
set.seed(2020)
train_sample <- sample(seq_len(nrow(data_italy_bart)), size = nrow(data_italy_bart )*0.9, replace=FALSE) 
train_bart <- data_italy_bart[train_sample,]
test_bart <- data_italy_bart[-train_sample,]
train_bart$X <- as.data.frame(train_bart[predictors])
test_bart$X <- as.data.frame(test_bart[predictors])
  

system.time({
  bart_machine<-bartMachine(train_bart$X, as.factor(train_bart$failure), use_missing_data=TRUE) 
})
  

 
fitted.results.bart <- 1- round(predict(bart_machine, test_bart$X,  type='prob'), 6)
  

 
#Roc
fg.bart<-fitted.results.bart[test_bart$failure==1] 
bg.bart<-fitted.results.bart[test_bart$failure==0]
  


roc_bart<-roc.curve(scores.class0 = fg.bart, scores.class1 = bg.bart, curve = T)
pdf("roc_bart.pdf") 
plot(roc_bart)
dev.off() 



pr_bart<-pr.curve(scores.class0 = fg.bart, scores.class1 = bg.bart, curve = T)
pdf("pr_bart.pdf") 
plot(pr_bart)
dev.off()   

 
#Get Accurancy
fitted.bart <- ifelse(fitted.results.bart> 0.5, 1, 0)
f1_bart <- f1_score(fitted.bart, test_bart$failure, positive.class="1")
  

 
balanced_accuracy_bart <- balanced_accuracy(as.matrix(table(fitted.bart, test_bart$failure)))
accuracy_bart <- as.data.frame(rbind(postResample(as.double(fitted.bart), test_bart$failure)))
  

 
bart_fit <- as.data.frame(cbind(roc_bart$auc, pr_bart$auc.integral, f1_bart, balanced_accuracy_bart, accuracy_bart$Rsquared))
colnames(bart_fit) <- c("AUC", "PR", "f1-score", "BACC", "Rsquared")
bart_fit
  

## Save Results

 
model_results <- rbind(logit_fit, ctree_fit, rf_fit, sl_fit, bart_fit)
write.csv(model_results, file = "model_results.csv")
  

# Model Comparison

 

  

 

  