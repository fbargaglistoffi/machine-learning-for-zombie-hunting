********************************************************************************
*Zombie prediction with LASSO
clear all 
cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data"  

* Upload Data
use zombie_data, clear

* Keep just Italian Data
keep if iso=="IT"

*Zombies 2015/2017
*LASSO REGRESSION
lars dummy_2017 control consdummy area dummy_patents dummy_trademark shareholders_funds_2014 added_value_2014 cash_flow_2014 ebitda_2014 fin_rev_2014 liquidity_ratio_2014 total_assets_2014 depr_2014 long_term_debt_2014 employees_2014 materials_2014 loans_2014 wage_bill_2014 fixed_assets tax_2014 current_liabilities_2014 current_assets_2014 fin_expenses_2014 int_paid_2014 solvency_ratio_2014 net_income_2014 revenue_2014 capital_intensity_2014 fin_cons_2014 ICR_failure_2014 interest_diff_2014 NEG_VA_2014 real_SA_2014 profitability_2014 misallocated_fixed_2014 financial_sustainability_2014 liquidity_return_2014 int_fixed_assets_2014, a(lasso) cluster(nace) vce(robust) 

/* Algorithm is lasso

Cp, R-squared and Actions along the sequence of models

+-----------------------------------------------------------------------------+
| Step |      Cp     | R-square |  Action                                     |
|------+-------------+----------+---------------------------------------------|
|    1 | 64771.6718  |  0.0000  |                                             | 
|    2 |  8792.6942  |  0.3715  | +control                                    | 
|    3 |  6436.5283  |  0.3871  | +real_SA_2014                               | 
|    4 |  5965.1274  |  0.3903  | +fin_cons_2014                              | 
|    5 |  3634.0560  |  0.4058  | +ICR_failure_2014                           | 
|    6 |  2581.7768  |  0.4127  | +solvency_ratio_2014                        | 
|    7 |  2412.2959  |  0.4139  | +interest_diff_2014                         | 
|    8 |  1174.2349  |  0.4221  | +NEG_VA_2014                                | 
|    9 |  1095.2129  |  0.4227  | +consdummy                                  | 
|   10 |  1050.1216  |  0.4230  | +dummy_patents                              | 
|   11 |   724.0803  |  0.4251  | +profitability_2014                         | 
|   12 |   663.2195  |  0.4256  | +tax_2014                                   | 
|   13 |   381.0716  |  0.4274  | +shareholders_funds_2014                    | 
|   14 |   369.9156  |  0.4275  | +liquidity_ratio_2014                       | 
|   15 |   366.6173  |  0.4276  | +capital_intensity_2014                     | 
|   16 |   343.3600  |  0.4277  | +dummy_trademark                            | 
|   17 |   305.2196  |  0.4280  | +revenue_2014                               | 
|   18 |   114.8127  |  0.4293  | +loans_2014                                 | 
|   19 |   111.0402  |  0.4293  | +financial_sustainability_2014              | 
|   20 |   102.0685  |  0.4294  | +area                                       | 
|   21 |    61.0418  |  0.4297  | +long_term_debt_2014                        | 
|   22 |    61.5596  |  0.4297  | +int_fixed_assets_2014                      | 
|   23 |    53.5459  |  0.4297  | +wage_bill_2014                             | 
|   24 |    54.7547  |  0.4298  | +misallocated_fixed_2014                    | 
|   25 |    56.2945  |  0.4298  | +depr_2014                                  | 
|   26 |    54.2644  |  0.4298  | +current_assets_2014                        | 
|   27 |    47.0979  |  0.4298  | +ebitda_2014                                | 
|   28 |    46.2936  |  0.4299  | +int_paid_2014                              | 
|   29 |    33.8992  |  0.4300  | +fixed_assets                               | 
|   30 |    32.7045  |  0.4300  | +fin_expenses_2014                          | 
|   31 |    28.0695  |  0.4300  | +net_income_2014                            | 
|   32 |    23.7559 *|  0.4301  | +fin_rev_2014                               | 
|   33 |    24.5068  |  0.4301  | +materials_2014 -revenue_2014               | 
|   34 |    26.0843  |  0.4301  |                                             | 
|   35 |    27.5317  |  0.4301  | +current_liabilities_2014                   | 
|   36 |    27.8888  |  0.4301  | +liquidity_return_2014                      | 
|   37 |    29.7852  |  0.4301  | -shareholders_funds_2014 +total_assets_2014 | 
|   38 |    31.7519  |  0.4301  |                                             | 
|   39 |    33.7372  |  0.4301  | +employees_2014                             | 
|   40 |    35.4987  |  0.4301  | +shareholders_funds_2014                    | 
|   41 |    37.2765  |  0.4301  | -fixed_assets +revenue_2014                 | 
|   42 |    39.1642  |  0.4301  |                                             | 
|   43 |    41.0000  |  0.4301  | +fixed_assets                               | 
|   44 |    43.0000  |  0.4301  | +added_value_2014                           | 
|   45 |    45.0000  |  0.4301  | +cash_flow_2014                             | 
+-----------------------------------------------------------------------------+
* indicates the smallest value for Cp */

