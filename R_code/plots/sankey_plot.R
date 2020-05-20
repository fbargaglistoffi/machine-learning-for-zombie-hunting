rm(list=ls()) # to clean the memeory
library(haven)
library(Gmisc)
library(RColorBrewer)

setwd("G:\\Il mio Drive\\Research\\Italian Firms\\Zombie Hunting New Data")
data <- read_dta("zombie_data.dta")
data_italy <- data[which(data$iso=="IT"),] 



data_italy$transition_2010 <- data_italy$cat_2010
data_italy$transition_2010[which(data_italy$transition_2010==0)] <- 5
data_italy$transition_2011 <- data_italy$cat_2011
data_italy$transition_2011[which(data_italy$transition_2011==0)] <- 5
data_italy$transition_2011[which(data_italy$transition_2011==5)][1:4537] <- 3


trn_mtrx <-
  with(data,
       table(data_italy$transition_2010, 
             data_italy$transition_2011))

# 9th decile: 0.59% remain in the same risk category
# 8th decile: 0.35% remain in the same risk category
# 7th decile: 0.28% remain in the same risk category
# 6th decile: 0.17% remain in the same risk category

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


