######################################################################################
##                                                                                  ##
##    Country/Year Analysis for the "Machine Learning for Zombie Hunting" paper     ##
##                           Falco J. Bargagli-Stoffi                               ##
##                                                                                  ##
##                                                                                  ##
######################################################################################

# Get Envirnoment Ready
rm(list=ls())
memory.limit(size=1000000)
options(java.parameters = "-Xmx100g")
library(rJava)
library(bartMachine)
library(haven)

# Set Working Directory
setwd("/home/falco.bargaglistoffi/Desktop/R_files/zombie_hunting/Working_Data/")

# Upload Data
data <- read_dta("analysis_data_indicators.dta")

# Rework Variables
names(data)[names(data) == 'GUO___BvD_ID_number'] <- 'guo'
data$control <- ifelse(data$guo=="", 0, 1)
data$nace <- as.factor(data$nace)
data$area <- as.factor(data$area)
levels(data$nace) <- floor(as.numeric(levels(data$nace))/100) 

# Rename Variables
names(data)[names(data) == "misallocated_2008_fixed"] <- "misallocated_fixed_2008"
names(data)[names(data) == "misallocated_2009_fixed"] <- "misallocated_fixed_2009"
names(data)[names(data) == "misallocated_2010_fixed"] <- "misallocated_fixed_2010"
names(data)[names(data) == "misallocated_2011_fixed"] <- "misallocated_fixed_2011"
names(data)[names(data) == "misallocated_2012_fixed"] <- "misallocated_fixed_2012"
names(data)[names(data) == "misallocated_2013_fixed"] <- "misallocated_fixed_2013"
names(data)[names(data) == "misallocated_2014_fixed"] <- "misallocated_fixed_2014"
names(data)[names(data) == "misallocated_2015_fixed"] <- "misallocated_fixed_2015"
names(data)[names(data) == "misallocated_2016_fixed"] <- "misallocated_fixed_2016"
names(data)[names(data) == "revenue2008"] <- "revenue_2008"
names(data)[names(data) == "revenue2009"] <- "revenue_2009"
names(data)[names(data) == "revenue2010"] <- "revenue_2010"
names(data)[names(data) == "revenue2011"] <- "revenue_2011"
names(data)[names(data) == "revenue2012"] <- "revenue_2012"
names(data)[names(data) == "revenue2013"] <- "revenue_2013"
names(data)[names(data) == "revenue2014"] <- "revenue_2014"
names(data)[names(data) == "revenue2015"] <- "revenue_2015"
names(data)[names(data) == "revenue2016"] <- "revenue_2016"
names(data)[names(data) == "depr2008"] <- "depr_2008"
names(data)[names(data) == "depr2009"] <- "depr_2009"
names(data)[names(data) == "depr2010"] <- "depr_2010"
names(data)[names(data) == "depr2011"] <- "depr_2011"
names(data)[names(data) == "depr2012"] <- "depr_2012"
names(data)[names(data) == "depr2013"] <- "depr_2013"
names(data)[names(data) == "depr2014"] <- "depr_2014"
names(data)[names(data) == "depr2015"] <- "depr_2015"
names(data)[names(data) == "depr2016"] <- "depr_2016"

# Select Predictors
lagged_predictors <- c("shareholders_funds",
                "added_value", "cash_flow", "ebitda",
                "fin_rev", "liquidity_ratio", "total_assets",
                "depr", "long_term_debt", "employees",
                "materials", "loans", "wage_bill", "tfp_acf",
                "fixed_assets", "tax", "current_liabilities",
                "current_assets", "fin_expenses", "int_paid",
                "solvency_ratio", "net_income", "revenue",
                "capital_intensity", "fin_cons", "inv",
                "ICR_failure", "interest_diff", "NEG_VA",
                "real_SA", "profitability", "misallocated_fixed",
                "financial_sustainability", "liquidity_return",
                "int_fixed_assets")
predictors <- c("control", "nace", "consdummy", "area", "dummy_patents", "dummy_trademark")

# Construct Yearly Failure Indicator
years <- c(2009:2016)
failed <- matrix(NA, ncol = length(years), nrow = nrow(data))
for (i in (years)){
  failed[,which(years==i)][which(data$year_of_status == i & data$year_of_incorporation<= i & data$failure== 1)] <- 1
  failed[,which(years==i)][which(data$year_of_incorporation <= i & data$failure==0)] <- 0
}
data$failure_2009 <- failed[,1]
data$failure_2010 <- failed[,2]
data$failure_2011 <- failed[,3]
data$failure_2012 <- failed[,4]
data$failure_2013 <- failed[,5]
data$failure_2014 <- failed[,6]
data$failure_2015 <- failed[,7]
data$failure_2016 <- failed[,8]
data$failure_2017 <- matrix(NA, ncol = 1, nrow = nrow(data))
data$failure_2017[which((data$year_of_status == 2017 | data$year_of_status == 2018) & data$year_of_incorporation<= 2017 & data$failure== 1)] <- 1
data$failure_2017[which(data$year_of_incorporation <= 2017 & data$failure==0)] <- 0

