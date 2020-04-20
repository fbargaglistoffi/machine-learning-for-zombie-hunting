********************************************************************************
*Zombie prediction with LASSO
clear all 
cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data"  

* Upload Data
use zombie_data, clear

* Keep just Italian Data
keep if iso=="IT"

* Failure 2017
*LASSO REGRESSION
lassologit failure_2017 control consdummy area dummy_patents dummy_trademark tfp_acf_2016 shareholders_funds_2016 added_value_2016 cash_flow_2016 ebitda_2016 fin_rev_2016 liquidity_ratio_2016 total_assets_2016 depr_2016 long_term_debt_2016 employees_2016 materials_2016 loans_2016 wage_bill_2016 fixed_assets tax_2016 current_liabilities_2016 current_assets_2016 fin_expenses_2016 int_paid_2016 solvency_ratio_2016 net_income_2016 revenue_2016 capital_intensity_2016 fin_cons_2016 ICR_failure_2016 interest_diff_2016 NEG_VA_2016 real_SA_2016 profitability_2016 misallocated_fixed_2016 financial_sustainability_2016 liquidity_return_2016 int_fixed_assets_2016 

/*
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1 2785.15155     0     3.70466  16527.90942   0.0000  | Added _cons.
     2|   2 2535.31839     1     4.51210  16028.45622   0.0302  | Added liquidity_return_2016.
     3|   4 2100.87326     2     5.64539  15420.32384   0.0670  | Added NEG_VA_2016.
     4|   7 1584.71392     3     6.85242  14865.46651   0.1006  | Added control.
     5|   8 1442.56220     4     7.16426  14475.10618   0.1242  | Added ICR_failure_2016.
     6|  10 1195.36874     5     7.71014  13843.28862   0.1624  | Added fin_cons_2016.
     7|  11 1088.14198     7     7.88459  13583.32737   0.1781  | Added solvency_ratio_2016
      |                                                         | real_SA_2016.
     8|  14  820.79856     8     7.14572  12794.07905   0.2258  | Added profitability_2016.
     9|  28  220.19529     9     6.99643  11610.78403   0.2974  | Added interest_diff_2016.
    10|  30  182.46323    10     7.33593  11560.92630   0.3004  | Added liquidity_ratio_2016.
    11|  37   94.50637    11     8.17210  11464.91555   0.3062  | Added capital_intensity_2016.
    12|  41   64.89269    12     8.53804  11439.84098   0.3078  | Added misallocated_fixed_2016.
    13|  44   48.94933    13     8.84852  11427.34354   0.3085  | Added tfp_acf_2016.
    14|  48   33.61100    14     9.35338  11415.95006   0.3092  | Added consdummy loans_2016.
    15|  49   30.59604    16     9.57368  11411.85254   0.3094  | Added dummy_trademark.

*/

* Failure 2016
*LASSO REGRESSION
lassologit failure_2016 control consdummy area dummy_patents dummy_trademark tfp_acf_2015 shareholders_funds_2015 added_value_2015 cash_flow_2015 ebitda_2015 fin_rev_2015 liquidity_ratio_2015 total_assets_2015 depr_2015 long_term_debt_2015 employees_2015 materials_2015 loans_2015 wage_bill_2015 fixed_assets tax_2015 current_liabilities_2015 current_assets_2015 fin_expenses_2015 int_paid_2015 solvency_ratio_2015 net_income_2015 revenue_2015 capital_intensity_2015 fin_cons_2015 ICR_failure_2015 interest_diff_2015 NEG_VA_2015 real_SA_2015 profitability_2015 misallocated_fixed_2015 financial_sustainability_2015 liquidity_return_2015 int_fixed_assets_2015 

