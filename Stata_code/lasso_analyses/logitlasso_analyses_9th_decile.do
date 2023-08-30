********************************************************************************
*                                                                              *
*     Logit-Lasso Analyses for "Machine Learning for Zombie Hunting" paper     *
*                                                                              *
********************************************************************************

* Change path accordingly
cd "H:\.shortcut-targets-by-id\1keYb51HXkcQwzkU2kBgbnguQaqUy3umX\Zombie Hunting New Data"

* Load data from yeay-by-year analysis 
use "data_failure.dta", clear


*****************************   Failure 2017    ********************************

* Perform logistic lasso and select the tuning parameter λ as the value that minimizes the EBIC
lassologit failure_2017 control consdummy area dummy_patents dummy_trademark tfp_acf_2016 shareholders_funds_2016 added_value_2016 cash_flow_2016 ebitda_2016 fin_rev_2016 liquidity_ratio_2016 total_assets_2016 depr_2016 long_term_debt_2016 employees_2016 materials_2016 loans_2016 wage_bill_2016 fixed_assets tax_2016 current_liabilities_2016 current_assets_2016 fin_expenses_2016 int_paid_2016 solvency_ratio_2016 net_income_2016 revenue_2016 capital_intensity_2016 fin_cons_2016 ICR_failure_2016 interest_diff_2016 NEG_VA_2016 real_SA_2016 profitability_2016 misallocated_fixed_2016 financial_sustainability_2016 liquidity_return_2016 int_fixed_assets_2016 
/*
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1 2642.54763     0     3.99248  17525.77223  -0.0000  | Added _cons.
     2|   2 2405.50630     1     4.74277  17058.49095   0.0266  | Added liquidity_return_2016.
     3|   4 1993.30541     2     5.70054  16544.75950   0.0559  | Added NEG_VA_2016.
     4|   6 1651.73812     3     6.49071  16062.54699   0.0834  | Added control.
     5|   7 1503.57420     5     6.82195  15622.78318   0.1085  | Added fin_cons_2016 ICR_failure_2016.
     6|   8 1368.70086     6     7.14787  15235.23495   0.1306  | Added profitability_2016.
     7|  14  778.77245     7     8.63705  13937.18794   0.2046  | Added solvency_ratio_2016.
     8|  22  367.18080     8     9.33878  13295.68910   0.2412  | Added real_SA_2016.
     9|  27  229.50827     9     9.18283  13115.43900   0.2514  | Added liquidity_ratio_2016.
    10|  40   67.63727    11     9.12544  12972.42607   0.2595  | Added capital_intensity_2016 interest_diff_2016.
    11|  46   38.48470    12     9.18392  12958.28882   0.2603  | Added financial_sustainability_2016.
    12|  50   26.42548    13     9.21599  12953.95676   0.2606  | Added misallocated_fixed_2016.

*/


* Perform logistic lasso implementing theory-driven penalization (see e.g. Belloni, Chernozhukov & Wei, 2016).
rlassologit failure_2017 control consdummy area dummy_patents dummy_trademark tfp_acf_2016 shareholders_funds_2016 added_value_2016 cash_flow_2016 ebitda_2016 fin_rev_2016 liquidity_ratio_2016 total_assets_2016 depr_2016 long_term_debt_2016 employees_2016 materials_2016 loans_2016 wage_bill_2016 fixed_assets tax_2016 current_liabilities_2016 current_assets_2016 fin_expenses_2016 int_paid_2016 solvency_ratio_2016 net_income_2016 revenue_2016 capital_intensity_2016 fin_cons_2016 ICR_failure_2016 interest_diff_2016 NEG_VA_2016 real_SA_2016 profitability_2016 misallocated_fixed_2016 financial_sustainability_2016 liquidity_return_2016 int_fixed_assets_2016
/*
---------------------------------------------------
         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
          control |      -1.7002682     -2.8535693
solvency_rat~2016 |      -0.0053334     -0.0111485
    fin_cons_2016 |       0.3914565      0.4722172
 ICR_failure_2016 |       0.7673899      1.0373748
      NEG_VA_2016 |       0.6877306      0.7815717
profitabilit~2016 |       0.3892122      0.4171551
liquidity_re~2016 |      -1.6383041     -1.3941074
            _cons |      -3.6694054     -3.6114011
---------------------------------------------------
*/


