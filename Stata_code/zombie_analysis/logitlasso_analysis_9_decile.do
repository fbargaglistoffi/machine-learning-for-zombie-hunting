********************************************************************************
*Zombie prediction with LASSO
clear all 
cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data"  

* Upload Data
use zombie_data, clear

* Keep just Italian Data
keep if iso=="IT"

forval j = 2011/2017 {
	 gen dummy_hrz_`j'=.
     replace dummy_hrz_`j' = 1 if zombie_`j'=="High Risk"
	 replace dummy_hrz_`j' = 0 if zombie_`j'=="Medium-High Risk"
	 replace dummy_hrz_`j' = 0 if zombie_`j'=="Medium Risk"
	 replace dummy_hrz_`j' = 0 if zombie_`j'=="Medium-Low Risk"
	 replace dummy_hrz_`j' = 0 if zombie_`j'=="Low Risk"
	 replace dummy_hrz_`j' = 0 if zombie_`j'=="No Zombie"
}

forval j= 2011/2017{
	tab dummy_hrz_`j'
}

/*
dummy_hrz_2 |
        011 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    181,518       96.15       96.15
          1 |      7,278        3.85      100.00
------------+-----------------------------------
      Total |    188,796      100.00

dummy_hrz_2 |
        012 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    190,748       96.07       96.07
          1 |      7,810        3.93      100.00
------------+-----------------------------------
      Total |    198,558      100.00

dummy_hrz_2 |
        013 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    189,385       95.57       95.57
          1 |      8,782        4.43      100.00
------------+-----------------------------------
      Total |    198,167      100.00

dummy_hrz_2 |
        014 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    188,786       95.53       95.53
          1 |      8,827        4.47      100.00
------------+-----------------------------------
      Total |    197,613      100.00

dummy_hrz_2 |
        015 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    188,486       95.67       95.67
          1 |      8,521        4.33      100.00
------------+-----------------------------------
      Total |    197,007      100.00

dummy_hrz_2 |
        016 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    188,039       96.47       96.47
          1 |      6,879        3.53      100.00
------------+-----------------------------------
      Total |    194,918      100.00

dummy_hrz_2 |
        017 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    186,680       97.27       97.27
          1 |      5,245        2.73      100.00
------------+-----------------------------------
      Total |    191,925      100.00
*/


*Zombies 2015/2017
*LASSO REGRESSION
lassologit dummy_hrz_2017 control consdummy area dummy_patents dummy_trademark tfp_acf_2014 shareholders_funds_2014 added_value_2014 cash_flow_2014 ebitda_2014 fin_rev_2014 liquidity_ratio_2014 total_assets_2014 depr_2014 long_term_debt_2014 employees_2014 materials_2014 loans_2014 wage_bill_2014 fixed_assets tax_2014 current_liabilities_2014 current_assets_2014 fin_expenses_2014 int_paid_2014 solvency_ratio_2014 net_income_2014 revenue_2014 capital_intensity_2014 fin_cons_2014 ICR_failure_2014 interest_diff_2014 NEG_VA_2014 real_SA_2014 profitability_2014 misallocated_fixed_2014 financial_sustainability_2014 liquidity_return_2014 int_fixed_assets_2014 
*lassologit, plotpath(lambda) plotvar(control consdummy dummy_trademark tfp_acf_2014 liquidity_ratio_2014 fin_cons_2014 ICR_failure_2014 interest_diff_2014 real_SA_2014) plotlabel plotopt(legend(off))plotpath(lambda)
rlassologit dummy_hrz_2017 control consdummy area dummy_patents dummy_trademark tfp_acf_2014 shareholders_funds_2014 added_value_2014 cash_flow_2014 ebitda_2014 fin_rev_2014 liquidity_ratio_2014 total_assets_2014 depr_2014 long_term_debt_2014 employees_2014 materials_2014 loans_2014 wage_bill_2014 fixed_assets tax_2014 current_liabilities_2014 current_assets_2014 fin_expenses_2014 int_paid_2014 solvency_ratio_2014 net_income_2014 revenue_2014 capital_intensity_2014 fin_cons_2014 ICR_failure_2014 interest_diff_2014 NEG_VA_2014 real_SA_2014 profitability_2014 misallocated_fixed_2014 financial_sustainability_2014 liquidity_return_2014 int_fixed_assets_2014

/*
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1 1550.86832     0     3.96294  13465.20263   0.0000  | Added fin_cons_2014 _cons.
     2|   2 1411.75261     2     4.41086  13011.62240   0.0337  | Added control.
     3|   3 1285.11583     4     4.83352  12527.49158   0.0696  | Added ICR_failure_2014
      |                                                         | NEG_VA_2014.
     4|   4 1169.83860     5     5.10799  11979.88127   0.1103  | Added real_SA_2014.
     5|  10  665.62249     6     4.07266   9878.94057   0.2663  | Added liquidity_return_2014.
     6|  13  502.08703     7     5.71343   9344.38589   0.3060  | Added solvency_ratio_2014.
     7|  16  378.73028     6     7.38523   8965.16312   0.3341  | Removed liquidity_return_2014.
     8|  21  236.72733     8     9.75905   8586.14911   0.3623  | Added interest_diff_2014
      |                                                         | profitability_2014.
     9|  24  178.56627    10    10.94015   8430.18732   0.3738  | Added capital_intensity_2014
      |                                                         | liquidity_ratio_2014.
    10|  28  122.61232    11    12.32731   8266.48861   0.3860  | Added tfp_acf_2014.
    11|  32   84.19161    12    13.54985   8172.74800   0.3929  | Added dummy_trademark.
    12|  34   69.76477    13    14.22171   8135.92863   0.3957  | Added misallocated_fixed_2014.
    13|  35   63.50674    14    14.57758   8114.32362   0.3973  | Added loans_2014.
    14|  39   43.60683    14    15.79044   8064.48329   0.4010  | Added materials_2014.
    15|  41   36.13448    17    16.35184   8039.18993   0.4028  | Added dummy_patents depr_2014
      |                                                         | net_income_2014.
    16|  42   32.89316    18    16.67009   8030.47126   0.4034  | Added consdummy.
    17|  44   27.25668    19    18.03801   8000.20299   0.4057  | Added liquidity_return_2014.
    18|  45   24.81170    20    18.53985   7989.52570   0.4065  | Added employees_2014.
    19|  46   22.58605    20    19.00329   7981.32913   0.4071  | Added fin_expenses_2014. Removed
      |                                                         | depr_2014.
    20|  48   18.71576    20    19.74256   7970.05719   0.4079  | Removed materials_2014.


---------------------------------------------------
         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
          control |      -2.0961619     -7.0645446
solvency_rat~2014 |      -0.0038138     -0.0125379
    fin_cons_2014 |       0.8322937      0.9287815
 ICR_failure_2014 |       0.9234972      1.3466502
      NEG_VA_2014 |       0.9512595      1.3031733
     real_SA_2014 |       0.5843695      1.0153329
            _cons |       2.3129568      6.7079607
---------------------------------------------------
*/

* Logit Regression
preserve
keep dummy_hrz_2017 control real_SA_2014 fin_cons_2014 ICR_failure_2014 solvency_ratio_2014 NEG_VA_2014 nace
rename dummy_hrz_2017 dummy_hrz_zombie
rename real_SA_2014 real_SA
rename fin_cons_2014 fin_cons
rename ICR_failure_2014 ICR_failure
rename solvency_ratio_2014 solvency_ratio
rename NEG_VA_2014 NEG_VA
eststo: logit dummy_hrz_zombie control real_SA fin_cons ICR_failure solvency_ratio NEG_VA, cluster(nace) robust
restore

*Zombies 2014/2016
*LASSO REGRESSION
lassologit dummy_hrz_2016 control consdummy area dummy_patents dummy_trademark tfp_acf_2013 shareholders_funds_2013 added_value_2013 cash_flow_2013 ebitda_2013 fin_rev_2013 liquidity_ratio_2013 total_assets_2013 depr_2013 long_term_debt_2013 employees_2013 materials_2013 loans_2013 wage_bill_2013 fixed_assets tax_2013 current_liabilities_2013 current_assets_2013 fin_expenses_2013 int_paid_2013 solvency_ratio_2013 net_income_2013 revenue_2013 capital_intensity_2013 fin_cons_2013 ICR_failure_2013 interest_diff_2013 NEG_VA_2013 real_SA_2013 profitability_2013 misallocated_fixed_2013 financial_sustainability_2013 liquidity_return_2013 int_fixed_assets_2013 
rlassologit dummy_hrz_2016 control consdummy area dummy_patents dummy_trademark tfp_acf_2013 shareholders_funds_2013 added_value_2013 cash_flow_2013 ebitda_2013 fin_rev_2013 liquidity_ratio_2013 total_assets_2013 depr_2013 long_term_debt_2013 employees_2013 materials_2013 loans_2013 wage_bill_2013 fixed_assets tax_2013 current_liabilities_2013 current_assets_2013 fin_expenses_2013 int_paid_2013 solvency_ratio_2013 net_income_2013 revenue_2013 capital_intensity_2013 fin_cons_2013 ICR_failure_2013 interest_diff_2013 NEG_VA_2013 real_SA_2013 profitability_2013 misallocated_fixed_2013 financial_sustainability_2013 liquidity_return_2013 int_fixed_assets_2013 

/* 
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1 2260.91613     0     3.62124  17722.31635   0.0000  | Added _cons.
     2|   2 2058.10784     3     4.35173  17231.44555   0.0277  | Added control fin_cons_2013
      |                                                         | NEG_VA_2013.
     3|   5 1552.45545     5     5.56623  15270.94258   0.1383  | Added real_SA_2013
      |                                                         | liquidity_return_2013.
     4|   6 1413.19737     6     5.43152  14651.69795   0.1732  | Added ICR_failure_2013.
     5|  10  970.37034     7     4.71345  12896.42892   0.2723  | Added solvency_ratio_2013.
     6|  14  666.30367     8     6.33862  11819.70011   0.3330  | Added profitability_2013.
     7|  20  379.11786     9     9.55972  10953.42557   0.3819  | Added interest_diff_2013.
     8|  24  260.32084    10    11.27338  10612.70006   0.4011  | Added capital_intensity_2013.
     9|  33  111.72799    12    14.37551  10234.41911   0.4224  | Added area tfp_acf_2013.
    10|  34  101.70579    13    14.71011  10210.03636   0.4238  | Added net_income_2013
      |                                                         | misallocated_fixed_2013.
    11|  36   84.27777    13    13.97087  10378.03344   0.4143  | Added liquidity_ratio_2013.
      |                                                         | Removed NEG_VA_2013
      |                                                         | liquidity_return_2013.
    12|  37   76.71790    15    15.68169  10141.93919   0.4276  | Added NEG_VA_2013
      |                                                         | liquidity_return_2013.
    13|  39   63.57173    16    16.24977  10106.27203   0.4296  | Added depr_2013.
    14|  42   47.95292    17    17.00845  10072.61240   0.4315  | Added dummy_trademark.
    15|  44   39.73584    17    17.52614  10048.24467   0.4329  | Added fin_rev_2013. Removed
      |                                                         | liquidity_return_2013.
    16|  49   24.83709    17    18.65900  10009.31741   0.4351  | Added materials_2013.



---------------------------------------------------
         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
          control |      -2.4530859     -7.4393086
solvency_rat~2013 |      -0.0084824     -0.0166040
    fin_cons_2013 |       0.9439983      1.1350608
 ICR_failure_2013 |       0.8141299      1.1099664
interest_dif~2013 |       0.0643426      0.5502813
      NEG_VA_2013 |       1.3221602      1.7378589
     real_SA_2013 |       0.6481496      0.9925701
profitabilit~2013 |       0.1030695      0.2708225
liquidity_re~2013 |      -0.1797320      0.0134622
            _cons |       3.2747238      6.5315912
---------------------------------------------------
*/ 

* Logit Regression
preserve
keep dummy_hrz_2016 control real_SA_2013 ICR_failure_2013 fin_cons_2013 interest_diff_2013 NEG_VA_2013 profitability_2013 solvency_ratio_2013 liquidity_return_2013 nace
rename dummy_hrz_2016 dummy_hrz_zombie
rename real_SA_2013 real_SA
rename ICR_failure_2013 ICR_failure
rename fin_cons_2013 fin_cons
rename interest_diff_2013 interest_diff
rename NEG_VA_2013 NEG_VA
rename profitability_2013 profitability
rename solvency_ratio_2013 solvency_ratio
rename liquidity_return_2013 liquidity_return
eststo: quietly logit dummy_hrz_zombie control real_SA ICR_failure fin_cons interest_diff NEG_VA profitability solvency_ratio liquidity_return, cluster(nace) robust
restore

*Zombies 2013/2015
*LASSO REGRESSION
lassologit dummy_hrz_2015 control consdummy area dummy_patents dummy_trademark tfp_acf_2012 shareholders_funds_2012 added_value_2012 cash_flow_2012 ebitda_2012 fin_rev_2012 liquidity_ratio_2012 total_assets_2012 depr_2012 long_term_debt_2012 employees_2012 materials_2012 loans_2012 wage_bill_2012 fixed_assets tax_2012 current_liabilities_2012 current_assets_2012 fin_expenses_2012 int_paid_2012 solvency_ratio_2012 net_income_2012 revenue_2012 capital_intensity_2012 fin_cons_2012 ICR_failure_2012 interest_diff_2012 NEG_VA_2012 real_SA_2012 profitability_2012 misallocated_fixed_2012 financial_sustainability_2012 liquidity_return_2012 int_fixed_assets_2012 
rlassologit dummy_hrz_2015 control consdummy area dummy_patents dummy_trademark tfp_acf_2012 shareholders_funds_2012 added_value_2012 cash_flow_2012 ebitda_2012 fin_rev_2012 liquidity_ratio_2012 total_assets_2012 depr_2012 long_term_debt_2012 employees_2012 materials_2012 loans_2012 wage_bill_2012 fixed_assets tax_2012 current_liabilities_2012 current_assets_2012 fin_expenses_2012 int_paid_2012 solvency_ratio_2012 net_income_2012 revenue_2012 capital_intensity_2012 fin_cons_2012 ICR_failure_2012 interest_diff_2012 NEG_VA_2012 real_SA_2012 profitability_2012 misallocated_fixed_2012 financial_sustainability_2012 liquidity_return_2012 int_fixed_assets_2012 

/*
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1 2919.03636     0     3.30000  22938.36680   0.0000  | Added _cons.
     2|   2 2657.19348     3     4.24609  22094.07634   0.0368  | Added control fin_cons_2012
      |                                                         | liquidity_return_2012.
     3|   5 2004.35294     5     5.55860  19604.26947   0.1453  | Added NEG_VA_2012 real_SA_2012.
     4|   8 1511.90749     6     5.24184  17570.38107   0.2340  | Added profitability_2012.
     5|   9 1376.28663     7     5.12672  17050.43691   0.2566  | Added ICR_failure_2012.
     6|  14  860.25511     8     7.62097  15252.36386   0.3350  | Added solvency_ratio_2012.
     7|  27  253.52163     9    13.75394  13536.44423   0.4098  | Added interest_diff_2012.
     8|  29  210.07886    11    14.43977  13431.88763   0.4144  | Added tfp_acf_2012
      |                                                         | capital_intensity_2012.
     9|  36  108.80982    12    16.51352  13202.84322   0.4243  | Added dummy_patents.
    10|  37   99.04938    13    16.79231  13182.03898   0.4252  | Added misallocated_fixed_2012.
    11|  41   68.01214    15    17.82890  13119.70070   0.4279  | Added area liquidity_ratio_2012.
    12|  42   61.91133    16    18.05798  13104.53388   0.4286  | Added net_income_2012.
    13|  46   42.51134    17    18.87764  13069.23120   0.4301  | Added
      |                                                         | financial_sustainability_2012.
    14|  49   32.06682    18    19.37770  13051.39792   0.4309  | Added fin_rev_2012.


---------------------------------------------------
         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
          control |      -2.8319625     -6.4660323
solvency_rat~2012 |      -0.0055858     -0.0110760
    fin_cons_2012 |       1.0882177      1.1933853
 ICR_failure_2012 |       0.6318009      0.9243469
      NEG_VA_2012 |       0.9868411      1.4811376
     real_SA_2012 |       0.7141779      1.0411661
profitabilit~2012 |       0.3487002      0.4596293
liquidity_re~2012 |      -1.4272856     -1.5106375
            _cons |       4.2222909      7.4503485
---------------------------------------------------
*/

* Logit Regression
preserve
keep dummy_hrz_2015 nace control real_SA_2012 fin_cons_2012 ICR_failure_2012 NEG_VA_2012 profitability_2012  liquidity_return_2012  solvency_ratio_2012
rename dummy_hrz_2015 dummy_hrz_zombie
rename real_SA_2012 real_SA
rename fin_cons_2012 fin_cons
rename ICR_failure_2012 ICR_failure
rename NEG_VA_2012 NEG_VA
rename profitability_2012 profitability
rename liquidity_return_2012 liquidity_return
rename solvency_ratio_2012 solvency_ratio
eststo: quietly logit dummy_hrz_zombie control real_SA fin_cons ICR_failure NEG_VA profitability liquidity_return solvency_ratio, cluster(nace) robust
restore

*Zombies 2012/2014
*LASSO REGRESSION
lassologit dummy_hrz_2014 control consdummy area dummy_patents dummy_trademark tfp_acf_2011 shareholders_funds_2011 added_value_2011 cash_flow_2011 ebitda_2011 fin_rev_2011 liquidity_ratio_2011 total_assets_2011 depr_2011 long_term_debt_2011 employees_2011 materials_2011 loans_2011 wage_bill_2011 fixed_assets tax_2011 current_liabilities_2011 current_assets_2011 fin_expenses_2011 int_paid_2011 solvency_ratio_2011 net_income_2011 revenue_2011 capital_intensity_2011 fin_cons_2011 ICR_failure_2011 interest_diff_2011 NEG_VA_2011 real_SA_2011 profitability_2011 misallocated_fixed_2011 financial_sustainability_2011 liquidity_return_2011 int_fixed_assets_2011 
rlassologit dummy_hrz_2014 control consdummy area dummy_patents dummy_trademark tfp_acf_2011 shareholders_funds_2011 added_value_2011 cash_flow_2011 ebitda_2011 fin_rev_2011 liquidity_ratio_2011 total_assets_2011 depr_2011 long_term_debt_2011 employees_2011 materials_2011 loans_2011 wage_bill_2011 fixed_assets tax_2011 current_liabilities_2011 current_assets_2011 fin_expenses_2011 int_paid_2011 solvency_ratio_2011 net_income_2011 revenue_2011 capital_intensity_2011 fin_cons_2011 ICR_failure_2011 interest_diff_2011 NEG_VA_2011 real_SA_2011 profitability_2011 misallocated_fixed_2011 financial_sustainability_2011 liquidity_return_2011 int_fixed_assets_2011 

/*
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1 4093.82753     0     3.17659  24553.41622   0.0000  | Added fin_cons_2011 _cons.
     2|   5 2811.02195     2     4.77426  21815.56053   0.1115  | Added control.
     3|   6 2558.86816     3     5.12507  21018.21993   0.1440  | Added ICR_failure_2011.
     4|   7 2329.33302     4     5.59062  20265.56741   0.1746  | Added NEG_VA_2011.
     5|  10 1757.04386     6     6.54156  18560.71957   0.2440  | Added real_SA_2011
      |                                                         | profitability_2011.
     6|  15 1098.24939     7     6.12264  16300.97268   0.3361  | Added solvency_ratio_2011.
     7|  25  429.07944     8     8.54579  14436.60619   0.4120  | Added liquidity_return_2011.
     8|  29  294.62690     9    10.34112  14122.91742   0.4248  | Added interest_diff_2011.
     9|  31  244.14045    10    11.14384  14007.36707   0.4295  | Added dummy_patents.
    10|  34  184.15808    11    12.28285  13869.04684   0.4351  | Added tfp_acf_2011.
    11|  36  152.60126    13    12.98634  13798.71763   0.4379  | Added area capital_intensity_2011.
    12|  39  115.10896    14    13.96787  13717.70606   0.4412  | Added
      |                                                         | financial_sustainability_2011.
    13|  40  104.78348    15    14.26042  13698.06375   0.4420  | Added dummy_trademark.
    14|  42   86.82807    16    14.83207  13664.81244   0.4434  | Added misallocated_fixed_2011.
    15|  44   71.94945    16    15.36621  13638.40577   0.4445  | Added ebitda_2011.
    16|  47   54.27234    18    16.04290  13607.51803   0.4457  | Added net_income_2011.
    17|  48   49.40401    18    16.23550  13599.63642   0.4460  | Added cash_flow_2011. Removed
      |                                                         | ebitda_2011.
	  
---------------------------------------------------
         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
          control |      -2.6559632     -4.4862297
solvency_rat~2011 |      -0.0085489     -0.0121067
    fin_cons_2011 |       1.5483212      1.3630814
 ICR_failure_2011 |       1.2014165      1.4641066
      NEG_VA_2011 |       1.1645400      1.0962365
     real_SA_2011 |       0.5063261      0.7487522
profitabilit~2011 |       0.2674672      0.2960786
liquidity_re~2011 |      -0.2157814     -3.1081548
            _cons |       1.8251659      4.4422587
---------------------------------------------------
*/ 

* Logit Regression
preserve
keep dummy_hrz_2014 nace control real_SA_2011 fin_cons_2011 ICR_failure_2011 NEG_VA_2011 solvency_ratio_2011 profitability_2011 liquidity_return_2011
rename dummy_hrz_2014 dummy_hrz_zombie
rename real_SA_2011 real_SA
rename fin_cons_2011 fin_cons
rename ICR_failure_2011 ICR_failure
rename NEG_VA_2011 NEG_VA
rename solvency_ratio_2011 solvency_ratio 
rename liquidity_return_2011 liquidity_return
eststo: quietly logit dummy_hrz_zombie control real_SA fin_cons ICR_failure NEG_VA solvency_ratio profitability liquidity_return, cluster(nace) robust
restore

*Zombies 2011/2013
*LASSO REGRESSION
lassologit dummy_hrz_2013  control consdummy area dummy_patents dummy_trademark tfp_acf_2010 shareholders_funds_2010 added_value_2010 cash_flow_2010 ebitda_2010 fin_rev_2010 liquidity_ratio_2010 total_assets_2010 depr_2010 long_term_debt_2010 employees_2010 materials_2010 loans_2010 wage_bill_2010 fixed_assets tax_2010 current_liabilities_2010 current_assets_2010 fin_expenses_2010 int_paid_2010 solvency_ratio_2010 net_income_2010 revenue_2010 capital_intensity_2010 fin_cons_2010 ICR_failure_2010 interest_diff_2010 NEG_VA_2010 real_SA_2010 profitability_2010 misallocated_fixed_2010 financial_sustainability_2010 liquidity_return_2010 int_fixed_assets_2010 
rlassologit dummy_hrz_2013  control consdummy area dummy_patents dummy_trademark tfp_acf_2010 shareholders_funds_2010 added_value_2010 cash_flow_2010 ebitda_2010 fin_rev_2010 liquidity_ratio_2010 total_assets_2010 depr_2010 long_term_debt_2010 employees_2010 materials_2010 loans_2010 wage_bill_2010 fixed_assets tax_2010 current_liabilities_2010 current_assets_2010 fin_expenses_2010 int_paid_2010 solvency_ratio_2010 net_income_2010 revenue_2010 capital_intensity_2010 fin_cons_2010 ICR_failure_2010 interest_diff_2010 NEG_VA_2010 real_SA_2010 profitability_2010 misallocated_fixed_2010 financial_sustainability_2010 liquidity_return_2010 int_fixed_assets_2010 

/* 
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1 2214.23012     0     3.19592  13719.23199   0.0000  | Added fin_cons_2010 _cons.
     2|   5 1520.39855     3     4.84198  12109.94266   0.1174  | Added control
      |                                                         | liquidity_return_2010.
     3|   8 1146.85488     4     6.69754  10967.76927   0.2007  | Added NEG_VA_2010.
     4|   9 1043.97991     5     7.20050  10690.48702   0.2209  | Added profitability_2010.
     5|  10  950.33301     6     7.52741  10429.03406   0.2400  | Added real_SA_2010.
     6|  16  540.72675     7     7.50569   9192.35765   0.3302  | Added ICR_failure_2010.
     7|  18  448.06931     8     7.49718   8944.24995   0.3483  | Added solvency_ratio_2010.
     8|  24  254.94544     9     9.02148   8462.40159   0.3835  | Added tfp_acf_2010.
     9|  26  211.25869    11     9.83300   8351.70254   0.3916  | Added misallocated_fixed_2010
      |                                                         | financial_sustainability_2010.
    10|  28  175.05799    12    10.61950   8259.43480   0.3983  | Added dummy_patents.
    11|  34   99.60565    13    12.66844   8085.10099   0.4111  | Added interest_diff_2010.
    12|  38   68.39411    14    13.71122   8026.24752   0.4154  | Added dummy_trademark.
    13|  43   42.75009    15    14.74358   7986.76839   0.4183  | Added capital_intensity_2010.
    14|  45   35.42455    16    15.08427   7974.91661   0.4192  | Added net_income_2010.
    15|  46   32.24691    17    15.23187   7969.92778   0.4196  | Added liquidity_ratio_2010.

---------------------------------------------------
         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
          control |      -2.3864433     -4.3947651
solvency_rat~2010 |      -0.0034475     -0.0100145
    fin_cons_2010 |       1.9277193      1.9492289
 ICR_failure_2010 |       0.3492034      0.7195404
      NEG_VA_2010 |       0.9151594      1.5452409
     real_SA_2010 |       0.3770297      0.6302212
profitabilit~2010 |       0.3544224      0.4284554
liquidity_re~2010 |      -1.8570237     -2.5380091
            _cons |       0.7066535      3.3801249
--------------------------------------------------

*/ 

* Logit Regression
preserve 
keep dummy_hrz_2013 nace control real_SA_2010 fin_cons_2010  ICR_failure_2010 NEG_VA_2010 solvency_ratio_2010 liquidity_return_2010 profitability_2010
rename dummy_hrz_2013 dummy_hrz_zombie
rename real_SA_2010 real_SA
rename fin_cons_2010 fin_cons
rename profitability_2010 profitability
rename ICR_failure_2010 ICR_failure
rename NEG_VA_2010 NEG_VA
rename solvency_ratio_2010 solvency_ratio
rename liquidity_return_2010 liquidity_return
eststo: quietly logit dummy_hrz_zombie control real_SA fin_cons profitability ICR_failure NEG_VA solvency_ratio liquidity_return, cluster(nace) robust
restore

*Zombies 2010/2012
*LASSO REGRESSION
lassologit dummy_hrz_2012 control consdummy area dummy_patents dummy_trademark tfp_acf_2009 shareholders_funds_2009 added_value_2009 cash_flow_2009 ebitda_2009 fin_rev_2009 liquidity_ratio_2009 total_assets_2009 depr_2009 long_term_debt_2009 employees_2009 materials_2009 loans_2009 wage_bill_2009 fixed_assets tax_2009 current_liabilities_2009 current_assets_2009 fin_expenses_2009 int_paid_2009 solvency_ratio_2009 net_income_2009 revenue_2009 capital_intensity_2009 fin_cons_2009 ICR_failure_2009 interest_diff_2009 NEG_VA_2009 real_SA_2009 profitability_2009 misallocated_fixed_2009 financial_sustainability_2009 liquidity_return_2009 int_fixed_assets_2009 
rlassologit dummy_hrz_2012 control consdummy area dummy_patents dummy_trademark tfp_acf_2009 shareholders_funds_2009 added_value_2009 cash_flow_2009 ebitda_2009 fin_rev_2009 liquidity_ratio_2009 total_assets_2009 depr_2009 long_term_debt_2009 employees_2009 materials_2009 loans_2009 wage_bill_2009 fixed_assets tax_2009 current_liabilities_2009 current_assets_2009 fin_expenses_2009 int_paid_2009 solvency_ratio_2009 net_income_2009 revenue_2009 capital_intensity_2009 fin_cons_2009 ICR_failure_2009 interest_diff_2009 NEG_VA_2009 real_SA_2009 profitability_2009 misallocated_fixed_2009 financial_sustainability_2009 liquidity_return_2009 int_fixed_assets_2009 

/*
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1 2220.78504     0     3.17857  16242.15805  -0.0000  | Added _cons.
     2|   2 2021.57657     2     4.06494  15741.41928   0.0309  | Added fin_cons_2009
      |                                                         | liquidity_return_2009.
     3|   3 1840.23747     3     4.74258  15193.02226   0.0646  | Added control.
     4|   6 1388.11322     4     6.33247  13699.30309   0.1566  | Added profitability_2009.
     5|   7 1263.59693     5     6.81905  13317.94579   0.1801  | Added NEG_VA_2009.
     6|  10  953.14634     6     7.91520  12473.27855   0.2321  | Added solvency_ratio_2009.
     7|  12  789.81782     7     8.24404  12026.16121   0.2597  | Added real_SA_2009.
     8|  22  308.57708     8     8.14660  10796.01966   0.3354  | Added ICR_failure_2009.
     9|  23  280.89715     9     8.14643  10735.70085   0.3392  | Added tfp_acf_2009.
    10|  25  232.76340    10     8.15631  10624.50140   0.3460  | Added dummy_patents.
    11|  27  192.87771    11     8.32450  10530.82443   0.3518  | Added dummy_trademark.
    12|  28  175.57622    12     8.43377  10486.44266   0.3546  | Added capital_intensity_2009.
    13|  30  145.48997    12     8.64447  10412.48073   0.3591  | Added net_income_2009.
    14|  33  109.74483    14     9.05619  10335.00814   0.3639  | Added interest_diff_2009.
    15|  34   99.90052    15     9.29224  10314.39617   0.3652  | Added liquidity_ratio_2009.
    16|  38   68.59658    16    10.16551  10254.24001   0.3689  | Added area.
    17|  41   51.74322    17    10.73928  10227.39440   0.3706  | Added
      |                                                         | financial_sustainability_2009.
    18|  45   35.52942    18    11.34743  10206.73668   0.3719  | Added misallocated_fixed_2009.


---------------------------------------------------
         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
          control |      -2.3897154     -4.0154735
solvency_rat~2009 |      -0.0109088     -0.0177609
    fin_cons_2009 |       1.8540403      1.9745017
 ICR_failure_2009 |       0.0421092      0.3664711
      NEG_VA_2009 |       0.9466649      1.3836262
     real_SA_2009 |       0.2114637      0.3862913
profitabilit~2009 |       0.3542000      0.3863097
liquidity_re~2009 |      -1.3362944     -1.2625621
            _cons |      -1.0103308      0.7358958
---------------------------------------------------
*/ 

* Logit Regression
preserve 
keep dummy_hrz_2012 nace control fin_cons_2009 real_SA_2009 liquidity_return_2009 ICR_failure_2009 NEG_VA_2009 solvency_ratio_2009 profitability_2009
rename dummy_hrz_2012 dummy_hrz_zombie
rename fin_cons_2009 fin_cons
rename real_SA_2009 real_SA
rename liquidity_return_2009 liquidity_return
rename profitability_2009 profitability
rename ICR_failure_2009 ICR_failure
rename NEG_VA_2009 NEG_VA
rename solvency_ratio_2009 solvency_ratio
eststo: quietly logit dummy_hrz_zombie control fin_cons real_SA liquidity_return  ICR_failure  NEG_VA profitability solvency_ratio, cluster(nace) robust
restore

*Zombies 2009/2011
*LASSO REGRESSION
lassologit dummy_hrz_2011 control consdummy area dummy_patents dummy_trademark tfp_acf_2008 shareholders_funds_2008 added_value_2008 cash_flow_2008 ebitda_2008 fin_rev_2008 liquidity_ratio_2008 total_assets_2008 depr_2008 long_term_debt_2008 employees_2008 materials_2008 loans_2008 wage_bill_2008 fixed_assets tax_2008 current_liabilities_2008 current_assets_2008 fin_expenses_2008 int_paid_2008 solvency_ratio_2008 net_income_2008 revenue_2008 capital_intensity_2008 fin_cons_2008 ICR_failure_2008 NEG_VA_2008 real_SA_2008 profitability_2008 misallocated_fixed_2008 financial_sustainability_2008 liquidity_return_2008 int_fixed_assets_2008 
rlassologit dummy_hrz_2011 control consdummy area dummy_patents dummy_trademark tfp_acf_2008 shareholders_funds_2008 added_value_2008 cash_flow_2008 ebitda_2008 fin_rev_2008 liquidity_ratio_2008 total_assets_2008 depr_2008 long_term_debt_2008 employees_2008 materials_2008 loans_2008 wage_bill_2008 fixed_assets tax_2008 current_liabilities_2008 current_assets_2008 fin_expenses_2008 int_paid_2008 solvency_ratio_2008 net_income_2008 revenue_2008 capital_intensity_2008 fin_cons_2008 ICR_failure_2008 NEG_VA_2008 real_SA_2008 profitability_2008 misallocated_fixed_2008 financial_sustainability_2008 liquidity_return_2008 int_fixed_assets_2008 

/*
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1 3504.73659     0     3.07557  20016.10493  -0.0000  | Added _cons.
     2|   2 3190.35533     1     3.60558  19166.63128   0.0424  | Added fin_cons_2008.
     3|   6 2190.65380     3     5.34875  17159.23669   0.1427  | Added control
      |                                                         | liquidity_return_2008.
     4|   8 1815.26944     4     6.50765  15967.31265   0.2023  | Added NEG_VA_2008.
     5|   9 1652.43647     5     7.01381  15499.51017   0.2257  | Added profitability_2008.
     6|  13 1134.64359     6     8.64994  14227.10751   0.2892  | Added solvency_ratio_2008.
     7|  14 1032.86399     7     8.80905  13948.12681   0.3032  | Added real_SA_2008.
     8|  25  367.33605     8     8.75952  12202.12593   0.3904  | Added ICR_failure_2008.
     9|  27  304.39036     9     8.82417  12077.03649   0.3967  | Added dummy_trademark.
    10|  28  277.08599    10     8.90910  12017.97071   0.3996  | Added area.
    11|  31  209.00929    11     9.14255  11875.23797   0.4068  | Added dummy_patents.
    12|  32  190.26077    12     9.25101  11837.06726   0.4087  | Added capital_intensity_2008.
    13|  33  173.19404    13     9.34303  11798.50020   0.4106  | Added
      |                                                         | financial_sustainability_2008.
    14|  38  108.25583    14    10.42238  11679.70816   0.4165  | Added net_income_2008
      |                                                         | misallocated_fixed_2008.
    15|  46   51.04118    16    11.84819  11599.77858   0.4205  | Added tfp_acf_2008.
    16|  49   38.50097    16    12.21550  11588.06359   0.4211  | Added loans_2008.
    17|  50   35.04737    17    12.32159  11584.13593   0.4213  | Added cash_flow_2008.


---------------------------------------------------
         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
          control |      -2.3317296     -3.5729902
  dummy_trademark |      -0.0127776     -0.9427824
solvency_rat~2008 |      -0.0118846     -0.0198629
    fin_cons_2008 |       2.9659077      3.2409645
 ICR_failure_2008 |       0.0370578      0.2410516
      NEG_VA_2008 |       0.9354614      1.4121771
     real_SA_2008 |       0.2639898      0.4107156
profitabilit~2008 |       0.1498058      0.1558566
liquidity_re~2008 |      -1.2470065     -1.5054369
            _cons |      -0.8533344      0.6655656
---------------------------------------------------
*/ 

* Logit Regression
preserve 
keep dummy_hrz_2011 nace control fin_cons_2008 real_SA_2008 ICR_failure_2008 liquidity_return_2008 NEG_VA_2008 dummy_trademark profitability_2008 solvency_ratio_2008 
rename dummy_hrz_2011 dummy_hrz_zombie
rename fin_cons_2008 fin_cons
rename real_SA_2008 real_SA
rename ICR_failure_2008 ICR_failure
rename liquidity_return_2008 liquidity_return
rename NEG_VA_2008 NEG_VA
rename profitability_2008 profitability
rename solvency_ratio_2008 solvency_ratio
eststo: quietly logit dummy_hrz_zombie control fin_cons real_SA ICR_failure liquidity_return NEG_VA dummy_trademark profitability solvency_ratio, cluster(nace) robust
restore 

* Get Latex Table
esttab using post_logit_regressions_9.tex, label ///
title(Logistic Regressions \label{tab1})