/*
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1 1515.06468     0     4.13614  11975.44613   0.0000  | Added NEG_VA_2015 _cons.
     2|   3 1255.44740     2     5.44158  11537.93450   0.0365  | Added liquidity_return_2015.
     3|   4 1142.83148     3     5.90902  11326.20866   0.0542  | Added control.
     4|   6  946.99905     4     6.64269  10829.36627   0.0957  | Added fin_cons_2015.
     5|   7  862.05151     5     6.96758  10589.79976   0.1156  | Added ICR_failure_2015.
     6|   9  714.33275     6     7.35990  10196.71814   0.1485  | Added real_SA_2015.
     7|  10  650.25580     7     7.17567   9992.36172   0.1655  | Added solvency_ratio_2015.
     8|  13  490.49576     8     6.59439   9523.45930   0.2047  | Added profitability_2015.
     9|  24  174.44385     9     5.80834   8859.72640   0.2601  | Added interest_diff_2015.
    10|  29  109.03703    10     6.75261   8760.67496   0.2683  | Added liquidity_ratio_2015.
    11|  32   82.24794    11     7.22426   8723.45974   0.2714  | Added misallocated_fixed_2015.
    12|  34   68.15416    12     7.62973   8701.79001   0.2732  | Added dummy_trademark.
    13|  38   46.79798    13     8.44388   8669.67431   0.2759  | Added capital_intensity_2015.
    14|  42   32.13378    14     9.06305   8651.69487   0.2774  | Added tfp_acf_2015.
    15|  45   24.23889    16     9.58727   8641.70269   0.2782  | Added consdummy wage_bill_2015.
    16|  48   18.28369    17    10.31512   8634.74832   0.2788  | Added area.
    17|  49   16.64361    17    10.48602   8632.89056   0.2789  | Added shareholders_funds_2015
      |                                                         | ebitda_2015.
*/ 

* Failure 2015
*LASSO REGRESSION
lassologit failure_2015 control consdummy area dummy_patents dummy_trademark tfp_acf_2014 shareholders_funds_2014 added_value_2014 cash_flow_2014 ebitda_2014 fin_rev_2014 liquidity_ratio_2014 total_assets_2014 depr_2014 long_term_debt_2014 employees_2014 materials_2014 loans_2014 wage_bill_2014 fixed_assets tax_2014 current_liabilities_2014 current_assets_2014 fin_expenses_2014 int_paid_2014 solvency_ratio_2014 net_income_2014 revenue_2014 capital_intensity_2014 fin_cons_2014 ICR_failure_2014 interest_diff_2014 NEG_VA_2014 real_SA_2014 profitability_2014 misallocated_fixed_2014 financial_sustainability_2014 liquidity_return_2014 int_fixed_assets_2014 

/*
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1 1405.11627     0     4.24322  11099.28299   0.0000  | Added NEG_VA_2014 _cons.
     2|   5  964.82146     2     5.83912  10459.25051   0.0576  | Added control.
     3|   6  878.27522     4     6.14212  10223.97644   0.0788  | Added fin_cons_2014
      |                                                         | ICR_failure_2014.
     4|   8  727.77641     5     6.75626   9801.30246   0.1169  | Added profitability_2014.
     5|   9  662.49354     6     6.96031   9615.57674   0.1336  | Added solvency_ratio_2014.
     6|  10  603.06667     7     6.94149   9433.43134   0.1500  | Added real_SA_2014.
     7|  23  177.72686     8     5.63558   8403.65945   0.2428  | Added interest_diff_2014.
     8|  24  161.78444     9     5.66704   8375.75806   0.2453  | Added liquidity_ratio_2014.
     9|  29  101.12420    10     5.86313   8275.04806   0.2543  | Added capital_intensity_2014.
    10|  35   57.53832    13     6.43965   8214.14589   0.2598  | Added area depr_2014
      |                                                         | financial_sustainability_2014.
    11|  36   52.37703    14     6.94730   8202.91719   0.2608  | Added consdummy.
    12|  37   47.67871    15     7.45424   8193.31636   0.2616  | Added misallocated_fixed_2014.
    13|  38   43.40184    15     7.87508   8185.68435   0.2623  | Added ebitda_2014.
    14|  39   39.50862    15     8.24084   8178.60909   0.2629  | Added shareholders_funds_2014.
    15|  41   32.73853    16     8.82735   8168.06995   0.2639  | Added materials_2014.
    16|  42   29.80183    16     9.05945   8164.63935   0.2642  | Removed depr_2014.
    17|  44   24.69507    16     9.44609   8157.17663   0.2648  | Added long_term_debt_2014.
    18|  45   22.47988    19     9.60524   8153.43240   0.2651  | Added depr_2014
      |                                                         | liquidity_return_2014.
    19|  46   20.46339    19     9.75965   8150.33538   0.2654  | Added dummy_trademark.
    20|  47   18.62779    19     9.90222   8147.94397   0.2656  | Added fin_expenses_2014.
    21|  49   15.43578    21    10.15449   8143.78432   0.2660  | Added dummy_patents.
    22|  50   14.05116    22    10.27216   8142.18275   0.2661  | Added tfp_acf_2014.
Use 'long' option for full output. 
Type e.g. 'lassologit, lic(ebic)' to run the model selected by EBIC.

*/


