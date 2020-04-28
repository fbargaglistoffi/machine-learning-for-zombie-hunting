######################################################################################
##                                                                                  ##
##        Code for Plots for the "Machine Learning for Zombie Hunting" paper        ##
##                           Falco J. Bargagli-Stoffi                               ##
##                                                                                  ##
##                                                                                  ##
######################################################################################

# Bar plot for zombies over years
rm(list=ls())
library(ggplot2)
library(dplyr)
library(tidyr)


# Create the input vectors.
colors = c("red","brown","grey", "gray88")
years <- c("2011","2012","2013","2014","2015", "2016")
status <- c("Failed","Zombie","Distressed", "Not distressed")

# Create the matrix of the values.
Values <- matrix(c(2927,3209,3639,3718,3336,2056,
                   3368,3675,4133,3766,3932,4029,
                   977,923,1007,1340, 1251, 794,
                   6, 3, 3, 3, 2, 0),
                 nrow = 4, ncol = 6, byrow = TRUE)

# Plot layout
layout(matrix(c(1,2), ncol=1, nrow=2, byrow=TRUE), heights=c(2.5, 1))

# Create the bar chart
par(mar=c(5.1, 4.1, 4.1, 5.1), xpd=TRUE)
barplot(prop.table(Values,2), names.arg = years, xlab = "Year", ylab = "% share", col = colors)

# Add the legend to the chart
par(mai=c(0,0,0,0))
plot.new()
legend("center", status, cex = 1.3, fill = colors)