# Get Country Specific Data
data_italy <- data[which(data$iso=="IT"),] 
data_spain <- data[which(data$iso=="ES"),] 
data_france <- data[which(data$iso=="FR"),] 
data_portugal <- data[which(data$iso=="PT"),] 

###########################################################################################################################################
# Analysis for Italian Firms (2009-2017)
years <- c(2009:2016)
prob <- matrix(NA, ncol = length(years), nrow = nrow(data_italy))
for (i in (years)){
  # Subset data by Year
  data_model <- data_italy[which(!is.na(data_italy[,paste("failure", sep = "_", i + 1)])),]
  
  # Get Predictors Matrix
  X <- as.data.frame(cbind(data_model[,paste(lagged_predictors, sep = "_", i)], data_model[,paste(predictors)]))
  
  # Get Outcome Vector
  y <- as.vector(data_model[,paste("failure", sep = "_", i + 1)])
  y <- as.factor(unlist(y, use.names = FALSE))
  
  # Run the model
  bart_machine<-bartMachine(X, y, use_missing_data=TRUE) 
  
  # Get fitted values
  prob[which(!is.na(data_italy[,paste("failure", sep = "_", i + 1)])), which(years==i)] <-  1 - round(predict(bart_machine, X, type='prob'), 6)
  
}

# Save Results
data_italy$prob_2010 <- prob[,1]
data_italy$prob_2011 <- prob[,2]
data_italy$prob_2012 <- prob[,3]
data_italy$prob_2013 <- prob[,4]
data_italy$prob_2014 <- prob[,5]
data_italy$prob_2015 <- prob[,6]
data_italy$prob_2016 <- prob[,7]
data_italy$prob_2017 <- prob[,8]

# Failures 2009 (no investments and interest-difference)
# Subset data by Year
data_model <- data_italy[which(!is.na(data_italy[,paste("failure", sep = "_", 2009)])),]
lagged_predictors <- c("shareholders_funds",
                       "added_value", "cash_flow", "ebitda",
                       "fin_rev", "liquidity_ratio", "total_assets",
                       "depr", "long_term_debt", "employees",
                       "materials", "loans", "wage_bill", 
                       "fixed_assets", "tax", "current_liabilities",
                       "current_assets", "fin_expenses", "int_paid",
                       "solvency_ratio", "net_income", "revenue",
                       "capital_intensity", "fin_cons",
                       "ICR_failure", "NEG_VA",
                       "real_SA", "profitability", "misallocated_fixed",
                       "financial_sustainability", "liquidity_return",
                       "int_fixed_assets")
# Get Predictors Matrix
X <- as.data.frame(cbind(data_model[,paste(lagged_predictors, sep = "_", 2008)], data_model[,paste(predictors)]))

# Get Outcome Vector
y <- as.vector(data_model[,paste("failure", sep = "_", 2009)])
y <- as.factor(unlist(y, use.names = FALSE))

# Run the model
bart_machine<-bartMachine(X, y, use_missing_data=TRUE) 

# Get fitted values
data_italy$prob_2009 <- matrix(NA, ncol = 1, nrow = nrow(data_italy))
data_italy$prob_2009[which(!is.na(data_italy[,paste("failure", sep = "_", 2009)]))] <-  1 - round(predict(bart_machine, X, type='prob'), 6)

###########################################################################################################################################
# Analysis for Spanish Firms (2009-2017)
# Select Predictors
lagged_predictors <- c("shareholders_funds",
                       "added_value", "cash_flow", "ebitda",
                       "fin_rev", "liquidity_ratio", "total_assets",
                       "depr", "long_term_debt", "employees",
                       "materials", "loans", "wage_bill",
                       "fixed_assets", "tax", "current_liabilities",
                       "current_assets", "fin_expenses", "int_paid",
                       "solvency_ratio", "net_income", "revenue",
                       "capital_intensity", "fin_cons", "inv",
                       "ICR_failure", "interest_diff", "NEG_VA",
                       "real_SA", "profitability", "misallocated_fixed",
                       "financial_sustainability", "liquidity_return",
                       "int_fixed_assets")
