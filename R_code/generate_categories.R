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

# Set Working Directory
setwd('G:\\Il mio Drive\\Research\\Italian Firms\\Zombie Hunting New Data')

# Upload Data
data <- read_dta("data_probabilities.dta")

# Get Country Specific Data
data_italy <- data[which(data$iso=="IT"),] 
data_spain <- data[which(data$iso=="ES"),] 
data_france <- data[which(data$iso=="FR"),] 
data_portugal <- data[which(data$iso=="PT"),] 

# Construct Zombie Indicator
## Italy
years <- c(2009:2017)
cat <- matrix(NA, ncol = length(years), nrow = nrow(data))
for (i in (years)){
  # Subset data by Year
  data_model <- data_italy[which(!is.na(data_italy[,paste("prob", sep = "_", i)])),]
  
  # Select the Probability Variable
  fitted <- as.matrix(data_model[,paste("prob", sep = "_", i)])
  
  # Generate Category Variable
  cat[which(!is.na(data_italy[,paste("prob", sep = "_", i)])),which(years==i)] <- quantcut(fitted, c(0,0.6,seq(0.7,1,0.1)), labels=c("0","4","3","2","1"))
  
  # Clean Workspace
  rm(fitted, data_model)
}

## Spain
for (i in (years)){
  # Subset data by Year
  data_model <- data_spain[which(!is.na(data_spain[,paste("prob", sep = "_", i)])),]
  
  # Select the Probability Variable
  fitted <- as.matrix(data_model[,paste("prob", sep = "_", i)])
  
  # Generate Category Variable
  cat[which(!is.na(data_spain[,paste("prob", sep = "_", i)])),which(years==i)] <- quantcut(fitted, c(0,0.6,seq(0.7,1,0.1)), labels=c("0","4","3","2","1"))
  
  # Clean Workspace
  rm(fitted, data_model)
}


## France
for (i in (years)){
  # Subset data by Year
  data_model <- data_france[which(!is.na(data_france[,paste("prob", sep = "_", i)])),]
  
  # Select the Probability Variable
  fitted <- as.matrix(data_model[,paste("prob", sep = "_", i)])
  
  # Generate Category Variable
  cat[which(!is.na(data_france[,paste("prob", sep = "_", i)])),which(years==i)] <- quantcut(fitted, c(0,0.6,seq(0.7,1,0.1)), labels=c("0","4","3","2","1"))
  
  # Clean Workspace
  rm(fitted, data_model)
}


## Portugal
for (i in (years)){
  # Subset data by Year
  data_model <- data_portugal[which(!is.na(data_portugal[,paste("prob", sep = "_", i)])),]
  
  # Select the Probability Variable
  fitted <- as.matrix(data_model[,paste("prob", sep = "_", i)])
  
  # Generate Category Variable
  cat[which(!is.na(data_portugal[,paste("prob", sep = "_", i)])),which(years==i)] <- quantcut(fitted, c(0,0.6,seq(0.7,1,0.1)), labels=c("0","4","3","2","1"))
  
  # Clean Workspace
  rm(fitted, data_model)
}