* Logistic regression
preserve
keep failure_2017 control solvency_ratio_2016 fin_cons_2016 ICR_failure_2016 NEG_VA_2016 profitability_2016 liquidity_return_2016 nace
rename failure_2017 failure
rename solvency_ratio_2016 solvency_ratio
rename fin_cons_2016 fin_cons
rename ICR_failure_2016 ICR_failure
rename NEG_VA_2016 NEG_VA
rename profitability_2016 profitability
rename liquidity_return_2016 liquidity_return
eststo: logit failure control solvency_ratio fin_cons ICR_failure NEG_VA profitability liquidity_return, cluster(nace) robust
restore
/*
Logistic regression                                    Number of obs =  99,622
                                                       Wald chi2(7)  = 3860.58
                                                       Prob > chi2   =  0.0000
Log pseudolikelihood = -7081.7274                      Pseudo R2     =  0.2585

                                      (Std. err. adjusted for 24 clusters in nace)
----------------------------------------------------------------------------------
                 |               Robust
         failure | Coefficient  std. err.      z    P>|z|     [95% conf. interval]
-----------------+----------------------------------------------------------------
         control |  -2.861979   .0920447   -31.09   0.000    -3.042383   -2.681575
  solvency_ratio |  -.0107607   .0013158    -8.18   0.000    -.0133396   -.0081817
        fin_cons |   .5304546   .1470435     3.61   0.000     .2422546    .8186546
     ICR_failure |   1.004094   .1159239     8.66   0.000     .7768877    1.231301
          NEG_VA |   .8044747   .0920392     8.74   0.000     .6240812    .9848683
   profitability |   .4572739   .0891563     5.13   0.000     .2825307    .6320171
liquidity_return |  -1.200419   .1789455    -6.71   0.000    -1.551146   -.8496927
           _cons |  -3.580041   .0735192   -48.70   0.000    -3.724136   -3.435946
----------------------------------------------------------------------------------
(est1 stored)
*/










*****************************   Failure 2016    ********************************

* Perform logistic lasso and select the tuning parameter λ as the value that minimizes the EBIC
lassologit failure_2016 control consdummy area dummy_patents dummy_trademark tfp_acf_2016 shareholders_funds_2016 added_value_2016 cash_flow_2016 ebitda_2016 fin_rev_2016 liquidity_ratio_2016 total_assets_2016 depr_2016 long_term_debt_2016 employees_2016 materials_2016 loans_2016 wage_bill_2016 fixed_assets tax_2016 current_liabilities_2016 current_assets_2016 fin_expenses_2016 int_paid_2016 solvency_ratio_2016 net_income_2016 revenue_2016 capital_intensity_2016 fin_cons_2016 ICR_failure_2016 interest_diff_2016 NEG_VA_2016 real_SA_2016 profitability_2016 misallocated_fixed_2016 financial_sustainability_2016 liquidity_return_2016 int_fixed_assets_2016 
/*
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1  506.89163     0     6.10864   3057.19187   0.0000  | Added NEG_VA_2016 _cons.
     2|   8  262.54323     2     8.74429   2758.38036   0.0975  | Added fin_cons_2016.
     3|  10  217.55455     3     9.22758   2690.45858   0.1196  | Added ICR_failure_2016.
     4|  11  198.03951     5     9.44984   2645.75439   0.1339  | Added control solvency_ratio_2016.
     5|  27   44.02411     6    11.40859   2319.33267   0.2405  | Added real_SA_2016.
     6|  28   40.07507     7    11.39808   2313.57494   0.2423  | Added liquidity_ratio_2016.
     7|  29   36.48026     8    11.42502   2307.59373   0.2441  | Added liquidity_return_2016.
     8|  35   20.75678     9    12.02854   2281.94688   0.2524  | Added capital_intensity_2016.
     9|  40   12.97413    10    12.37026   2272.28337   0.2554  | Added tfp_acf_2016.
    10|  44    8.90867    11    12.59908   2267.83259   0.2567  | Added loans_2016 net_income_2016.
    11|  47    6.71992    13    12.77297   2264.35591   0.2576  | Added financial_sustainability_2016.
    12|  49    5.56841    14    12.88234   2262.57848   0.2580  | Added dummy_patents.

*/


