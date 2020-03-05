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
lassologit dummy_2017 control consdummy area dummy_patents dummy_trademark tfp_acf_2014 shareholders_funds_2014 added_value_2014 cash_flow_2014 ebitda_2014 fin_rev_2014 liquidity_ratio_2014 total_assets_2014 depr_2014 long_term_debt_2014 employees_2014 materials_2014 loans_2014 wage_bill_2014 fixed_assets tax_2014 current_liabilities_2014 current_assets_2014 fin_expenses_2014 int_paid_2014 solvency_ratio_2014 net_income_2014 revenue_2014 capital_intensity_2014 fin_cons_2014 ICR_failure_2014 interest_diff_2014 NEG_VA_2014 real_SA_2014 profitability_2014 misallocated_fixed_2014 financial_sustainability_2014 liquidity_return_2014 int_fixed_assets_2014
lassologit, plotpath(lambda) plotvar(control consdummy dummy_trademark tfp_acf_2014 liquidity_ratio_2014 fin_cons_2014 ICR_failure_2014 interest_diff_2014 real_SA_2014) plotlabel plotopt(legend(off))plotpath(lambda)
rlassologit dummy_2017 control consdummy area dummy_patents dummy_trademark tfp_acf_2014 shareholders_funds_2014 added_value_2014 cash_flow_2014 ebitda_2014 fin_rev_2014 liquidity_ratio_2014 total_assets_2014 depr_2014 long_term_debt_2014 employees_2014 materials_2014 loans_2014 wage_bill_2014 fixed_assets tax_2014 current_liabilities_2014 current_assets_2014 fin_expenses_2014 int_paid_2014 solvency_ratio_2014 net_income_2014 revenue_2014 capital_intensity_2014 fin_cons_2014 ICR_failure_2014 interest_diff_2014 NEG_VA_2014 real_SA_2014 profitability_2014 misallocated_fixed_2014 financial_sustainability_2014 liquidity_return_2014 int_fixed_assets_2014 

/* 
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1  1.066e+04     0     1.85706  57472.09767   0.0000  | Added _cons.
     2|   2 9705.34158     1     1.96326  55186.94468   0.0398  | Added control.
     3|  10 4575.93886     2     2.53700  45695.22778   0.2049  | Added real_SA_2014.
     4|  14 3142.06313     3     3.06287  42086.32320   0.2677  | Added ICR_failure_2014.
     5|  23 1348.55284     5     7.63078  37428.96605   0.3487  | Added fin_cons_2014 NEG_VA_2014.
     6|  24 1227.58519     7     8.09595  37112.43658   0.3542  | Added solvency_ratio_2014
      |                                                         | interest_diff_2014.
     7|  34  479.61016     8    11.55904  35417.41165   0.3837  | Added liquidity_ratio_2014.
     8|  35  436.58826     9    11.81308  35327.35084   0.3853  | Added capital_intensity_2014.
     9|  36  397.42549    10    12.06005  35243.44651   0.3868  | Added tfp_acf_2014.
    10|  38  329.32376    11    12.52857  35106.99197   0.3891  | Added misallocated_fixed_2014.
    11|  39  299.78282    12    12.80536  35041.69746   0.3903  | Added dummy_trademark.
    12|  40  272.89176    13    13.36006  34966.56104   0.3916  | Added consdummy.
    13|  43  205.84553    16    15.00266  34781.11818   0.3948  | Added loans_2014
      |                                                         | profitability_2014
      |                                                         | liquidity_return_2014.
    14|  44  187.38081    17    15.52056  34728.52250   0.3957  | Added employees_2014.
    15|  49  117.12335    18    17.45397  34568.13292   0.3985  | Added area materials_2014.
    16|  50  106.61717    18    17.75126  34550.12517   0.3988  | Added shareholders_funds_2014.
	
---------------------------------------------------
         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
          control |      -4.3413600     -5.7082916
liquidity_ra~2014 |       0.0121178      0.0496680
solvency_rat~2014 |      -0.0057905     -0.0097313
    fin_cons_2014 |       0.0996967      0.1375766
 ICR_failure_2014 |       0.9130207      1.0553608
interest_dif~2014 |       0.3469562      0.4924597
      NEG_VA_2014 |       0.6603383      1.0305281
     real_SA_2014 |       0.5926912      0.6776603
            _cons |       5.3240213      6.2128443
---------------------------------------------------
*/


