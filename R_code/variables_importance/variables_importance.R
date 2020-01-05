#Variable importance

rm(list=ls())

memory.limit(size=1000000)
options(java.parameters = "-Xmx50g")
#options(java.parameters = "-Xmx5g")
library(rJava)
library(bartMachine)
library(haven)
library(plyr)
library(dplyr)
library(PRROC)
library(caret)

setwd("G:\\Il mio Drive\\Research\\Italian Firms\\Zombie Hunting New Data")
dati <- read_dta("zombie_indicator_by_country.dta")

variables <- c("failure_2017", "iso", "tfp_acf_2016", "dummy_patents", "dummy_trademark", "consdummy", "control", 
                "nace_2", "fin_rev_2016", "int_paid_2016", "ebitda_2016", "cash_flow_2016", "depr2016", 
                "revenue2016", "total_assets_2016",  "long_term_debt_2016", "employees_2016", "added_value_2016",
                "materials_2016", "wage_bill_2016", "loans_2016" , "int_fixed_assets_2016", "fixed_assets_2016",
                "current_liabilities_2016",  "liquidity_ratio_2016",  "solvency_ratio_2016", "current_assets_2016",
                "fin_expenses_2016", "net_income_2016",  "fin_cons100_2016" , "inv_2016" , "real_SA_2016", 
                "shareholders_funds_2016" , "NEG_VA_2016" , "ICR_failure_2016" , "profitability_2016" ,  "misallocated_2016_fixed" , 
                "interest_diff_2016")
dati_2016 <- (dati[variables])
#dati_2016<- na.omit(dati_2016)
dati_2016<- subset(dati_2016, !is.na(dati_2016$failure_2017)) 

#Sample the same size of other datasets
dati_2016<-as.data.frame(dati_2016[,1:length(dati_2016)])
set.seed(123)
index <- sample(seq_len(nrow(dati_2016)), size = 5000) #same size of the others 
sample <- dati_2016[index,]

#Create train data and test data
set.seed(2235)
train_ind <- sample(seq_len(nrow(sample)), size = nrow(sample)*0.9) 
train <- sample[train_ind,]
test <- sample[-train_ind,]

#BART MACHINE
predictors <- c( "iso", "tfp_acf_2016", "dummy_patents", "dummy_trademark", "consdummy", "control", 
                "nace_2", "fin_rev_2016", "int_paid_2016", "ebitda_2016", "cash_flow_2016", "depr2016", 
                "revenue2016", "total_assets_2016",  "long_term_debt_2016", "employees_2016", "added_value_2016",
                "materials_2016", "wage_bill_2016", "loans_2016" , "int_fixed_assets_2016", "fixed_assets_2016",
                "current_liabilities_2016",  "liquidity_ratio_2016",  "solvency_ratio_2016", "current_assets_2016",
                "fin_expenses_2016", "net_income_2016",  "fin_cons100_2016" , "inv_2016" , "real_SA_2016", 
                "shareholders_funds_2016" , "NEG_VA_2016" , "ICR_failure_2016" , "profitability_2016" ,  "misallocated_2016_fixed" , 
                "interest_diff_2016")
train$X <-as.data.frame(train[predictors])
set_bart_machine_num_cores(4)
system.time({
  bart_2017<-bartMachine(train$X,as.factor(train$failure_2017), use_missing_data=TRUE) 
})

#Var importance
system.time({
investigate_var_importance(bart_2017, num_replicates_for_avg = 10)
})

#Plot of the effect of the single covariates (ceteris paribus)
pd_plot(bart_2017, j= "ICR_failure_2016") 
pd_plot(bart_2017, j= "tfp_acf_2016") 
pd_plot(bart_2017, j= "fin_rev_2016") 
