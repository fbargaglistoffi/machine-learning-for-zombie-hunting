#YEAR BY YEAR ANALYSIS

options(java.parameters = "-Xmx50g")
#options(java.parameters = "-Xmx5g")
library(rJava)
library(bartMachine)
library(haven)
library(plyr)
library(dplyr)
library(PRROC)
library(caret)

#Upload dati
setwd("G:\\Il mio Drive\\Research\\Italian Firms\\Zombie Hunting New Data")
setwd("/home/falco.bargaglistoffi/Research/Zombie Hunting/Data/")
dati <- read_dta("data_2017.dta")
dati$iso <- as.factor(dati$iso)
dati$nace_2 <- as.factor(dati$nace_2)
dati$control <- as.factor(dati$control)

set.seed(455)
train_sample <- sample(seq_len(nrow(dati)), size = nrow(dati)*0.9) 
train <- as.data.frame(dati[train_sample,])
test_sample <- sample(seq_len(nrow(dati)), size = nrow(dati)*0.1) 
test <- as.data.frame(dati[test_sample,])


train_it <-  train[train$iso== 'IT', ]
train_pt <-  train[train$iso== 'PT', ]
train_fr <-  train[train$iso== 'FR', ]
train_es <-  train[train$iso== 'ES', ]

test_it <-  test[test$iso== 'IT', ]
test_pt <-  test[test$iso== 'PT', ]
test_fr <-  test[test$iso== 'FR', ]
test_es <-  test[test$iso== 'ES', ]


predictors <- c("iso", "tfp_acf_2016", "dummy_patents", "dummy_trademark", "consdummy", "control", 
                "nace_2", "fin_rev_2016", "int_paid_2016", "ebitda_2016", "cash_flow_2016", "depr2016", 
                "revenue2016", "total_assets_2016",  "long_term_debt_2016", "employees_2016", "added_value_2016",
                "materials_2016", "wage_bill_2016", "loans_2016" , "int_fixed_assets_2016", "fixed_assets_2016",
                "current_liabilities_2016",  "liquidity_ratio_2016",  "solvency_ratio_2016", "current_assets_2016",
                "fin_expenses_2016", "net_income_2016",  "fin_cons100_2016" , "inv_2016" , "real_SA_2016", 
                "shareholders_funds_2016" , "NEG_VA_2016" , "ICR_failure_2016" , "profitability_2016" ,  "misallocated_2016_fixed" , 
                "interest_diff_2016")

#ITALY
train_it$X <-as.data.frame(train_it[predictors])

set_bart_machine_num_cores(4)
system.time({
  bart_it_2017 <- bartMachine(train_it$X,as.factor(train_it$failure_2017), use_missing_data=TRUE) 
}) # 9 minutes

test_it$X <- as.data.frame(test_it[predictors])
fitted_it_2017 <- 1- round(predict(bart_it_2017, test_it$X,  type='prob'), 6)

postResample(fitted_it_2017, test_it$failure_2017)
#      RMSE   Rsquared        MAE 
#0.14003817 0.31532403 0.04032672 

#Roc
fg.bart<-fitted_it_2017[test_it$failure_2017==1] 
bg.bart<-fitted_it_2017[test_it$failure_2017==0]


roc.bart<-roc.curve(scores.class0 = fg.bart, scores.class1 = bg.bart, curve = T)
plot(roc.bart) #0.9657

pr.bart<-pr.curve(scores.class0 = fg.bart, scores.class1 = bg.bart, curve = T)
plot(pr.bart) #0.4660

#Confusion matrix
fitted_values_it_2017 <- predict(bart_it_2017, test_it$X,  type='class')

table(fitted_it_2017, test_it$failure_2017)

#Create categories
fitted_it_2017 <- 1- round(predict(bart_it_2017, test_it$X,  type='prob'), 6)

cat_2017<-ifelse(fitted_it_2017  >=  quantile(fitted_it_2017 , c(.9)) , 1,0 )
length(which(cat_2017==1))

cat_2017<-replace(cat_it_2017, fitted_it_2017  <  quantile(fitted_it_2017 , c(.9)) & fitted_it_2017 >=  quantile(fitted_it_2017 , c(.8)), 2 )
length(which(cat_2017==2))

table(cat_it_2017)