* Logit Regression
preserve
keep dummy_2017 control real_SA_2014 fin_cons_2014 ICR_failure_2014 solvency_ratio_2014 interest_diff_2014 NEG_VA_2014 liquidity_ratio_2014 nace
rename dummy_2017 dummy_zombie
rename real_SA_2014 real_SA
rename fin_cons_2014 fin_cons
rename ICR_failure_2014 ICR_failure
rename solvency_ratio_2014 solvency_ratio
rename interest_diff_2014 interest_diff
rename NEG_VA_2014 NEG_VA
rename liquidity_ratio_2014 liquidity
eststo: quietly logit dummy_zombie control real_SA fin_cons ICR_failure solvency_ratio interest_diff NEG_VA liquidity, cluster(nace) robust
restore

*Zombies 2014/2016
*LASSO REGRESSION
lassologit dummy_2016 control consdummy area dummy_patents dummy_trademark tfp_acf_2013 shareholders_funds_2013 added_value_2013 cash_flow_2013 ebitda_2013 fin_rev_2013 liquidity_ratio_2013 total_assets_2013 depr_2013 long_term_debt_2013 employees_2013 materials_2013 loans_2013 wage_bill_2013 fixed_assets tax_2013 current_liabilities_2013 current_assets_2013 fin_expenses_2013 int_paid_2013 solvency_ratio_2013 net_income_2013 revenue_2013 capital_intensity_2013 fin_cons_2013 ICR_failure_2013 interest_diff_2013 NEG_VA_2013 real_SA_2013 profitability_2013 misallocated_fixed_2013 financial_sustainability_2013 liquidity_return_2013 int_fixed_assets_2013
rlassologit dummy_2016 control consdummy area dummy_patents dummy_trademark tfp_acf_2013 shareholders_funds_2013 added_value_2013 cash_flow_2013 ebitda_2013 fin_rev_2013 liquidity_ratio_2013 total_assets_2013 depr_2013 long_term_debt_2013 employees_2013 materials_2013 loans_2013 wage_bill_2013 fixed_assets tax_2013 current_liabilities_2013 current_assets_2013 fin_expenses_2013 int_paid_2013 solvency_ratio_2013 net_income_2013 revenue_2013 capital_intensity_2013 fin_cons_2013 ICR_failure_2013 interest_diff_2013 NEG_VA_2013 real_SA_2013 profitability_2013 misallocated_fixed_2013 financial_sustainability_2013 liquidity_return_2013 int_fixed_assets_2013 

/*

---------------------------------------------------
         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
          control |      -4.5189536     -5.9040086
solvency_rat~2013 |      -0.0005478     -0.0021469
  net_income_2013 |      -0.0000000     -0.0000000
    fin_cons_2013 |       0.5572637      0.6059469
 ICR_failure_2013 |       0.9087088      1.0609984
interest_dif~2013 |       0.4153832      0.5877105
      NEG_VA_2013 |       0.9731863      1.3362155
     real_SA_2013 |       0.7968055      0.9288468
profitabilit~2013 |       0.1037167      0.2130673
liquidity_re~2013 |      -0.3477280     -0.5480997
            _cons |       7.2693095      8.8385169
---------------------------------------------------
*/ 

* Logit Regression
preserve
keep dummy_2016 control real_SA_2013 ICR_failure_2013 fin_cons_2013 interest_diff_2013 NEG_VA_2013 profitability_2013 solvency_ratio_2013 net_income_2013 liquidity_return_2013 nace
rename dummy_2016 dummy_zombie
rename real_SA_2013 real_SA
rename ICR_failure_2013 ICR_failure
rename fin_cons_2013 fin_cons
rename interest_diff_2013 interest_diff
rename NEG_VA_2013 NEG_VA
rename profitability_2013 profitability
rename solvency_ratio_2013 solvency_ratio
rename liquidity_return_2013 liquidity_return
rename net_income_2013 net_income
eststo: quietly logit dummy_zombie control real_SA ICR_failure fin_cons interest_diff NEG_VA profitability solvency_ratio net_income liquidity_return, cluster(nace) robust
restore

