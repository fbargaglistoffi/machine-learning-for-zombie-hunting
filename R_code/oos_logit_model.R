######################################################################################
##                                                                                  ##
##       Code for OOS-R2 for the "Machine Learning for Zombie Hunting" paper        ##
##                           Falco J. Bargagli-Stoffi                               ##
##                                                                                  ##
##                                                                                  ##
######################################################################################


# Get Envirnoment Ready
rm(list=ls())
library(haven)
library(caret)

# Set Working Directory
#setwd("/home/falco.bargaglistoffi/Desktop/R_files/zombie_hunting/Working_Data/")
setwd("G:/Il mio Drive/Research/Italian Firms/Zombie Hunting New Data")
source("functions.R")


# Upload Data
data <- read_dta("zombie_data.dta")
data_italy <- data[which(data$iso=="IT"),] 

# Model
variables <- c("dummy_2017", "control", "nace", "fin_cons_2014", "ICR_failure_2014", "interest_diff_2014", "NEG_VA_2014", "real_SA_2014", "solvency_ratio_2014")
predictors <- c("control", "nace", "fin_cons_2014", "ICR_failure_2014", "interest_diff_2014", "NEG_VA_2014", "real_SA_2014", "solvency_ratio_2014")
formula <- as.formula(paste("as.factor(dummy_2017) ~",
                            paste(predictors, collapse="+")))


omitted <- na.omit(data_italy[variables])
set.seed(2020)
index <- sample(seq_len(nrow(omitted)), size = nrow(omitted)*0.9) 
train <- omitted[index,]
test <- omitted[-index,]



logit <- glm(formula, data= train,  na.action = "na.omit",
               family=binomial(link='logit'))
  
fitted.prob.logit <- predict(logit, newdata=test, type='response')
fitted.logit <- ifelse(fitted.prob.logit>0.5,1,0)
f1_logit <- f1_score(fitted.logit,
                       test$dummy_2017,
                       positive.class="1")

balanced_accuracy_logit<-balanced_accuracy(fitted.logit, test$dummy_2017)
accuracy_logit <- as.data.frame(rbind(postResample(fitted.logit, test$dummy_2017)))
                                                   
                                                   
                                                   