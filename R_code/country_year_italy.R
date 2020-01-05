
#YEAR BY YEAR ANALYSIS
rm(list = ls())

options(java.parameters = "-Xmx100g")
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
dati <- read_dta("data_italy.dta")

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
}) #42 minutes


dati_2016$X <- as.data.frame(dati_2016[predictors])
fitted_2016 <- 1- round(predict(bart2016, dati_2016$X,  type='prob'), 6)

#Create categories
dati_2016$cat_2017<-ifelse(fitted_2016  >=  quantile(fitted_2016 , c(.9)) , 1,0 )
length(which(dati_2016$cat_2017==1))

dati_2016$cat_2017<-replace(dati_2016$cat_2017, fitted_2016  <  quantile(fitted_2016 , c(.9)) & fitted_2016 >=  quantile(fitted_2016 , c(.8)), 2 )
length(which(dati_2016$cat_2017==2))

table(dati_2016$cat_2017)

#Change COUNTRY
dati_2016$cat_it_2017 <- dati_2016$cat_2017
dati_2016$prob_it_2017 <- fitted_2016
variable <- c("id", "cat_it_2017", "prob_it_2017")
dati_it_2016 <- dati_2016[variable]

#Save Data
write_dta(dati_it_2016, "dati_it_2016.dta")

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
dati_2015$cat_it_2016 <- dati_2015$cat_2016
dati_2015$prob_it_2016 <- fitted_2015
variable <- c("id", "cat_it_2016", "prob_it_2016")
dati_it_2015 <- dati_2015[variable]

#Save Data
write_dta(dati_it_2015, "dati_it_2015.dta")

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
dati_2014$cat_it_2015 <- dati_2014$cat_2015
dati_2014$prob_it_2015 <- fitted_2014
variable <- c("id", "cat_it_2015", "prob_it_2015")
dati_it_2014 <- dati_2014[variable]

#Save Data
write_dta(dati_it_2014, "dati_it_2014.dta")

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
dati_2013$cat_it_2014 <- dati_2013$cat_2014
dati_2013$prob_it_2014 <- fitted_2013
variable <- c("id", "cat_it_2014", "prob_it_2014")
dati_it_2013 <- dati_2013[variable]

#Save Data
write_dta(dati_it_2013, "dati_it_2013.dta")

#2012
dati_2012 <- as.data.frame(dati[!is.na(dati$failure_2013),]) 

set.seed(455)
train_sample <- sample(seq_len(nrow(dati_2012)), size = nrow(dati_2012)*0.9) 
train2012 <- as.data.frame(dati_2012[train_sample,])
test2012 <- as.data.frame(dati_2012[-train_sample,])

predictors <- c("iso", "tfp_acf_2012", "dummy_patents", "dummy_trademark", "consdummy", "control", 
                "nace_2", "fin_rev_2012", "int_paid_2012", "ebitda_2012", "cash_flow_2012", "depr2012", 
                "revenue2012", "total_assets_2012",  "long_term_debt_2012", "employees_2012", "added_value_2012",
                "materials_2012", "wage_bill_2012", "loans_2012" , "int_fixed_assets_2012", "fixed_assets_2012",
                "current_liabilities_2012",  "liquidity_ratio_2012",  "solvency_ratio_2012", "current_assets_2012",
                "fin_expenses_2012", "net_income_2012",  "fin_cons100_2012" , "inv_2012" , "real_SA_2012", 
                "shareholders_funds_2012" , "NEG_VA_2012" , "ICR_failure_2012" , "profitability_2012" ,  "misallocated_2012_fixed" , 
                "interest_diff_2012")
train2012$X <-as.data.frame(train2012[predictors])

set_bart_machine_num_cores(4)
system.time({
  bart2012<-bartMachine(train2012$X,as.factor(train2012$failure_2013), use_missing_data=TRUE) #names referred to year t + 1 
})


dati_2012$X <- as.data.frame(dati_2012[predictors])
fitted_2012 <- 1- round(predict(bart2012, dati_2012$X,  type='prob'), 6)

#Create categories
dati_2012$cat_2013<-ifelse(fitted_2012  >=  quantile(fitted_2012 , c(.9)) , 1,0 )
length(which(dati_2012$cat_2013==1))

dati_2012$cat_2013<-replace(dati_2012$cat_2013, fitted_2012  <  quantile(fitted_2012 , c(.9)) & fitted_2012 >=  quantile(fitted_2012 , c(.8)), 2 )
length(which(dati_2012$cat_2013==2))

table(dati_2012$cat_2013)

#Change COUNTRY
dati_2012$cat_it_2013 <- dati_2012$cat_2013
dati_2012$prob_it_2013 <- fitted_2012
variable <- c("id", "cat_it_2013", "prob_it_2013")
dati_it_2012 <- dati_2012[variable]

#Save Data
write_dta(dati_it_2012, "dati_it_2012.dta")

#2011
dati_2011 <- as.data.frame(dati[!is.na(dati$failure_2012),]) 