*Zombies 2013/2015
*LASSO REGRESSION
lassologit dummy_2015 control consdummy area dummy_patents dummy_trademark tfp_acf_2012 shareholders_funds_2012 added_value_2012 cash_flow_2012 ebitda_2012 fin_rev_2012 liquidity_ratio_2012 total_assets_2012 depr_2012 long_term_debt_2012 employees_2012 materials_2012 loans_2012 wage_bill_2012 fixed_assets tax_2012 current_liabilities_2012 current_assets_2012 fin_expenses_2012 int_paid_2012 solvency_ratio_2012 net_income_2012 revenue_2012 capital_intensity_2012 fin_cons_2012 ICR_failure_2012 interest_diff_2012 NEG_VA_2012 real_SA_2012 profitability_2012 misallocated_fixed_2012 financial_sustainability_2012 liquidity_return_2012 int_fixed_assets_2012 
rlassologit dummy_2015 control consdummy area dummy_patents dummy_trademark tfp_acf_2012 shareholders_funds_2012 added_value_2012 cash_flow_2012 ebitda_2012 fin_rev_2012 liquidity_ratio_2012 total_assets_2012 depr_2012 long_term_debt_2012 employees_2012 materials_2012 loans_2012 wage_bill_2012 fixed_assets tax_2012 current_liabilities_2012 current_assets_2012 fin_expenses_2012 int_paid_2012 solvency_ratio_2012 net_income_2012 revenue_2012 capital_intensity_2012 fin_cons_2012 ICR_failure_2012 interest_diff_2012 NEG_VA_2012 real_SA_2012 profitability_2012 misallocated_fixed_2012 financial_sustainability_2012 liquidity_return_2012 int_fixed_assets_2012 

/* 

---------------------------------------------------
         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
          control |      -4.5966275     -5.7359471
    dummy_patents |      -0.2184425     -0.5252743
  net_income_2012 |      -0.0000000     -0.0000000
    fin_cons_2012 |       0.9445132      1.0559080
 ICR_failure_2012 |       0.4559692      0.5752404
interest_dif~2012 |       0.2728673      0.4217718
      NEG_VA_2012 |       0.7901025      1.1668534
     real_SA_2012 |       0.9603459      1.1131538
profitabilit~2012 |       0.2442847      0.3886976
liquidity_re~2012 |      -2.1080712     -2.6597742
            _cons |       9.2078860     10.9617550
---------------------------------------------------
*/

* Logit Regression
preserve
keep dummy_2015 nace control dummy_patents real_SA_2012 fin_cons_2012 ICR_failure_2012 NEG_VA_2012 profitability_2012 liquidity_return_2012 interest_diff_2012 net_income_2012
rename dummy_2015 dummy_zombie
rename real_SA_2012 real_SA
rename fin_cons_2012 fin_cons
rename ICR_failure_2012 ICR_failure
rename NEG_VA_2012 NEG_VA
rename interest_diff_2012 interest_diff
rename profitability_2012 profitability
rename liquidity_return_2012 liquidity_return
rename net_income_2012 net_income
eststo: quietly logit dummy_zombie control dummy_patents real_SA fin_cons ICR_failure NEG_VA profitability liquidity_return interest_diff net_income, cluster(nace) robust
restore

*Zombies 2012/2014
*LASSO REGRESSION
lassologit dummy_2014 control consdummy area dummy_patents dummy_trademark tfp_acf_2011 shareholders_funds_2011 added_value_2011 cash_flow_2011 ebitda_2011 fin_rev_2011 liquidity_ratio_2011 total_assets_2011 depr_2011 long_term_debt_2011 employees_2011 materials_2011 loans_2011 wage_bill_2011 fixed_assets tax_2011 current_liabilities_2011 current_assets_2011 fin_expenses_2011 int_paid_2011 solvency_ratio_2011 net_income_2011 revenue_2011 capital_intensity_2011 fin_cons_2011 ICR_failure_2011 interest_diff_2011 NEG_VA_2011 real_SA_2011 profitability_2011 misallocated_fixed_2011 financial_sustainability_2011 liquidity_return_2011 int_fixed_assets_2011 
rlassologit dummy_2014 control consdummy area dummy_patents dummy_trademark tfp_acf_2011 shareholders_funds_2011 added_value_2011 cash_flow_2011 ebitda_2011 fin_rev_2011 liquidity_ratio_2011 total_assets_2011 depr_2011 long_term_debt_2011 employees_2011 materials_2011 loans_2011 wage_bill_2011 fixed_assets tax_2011 current_liabilities_2011 current_assets_2011 fin_expenses_2011 int_paid_2011 solvency_ratio_2011 net_income_2011 revenue_2011 capital_intensity_2011 fin_cons_2011 ICR_failure_2011 interest_diff_2011 NEG_VA_2011 real_SA_2011 profitability_2011 misallocated_fixed_2011 financial_sustainability_2011 liquidity_return_2011 int_fixed_assets_2011 

