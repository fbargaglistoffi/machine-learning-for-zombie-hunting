######################################################################################
##                                                                                  ##
##  Generating Zombie Indicator for the "Machine Learning for Zombie Hunting" paper ##
##                           Falco J. Bargagli-Stoffi                               ##
##                                                                                  ##
##                                                                                  ##
######################################################################################

# Get Envirnoment Ready
rm(list=ls()) 
memory.limit(size=1000000)
options(java.parameters = "-Xmx15000m")
library(haven)
library(BART)
library(ggplot2)
library(gtools)
library(labelVector)

# Set Working Directory
#setwd('G:\\Il mio Drive\\Research\\Italian Firms\\Zombie Hunting New Data')
setwd("/home/falco.bargaglistoffi/Desktop/R_files/zombie_hunting/Working_Data/")

# Upload Data
data <- read_dta("data_probabilities.dta")

# Get Country Specific Data
data_italy <- data[which(data$iso=="IT"),] 
data_spain <- data[which(data$iso=="ES"),] 
data_france <- data[which(data$iso=="FR"),] 
data_portugal <- data[which(data$iso=="PT"),] 

# Construct Categories
## Italy
years <- c(2009:2017)
data_italy$cat <- matrix(NA, ncol = length(years), nrow = nrow(data_italy))
for (i in (years)){
  # Subset data by Year
  data_model <- data_italy[which(!is.na(data_italy[,paste("prob", sep = "_", i)])),]
  
  # Select the Probability Variable
  fitted <- as.matrix(data_model[,paste("prob", sep = "_", i)])
  
  # Generate Category Variable
  data_italy$cat[which(!is.na(data_italy[,paste("prob", sep = "_", i)])),which(years==i)] <- quantcut(fitted, c(0,0.6,seq(0.7,1,0.1)), labels=c("0","4","3","2","1"))
  
  # Clean Workspace
  rm(fitted, data_model)
}


## Spain
data_spain$cat <- matrix(NA, ncol = length(years), nrow = nrow(data_spain))
for (i in (years)){
  # Subset data by Year
  data_model <- data_spain[which(!is.na(data_spain[,paste("prob", sep = "_", i)])),]
  
  # Select the Probability Variable
  fitted <- as.matrix(data_model[,paste("prob", sep = "_", i)])
  
  # Generate Category Variable
  data_spain$cat[which(!is.na(data_spain[,paste("prob", sep = "_", i)])),which(years==i)] <- quantcut(fitted, c(0,0.6,seq(0.7,1,0.1)), labels=c("0","4","3","2","1"))
  
  # Clean Workspace
  rm(fitted, data_model)
}


## France
data_france$cat <- matrix(NA, ncol = length(years), nrow = nrow(data_france))
for (i in (years)){
  # Subset data by Year
  data_model <- data_france[which(!is.na(data_france[,paste("prob", sep = "_", i)])),]
  
  # Select the Probability Variable
  fitted <- as.matrix(data_model[,paste("prob", sep = "_", i)])
  
  # Generate Category Variable
  data_france$cat[which(!is.na(data_france[,paste("prob", sep = "_", i)])),which(years==i)] <- quantcut(fitted, c(0,0.6,seq(0.7,1,0.1)), labels=c("0","4","3","2","1"))
  
  # Clean Workspace
  rm(fitted, data_model)
}


## Portugal
data_portugal$cat <- matrix(NA, ncol = length(years), nrow = nrow(data_portugal))
for (i in (years)){
  # Subset data by Year
  data_model <- data_portugal[which(!is.na(data_portugal[,paste("prob", sep = "_", i)])),]
  
  # Select the Probability Variable
  fitted <- as.matrix(data_model[,paste("prob", sep = "_", i)])
  
  # Generate Category Variable
  data_portugal$cat[which(!is.na(data_portugal[,paste("prob", sep = "_", i)])),which(years==i)] <- quantcut(fitted, c(0,0.6,seq(0.7,1,0.1)), labels=c("0","4","3","2","1"))
  
  # Clean Workspace
  rm(fitted, data_model)
}

cat_data <- rbind(data_italy, data_spain, data_portugal, data_france)

# Rename Labels
cat_data$cat[ cat_data$cat == 1 ] <- 0
cat_data$cat[ cat_data$cat == 5 ] <- 1
cat_data$cat[ cat_data$cat == 4 ] <- 5
cat_data$cat[ cat_data$cat == 2 ] <- 4
cat_data$cat[ cat_data$cat == 5 ] <- 2

# Rename
cat_data$cat_2009 <- cat_data$cat[,1]
cat_data$cat_2010 <- cat_data$cat[,2]
cat_data$cat_2011 <- cat_data$cat[,3]
cat_data$cat_2012 <- cat_data$cat[,4]
cat_data$cat_2013 <- cat_data$cat[,5]
cat_data$cat_2014 <- cat_data$cat[,6]
cat_data$cat_2015 <- cat_data$cat[,7]
cat_data$cat_2016 <- cat_data$cat[,8]
cat_data$cat_2017 <- cat_data$cat[,9]

# Save Overall Data
write_dta(cat_data, "data_categories.dta")
