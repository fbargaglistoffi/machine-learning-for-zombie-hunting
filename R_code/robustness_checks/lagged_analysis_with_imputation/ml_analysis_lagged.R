#######################################################
#        MACHINE LEARNING for ZOMBIE HUNTING          #
#######################################################

rm(list=ls())
   
setwd("G:\\Il mio Drive\\Research\\Italian Firms\\Zombie Hunting New Data")

memory.limit(size=1000000)
options(java.parameters = "-Xmx15000m")
#options(java.parameters = "-Xmx5g")
library(rJava)
library(bartMachine)
#library(bartMachineJARs)
#library(speedglm)
library(haven)
library(plyr)
library(dplyr)
library(missForest)
library(randomForest)
library(randomForestSRC)
library(survival)
library(pec)
library(PRROC)
library(rms)
library(Hmisc)
library(xtable)
library(rpart)
library(party)
library(reprtree)
library(caret)
library(devtools)
library(SuperLearner)
library(Metrics)
library(biglasso)
library(gam)
library(RCurl)
library(MASS)
library(tmle)
library(ggplot2)
library(gbm)
library(Amelia)
library(PresenceAbsence)
library(pROC)
library(e1071)
library(Hmisc)

#LOAD DATA

dati <- read_dta("data_lagged_10_07.dta")
#dati <- read_dta("data_lagged_26_06.dta")

#OMIITED DATA

myvariables <- c("iso", "tfp_acf",  "Number_of_patents", "Number_of_trademarks", "consdummy", "control", "failure", 
                 "nace_2","fin_rev", "int_paid", "ebitda", "cash_flow", "depr", "revenue", "total_assets", 
                 "long_term_debt", "employees", "added_value", "materials", "wage_bill", "loans" , "int_fixed_assets",
                 "fixed_assets", "current_liabilities",  "liquidity_ratio",  "solvency_ratio", "current_assets",
                 "fin_expenses", "net_income", "fin_cons", "fin_cons100", "inv",  "ICR_t",
                 "time", "real_SA", "shareholders_funds", "NEG_VA", "ICR_failure", "profitability", "misallocated_fixed", 
                  "interest_diff") #"capital_intensity", "labour_product",   retained_earnings, firm_value  excluded: highly missing
dati <- dati[myvariables]

#Patterns of missingness
sapply(dati,function(x) sum(is.na(x)))
sapply(dati, function(x) length(unique(x)))
missmap(dati[1:100,], main = "Missing values vs Observed")

omitted<-na.omit(dati[myvariables]) 

#SPLIT DATA FOR CROSS-VALIDATION
omitted<-as.data.frame(omitted[,1:length(omitted)])
set.seed(123)
train_ind <- sample(seq_len(nrow(omitted)), size = nrow(omitted)*0.9) 

omitted$iso <- as.factor(omitted$iso)
omitted$nace_2 <- as.factor(omitted$nace_2)
omitted$control <- as.factor(omitted$control)

train <- omitted[train_ind,]
test <- omitted[-train_ind,]



################################################################################################
#GLM:logit (on the entire dataset)

#Logit model

system.time({
logit<-glm(failure ~ iso + tfp_acf+ Number_of_patents+ Number_of_trademarks+ consdummy+ control+ 
             nace_2 +fin_rev+ int_paid+ ebitda+ cash_flow+ depr+ revenue+ total_assets+ 
             long_term_debt+ employees+ added_value+ materials+ wage_bill+ loans + int_fixed_assets+
             fixed_assets+ current_liabilities+  liquidity_ratio+  solvency_ratio+ current_assets+
             fin_expenses+ net_income+  fin_cons100 + inv + real_SA+ shareholders_funds + NEG_VA + ICR_failure +
             profitability +  misallocated_fixed + interest_diff, 
             data= train,  na.action = "na.omit", family=binomial(link='logit')) #subset = which(train$iso == "PT"),
}) #+ capital_intensity + labour_product,