/*
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1  1.264e+04     0     1.55571  67557.18947   0.0000  | Added control _cons.
     2|   8 6544.48266     3     2.03704  55489.14407   0.1786  | Added fin_cons_2011 real_SA_2011.
     3|  13 4090.66287     4     4.26665  46823.85516   0.3069  | Added ICR_failure_2011.
     4|  22 1755.68561     5     9.74011  39810.71593   0.4107  | Added NEG_VA_2011.
     5|  25 1324.33474     7    11.47536  38651.65283   0.4279  | Added interest_diff_2011
      |                                                         | liquidity_return_2011.
     6|  27 1097.40041     8    12.60093  38005.03126   0.4374  | Added dummy_patents.
     7|  29  909.35292     9    14.14505  37310.18498   0.4477  | Added area.
     8|  30  827.78230    11    14.92639  37005.29637   0.4522  | Added dummy_trademark
      |                                                         | profitability_2011.
     9|  36  470.99704    12    19.11660  35778.62813   0.4704  | Added tfp_acf_2011.
    10|  42  267.99101    13    22.29943  35223.85830   0.4786  | Added capital_intensity_2011.
    11|  45  202.14883    14    23.54766  35076.06174   0.4808  | Added misallocated_fixed_2011.
    12|  47  167.50917    15    24.28133  34996.49408   0.4819  | Added net_income_2011.
    13|  49  138.80526    15    24.92249  34941.56937   0.4828  | Added tax_2011.


---------------------------------------------------
         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
          control |      -4.3284513     -5.3296074
    dummy_patents |      -0.4064260     -0.7061946
  dummy_trademark |      -0.2969070     -0.6478884
     tfp_acf_2011 |      -0.0019173     -0.0084816
    fin_cons_2011 |       1.2519491      1.1641804
 ICR_failure_2011 |       0.8211153      0.9874208
interest_dif~2011 |       0.2881719      0.4292447
      NEG_VA_2011 |       0.5107175      0.6469195
     real_SA_2011 |       0.8524820      1.0016310
profitabilit~2011 |       0.1748143      0.4059553
liquidity_re~2011 |      -3.3480154     -6.1082089
            _cons |       8.4132884     10.4221241
---------------------------------------------------

*/ 

* Logit Regression
preserve
keep dummy_2014 nace control tfp_acf_2011 real_SA_2011 fin_cons_2011 ICR_failure_2011 NEG_VA_2011 solvency_ratio_2011 dummy_patents dummy_trademark profitability_2011 liquidity_return_2011
rename dummy_2014 dummy_zombie
rename real_SA_2011 real_SA
rename fin_cons_2011 fin_cons
rename ICR_failure_2011 ICR_failure
rename NEG_VA_2011 NEG_VA
rename solvency_ratio_2011 solvency_ratio 
rename profitability_2011 profitability
rename tfp_acf_2011 tfp_acf
rename liquidity_return_2011 liquidity_return
eststo: quietly logit dummy_zombie control tfp_acf real_SA fin_cons ICR_failure NEG_VA solvency_ratio dummy_patents dummy_trademark profitability liquidity_return, cluster(nace) robust
restore

*Zombies 2011/2013
*LASSO REGRESSION
lassologit dummy_2013  control consdummy area dummy_patents dummy_trademark tfp_acf_2010 shareholders_funds_2010 added_value_2010 cash_flow_2010 ebitda_2010 fin_rev_2010 liquidity_ratio_2010 total_assets_2010 depr_2010 long_term_debt_2010 employees_2010 materials_2010 loans_2010 wage_bill_2010 fixed_assets tax_2010 current_liabilities_2010 current_assets_2010 fin_expenses_2010 int_paid_2010 solvency_ratio_2010 net_income_2010 revenue_2010 capital_intensity_2010 fin_cons_2010 ICR_failure_2010 interest_diff_2010 NEG_VA_2010 real_SA_2010 profitability_2010 misallocated_fixed_2010 financial_sustainability_2010 liquidity_return_2010 int_fixed_assets_2010 
rlassologit dummy_2013  control consdummy area dummy_patents dummy_trademark tfp_acf_2010 shareholders_funds_2010 added_value_2010 cash_flow_2010 ebitda_2010 fin_rev_2010 liquidity_ratio_2010 total_assets_2010 depr_2010 long_term_debt_2010 employees_2010 materials_2010 loans_2010 wage_bill_2010 fixed_assets tax_2010 current_liabilities_2010 current_assets_2010 fin_expenses_2010 int_paid_2010 solvency_ratio_2010 net_income_2010 revenue_2010 capital_intensity_2010 fin_cons_2010 ICR_failure_2010 interest_diff_2010 NEG_VA_2010 real_SA_2010 profitability_2010 misallocated_fixed_2010 financial_sustainability_2010 liquidity_return_2010 int_fixed_assets_2010 

