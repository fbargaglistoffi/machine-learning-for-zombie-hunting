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
lars dummy_2017 control consdummy area dummy_patents dummy_trademark tfp_acf_2014 shareholders_funds_2014 added_value_2014 cash_flow_2014 ebitda_2014 fin_rev_2014 liquidity_ratio_2014 total_assets_2014 depr_2014 long_term_debt_2014 employees_2014 materials_2014 loans_2014 wage_bill_2014 fixed_assets tax_2014 current_liabilities_2014 current_assets_2014 fin_expenses_2014 int_paid_2014 solvency_ratio_2014 net_income_2014 revenue_2014 capital_intensity_2014 fin_cons_2014 ICR_failure_2014 interest_diff_2014 NEG_VA_2014 real_SA_2014 profitability_2014 misallocated_fixed_2014 financial_sustainability_2014 liquidity_return_2014 int_fixed_assets_2014, a(lasso) cluster(nace) vce(robust) 

/* Algorithm is lasso

Cp, R-squared and Actions along the sequence of models

+-----------------------------------------------------------------------------+
| Step |      Cp     | R-square |  Action                                     |
|------+-------------+----------+---------------------------------------------|
|    1 | 63922.8149  |  0.0000  |                                             | 
|    2 |  8717.2520  |  0.3698  | +control                                    | 
|    3 |  6354.2189  |  0.3857  | +real_SA_2014                               | 
|    4 |  5926.8316  |  0.3886  | +fin_cons_2014                              | 
|    5 |  3589.0065  |  0.4042  | +ICR_failure_2014                           | 
|    6 |  2563.4690  |  0.4111  | +solvency_ratio_2014                        | 
|    7 |  2373.2124  |  0.4124  | +interest_diff_2014                         | 
|    8 |  1171.4789  |  0.4205  | +NEG_VA_2014                                | 
|    9 |  1092.8485  |  0.4210  | +consdummy                                  | 
|   10 |  1008.6955  |  0.4216  | +dummy_patents                              | 
|   11 |   747.0872  |  0.4234  | +profitability_2014                         | 
|   12 |   662.3393  |  0.4239  | +tax_2014                                   | 
|   13 |   410.3183  |  0.4256  | +shareholders_funds_2014                    | 
|   14 |   408.7807  |  0.4257  | +capital_intensity_2014                     | 
|   15 |   394.3198  |  0.4258  | +tfp_acf_2014                               | 
|   16 |   384.8265  |  0.4259  | +liquidity_ratio_2014                       | 
|   17 |   375.7815  |  0.4259  | +dummy_trademark                            | 
|   18 |   314.3224  |  0.4264  | +revenue_2014                               | 
|   19 |   124.9022  |  0.4276  | +loans_2014                                 | 
|   20 |   120.8185  |  0.4277  | +financial_sustainability_2014              | 
|   21 |   115.1645  |  0.4277  | +area                                       | 
|   22 |    70.7918  |  0.4280  | +long_term_debt_2014                        | 
|   23 |    66.8995  |  0.4281  | +wage_bill_2014                             | 
|   24 |    66.6709  |  0.4281  | +int_fixed_assets_2014                      | 
|   25 |    64.9111  |  0.4281  | +depr_2014                                  | 
|   26 |    61.4274  |  0.4282  | +current_assets_2014                        | 
|   27 |    56.7637  |  0.4282  | +misallocated_fixed_2014                    | 
|   28 |    56.3832  |  0.4282  | +fixed_assets                               | 
|   29 |    39.1078  |  0.4283  | +ebitda_2014                                | 
|   30 |    29.2133  |  0.4284  | +int_paid_2014                              | 
|   31 |    30.9953  |  0.4284  | +net_income_2014                            | 
|   32 |    28.2231  |  0.4285  | +fin_expenses_2014                          | 
|   33 |    27.0037 *|  0.4285  | +fin_rev_2014                               | 
|   34 |    28.9963  |  0.4285  | +materials_2014                             | 
|   35 |    30.6856  |  0.4285  | +current_liabilities_2014                   | 
|   36 |    30.4859  |  0.4285  | -revenue_2014 +liquidity_return_2014        | 
|   37 |    31.5675  |  0.4285  |                                             | 
|   38 |    33.2582  |  0.4285  | +employees_2014                             | 
|   39 |    34.8466  |  0.4285  | -shareholders_funds_2014 +total_assets_2014 | 
|   40 |    36.7370  |  0.4285  |                                             | 
|   41 |    38.2488  |  0.4285  | +shareholders_funds_2014                    | 
|   42 |    40.0000  |  0.4285  | +revenue_2014                               | 
|   43 |    42.0000  |  0.4285  | +added_value_2014                           | 
|   44 |    44.0000  |  0.4285  | +cash_flow_2014                             | 
+-----------------------------------------------------------------------------+
* indicates the smallest value for Cp

The coefficient values for the minimum Cp */

* Logit Regression
preserve
keep dummy_2017 control real_SA_2014 fin_cons_2014 ICR_failure_2014 solvency_ratio_2014 interest_diff_2014 NEG_VA_2014 consdummy dummy_patents profitability_2014 nace
rename dummy_2017 dummy_zombie
rename real_SA_2014 real_SA
rename fin_cons_2014 fin_cons
rename ICR_failure_2014 ICR_failure
rename solvency_ratio_2014 solvency_ratio
rename interest_diff_2014 interest_diff
rename NEG_VA_2014 NEG_VA
rename profitability_2014 profitability
eststo: quietly logit dummy_zombie control real_SA fin_cons ICR_failure solvency_ratio interest_diff NEG_VA consdummy dummy_patents profitability, cluster(nace) robust
restore

*Zombies 2014/2016
*LASSO REGRESSION
lars dummy_2016 control consdummy area dummy_patents dummy_trademark tfp_acf_2013 shareholders_funds_2013 added_value_2013 cash_flow_2013 ebitda_2013 fin_rev_2013 liquidity_ratio_2013 total_assets_2013 depr_2013 long_term_debt_2013 employees_2013 materials_2013 loans_2013 wage_bill_2013 fixed_assets tax_2013 current_liabilities_2013 current_assets_2013 fin_expenses_2013 int_paid_2013 solvency_ratio_2013 net_income_2013 revenue_2013 capital_intensity_2013 fin_cons_2013 ICR_failure_2013 interest_diff_2013 NEG_VA_2013 real_SA_2013 profitability_2013 misallocated_fixed_2013 financial_sustainability_2013 liquidity_return_2013 int_fixed_assets_2013, a(lasso) cluster(nace) vce(robust)

