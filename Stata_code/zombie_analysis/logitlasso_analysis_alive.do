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
lassologit dummy_alive_2017 control consdummy area dummy_patents dummy_trademark tfp_acf_2014 shareholders_funds_2014 added_value_2014 cash_flow_2014 ebitda_2014 fin_rev_2014 liquidity_ratio_2014 total_assets_2014 depr_2014 long_term_debt_2014 employees_2014 materials_2014 loans_2014 wage_bill_2014 fixed_assets tax_2014 current_liabilities_2014 current_assets_2014 fin_expenses_2014 int_paid_2014 solvency_ratio_2014 net_income_2014 revenue_2014 capital_intensity_2014 fin_cons_2014 ICR_failure_2014 interest_diff_2014 NEG_VA_2014 real_SA_2014 profitability_2014 misallocated_fixed_2014 financial_sustainability_2014 liquidity_return_2014 int_fixed_assets_2014 
*lassologit, plotpath(lambda) plotvar(control consdummy dummy_alive_trademark tfp_acf_2014 liquidity_ratio_2014 fin_cons_2014 ICR_failure_2014 interest_diff_2014 real_SA_2014) plotlabel plotopt(legend(off))plotpath(lambda)
rlassologit dummy_alive_2017 control consdummy area dummy_patents dummy_trademark tfp_acf_2014 shareholders_funds_2014 added_value_2014 cash_flow_2014 ebitda_2014 fin_rev_2014 liquidity_ratio_2014 total_assets_2014 depr_2014 long_term_debt_2014 employees_2014 materials_2014 loans_2014 wage_bill_2014 fixed_assets tax_2014 current_liabilities_2014 current_assets_2014 fin_expenses_2014 int_paid_2014 solvency_ratio_2014 net_income_2014 revenue_2014 capital_intensity_2014 fin_cons_2014 ICR_failure_2014 interest_diff_2014 NEG_VA_2014 real_SA_2014 profitability_2014 misallocated_fixed_2014 financial_sustainability_2014 liquidity_return_2014 int_fixed_assets_2014

/*
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1  1.091e+04     0     1.83013  56982.02882   0.0000  | Added control _cons.
     2|  10 4683.95294     2     2.51148  44705.73522   0.2154  | Added real_SA_2014.
     3|  13 3533.16194     3     2.63765  41739.74746   0.2675  | Added ICR_failure_2014.
     4|  19 2010.32181     4     6.27457  37213.74346   0.3469  | Added fin_cons_2014.
     5|  21 1665.83864     5     7.36082  36295.62204   0.3630  | Added NEG_VA_2014.
     6|  23 1380.38515     6     8.50935  35538.05039   0.3763  | Added solvency_ratio_2014.
     7|  24 1256.56209     7     9.02585  35174.71411   0.3827  | Added interest_diff_2014.
     8|  34  490.93126     8    13.11852  33213.84282   0.4171  | Added liquidity_ratio_2014.
     9|  35  446.89383     9    13.42950  33116.01907   0.4188  | Added capital_intensity_2014.
    10|  36  406.80664    10    13.73359  33017.77067   0.4205  | Added tfp_acf_2014.
    11|  37  370.31534    11    14.03415  32931.12076   0.4221  | Added profitability_2014.
    12|  38  337.09738    13    14.38558  32844.44182   0.4236  | Added dummy_trademark misallocated_fixed_2014.
    13|  40  279.33331    14    15.39023  32673.51922   0.4266  | Added consdummy.
    14|  44  191.80389    15    17.95062  32389.32521   0.4316  | Added loans_2014.
    15|  45  174.59874    15    18.31079  32350.69094   0.4322  | Added employees_2014. Removed loans_2014.
    16|  46  158.93691    16    18.66779  32303.60505   0.4331  | Added loans_2014.
    17|  49  119.88802    16    19.68688  32225.09245   0.4344  | Added shareholders_funds_2014.
    18|  50  109.13385    17    19.97687  32203.22317   0.4348  | Added tax_2014.


---------------------------------------------------
         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
          control |      -4.5913584     -6.2068001
liquidity_ra~2014 |       0.0161916      0.0594004
solvency_rat~2014 |      -0.0071219     -0.0126194
    fin_cons_2014 |       0.2530499      0.4624119
 ICR_failure_2014 |       0.9989543      1.0632610
interest_dif~2014 |       0.3728865      0.5158549
      NEG_VA_2014 |       1.2073187      1.9246052
     real_SA_2014 |       0.6541149      0.7686062
profitabilit~2014 |       0.0202232      0.3919570
misallocated~2014 |      -0.0112890     -0.3498046
            _cons |       6.0423251      7.3135265
---------------------------------------------------
*/