* Perform logistic lasso implementing theory-driven penalization (see e.g. Belloni, Chernozhukov & Wei, 2016).
rlassologit failure_2016 control consdummy area dummy_patents dummy_trademark tfp_acf_2015 shareholders_funds_2015 added_value_2015 cash_flow_2015 ebitda_2015 fin_rev_2015 liquidity_ratio_2015 total_assets_2015 depr_2015 long_term_debt_2015 employees_2015 materials_2015 loans_2015 wage_bill_2015 fixed_assets tax_2015 current_liabilities_2015 current_assets_2015 fin_expenses_2015 int_paid_2015 solvency_ratio_2015 net_income_2015 revenue_2015 capital_intensity_2015 fin_cons_2015 ICR_failure_2015 interest_diff_2015 NEG_VA_2015 real_SA_2015 profitability_2015 misallocated_fixed_2015 financial_sustainability_2015 liquidity_return_2015 int_fixed_assets_2015
/*
---------------------------------------------------
         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
          control |      -1.5545759     -3.7495205
solvency_rat~2015 |      -0.0026245     -0.0106130
    fin_cons_2015 |       0.4717151      0.5227142
 ICR_failure_2015 |       0.5224815      0.9491754
      NEG_VA_2015 |       0.9180250      0.8831138
profitabilit~2015 |       0.2288277      0.3147237
liquidity_re~2015 |      -0.6657376     -0.5116820
            _cons |      -4.1187231     -4.0245945
---------------------------------------------------

*/


* Logistic regression
preserve
keep failure_2016 control solvency_ratio_2015 fin_cons_2015 ICR_failure_2015 NEG_VA_2015 profitability_2015 liquidity_return_2015 nace
rename failure_2016 failure
rename solvency_ratio_2015 solvency_ratio
rename fin_cons_2015 fin_cons
rename ICR_failure_2015 ICR_failure
rename NEG_VA_2015 NEG_VA
rename profitability_2015 profitability
rename liquidity_return_2015 liquidity_return
eststo: logit failure control solvency_ratio fin_cons ICR_failure NEG_VA profitability liquidity_return, cluster(nace) robust
restore
/*
Logistic regression                                    Number of obs = 102,046
                                                       Wald chi2(7)  = 2550.47
                                                       Prob > chi2   =  0.0000
Log pseudolikelihood = -5424.6524                      Pseudo R2     =  0.2151

                                      (Std. err. adjusted for 24 clusters in nace)
----------------------------------------------------------------------------------
                 |               Robust
         failure | Coefficient  std. err.      z    P>|z|     [95% conf. interval]
-----------------+----------------------------------------------------------------
         control |  -3.714387   .1415079   -26.25   0.000    -3.991738   -3.437037
  solvency_ratio |  -.0080209   .0012238    -6.55   0.000    -.0104195   -.0056223
        fin_cons |   .6463131   .1237746     5.22   0.000     .4037194    .8889068
     ICR_failure |   .8843364   .0992818     8.91   0.000     .6897476    1.078925
          NEG_VA |   .8949047   .0777401    11.51   0.000      .742537    1.047272
   profitability |   .3115016   .0963724     3.23   0.001     .1226151     .500388
liquidity_return |  -.0000107   .0000101    -1.06   0.291    -.0000305    9.13e-06
           _cons |  -4.147842   .0743607   -55.78   0.000    -4.293586   -4.002097
----------------------------------------------------------------------------------
(est2 stored)
*/









*****************************   Failure 2015    ********************************

* Perform logistic lasso implementing theory-driven penalization (see e.g. Belloni, Chernozhukov & Wei, 2015).
rlassologit failure_2015 control consdummy area dummy_patents dummy_trademark tfp_acf_2014 shareholders_funds_2014 added_value_2014 cash_flow_2014 ebitda_2014 fin_rev_2014 liquidity_ratio_2014 total_assets_2014 depr_2014 long_term_debt_2014 employees_2014 materials_2014 loans_2014 wage_bill_2014 fixed_assets tax_2014 current_liabilities_2014 current_assets_2014 fin_expenses_2014 int_paid_2014 solvency_ratio_2014 net_income_2014 revenue_2014 capital_intensity_2014 fin_cons_2014 ICR_failure_2014 interest_diff_2014 NEG_VA_2014 real_SA_2014 profitability_2014 misallocated_fixed_2014 financial_sustainability_2014 liquidity_return_2014 int_fixed_assets_2014
/*
---------------------------------------------------
         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
          control |      -1.3403385     -3.3479423
solvency_rat~2014 |      -0.0038028     -0.0119586
    fin_cons_2014 |       0.3511827      0.4052215
 ICR_failure_2014 |       0.5736445      1.0684642
      NEG_VA_2014 |       1.1499400      1.0049681
profitabilit~2014 |       0.4204097      0.4465146
            _cons |      -4.2663699     -4.2017847
---------------------------------------------------

*/