/* Algorithm is lasso

Cp, R-squared and Actions along the sequence of models

+-----------------------------------------------------------------------------+
| Step |      Cp     | R-square |  Action                                     |
|------+-------------+----------+---------------------------------------------|
|    1 | 76848.7587  |  0.0000  |                                             | 
|    2 | 11586.9664  |  0.4154  | +control                                    | 
|    3 |  7540.0631  |  0.4411  | +real_SA_2013                               | 
|    4 |  4279.8451  |  0.4619  | +ICR_failure_2013                           | 
|    5 |  3157.0804  |  0.4690  | +fin_cons_2013                              | 
|    6 |  1962.9595  |  0.4767  | +interest_diff_2013                         | 
|    7 |  1150.1354  |  0.4818  | +NEG_VA_2013                                | 
|    8 |   861.2725  |  0.4837  | +consdummy                                  | 
|    9 |   661.7242  |  0.4850  | +shareholders_funds_2013                    | 
|   10 |   564.0348  |  0.4856  | +profitability_2013                         | 
|   11 |   543.3734  |  0.4858  | +solvency_ratio_2013                        | 
|   12 |   447.2088  |  0.4864  | +ebitda_2013                                | 
|   13 |   370.9199  |  0.4869  | +tax_2013                                   | 
|   14 |   296.0854  |  0.4874  | +revenue_2013                               | 
|   15 |   244.4332  |  0.4877  | +dummy_patents                              | 
|   16 |   223.2429  |  0.4879  | +tfp_acf_2013                               | 
|   17 |   201.4929  |  0.4880  | +liquidity_ratio_2013                       | 
|   18 |   188.8121  |  0.4881  | +capital_intensity_2013                     | 
|   19 |   190.5757  |  0.4881  | +misallocated_fixed_2013                    | 
|   20 |   172.3219  |  0.4882  | +materials_2013                             | 
|   21 |   164.8158  |  0.4883  | +long_term_debt_2013                        | 
|   22 |   163.1002  |  0.4883  | -materials_2013 +int_fixed_assets_2013      | 
|   23 |   164.5879  |  0.4883  |                                             | 
|   24 |   140.1001  |  0.4885  | +area                                       | 
|   25 |   108.9900  |  0.4887  | +current_assets_2013                        | 
|   26 |    94.3915  |  0.4888  | +dummy_trademark                            | 
|   27 |    78.5977  |  0.4889  | +liquidity_return_2013                      | 
|   28 |    75.8674  |  0.4889  | +wage_bill_2013                             | 
|   29 |    70.4375  |  0.4890  | +int_paid_2013                              | 
|   30 |    53.5016  |  0.4891  | +financial_sustainability_2013              | 
|   31 |    43.2378  |  0.4892  | +fixed_assets                               | 
|   32 |    45.1334  |  0.4892  | +fin_rev_2013                               | 
|   33 |    40.7854  |  0.4892  | +cash_flow_2013                             | 
|   34 |    41.5894  |  0.4892  | +loans_2013                                 | 
|   35 |    37.7826  |  0.4893  | +current_liabilities_2013                   | 
|   36 |    31.2685 *|  0.4893  | +employees_2013                             | 
|   37 |    31.5826  |  0.4893  | +fin_expenses_2013                          | 
|   38 |    32.1840  |  0.4894  | +net_income_2013                            | 
|   39 |    34.0920  |  0.4894  | +materials_2013                             | 
|   40 |    36.0135  |  0.4894  | -shareholders_funds_2013 +total_assets_2013 | 
|   41 |    38.0109  |  0.4894  |                                             | 
|   42 |    40.0000  |  0.4894  | +shareholders_funds_2013                    | 
|   43 |    42.0000  |  0.4894  | +added_value_2013                           | 
|   44 |    44.0000  |  0.4894  | +depr_2013                                  | 
+-----------------------------------------------------------------------------+
* indicates the smallest value for Cp

The coefficient values for the minimum Cp */ 

* Logit Regression
preserve
keep dummy_2016 control real_SA_2013 ICR_failure_2013 fin_cons_2013 interest_diff_2013 NEG_VA_2013 consdummy shareholders_funds_2013 profitability_2013 solvency_ratio_2013 nace
rename dummy_2016 dummy_zombie
rename real_SA_2013 real_SA
rename ICR_failure_2013 ICR_failure
rename fin_cons_2013 fin_cons
rename interest_diff_2013 interest_diff
rename NEG_VA_2013 NEG_VA
rename shareholders_funds_2013 shareholders_funds
rename profitability_2013 profitability
rename solvency_ratio_2013 solvency_ratio
eststo: quietly logit dummy_zombie control real_SA ICR_failure fin_cons interest_diff NEG_VA consdummy shareholders_funds profitability solvency_ratio, cluster(nace) robust
restore

*Zombies 2013/2015
*LASSO REGRESSION
lars dummy_2015 control consdummy area dummy_patents dummy_trademark tfp_acf_2012 shareholders_funds_2012 added_value_2012 cash_flow_2012 ebitda_2012 fin_rev_2012 liquidity_ratio_2012 total_assets_2012 depr_2012 long_term_debt_2012 employees_2012 materials_2012 loans_2012 wage_bill_2012 fixed_assets tax_2012 current_liabilities_2012 current_assets_2012 fin_expenses_2012 int_paid_2012 solvency_ratio_2012 net_income_2012 revenue_2012 capital_intensity_2012 fin_cons_2012 ICR_failure_2012 interest_diff_2012 NEG_VA_2012 real_SA_2012 profitability_2012 misallocated_fixed_2012 financial_sustainability_2012 liquidity_return_2012 int_fixed_assets_2012, a(lasso) cluster(nace) vce(robust)

/* Algorithm is lasso

Cp, R-squared and Actions along the sequence of models

+------------------------------------------------------------------------+
| Step |      Cp     | R-square |  Action                                |
|------+-------------+----------+----------------------------------------|
|    1 | 85192.5726  |  0.0000  |                                        | 
|    2 | 23962.0860  |  0.3779  | +control                               | 
|    3 |  8871.3900  |  0.4710  | +real_SA_2012                          | 
|    4 |  5743.4443  |  0.4903  | +fin_cons_2012                         | 
|    5 |  2896.5021  |  0.5079  | +ICR_failure_2012                      | 
|    6 |  2541.3695  |  0.5101  | +NEG_VA_2012                           | 
|    7 |  2197.2543  |  0.5122  | +profitability_2012                    | 
|    8 |  1903.5316  |  0.5141  | +consdummy                             | 
|    9 |  1529.7659  |  0.5164  | +liquidity_return_2012                 | 
|   10 |  1044.0798  |  0.5194  | +shareholders_funds_2012               | 
|   11 |  1011.4161  |  0.5196  | +area                                  | 
|   12 |   942.6678  |  0.5201  | +revenue_2012                          | 
|   13 |   785.9379  |  0.5210  | +loans_2012                            | 
|   14 |   471.7467  |  0.5230  | +interest_diff_2012                    | 
|   15 |   378.3292  |  0.5236  | +solvency_ratio_2012                   | 
|   16 |   254.6662  |  0.5243  | +tax_2012                              | 
|   17 |   198.0333  |  0.5247  | +capital_intensity_2012                | 
|   18 |   154.8430  |  0.5250  | +financial_sustainability_2012         | 
|   19 |   142.9666  |  0.5251  | +int_fixed_assets_2012                 | 
|   20 |   140.8305  |  0.5251  | +current_assets_2012                   | 
|   21 |   133.7698  |  0.5252  | +liquidity_ratio_2012                  | 
|   22 |   129.8063  |  0.5252  | +misallocated_fixed_2012               | 
|   23 |   129.1153  |  0.5252  | +employees_2012                        | 
|   24 |   125.1971  |  0.5252  | +long_term_debt_2012                   | 
|   25 |   117.7539  |  0.5253  | +wage_bill_2012                        | 
|   26 |    93.0433  |  0.5255  |                                        | 
|   27 |    91.7236  |  0.5255  | +dummy_patents                         | 
|   28 |    74.5922  |  0.5256  | +dummy_trademark                       | 
|   29 |    58.8500  |  0.5257  | +fin_expenses_2012                     | 
|   30 |    60.5187  |  0.5257  | +int_paid_2012                         | 
|   31 |    48.4837  |  0.5258  | +fixed_assets                          | 
|   32 |    47.2744  |  0.5258  | +ebitda_2012                           | 
|   33 |    41.1215  |  0.5259  | +current_liabilities_2012              | 
|   34 |    40.6232  |  0.5259  | +fin_rev_2012                          | 
|   35 |    42.4187  |  0.5259  | +materials_2012                        | 
|   36 |    41.5742  |  0.5259  | +depr_2012 -tax_2012                   | 
|   37 |    40.5940  |  0.5259  |                                        | 
|   38 |    42.4384  |  0.5259  |                                        | 
|   39 |    38.4751  |  0.5260  | +net_income_2012                       | 
|   40 |    38.4976  |  0.5260  | -depr_2012 +tax_2012                   | 
|   41 |    37.2060 *|  0.5260  |                                        | 
|   42 |    38.7327  |  0.5260  | +total_assets_2012                     | 
|   43 |    38.3205  |  0.5260  | +cash_flow_2012                        | 
|   44 |    40.0322  |  0.5260  | +tfp_acf_2012 -shareholders_funds_2012 | 
|   45 |    42.0231  |  0.5260  |                                        | 
|   46 |    44.0000  |  0.5260  | +shareholders_funds_2012               | 
|   47 |    46.0000  |  0.5260  | +added_value_2012                      | 
|   48 |    48.0000  |  0.5260  | +depr_2012                             | 
+------------------------------------------------------------------------+
* indicates the smallest value for Cp

The coefficient values for the minimum Cp */

