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




*****************************   Failure 2015    ********************************

* Perform logistic lasso and select the tuning parameter λ as the value that minimizes the EBIC
lassologit failure_2015 control consdummy area dummy_patents dummy_trademark tfp_acf_2014 shareholders_funds_2014 added_value_2014 cash_flow_2014 ebitda_2014 fin_rev_2014 liquidity_ratio_2014 total_assets_2014 depr_2014 long_term_debt_2014 employees_2014 materials_2014 loans_2014 wage_bill_2014 fixed_assets tax_2014 current_liabilities_2014 current_assets_2014 fin_expenses_2014 int_paid_2014 solvency_ratio_2014 net_income_2014 revenue_2014 capital_intensity_2014 fin_cons_2014 ICR_failure_2014 interest_diff_2014 NEG_VA_2014 real_SA_2014 profitability_2014 misallocated_fixed_2014 financial_sustainability_2014 liquidity_return_2014 int_fixed_assets_2014
/*
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1 1309.68945     0     4.43297  11497.79634   0.0000  | Added NEG_VA_2014 _cons.
     2|   4  987.91447     2     5.72078  10936.91151   0.0487  | Added control.
     3|   5  899.29675     4     6.09267  10655.15107   0.0732  | Added fin_cons_2014 ICR_failure_2014.
     4|   6  818.62819     5     6.48373  10402.48048   0.0951  | Added profitability_2014.
     5|  10  562.11010     6     7.63143   9772.60566   0.1499  | Added solvency_ratio_2014.
     6|  16  319.83312     7     8.30971   9286.72194   0.1921  | Added real_SA_2014.
     7|  22  181.98076     8     8.12786   9041.64848   0.2134  | Added liquidity_ratio_2014.
     8|  31   78.10495    10     8.21999   8902.06285   0.2255  | Added area capital_intensity_2014.
     9|  34   58.91550    11     8.22042   8881.97089   0.2272  | Added interest_diff_2014.
    10|  35   53.63067    12     8.23428   8874.24826   0.2278  | Added depr_2014.
    11|  36   48.81990    13     8.51267   8866.30372   0.2285  | Added consdummy ebitda_2014.
    12|  38   40.45426    13     8.90612   8855.45227   0.2294  | Added shareholders_funds_2014.
    13|  41   30.51513    13     9.30784   8844.72292   0.2304  | Added materials_2014. Removed depr_2014.
    14|  42   27.77787    14     9.41014   8842.04676   0.2306  | Added misallocated_fixed_2014.
    15|  43   25.28614    15     9.49946   8837.40759   0.2309  | Added depr_2014 long_term_debt_2014.
    16|  45   20.95318    16     9.63162   8831.15313   0.2315  | Added fin_expenses_2014.
    17|  50   13.09689    18     9.90579   8823.14389   0.2321  | Added dummy_trademark.
*/