set.seed(455)
train_sample <- sample(seq_len(nrow(dati_2011)), size = nrow(dati_2011)*0.9) 
train2011 <- as.data.frame(dati_2011[train_sample,])
test2011 <- as.data.frame(dati_2011[-train_sample,])

predictors <- c("iso", "tfp_acf_2011", "dummy_patents", "dummy_trademark", "consdummy", "control", 
                "nace_2", "fin_rev_2011", "int_paid_2011", "ebitda_2011", "cash_flow_2011", "depr2011", 
                "revenue2011", "total_assets_2011",  "long_term_debt_2011", "employees_2011", "added_value_2011",
                "materials_2011", "wage_bill_2011", "loans_2011" , "int_fixed_assets_2011", "fixed_assets_2011",
                "current_liabilities_2011",  "liquidity_ratio_2011",  "solvency_ratio_2011", "current_assets_2011",
                "fin_expenses_2011", "net_income_2011",  "fin_cons100_2011" , "inv_2011" , "real_SA_2011", 
                "shareholders_funds_2011" , "NEG_VA_2011" , "ICR_failure_2011" , "profitability_2011" ,  "misallocated_2011_fixed" , 
                "interest_diff_2011")
train2011$X <-as.data.frame(train2011[predictors])

set_bart_machine_num_cores(4)
system.time({
  bart2011<-bartMachine(train2011$X,as.factor(train2011$failure_2012), use_missing_data=TRUE) #names referred to year t + 1 
})


dati_2011$X <- as.data.frame(dati_2011[predictors])
fitted_2011 <- 1- round(predict(bart2011, dati_2011$X,  type='prob'), 6)

#Create categories
dati_2011$cat_2012<-ifelse(fitted_2011  >=  quantile(fitted_2011 , c(.9)) , 1,0 )
length(which(dati_2011$cat_2012==1))

dati_2011$cat_2012<-replace(dati_2011$cat_2012, fitted_2011  <  quantile(fitted_2011 , c(.9)) & fitted_2011 >=  quantile(fitted_2011 , c(.8)), 2 )
length(which(dati_2011$cat_2012==2))

table(dati_2011$cat_2012)

#Change COUNTRY
dati_2011$cat_it_2012 <- dati_2011$cat_2012
dati_2011$prob_it_2012 <- fitted_2011
variable <- c("id", "cat_it_2012", "prob_it_2012")
dati_it_2011 <- dati_2011[variable]

#Save Data
write_dta(dati_it_2011, "dati_it_2011.dta")

#2010
dati_2010 <- as.data.frame(dati[!is.na(dati$failure_2011),]) 

set.seed(455)
train_sample <- sample(seq_len(nrow(dati_2010)), size = nrow(dati_2010)*0.9) 
train2010 <- as.data.frame(dati_2010[train_sample,])
test2010 <- as.data.frame(dati_2010[-train_sample,])

predictors <- c("iso", "tfp_acf_2010", "dummy_patents", "dummy_trademark", "consdummy", "control", 
                "nace_2", "fin_rev_2010", "int_paid_2010", "ebitda_2010", "cash_flow_2010", "depr2010", 
                "revenue2010", "total_assets_2010",  "long_term_debt_2010", "employees_2010", "added_value_2010",
                "materials_2010", "wage_bill_2010", "loans_2010" , "int_fixed_assets_2010", "fixed_assets_2010",
                "current_liabilities_2010",  "liquidity_ratio_2010",  "solvency_ratio_2010", "current_assets_2010",
                "fin_expenses_2010", "net_income_2010",  "fin_cons100_2010" , "inv_2010" , "real_SA_2010", 
                "shareholders_funds_2010" , "NEG_VA_2010" , "ICR_failure_2010" , "profitability_2010" ,  "misallocated_2010_fixed" , 
                "interest_diff_2010")
train2010$X <-as.data.frame(train2010[predictors])

set_bart_machine_num_cores(4)
system.time({
  bart2010<-bartMachine(train2010$X,as.factor(train2010$failure_2011), use_missing_data=TRUE) #names referred to year t + 1 
})


dati_2010$X <- as.data.frame(dati_2010[predictors])
fitted_2010 <- 1- round(predict(bart2010, dati_2010$X,  type='prob'), 6)

#Create categories
dati_2010$cat_2011<-ifelse(fitted_2010  >=  quantile(fitted_2010 , c(.9)) , 1,0 )
length(which(dati_2010$cat_2011==1))

dati_2010$cat_2011<-replace(dati_2010$cat_2011, fitted_2010  <  quantile(fitted_2010 , c(.9)) & fitted_2010 >=  quantile(fitted_2010 , c(.8)), 2 )
length(which(dati_2010$cat_2011==2))

table(dati_2010$cat_2011)

#Change COUNTRY
dati_2010$cat_it_2011 <- dati_2010$cat_2011
dati_2010$prob_it_2011 <- fitted_2010
variable <- c("id", "cat_it_2011", "prob_it_2011")
dati_it_2010 <- dati_2010[variable]

#Save Data
write_dta(dati_it_2010, "dati_it_2010.dta")

#2009
dati_2009 <- as.data.frame(dati[!is.na(dati$failure_2010),]) 