* Logistic regression
preserve
keep failure_2015 control solvency_ratio_2014 fin_cons_2014 ICR_failure_2014 NEG_VA_2014 profitability_2014 nace
rename failure_2015 failure
rename solvency_ratio_2014 solvency_ratio
rename fin_cons_2014 fin_cons
rename ICR_failure_2014 ICR_failure
rename NEG_VA_2014 NEG_VA
rename profitability_2014 profitability
eststo: logit failure control solvency_ratio fin_cons ICR_failure NEG_VA profitability, cluster(nace) robust
restore
/*
Logistic regression                                    Number of obs =  99,769
                                                       Wald chi2(6)  = 3906.44
                                                       Prob > chi2   =  0.0000
Log pseudolikelihood = -5124.4574                      Pseudo R2     =  0.2043

                                    (Std. err. adjusted for 24 clusters in nace)
--------------------------------------------------------------------------------
               |               Robust
       failure | Coefficient  std. err.      z    P>|z|     [95% conf. interval]
---------------+----------------------------------------------------------------
       control |  -3.329012   .1484754   -22.42   0.000    -3.620018   -3.038005
solvency_ratio |  -.0066683   .0010081    -6.61   0.000    -.0086442   -.0046925
      fin_cons |   .4516798   .1535914     2.94   0.003     .1506463    .7527133
   ICR_failure |    .948433   .1011568     9.38   0.000     .7501694    1.146697
        NEG_VA |   1.049704   .0927686    11.32   0.000     .8678813    1.231527
 profitability |   .4439957   .1074198     4.13   0.000     .2334567    .6545347
         _cons |  -4.327756   .0747274   -57.91   0.000    -4.474219   -4.181293
--------------------------------------------------------------------------------
(est4 stored)
*/





*****************************   Failure 2014  ********************************

* Perform logistic lasso implementing theory-driven penalization (see e.g. Belloni, Chernozhukov & Wei, 2014).
rlassologit failure_2014 control consdummy area dummy_patents dummy_trademark tfp_acf_2013 shareholders_funds_2013 added_value_2013 cash_flow_2013 ebitda_2013 fin_rev_2013 liquidity_ratio_2013 total_assets_2013 depr_2013 long_term_debt_2013 employees_2013 materials_2013 loans_2013 wage_bill_2013 fixed_assets tax_2013 current_liabilities_2013 current_assets_2013 fin_expenses_2013 int_paid_2013 solvency_ratio_2013 net_income_2013 revenue_2013 capital_intensity_2013 fin_cons_2013 ICR_failure_2013 interest_diff_2013 NEG_VA_2013 real_SA_2013 profitability_2013 misallocated_fixed_2013 financial_sustainability_2013 liquidity_return_2013 int_fixed_assets_2013
/*
---------------------------------------------------
         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
solvency_rat~2013 |      -0.0004975     -0.0191726
    fin_cons_2013 |       0.0838330      2.1866083
      NEG_VA_2013 |       1.7490431      1.1827171
profitabilit~2013 |       0.3580770      0.3753632
liquidity_re~2013 |      -0.8673540     -0.2020525
            _cons |      -5.5258411     -6.4364436
---------------------------------------------------
*/


* Logistic regression
preserve
keep failure_2014 solvency_ratio_2013 fin_cons_2013 NEG_VA_2013 profitability_2013 liquidity_return_2013 nace
rename failure_2014 failure
rename solvency_ratio_2013 solvency_ratio
rename fin_cons_2013 fin_cons
rename NEG_VA_2013 NEG_VA
rename profitability_2013 profitability
rename liquidity_return_2013 liquidity_return
eststo: logit failure solvency_ratio fin_cons NEG_VA profitability liquidity_return, cluster(nace) robust
restore
/*
Logistic regression                                    Number of obs =  95,702
                                                       Wald chi2(5)  = 1668.99
                                                       Prob > chi2   =  0.0000
Log pseudolikelihood = -2305.3063                      Pseudo R2     =  0.1676

                                      (Std. err. adjusted for 24 clusters in nace)
----------------------------------------------------------------------------------
                 |               Robust
         failure | Coefficient  std. err.      z    P>|z|     [95% conf. interval]
-----------------+----------------------------------------------------------------
  solvency_ratio |   -.016785   .0017539    -9.57   0.000    -.0202226   -.0133474
        fin_cons |   2.091582   .1823738    11.47   0.000     1.734136    2.449029
          NEG_VA |   1.203933   .1489207     8.08   0.000     .9120534    1.495812
   profitability |   .3450108    .115707     2.98   0.003     .1182292    .5717924
liquidity_return |  -.1223442    .157186    -0.78   0.436    -.4304231    .1857348
           _cons |  -6.474643   .1326971   -48.79   0.000    -6.734725   -6.214562
----------------------------------------------------------------------------------
(est5 stored)

*/





