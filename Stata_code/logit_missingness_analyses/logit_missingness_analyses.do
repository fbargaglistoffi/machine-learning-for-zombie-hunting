********************************************************************************
*                                                                              *
*        Logit Analyses for "Machine Learning for Zombie Hunting" paper        *
*                                                                              *
********************************************************************************

* Change path accordingly
cd "H:\.shortcut-targets-by-id\1keYb51HXkcQwzkU2kBgbnguQaqUy3umX\Zombie Hunting New Data"

* Load data from yeay-by-year analysis 
use "data_failure.dta", clear


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


xi: logit failure_2016 missing_ICR i.nace i.nuts2, or cluster(nace)
/* 
------------------------------------------------------------------------------
             |               Robust
failure_2016 | Odds ratio   std. err.      z    P>|z|     [95% conf. interval]
-------------+----------------------------------------------------------------
 missing_ICR |   5.703321    1.07283     9.26   0.000     3.944678    8.246015
*/


xi: logit failure_2016 missing_interest_diff i.nace i.nuts2, or cluster(nace)
/*
---------------------------------------------------------------------------------------
                      |               Robust
         failure_2016 | Odds ratio   std. err.      z    P>|z|     [95% conf. interval]
----------------------+----------------------------------------------------------------
missing_interest_diff |   4.088188   .7491278     7.68   0.000     2.854664    5.854728
*/


xi: logit failure_2016 missing_profitability i.nace i.nuts2, or cluster(nace)
/*
---------------------------------------------------------------------------------------
                      |               Robust
         failure_2016 | Odds ratio   std. err.      z    P>|z|     [95% conf. interval]
----------------------+----------------------------------------------------------------
missing_profitability |   5.703321    1.07283     9.26   0.000     3.944678    8.246015
*/


xi: logit failure_2016 missing_Z i.nace i.nuts2, or cluster(nace)
/*
------------------------------------------------------------------------------
             |               Robust
failure_2016 | Odds ratio   std. err.      z    P>|z|     [95% conf. interval]
-------------+----------------------------------------------------------------
   missing_Z |   10.29281   2.206031    10.88   0.000     6.762358    15.66642
*/


xi: logit failure_2016 missing_tfp_acf i.nace i.nuts2, or cluster(nace)
/*
---------------------------------------------------------------------------------
                |               Robust
   failure_2016 | Odds ratio   std. err.      z    P>|z|     [95% conf. interval]
----------------+----------------------------------------------------------------
missing_tfp_acf |   7.045051   1.220613    11.27   0.000     5.016565     9.89377
*/


xi: logit failure_2016 missing_NEG_VA i.nace i.nuts2, or cluster(nace)
/* 
--------------------------------------------------------------------------------
               |               Robust
  failure_2016 | Odds ratio   std. err.      z    P>|z|     [95% conf. interval]
---------------+----------------------------------------------------------------
missing_NEG_VA |   6.650088   1.218358    10.34   0.000     4.643862    9.523036
*/