* Logit Regression
preserve
keep dummy_2015 nace control real_SA_2012 fin_cons_2012 ICR_failure_2012 NEG_VA_2012 profitability_2012 consdummy liquidity_return_2012 shareholders_funds_2012 revenue_2012
rename dummy_2015 dummy_zombie
rename real_SA_2012 real_SA
rename fin_cons_2012 fin_cons
rename ICR_failure_2012 ICR_failure
rename NEG_VA_2012 NEG_VA
rename profitability_2012 profitability
rename liquidity_return_2012 liquidity_return
rename shareholders_funds_2012 shareholders_funds
rename revenue_2012 revenue
eststo: quietly logit dummy_zombie control real_SA fin_cons ICR_failure NEG_VA profitability consdummy liquidity_return shareholders_funds revenue, cluster(nace) robust
restore

*Zombies 2012/2014
*LASSO REGRESSION
lars dummy_2014 control consdummy area dummy_patents dummy_trademark tfp_acf_2011 shareholders_funds_2011 added_value_2011 cash_flow_2011 ebitda_2011 fin_rev_2011 liquidity_ratio_2011 total_assets_2011 depr_2011 long_term_debt_2011 employees_2011 materials_2011 loans_2011 wage_bill_2011 fixed_assets tax_2011 current_liabilities_2011 current_assets_2011 fin_expenses_2011 int_paid_2011 solvency_ratio_2011 net_income_2011 revenue_2011 capital_intensity_2011 fin_cons_2011 ICR_failure_2011 interest_diff_2011 NEG_VA_2011 real_SA_2011 profitability_2011 misallocated_fixed_2011 financial_sustainability_2011 liquidity_return_2011 int_fixed_assets_2011, a(lasso) cluster(nace) vce(robust)

/* Algorithm is lasso

Cp, R-squared and Actions along the sequence of models

+----------------------------------------------------------------+
| Step |      Cp     | R-square |  Action                        |
|------+-------------+----------+--------------------------------|
|    1 | 58628.9183  |  0.0000  |                                | 
|    2 | 20926.1405  |  0.2887  | +control                       | 
|    3 | 13730.0157  |  0.3438  | +real_SA_2011                  | 
|    4 |  3910.5152  |  0.4190  | +fin_cons_2011                 | 
|    5 |  2474.3958  |  0.4300  | +ICR_failure_2011              | 
|    6 |  2402.2089  |  0.4306  | +solvency_ratio_2011           | 
|    7 |  1974.5784  |  0.4339  | +NEG_VA_2011                   | 
|    8 |  1809.6621  |  0.4351  | +dummy_patents                 | 
|    9 |  1764.6477  |  0.4355  | +consdummy                     | 
|   10 |  1506.7935  |  0.4375  | +area                          | 
|   11 |  1323.2243  |  0.4389  | +profitability_2011            | 
|   12 |  1310.6956  |  0.4390  | +shareholders_funds_2011       | 
|   13 |   936.8131  |  0.4419  | +liquidity_return_2011         | 
|   14 |   583.1637  |  0.4446  | +misallocated_fixed_2011       | 
|   15 |   462.8040  |  0.4455  | +dummy_trademark               | 
|   16 |   382.8794  |  0.4462  | +tfp_acf_2011                  | 
|   17 |   363.2389  |  0.4463  | +ebitda_2011                   | 
|   18 |   265.9472  |  0.4471  | +tax_2011                      | 
|   19 |   265.3773  |  0.4471  | +interest_diff_2011            | 
|   20 |   247.5381  |  0.4473  |                                | 
|   21 |   226.8229  |  0.4474  | +liquidity_ratio_2011          | 
|   22 |   210.5994  |  0.4476  | +int_fixed_assets_2011         | 
|   23 |   189.9090  |  0.4478  | +capital_intensity_2011        | 
|   24 |   176.2404  |  0.4479  | +current_assets_2011           | 
|   25 |   137.7472  |  0.4482  | +long_term_debt_2011           | 
|   26 |   136.9806  |  0.4482  | +net_income_2011               | 
|   27 |   135.1683  |  0.4482  | +depr_2011                     | 
|   28 |   128.7254  |  0.4483  |                                | 
|   29 |   126.7672  |  0.4483  | +financial_sustainability_2011 | 
|   30 |   110.5795  |  0.4485  | +fin_rev_2011                  | 
|   31 |    72.8489  |  0.4488  | -ebitda_2011 +int_paid_2011    | 
|   32 |    68.9326  |  0.4488  |                                | 
|   33 |    67.5652  |  0.4489  | +wage_bill_2011                | 
|   34 |    54.0718  |  0.4490  | +materials_2011                | 
|   35 |    52.1963  |  0.4490  | +loans_2011                    | 
|   36 |    52.5620  |  0.4490  | +ebitda_2011                   | 
|   37 |    49.9669  |  0.4490  | +fixed_assets                  | 
|   38 |    47.3884  |  0.4491  |-ebitda_2011 +fin_expenses_2011 | 
|   39 |    35.7437  |  0.4492  |                                | 
|   40 |    35.1073 *|  0.4492  | +employees_2011 -fixed_assets  | 
|   41 |    36.3114  |  0.4492  |                                | 
|   42 |    37.3670  |  0.4492  | +ebitda_2011                   | 
|   43 |    39.0521  |  0.4492  | +current_liabilities_2011      | 
|   44 |    40.3989  |  0.4492  | +fixed_assets                  | 
|   45 |    42.0279  |  0.4492  | +total_assets_2011             | 
|   46 |    44.0000  |  0.4492  | +revenue_2011                  | 
|   47 |    46.0000  |  0.4492  | +added_value_2011              | 
|   48 |    48.0000  |  0.4492  | +cash_flow_2011                | 
+----------------------------------------------------------------+
* indicates the smallest value for Cp

The coefficient values for the minimum Cp */ 

* Logit Regression
preserve
keep dummy_2014 nace control real_SA_2011 fin_cons_2011 ICR_failure_2011 NEG_VA_2011 solvency_ratio_2011 dummy_patents consdummy profitability_2011 shareholders_funds_2011
rename dummy_2014 dummy_zombie
rename real_SA_2011 real_SA
rename fin_cons_2011 fin_cons
rename ICR_failure_2011 ICR_failure
rename NEG_VA_2011 NEG_VA
rename solvency_ratio_2011 solvency_ratio 
rename profitability_2011 profitability
rename shareholders_funds_2011 shareholders_funds
eststo: quietly logit dummy_zombie control real_SA fin_cons ICR_failure NEG_VA solvency_ratio dummy_patents consdummy profitability shareholders_funds, cluster(nace) robust
restore

*Zombies 2011/2013
*LASSO REGRESSION
lars dummy_2013  control consdummy area dummy_patents dummy_trademark tfp_acf_2010 shareholders_funds_2010 added_value_2010 cash_flow_2010 ebitda_2010 fin_rev_2010 liquidity_ratio_2010 total_assets_2010 depr_2010 long_term_debt_2010 employees_2010 materials_2010 loans_2010 wage_bill_2010 fixed_assets tax_2010 current_liabilities_2010 current_assets_2010 fin_expenses_2010 int_paid_2010 solvency_ratio_2010 net_income_2010 revenue_2010 capital_intensity_2010 fin_cons_2010 ICR_failure_2010 interest_diff_2010 NEG_VA_2010 real_SA_2010 profitability_2010 misallocated_fixed_2010 financial_sustainability_2010 liquidity_return_2010 int_fixed_assets_2010, a(lasso) cluster(nace) vce(robust)

