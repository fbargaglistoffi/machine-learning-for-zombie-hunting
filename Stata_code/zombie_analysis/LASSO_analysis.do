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