/*
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1 6778.29566     0     1.63657  36786.04965   0.0000  | Added control _cons.
     2|   7 3856.75942     2     2.37628  30867.88073   0.1609  | Added fin_cons_2010.
     3|   8 3510.80107     3     2.33393  29624.97137   0.1947  | Added real_SA_2010.
     4|  14 1997.59878     4     5.01365  24625.75273   0.3306  | Added liquidity_return_2010.
     5|  19 1248.60949     5     9.00461  22397.91465   0.3912  | Added ICR_failure_2010.
     6|  24  780.44984     6    12.48290  21114.90687   0.4261  | Added dummy_patents.
     7|  25  710.44207     7    13.13802  20912.23323   0.4316  | Added misallocated_fixed_2010.
     8|  27  588.70269     9    14.38666  20558.34748   0.4412  | Added tfp_acf_2010
      |                                                         | interest_diff_2010.
     9|  28  535.89498    10    14.99976  20390.41739   0.4458  | Added NEG_VA_2010.
    10|  30  444.06551    11    16.20171  20107.20738   0.4535  | Added area.
    11|  33  334.96394    12    17.92419  19788.78765   0.4622  | Added dummy_trademark.
    12|  34  304.91707    14    18.43965  19704.07348   0.4645  | Added solvency_ratio_2010
      |                                                         | financial_sustainability_2010.
    13|  42  143.76432    16    21.75148  19309.20357   0.4753  | Added loans_2010 net_income_2010.
    14|  49   74.46237    18    23.66891  19168.60248   0.4791  | Added fin_expenses_2010
      |                                                         | capital_intensity_2010.


---------------------------------------------------
         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
          control |      -3.8854040     -4.8822882
    dummy_patents |      -0.4963909     -0.9103605
  dummy_trademark |      -0.0896236     -0.4453692
     tfp_acf_2010 |      -0.0103746     -0.0216625
solvency_rat~2010 |      -0.0005030     -0.0024848
    fin_cons_2010 |       1.5107803      1.5605213
 ICR_failure_2010 |       0.4494277      0.6772308
interest_dif~2010 |       0.2104550      0.4251871
      NEG_VA_2010 |       0.3669154      0.6817704
     real_SA_2010 |       0.7211471      0.8611888
misallocated~2010 |       0.2584863      0.3268541
financial_su~2010 |       0.0506463      3.4708589
liquidity_re~2010 |      -4.0773602     -5.3239626
            _cons |       7.0236972      8.9192659
---------------------------------------------------
*/ 

* Logit Regression
preserve 
keep dummy_2013 nace control real_SA_2010 interest_diff_2010 tfp_acf_2010 financial_sustainability_2010 fin_cons_2010 misallocated_fixed_2010 dummy_patents dummy_trademark ICR_failure_2010 NEG_VA_2010 solvency_ratio_2010 liquidity_return_2010
rename dummy_2013 dummy_zombie
rename real_SA_2010 real_SA
rename fin_cons_2010 fin_cons
rename tfp_acf_2010 tfp_acf
rename ICR_failure_2010 ICR_failure
rename NEG_VA_2010 NEG_VA
rename solvency_ratio_2010 solvency_ratio
rename liquidity_return_2010 liquidity_return
rename financial_sustainability_2010 financial_sustainability
rename misallocated_fixed_2010 misallocated_fixed_2010
rename interest_diff_2010 interest_diff
eststo: quietly logit dummy_zombie control real_SA interest_diff tfp_acf financial_sustainability fin_cons misallocated_fixed dummy_patents dummy_trademark ICR_failure NEG_VA solvency_ratio liquidity_return, cluster(nace) robust
restore