/* Algorithm is lasso

Cp, R-squared and Actions along the sequence of models

+----------------------------------------------------------------+
| Step |      Cp     | R-square |  Action                        |
|------+-------------+----------+--------------------------------|
|    1 | 58628.9183  |  0.0000  |                                | 
|    2 | 20926.1405  |  0.2887  | +control                       | 
|    3 | 13730.0157  |  0.3438  | +real_SA_2011                  | 
|    4 |  3910.5152  |  0.4190  | +fin_cons_2011                 | 
|    5 |  2474.3958  |  0.4300  | +ICR_failure_2011              | 
|    6 |  2402.2089  |  0.4306  | +solvency_ratio_2011           | 
|    7 |  1974.5784  |  0.4339  | +NEG_VA_2011                   | 
|    8 |  1809.6621  |  0.4351  | +dummy_patents                 | 
|    9 |  1764.6477  |  0.4355  | +consdummy                     | 
|   10 |  1506.7935  |  0.4375  | +area                          | 
|   11 |  1323.2243  |  0.4389  | +profitability_2011            | 
|   12 |  1310.6956  |  0.4390  | +shareholders_funds_2011       | 
|   13 |   936.8131  |  0.4419  | +liquidity_return_2011         | 
|   14 |   583.1637  |  0.4446  | +misallocated_fixed_2011       | 
|   15 |   462.8040  |  0.4455  | +dummy_trademark               | 
|   16 |   382.8794  |  0.4462  | +tfp_acf_2011                  | 
|   17 |   363.2389  |  0.4463  | +ebitda_2011                   | 
|   18 |   265.9472  |  0.4471  | +tax_2011                      | 
|   19 |   265.3773  |  0.4471  | +interest_diff_2011            | 
|   20 |   247.5381  |  0.4473  |                                | 
|   21 |   226.8229  |  0.4474  | +liquidity_ratio_2011          | 
|   22 |   210.5994  |  0.4476  | +int_fixed_assets_2011         | 
|   23 |   189.9090  |  0.4478  | +capital_intensity_2011        | 
|   24 |   176.2404  |  0.4479  | +current_assets_2011           | 
|   25 |   137.7472  |  0.4482  | +long_term_debt_2011           | 
|   26 |   136.9806  |  0.4482  | +net_income_2011               | 
|   27 |   135.1683  |  0.4482  | +depr_2011                     | 
|   28 |   128.7254  |  0.4483  |                                | 
|   29 |   126.7672  |  0.4483  | +financial_sustainability_2011 | 
|   30 |   110.5795  |  0.4485  | +fin_rev_2011                  | 
|   31 |    72.8489  |  0.4488  | -ebitda_2011 +int_paid_2011    | 
|   32 |    68.9326  |  0.4488  |                                | 
|   33 |    67.5652  |  0.4489  | +wage_bill_2011                | 
|   34 |    54.0718  |  0.4490  | +materials_2011                | 
|   35 |    52.1963  |  0.4490  | +loans_2011                    | 
|   36 |    52.5620  |  0.4490  | +ebitda_2011                   | 
|   37 |    49.9669  |  0.4490  | +fixed_assets                  | 
|   38 |    47.3884  |  0.4491  | -ebitda_2011 +fin_expenses_2011 | 
|   39 |    35.7437  |  0.4492  |                                | 
|   40 |    35.1073 *|  0.4492  | +employees_2011 -fixed_assets  | 
|   41 |    36.3114  |  0.4492  |                                | 
|   42 |    37.3670  |  0.4492  | +ebitda_2011                   | 
|   43 |    39.0521  |  0.4492  | +current_liabilities_2011      | 
|   44 |    40.3989  |  0.4492  | +fixed_assets                  | 
|   45 |    42.0279  |  0.4492  | +total_assets_2011             | 
|   46 |    44.0000  |  0.4492  | +revenue_2011                  | 
|   47 |    46.0000  |  0.4492  | +added_value_2011              | 
|   48 |    48.0000  |  0.4492  | +cash_flow_2011                | 
+----------------------------------------------------------------+
* indicates the smallest value for Cp

The coefficient values for the minimum Cp

+----------------------------------------------+
| Variable                      |  Coefficient |
|-------------------------------+--------------|
| control                       |      -0.4948 |
| consdummy                     |       0.1953 |
| area                          |      -0.0156 |
| dummy_patents                 |      -0.0358 |
| dummy_trademark               |      -0.0181 |
| tfp_acf_2011                  |      -0.0007 |
| shareholders_funds_2011       |   6.3699e-10 |
| liquidity_ratio_2011          |       0.0032 |
| depr_2011                     |   1.3226e-09 |
| loans_2011                    |   1.4478e-10 |
| wage_bill_2011                |   3.2965e-10 |
| tax_2011                      |   2.3945e-09 |
| current_assets_2011           |   1.0422e-10 |
| fin_expenses_2011             |   1.6503e-09 |
| solvency_ratio_2011           |      -0.0006 |
| capital_intensity_2011        |   3.3595e-09 |
| fin_cons_2011                 |       0.1434 |
| ICR_failure_2011              |       0.0597 |
| interest_diff_2011            |       0.0055 |
| NEG_VA_2011                   |       0.1412 |
| real_SA_2011                  |       0.0725 |
| profitability_2011            |       0.0367 |
| misallocated_fixed_2011       |       0.0180 |
| financial_sustainability_2011 |      -0.0007 |
| liquidity_return_2011         |      -0.0496 |
+----------------------------------------------+

. 
end of do-file

. do "C:\Users\Falco\AppData\Local\Temp\STD02000000.tmp"

. lars dummy_2013  control consdummy area dummy_patents dummy_trademark tfp_acf_2010 shareholders_fu
> nds_2010 added_value_2010 cash_flow_2010 ebitda_2010 fin_rev_2010 liquidity_ratio_2010 total_asset
> s_2010 depr_2010 long_term_debt_2010 employees_2010 materials_2010 loans_2010 wage_bill_2010 fixed
> _assets tax_2010 current_liabilities_2010 current_assets_2010 fin_expenses_2010 int_paid_2010 solv
> ency_ratio_2010 net_income_2010 revenue_2010 capital_intensity_2010 fin_cons_2010 ICR_failure_2010
>  interest_diff_2010 NEG_VA_2010 real_SA_2010 profitability_2010 misallocated_fixed_2010 financial_
> sustainability_2010 liquidity_return_2010 int_fixed_assets_2010, a(lasso) cluster(nace) vce(robust
> )
NOTE: Deleting all matrices
          ade[42,39]
           mu[1,1]
        meanx[1,39]
           R2[1,42]
          RSS[1,42]
           r2[1,1]
          rss[1,1]
           cp[1,42]
        normx[1,39]
         beta[42,39]
        sbeta[42,39]
        error[1,1]

sbeta[42,39]
             c1          c2          c3          c4          c5          c6          c7          c8
 r1           0           0           0           0           0           0           0           0
 r2  -23.453935           0           0           0           0           0           0           0
 r3  -27.963678           0           0           0           0           0           0           0
 r4  -37.356561           0           0           0           0           0           0           0
 r5  -38.316145           0           0           0           0           0           0           0
 r6  -38.545715           0           0           0           0           0           0           0
 r7  -38.569602           0           0  -.01751096           0           0           0           0
 r8  -39.882591           0           0  -.99657906           0           0           0           0
 r9  -40.110905           0           0  -1.1657317           0           0           0           0
r10  -40.601792   .78103236           0  -1.5491255           0           0           0           0
r11  -40.727471   .98478386  -.12818213  -1.6491354           0           0           0           0
r12  -40.758872   1.0348221  -.15979653  -1.6740155           0           0           0           0
r13  -40.818819   1.1160111  -.21806154  -1.7205322           0           0           0           0
r14  -40.954076   1.2953267  -.34887955  -1.8255794           0           0   .12702979           0
r15  -41.177807   1.5921134  -.56544661  -1.9995352           0           0   .33866688           0
r16  -41.231359   1.6516789  -.61550083  -2.0410442           0           0   .39181651           0
r17  -41.683308    2.148773   -1.038375  -2.3812182           0           0   .83226896           0
r18  -41.954222   2.4466312   -1.292159   -2.587113           0           0   1.0936206           0
r19   -42.03561   2.5339104  -1.3651887  -2.6472057           0  -.08476958     1.17082           0
r20   -42.20756   2.7200324   -1.518867  -2.7745677           0  -.26411067   1.2054999           0
r21  -42.727513    3.340693  -2.0047471  -3.0778312  -.43137224  -.87317258   1.3227089           0
r22   -42.82942   3.4624029  -2.1001827  -3.1348354  -.51338722  -.99039269   1.3226126           0
r23  -42.859448   3.5022669  -2.1259923  -3.1525215  -.53716582  -1.0227626    1.428504           0
r24  -42.905866   3.5585809  -2.1658796   -3.179544   -.5726601  -1.0722975   1.6425566           0
r25  -42.909484   3.5621957  -2.1687349  -3.1814919   -.5752207  -1.0759805   1.6745063           0
r26  -42.947685   3.6007398  -2.1987932  -3.2016953  -.60136838  -1.1161071   2.0128582           0
r27  -42.956483   3.6094175  -2.2056608  -3.2072633   -.6077154  -1.1255175   2.0855482           0
r28  -42.975996   3.6261543  -2.2206546  -3.2192214  -.62166581  -1.1463457   2.2516687           0
r29  -42.990644   3.6383563  -2.2314776  -3.2274291  -.63182382  -1.1616928   2.3813472           0
r30  -43.078778   3.6812049  -2.2934605  -3.2845724  -.68917904  -1.2506559     3.15289           0
r31  -43.134568   3.6956722  -2.3322963  -3.3184653  -.72650709  -1.3058514    3.682264           0
r32  -43.152629   3.7053209  -2.3451306  -3.3291378  -.73784703  -1.3235524   3.9478873           0
r33  -43.162666   3.7102969  -2.3520271  -3.3348788  -.74410244  -1.3333401   4.1144199           0
r34  -43.169895   3.7132555  -2.3569253  -3.3396805  -.74927041  -1.3402778    4.257313           0
r35   -43.18869   3.7201194  -2.3695828  -3.3526787  -.76305541  -1.3584117   4.6336663           0
r36  -43.190713   3.7158518  -2.3708132  -3.3542826  -.76567265  -1.3604386   4.7560641           0
r37  -43.203499   3.7055407  -2.3777583  -3.3635001  -.78029615  -1.3734998   5.4259448           0
r38  -43.209475   3.7082579  -2.3806649  -3.3676819   -.7857401  -1.3788968   5.6101188           0
r39  -43.211827   3.7050654  -2.3820006  -3.3693989  -.78866883  -1.3814207   5.7554935           0
r40  -43.224195   3.6814502  -2.3862511  -3.3735055  -.81071654  -1.3922351   6.2694628           0
r41  -43.224195   3.6814502  -2.3862511  -3.3735055  -.81071654  -1.3922351   6.2694628   .07940718
r42  -43.224195   3.6814502  -2.3862511  -3.3735055  -.81071654  -1.3922351   6.2694628   .15038313

             c9         c10         c11         c12         c13         c14         c15         c16
 r1           0           0           0           0           0           0           0           0
 r2           0           0           0           0           0           0           0           0
 r3           0           0           0           0           0           0           0           0
 r4           0           0           0           0           0           0           0           0
 r5           0           0           0           0           0           0           0           0
 r6           0           0           0           0           0           0           0           0
 r7           0           0           0           0           0           0           0           0
 r8           0           0           0           0           0           0           0           0
 r9           0           0           0           0           0           0           0           0
r10           0           0           0           0           0           0           0           0
r11           0           0           0           0           0           0           0           0
r12           0           0           0           0           0           0           0           0
r13           0           0           0           0           0   .06449088           0           0
r14           0           0           0           0           0   .09721123           0           0
r15           0           0           0           0           0    .1482827           0           0
r16           0           0           0           0           0   .16516601           0           0
r17           0           0           0           0           0    .3032215           0           0
r18           0           0           0           0           0    .3881678           0           0
r19           0           0           0           0           0   .41359109           0           0
r20           0           0           0           0           0   .42497321           0           0
r21           0           0           0           0           0    .4570563           0           0
r22           0           0           0           0           0    .4745988           0           0
r23           0           0           0           0           0    .5004841   -.1630647           0
r24           0           0           0           0           0   .50988061  -.31340964           0
r25           0           0           0           0           0   .52251214  -.32845019           0
r26           0           0           0   .05354564           0   .65734324  -.48873898           0
r27           0           0           0   .06568107           0   .72274066  -.52391449           0
r28           0           0           0   .09236744           0   .85812858  -.61033124           0
r29           0           0           0   .11213939           0   .97958051  -.62992329           0
r30           0           0           0   .22526432           0   1.4397476  -.68173061           0
r31           0           0           0   .29672494           0    1.664137  -.77362884           0
r32           0           0           0   .32259589           0   1.7167742  -.77843208           0
r33           0           0           0   .33695025           0   1.7500788     -.77471           0
r34           0           0   .07904784   .34606673           0   1.7327702  -.76123272           0
r35           0   -.3380627   .12871919   .36996127           0   1.8275156  -.70548283           0
r36           0  -.35402711   .15670963   .37191337  -.49212911   1.9016395  -.60886915           0
r37           0  -.37204065   .36500273   .38433275  -3.3838197   2.3553454           0  -.48911189
r38           0  -.32603086   .44934427    .3907087  -3.9525376   2.4321857           0  -.70596304
r39           0  -.33870465   .48989086   .39289459  -4.6190011   2.5388849   .16092379  -.79794072
r40           0  -.57269463    .6906288   .40288802  -7.5986636   2.8851571   .95263953  -.95261071
r41           0  -.57269463    .6906288   .40288802  -7.5986636   2.8727096   .95263953  -.95261071
r42  -.16637777  -.57269463    .6906288   .40288802  -7.5986636   2.9484092   .95263953  -.95261071

            c17         c18         c19         c20         c21         c22         c23         c24
 r1           0           0           0           0           0           0           0           0
 r2           0           0           0           0           0           0           0           0
 r3           0           0           0           0           0           0           0           0
 r4           0           0           0           0           0           0           0           0
 r5           0           0           0           0           0           0           0           0
 r6           0           0           0           0           0           0           0           0
 r7           0           0           0           0           0           0           0           0
 r8           0           0           0           0           0           0           0           0
 r9           0           0           0           0           0           0           0           0
r10           0           0           0           0           0           0           0           0
r11           0           0           0           0           0           0           0           0
r12           0           0           0           0           0           0           0           0
r13           0           0           0           0           0           0           0           0
r14           0           0           0           0           0           0           0           0
r15           0           0           0           0           0           0           0           0
r16           0           0           0           0   .07207921           0           0           0
r17           0           0           0           0   .66827017           0           0           0
r18           0           0           0           0   1.0255904           0           0           0
r19           0           0           0           0   1.1313348           0           0           0
r20           0           0           0           0   1.3750168           0   .18932714           0
r21           0           0           0           0   2.1511776           0   .78664572           0
r22           0           0           0           0   2.3032823           0   .91365118           0
r23           0           0           0           0    2.323671           0    .9559044           0
r24           0           0           0           0   2.3069752           0   1.1222097           0
r25           0           0           0  -.02711829    2.304682           0   1.1348603           0
r26           0           0           0  -.31390605   2.2798098           0    1.266933           0
r27  -.05276718           0           0  -.36236315   2.2693597           0   1.3169393           0
r28  -.16720358           0           0  -.46547823   2.2535261           0   1.4431951           0
r29  -.24249219           0           0  -.52320116    2.217251           0   1.5670422           0
r30  -.54690209           0   1.2756673  -1.0092914   2.0494419           0   1.8220287           0
r31  -.74922214   .13454777   2.1404524  -1.3302402   1.9149243           0    1.928603           0
r32   -.8357057   .14895787   2.3891555  -1.4876996   1.9086522   .41397843   1.5832827           0
r33  -.88481972     .154667   2.5169598  -1.5733952   1.9004052   .66122856   1.3784726  -.05766627
r34  -.93581835   .16877654   2.6414946  -1.6639824   1.9015601   .75447861   1.3187972  -.13349355
r35  -1.0632519   .19593088   2.9851993  -1.8825068   1.9815052   1.0649661   1.0914866  -.23624074
r36  -1.0794539   .20734433   2.9959713  -1.9019895   1.9873652   1.1919798   1.2241694   -.2399296
r37  -1.1917233   .27190265   3.5855847  -1.9529348    2.029602   1.9460807   1.9623538  -.25408434
r38  -1.2392271   .31479632     3.87881  -1.9927335   2.0409615   2.0451139   2.1169238  -.26741719
r39  -1.2607301   .32448214   3.9842153  -1.9993537    2.050171   2.2273905   2.2854424  -.26886528
r40  -4.1083859   .42305334   3.1163318   -2.070933   1.9751125   2.7536445   3.1809064  -.27154069
r41  -4.1083859   .42305334   3.0643437   -2.070933   1.9700232   2.7536445   3.1809064  -.27154069
r42  -4.1083859   .42305334   3.0178755   -2.070933   1.9654743   2.7536445   3.1809064  -.27154069

            c25         c26         c27         c28         c29         c30         c31         c32
 r1           0           0           0           0           0           0           0           0
 r2           0           0           0           0           0           0           0           0
 r3           0           0           0           0           0           0           0           0
 r4           0           0           0           0           0   10.047231           0           0
 r5           0           0           0           0           0   10.640501           0           0
 r6           0           0           0           0           0   10.725599           0           0
 r7           0           0           0           0           0     10.7346           0           0
 r8           0           0           0           0           0   10.240855   1.3230949           0
 r9           0           0           0           0           0   10.155832   1.5473733           0
r10           0           0           0           0           0   9.9927374       1.984           0
r11           0           0           0           0           0   9.9449948   2.1022675           0
r12           0  -.01256007           0           0           0   9.9304845   2.1334428           0
r13           0  -.03365101           0           0           0   9.9039613   2.1900319           0
r14           0  -.08745814           0           0           0   9.8424104   2.3203251           0
r15           0  -.17810925           0           0           0   9.7293534   2.5244681           0
r16           0  -.19800388           0           0           0   9.7038581   2.5733744           0
r17           0  -.45582329           0           0           0   9.5355076   2.9598861   .45234754
r18           0  -.61228033           0           0           0   9.4262167   3.1936615   .72422445
r19           0  -.65821857           0           0           0   9.3910143   3.2624211   .80423989
r20           0  -.74570824           0           0           0   9.3166467   3.4090058   .97156617
r21           0  -1.0256084           0           0           0   9.0768623   3.8725211   1.4899164
r22           0   -1.084058           0           0   .11139581   9.0274545   3.9628656   1.5918676
r23           0  -1.1059882           0           0   .14070251   9.0148345   3.9867461   1.6188757
r24           0  -1.1386806           0           0   .18340553   8.9950722   4.0212808   1.6592082
r25           0  -1.1415624           0           0   .18671067   8.9939658   4.0234841   1.6620618
r26           0  -1.1962834           0           0   .22284269   8.9832738   4.0472395   1.6868396
r27           0  -1.2089131           0           0     .230962   8.9809934   4.0519656   1.6925821
r28           0  -1.2363781  -.03725237           0   .24879987    8.976646   4.0614686   1.7050046
r29  -.14188902  -1.2571413  -.06029433           0    .2613311   8.9758347    4.067265   1.7146017
r30  -1.1134937  -1.3688602  -.27463026           0   .34448074   8.9754306   4.0996571   1.7670872
r31   -1.745735  -1.4347252  -.38331243           0   .39509815   8.9753521   4.1179288   1.8019247
r32  -1.9028858  -1.4563174  -.44326184           0   .40910012     8.97508   4.1236424   1.8124019
r33  -1.9448462  -1.4688447  -.47918246           0   .41621475   8.9747787   4.1265084    1.818223
r34   -1.998064  -1.4793132  -.53244153           0   .42105375   8.9738475   4.1288956   1.8225794
r35  -2.1194269  -1.5060023   -.5176186           0   .43310948   8.9690994   4.1347207   1.8338077
r36  -2.1480461  -1.5088325  -.52437694           0   .43557825   8.9697166   4.1342691   1.8354585
r37  -2.3581997  -1.5246541  -.62267061           0   .44960765   8.9739616   4.1311341   1.8446169
r38  -2.3552047  -1.5329145   -.6906246           0    .4548111   8.9741929    4.131466   1.8475379
r39  -2.4112633  -1.5356755  -.70491675           0   .45762417    8.975275   4.1305804   1.8494561
r40  -2.8328003   -1.537734  -.81111096   4.0187437   .47542741   8.9827109   4.1270202   1.8579859
r41  -2.8398524   -1.537734  -.82561036   4.0187437   .47542741   8.9827109   4.1270202   1.8579859
r42  -2.8461558   -1.537734  -.73743264   4.0187437   .47542741   8.9827109   4.1270202   1.8579859

            c33         c34         c35         c36         c37         c38         c39
 r1           0           0           0           0           0           0           0
 r2           0           0           0           0           0           0           0
 r3           0   4.5097433           0           0           0           0           0
 r4           0   13.869596           0           0           0           0           0
 r5           0   14.867838           0           0           0  -.73440372           0
 r6           0   15.084818           0   .17886669           0  -.91618024           0
 r7           0   15.102738           0   .19865618           0  -.93591254           0
 r8           0   16.122712           0    1.466665           0  -1.9970556           0
 r9   .19400826   16.294956           0   1.6843892           0  -2.1116696           0
r10   .57080933   16.832996           0   2.0805115           0  -2.3610906           0
r11   .66976208   16.970036           0   2.1813759           0  -2.4274919           0
r12   .69481344   17.000645           0   2.2043569           0  -2.4409896           0
r13   .74055142   17.069357           0   2.2456201           0  -2.4688382           0
r14   .84442032   17.226655           0   2.3382902           0  -2.5301352           0
r15   1.0076965   17.486792   .09496617    2.459459           0  -2.6245589           0
r16   1.0444812   17.559248    .1166265   2.4872338           0  -2.6517643           0
r17   1.3478722   18.050347   .28992383   2.7423334           0  -2.8696047           0
r18   1.5029245   18.345501   .38779682   2.8824909   .23309538  -2.9993631           0
r19   1.5477994   18.442601   .41781557   2.9251857   .30183118  -3.0359397           0
r20   1.6411625   18.653452   .48119899   3.0170021   .44724938  -3.1147362           0
r21   1.9408489   19.209812   .68569187   3.3075186   .90824154  -3.3489152           0
r22   1.9967942   19.325009   .72564827    3.363651   .99600755  -3.3943482           0
r23   2.0117853   19.361796   .73442794   3.3795969   1.0210423  -3.4076684           0
r24   2.0339985   19.427361   .74696371   3.4025559   1.0588694  -3.4268695  -.24248221
r25   2.0355421   19.433259   .74797661   3.4041117   1.0616959  -3.4283558  -.26202439
r26   2.0507656   19.490742   .75774527   3.4202733   1.0920169  -3.4433854  -.46812052
r27   2.0540552   19.503822    .7603859   3.4238247   1.0987385  -3.4469516  -.54801986
r28   2.0594715   19.533988   .76639094   3.4310678   1.1137219  -3.4523304  -.70415341
r29   2.0629916   19.556344   .77239511   3.4381563   1.1248386  -3.4548221   -.8048045
r30    2.085665   19.714747   .80342038   3.4843568   1.1907533  -3.4664537  -1.7964205
r31   2.1014622   19.825487   .82403896   3.5121759   1.2316695  -3.4736294   -2.401041
r32   2.1049704   19.860781     .830022   3.5205219   1.2448141  -3.4761474  -2.6421737
r33    2.106869   19.880087   .83383033    3.525945   1.2522754  -3.4772964  -2.7889367
r34    2.108314   19.893545   .83588608     3.53055   1.2576086  -3.4766304  -2.8512808
r35   2.1126678   19.929019   .84035199   3.5429695   1.2713094  -3.4762266  -3.0169044
r36   2.1124902   19.933741   .84106954   3.5430349   1.2727325   -3.477215  -2.9867433
r37   2.1097796   19.959771   .84532155   3.5439071    1.281409  -3.4841704  -2.8896042
r38   2.1094939   19.971969   .84554448   3.5443451   1.2854517  -3.4864851  -2.8604687
r39   2.1088266   19.976751   .84662994   3.5445003   1.2870496  -3.4879253  -2.8398056
r40   2.1084545   20.008441   .85186607   3.5483032   1.2952211  -3.4928544  -2.7638075
r41   2.1084545   20.008441   .85186607   3.5483032   1.2952211  -3.4928544  -2.7638075
r42   2.1084545   20.008441   .85186607   3.5483032   1.2952211  -3.4928544  -2.7638075

Algorithm is lasso

Cp, R-squared and Actions along the sequence of models

+----------------------------------------------------------------------+
| Step |      Cp     | R-square |  Action                              |
|------+-------------+----------+--------------------------------------|
|    1 | 28754.3880  |  0.0000  |                                      | 
|    2 | 12599.8399  |  0.2392  | +control                             | 
|    3 |  9023.6034  |  0.2922  | +real_SA_2010                        | 
|    4 |  2157.0984  |  0.3939  | +fin_cons_2010                       | 
|    5 |  1765.3249  |  0.3998  | +liquidity_return_2010               | 
|    6 |  1672.6091  |  0.4012  | +misallocated_fixed_2010             | 
|    7 |  1663.4763  |  0.4013  | +dummy_patents                       | 
|    8 |  1102.7316  |  0.4097  | +ICR_failure_2010                    | 
|    9 |  1020.4202  |  0.4109  | +NEG_VA_2010                         | 
|   10 |   812.6693  |  0.4140  | +consdummy                           | 
|   11 |   759.6815  |  0.4148  | +area                                | 
|   12 |   748.3132  |  0.4150  | +solvency_ratio_2010                 | 
|   13 |   722.7557  |  0.4154  | +depr_2010                           | 
|   14 |   664.3233  |  0.4163  | +shareholders_funds_2010             | 
|   15 |   573.2792  |  0.4177  | +profitability_2010                  | 
|   16 |   551.3551  |  0.4181  | +tax_2010                            | 
|   17 |   363.1029  |  0.4209  | +interest_diff_2010                  | 
|   18 |   269.7905  |  0.4223  | +financial_sustainability_2010       | 
|   19 |   245.0692  |  0.4227  | +tfp_acf_2010                        | 
|   20 |   195.7391  |  0.4234  | +current_assets_2010                 | 
|   21 |    85.7645  |  0.4251  | +dummy_trademark                     | 
|   22 |    74.9760  |  0.4253  | +capital_intensity_2010              | 
|   23 |    72.1014  |  0.4254  | +long_term_debt_2010                 | 
|   24 |    66.2494  |  0.4255  | +int_fixed_assets_2010               | 
|   25 |    67.3883  |  0.4255  | +fixed_assets                        | 
|   26 |    60.6079  |  0.4256  | +liquidity_ratio_2010                | 
|   27 |    60.2626  |  0.4257  | +materials_2010                      | 
|   28 |    57.2418  |  0.4257  | +net_income_2010                     | 
|   29 |    55.4531  |  0.4258  | +int_paid_2010                       | 
|   30 |    36.5130  |  0.4261  | +wage_bill_2010                      | 
|   31 |    30.2641 *|  0.4262  | +loans_2010                          | 
|   32 |    30.2812  |  0.4263  | +current_liabilities_2010            | 
|   33 |    31.3565  |  0.4263  | +fin_expenses_2010                   | 
|   34 |    32.6196  |  0.4263  | +fin_rev_2010                        | 
|   35 |    33.0937  |  0.4263  | +ebitda_2010                         | 
|   36 |    34.5984  |  0.4263  | +total_assets_2010                   | 
|   37 |    33.9355  |  0.4263  | -long_term_debt_2010 +employees_2010 | 
|   38 |    35.4644  |  0.4264  |                                      | 
|   39 |    37.1272  |  0.4264  | +long_term_debt_2010                 | 
|   40 |    38.0000  |  0.4264  | +revenue_2010                        | 
|   41 |    40.0000  |  0.4264  | +added_value_2010                    | 
|   42 |    42.0000  |  0.4264  | +cash_flow_2010                      | 
+----------------------------------------------------------------------+
* indicates the smallest value for Cp

The coefficient values for the minimum Cp */ 

