rm(list=ls()) # to clean the memeory
library(haven)
library(Gmisc)
library(RColorBrewer)
library(xtable)

setwd("G:\\Il mio Drive\\Research\\Italian Firms\\Zombie Hunting New Data")
data <- read_dta("zombie_data.dta")
data_italy <- data[which(data$iso=="IT"),] 

data_italy$transition_2009 <- data_italy$cat_2009
data_italy$transition_2009[which(data_italy$transition_2009==0)] <- 5
data_italy$transition_2009[which(data_italy$transition_2009==4)][1:2434] <- 3
data_italy$transition_2009[which(data_italy$transition_2009==5)][1:6059] <- 3
data_italy$transition_2010 <- data_italy$cat_2010
data_italy$transition_2010[which(data_italy$transition_2010==0)] <- 5
data_italy$transition_2011 <- data_italy$cat_2011
data_italy$transition_2011[which(data_italy$transition_2011==0)] <- 5
data_italy$transition_2012 <- data_italy$cat_2012
data_italy$transition_2012[which(data_italy$transition_2012==0)] <- 5
data_italy$transition_2013 <- data_italy$cat_2013
data_italy$transition_2013[which(data_italy$transition_2013==0)] <- 5
data_italy$transition_2014 <- data_italy$cat_2014
data_italy$transition_2014[which(data_italy$transition_2014==0)] <- 5
data_italy$transition_2015 <- data_italy$cat_2015
data_italy$transition_2015[which(data_italy$transition_2015==0)] <- 5
data_italy$transition_2016 <- data_italy$cat_2016
data_italy$transition_2016[which(data_italy$transition_2016==0)] <- 5
data_italy$transition_2017 <- data_italy$cat_2017
data_italy$transition_2017[which(data_italy$transition_2017==0)] <- 5

trn_mtrx_2010 <-
  with(data,
       table(data_italy$transition_2009, 
             data_italy$transition_2010))

trn_mtrx_2011 <-
  with(data,
       table(data_italy$transition_2010, 
             data_italy$transition_2011))

trn_mtrx_2012 <-
  with(data,
       table(data_italy$transition_2011, 
             data_italy$transition_2012))

trn_mtrx_2013 <-
  with(data,
       table(data_italy$transition_2012, 
             data_italy$transition_2013))

trn_mtrx_2014 <-
  with(data,
       table(data_italy$transition_2013, 
             data_italy$transition_2014))

trn_mtrx_2015 <-
  with(data,
       table(data_italy$transition_2014, 
             data_italy$transition_2015))

trn_mtrx_2016 <-
  with(data,
       table(data_italy$transition_2015, 
             data_italy$transition_2016))

trn_mtrx_2017 <-
  with(data,
       table(data_italy$transition_2016, 
             data_italy$transition_2017))

trn_mtrx <- trn_mtrx_2010 + trn_mtrx_2011 + trn_mtrx_2012 + trn_mtrx_2013 + trn_mtrx_2014 + trn_mtrx_2015 + trn_mtrx_2016 + trn_mtrx_2017
prop.table(trn_mtrx, 2)

# 9th decile: 0.62% remain in the same risk category
# 8th decile: 0.39% remain in the same risk category
# 7th decile: 0.29% remain in the same risk category
# 6th decile: 0.30% remain in the same risk category

# Sankey Plot
output_perc <- function(txt) sprintf("%s", txt)
box_txt <-cbind(mapply(output_perc, txt = c("9th decile", "8th decile", "7th decile", "6th decile", "Below 6th decile")), 
        mapply(output_perc, txt = c("9th decile", "8th decile", "7th decile", "6th decile", "Below 6th decile"))) 

rev(brewer.pal(5,"Reds"))
plot.new()
transitionPlot(trn_mtrx, 
               fill_start_box = c("red4", "red3", "red2", "#DE2D26", "#FB6A4A"), 
               fill_end_box = c("red4", "red3", "red2", "#DE2D26", "#FB6A4A"),
               main = "Transition plot",
               box_label = c("t", "t+1"),
               box_txt = box_txt,
               cex = 1.2,
               type_of_arrow = "gradient")