*Zombies 2010/2012
*LASSO REGRESSION
lassologit dummy_2012 control consdummy area dummy_patents dummy_trademark tfp_acf_2009 shareholders_funds_2009 added_value_2009 cash_flow_2009 ebitda_2009 fin_rev_2009 liquidity_ratio_2009 total_assets_2009 depr_2009 long_term_debt_2009 employees_2009 materials_2009 loans_2009 wage_bill_2009 fixed_assets tax_2009 current_liabilities_2009 current_assets_2009 fin_expenses_2009 int_paid_2009 solvency_ratio_2009 net_income_2009 revenue_2009 capital_intensity_2009 fin_cons_2009 ICR_failure_2009 interest_diff_2009 NEG_VA_2009 real_SA_2009 profitability_2009 misallocated_fixed_2009 financial_sustainability_2009 liquidity_return_2009 int_fixed_assets_2009 
rlassologit dummy_2012 control consdummy area dummy_patents dummy_trademark tfp_acf_2009 shareholders_funds_2009 added_value_2009 cash_flow_2009 ebitda_2009 fin_rev_2009 liquidity_ratio_2009 total_assets_2009 depr_2009 long_term_debt_2009 employees_2009 materials_2009 loans_2009 wage_bill_2009 fixed_assets tax_2009 current_liabilities_2009 current_assets_2009 fin_expenses_2009 int_paid_2009 solvency_ratio_2009 net_income_2009 revenue_2009 capital_intensity_2009 fin_cons_2009 ICR_failure_2009 interest_diff_2009 NEG_VA_2009 real_SA_2009 profitability_2009 misallocated_fixed_2009 financial_sustainability_2009 liquidity_return_2009 int_fixed_assets_2009 

/*
 Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1 7396.25001     0     1.67569  42160.98636  -0.0000  | Added _cons.
     2|   2 6732.79290     1     1.77689  40704.70241   0.0345  | Added control.
     3|   7 4208.36717     2     2.33329  36059.64479   0.1447  | Added fin_cons_2009.
     4|   9 3487.23304     3     2.86465  34167.59198   0.1896  | Added real_SA_2009.
     5|  12 2630.46175     4     2.68299  31437.46438   0.2544  | Added liquidity_return_2009.
     6|  15 1984.18888     5     4.50351  29533.14595   0.2995  | Added solvency_ratio_2009.
     7|  19 1362.44100     6     6.74651  27851.24088   0.3394  | Added NEG_VA_2009.
     8|  22 1027.70561     7     8.28180  27015.10787   0.3593  | Added dummy_trademark.
     9|  23  935.51854     8     8.77825  26765.33526   0.3652  | Added dummy_patents.
    10|  26  705.67287    12    10.20836  26134.34716   0.3802  | Added tfp_acf_2009
      |                                                         | interest_diff_2009
      |                                                         | profitability_2009.
    11|  28  584.75072    14    11.21908  25743.08519   0.3895  | Added ICR_failure_2009
      |                                                         | misallocated_fixed_2009.
    12|  34  332.71533    15    13.79765  25028.16809   0.4065  | Added capital_intensity_2009.
    13|  36  275.70215    15    14.50860  24886.63378   0.4098  | Added net_income_2009.
    14|  43  142.79923    17    16.38702  24630.26715   0.4159  | Added
      |                                                         | financial_sustainability_2009.


---------------------------------------------------
         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
          control |      -3.5071511     -4.2231648
    dummy_patents |      -0.4750230     -0.8343327
  dummy_trademark |      -0.6148365     -1.0925469
     tfp_acf_2009 |      -0.0130030     -0.0239181
solvency_rat~2009 |      -0.0091259     -0.0114969
    fin_cons_2009 |       1.4752866      1.5318586
 ICR_failure_2009 |       0.1593178      0.3163843
interest_dif~2009 |       0.2203784      0.3910558
      NEG_VA_2009 |       1.0866051      1.6278718
     real_SA_2009 |       0.4650878      0.5382408
profitabilit~2009 |       0.0885305      0.1648305
misallocated~2009 |       0.0983465      0.2022427
liquidity_re~2009 |      -1.7634794     -2.2631469
            _cons |       4.2717643      5.3781328
---------------------------------------------------

*/ 