* Logit Regression
preserve
keep dummy_alive_2017 control real_SA_2014 fin_cons_2014 ICR_failure_2014 solvency_ratio_2014 interest_diff_2014 NEG_VA_2014 consdummy dummy_alive_patents profitability_2014 nace
rename dummy_alive_2017 dummy_alive_zombie
rename real_SA_2014 real_SA
rename fin_cons_2014 fin_cons
rename ICR_failure_2014 ICR_failure
rename solvency_ratio_2014 solvency_ratio
rename interest_diff_2014 interest_diff
rename NEG_VA_2014 NEG_VA
rename profitability_2014 profitability
eststo: quietly logit dummy_alive_zombie control real_SA fin_cons ICR_failure solvency_ratio interest_diff NEG_VA consdummy dummy_alive_patents profitability, cluster(nace) robust
restore

*Zombies 2014/2016
*LASSO REGRESSION
lassologit dummy_alive_2016 control consdummy area dummy_alive_patents dummy_alive_trademark tfp_acf_2013 shareholders_funds_2013 added_value_2013 cash_flow_2013 ebitda_2013 fin_rev_2013 liquidity_ratio_2013 total_assets_2013 depr_2013 long_term_debt_2013 employees_2013 materials_2013 loans_2013 wage_bill_2013 fixed_assets tax_2013 current_liabilities_2013 current_assets_2013 fin_expenses_2013 int_paid_2013 solvency_ratio_2013 net_income_2013 revenue_2013 capital_intensity_2013 fin_cons_2013 ICR_failure_2013 interest_diff_2013 NEG_VA_2013 real_SA_2013 profitability_2013 misallocated_fixed_2013 financial_sustainability_2013 liquidity_return_2013 int_fixed_assets_2013 
rlassologit dummy_alive_2016 control consdummy area dummy_alive_patents dummy_alive_trademark tfp_acf_2013 shareholders_funds_2013 added_value_2013 cash_flow_2013 ebitda_2013 fin_rev_2013 liquidity_ratio_2013 total_assets_2013 depr_2013 long_term_debt_2013 employees_2013 materials_2013 loans_2013 wage_bill_2013 fixed_assets tax_2013 current_liabilities_2013 current_assets_2013 fin_expenses_2013 int_paid_2013 solvency_ratio_2013 net_income_2013 revenue_2013 capital_intensity_2013 fin_cons_2013 ICR_failure_2013 interest_diff_2013 NEG_VA_2013 real_SA_2013 profitability_2013 misallocated_fixed_2013 financial_sustainability_2013 liquidity_return_2013 int_fixed_assets_2013 