prob <- matrix(NA, ncol = length(years), nrow = nrow(data_spain))
for (i in (years)){
  # Subset data by Year
  data_model <- data_spain[which(!is.na(data_spain[,paste("failure", sep = "_", i + 1)])),]
  
  # Get Predictors Matrix
  X <- as.data.frame(cbind(data_model[,paste(lagged_predictors, sep = "_", i)], data_model[,paste(predictors)]))
  
  # Get Outcome Vector
  y <- as.vector(data_model[,paste("failure", sep = "_", i + 1)])
  y <- as.factor(unlist(y, use.names = FALSE))
  
  # Run the model
  bart_machine<-bartMachine(X, y, use_missing_data=TRUE) 
  
  # Get fitted values
  prob[which(!is.na(data_spain[,paste("failure", sep = "_", i + 1)])), which(years==i)] <-  1 - round(predict(bart_machine, X, type='prob'), 6)
  
}

# Save Results
data_spain$prob_2010 <- prob[,1]
data_spain$prob_2011 <- prob[,2]
data_spain$prob_2012 <- prob[,3]
data_spain$prob_2013 <- prob[,4]
data_spain$prob_2014 <- prob[,5]
data_spain$prob_2015 <- prob[,6]
data_spain$prob_2016 <- prob[,7]
data_spain$prob_2017 <- prob[,8]

# Failures 2009 (no investments and interest-difference)
# Subset data by Year
data_model <- data_spain[which(!is.na(data_spain[,paste("failure", sep = "_", 2009)])),]
lagged_predictors <- c("shareholders_funds",
                       "added_value", "cash_flow", "ebitda",
                       "fin_rev", "liquidity_ratio", "total_assets",
                       "depr", "long_term_debt", "employees",
                       "materials", "loans", "wage_bill",
                       "fixed_assets", "tax", "current_liabilities",
                       "current_assets", "fin_expenses", "int_paid",
                       "solvency_ratio", "net_income", "revenue",
                       "capital_intensity", "fin_cons",
                       "ICR_failure", "NEG_VA",
                       "real_SA", "profitability", "misallocated_fixed",
                       "financial_sustainability", "liquidity_return",
                       "int_fixed_assets")
# Get Predictors Matrix
X <- as.data.frame(cbind(data_model[,paste(lagged_predictors, sep = "_", 2008)], data_model[,paste(predictors)]))

# Get Outcome Vector
y <- as.vector(data_model[,paste("failure", sep = "_", 2009)])
y <- as.factor(unlist(y, use.names = FALSE))

# Run the model
bart_machine<-bartMachine(X, y, use_missing_data=TRUE) 

# Get fitted values
data_spain$prob_2009 <- matrix(NA, ncol = 1, nrow = nrow(data_spain))
data_spain$prob_2009[which(!is.na(data_spain[,paste("failure", sep = "_", 2009)]))] <-  1 - round(predict(bart_machine, X, type='prob'), 6)

###########################################################################################################################################
# Analysis for French Firms (2009-2017)
prob <- matrix(NA, ncol = length(years), nrow = nrow(data_france))
for (i in (years)){
  # Subset data by Year
  data_model <- data_france[which(!is.na(data_france[,paste("failure", sep = "_", i + 1)])),]
  
  # Get Predictors Matrix
  X <- as.data.frame(cbind(data_model[,paste(lagged_predictors, sep = "_", i)], data_model[,paste(predictors)]))
  
  # Get Outcome Vector
  y <- as.vector(data_model[,paste("failure", sep = "_", i + 1)])
  y <- as.factor(unlist(y, use.names = FALSE))
  
  # Run the model
  bart_machine<-bartMachine(X, y, use_missing_data=TRUE) 
  
  # Get fitted values
  prob[which(!is.na(data_france[,paste("failure", sep = "_", i + 1)])), which(years==i)] <-  1 - round(predict(bart_machine, X, type='prob'), 6)
  
}

# Save Results
data_france$prob_2010 <- prob[,1]
data_france$prob_2011 <- prob[,2]
data_france$prob_2012 <- prob[,3]
data_france$prob_2013 <- prob[,4]
data_france$prob_2014 <- prob[,5]
data_france$prob_2015 <- prob[,6]
data_france$prob_2016 <- prob[,7]
data_france$prob_2017 <- prob[,8]