* Logit Regression
eststo: quietly logit dummy_2017 control real_SA_2014 fin_cons_2014 ICR_failure_2014 solvency_ratio_2014 interest_diff_2014 NEG_VA_2014 consdummy dummy_patents profitability_2014, cluster(nace) robust

*Zombies 2014/2016
*LASSO REGRESSION
lars dummy_2016 control consdummy area dummy_patents dummy_trademark shareholders_funds_2013 added_value_2013 cash_flow_2013 ebitda_2013 fin_rev_2013 liquidity_ratio_2013 total_assets_2013 depr_2013 long_term_debt_2013 employees_2013 materials_2013 loans_2013 wage_bill_2013 fixed_assets tax_2013 current_liabilities_2013 current_assets_2013 fin_expenses_2013 int_paid_2013 solvency_ratio_2013 net_income_2013 revenue_2013 capital_intensity_2013 fin_cons_2013 ICR_failure_2013 interest_diff_2013 NEG_VA_2013 real_SA_2013 profitability_2013 misallocated_fixed_2013 financial_sustainability_2013 liquidity_return_2013 int_fixed_assets_2013, a(lasso) cluster(nace) vce(robust)

/* Algorithm is lasso

Cp, R-squared and Actions along the sequence of models

+------------------------------------------------------------------------+
| Step |      Cp     | R-square |  Action                                |
|------+-------------+----------+----------------------------------------|
|    1 | 77682.5880  |  0.0000  |                                        | 
|    2 | 11623.2658  |  0.4169  | +control                               | 
|    3 |  7616.7993  |  0.4422  | +real_SA_2013                          | 
|    4 |  4384.4816  |  0.4626  | +ICR_failure_2013                      | 
|    5 |  3199.8879  |  0.4701  | +fin_cons_2013                         | 
|    6 |  2015.6146  |  0.4776  | +interest_diff_2013                    | 
|    7 |  1158.7221  |  0.4830  | +NEG_VA_2013                           | 
|    8 |   843.6264  |  0.4850  | +consdummy                             | 
|    9 |   667.5966  |  0.4861  | +shareholders_funds_2013               | 
|   10 |   581.0007  |  0.4867  | +profitability_2013                    | 
|   11 |   519.3604  |  0.4871  | +solvency_ratio_2013                   | 
|   12 |   461.2264  |  0.4875  | +ebitda_2013                           | 
|   13 |   360.1397  |  0.4881  | +tax_2013                              | 
|   14 |   286.7600  |  0.4886  | +revenue_2013                          | 
|   15 |   202.1983  |  0.4892  | +dummy_patents                         | 
|   16 |   185.1666  |  0.4893  | +liquidity_ratio_2013                  | 
|   17 |   175.1075  |  0.4894  | +capital_intensity_2013                | 
|   18 |   174.8708  |  0.4894  | +materials_2013                        | 
|   19 |   155.5109  |  0.4895  | +misallocated_fixed_2013               | 
|   20 |   151.4994  |  0.4895  | +long_term_debt_2013                   | 
|   21 |   152.6559  |  0.4895  | +area                                  | 
|   22 |   145.6005  |  0.4896  | -materials_2013 +int_fixed_assets_2013 | 
|   23 |   127.8465  |  0.4897  |                                        | 
|   24 |    95.5015  |  0.4899  | +current_assets_2013                   | 
|   25 |    92.8063  |  0.4900  | +liquidity_return_2013                 | 
|   26 |    67.5213  |  0.4902  | +dummy_trademark                       | 
|   27 |    68.3262  |  0.4902  | +int_paid_2013                         | 
|   28 |    62.9845  |  0.4902  | +wage_bill_2013                        | 
|   29 |    38.5795  |  0.4904  | +financial_sustainability_2013         | 
|   30 |    40.5570  |  0.4904  | +fin_rev_2013                          | 
|   31 |    41.0055  |  0.4904  | +cash_flow_2013                        | 
|   32 |    42.9978  |  0.4904  | +net_income_2013                       | 
|   33 |    39.4237  |  0.4904  | +loans_2013                            | 
|   34 |    40.8567  |  0.4904  | +fin_expenses_2013                     | 
|   35 |    40.9368  |  0.4904  | +employees_2013                        | 
|   36 |    39.1132  |  0.4905  | +current_liabilities_2013              | 
|   37 |    33.0405 *|  0.4905  | +fixed_assets                          | 
|   38 |    35.0016  |  0.4905  | +materials_2013                        | 
|   39 |    37.0000  |  0.4905  | +total_assets_2013                     | 
|   40 |    39.0000  |  0.4905  | +added_value_2013                      | 
|   41 |    41.0000  |  0.4905  | +depr_2013                             | 
+------------------------------------------------------------------------+
* indicates the smallest value for Cp

The coefficient values for the minimum Cp */ 

* Logit Regression
eststo: quietly logit dummy_2016 control real_SA_2013 ICR_failure_2013 fin_cons_2013 interest_diff_2013 NEG_VA_2013 consdummy shareholders_funds_2013 profitability_2013 solvency_ratio_2013, cluster(nace) robust