summary(logit)

#Accurancy from cv
fitted.results.logit <- predict(logit ,newdata=test,type='response')
postResample(fitted.results.logit, test$failure)
#RMSE   Rsquared        MAE 
#0.15031298 0.03585731 0.04574970 

#Roc
fitted.logit<-as.numeric(fitted.results.logit)
fg<-fitted.logit[test$failure==1]
bg<-fitted.logit[test$failure==0]

roc<-roc.curve(scores.class0 = fg, scores.class1 = bg, curve = T)
plot(roc) #0.7341 (0.9093)

pr<-pr.curve(scores.class0 = fg, scores.class1 = bg, curve = T)
plot(pr) #0.0924 (0.3965)

#For good predictive model the chi and RMSE values should be low 
confusionMatrix(data = fitted.results.logit, reference = test$failure)

################################################################################################
# Classification Tree with rpart

#Grow tree 
set.seed(12455)
system.time({
rpart <- rpart(failure ~  iso + tfp_acf+ Number_of_patents+ Number_of_trademarks+ consdummy+ control+ 
                 nace_2 +fin_rev+ int_paid+ ebitda+ cash_flow+ depr+ revenue+ total_assets+ 
                 long_term_debt+ employees+ added_value+ materials+ wage_bill+ loans + int_fixed_assets+
                 fixed_assets+ current_liabilities+  liquidity_ratio+  solvency_ratio+ current_assets+
                 fin_expenses+ net_income+  fin_cons100 + inv + real_SA+ shareholders_funds + NEG_VA + ICR_failure +
                 profitability +  misallocated_fixed + interest_diff,
                 data=train, method="class", control=rpart.control(minsplit=30, cp=0.001)) #subset = which(train$iso == "IT"),
}) #41 seconds

printcp(rpart) # display the results 
plotcp(rpart) # visualize cross-validation results 
summary(rpart) # detailed summary of splits

#Plot tree 
plot(rpart, uniform=TRUE, main="Classification Tree")
text(rpart, use.n=TRUE, all=TRUE, cex=.8)

#Accurancy from cv
fitted.results.rpart <- predict(rpart, newdata=test,type='prob')
postResample(fitted.results.rpart[,2], test$failure)
#RMSE   Rsquared        MAE 
#0.15133305 0.02462911 0.04607854 

#Roc
fitted.cart<-fitted.results.rpart[,2]
fg.cart<-fitted.cart[test$failure==1]
bg.cart<-fitted.cart[test$failure==0]


roc.cart<-roc.curve(scores.class0 = fg.cart, scores.class1 = bg.cart, curve = T)
plot(roc.cart) #0.7056 (0.8827)

pr.cart<-pr.curve(scores.class0 = fg.cart, scores.class1 = bg.cart, curve = T)
plot(pr.cart) #0.0870 (0.3776)

# prune the tree 
pruned<- prune(rpart, cp=   rpart$cptable[which.min(rpart$cptable[,"xerror"]),"CP"])

# plot the pruned tree 
plot(pruned, uniform=TRUE, main="Pruned Classification Tree")

#Accurancy from cv
fitted.results.pruned <- predict(pruned, newdata=test,type='prob')
length(which(train$failure==1))/length(train$failure) #Exactly the same number of the mean
postResample(fitted.results.pruned[,2], test$failure)

###############################################################################
#Conditional inference tree (PARTY)
#library(partykit)
set.seed(235)
system.time({
fit <- ctree(failure ~ iso + tfp_acf+ Number_of_patents+ Number_of_trademarks+ consdummy+ control+ 
               nace_2 +fin_rev+ int_paid+ ebitda+ cash_flow+ depr+ revenue+ total_assets+ 
               long_term_debt+ employees+ added_value+ materials+ wage_bill+ loans + int_fixed_assets+
               fixed_assets+ current_liabilities+  liquidity_ratio+  solvency_ratio+ current_assets+
               fin_expenses+ net_income+  fin_cons100 + inv + real_SA+ shareholders_funds + NEG_VA + ICR_failure +
               profitability +  misallocated_fixed + interest_diff, #+ capital_intensity + labour_product,
               data=train, control = ctree_control(testtype = "MonteCarlo",
               mincriterion = 0.90, nresample = 1000))
}) # 6 minutes