* Logit Regression
preserve 
keep dummy_2013 nace control real_SA_2010 fin_cons_2010 misallocated_fixed_2010 dummy_patents ICR_failure_2010 NEG_VA_2010 solvency_ratio_2010 consdummy liquidity_return_2010
rename dummy_2013 dummy_zombie
rename real_SA_2010 real_SA
rename fin_cons_2010 fin_cons
rename misallocated_fixed_2010 misallocated_fixed
rename ICR_failure_2010 ICR_failure
rename NEG_VA_2010 NEG_VA
rename solvency_ratio_2010 solvency_ratio
rename liquidity_return_2010 liquidity_return
eststo: quietly logit dummy_zombie control real_SA fin_cons misallocated_fixed dummy_patents ICR_failure NEG_VA solvency_ratio consdummy liquidity_return, cluster(nace) robust
restore

*Zombies 2010/2012
*LASSO REGRESSION
lars dummy_2012 control consdummy area dummy_patents dummy_trademark tfp_acf_2009 shareholders_funds_2009 added_value_2009 cash_flow_2009 ebitda_2009 fin_rev_2009 liquidity_ratio_2009 total_assets_2009 depr_2009 long_term_debt_2009 employees_2009 materials_2009 loans_2009 wage_bill_2009 fixed_assets tax_2009 current_liabilities_2009 current_assets_2009 fin_expenses_2009 int_paid_2009 solvency_ratio_2009 net_income_2009 revenue_2009 capital_intensity_2009 fin_cons_2009 ICR_failure_2009 interest_diff_2009 NEG_VA_2009 real_SA_2009 profitability_2009 misallocated_fixed_2009 financial_sustainability_2009 liquidity_return_2009 int_fixed_assets_2009, a(lasso) cluster(nace) vce(robust)

