
#YEAR BY YEAR ANALYSIS
rm(list = ls())

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
#setwd("G:\\Il mio Drive\\Research\\Italian Firms\\Zombie Hunting New Data")
setwd("/home/falco.bargaglistoffi/Research/Zombie Hunting/Data/")
dati <- read_dta("data_france.dta")

dati <- as.data.frame(dati)
dati$iso <- as.factor(dati$iso)
dati$nace_2 <- as.factor(dati$nace_2)
dati$control <- as.factor(dati$control)

#2016

dati_2016 <- dati[!is.na(dati$failure_2017),] 

set.seed(455)
train_sample <- sample(seq_len(nrow(dati_2016)), size = nrow(dati_2016)*0.9) 
train2016 <- as.data.frame(dati_2016[train_sample,])
test2016 <- as.data.frame(dati_2016[-train_sample,])

predictors <- c("iso", "tfp_acf_2016", "dummy_patents", "dummy_trademark", "consdummy", "control", 
                "nace_2", "fin_rev_2016", "int_paid_2016", "ebitda_2016", "cash_flow_2016", "depr2016", 
                "revenue2016", "total_assets_2016",  "long_term_debt_2016", "employees_2016", "added_value_2016",
                "materials_2016", "wage_bill_2016", "loans_2016" , "int_fixed_assets_2016", "fixed_assets_2016",
                "current_liabilities_2016",  "liquidity_ratio_2016",  "solvency_ratio_2016", "current_assets_2016",
                "fin_expenses_2016", "net_income_2016",  "fin_cons100_2016" , "inv_2016" , "real_SA_2016", 
                "shareholders_funds_2016" , "NEG_VA_2016" , "ICR_failure_2016" , "profitability_2016" ,  "misallocated_2016_fixed" , 
                "interest_diff_2016")
train2016$X <-as.data.frame(train2016[predictors])

set_bart_machine_num_cores(4)
system.time({
  bart2016<-bartMachine(train2016$X,as.factor(train2016$failure_2017), use_missing_data=TRUE) #names referred to year t + 1 
})


dati_2016$X <- as.data.frame(dati_2016[predictors])
fitted_2016 <- 1- round(predict(bart2016, dati_2016$X,  type='prob'), 6)

#Create categories
dati_2016$cat_2017<-ifelse(fitted_2016  >=  quantile(fitted_2016 , c(.9)) , 1,0 )
length(which(dati_2016$cat_2017==1))

dati_2016$cat_2017<-replace(dati_2016$cat_2017, fitted_2016  <  quantile(fitted_2016 , c(.9)) & fitted_2016 >=  quantile(fitted_2016 , c(.8)), 2 )
length(which(dati_2016$cat_2017==2))

table(dati_2016$cat_2017)

#Change COUNTRY
dati_2016$cat_fr_2017 <- dati_2016$cat_2017
dati_2016$prob_fr_2017 <- fitted_2016
variable <- c("id", "cat_fr_2017", "prob_fr_2017")
dati_fr_2016 <- dati_2016[variable]

#Save Data
write_dta(dati_fr_2016, "dati_fr_2016.dta")

#2015

dati_2015 <- as.data.frame(dati[!is.na(dati$failure_2016),]) 

set.seed(455)
train_sample <- sample(seq_len(nrow(dati_2015)), size = nrow(dati_2015)*0.9) 
train2015 <- as.data.frame(dati_2015[train_sample,])
test2015 <- as.data.frame(dati_2015[-train_sample,])

predictors <- c("iso", "tfp_acf_2015", "dummy_patents", "dummy_trademark", "consdummy", "control", 
                "nace_2", "fin_rev_2015", "int_paid_2015", "ebitda_2015", "cash_flow_2015", "depr2015", 
                "revenue2015", "total_assets_2015",  "long_term_debt_2015", "employees_2015", "added_value_2015",
                "materials_2015", "wage_bill_2015", "loans_2015" , "int_fixed_assets_2015", "fixed_assets_2015",
                "current_liabilities_2015",  "liquidity_ratio_2015",  "solvency_ratio_2015", "current_assets_2015",
                "fin_expenses_2015", "net_income_2015",  "fin_cons100_2015" , "inv_2015" , "real_SA_2015", 
                "shareholders_funds_2015" , "NEG_VA_2015" , "ICR_failure_2015" , "profitability_2015" ,  "misallocated_2015_fixed" , 
                "interest_diff_2015")
train2015$X <-as.data.frame(train2015[predictors])

set_bart_machine_num_cores(4)
system.time({
  bart2015<-bartMachine(train2015$X,as.factor(train2015$failure_2016), use_missing_data=TRUE) #names referred to year t + 1 
})


dati_2015$X <- as.data.frame(dati_2015[predictors])
fitted_2015 <- 1- round(predict(bart2015, dati_2015$X,  type='prob'), 6)

#Create categories
dati_2015$cat_2016<-ifelse(fitted_2015  >=  quantile(fitted_2015 , c(.9)) , 1,0 )
length(which(dati_2015$cat_2016==1))

dati_2015$cat_2016<-replace(dati_2015$cat_2016, fitted_2015  <  quantile(fitted_2015 , c(.9)) & fitted_2015 >=  quantile(fitted_2015 , c(.8)), 2 )
length(which(dati_2015$cat_2016==2))

table(dati_2015$cat_2016)

