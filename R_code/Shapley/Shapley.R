######################################################################################
##                                                                                  ##
##      Shapley Analysis for the "Machine Learning for Zombie Hunting" paper        ##
##                           Falco J. Bargagli-Stoffi                               ##
##                                                                                  ##
##                                                                                  ##
######################################################################################

# Get Environment Ready
rm(list=ls())
library(dbarts)
library(haven)
library(fastshap)
library(ranger)
library(ggplot2)
library(imputeMissings)
library(patchwork)

# Set Working Directory
setwd("/Volumes/GoogleDrive/My Drive/Research/Italian Firms/Zombie Hunting New Data")

# Upload Data
data <- read_dta("zombie_data.dta")

# Keep just Italian Data
data_italy <- data[which(data$iso=="IT"),]

# Predictors 
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

system.time({
  years <- c(2012:2017)
  shapley <- c()
  for (i in (years)){
    # Subset data by Year
    data_model <- data_italy[which(!is.na(data_italy[,paste("dummy", sep = "_", i)])),]
    
    # Get Outcome Vector
    y <- as.vector(data_model[,paste("dummy", sep = "_", i)])
    y <- as.factor(unlist(y, use.names = FALSE))
    
    # Get Predictors Matrix
    data_model <- as.data.frame(cbind(y, data_model[,paste(lagged_predictors, sep = "_", i - 3)], data_model[,paste(predictors)]))
    
    # Generate NA Variable
    MissCount = rowSums(is.na(data_model))
    miss = rep(NA, nrow(data_model))
    miss[which(MissCount > 0 & MissCount<35)] = 1
    miss[which(MissCount==35)] = 2
    miss[which(MissCount==0)] = 0
    y <- data_model[,1]
    X <- data_model[,-1]
    X <- impute(X, object = NULL, method = "median/mode", flag = FALSE)
    X <- cbind(X, miss)
    
    # Run the model
    set.seed(42)
    bart <- bart(x.train = X, y.train = y, x.test = X, keeptrees = TRUE)
    
    pred_fun <- function(model, newdata, y) {
      #predict(model, newdata)$predictions[,2]
      pred = predict(model, newdata, mu = mean(y))
    }
    shap <- explain(bart, X = X, pred_wrapper = pred_fun, nsim = 1)
    
    
    colnames(shap) <- c(lagged_predictors, predictors, paste("miss"))
    shapley <- rbind(shapley, shap)
  }
})

write.csv(shapley,"shapley.csv", row.names = FALSE)

# Aggregate Shapley values
shap_imp <- data.frame(
  Variable = names(shapley),
  Importance = apply(shapley, MARGIN = 2, FUN = function(x) sum(abs(x)))
)

# Plot Shap-based variable importance
ggplot(shap_imp, aes(reorder(Variable, Importance), Importance)) +
  geom_col() +
  coord_flip() +
  xlab("") +
  ylab("mean(|Shapley value|)") +
  theme(text = element_text(size=20)) 

# Aggregated Predictors (OVERLAP)
sector <- c("nace")
shap_imp_sector <- data.frame(
  Variable = names(shapley[paste(sector)]),
  Importance = apply(shapley[paste(sector)], MARGIN = 2, FUN = function(x) sum(abs(x)))
)
shap_imp_sector <- sum(shap_imp_sector$Importance)

area <- c("area")
shap_imp_area <- data.frame(
  Variable = names(shapley[paste(area)]),
  Importance = apply(shapley[paste(area)], MARGIN = 2, FUN = function(x) sum(abs(x)))
)
shap_imp_area <- sum(shap_imp_area$Importance)

missingness <- c("miss")
shap_imp_miss <- data.frame(
  Variable = names(shapley[paste(missingness)]),
  Importance = apply(shapley[paste(missingness)], MARGIN = 2, FUN = function(x) sum(abs(x)))
)
shap_imp_miss <- sum(shap_imp_miss$Importance)

size <- c("total_assets", "employees", "net_income")
shap_imp_size <- data.frame(
  Variable = names(shapley[,paste(size)]),
  Importance = apply(shapley[,paste(size)], MARGIN = 2, FUN = function(x) sum(abs(x)))
)
shap_imp_size <- sum(shap_imp_size$Importance)

