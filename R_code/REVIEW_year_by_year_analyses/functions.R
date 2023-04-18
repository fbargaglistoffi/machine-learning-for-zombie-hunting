######################################################################################
##                                                                                  ##
##          Functions for the "Machine Learning for Zombie Hunting" paper           ##
##                           Falco J. Bargagli-Stoffi                               ##
##                                                                                  ##
##                                                                                  ##
######################################################################################


## F1- Score
# predicted: vector of predicted values
# expected: vector of observed value
# positive.class: class of binary predictions we are mostly interested in (e.g., "1", "0")

f1_score <- function(predicted, expected, positive.class) {
  
  # Generate Confusion Matrix
  c.matrix = as.matrix(table(expected, predicted))
  
  # Compute Precision
  precision <- diag(c.matrix) / colSums(c.matrix)
  
  # Compute Recall
  recall <- diag(c.matrix) / rowSums(c.matrix)
  
  # Compute F-1 Score
  f1 <-  ifelse(precision + recall == 0, 0, 2 * precision * recall / (precision + recall))
  
  # Extract F1-score for the pre-defined "positive class"
  f1 <- f1[positive.class]
  
  # Assuming that F1 is zero when it's not possible compute it
  f1[is.na(f1)] <- 0
  
  # Return F1-score
  return(f1)
}

## Balanced Accuracy (BACC)
# predicted: vector of predicted values
# expected: vector of observed value

balanced_accuracy <- function(predicted, expected) {
  
  # Generate Confusion Matrix
  c.matrix = as.matrix(table(predicted, expected))
  
  # First Row Generation
  first.row <- c.matrix[1,1] / (c.matrix[1,1] + c.matrix[1,2])  
  
  # Second Row Generation
  second.row <- c.matrix[2,2] / (c.matrix[2,1] + c.matrix[2,2])  
  
  # # "Balanced" proportion correct (you can use different weighting if needed)
  acc <- (first.row + second.row)/2 
  
  # Return Balanced Accuracy
  return(acc)
}

## Model Compare (Precision and False Discovery Rate [FDR])
# predicted: vector of predicted values
# expected: vector of observed value
# positive.class: class of binary predictions we are mostly interested in (e.g., "1", "0")

model_compare <- function(predicted, expected, positive.class) {
  
  # Generate Confusion Matrix
  c.matrix = as.matrix(table(expected, predicted))
  
  # Precision
  precision <- diag(c.matrix) / colSums(c.matrix)
  precision <- precision[positive.class]
  
  # False Discovery Rate
  fdr <- c.matrix[1,2]/(c.matrix[1,2] + c.matrix[2,2])
  
  # Return Precision and False Discovery Rate (FDR)
  return(c(precision, fdr))
}

## Merton's Distance to Default (DtD)
# mcap: value of company assets
# debt: debt of the firm
# vol: equity volatility 
# r: risk free interest rate

DtD <- function(mcap, debt, vol, r){
  
  # To avoid infinite values when computing the ratio
  debt <- debt + 1 
  
  # Maturity Values
  Maturity <- 1
  
  # Values of firm's market value and its volatility
  sV <- mcap * vol / debt # This mimics the R packages ifrogs
  
  # Compute D1
  d1 <- function(mcap, debt, sV, Maturity) {
    # if(which(mcap/debt<0)){
    #   num <- 0 + r + 0.5*sV*sV*Maturity
    # }
    # else{
    #   num <- log(mcap/debt) + r + 0.5*sV*sV*Maturity
    # }
    
    num <- ifelse(mcap/debt < 0, (0 + r + 0.5*sV*sV*Maturity), (log(mcap/debt) + r + 0.5*sV*sV*Maturity) )
    den <- sV * sqrt(Maturity)
    num/den
  }
  
  # Compute D2
  d2 <- function(mcap, debt, sV, Maturity) {
    d1(mcap, debt, sV, Maturity) -     sV*sqrt(Maturity)
  }
  
  # Compute DtD
  e <- mcap*pnorm(d1(mcap, debt, sV, Maturity)) - debt*pnorm(d2(mcap, debt, sV, Maturity))*exp(-r)
  
  # Save Positive Values
  # if(e < 0){
  #   e <- 0
  # }
  # else{
  #   e <- e
  # }
  e <- ifelse(e<0, 0, e)
  
  # Return DtD
  return(e)
}



#############################################################################################################
# Compute correlations when many columns are available
# 
# See: https://towardsdatascience.com/how-to-create-a-correlation-matrix-with-too-many-variables-309cc0c0a57

# df = dataframe of interest
# sig = lower bound for correlation we want to display

 