set.seed(455)
train_sample <- sample(seq_len(nrow(dati_2009)), size = nrow(dati_2009)*0.9) 
train2009 <- as.data.frame(dati_2009[train_sample,])
test2009 <- as.data.frame(dati_2009[-train_sample,])

predictors <- c("iso", "tfp_acf_2009", "dummy_patents", "dummy_trademark", "consdummy", "control", 
                "nace_2", "fin_rev_2009", "int_paid_2009", "ebitda_2009", "cash_flow_2009", "depr2009", 
                "revenue2009", "total_assets_2009",  "long_term_debt_2009", "employees_2009", "added_value_2009",
                "materials_2009", "wage_bill_2009", "loans_2009" , "int_fixed_assets_2009", "fixed_assets_2009",
                "current_liabilities_2009",  "liquidity_ratio_2009",  "solvency_ratio_2009", "current_assets_2009",
                "fin_expenses_2009", "net_income_2009",  "fin_cons100_2009" , "inv_2009" , "real_SA_2009", 
                "shareholders_funds_2009" , "NEG_VA_2009" , "ICR_failure_2009" , "profitability_2009" ,  "misallocated_2009_fixed" , 
                "interest_diff_2009")
train2009$X <-as.data.frame(train2009[predictors])

set_bart_machine_num_cores(4)
system.time({
  bart2009<-bartMachine(train2009$X,as.factor(train2009$failure_2010), use_missing_data=TRUE) #names referred to year t + 1 
})


dati_2009$X <- as.data.frame(dati_2009[predictors])
fitted_2009 <- 1- round(predict(bart2009, dati_2009$X,  type='prob'), 6)

#Create categories
dati_2009$cat_2010<-ifelse(fitted_2009  >=  quantile(fitted_2009 , c(.9)) , 1,0 )
length(which(dati_2009$cat_2010==1))

dati_2009$cat_2010<-replace(dati_2009$cat_2010, fitted_2009  <  quantile(fitted_2009 , c(.9)) & fitted_2009 >=  quantile(fitted_2009 , c(.8)), 2 )
length(which(dati_2009$cat_2010==2))

table(dati_2009$cat_2010)

#Change COUNTRY
dati_2009$cat_it_2010 <- dati_2009$cat_2010
dati_2009$prob_it_2010 <- fitted_2009
variable <- c("id", "cat_it_2010", "prob_it_2010")
dati_it_2009 <- dati_2009[variable]

#Save Data
write_dta(dati_it_2009, "dati_it_2009.dta")

#2008
dati_2008 <- as.data.frame(dati[!is.na(dati$failure_2009),]) 

set.seed(455)
train_sample <- sample(seq_len(nrow(dati_2008)), size = nrow(dati_2008)*0.9) 
train2008 <- as.data.frame(dati_2008[train_sample,])
test2008 <- as.data.frame(dati_2008[-train_sample,])

predictors <- c("iso", "tfp_acf_2008", "dummy_patents", "dummy_trademark", "consdummy", "control", 
                "nace_2", "fin_rev_2008", "int_paid_2008", "ebitda_2008", "cash_flow_2008", "depr2008", 
                "revenue2008", "total_assets_2008",  "long_term_debt_2008", "employees_2008", "added_value_2008",
                "materials_2008", "wage_bill_2008", "loans_2008" , "int_fixed_assets_2008", "fixed_assets_2008",
                "current_liabilities_2008",  "liquidity_ratio_2008",  "solvency_ratio_2008", "current_assets_2008",
                "fin_expenses_2008", "net_income_2008",  "fin_cons100_2008" ,  "real_SA_2008", 
                "shareholders_funds_2008" , "NEG_VA_2008" , "ICR_failure_2008" , "profitability_2008" ,  "misallocated_2008_fixed")
#  "interest_diff_2008", "inv_2008" 
train2008$X <-as.data.frame(train2008[predictors])

set_bart_machine_num_cores(4)
system.time({
  bart2008<-bartMachine(train2008$X,as.factor(train2008$failure_2009), use_missing_data=TRUE) #names referred to year t + 1 
})


dati_2008$X <- as.data.frame(dati_2008[predictors])
fitted_2008 <- 1- round(predict(bart2008, dati_2008$X,  type='prob'), 6)

#Create categories
dati_2008$cat_2009<-ifelse(fitted_2008  >=  quantile(fitted_2008 , c(.9)) , 1,0 )
length(which(dati_2008$cat_2009==1))

dati_2008$cat_2009<-replace(dati_2008$cat_2009, fitted_2008  <  quantile(fitted_2008 , c(.9)) & fitted_2008 >=  quantile(fitted_2008 , c(.8)), 2 )
length(which(dati_2008$cat_2009==2))

table(dati_2008$cat_2009)

#Change COUNTRY
dati_2008$cat_it_2009 <- dati_2008$cat_2009
dati_2008$prob_it_2009 <- fitted_2008
variable <- c("id", "cat_it_2009", "prob_it_2009")
dati_it_2008 <- dati_2008[variable]

#Save Data
write_dta(dati_it_2008, "dati_it_2008.dta")