/* 
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1  1.154e+04     0     1.75475  60448.53026   0.0000  | Added _cons.
     2|   2  1.050e+04     1     1.86218  57950.88112   0.0413  | Added control.
     3|   8 5974.62987     2     2.36625  49229.15332   0.1856  | Added real_SA_2013.
     4|  11 4506.73505     3     2.39241  45145.54236   0.2532  | Added ICR_failure_2013.
     5|  13 3734.47342     4     3.88072  42408.53689   0.2984  | Added fin_cons_2013.
     6|  18 2334.25201     5     7.21970  37865.93300   0.3736  | Added NEG_VA_2013.
     7|  22 1602.81144     7     9.92099  35586.27108   0.4113  | Added interest_diff_2013 liquidity_return_2013.
     8|  30  755.70418     8    14.63879  33082.57883   0.4527  | Added profitability_2013.
     9|  32  626.20880     9    15.64850  32748.42026   0.4582  | Added capital_intensity_2013.
    10|  33  570.03673    10    16.11847  32590.45690   0.4608  | Added solvency_ratio_2013.
    11|  36  429.98555    11    17.39497  32230.95154   0.4668  | Added area.
    12|  37  391.41506    12    17.81881  32111.25771   0.4688  | Added materials_2013 net_income_2013
      |                                                         | misallocated_fixed_2013.
    13|  38  356.30442    15    17.84848  32202.60934   0.4672  | Added added_value_2013 total_assets_2013
      |                                                         | depr_2013 fixed_assets tax_2013. Removed
      |                                                         | materials_2013 net_income_2013.
    14|  39  324.34326    13    18.95974  33649.33754   0.4433  | Added materials_2013. Removed added_value_2013
      |                                                         | total_assets_2013 depr_2013 fixed_assets tax_2013.
    15|  40  295.24908    11    19.27219  32194.69193   0.4674  | Added liquidity_ratio_2013 revenue_2013. Removed
      |                                                         | materials_2013 solvency_ratio_2013
      |                                                         | interest_diff_2013.
    16|  41  268.76470    14    19.76766  31735.97256   0.4750  | Added consdummy solvency_ratio_2013
      |                                                         | interest_diff_2013.
    17|  43  222.70993    14    21.38583  31572.63019   0.4777  | Added shareholders_funds_2013 materials_2013.
    18|  45  184.54697    15    22.53066  31457.06295   0.4796  | Removed revenue_2013.
    19|  46  167.99277    15    23.02867  31417.01228   0.4802  | Added net_income_2013.

---------------------------------------------------
         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
          control |      -4.7780249     -6.4533266
             area |      -0.0113615     -0.0777171
solvency_rat~2013 |      -0.0013138     -0.0044469
  net_income_2013 |      -0.0000000     -0.0000000
    fin_cons_2013 |       0.6428179      0.8946840
 ICR_failure_2013 |       0.9569224      1.0267289
interest_dif~2013 |       0.4594209      0.6350631
      NEG_VA_2013 |       1.4065000      2.0852183
     real_SA_2013 |       0.8697244      1.0416040
profitabilit~2013 |       0.1558486      0.5307132
misallocated~2013 |      -0.0349713     -0.3970581
liquidity_re~2013 |      -0.7488322     -1.0001274
            _cons |       8.1081838     10.2084842
---------------------------------------------------
*/ 

* Logit Regression
preserve
keep dummy_alive_2016 control real_SA_2013 ICR_failure_2013 fin_cons_2013 interest_diff_2013 NEG_VA_2013 consdummy shareholders_funds_2013 profitability_2013 solvency_ratio_2013 nace
rename dummy_alive_2016 dummy_alive_zombie
rename real_SA_2013 real_SA
rename ICR_failure_2013 ICR_failure
rename fin_cons_2013 fin_cons
rename interest_diff_2013 interest_diff
rename NEG_VA_2013 NEG_VA
rename shareholders_funds_2013 shareholders_funds
rename profitability_2013 profitability
rename solvency_ratio_2013 solvency_ratio
eststo: quietly logit dummy_alive_zombie control real_SA ICR_failure fin_cons interest_diff NEG_VA consdummy shareholders_funds profitability solvency_ratio, cluster(nace) robust
restore