/* Algorithm is lasso

Cp, R-squared and Actions along the sequence of models

+------------------------------------------------------------------+
| Step |      Cp     | R-square |  Action                          |
|------+-------------+----------+----------------------------------|
|    1 | 23454.0169  |  0.0000  |                                  | 
|    2 | 11355.8974  |  0.1773  | +control                         | 
|    3 |  8208.2362  |  0.2234  | +fin_cons_2009                   | 
|    4 |  4414.9727  |  0.2790  | +real_SA_2009                    | 
|    5 |  3067.3188  |  0.2988  | +liquidity_return_2009           | 
|    6 |  2344.4667  |  0.3094  | +misallocated_fixed_2009         | 
|    7 |  2108.8986  |  0.3129  | +ICR_failure_2009                | 
|    8 |  1927.7771  |  0.3156  | +dummy_patents                   | 
|    9 |  1859.5339  |  0.3166  | +dummy_trademark                 | 
|   10 |  1574.7311  |  0.3208  | +NEG_VA_2009                     | 
|   11 |  1485.7317  |  0.3222  | +area                            | 
|   12 |   884.2461  |  0.3310  | +solvency_ratio_2009             | 
|   13 |   743.0896  |  0.3331  | +profitability_2009              | 
|   14 |   638.4302  |  0.3347  | +interest_diff_2009              | 
|   15 |   612.9348  |  0.3351  | +financial_sustainability_2009   | 
|   16 |   550.7631  |  0.3360  | +consdummy                       | 
|   17 |   470.8475  |  0.3372  | +tfp_acf_2009                    | 
|   18 |   388.2985  |  0.3384  | +shareholders_funds_2009         | 
|   19 |   225.2814  |  0.3409  | +tax_2009                        | 
|   20 |   222.6511  |  0.3409  | +capital_intensity_2009          | 
|   21 |   134.9887  |  0.3422  | +depr_2009                       | 
|   22 |   123.2197  |  0.3424  | +int_fixed_assets_2009           | 
|   23 |    88.8640  |  0.3430  | +fin_expenses_2009               | 
|   24 |    73.3071  |  0.3432  | +liquidity_ratio_2009            | 
|   25 |    66.8867  |  0.3434  | +long_term_debt_2009             | 
|   26 |    67.8850  |  0.3434  | +current_assets_2009             | 
|   27 |    69.7268  |  0.3434  | +fin_rev_2009                    | 
|   28 |    50.7124  |  0.3437  | +loans_2009                      | 
|   29 |    39.5943  |  0.3439  | +fixed_assets                    | 
|   30 |    36.8376 *|  0.3439  | +wage_bill_2009                  | 
|   31 |    37.3247  |  0.3440  | +net_income_2009                 | 
|   32 |    37.4159  |  0.3440  | -fin_rev_2009 +materials_2009    | 
|   33 |    39.3164  |  0.3440  |                                  | 
|   34 |    41.2143  |  0.3440  | +ebitda_2009                     | 
|   35 |    42.6283  |  0.3440  | +fin_rev_2009 -net_income_2009   | 
|   36 |    40.6380  |  0.3441  | -fin_rev_2009                    | 
|   37 |    41.4782  |  0.3441  |                                  | 
|   38 |    41.8568  |  0.3441  | +int_paid_2009                   | 
|   39 |    43.3095  |  0.3441  | +cash_flow_2009                  | 
|   40 |    38.6447  |  0.3442  | +fin_rev_2009 -fin_expenses_2009 | 
|   41 |    39.7315  |  0.3442  |                                  | 
|   42 |    39.6681  |  0.3443  | +employees_2009                  | 
|   43 |    40.8837  |  0.3443  | +fin_expenses_2009               | 
|   44 |    41.0162  |  0.3443  | +current_liabilities_2009        | 
|   45 |    42.0000  |  0.3443  | +total_assets_2009               | 
|   46 |    44.0000  |  0.3443  | +revenue_2009                    | 
|   47 |    46.0000  |  0.3443  | +added_value_2009                | 
|   48 |    48.0000  |  0.3443  | +net_income_2009                 | 
+------------------------------------------------------------------+
* indicates the smallest value for Cp

The coefficient values for the minimum Cp */ 