plot(fit, main="Conditional Inference Tree")
plot(fit, main="Conditional Inference Tree", type="simple",  inner_panel=node_inner(fit, pval = FALSE)
     
     #tp_args = list(fill = c("Light Blue", "lightgray")),
     #ip_args = list(fill = c("cadetblue1"))
)
print(fit)
summary(fit)


#Accurancy from cv
fitted.results.tree <- predict(fit, newdata=test, type='response')
postResample(fitted.results.tree, test$failure)
#      RMSE   Rsquared        MAE 
#0.15028213 0.03684235 0.04567466  

#Roc
fg.tree<-fitted.results.tree[test$failure==1]
bg.tree<-fitted.results.tree[test$failure==0]


roc.tree<-roc.curve(scores.class0 = fg.tree, scores.class1 = bg.tree, curve = T)
plot(roc.tree) #0.7352 (0.9115)

pr.tree<-pr.curve(scores.class0 = fg.tree, scores.class1 = bg.tree, curve = T)
plot(pr.tree) #0.0924 (0.4069)

################################################################################################
#RANDOM FOREST
set.seed(133234)
system.time({
rf <- randomForest(as.factor(train$failure) ~  iso + tfp_acf+ Number_of_patents+ Number_of_trademarks+ consdummy+ control+ 
                     nace_2 +fin_rev+ int_paid+ ebitda+ cash_flow+ depr+ revenue+ total_assets+ 
                     long_term_debt+ employees+ added_value+ materials+ wage_bill+ loans + int_fixed_assets+
                     fixed_assets+ current_liabilities+  liquidity_ratio+  solvency_ratio+ current_assets+
                     fin_expenses+ net_income+  fin_cons100 + inv + real_SA+ shareholders_funds + NEG_VA + ICR_failure +
                     profitability +  misallocated_fixed + interest_diff, #+ capital_intensity + labour_product,
                     data=train, importance=TRUE, ntree=200)
}) #9 minutes
rf
print(rf)
plot(rf)
varImpPlot(rf)
getTree(rf, 2, labelVar=TRUE)
reprtree:::plot.getTree(rf, 34, labelVar=TRUE)

#Fitted results Random Forest
fitted.results.rf <- predict(rf,newdata=test,type='prob') #on the same set prediction (the RF package computes it out of bag)
hist(as.numeric(fitted.results.rf[,2]), breaks = 20)
postResample(as.numeric(fitted.results.rf[,2]), test$failure)
#RMSE   Rsquared        MAE 
#0.15124594 0.03621474 0.04902458 

#Roc
fitted.results.rf<-fitted.results.rf[,2]
fg.rf<-fitted.results.rf[test$failure==1]
bg.rf<-fitted.results.rf[test$failure==0]


roc.rf<-roc.curve(scores.class0 = fg.rf, scores.class1 = bg.rf, curve = T)
plot(roc.rf) #0.7610 (0.9254)

pr.rf<-pr.curve(scores.class0 = fg.rf, scores.class1 = bg.rf, curve = T)
plot(pr.rf) #0.0944 (0.4849)


################################################################################################
#Support Vector Machine
#install.packages('e1071')
library(e1071)
set.seed(124466)

system.time({
svm.model <- svm(as.factor(train$failure) ~  iso + tfp_acf+ Number_of_patents+ Number_of_trademarks+ consdummy+ control+ 
                   nace_2 +fin_rev+ int_paid+ ebitda+ cash_flow+ depr+ revenue+ total_assets+ 
                   long_term_debt+ employees+ added_value+ materials+ wage_bill+ loans + int_fixed_assets+
                   fixed_assets+ current_liabilities+  liquidity_ratio+  solvency_ratio+ current_assets+
                   fin_expenses+ net_income+  fin_cons100 + inv + real_SA+ shareholders_funds + NEG_VA + ICR_failure +
                   profitability +  misallocated_fixed + interest_diff + capital_intensity + labour_product,
                 data = train, cost = 100, gamma = 1, probability = TRUE)
})