#Change COUNTRY
dati_2015$cat_fr_2016 <- dati_2015$cat_2016
dati_2015$prob_fr_2016 <- fitted_2015
variable <- c("id", "cat_fr_2016", "prob_fr_2016")
dati_fr_2015 <- dati_2015[variable]

#Save Data
write_dta(dati_fr_2015, "dati_fr_2015.dta")

#2014
dati_2014 <- as.data.frame(dati[!is.na(dati$failure_2015),]) 

set.seed(455)
train_sample <- sample(seq_len(nrow(dati_2014)), size = nrow(dati_2014)*0.9) 
train2014 <- as.data.frame(dati_2014[train_sample,])
test2014 <- as.data.frame(dati_2014[-train_sample,])

predictors <- c("iso", "tfp_acf_2014", "dummy_patents", "dummy_trademark", "consdummy", "control", 
                "nace_2", "fin_rev_2014", "int_paid_2014", "ebitda_2014", "cash_flow_2014", "depr2014", 
                "revenue2014", "total_assets_2014",  "long_term_debt_2014", "employees_2014", "added_value_2014",
                "materials_2014", "wage_bill_2014", "loans_2014" , "int_fixed_assets_2014", "fixed_assets_2014",
                "current_liabilities_2014",  "liquidity_ratio_2014",  "solvency_ratio_2014", "current_assets_2014",
                "fin_expenses_2014", "net_income_2014",  "fin_cons100_2014" , "inv_2014" , "real_SA_2014", 
                "shareholders_funds_2014" , "NEG_VA_2014" , "ICR_failure_2014" , "profitability_2014" ,  "misallocated_2014_fixed" , 
                "interest_diff_2014")
train2014$X <-as.data.frame(train2014[predictors])

set_bart_machine_num_cores(4)
system.time({
  bart2014<-bartMachine(train2014$X,as.factor(train2014$failure_2015), use_missing_data=TRUE) #names referred to year t + 1 
})


dati_2014$X <- as.data.frame(dati_2014[predictors])
fitted_2014 <- 1- round(predict(bart2014, dati_2014$X,  type='prob'), 6)

#Create categories
dati_2014$cat_2015<-ifelse(fitted_2014  >=  quantile(fitted_2014 , c(.9)) , 1,0 )
length(which(dati_2014$cat_2015==1))

dati_2014$cat_2015<-replace(dati_2014$cat_2015, fitted_2014  <  quantile(fitted_2014 , c(.9)) & fitted_2014 >=  quantile(fitted_2014 , c(.8)), 2 )
length(which(dati_2014$cat_2015==2))

table(dati_2014$cat_2015)

#Change COUNTRY
dati_2014$cat_fr_2015 <- dati_2014$cat_2015
dati_2014$prob_fr_2015 <- fitted_2014
variable <- c("id", "cat_fr_2015", "prob_fr_2015")
dati_fr_2014 <- dati_2014[variable]

#Save Data
write_dta(dati_fr_2014, "dati_fr_2014.dta")

#2013

dati_2013 <- as.data.frame(dati[!is.na(dati$failure_2014),]) 

set.seed(455)
train_sample <- sample(seq_len(nrow(dati_2013)), size = nrow(dati_2013)*0.9) 
train2013 <- as.data.frame(dati_2013[train_sample,])
test2013 <- as.data.frame(dati_2013[-train_sample,])

predictors <- c("iso", "tfp_acf_2013", "dummy_patents", "dummy_trademark", "consdummy", "control", 
                "nace_2", "fin_rev_2013", "int_paid_2013", "ebitda_2013", "cash_flow_2013", "depr2013", 
                "revenue2013", "total_assets_2013",  "long_term_debt_2013", "employees_2013", "added_value_2013",
                "materials_2013", "wage_bill_2013", "loans_2013" , "int_fixed_assets_2013", "fixed_assets_2013",
                "current_liabilities_2013",  "liquidity_ratio_2013",  "solvency_ratio_2013", "current_assets_2013",
                "fin_expenses_2013", "net_income_2013",  "fin_cons100_2013" , "inv_2013" , "real_SA_2013", 
                "shareholders_funds_2013" , "NEG_VA_2013" , "ICR_failure_2013" , "profitability_2013" ,  "misallocated_2013_fixed" , 
                "interest_diff_2013")
train2013$X <-as.data.frame(train2013[predictors])

set_bart_machine_num_cores(4)
system.time({
  bart2013<-bartMachine(train2013$X,as.factor(train2013$failure_2014), use_missing_data=TRUE) #names referred to year t + 1 
})


dati_2013$X <- as.data.frame(dati_2013[predictors])
fitted_2013 <- 1- round(predict(bart2013, dati_2013$X,  type='prob'), 6)

#Create categories
dati_2013$cat_2014<-ifelse(fitted_2013  >=  quantile(fitted_2013 , c(.9)) , 1,0 )
length(which(dati_2013$cat_2014==1))

dati_2013$cat_2014<-replace(dati_2013$cat_2014, fitted_2013  <  quantile(fitted_2013 , c(.9)) & fitted_2013 >=  quantile(fitted_2013 , c(.8)), 2 )
length(which(dati_2013$cat_2014==2))

table(dati_2013$cat_2014)

#Change COUNTRY
dati_2013$cat_fr_2014 <- dati_2013$cat_2014
dati_2013$prob_fr_2014 <- fitted_2013
variable <- c("id", "cat_fr_2014", "prob_fr_2014")
dati_fr_2013 <- dati_2013[variable]

#Save Data
write_dta(dati_fr_2013, "dati_fr_2013.dta")