*Zombies 2013/2015
*LASSO REGRESSION
lassologit dummy_alive_2015 control consdummy area dummy_alive_patents dummy_alive_trademark tfp_acf_2012 shareholders_funds_2012 added_value_2012 cash_flow_2012 ebitda_2012 fin_rev_2012 liquidity_ratio_2012 total_assets_2012 depr_2012 long_term_debt_2012 employees_2012 materials_2012 loans_2012 wage_bill_2012 fixed_assets tax_2012 current_liabilities_2012 current_assets_2012 fin_expenses_2012 int_paid_2012 solvency_ratio_2012 net_income_2012 revenue_2012 capital_intensity_2012 fin_cons_2012 ICR_failure_2012 interest_diff_2012 NEG_VA_2012 real_SA_2012 profitability_2012 misallocated_fixed_2012 financial_sustainability_2012 liquidity_return_2012 int_fixed_assets_2012 
rlassologit dummy_alive_2015 control consdummy area dummy_alive_patents dummy_alive_trademark tfp_acf_2012 shareholders_funds_2012 added_value_2012 cash_flow_2012 ebitda_2012 fin_rev_2012 liquidity_ratio_2012 total_assets_2012 depr_2012 long_term_debt_2012 employees_2012 materials_2012 loans_2012 wage_bill_2012 fixed_assets tax_2012 current_liabilities_2012 current_assets_2012 fin_expenses_2012 int_paid_2012 solvency_ratio_2012 net_income_2012 revenue_2012 capital_intensity_2012 fin_cons_2012 ICR_failure_2012 interest_diff_2012 NEG_VA_2012 real_SA_2012 profitability_2012 misallocated_fixed_2012 financial_sustainability_2012 liquidity_return_2012 int_fixed_assets_2012 

/*

  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1  1.301e+04     0     1.59323  66763.40126   0.0000  | Added _cons.
     2|   2  1.184e+04     1     1.70189  63960.58667   0.0420  | Added control.
     3|   7 7403.66546     2     2.09536  55147.72211   0.1740  | Added real_SA_2012.
     4|  11 5083.71834     3     3.20135  48501.50010   0.2735  | Added fin_cons_2012.
     5|  15 3490.72933     4     6.39008  42833.48691   0.3584  | Added liquidity_return_2012.
     6|  18 2633.09904     5     9.02026  39898.19471   0.4024  | Added ICR_failure_2012.
     7|  20 2181.89849     6    10.66410  38388.53598   0.4250  | Added NEG_VA_2012.
     8|  24 1498.19808     7    13.76948  36161.88879   0.4583  | Added profitability_2012.
     9|  26 1241.47101     8    15.22308  35355.14700   0.4704  | Added interest_diff_2012.
    10|  32  706.38037     9    19.08019  33714.15970   0.4950  | Added dummy_patents.
    11|  37  441.52672    11    21.71682  32901.48274   0.5072  | Added area net_income_2012.
    12|  38  401.92097    10    22.28733  32892.33639   0.5073  | Removed net_income_2012.
    13|  39  365.86793    11    22.37196  32961.68565   0.5063  | Added net_income_2012.
    14|  40  333.04891    11    23.21673  32719.71785   0.5099  | Added capital_intensity_2012. Removed
      |                                                         | net_income_2012.
    15|  41  303.17381    12    23.47159  32631.23743   0.5112  | Added dummy_trademark.
    16|  42  275.97857    13    23.28321  33403.68901   0.4996  | Added net_income_2012.
    17|  43  251.22279    13    23.82403  32563.54975   0.5122  | Added liquidity_ratio_2012 materials_2012
      |                                                         | revenue_2012. Removed net_income_2012.
    18|  44  228.68765    10    26.78781  33903.44527   0.4922  | Added solvency_ratio_2012 net_income_2012.
      |                                                         | Removed dummy_patents dummy_trademark
      |                                                         | materials_2012 revenue_2012 capital_intensity_2012
      |                                                         | fin_cons_2012 ICR_failure_2012.
    19|  45  208.17395    15    25.14620  32344.97003   0.5155  | Added dummy_patents dummy_trademark
      |                                                         | capital_intensity_2012 fin_cons_2012
      |                                                         | ICR_failure_2012.
    20|  46  189.50037    14    25.42134  32344.22733   0.5155  | Removed capital_intensity_2012.
    21|  47  172.50184    15    25.76022  32274.59635   0.5166  | Added capital_intensity_2012.
    22|  48  157.02811    15    25.99156  32285.54571   0.5164  | Added financial_sustainability_2012. Removed
      |                                                         | capital_intensity_2012.
    23|  49  142.94240    16    26.29449  32220.16106   0.5174  | Added cash_flow_2012 capital_intensity_2012.
    24|  50  130.12021    16    26.47642  32236.93829   0.5171  | Removed capital_intensity_2012.


---------------------------------------------------
         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
          control |      -4.9657285     -6.4382114
             area |      -0.0152213     -0.0749531
    dummy_patents |      -0.2327596     -0.5709936
  net_income_2012 |      -0.0000000     -0.0000000
    fin_cons_2012 |       1.0616786      1.2105952
 ICR_failure_2012 |       0.5223141      0.6734333
interest_dif~2012 |       0.3045413      0.4763960
      NEG_VA_2012 |       1.2180452      1.8509206
     real_SA_2012 |       1.0714069      1.2719917
profitabilit~2012 |       0.3994180      0.6314319
liquidity_re~2012 |      -2.5640451     -3.3690104
            _cons |      10.4638689     12.7410156
--------------------------------------------------- 
*/