svm.fitted.values<- predict(svm.model, newdata = test[,-7])
table(svm.fitted.values, train$failure) #confusion matrix
svm.fitted <- predict(svm.model, newdata = test[,-7],  probability = TRUE) #exclude the column of failure
svm.fitted.prob<-as.data.frame(attr(svm.fitted, "probabilities")[,2])
svm.fitted.prob<-svm.fitted.prob[,1]
hist(svm.fitted.prob)
postResample(svm.fitted.prob, test$failure)
#RMSE    Rsquared         MAE 
#0.152887890 0.002596668 0.048356413 

#Roc
fg.svm<-svm.fitted.prob[test$failure==1]
bg.svm<-svm.fitted.prob[test$failure==0]


roc.svm<-roc.curve(scores.class0 = fg.svm, scores.class1 = bg.svm, curve = T)
plot(roc.svm) #0.5720

pr.svm<-pr.curve(scores.class0 = fg.svm, scores.class1 = bg.svm, curve = T)
plot(pr.svm) #0.453

################################################################################################
#Super-Learner
#Candidate learners
listWrappers()

SL.MYctree<-function (Y, X, newX, family, ...)
  
{
  #.SL.require("party")
  if (family$family == "gaussian") {
    fit.MYctree <- party::ctree(Y ~ ., data = data.frame(Y,
                                                         X), controls = party::ctree_control(testtype = "MonteCarlo",
                                                                                             mincriterion = 0.90, nresample = 1000))
  }
  if (family$family == "binomial") {
    fit.MYctree <- party::ctree(Y ~ ., data = data.frame(Y,
                                                         X), controls = party::ctree_control(testtype = "MonteCarlo",
                                                                                             mincriterion = 0.90, nresample = 1000))
  }
  pred <- predict(object = fit.MYctree, newdata = newX)
  fit <- list(object = fit.MYctree)
  out <- list(pred = pred, fit = fit)
  class(out$fit) <- c("SL.MYctree")
  return(out)
}


SL.library <- c("SL.glm",  "SL.randomForest") 

#Model: SL without cv
predictors <- c("iso", "tfp_acf", "Number_of_patents", "Number_of_trademarks", "consdummy", "control", 
                "nace_2", "fin_rev", "int_paid", "ebitda", "cash_flow", "depr", "revenue", "total_assets", 
                "long_term_debt", "employees", "added_value", "materials", "wage_bill", "loans" , "int_fixed_assets",
                "fixed_assets", "current_liabilities",  "liquidity_ratio",  "solvency_ratio", "current_assets",
                "fin_expenses", "net_income",  "fin_cons100" , "inv" , "real_SA", "shareholders_funds" , "NEG_VA" ,
                "ICR_failure" , "profitability" ,  "misallocated_fixed" , "interest_diff") # , "+ capital_intensity", "labour_product"

train$X <-(train[predictors]) #change accordingly to number of predictors
which(is.na(train$X)==TRUE)

set.seed(123)
system.time({
  # This will take about 10x as long as the not Cross validated SuperLearner.
  SL <- SuperLearner(Y=train$failure, X=train$X, SL.library = SL.library,
                     verbose = FALSE, method = "method.NNLS", family = binomial() )#, id = NULL, control = list(), obsWeights = NULL)
}) # 3 hours and a half on 1 core

SL
summary(SL)
coef(SL)

sl.fitted <- predict.SuperLearner(SL, test, X = train$X, Y = train$failure, onlySL = TRUE)
sl.fitted$pred
postResample(sl.fitted$pred, test$failure)
#      RMSE   Rsquared        MAE 
#0.14985966 0.04341066 0.04783414 