*Zombies 2013/2015
*LASSO REGRESSION
lars dummy_2015 control consdummy area dummy_patents dummy_trademark shareholders_funds_2012 added_value_2012 cash_flow_2012 ebitda_2012 fin_rev_2012 liquidity_ratio_2012 total_assets_2012 depr_2012 long_term_debt_2012 employees_2012 materials_2012 loans_2012 wage_bill_2012 fixed_assets tax_2012 current_liabilities_2012 current_assets_2012 fin_expenses_2012 int_paid_2012 solvency_ratio_2012 net_income_2012 revenue_2012 capital_intensity_2012 fin_cons_2012 ICR_failure_2012 interest_diff_2012 NEG_VA_2012 real_SA_2012 profitability_2012 misallocated_fixed_2012 financial_sustainability_2012 liquidity_return_2012 int_fixed_assets_2012, a(lasso) cluster(nace) vce(robust)

/**/ 

* Logit Regression
eststo: quietly logit dummy_2015 , cluster(nace) robust

*Zombies 2012/2014
*LASSO REGRESSION
lars dummy_2014 control consdummy area dummy_patents dummy_trademark shareholders_funds_2011 added_value_2011 cash_flow_2011 ebitda_2011 fin_rev_2011 liquidity_ratio_2011 total_assets_2011 depr_2011 long_term_debt_2011 employees_2011 materials_2011 loans_2011 wage_bill_2011 fixed_assets tax_2011 current_liabilities_2011 current_assets_2011 fin_expenses_2011 int_paid_2011 solvency_ratio_2011 net_income_2011 revenue_2011 capital_intensity_2011 fin_cons_2011 ICR_failure_2011 interest_diff_2011 NEG_VA_2011 real_SA_2011 profitability_2011 misallocated_fixed_2011 financial_sustainability_2011 liquidity_return_2011 int_fixed_assets_2011, a(lasso) cluster(nace) vce(robust)

/*

*/ 

* Logit Regression
eststo: quietly logit dummy_2014 , cluster(nace) robust

*Zombies 2011/2013
*LASSO REGRESSION
lars dummy_2013  control consdummy area dummy_patents dummy_trademark shareholders_funds_2010 added_value_2010 cash_flow_2010 ebitda_2010 fin_rev_2010 liquidity_ratio_2010 total_assets_2010 depr_2010 long_term_debt_2010 employees_2010 materials_2010 loans_2010 wage_bill_2010 fixed_assets tax_2010 current_liabilities_2010 current_assets_2010 fin_expenses_2010 int_paid_2010 solvency_ratio_2010 net_income_2010 revenue_2010 capital_intensity_2010 fin_cons_2010 ICR_failure_2010 interest_diff_2010 NEG_VA_2010 real_SA_2010 profitability_2010 misallocated_fixed_2010 financial_sustainability_2010 liquidity_return_2010 int_fixed_assets_2010, a(lasso) cluster(nace) vce(robust)

/*

*/ 

* Logit Regression
eststo: quietly logit dummy_2013 , cluster(nace) robust

*Zombies 2010/2012
*LASSO REGRESSION
lars dummy_2012 control consdummy area dummy_patents dummy_trademark shareholders_funds_2009 added_value_2009 cash_flow_2009 ebitda_2009 fin_rev_2009 liquidity_ratio_2009 total_assets_2009 depr_2009 long_term_debt_2009 employees_2009 materials_2009 loans_2009 wage_bill_2009 fixed_assets tax_2009 current_liabilities_2009 current_assets_2009 fin_expenses_2009 int_paid_2009 solvency_ratio_2009 net_income_2009 revenue_2009 capital_intensity_2009 fin_cons_2009 ICR_failure_2009 interest_diff_2009 NEG_VA_2009 real_SA_2009 profitability_2009 misallocated_fixed_2009 financial_sustainability_2009 liquidity_return_2009 int_fixed_assets_2009, a(lasso) cluster(nace) vce(robust)

/*

*/ 

* Logit Regression
eststo: quietly logit dummy_2012 , cluster(nace) robust

*Zombies 2009/2011
*LASSO REGRESSION
lars dummy_2011 control consdummy area dummy_patents dummy_trademark shareholders_funds_2008 added_value_2008 cash_flow_2008 ebitda_2008 fin_rev_2008 liquidity_ratio_2008 total_assets_2008 depr_2008 long_term_debt_2008 employees_2008 materials_2008 loans_2008 wage_bill_2008 fixed_assets tax_2008 current_liabilities_2008 current_assets_2008 fin_expenses_2008 int_paid_2008 solvency_ratio_2008 net_income_2008 revenue_2008 capital_intensity_2008 fin_cons_2008 ICR_failure_2008 NEG_VA_2008 real_SA_2008 profitability_2008 misallocated_fixed_2008 financial_sustainability_2008 liquidity_return_2008 int_fixed_assets_2008, a(lasso) cluster(nace) vce(robust)

/*

*/ 

* Logit Regression
eststo: quietly logit dummy_2011, cluster(nace) robust

esttab using logit_regressions.tex, label nostar ///
title(Logistic Regressions \label{tab1})
