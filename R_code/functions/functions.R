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
# r: risk free interes rate

DtD <- function(mcap, debt, vol, r){
  
  # To avoid infinite values when computing the ratio
  debt <- debt + 1 
  
  # Maturity Values
  Maturity <- 1
  
  # Values of firm's market value and its volatility
  sV <- mcap * vol / debt # This mimics the R packages ifrogs
  
  # Compute D1
  d1 <- function(mcap, debt, sV, Maturity) {
    if(which(mcap/debt<0)){
      num <- 0 + r + 0.5*sV*sV*Maturity
    }
    else{
      num <- log(mcap/debt) + r + 0.5*sV*sV*Maturity
    }
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
  if(e < 0){
    e <- 0
  }
  else{
    e <- e
  }
  
  # Return DtD
  return(e)
}