corr_simple <- function(data, sig){
  #convert data to numeric in order to run correlations
  #convert to factor first to keep the integrity of the data - each value will become a number rather than turn into NA
  df_cor <- data %>% mutate_if(is.character, as.factor)
  df_cor <- df_cor %>% mutate_if(is.factor, as.numeric)  #run a correlation and drop the insignificant ones
  corr <- cor(df_cor)
  #prepare to drop duplicates and correlations of 1     
  corr[lower.tri(corr,diag=TRUE)] <- NA 
  #drop perfect correlations
  corr[corr == 1] <- NA   #turn into a 3-column table
  corr <- as.data.frame(as.table(corr))
  #remove the NA values from above 
  corr <- na.omit(corr)   #select significant values  
  corr <- subset(corr, abs(Freq) > sig) 
  #sort by highest correlation
  corr <- corr[order(-abs(corr$Freq)),]   #print table
  print(corr)  #turn corr back into matrix in order to plot with corrplot
  mtx_corr <- reshape2::acast(corr, Var1~Var2, value.var="Freq")
  
  #plot correlations visually
  corrplot(mtx_corr, is.corr=FALSE, tl.col="black", na.label=" ")
}






#################################################################################################
# Create yearly failure indicator
failure_yearly <- function(data){
  
  
  # Costruisco una matrice con numero di righe = nrow(data) e colonne 2009, ... , 2017
  years <- c(2009:2017)
  failed <- matrix(NA, ncol = length(years), nrow = nrow(data))
  
  # YEARLY FAILURE INDICATOR FOR OBS NON MISSING IN YEAR OF INCORPORATION  
  for (i in (years)){
    if(i==2009){  
      
      # Se l'anno di costituzione <= 2012: 0 --> failure_2012
      failed[ , which(years==i)][which(!is.na(data$year_of_incorporation) 
                                       & data$year_of_incorporation <= i)] <- 0 
      
      # Se l'anno di costituzione <= 2012 + anno di status=2012 : 1 --> failure_2012 
      failed[,which(years==i)][which(!is.na(data$year_of_incorporation) 
                                     & data$year_of_status == i 
                                     & data$year_of_incorporation<= i)] <- 1 
      # NB: if year of incorporation is after 2012: failed_2012 = NaN
    }
    
    
    if(i==2010){  
      
      failed[,which(years==i)][which(!is.na(data$year_of_incorporation) # Check you're not missing in the year of incorporation 
                                     & data$year_of_incorporation <= i  # Check year of incorporation is not after 2013
                                     & (failed[,which(years==i-1)]!=1 | is.na(failed[,which(years==i-1)])) )]  <- 0 
      # Check you're not failed in 2010
      # or you're born in subsequent years, i.e. you're NaN in failed_2010
      
      failed[,which(years==i)][which(!is.na(data$year_of_incorporation) 
                                     & data$year_of_status == i 
                                     & data$year_of_incorporation<= i)] <- 1
    }
    
    if(i==2011){  
      
      failed[,which(years==i)][which(!is.na(data$year_of_incorporation)    # Check you're not missing in the year of incorporation 
                                     & data$year_of_incorporation <= i     # Check year of incorporation is not after 2014
                                     & (failed[,which(years==i-1)]!=1 | is.na(failed[,which(years==i-1)])) 
                                     & (failed[,which(years==i-2)]!=1 | is.na(failed[,which(years==i-2)]))  )]    <- 0
      
      
      failed[,which(years==i)][which(!is.na(data$year_of_incorporation) 
                                     & data$year_of_status == i 
                                     & data$year_of_incorporation<= i)] <- 1
    }
    
    
    if(i==2012){  
      
      failed[,which(years==i)][which(!is.na(data$year_of_incorporation) 
                                     & data$year_of_incorporation <= i 
                                     & (failed[,which(years==i-1)]!=1 | is.na(failed[,which(years==i-1)])) 
                                     & (failed[,which(years==i-2)]!=1 | is.na(failed[,which(years==i-2)]))  
                                     & (failed[,which(years==i-3)]!=1 | is.na(failed[,which(years==i-3)])) )]    <- 0
      
      
      failed[,which(years==i)][which(!is.na(data$year_of_incorporation) 
                                     & data$year_of_status == i 
                                     & data$year_of_incorporation<= i)] <- 1
    }
    
    
    
    if(i==2013){  
      
      failed[,which(years==i)][which(!is.na(data$year_of_incorporation) 
                                     & data$year_of_incorporation <= i 
                                     & (failed[,which(years==i-1)]!=1 | is.na(failed[,which(years==i-1)])) 
                                     & (failed[,which(years==i-2)]!=1 | is.na(failed[,which(years==i-2)]))  
                                     & (failed[,which(years==i-3)]!=1 | is.na(failed[,which(years==i-3)]))
                                     & (failed[,which(years==i-4)]!=1 | is.na(failed[,which(years==i-4)])) )]    <- 0
      
      
      failed[,which(years==i)][which(!is.na(data$year_of_incorporation) 
                                     & data$year_of_status == i 
                                     & data$year_of_incorporation<= i)] <- 1
    }
    
    if(i==2014){  
      
      failed[,which(years==i)][which(!is.na(data$year_of_incorporation) 
                                     & data$year_of_incorporation <= i 
                                     & (failed[,which(years==i-1)]!=1 | is.na(failed[,which(years==i-1)])) 
                                     & (failed[,which(years==i-2)]!=1 | is.na(failed[,which(years==i-2)]))  
                                     & (failed[,which(years==i-3)]!=1 | is.na(failed[,which(years==i-3)]))
                                     & (failed[,which(years==i-4)]!=1 | is.na(failed[,which(years==i-4)]))
                                     & (failed[,which(years==i-5)]!=1 | is.na(failed[,which(years==i-5)])))]    <- 0
      
      
      failed[,which(years==i)][which(!is.na(data$year_of_incorporation) 
                                     & data$year_of_status == i 
                                     & data$year_of_incorporation<= i)] <- 1
    }
    
    if(i==2015){  
      
      failed[,which(years==i)][which(!is.na(data$year_of_incorporation) 
                                     & data$year_of_incorporation <= i 
                                     & (failed[,which(years==i-1)]!=1 | is.na(failed[,which(years==i-1)])) 
                                     & (failed[,which(years==i-2)]!=1 | is.na(failed[,which(years==i-2)]))  
                                     & (failed[,which(years==i-3)]!=1 | is.na(failed[,which(years==i-3)]))
                                     & (failed[,which(years==i-4)]!=1 | is.na(failed[,which(years==i-4)]))
                                     & (failed[,which(years==i-5)]!=1 | is.na(failed[,which(years==i-5)]))
                                     & (failed[,which(years==i-6)]!=1 | is.na(failed[,which(years==i-6)])))]    <- 0
      
      
      failed[,which(years==i)][which(!is.na(data$year_of_incorporation) 
                                     & data$year_of_status == i 
                                     & data$year_of_incorporation<= i)] <- 1
    }
    
    
    
    if(i==2016){  
      
      failed[,which(years==i)][which(!is.na(data$year_of_incorporation) 
                                     & data$year_of_incorporation <= i 
                                     & (failed[,which(years==i-1)]!=1 | is.na(failed[,which(years==i-1)])) 
                                     & (failed[,which(years==i-2)]!=1 | is.na(failed[,which(years==i-2)]))  
                                     & (failed[,which(years==i-3)]!=1 | is.na(failed[,which(years==i-3)]))
                                     & (failed[,which(years==i-4)]!=1 | is.na(failed[,which(years==i-4)]))
                                     & (failed[,which(years==i-5)]!=1 | is.na(failed[,which(years==i-5)]))
                                     & (failed[,which(years==i-6)]!=1 | is.na(failed[,which(years==i-6)]))
                                     & (failed[,which(years==i-7)]!=1 | is.na(failed[,which(years==i-7)]))  )]    <- 0
      
      
      
      failed[,which(years==i)][which(!is.na(data$year_of_incorporation) 
                                     & data$year_of_status == i 
                                     & data$year_of_incorporation<= i)] <- 1
    }
    
    
    if(i==2017){  
      
      failed[,which(years==i)][which(!is.na(data$year_of_incorporation) 
                                     & data$year_of_incorporation <= i 
                                     & (failed[,which(years==i-1)]!=1 | is.na(failed[,which(years==i-1)])) 
                                     & (failed[,which(years==i-2)]!=1 | is.na(failed[,which(years==i-2)]))  
                                     & (failed[,which(years==i-3)]!=1 | is.na(failed[,which(years==i-3)]))
                                     & (failed[,which(years==i-4)]!=1 | is.na(failed[,which(years==i-4)]))
                                     & (failed[,which(years==i-5)]!=1 | is.na(failed[,which(years==i-5)]))
                                     & (failed[,which(years==i-6)]!=1 | is.na(failed[,which(years==i-6)]))
                                     & (failed[,which(years==i-7)]!=1 | is.na(failed[,which(years==i-7)]))  
                                     & (failed[,which(years==i-8)]!=1 | is.na(failed[,which(years==i-8)])))]    <- 0
      
      
      failed[,which(years==i)][which( (!is.na(data$year_of_incorporation) 
                                       & data$year_of_status == 2017 | data$year_of_status == 2018) 
                                       & data$year_of_incorporation<= 2017
                                       & data$failure==1)] <- 1
    }
  }  
  
  
  
  data$failure_2009 <- failed[,1]
  data$failure_2010 <- failed[,2]
  data$failure_2011 <- failed[,3]
  data$failure_2012 <- failed[,4]
  data$failure_2013 <- failed[,5]
  data$failure_2014 <- failed[,6]
  data$failure_2015 <- failed[,7]
  data$failure_2016 <- failed[,8]  
  data$failure_2017 <- failed[,9]
  
  
  
  return(data)
  
  
  
}