*****************************   Failure 2013  ********************************

* Perform logistic lasso implementing theory-driven penalization (see e.g. Belloni, Chernozhukov & Wei, 2013).
rlassologit failure_2013 control consdummy area dummy_patents dummy_trademark tfp_acf_2012 shareholders_funds_2012 added_value_2012 cash_flow_2012 ebitda_2012 fin_rev_2012 liquidity_ratio_2012 total_assets_2012 depr_2012 long_term_debt_2012 employees_2012 materials_2012 loans_2012 wage_bill_2012 fixed_assets tax_2012 current_liabilities_2012 current_assets_2012 fin_expenses_2012 int_paid_2012 solvency_ratio_2012 net_income_2012 revenue_2012 capital_intensity_2012 fin_cons_2012 ICR_failure_2012 interest_diff_2012 NEG_VA_2012 real_SA_2012 profitability_2012 misallocated_fixed_2012 financial_sustainability_2012 liquidity_return_2012 int_fixed_assets_2012
/*
---------------------------------------------------
         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
      NEG_VA_2012 |       0.7878661      1.1433477
profitabilit~2012 |       0.0367679      1.4190819
liquidity_re~2012 |      -1.9095983     -2.4360075
            _cons |      -5.4671410     -5.7769839
---------------------------------------------------

*/


* Logistic regression
preserve
keep failure_2013 profitability_2012 liquidity_return_2012 nace
rename failure_2013 failure
rename profitability_2012 profitability
rename liquidity_return_2012 liquidity_return
set maxiter 10
eststo: logit failure profitability liquidity_return, cluster(nace) robust 
restore
/*
Logistic regression                                    Number of obs = 101,270
                                                       Wald chi2(2)  =  444.08
                                                       Prob > chi2   =  0.0000
Log pseudolikelihood = -2898.5129                      Pseudo R2     =  0.0653

                                      (Std. err. adjusted for 24 clusters in nace)
----------------------------------------------------------------------------------
                 |               Robust
         failure | Coefficient  std. err.      z    P>|z|     [95% conf. interval]
-----------------+----------------------------------------------------------------
   profitability |   2.549362    .797802     3.20   0.001     .9856988    4.113025
liquidity_return |  -.3032606   2.349459    -0.13   0.897    -4.908116    4.301595
           _cons |  -5.633693   .0904735   -62.27   0.000    -5.811018   -5.456368
----------------------------------------------------------------------------------
*/




* Get table
esttab est1 est2 est3 est4 est5
/*
--------------------------------------------------------------------------------------------
                      (1)             (2)             (3)             (4)             (5)   
 Failure             2017           2016             2015            2014           2013   
--------------------------------------------------------------------------------------------                                                                                    
control            -2.862***       -3.714***       -3.328***       -3.329***                
                 (-31.09)        (-26.25)        (-22.45)        (-22.42)                   

solvency_r~o      -0.0108***     -0.00802***     -0.00678***     -0.00667***      -0.0168***
                  (-8.18)         (-6.55)         (-6.63)         (-6.61)         (-9.57)   

fin_cons            0.530***        0.646***        0.454**         0.452**         2.092***
                   (3.61)          (5.22)          (2.97)          (2.94)         (11.47)   

ICR_failure         1.004***        0.884***        0.950***        0.948***                
                   (8.66)          (8.91)          (9.36)          (9.38)                   

NEG_VA              0.804***        0.895***        1.052***        1.050***        1.204***
                   (8.74)         (11.51)         (11.20)         (11.32)          (8.08)   

profitabil~y        0.457***        0.312**         0.443***        0.444***        0.345** 
                   (5.13)          (3.23)          (4.14)          (4.13)          (2.98)   

liquidity_~n       -1.200***   -0.0000107          0.0165**                        -0.122   
                  (-6.71)         (-1.06)          (2.92)                         (-0.78)   

_cons              -3.580***       -4.148***       -4.329***       -4.328***       -6.475***
                 (-48.70)        (-55.78)        (-58.11)        (-57.91)        (-48.79)   
--------------------------------------------------------------------------------------------
N                   99622          102046           99769           99769           95702   
--------------------------------------------------------------------------------------------
t statistics in parentheses
* p<0.05, ** p<0.01, *** p<0.001
*/