profitability <- c("ebitda", "profitability")
shap_imp_profitability <- data.frame(
  Variable = names(shapley[,paste(profitability)]),
  Importance = apply(shapley[,paste(profitability)], MARGIN = 2, FUN = function(x) sum(abs(x)))
)
shap_imp_profitability <- sum(shap_imp_profitability$Importance)

governance <- c("control", "consdummy")
shap_imp_governance <- data.frame(
  Variable = names(shapley[,paste(governance)]),
  Importance = apply(shapley[,paste(governance)], MARGIN = 2, FUN = function(x) sum(abs(x)))
)
shap_imp_governance <- sum(shap_imp_governance$Importance)

innovation <- c("dummy_patents", "dummy_trademark")
shap_imp_innovation <- data.frame(
  Variable = names(shapley[,paste(innovation)]),
  Importance = apply(shapley[,paste(innovation)], MARGIN = 2, FUN = function(x) sum(abs(x)))
)
shap_imp_innovation <- sum(shap_imp_innovation$Importance)

productivity <- c("tfp_acf", "NEG_VA")
shap_imp_productivity <- data.frame(
  Variable = names(shapley[,paste(productivity)]),
  Importance = apply(shapley[,paste(productivity)], MARGIN = 2, FUN = function(x) sum(abs(x)))
)
shap_imp_productivity <- sum(shap_imp_productivity$Importance)

financial_constraints <- c("ICR_failure", "interest_diff", "NEG_VA", "real_SA", 
                           "misallocated_fixed", "financial_sustainability",
                           "liquidity_return", "int_fixed_assets", "fin_cons")
shap_imp_fin_cons <- data.frame(
  Variable = names(shapley[,paste(financial_constraints)]),
  Importance = apply(shapley[,paste(financial_constraints)], MARGIN = 2, FUN = function(x) sum(abs(x)))
)
shap_imp_fin_cons <- sum(shap_imp_fin_cons$Importance)

zombie_indicators <- c("ICR_failure", "NEG_VA", "interest_diff", "profitability",
                       "misallocated_fixed")
shap_imp_zombie <- data.frame(
  Variable = names(shapley[,paste(zombie_indicators)]),
  Importance = apply(shapley[,paste(zombie_indicators)], MARGIN = 2, FUN = function(x) sum(abs(x)))
)
shap_imp_zombie <- sum(shap_imp_zombie$Importance)

financial_accounts <- c("shareholders_funds", "added_value", "cash_flow", "inv",
                       "fin_rev", "liquidity_ratio", "depr", "long_term_debt", 
                       "materials", "loans", "wage_bill",  "fixed_assets", "tax",
                       "current_liabilities", "current_assets", "fin_expenses",
                       "int_paid","solvency_ratio", "revenue","capital_intensity")
shap_imp_fin_acc <- data.frame(
  Variable = names(shapley[,paste(financial_accounts)]),
  Importance = apply(shapley[,paste(financial_accounts)], MARGIN = 2, FUN = function(x) sum(abs(x)))
)
shap_imp_fin_acc <- sum(shap_imp_fin_acc$Importance)

# Group the Indicators
shap_imp_by_group <- data.frame(
  Variable = c("sector", "area", "size", "missingness", "profitability", "governance", "innovation",
               "productivity", "financial_constrains", "zombie_indicators", "financial_accounts"),
  Importance = c(shap_imp_sector, shap_imp_area, shap_imp_size, shap_imp_miss, shap_imp_profitability,
                 shap_imp_governance, shap_imp_innovation, shap_imp_productivity,
                 shap_imp_fin_cons, shap_imp_zombie, shap_imp_fin_acc)
)

# Plot Shap-based variable importance
ggplot(shap_imp_by_group, aes(reorder(Variable, Importance), Importance)) +
  geom_col() +
  coord_flip() +
  xlab("") +
  ylab("mean(|Shapley value|)")

# Aggregated Predictors (NON-OVERLAP)
sector <- c("nace")
shap_imp_sector <- data.frame(
  Variable = names(shapley[paste(sector)]),
  Importance = apply(shapley[paste(sector)], MARGIN = 2, FUN = function(x) sum(abs(x)))
)
shap_imp_sector <- sum(shap_imp_sector$Importance)

area <- c("area")
shap_imp_area <- data.frame(
  Variable = names(shapley[paste(area)]),
  Importance = apply(shapley[paste(area)], MARGIN = 2, FUN = function(x) sum(abs(x)))
)
shap_imp_area <- sum(shap_imp_area$Importance)