* Logit Regression
preserve
keep dummy_alive_2015 nace control real_SA_2012 fin_cons_2012 ICR_failure_2012 NEG_VA_2012 profitability_2012 consdummy liquidity_return_2012 shareholders_funds_2012 revenue_2012
rename dummy_alive_2015 dummy_alive_zombie
rename real_SA_2012 real_SA
rename fin_cons_2012 fin_cons
rename ICR_failure_2012 ICR_failure
rename NEG_VA_2012 NEG_VA
rename profitability_2012 profitability
rename liquidity_return_2012 liquidity_return
rename shareholders_funds_2012 shareholders_funds
rename revenue_2012 revenue
eststo: quietly logit dummy_alive_zombie control real_SA fin_cons ICR_failure NEG_VA profitability consdummy liquidity_return shareholders_funds revenue, cluster(nace) robust
restore

*Zombies 2012/2014
*LASSO REGRESSION
lassologit dummy_alive_2014 control consdummy area dummy_alive_patents dummy_alive_trademark tfp_acf_2011 shareholders_funds_2011 added_value_2011 cash_flow_2011 ebitda_2011 fin_rev_2011 liquidity_ratio_2011 total_assets_2011 depr_2011 long_term_debt_2011 employees_2011 materials_2011 loans_2011 wage_bill_2011 fixed_assets tax_2011 current_liabilities_2011 current_assets_2011 fin_expenses_2011 int_paid_2011 solvency_ratio_2011 net_income_2011 revenue_2011 capital_intensity_2011 fin_cons_2011 ICR_failure_2011 interest_diff_2011 NEG_VA_2011 real_SA_2011 profitability_2011 misallocated_fixed_2011 financial_sustainability_2011 liquidity_return_2011 int_fixed_assets_2011 
rlassologit dummy_alive_2014 control consdummy area dummy_alive_patents dummy_alive_trademark tfp_acf_2011 shareholders_funds_2011 added_value_2011 cash_flow_2011 ebitda_2011 fin_rev_2011 liquidity_ratio_2011 total_assets_2011 depr_2011 long_term_debt_2011 employees_2011 materials_2011 loans_2011 wage_bill_2011 fixed_assets tax_2011 current_liabilities_2011 current_assets_2011 fin_expenses_2011 int_paid_2011 solvency_ratio_2011 net_income_2011 revenue_2011 capital_intensity_2011 fin_cons_2011 ICR_failure_2011 interest_diff_2011 NEG_VA_2011 real_SA_2011 profitability_2011 misallocated_fixed_2011 financial_sustainability_2011 liquidity_return_2011 int_fixed_assets_2011 

/* 
*/ 

* Logit Regression
preserve
keep dummy_alive_2014 nace control real_SA_2011 fin_cons_2011 ICR_failure_2011 NEG_VA_2011 solvency_ratio_2011 dummy_alive_patents consdummy profitability_2011 shareholders_funds_2011
rename dummy_alive_2014 dummy_alive_zombie
rename real_SA_2011 real_SA
rename fin_cons_2011 fin_cons
rename ICR_failure_2011 ICR_failure
rename NEG_VA_2011 NEG_VA
rename solvency_ratio_2011 solvency_ratio 
rename profitability_2011 profitability
rename shareholders_funds_2011 shareholders_funds
eststo: quietly logit dummy_alive_zombie control real_SA fin_cons ICR_failure NEG_VA solvency_ratio dummy_alive_patents consdummy profitability shareholders_funds, cluster(nace) robust
restore

