######################################################################################
##                                                                                  ##
##     Predictive Analysis for the "Machine Learning for Zombie Hunting" paper      ##
##                           Falco J. Bargagli-Stoffi                               ##
##                                                                                  ##
##                                                                                  ##
######################################################################################

rm(list=ls()) # to clean the memeory

# Set Working Directory
setwd('G:\\Il mio Drive\\Research\\Italian Firms\\Zombie Hunting New Data')

# Upload Libraries and Functions
library(haven)
source('functions.R')

# Upload Data
data <- read_dta("zombie_data.dta")

# 2009
seq <- seq(0.01, 0.2, 0.01)
out <- matrix(NA, ncol=2, nrow=length(seq))
for (i in (seq)){
  pred <- ifelse(data$prob_2009>i, 1,0)
  score <- f1_score(pred, data$failure_2009, "1")
  out[which(seq==i), 1:2] <- cbind(as.numeric(i), score)
}

out
out[,1][which.max(out[,2])]
data$pred_2009 <- ifelse(data$prob_2009>out[,1][which.max(out[,2])],1, 0)

# 2010
seq <- seq(0.01, 0.2, 0.01)
out <- matrix(NA, ncol=2, nrow=length(seq))
for (i in (seq)){
  pred <- ifelse(data$prob_2010>i, 1,0)
  score <- f1_score(pred, data$failure_2010, "1")
  out[which(seq==i), 1:2] <- cbind(as.numeric(i), score)
}

out
max(out[,2])
out[,1][which.max(out[,2])]
data$pred_2010 <- ifelse(data$prob_2010>out[,1][which.max(out[,2])],1, 0)

# 2011
seq <- seq(0.01, 0.3, 0.01)
out <- matrix(NA, ncol=2, nrow=length(seq))
for (i in (seq)){
  pred <- ifelse(data$prob_2011>i, 1,0)
  score <- f1_score(pred, data$failure_2011, "1")
  out[which(seq==i), 1:2] <- cbind(as.numeric(i), score)
}

out
max(out[,2])
out[,1][which.max(out[,2])]
data$pred_2011 <- ifelse(data$prob_2011>out[,1][which.max(out[,2])],1, 0)

# 2012
seq <- seq(0.01, 0.3, 0.01)
out <- matrix(NA, ncol=2, nrow=length(seq))
for (i in (seq)){
  pred <- ifelse(data$prob_2012>i, 1,0)
  score <- f1_score(pred, data$failure_2012, "1")
  out[which(seq==i), 1:2] <- cbind(as.numeric(i), score)
}

out
max(out[,2])
out[,1][which.max(out[,2])]
data$pred_2012 <- ifelse(data$prob_2012>out[,1][which.max(out[,2])],1, 0)

# 2013
seq <- seq(0.01, 0.3, 0.01)
out <- matrix(NA, ncol=2, nrow=length(seq))
for (i in (seq)){
  pred <- ifelse(data$prob_2013>i, 1,0)
  score <- f1_score(pred, data$failure_2013, "1")
  out[which(seq==i), 1:2] <- cbind(as.numeric(i), score)
}

out
max(out[,2])
out[,1][which.max(out[,2])]
data$pred_2013 <- ifelse(data$prob_2013>out[,1][which.max(out[,2])],1, 0)

# 2014
seq <- seq(0.01, 0.3, 0.01)
out <- matrix(NA, ncol=2, nrow=length(seq))
for (i in (seq)){
  pred <- ifelse(data$prob_2014>i, 1,0)
  score <- f1_score(pred, data$failure_2014, "1")
  out[which(seq==i), 1:2] <- cbind(as.numeric(i), score)
}

out
max(out[,2])
out[,1][which.max(out[,2])]
data$pred_2014 <- ifelse(data$prob_2014>out[,1][which.max(out[,2])],1, 0)

# 2015
seq <- seq(0.01, 0.5, 0.01)
out <- matrix(NA, ncol=2, nrow=length(seq))
for (i in (seq)){
  pred <- ifelse(data$prob_2015>i, 1,0)
  score <- f1_score(pred, data$failure_2015, "1")
  out[which(seq==i), 1:2] <- cbind(as.numeric(i), score)
}

out
max(out[,2])
out[,1][which.max(out[,2])]
data$pred_2015 <- ifelse(data$prob_2015>out[,1][which.max(out[,2])],1, 0)

# 2016
seq <- seq(0.01, 0.5, 0.01)
out <- matrix(NA, ncol=2, nrow=length(seq))
for (i in (seq)){
  pred <- ifelse(data$prob_2016>i, 1,0)
  score <- f1_score(pred, data$failure_2016, "1")
  out[which(seq==i), 1:2] <- cbind(as.numeric(i), score)
}

out
max(out[,2])
out[,1][which.max(out[,2])]
data$pred_2016 <- ifelse(data$prob_2016>out[,1][which.max(out[,2])],1, 0)

# 2017
seq <- seq(0.01, 0.5, 0.01)
out <- matrix(NA, ncol=2, nrow=length(seq))
for (i in (seq)){
  pred <- ifelse(data$prob_2017>i, 1,0)
  score <-f1_score(pred, data$failure_2017, "1")
  out[which(seq==i), 1:2] <- cbind(as.numeric(i), score)
}

out
max(out[,2])
out[,1][which.max(out[,2])]
data$pred_2017 <- ifelse(data$prob_2017>out[,1][which.max(out[,2])],1, 0)

# Save Data
write_dta(data, "zombie_data.dta")