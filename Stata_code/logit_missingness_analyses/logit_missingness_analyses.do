********************************************************************************
*                                                                              *
*        Logit Analyses for "Machine Learning for Zombie Hunting" paper        *
*                                                                              *
********************************************************************************


use "zombie_data.dta", clear
keep if iso=="IT"


gen missing_ICR_2016= missing(ICR_2016)
gen missing_ICR_2015=missing(ICR_2015)
gen missing_ICR_2014=missing(ICR_2014)
egen missing_ICR=rowmax(missing_ICR*)

gen missing_interest_diff_2016= missing(interest_diff_2016)
gen missing_interest_diff_2015=missing(interest_diff_2015)
gen missing_interest_diff_2014=missing(interest_diff_2014)
egen missing_interest_diff=rowmax(missing_interest_diff*)

gen missing_profitability_2016= missing(profitability_2016)
gen missing_profitability_2015=missing(profitability_2015)
gen missing_profitability_2014=missing(profitability_2014)
egen missing_profitability=rowmax(missing_profitability*)

gen missing_Z_2016= missing(Z_2016)
gen missing_Z_2015=missing(Z_2015)
gen missing_Z_2014=missing(Z_2014)
egen missing_Z=rowmax(missing_Z*)

gen missing_NEG_VA_2016= missing(NEG_VA_2016)
gen missing_NEG_VA_2015=missing(NEG_VA_2015)
gen missing_NEG_VA_2014=missing(NEG_VA_2014)
egen missing_NEG_VA=rowmax(missing_NEG_VA*)

gen missing_tfp_acf_2016= missing(tfp_acf_2016)
gen missing_tfp_acf_2015=missing(tfp_acf_2015)
gen missing_tfp_acf_2014=missing(tfp_acf_2014)
egen missing_tfp_acf=rowmax(missing_tfp_acf*)

gen missing_real_SA_2016= missing(real_SA_2016)
gen missing_real_SA_2015=missing(real_SA_2015)
gen missing_real_SA_2014=missing(real_SA_2014)


xi: logit failure_2017 missing_ICR i.nace i.nuts2, or cluster(nace)
xi: logit failure_2017 missing_interest_diff i.nace i.nuts2, or cluster(nace)
xi: logit failure_2017 missing_profitability i.nace i.nuts2, or cluster(nace)
xi: logit failure_2017 missing_Z i.nace i.nuts2, or cluster(nace)
xi: logit failure_2017 missing_tfp_acf i.nace i.nuts2, or cluster(nace)
xi: logit failure_2017 missing_NEG_VA i.nace i.nuts2, or cluster(nace)