*Zombies 2011/2013
*LASSO REGRESSION
lassologit dummy_alive_2013  control consdummy area dummy_alive_patents dummy_alive_trademark tfp_acf_2010 shareholders_funds_2010 added_value_2010 cash_flow_2010 ebitda_2010 fin_rev_2010 liquidity_ratio_2010 total_assets_2010 depr_2010 long_term_debt_2010 employees_2010 materials_2010 loans_2010 wage_bill_2010 fixed_assets tax_2010 current_liabilities_2010 current_assets_2010 fin_expenses_2010 int_paid_2010 solvency_ratio_2010 net_income_2010 revenue_2010 capital_intensity_2010 fin_cons_2010 ICR_failure_2010 interest_diff_2010 NEG_VA_2010 real_SA_2010 profitability_2010 misallocated_fixed_2010 financial_sustainability_2010 liquidity_return_2010 int_fixed_assets_2010 
rlassologit dummy_alive_2013  control consdummy area dummy_alive_patents dummy_alive_trademark tfp_acf_2010 shareholders_funds_2010 added_value_2010 cash_flow_2010 ebitda_2010 fin_rev_2010 liquidity_ratio_2010 total_assets_2010 depr_2010 long_term_debt_2010 employees_2010 materials_2010 loans_2010 wage_bill_2010 fixed_assets tax_2010 current_liabilities_2010 current_assets_2010 fin_expenses_2010 int_paid_2010 solvency_ratio_2010 net_income_2010 revenue_2010 capital_intensity_2010 fin_cons_2010 ICR_failure_2010 interest_diff_2010 NEG_VA_2010 real_SA_2010 profitability_2010 misallocated_fixed_2010 financial_sustainability_2010 liquidity_return_2010 int_fixed_assets_2010 

/* 
*/ 

* Logit Regression
preserve 
keep dummy_alive_2013 nace control real_SA_2010 fin_cons_2010 misallocated_fixed_2010 dummy_alive_patents ICR_failure_2010 NEG_VA_2010 solvency_ratio_2010 consdummy liquidity_return_2010
rename dummy_alive_2013 dummy_alive_zombie
rename real_SA_2010 real_SA
rename fin_cons_2010 fin_cons
rename misallocated_fixed_2010 misallocated_fixed
rename ICR_failure_2010 ICR_failure
rename NEG_VA_2010 NEG_VA
rename solvency_ratio_2010 solvency_ratio
rename liquidity_return_2010 liquidity_return
eststo: quietly logit dummy_alive_zombie control real_SA fin_cons misallocated_fixed dummy_alive_patents ICR_failure NEG_VA solvency_ratio consdummy liquidity_return, cluster(nace) robust
restore

*Zombies 2010/2012
*LASSO REGRESSION
lassologit dummy_alive_2012 control consdummy area dummy_alive_patents dummy_alive_trademark tfp_acf_2009 shareholders_funds_2009 added_value_2009 cash_flow_2009 ebitda_2009 fin_rev_2009 liquidity_ratio_2009 total_assets_2009 depr_2009 long_term_debt_2009 employees_2009 materials_2009 loans_2009 wage_bill_2009 fixed_assets tax_2009 current_liabilities_2009 current_assets_2009 fin_expenses_2009 int_paid_2009 solvency_ratio_2009 net_income_2009 revenue_2009 capital_intensity_2009 fin_cons_2009 ICR_failure_2009 interest_diff_2009 NEG_VA_2009 real_SA_2009 profitability_2009 misallocated_fixed_2009 financial_sustainability_2009 liquidity_return_2009 int_fixed_assets_2009 
rlassologit dummy_alive_2012 control consdummy area dummy_alive_patents dummy_alive_trademark tfp_acf_2009 shareholders_funds_2009 added_value_2009 cash_flow_2009 ebitda_2009 fin_rev_2009 liquidity_ratio_2009 total_assets_2009 depr_2009 long_term_debt_2009 employees_2009 materials_2009 loans_2009 wage_bill_2009 fixed_assets tax_2009 current_liabilities_2009 current_assets_2009 fin_expenses_2009 int_paid_2009 solvency_ratio_2009 net_income_2009 revenue_2009 capital_intensity_2009 fin_cons_2009 ICR_failure_2009 interest_diff_2009 NEG_VA_2009 real_SA_2009 profitability_2009 misallocated_fixed_2009 financial_sustainability_2009 liquidity_return_2009 int_fixed_assets_2009 