* Logit Regression
preserve 
keep dummy_2012 nace control fin_cons_2009 real_SA_2009 liquidity_return_2009 misallocated_fixed_2009 ICR_failure_2009 dummy_patents NEG_VA_2009 dummy_trademark solvency_ratio_2009
rename dummy_2012 dummy_zombie
rename fin_cons_2009 fin_cons
rename real_SA_2009 real_SA
rename liquidity_return_2009 liquidity_return
rename misallocated_fixed_2009 misallocated_fixed
rename ICR_failure_2009 ICR_failure
rename NEG_VA_2009 NEG_VA
rename solvency_ratio_2009 solvency_ratio
eststo: quietly logit dummy_zombie control fin_cons real_SA liquidity_return misallocated_fixed ICR_failure dummy_patents NEG_VA dummy_trademark solvency_ratio, cluster(nace) robust
restore

*Zombies 2009/2011
*LASSO REGRESSION
lars dummy_2011 control consdummy area dummy_patents dummy_trademark tfp_acf_2008 shareholders_funds_2008 added_value_2008 cash_flow_2008 ebitda_2008 fin_rev_2008 liquidity_ratio_2008 total_assets_2008 depr_2008 long_term_debt_2008 employees_2008 materials_2008 loans_2008 wage_bill_2008 fixed_assets tax_2008 current_liabilities_2008 current_assets_2008 fin_expenses_2008 int_paid_2008 solvency_ratio_2008 net_income_2008 revenue_2008 capital_intensity_2008 fin_cons_2008 ICR_failure_2008 NEG_VA_2008 real_SA_2008 profitability_2008 misallocated_fixed_2008 financial_sustainability_2008 liquidity_return_2008 int_fixed_assets_2008, a(lasso) cluster(nace) vce(robust)