* Failure 2014
*LASSO REGRESSION
lassologit failure_2014 control consdummy area dummy_patents dummy_trademark tfp_acf_2013 shareholders_funds_2013 added_value_2013 cash_flow_2013 ebitda_2013 fin_rev_2013 liquidity_ratio_2013 total_assets_2013 depr_2013 long_term_debt_2013 employees_2013 materials_2013 loans_2013 wage_bill_2013 fixed_assets tax_2013 current_liabilities_2013 current_assets_2013 fin_expenses_2013 int_paid_2013 solvency_ratio_2013 net_income_2013 revenue_2013 capital_intensity_2013 fin_cons_2013 ICR_failure_2013 interest_diff_2013 NEG_VA_2013 real_SA_2013 profitability_2013 misallocated_fixed_2013 financial_sustainability_2013 liquidity_return_2013 int_fixed_assets_2013 

/* 

  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1  812.66573     0     5.24363   4909.56505  -0.0000  | Added _cons.
     2|   2  739.76814     1     6.14358   4720.82370   0.0384  | Added NEG_VA_2013.
     3|   4  613.00352     2     7.18981   4551.33929   0.0729  | Added liquidity_return_2013.
     4|   8  420.91816     4     8.29931   4405.22810   0.1026  | Added solvency_ratio_2013
      |                                                         | profitability_2013.
     5|   9  383.16103     5     8.39314   4339.96073   0.1159  | Added fin_cons_2013.
     6|  11  317.50362     6     8.65905   4196.52698   0.1450  | Added control.
     7|  15  218.01349     7     9.11403   3947.04023   0.1958  | Added real_SA_2013.
     8|  17  180.65531     8     8.74035   3844.36372   0.2167  | Added ICR_failure_2013.
     9|  30   53.24005     9     7.45444   3590.91397   0.2683  | Added tfp_acf_2013.
    10|  34   36.55722    10     7.42681   3568.53490   0.2728  | Added liquidity_ratio_2013.
    11|  35   33.27797    11     7.43700   3564.11195   0.2737  | Added interest_diff_2013.
    12|  38   25.10197    12     7.55169   3554.01314   0.2757  | Added misallocated_fixed_2013.
    13|  44   14.28269    13     7.88026   3542.06621   0.2781  | Added dummy_trademark.
*/

* Failure 2013
*LASSO REGRESSION
lassologit failure_2013 control consdummy area dummy_patents dummy_trademark tfp_acf_2012 shareholders_funds_2012 added_value_2012 cash_flow_2012 ebitda_2012 fin_rev_2012 liquidity_ratio_2012 total_assets_2012 depr_2012 long_term_debt_2012 employees_2012 materials_2012 loans_2012 wage_bill_2012 fixed_assets tax_2012 current_liabilities_2012 current_assets_2012 fin_expenses_2012 int_paid_2012 solvency_ratio_2012 net_income_2012 revenue_2012 capital_intensity_2012 fin_cons_2012 ICR_failure_2012 interest_diff_2012 NEG_VA_2012 real_SA_2012 profitability_2012 misallocated_fixed_2012 financial_sustainability_2012 liquidity_return_2012 int_fixed_assets_2012 