* Logit Regression
preserve 
keep dummy_2012 nace control tfp_acf_2009 interest_diff_2009 profitability_2009 fin_cons_2009 real_SA_2009 liquidity_return_2009 misallocated_fixed_2009 ICR_failure_2009 dummy_patents NEG_VA_2009 dummy_trademark solvency_ratio_2009
rename dummy_2012 dummy_zombie
rename fin_cons_2009 fin_cons
rename real_SA_2009 real_SA
rename liquidity_return_2009 liquidity_return
rename misallocated_fixed_2009 misallocated_fixed
rename ICR_failure_2009 ICR_failure
rename NEG_VA_2009 NEG_VA
rename solvency_ratio_2009 solvency_ratio
rename profitability_2009 profitability
rename tfp_acf_2009 tfp_acf
rename interest_diff_2009 interest_diff
eststo: quietly logit dummy_zombie control tfp_acf interest_diff profitability fin_cons real_SA liquidity_return misallocated_fixed ICR_failure dummy_patents NEG_VA dummy_trademark solvency_ratio, cluster(nace) robust
restore

*Zombies 2009/2011
*LASSO REGRESSION
lassologit dummy_2011 control consdummy area dummy_patents dummy_trademark tfp_acf_2008 shareholders_funds_2008 added_value_2008 cash_flow_2008 ebitda_2008 fin_rev_2008 liquidity_ratio_2008 total_assets_2008 depr_2008 long_term_debt_2008 employees_2008 materials_2008 loans_2008 wage_bill_2008 fixed_assets tax_2008 current_liabilities_2008 current_assets_2008 fin_expenses_2008 int_paid_2008 solvency_ratio_2008 net_income_2008 revenue_2008 capital_intensity_2008 fin_cons_2008 ICR_failure_2008 NEG_VA_2008 real_SA_2008 profitability_2008 misallocated_fixed_2008 financial_sustainability_2008 liquidity_return_2008 int_fixed_assets_2008 
rlassologit dummy_2011 control consdummy area dummy_patents dummy_trademark tfp_acf_2008 shareholders_funds_2008 added_value_2008 cash_flow_2008 ebitda_2008 fin_rev_2008 liquidity_ratio_2008 total_assets_2008 depr_2008 long_term_debt_2008 employees_2008 materials_2008 loans_2008 wage_bill_2008 fixed_assets tax_2008 current_liabilities_2008 current_assets_2008 fin_expenses_2008 int_paid_2008 solvency_ratio_2008 net_income_2008 revenue_2008 capital_intensity_2008 fin_cons_2008 ICR_failure_2008 NEG_VA_2008 real_SA_2008 profitability_2008 misallocated_fixed_2008 financial_sustainability_2008 liquidity_return_2008 int_fixed_assets_2008 

/*

---------------------------------------------------
         Selected |       Logistic       Post
                  |       Lasso          logit
------------------+--------------------------------
          control |      -3.4856560     -4.0884542
    dummy_patents |      -0.3769872     -0.6906350
  dummy_trademark |      -0.8871345     -1.4080695
solvency_rat~2008 |      -0.0142978     -0.0173143
    fin_cons_2008 |       2.0651690      2.2579527
 ICR_failure_2008 |       0.3123347      0.4535994
      NEG_VA_2008 |       0.7246604      1.2450075
     real_SA_2008 |       0.6051213      0.7086343
liquidity_re~2008 |      -1.7995106     -2.3623225
            _cons |       5.8165156      7.2073367
---------------------------------------------------
*/ 

* Logit Regression
preserve 
keep dummy_2011 nace control fin_cons_2008 real_SA_2008 ICR_failure_2008 liquidity_return_2008 NEG_VA_2008 dummy_patents dummy_trademark solvency_ratio_2008
rename dummy_2011 dummy_zombie
rename fin_cons_2008 fin_cons
rename real_SA_2008 real_SA
rename ICR_failure_2008 ICR_failure
rename liquidity_return_2008 liquidity_return
rename NEG_VA_2008 NEG_VA
rename solvency_ratio_2008 solvency_ratio
eststo: quietly logit dummy_zombie control fin_cons real_SA ICR_failure liquidity_return NEG_VA dummy_trademark solvency_ratio, cluster(nace) robust
restore 

* Get Latex Table
esttab using post_logit_regressions.tex, label  ///
title(Logistic Regressions \label{tab1})