/*
*/ 

* Logit Regression
preserve 
keep dummy_alive_2012 nace control fin_cons_2009 real_SA_2009 liquidity_return_2009 misallocated_fixed_2009 ICR_failure_2009 dummy_alive_patents NEG_VA_2009 dummy_alive_trademark solvency_ratio_2009
rename dummy_alive_2012 dummy_alive_zombie
rename fin_cons_2009 fin_cons
rename real_SA_2009 real_SA
rename liquidity_return_2009 liquidity_return
rename misallocated_fixed_2009 misallocated_fixed
rename ICR_failure_2009 ICR_failure
rename NEG_VA_2009 NEG_VA
rename solvency_ratio_2009 solvency_ratio
eststo: quietly logit dummy_alive_zombie control fin_cons real_SA liquidity_return misallocated_fixed ICR_failure dummy_alive_patents NEG_VA dummy_alive_trademark solvency_ratio, cluster(nace) robust
restore

*Zombies 2009/2011
*LASSO REGRESSION
lassologit dummy_alive_2011 control consdummy area dummy_alive_patents dummy_alive_trademark tfp_acf_2008 shareholders_funds_2008 added_value_2008 cash_flow_2008 ebitda_2008 fin_rev_2008 liquidity_ratio_2008 total_assets_2008 depr_2008 long_term_debt_2008 employees_2008 materials_2008 loans_2008 wage_bill_2008 fixed_assets tax_2008 current_liabilities_2008 current_assets_2008 fin_expenses_2008 int_paid_2008 solvency_ratio_2008 net_income_2008 revenue_2008 capital_intensity_2008 fin_cons_2008 ICR_failure_2008 NEG_VA_2008 real_SA_2008 profitability_2008 misallocated_fixed_2008 financial_sustainability_2008 liquidity_return_2008 int_fixed_assets_2008 
rlassologit dummy_alive_2011 control consdummy area dummy_alive_patents dummy_alive_trademark tfp_acf_2008 shareholders_funds_2008 added_value_2008 cash_flow_2008 ebitda_2008 fin_rev_2008 liquidity_ratio_2008 total_assets_2008 depr_2008 long_term_debt_2008 employees_2008 materials_2008 loans_2008 wage_bill_2008 fixed_assets tax_2008 current_liabilities_2008 current_assets_2008 fin_expenses_2008 int_paid_2008 solvency_ratio_2008 net_income_2008 revenue_2008 capital_intensity_2008 fin_cons_2008 ICR_failure_2008 NEG_VA_2008 real_SA_2008 profitability_2008 misallocated_fixed_2008 financial_sustainability_2008 liquidity_return_2008 int_fixed_assets_2008 

/*

*/ 

* Logit Regression
preserve 
keep dummy_alive_2011 nace control fin_cons_2008 real_SA_2008 ICR_failure_2008 liquidity_return_2008 NEG_VA_2008 dummy_alive_trademark profitability_2008 solvency_ratio_2008 consdummy
rename dummy_alive_2011 dummy_alive_zombie
rename fin_cons_2008 fin_cons
rename real_SA_2008 real_SA
rename ICR_failure_2008 ICR_failure
rename liquidity_return_2008 liquidity_return
rename NEG_VA_2008 NEG_VA
rename profitability_2008 profitability
rename solvency_ratio_2008 solvency_ratio
eststo: quietly logit dummy_alive_zombie control fin_cons real_SA ICR_failure liquidity_return NEG_VA dummy_alive_trademark profitability solvency_ratio consdummy, cluster(nace) robust
restore 

* Get Latex Table
esttab using post_logit_regressions_alive.tex, label nostar ///
title(Logistic Regressions \label{tab1})