/* Algorithm is lasso

Cp, R-squared and Actions along the sequence of models

+----------------------------------------------------------------------+
| Step |      Cp     | R-square |  Action                              |
|------+-------------+----------+--------------------------------------|
|    1 | 21790.9728  |  0.0000  |                                      | 
|    2 | 11133.3029  |  0.1467  | +control                             | 
|    3 |  8612.0572  |  0.1814  | +fin_cons_2008                       | 
|    4 |  7686.1501  |  0.1942  | +real_SA_2008                        | 
|    5 |  2469.2846  |  0.2660  | +ICR_failure_2008                    | 
|    6 |  2079.3297  |  0.2714  | +liquidity_return_2008               | 
|    7 |  1990.1404  |  0.2727  | +NEG_VA_2008                         | 
|    8 |  1453.8699  |  0.2801  | +dummy_trademark                     | 
|    9 |  1038.1157  |  0.2858  | +profitability_2008                  | 
|   10 |   543.6777  |  0.2927  | +solvency_ratio_2008                 | 
|   11 |   495.0104  |  0.2934  | +consdummy                           | 
|   12 |   446.2795  |  0.2941  | +area                                | 
|   13 |   418.8278  |  0.2945  | +shareholders_funds_2008             | 
|   14 |   420.5749  |  0.2945  | +liquidity_ratio_2008                | 
|   15 |   319.3767  |  0.2959  | +ebitda_2008                         | 
|   16 |   216.3962  |  0.2973  | -ebitda_2008 +tax_2008               | 
|   17 |   162.6628  |  0.2981  |                                      | 
|   18 |   150.8382  |  0.2983  | +misallocated_fixed_2008             | 
|   19 |   144.0103  |  0.2984  | +depr_2008                           | 
|   20 |   139.9786  |  0.2985  | +capital_intensity_2008              | 
|   21 |   130.4496  |  0.2986  | +cash_flow_2008                      | 
|   22 |   108.9042  |  0.2990  | +int_fixed_assets_2008               | 
|   23 |    87.7261  |  0.2993  | +int_paid_2008                       | 
|   24 |    68.9854  |  0.2996  | -cash_flow_2008 +long_term_debt_2008 | 
|   25 |    50.7726  |  0.2999  |                                      | 
|   26 |    50.8488  |  0.2999  | +financial_sustainability_2008       | 
|   27 |    39.1457  |  0.3001  | +current_assets_2008                 | 
|   28 |    25.9032  |  0.3003  | +employees_2008                      | 
|   29 |    27.7824  |  0.3003  | +tfp_acf_2008                        | 
|   30 |    29.6715  |  0.3003  | +dummy_patents                       | 
|   31 |    24.8895  |  0.3004  | +fin_rev_2008                        | 
|   32 |    25.0236  |  0.3004  | +revenue_2008                        | 
|   33 |    24.0994 *|  0.3004  | +wage_bill_2008                      | 
|   34 |    25.2426  |  0.3005  | +loans_2008                          | 
|   35 |    27.2254  |  0.3005  | +net_income_2008                     | 
|   36 |    29.2108  |  0.3005  | +ebitda_2008 -net_income_2008        | 
|   37 |    30.3936  |  0.3005  |                                      | 
|   38 |    31.8196  |  0.3005  | +fin_expenses_2008                   | 
|   39 |    33.1574  |  0.3005  | +cash_flow_2008 -revenue_2008        | 
|   40 |    35.0258  |  0.3005  |                                      | 
|   41 |    35.9468  |  0.3005  | +total_assets_2008                   | 
|   42 |    37.7701  |  0.3005  | +materials_2008                      | 
|   43 |    39.2470  |  0.3005  | +current_liabilities_2008            | 
|   44 |    41.1686  |  0.3005  | +revenue_2008                        | 
|   45 |    43.0000  |  0.3005  | +fixed_assets                        | 
|   46 |    45.0000  |  0.3005  | +added_value_2008                    | 
|   47 |    47.0000  |  0.3005  | +net_income_2008                     | 
+----------------------------------------------------------------------+
* indicates the smallest value for Cp

The coefficient values for the minimum Cp */ 

* Logit Regression
preserve 
keep dummy_2011 nace control fin_cons_2008 real_SA_2008 ICR_failure_2008 liquidity_return_2008 NEG_VA_2008 dummy_trademark profitability_2008 solvency_ratio_2008 consdummy
rename dummy_2011 dummy_zombie
rename fin_cons_2008 fin_cons
rename real_SA_2008 real_SA
rename ICR_failure_2008 ICR_failure
rename liquidity_return_2008 liquidity_return
rename NEG_VA_2008 NEG_VA
rename profitability_2008 profitability
rename solvency_ratio_2008 solvency_ratio
eststo: quietly logit dummy_zombie control fin_cons real_SA ICR_failure liquidity_return NEG_VA dummy_trademark profitability solvency_ratio consdummy, cluster(nace) robust
restore 

* Get Latex Table
esttab using logit_regressions.tex, label nostar ///
title(Logistic Regressions \label{tab1})