# Failures 2009 (no investments and interest-difference)
# Subset data by Year
data_model <- data_france[which(!is.na(data_france[,paste("failure", sep = "_", 2009)])),]
lagged_predictors <- c("shareholders_funds",
                       "added_value", "cash_flow", "ebitda",
                       "fin_rev", "liquidity_ratio", "total_assets",
                       "depr", "long_term_debt", "employees",
                       "materials", "loans", "wage_bill",
                       "fixed_assets", "tax", "current_liabilities",
                       "current_assets", "fin_expenses", "int_paid",
                       "solvency_ratio", "net_income", "revenue",
                       "capital_intensity", "fin_cons",
                       "ICR_failure", "NEG_VA",
                       "real_SA", "profitability", "misallocated_fixed",
                       "financial_sustainability", "liquidity_return",
                       "int_fixed_assets")
# Get Predictors Matrix
X <- as.data.frame(cbind(data_model[,paste(lagged_predictors, sep = "_", 2008)], data_model[,paste(predictors)]))

# Get Outcome Vector
y <- as.vector(data_model[,paste("failure", sep = "_", 2009)])
y <- as.factor(unlist(y, use.names = FALSE))

# Run the model
bart_machine<-bartMachine(X, y, use_missing_data=TRUE) 

# Get fitted values
data_france$prob_2009 <- matrix(NA, ncol = 1, nrow = nrow(data_france))
data_france$prob_2009[which(!is.na(data_france[,paste("failure", sep = "_", 2009)]))] <-  1 - round(predict(bart_machine, X, type='prob'), 6)

###########################################################################################################################################
# Analysis for Portuguese Firms (2009-2017)
prob <- matrix(NA, ncol = length(years), nrow = nrow(data_portugal))
for (i in (years)){
  # Subset data by Year
  data_model <- data_france[which(!is.na(data_france[,paste("failure", sep = "_", i + 1)])),]
  
  # Get Predictors Matrix
  X <- as.data.frame(cbind(data_model[,paste(lagged_predictors, sep = "_", i)], data_model[,paste(predictors)]))
  
  # Get Outcome Vector
  y <- as.vector(data_model[,paste("failure", sep = "_", i + 1)])
  y <- as.factor(unlist(y, use.names = FALSE))
  
  # Run the model
  bart_machine<-bartMachine(X, y, use_missing_data=TRUE) 
  
  # Get fitted values
  prob[which(!is.na(data_france[,paste("failure", sep = "_", i + 1)])), which(years==i)] <-  1 - round(predict(bart_machine, X, type='prob'), 6)
  
}

# Save Results
data_france$prob_2010 <- prob[,1]
data_france$prob_2011 <- prob[,2]
data_france$prob_2012 <- prob[,3]
data_france$prob_2013 <- prob[,4]
data_france$prob_2014 <- prob[,5]
data_france$prob_2015 <- prob[,6]
data_france$prob_2016 <- prob[,7]
data_france$prob_2017 <- prob[,8]

# Failures 2009 (no investments and interest-difference)
# Subset data by Year
data_model <- data_france[which(!is.na(data_france[,paste("failure", sep = "_", 2009)])),]
lagged_predictors <- c("shareholders_funds",
                       "added_value", "cash_flow", "ebitda",
                       "fin_rev", "liquidity_ratio", "total_assets",
                       "depr", "long_term_debt", "employees",
                       "materials", "loans", "wage_bill",
                       "fixed_assets", "tax", "current_liabilities",
                       "current_assets", "fin_expenses", "int_paid",
                       "solvency_ratio", "net_income", "revenue",
                       "capital_intensity", "fin_cons",
                       "ICR_failure", "NEG_VA",
                       "real_SA", "profitability", "misallocated_fixed",
                       "financial_sustainability", "liquidity_return",
                       "int_fixed_assets")
# Get Predictors Matrix
X <- as.data.frame(cbind(data_model[,paste(lagged_predictors, sep = "_", 2008)], data_model[,paste(predictors)]))

# Get Outcome Vector
y <- as.vector(data_model[,paste("failure", sep = "_", 2009)])
y <- as.factor(unlist(y, use.names = FALSE))

# Run the model
bart_machine<-bartMachine(X, y, use_missing_data=TRUE) 

# Get fitted values
data_france$prob_2009 <- matrix(NA, ncol = 1, nrow = nrow(data_france))
data_france$prob_2009[which(!is.na(data_france[,paste("failure", sep = "_", 2009)]))] <-  1 - round(predict(bart_machine, X, type='prob'), 6)

# Organize the Data into a Single Data frame
prob_data <- rbind(data_italy, data_spain, data_portugal, data_france)

# Save Overall Data
write_dta(prob_data, "data_probabilities.dta")
