********************************************************************************
*                                                                              *
*    Table 6: productivity and size premia for zombies vs. healthy firms
*                              TIME-VARIANT VERSION
*                                                                              *
********************************************************************************

clear 

* Change working directory
cd "C:\Users\fabio\OneDrive\Documenti\GitHub\machine-learning-for-zombie-hunting\R_code\REVIEW_year_by_year_analyses" 

/*
* Update firm-level data augmented of the "overall" zombie indicator
*
* zombie indicator = 1 whether a firm has been a "Zombie" (i.e. = 1) in at least one year (2011-2017) 
*                    0 otherwise

use "data_zombie_indicator_time_variant.dta", clear

* Create categorical variable for each combination of industry-region 
egen industry_region = group(nace region)

* Generate numeric identifier 
egen id_new = group(id)

* Reshape data from wide --> long for panel regression
reshape long tfp_acf_ labour_product_ revenue_ employees_ zombie_indicator_,  i(id) j(year 2008 2009 2010 2011 2012 2013 2014 2015 2016)

* Save longitudinal format
save "data_zombie_indicator_time_variant_long_format.dta"
*/

use "data_zombie_indicator_time_variant_long_format.dta", clear

********************************* TFP *******************************************************************

preserve 

* Drop observations missing in TFP
drop if missing(tfp_acf_)

* TFP --> NO additional log: it is already in log
g tfp_acf_panel_log = tfp_acf_
eststo pooled_tfp: quietly reg tfp_acf_panel_log zombie_indicator_ i.industry_region, vce(cluster industry_region) 
esttab pooled_tfp, equations(1) se pr2 b(3) stats(r2_a N, fmt(3 0) labels("Adj. R Squared" "N. obs")) keep(zombie_indicator_) 

restore 

/*
----------------------------
                      (1)   
             tfp_acf_pa~g   
----------------------------
#1                          
zombie_ind~_       -0.197***
                  (0.037)   
----------------------------
Adj. R Squ~d        0.967   
N. obs             600771   
----------------------------
*/


********************************** LABOUR PRODUCTIVITY *************************************************** 
preserve

* Drop observations missing in labour productivity
drop if missing(labour_product_)

g labour_prod_panel_log = log(labour_product_)
eststo pooled_labour_product: quietly reg labour_prod_panel_log zombie_indicator_ i.industry_region, vce(cluster industry_region) 
esttab pooled_labour_product, equations(1) se pr2 b(3) stats(r2_a N, fmt(3 0) labels("Adj. R Squared" "N. obs")) keep(zombie_indicator_) 

restore 

/*
----------------------------
                      (1)   
             labour_pro~g   
----------------------------
#1                          
zombie_ind~_       -0.450***
                  (0.014)   
----------------------------
Adj. R Squ~d        0.110   
N. obs             559315   
----------------------------
Standard errors in parentheses
* p<0.05, ** p<0.01, *** p<0.001
*/



********************************************** SALES *****************************************************  
preserve 

* Drop observations missing in sales
drop if missing(revenue_)

g revenue_panel_log = log(revenue_)
eststo pooled_revenue: quietly reg revenue_panel_log zombie_indicator_ i.industry_region, vce(cluster industry_region) 
esttab pooled_revenue, equations(1) se pr2 b(3) stats(r2_a N, fmt(3 0) labels("Adj. R Squared" "N. obs")) keep(zombie_indicator_) 

restore 

/*
----------------------------
                      (1)   
             revenue_pa~g   
----------------------------
#1                          
zombie_ind~_       -2.066***
                  (0.053)   
----------------------------
Adj. R Squ~d        0.116   
N. obs            1234750   
----------------------------
Standard errors in parentheses
* p<0.05, ** p<0.01, *** p<0.001
*/






******************************************** EMPLOYEES *****************************************
preserve

* Drop observations missing in sales
drop if missing(employees_)

g employees_panel_log = log(employees_)
eststo pooled_employees: quietly reg employees_panel_log zombie_indicator_ i.industry_region, vce(cluster industry_region)
esttab pooled_employees, equations(1) se pr2 b(3) stats(r2_a N, fmt(3 0) labels("Adj. R Squared" "N. obs")) keep(zombie_indicator_) 

restore

/*
----------------------------
                      (1)   
             employees_~g   
----------------------------
#1                          
zombie_ind~_       -0.170***
                  (0.039)   
----------------------------
Adj. R Squ~d        0.157   
N. obs            1119486   
----------------------------
Standard errors in parentheses
* p<0.05, ** p<0.01, *** p<0.001
*/


* Overall table
esttab pooled_tfp pooled_labour_product pooled_revenue pooled_employees, equations(1) se pr2 b(3) stats(r2_a N, fmt(3 0) labels("Adj. R Squared" "N. obs")) keep(zombie_indicator_) 

/*
----------------------------------------------------------------------------
                      (1)             (2)             (3)             (4)   
             tfp_acf_pa~g    labour_pro~g    revenue_pa~g    employees_~g   
----------------------------------------------------------------------------
#1                                                                          
zombie_ind~_       -0.197***       -0.450***       -2.066***       -0.170***
                  (0.037)         (0.014)         (0.053)         (0.039)   
----------------------------------------------------------------------------
Adj. R Squ~d        0.967           0.110           0.116           0.157   
N. obs             600771          559315         1234750         1119486   
----------------------------------------------------------------------------
Standard errors in parentheses
* p<0.05, ** p<0.01, *** p<0.001


*/