* Perform logistic lasso implementing theory-driven penalization ((see e.g. Belloni, Chernozhukov & Wei, 2016).
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






*****************************   Failure 2014  ********************************

* Perform logistic lasso and select the tuning parameter λ as the value that minimizes the EBIC
lassologit failure_2014 control consdummy area dummy_patents dummy_trademark tfp_acf_2013 shareholders_funds_2013 added_value_2013 cash_flow_2013 ebitda_2013 fin_rev_2013 liquidity_ratio_2013 total_assets_2013 depr_2013 long_term_debt_2013 employees_2013 materials_2013 loans_2013 wage_bill_2013 fixed_assets tax_2013 current_liabilities_2013 current_assets_2013 fin_expenses_2013 int_paid_2013 solvency_ratio_2013 net_income_2013 revenue_2013 capital_intensity_2013 fin_cons_2013 ICR_failure_2013 interest_diff_2013 NEG_VA_2013 real_SA_2013 profitability_2013 misallocated_fixed_2013 financial_sustainability_2013 liquidity_return_2013 int_fixed_assets_2013
/*
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1  790.05523     0     5.37930   5015.93850  -0.0000  | Added _cons.
     2|   2  719.18584     1     6.24759   4834.56110   0.0361  | Added NEG_VA_2013.
     3|   4  595.94815     2     7.16347   4680.78204   0.0667  | Added liquidity_return_2013.
     4|   7  449.53084     3     8.17928   4550.80128   0.0926  | Added profitability_2013.
     5|   9  372.50048     5     8.65653   4439.01638   0.1147  | Added solvency_ratio_2013 fin_cons_2013.
     6|  10  339.08651     6     8.78788   4370.43166   0.1283  | Added control.
     7|  18  159.87476     7     9.88070   3955.33837   0.2110  | Added ICR_failure_2013.
     8|  20  132.47906     8     9.90782   3903.56556   0.2213  | Added real_SA_2013.
     9|  28   62.46211     9     9.43934   3782.72871   0.2453  | Added tfp_acf_2013.
    10|  32   42.88953    10     9.45353   3754.00586   0.2510  | Added liquidity_ratio_2013.
    11|  37   26.80833    11     9.55369   3734.16088   0.2549  | Added dummy_trademark.
    12|  42   16.75668    12     9.78728   3724.81763   0.2567  | Added misallocated_fixed_2013.
    13|  45   12.63977    13     9.99030   3720.92921   0.2574  | Added dummy_patents.
*/

* Perform logistic lasso implementing theory-driven penalization (see e.g. Belloni, Chernozhukov & Wei, 2016).
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





*****************************   Failure 2013  ********************************

* Perform logistic lasso and select the tuning parameter λ as the value that minimizes the EBIC
lassologit failure_2013 control consdummy area dummy_patents dummy_trademark tfp_acf_2012 shareholders_funds_2012 added_value_2012 cash_flow_2012 ebitda_2012 fin_rev_2012 liquidity_ratio_2012 total_assets_2012 depr_2012 long_term_debt_2012 employees_2012 materials_2012 loans_2012 wage_bill_2012 fixed_assets tax_2012 current_liabilities_2012 current_assets_2012 fin_expenses_2012 int_paid_2012 solvency_ratio_2012 net_income_2012 revenue_2012 capital_intensity_2012 fin_cons_2012 ICR_failure_2012 interest_diff_2012 NEG_VA_2012 real_SA_2012 profitability_2012 misallocated_fixed_2012 financial_sustainability_2012 liquidity_return_2012 int_fixed_assets_2012
/*
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1  618.96645     0     5.48342   4436.08177  -0.0000  | Added _cons.
     2|   2  563.44403     1     6.40578   4318.58040   0.0264  | Added liquidity_return_2012.
     3|   3  512.90208     2     6.86933   4264.33203   0.0386  | Added NEG_VA_2012.
     4|   6  386.88819     3     8.16755   4122.21608   0.0706  | Added profitability_2012.
     5|   8  320.59211     4     8.70487   4040.53845   0.0889  | Added solvency_ratio_2012.
     6|  10  265.65633     6     8.77897   3938.26258   0.1119  | Added control fin_cons_2012.
     7|  17  137.59602     7     9.35494   3644.62125   0.1780  | Added real_SA_2012.
     8|  21   94.48015     8     8.89119   3553.84427   0.1984  | Added ICR_failure_2012.
     9|  31   36.91283     9     8.37309   3470.21928   0.2172  | Added dummy_patents.
    10|  33   30.58755    10     8.43513   3463.02722   0.2188  | Added tfp_acf_2012.
    11|  36   23.07255    12     8.52644   3453.96931   0.2207  | Added area misallocated_fixed_2012.
    12|  40   15.84274    13     8.89052   3444.35812   0.2228  | Added dummy_trademark.
    13|  41   14.42162    14     8.98809   3442.48409   0.2232  | Added financial_sustainability_2012.
    14|  42   13.12797    15     9.07940   3440.82309   0.2235  | Added interest_diff_2012.
    15|  49    6.79960    16     9.55990   3434.48509   0.2249  | Added liquidity_ratio_2012.
    16|  50    6.18966    17     9.62207   3433.64577   0.2250  | Added net_income_2012.
*/

* Perform logistic lasso implementing theory-driven penalization (see e.g. Belloni, Chernozhukov & Wei, 2016).
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





*****************************   Failure 2012  ********************************

* Perform logistic lasso and select the tuning parameter λ as the value that minimizes the EBIC
lassologit failure_2012 control consdummy area dummy_patents dummy_trademark tfp_acf_2011 shareholders_funds_2011 added_value_2011 cash_flow_2011 ebitda_2011 fin_rev_2011 liquidity_ratio_2011 total_assets_2011 depr_2011 long_term_debt_2011 employees_2011 materials_2011 loans_2011 wage_bill_2011 fixed_assets tax_2011 current_liabilities_2011 current_assets_2011 fin_expenses_2011 int_paid_2011 solvency_ratio_2011 net_income_2011 revenue_2011 capital_intensity_2011 fin_cons_2011 ICR_failure_2011 interest_diff_2011 NEG_VA_2011 real_SA_2011 profitability_2011 misallocated_fixed_2011 financial_sustainability_2011 liquidity_return_2011 int_fixed_assets_2011
/*
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1  398.74437     0     5.89741   2938.88190   0.0000  | Added _cons.
     2|   2  362.97627     2     7.22370   2800.09131   0.0471  | Added NEG_VA_2011 profitability_2011.
     3|   6  249.23724     3     8.96944   2642.87567   0.1005  | Added fin_cons_2011.
     4|  10  171.13846     5     9.90881   2515.44364   0.1437  | Added control solvency_ratio_2011.
     5|  14  117.51203     6    10.38463   2378.75448   0.1902  | Added ICR_failure_2011.
     6|  16   97.37549     7    10.59677   2335.19841   0.2049  | Added liquidity_return_2011.
     7|  23   50.43539     8    11.64566   2253.09948   0.2328  | Added real_SA_2011.
     8|  30   26.12288    10    11.73216   2218.75380   0.2444  | Added dummy_patents dummy_trademark.
     9|  33   19.70480    11    12.02575   2209.83668   0.2473  | Added tfp_acf_2011.
    10|  34   17.93725    12    12.09987   2207.16292   0.2482  | Added area.
    11|  37   13.53028    13    12.27577   2201.15038   0.2502  | Added financial_sustainability_2011.
    12|  39   11.21177    14    12.38592   2198.16862   0.2511  | Added interest_diff_2011.
    13|  40   10.20605    15    12.45461   2196.58850   0.2516  | Added misallocated_fixed_2011.
    14|  41    9.29055    16    12.54678   2194.99899   0.2521  | Added capital_intensity_2011.
    15|  43    7.69855    17    12.72197   2192.47962   0.2528  | Added liquidity_ratio_2011.
    16|  45    6.37935    18    12.89512   2190.19849   0.2536  | Added loans_2011.
*/

* Perform logistic lasso implementing theory-driven penalization (see e.g. Belloni, Chernozhukov & Wei, 2016).
rlassologit failure_2012 control consdummy area dummy_patents dummy_trademark tfp_acf_2011 shareholders_funds_2011 added_value_2011 cash_flow_2011 ebitda_2011 fin_rev_2011 liquidity_ratio_2011 total_assets_2011 depr_2011 long_term_debt_2011 employees_2011 materials_2011 loans_2011 wage_bill_2011 fixed_assets tax_2011 current_liabilities_2011 current_assets_2011 fin_expenses_2011 int_paid_2011 solvency_ratio_2011 net_income_2011 revenue_2011 capital_intensity_2011 fin_cons_2011 ICR_failure_2011 interest_diff_2011 NEG_VA_2011 real_SA_2011 profitability_2011 misallocated_fixed_2011 financial_sustainability_2011 liquidity_return_2011 int_fixed_assets_2011
/*
---------------------------------------------------
         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
      NEG_VA_2011 |       0.5933598      2.0434495
profitabilit~2011 |       0.4768349      2.3124327
            _cons |      -5.9280760     -6.3534460
---------------------------------------------------
*/





*****************************   Failure 2011  ********************************

* Perform logistic lasso and select the tuning parameter λ as the value that minimizes the EBIC
lassologit failure_2011 control consdummy area dummy_patents dummy_trademark tfp_acf_2010 shareholders_funds_2010 added_value_2010 cash_flow_2010 ebitda_2010 fin_rev_2010 liquidity_ratio_2010 total_assets_2010 depr_2010 long_term_debt_2010 employees_2010 materials_2010 loans_2010 wage_bill_2010 fixed_assets tax_2010 current_liabilities_2010 current_assets_2010 fin_expenses_2010 int_paid_2010 solvency_ratio_2010 net_income_2010 revenue_2010 capital_intensity_2010 fin_cons_2010 ICR_failure_2010 interest_diff_2010 NEG_VA_2010 real_SA_2010 profitability_2010 misallocated_fixed_2010 financial_sustainability_2010 liquidity_return_2010 int_fixed_assets_2010
/*
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1  249.27813     0     5.94768   1514.87773  -0.0000  | Added _cons.
     2|   2  226.91742     1     7.03838   1458.50284   0.0375  | Added NEG_VA_2010.
     3|   3  206.56252     2     8.25176   1412.28974   0.0683  | Added liquidity_return_2010.
     4|   9  117.53130     3    10.56650   1339.98717   0.1163  | Added fin_cons_2010.
     5|  11   97.39147     4    11.02417   1314.08799   0.1337  | Added control.
     6|  14   73.46355     5    11.64218   1254.62900   0.1732  | Added solvency_ratio_2010.
     7|  24   28.70177     6    12.62044   1171.20128   0.2286  | Added real_SA_2010.
     8|  25   26.12717     7    12.56206   1167.49733   0.2313  | Added ICR_failure_2010.
     9|  31   14.86601     8    12.34592   1152.41747   0.2415  | Added misallocated_fixed_2010.
    10|  35   10.20773     9    12.37948   1147.89272   0.2448  | Added dummy_trademark.
    11|  37    8.45856    12    12.49350   1147.28569   0.2460  | Added dummy_patents tfp_acf_2010 financial_sustainability_2010.
    12|  41    5.80806    13    12.74116   1144.76637   0.2480  | Added capital_intensity_2010.
    13|  42    5.28707    15    12.86861   1144.76727   0.2485  | Added liquidity_ratio_2010 profitability_2010.
    14|  44    4.38109    16    13.10444   1143.80029   0.2494  | Added loans_2010.
    15|  48    3.00827    16    13.48018   1142.21237   0.2505  | Added net_income_2010.
    16|  49    2.73842    18    13.55412   1142.63484   0.2508  | Added fin_expenses_2010.

*/

* Perform logistic lasso implementing theory-driven penalization (see e.g. Belloni, Chernozhukov & Wei, 2016).
rlassologit failure_2011 control consdummy area dummy_patents dummy_trademark tfp_acf_2010 shareholders_funds_2010 added_value_2010 cash_flow_2010 ebitda_2010 fin_rev_2010 liquidity_ratio_2010 total_assets_2010 depr_2010 long_term_debt_2010 employees_2010 materials_2010 loans_2010 wage_bill_2010 fixed_assets tax_2010 current_liabilities_2010 current_assets_2010 fin_expenses_2010 int_paid_2010 solvency_ratio_2010 net_income_2010 revenue_2010 capital_intensity_2010 fin_cons_2010 ICR_failure_2010 interest_diff_2010 NEG_VA_2010 real_SA_2010 profitability_2010 misallocated_fixed_2010 financial_sustainability_2010 liquidity_return_2010 int_fixed_assets_2010
/*

         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
            _cons |      -5.9476756     -5.9476756
---------------------------------------------------

*/




*****************************   Failure 2010  ********************************

* Perform logistic lasso and select the tuning parameter λ as the value that minimizes the EBIC
lassologit failure_2010 control consdummy area dummy_patents dummy_trademark tfp_acf_2009 shareholders_funds_2009 added_value_2009 cash_flow_2009 ebitda_2009 fin_rev_2009 liquidity_ratio_2009 total_assets_2009 depr_2009 long_term_debt_2009 employees_2009 materials_2009 loans_2009 wage_bill_2009 fixed_assets tax_2009 current_liabilities_2009 current_assets_2009 fin_expenses_2009 int_paid_2009 solvency_ratio_2009 net_income_2009 revenue_2009 capital_intensity_2009 fin_cons_2009 ICR_failure_2009 interest_diff_2009 NEG_VA_2009 real_SA_2009 profitability_2009 misallocated_fixed_2009 financial_sustainability_2009 liquidity_return_2009 int_fixed_assets_2009
/*
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1  239.96385     0     5.97794   1716.88430  -0.0000  | Added _cons.
     2|   2  218.43865     2     7.10897   1657.64942   0.0348  | Added NEG_VA_2009 liquidity_return_2009.
     3|   9  113.13975     3     9.85243   1556.57218   0.0939  | Added profitability_2009.
     4|  10  102.99091     4    10.07602   1547.06590   0.0995  | Added fin_cons_2009.
     5|  11   93.75243     5    10.34168   1524.13073   0.1131  | Added control.
     6|  12   85.34267     6    10.56031   1501.94693   0.1261  | Added solvency_ratio_2009.
     7|  26   22.89484     7    12.05535   1381.99399   0.1962  | Added area.
     8|  27   20.84113     8    12.08970   1379.49206   0.1978  | Added dummy_trademark.
     9|  29   17.26985     9    12.24279   1374.31116   0.2010  | Added ICR_failure_2009.
    10|  32   13.02686    10    12.45779   1368.81467   0.2043  | Added dummy_patents.
    11|  34   10.79461    11    12.62381   1366.28119   0.2060  | Added financial_sustainability_2009.
    12|  39    6.74723    12    13.01612   1362.20902   0.2085  | Added misallocated_fixed_2009.
    13|  40    6.14199    13    13.11492   1361.72651   0.2089  | Added capital_intensity_2009.
    14|  46    3.49471    13    13.58749   1359.03118   0.2105  | Added depr_2009.
    15|  48    2.89587    14    13.70709   1358.82274   0.2108  | Added tax_2009.
    16|  49    2.63610    15    13.76363   1358.87732   0.2109  | Added interest_diff_2009.
*/

* Perform logistic lasso implementing theory-driven penalization (see e.g. Belloni, Chernozhukov & Wei, 2016).
rlassologit failure_2010 control consdummy area dummy_patents dummy_trademark tfp_acf_2009 shareholders_funds_2009 added_value_2009 cash_flow_2009 ebitda_2009 fin_rev_2009 liquidity_ratio_2009 total_assets_2009 depr_2009 long_term_debt_2009 employees_2009 materials_2009 loans_2009 wage_bill_2009 fixed_assets tax_2009 current_liabilities_2009 current_assets_2009 fin_expenses_2009 int_paid_2009 solvency_ratio_2009 net_income_2009 revenue_2009 capital_intensity_2009 fin_cons_2009 ICR_failure_2009 interest_diff_2009 NEG_VA_2009 real_SA_2009 profitability_2009 misallocated_fixed_2009 financial_sustainability_2009 liquidity_return_2009 int_fixed_assets_2009
/*
---------------------------------------------------
         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
            _cons |      -5.9779385     -5.9779385
---------------------------------------------------
*/




*****************************   Failure 2009  ********************************

* Perform logistic lasso and select the tuning parameter λ as the value that minimizes the EBIC (NO interest_diff_2008)
lassologit failure_2009 control consdummy area dummy_patents dummy_trademark tfp_acf_2008 shareholders_funds_2008 added_value_2008 cash_flow_2008 ebitda_2008 fin_rev_2008 liquidity_ratio_2008 total_assets_2008 depr_2008 long_term_debt_2008 employees_2008 materials_2008 loans_2008 wage_bill_2008 fixed_assets tax_2008 current_liabilities_2008 current_assets_2008 fin_expenses_2008 int_paid_2008 solvency_ratio_2008 net_income_2008 revenue_2008 capital_intensity_2008 fin_cons_2008 ICR_failure_2008 NEG_VA_2008 real_SA_2008 profitability_2008 misallocated_fixed_2008 financial_sustainability_2008 liquidity_return_2008 int_fixed_assets_2008
/*
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1  289.08514     0     6.10407   1762.08687   0.0000  | Added NEG_VA_2008 _cons.
     2|   2  263.15368     2     7.33219   1690.24228   0.0408  | Added liquidity_return_2008.
     3|   9  136.29978     4    10.11686   1560.90856   0.1143  | Added fin_cons_2008 profitability_2008.
     4|  13   93.59009     6    11.07545   1485.67100   0.1571  | Added control solvency_ratio_2008.
     5|  15   77.55275     7    11.30254   1441.83208   0.1820  | Added ICR_failure_2008.
     6|  26   27.58148     8    12.39328   1342.81600   0.2382  | Added dummy_trademark.
     7|  27   25.10737     9    12.52577   1338.55111   0.2407  | Added real_SA_2008.
     8|  29   20.80504    10    12.61112   1330.27575   0.2454  | Added capital_intensity_2008.
     9|  31   17.23995    11    12.70415   1324.07237   0.2490  | Added financial_sustainability_2008.
    10|  38    8.92939    12    13.08678   1313.12121   0.2552  | Added dummy_patents.
    11|  40    7.39927    14    13.23687   1311.55897   0.2562  | Added area tfp_acf_2008.
    12|  43    5.58136    15    13.47698   1309.56293   0.2574  | Added misallocated_fixed_2008.
    13|  46    4.21009    15    13.72435   1308.00307   0.2582  | Added loans_2008.
    14|  50    2.89085    17    14.06995   1306.21534   0.2593  | Added liquidity_ratio_2008.

*/

* Perform logistic lasso implementing theory-driven penalization (see e.g. Belloni, Chernozhukov & Wei, 2016). (No interest_diff_2008)
rlassologit failure_2009 control consdummy area dummy_patents dummy_trademark tfp_acf_2008 shareholders_funds_2008 added_value_2008 cash_flow_2008 ebitda_2008 fin_rev_2008 liquidity_ratio_2008 total_assets_2008 depr_2008 long_term_debt_2008 employees_2008 materials_2008 loans_2008 wage_bill_2008 fixed_assets tax_2008 current_liabilities_2008 current_assets_2008 fin_expenses_2008 int_paid_2008 solvency_ratio_2008 net_income_2008 revenue_2008 capital_intensity_2008 fin_cons_2008 ICR_failure_2008  NEG_VA_2008 real_SA_2008 profitability_2008 misallocated_fixed_2008 financial_sustainability_2008 liquidity_return_2008 int_fixed_assets_2008
/*
---------------------------------------------------
         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
            _cons |      -6.1040729     -6.1040729
---------------------------------------------------

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