table(SL$Y, test$failure) #confusion matrix

#Roc
fg.sl<-sl.fitted$pred[test$failure==1] 
bg.sl<-sl.fitted$pred[test$failure==0]


roc.sl<-roc.curve(scores.class0 = fg.sl, scores.class1 = bg.sl, curve = T)
plot(roc.sl) #0.7776

pr.sl<-pr.curve(scores.class0 = fg.sl, scores.class1 = bg.sl, curve = T)
plot(pr.sl) #0.1076


#Model: Super Learner with CV
system.time({
  test_CV <- CV.SuperLearner(Y=train$failure, X=train$X, V=10, SL.library = SL.library,
                             verbose = FALSE, method = "method.NNLS", family = binomial(), 
                             cvControl = list(stratifyCV = TRUE))#, id = NULL, control = list(), obsWeights = NULL)
}) # use parallel = 'multicore': around 7 hours on 1 core

test_CV
summary(test_CV)
coef(test_CV)
coef<-coef(test_CV)
mean(coef[,3])


#BART MACHINE on a sample

set.seed(123)
sample <- sample(seq_len(nrow(dati)), size = nrow(dati)*0.1) 

dati$iso <- as.factor(dati$iso)
dati$nace_2 <- as.factor(dati$nace_2)
dati$control <- as.factor(dati$control)


sample <- dati[sample,]

set.seed(123)
train_sample <- sample(seq_len(nrow(sample)), size = nrow(sample)*0.9) 
train <- sample[train_sample,]
test <- sample[-train_sample,]


predictors <- c("iso", "tfp_acf", "Number_of_patents", "Number_of_trademarks", "consdummy", "control", 
                "nace_2", "fin_rev", "int_paid", "ebitda", "cash_flow", "depr", "revenue", "total_assets", 
                "long_term_debt", "employees", "added_value", "materials", "wage_bill", "loans" , "int_fixed_assets",
                "fixed_assets", "current_liabilities",  "liquidity_ratio",  "solvency_ratio", "current_assets",
                "fin_expenses", "net_income",  "fin_cons100" , "inv" , "real_SA", "shareholders_funds" , "NEG_VA" ,
                "ICR_failure" , "profitability" ,  "misallocated_fixed" , "interest_diff") # , "+ capital_intensity", "labour_product"

train$X <-as.data.frame(train[predictors])

set_bart_machine_num_cores(4)
system.time({
bart_machine<-bartMachine(train$X,as.factor(train$failure), use_missing_data=TRUE) 
})

test$X <- as.data.frame(test[predictors])
fitted.results.bart <- 1- round(predict(bart_machine, test$X,  type='prob'), 6)

postResample(fitted.results.bart, test$failure)
#     RMSE  Rsquared       MAE 
#0.2533690 0.4123998 0.1277762 
bart_predict_for_test_data(bart_machine, test$X, as.factor(test$failure))$rmse

#Get Accurancy
fitted.bart <- ifelse(fitted.results.bart> 0.5 ,1,0)
misClasificError.bart <- mean(fitted.bart != test$failure)
acc.bart<-print(paste('Accuracy',1-misClasificError.bart)) #Accurancy:0.892777555568253
auc(fitted.results.bart, test$failure)

#Roc
fg.bart<-fitted.results.bart[test$failure==1] 
bg.bart<-fitted.results.bart[test$failure==0]


roc.bart<-roc.curve(scores.class0 = fg.bart, scores.class1 = bg.bart, curve = T)
plot(roc.bart) #0.9039

pr.bart<-pr.curve(scores.class0 = fg.bart, scores.class1 = bg.bart, curve = T)
plot(pr.bart) #0.6867

#Confusion matrix
fitted.values.bart <- predict(bart_machine, test$X,  type='class')

table(fitted.values.bart, test$failure) #confusion matrix


 