/*
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1  653.84500     0     5.39126   4373.17701  -0.0000  | Added liquidity_return_2012 _cons.
     2|   5  448.96192     2     8.25829   4040.03958   0.0761  | Added NEG_VA_2012.
     3|   9  308.27918     4     9.18453   3943.74421   0.0980  | Added solvency_ratio_2012
      |                                                         | profitability_2012.
     4|  11  255.45332     5     9.18754   3845.51151   0.1205  | Added control.
     5|  12  232.53869     6     9.26734   3783.72284   0.1346  | Added fin_cons_2012.
     6|  14  192.69150     7     9.33537   3682.99354   0.1576  | Added real_SA_2012.
     7|  22   90.85147     8     7.93508   3430.67411   0.2152  | Added ICR_failure_2012.
     8|  32   35.49512     9     7.15877   3350.03006   0.2336  | Added tfp_acf_2012.
     9|  33   32.31115    10     7.15344   3345.74557   0.2346  | Added dummy_patents.
    10|  35   26.77440    11     7.19926   3338.28144   0.2362  | Added misallocated_fixed_2012.
    11|  36   24.37269    12     7.27734   3334.31757   0.2371  | Added area.
    12|  41   15.23427    13     7.68577   3321.72253   0.2399  | Added
      |                                                         | financial_sustainability_2012.
    13|  45   10.46060    14     7.93383   3316.93348   0.2410  | Added interest_diff_2012.
*/


* Failure 2012
*LASSO REGRESSION
lassologit failure_2012 control consdummy area dummy_patents dummy_trademark tfp_acf_2011 shareholders_funds_2011 added_value_2011 cash_flow_2011 ebitda_2011 fin_rev_2011 liquidity_ratio_2011 total_assets_2011 depr_2011 long_term_debt_2011 employees_2011 materials_2011 loans_2011 wage_bill_2011 fixed_assets tax_2011 current_liabilities_2011 current_assets_2011 fin_expenses_2011 int_paid_2011 solvency_ratio_2011 net_income_2011 revenue_2011 capital_intensity_2011 fin_cons_2011 ICR_failure_2011 interest_diff_2011 NEG_VA_2011 real_SA_2011 profitability_2011 misallocated_fixed_2011 financial_sustainability_2011 liquidity_return_2011 int_fixed_assets_2011 

/*
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1  424.95996     0     5.84180   2915.22512  -0.0000  | Added _cons.
     2|   2  386.84028     1     6.83776   2826.26554   0.0305  | Added NEG_VA_2011.
     3|   3  352.14000     2     7.62984   2743.65193   0.0588  | Added profitability_2011.
     4|   6  265.62343     3     8.78691   2642.51687   0.0934  | Added fin_cons_2011.
     5|  10  182.39002     5     9.78069   2520.26625   0.1352  | Added control solvency_ratio_2011.
     6|  15  114.00383     6    10.36798   2342.17961   0.1963  | Added ICR_failure_2011.
     7|  18   85.99446     7    10.70395   2284.75971   0.2159  | Added liquidity_return_2011.
     8|  20   71.25869     8    11.03975   2256.85320   0.2255  | Added real_SA_2011.
     9|  31   25.34301     9    10.94265   2180.81006   0.2515  | Added dummy_patents.
    10|  33   21.00030    11    11.06421   2174.91929   0.2534  | Added dummy_trademark
      |                                                         | tfp_acf_2011.
    11|  34   19.11654    12    11.14388   2172.03916   0.2544  | Added
      |                                                         | financial_sustainability_2011.
    12|  35   17.40175    13    11.22174   2169.52248   0.2552  | Added area.
    13|  39   11.94889    14    11.48597   2162.12342   0.2577  | Added misallocated_fixed_2011.
    14|  41    9.90136    15    11.67437   2159.21696   0.2586  | Added liquidity_ratio_2011.
    15|  42    9.01319    16    11.76272   2157.93859   0.2590  | Added capital_intensity_2011.
    16|  48    5.12839    17    12.23665   2153.04324   0.2606  | Added loans_2011.

*/ 