missingness <- c("miss")
shap_imp_miss <- data.frame(
  Variable = names(shapley[paste(missingness)]),
  Importance = apply(shapley[paste(missingness)], MARGIN = 2, FUN = function(x) sum(abs(x)))
)
shap_imp_miss <- sum(shap_imp_miss$Importance)

productivity <- c("tfp_acf")
shap_imp_productivity <- data.frame(
  Variable = names(shapley[paste(productivity)]),
  Importance = apply(shapley[paste(productivity)], MARGIN = 2, FUN = function(x) sum(abs(x)))
)
shap_imp_productivity <- sum(shap_imp_productivity$Importance)

size <- c("total_assets", "employees", "net_income")
shap_imp_size <- data.frame(
  Variable = names(shapley[,paste(size)]),
  Importance = apply(shapley[,paste(size)], MARGIN = 2, FUN = function(x) sum(abs(x)))
)
shap_imp_size <- sum(shap_imp_size$Importance)

profitability <- c("ebitda", "profitability")
shap_imp_profitability <- data.frame(
  Variable = names(shapley[,paste(profitability)]),
  Importance = apply(shapley[,paste(profitability)], MARGIN = 2, FUN = function(x) sum(abs(x)))
)
shap_imp_profitability <- sum(shap_imp_profitability$Importance)

governance <- c("control", "consdummy")
shap_imp_governance <- data.frame(
  Variable = names(shapley[,paste(governance)]),
  Importance = apply(shapley[,paste(governance)], MARGIN = 2, FUN = function(x) sum(abs(x)))
)
shap_imp_governance <- sum(shap_imp_governance$Importance)

innovation <- c("dummy_patents", "dummy_trademark")
shap_imp_innovation <- data.frame(
  Variable = names(shapley[,paste(innovation)]),
  Importance = apply(shapley[,paste(innovation)], MARGIN = 2, FUN = function(x) sum(abs(x)))
)
shap_imp_innovation <- sum(shap_imp_innovation$Importance)

financial_constraints <- c("real_SA", "financial_sustainability",
                           "liquidity_return", "int_fixed_assets", "fin_cons")
shap_imp_fin_cons <- data.frame(
  Variable = names(shapley[,paste(financial_constraints)]),
  Importance = apply(shapley[,paste(financial_constraints)], MARGIN = 2, FUN = function(x) sum(abs(x)))
)
shap_imp_fin_cons <- sum(shap_imp_fin_cons$Importance)

zombie_indicators <- c("ICR_failure", "NEG_VA", "interest_diff", "profitability",
                       "misallocated_fixed")
shap_imp_zombie <- data.frame(
  Variable = names(shapley[,paste(zombie_indicators)]),
  Importance = apply(shapley[,paste(zombie_indicators)], MARGIN = 2, FUN = function(x) sum(abs(x)))
)
shap_imp_zombie <- sum(shap_imp_zombie$Importance)

financial_accounts <- c("shareholders_funds", "added_value", "cash_flow", "inv",
                        "fin_rev", "liquidity_ratio", "depr", "long_term_debt", 
                        "materials", "loans", "wage_bill",  "fixed_assets", "tax",
                        "current_liabilities", "current_assets", "fin_expenses",
                        "int_paid","solvency_ratio", "revenue","capital_intensity")
shap_imp_fin_acc <- data.frame(
  Variable = names(shapley[,paste(financial_accounts)]),
  Importance = apply(shapley[,paste(financial_accounts)], MARGIN = 2, FUN = function(x) sum(abs(x)))
)
shap_imp_fin_acc <- sum(shap_imp_fin_acc$Importance)

# Group the Indicators
shap_imp_by_group <- data.frame(
  Variable = c("sector", "area", "size", "missingness", "profitability", "governance", "innovation",
               "productivity", "financial_constrains", "zombie_indicators", "financial_accounts"),
  Importance = c(shap_imp_sector, shap_imp_area, shap_imp_size, shap_imp_miss, shap_imp_profitability,
                 shap_imp_governance, shap_imp_innovation, shap_imp_productivity,
                 shap_imp_fin_cons, shap_imp_zombie, shap_imp_fin_acc)
)

# Plot Shap-based variable importance
ggplot(shap_imp_by_group, aes(reorder(Variable, Importance), Importance)) +
  geom_col() +
  coord_flip() +
  xlab("") +
  ylab("mean(|Shapley value|)") +
  theme(text = element_text(size=30)) 