* Failure 2011
*LASSO REGRESSION
lassologit failure_2011 control consdummy area dummy_patents dummy_trademark tfp_acf_2010 shareholders_funds_2010 added_value_2010 cash_flow_2010 ebitda_2010 fin_rev_2010 liquidity_ratio_2010 total_assets_2010 depr_2010 long_term_debt_2010 employees_2010 materials_2010 loans_2010 wage_bill_2010 fixed_assets tax_2010 current_liabilities_2010 current_assets_2010 fin_expenses_2010 int_paid_2010 solvency_ratio_2010 net_income_2010 revenue_2010 capital_intensity_2010 fin_cons_2010 ICR_failure_2010 interest_diff_2010 NEG_VA_2010 real_SA_2010 profitability_2010 misallocated_fixed_2010 financial_sustainability_2010 liquidity_return_2010 int_fixed_assets_2010 

/*
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1  252.22281     0     5.94208   1513.65877   0.0000  | Added _cons.
     2|   2  229.59796     1     7.04769   1456.43035   0.0381  | Added NEG_VA_2010.
     3|   3  209.00261     2     8.15748   1413.35207   0.0668  | Added liquidity_return_2010.
     4|   9  118.91968     3    10.54285   1339.78198   0.1157  | Added fin_cons_2010.
     5|  12   89.70255     4    11.25168   1291.66124   0.1478  | Added control.
     6|  14   74.33137     5    11.63536   1254.40772   0.1727  | Added solvency_ratio_2010.
     7|  24   29.04082     6    12.55102   1168.82311   0.2295  | Added real_SA_2010.
     8|  25   26.43580     7    12.49087   1165.04457   0.2323  | Added ICR_failure_2010.
     9|  32   13.69236     8    12.23390   1148.24255   0.2437  | Added misallocated_fixed_2010.
    10|  35   10.32831     9    12.26123   1145.19206   0.2460  | Added dummy_trademark.
    11|  37    8.55848    12    12.37597   1144.55835   0.2473  | Added dummy_patents tfp_acf_2010
      |                                                         | financial_sustainability_2010.
    12|  42    5.34952    15    12.78086   1141.92694   0.2499  | Added liquidity_ratio_2010
      |                                                         | capital_intensity_2010
      |                                                         | profitability_2010.
    13|  43    4.86966    15    12.91307   1141.23454   0.2503  | Added loans_2010.
    14|  48    3.04381    16    13.40155   1139.27398   0.2519  | Added net_income_2010.
    15|  49    2.77077    18    13.47516   1139.76693   0.2521  | Added fin_expenses_2010.
 
*/

* Failure 2010
*LASSO REGRESSION
lassologit failure_2010 control consdummy area dummy_patents dummy_trademark tfp_acf_2009 shareholders_funds_2009 added_value_2009 cash_flow_2009 ebitda_2009 fin_rev_2009 liquidity_ratio_2009 total_assets_2009 depr_2009 long_term_debt_2009 employees_2009 materials_2009 loans_2009 wage_bill_2009 fixed_assets tax_2009 current_liabilities_2009 current_assets_2009 fin_expenses_2009 int_paid_2009 solvency_ratio_2009 net_income_2009 revenue_2009 capital_intensity_2009 fin_cons_2009 ICR_failure_2009 interest_diff_2009 NEG_VA_2009 real_SA_2009 profitability_2009 misallocated_fixed_2009 financial_sustainability_2009 liquidity_return_2009 int_fixed_assets_2009 

/*
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1  239.96385     0     5.97794   1716.88430  -0.0000  | Added _cons.
     2|   2  218.43865     2     7.10897   1657.64942   0.0348  | Added NEG_VA_2009
      |                                                         | liquidity_return_2009.
     3|   9  113.13975     3     9.85243   1556.57218   0.0939  | Added profitability_2009.
     4|  10  102.99091     4    10.07602   1547.06590   0.0995  | Added fin_cons_2009.
     5|  11   93.75243     5    10.34168   1524.13073   0.1131  | Added control.
     6|  12   85.34267     6    10.56031   1501.94693   0.1261  | Added solvency_ratio_2009.
     7|  26   22.89484     7    12.05535   1381.99399   0.1962  | Added area.
     8|  27   20.84113     8    12.08970   1379.49206   0.1978  | Added dummy_trademark.
     9|  29   17.26985     9    12.24279   1374.31116   0.2010  | Added ICR_failure_2009.
    10|  32   13.02686    10    12.45779   1368.81467   0.2043  | Added dummy_patents.
    11|  34   10.79461    11    12.62381   1366.28119   0.2060  | Added
      |                                                         | financial_sustainability_2009.
    12|  39    6.74723    12    13.01612   1362.20902   0.2085  | Added misallocated_fixed_2009.
    13|  40    6.14199    13    13.11492   1361.72651   0.2089  | Added capital_intensity_2009.
    14|  46    3.49471    13    13.58749   1359.03118   0.2105  | Added depr_2009.
    15|  48    2.89587    14    13.70709   1358.82274   0.2108  | Added tax_2009.
    16|  49    2.63610    15    13.76363   1358.87732   0.2109  | Added interest_diff_2009.

*/

* Failure 2009
*LASSO REGRESSION
lassologit failure_2009 control consdummy area dummy_patents dummy_trademark tfp_acf_2008 shareholders_funds_2008 added_value_2008 cash_flow_2008 ebitda_2008 fin_rev_2008 liquidity_ratio_2008 total_assets_2008 depr_2008 long_term_debt_2008 employees_2008 materials_2008 loans_2008 wage_bill_2008 fixed_assets tax_2008 current_liabilities_2008 current_assets_2008 fin_expenses_2008 int_paid_2008 solvency_ratio_2008 net_income_2008 revenue_2008 capital_intensity_2008 fin_cons_2008 ICR_failure_2008 NEG_VA_2008 real_SA_2008 profitability_2008 misallocated_fixed_2008 financial_sustainability_2008 liquidity_return_2008 int_fixed_assets_2008 

/*
  Knot|  ID     Lambda    s      L1-Norm     EBIC     Pseudo-R2 | Entered/removed
------+---------------------------------------------------------+----------------
     1|   1  289.08514     0     6.10407   1762.08687   0.0000  | Added NEG_VA_2008 _cons.
     2|   2  263.15368     2     7.33219   1690.24228   0.0408  | Added liquidity_return_2008.
     3|   9  136.29978     4    10.11686   1560.90856   0.1143  | Added fin_cons_2008
      |                                                         | profitability_2008.
     4|  13   93.59009     6    11.07545   1485.67100   0.1571  | Added control solvency_ratio_2008.
     5|  15   77.55275     7    11.30254   1441.83208   0.1820  | Added ICR_failure_2008.
     6|  26   27.58148     8    12.39328   1342.81600   0.2382  | Added dummy_trademark.
     7|  27   25.10737     9    12.52577   1338.55111   0.2407  | Added real_SA_2008.
     8|  29   20.80504    10    12.61112   1330.27575   0.2454  | Added capital_intensity_2008.
     9|  31   17.23995    11    12.70415   1324.07237   0.2490  | Added
      |                                                         | financial_sustainability_2008.
    10|  38    8.92939    12    13.08678   1313.12121   0.2552  | Added dummy_patents.
    11|  40    7.39927    14    13.23687   1311.55897   0.2562  | Added area tfp_acf_2008.
    12|  43    5.58136    15    13.47698   1309.56293   0.2574  | Added misallocated_fixed_2008.
    13|  46    4.21009    15    13.72435   1308.00307   0.2582  | Added loans_2008.
    14|  50    2.89085    17    14.06995   1306.21534   0.2593  | Added liquidity_ratio_2008.
*/


