*Zombie Indicator
clear all 
cd "C:\Users\Falco\Desktop\Research\Italian Firms\Zombie Hunting\Predictions_BART"
*Use data (2016)
use "bart_pred_2016.dta", clear

*Merge Data(2015)
merge 1:1 BvD_ID_number using bart_pred_2015.dta /* 4,455: OK! */
rename _merge drop2015
*drop if _merge==1
*drop if _merge==2
*drop _merge 

*Merge Data (2014)
merge 1:1 BvD_ID_number using bart_pred_2014.dta
rename _merge drop2014
*drop if _merge==1
*drop if _merge==2
*drop _merge /*master (yr_b) 3595 OK: firms born in 2015, using (yr_d) 2100 + 4455= 6555 OK! */


/*     yr_d |      Freq.     Percent        Cum.
------------+-----------------------------------
       2009 |        249        0.20        0.20
       2010 |        388        0.31        0.52
       2011 |        447        0.36        0.88
       2012 |        531        0.43        1.31
       2013 |        809        0.65        1.96
       2014 |      2,100        1.70        3.66
       2015 |      4,455        3.60        7.26
       2016 |      5,334        4.31       11.57
       2017 |    109,348       88.43      100.00
------------+-----------------------------------
      Total |    123,661      100.00          */


/*     yr_b |      Freq.     Percent        Cum.
------------+-----------------------------------
       2009 |      4,628       13.34       13.34
       2010 |      5,055       14.57       27.91
       2011 |      4,933       14.22       42.14
       2012 |      5,149       14.84       56.98
       2013 |      5,883       16.96       73.94
       2014 |      5,445       15.70       89.64
       2015 |      3,595       10.36      100.00
------------+-----------------------------------
      Total |     34,688      100.00          */

	  
*Merge with names & birth year
merge 1:1 BvD_ID_number using  name_birth_year.dta
*drop if _merge==1
*drop if _merge==2
drop _merge

*Gen Age
gen AGE=floor(age)
hist AGE 

/*I define the start-ups as those firms that were born in correspondence with 
the years that I am analyzing: so firms for instance those firms that were born 
in 2014/2016 */

*Generate Zombie (ruling out START UPS) 2014-2016
gen zombie_2016_2014="."
replace zombie_2016_2014="High Risk" if cat_2014==1 & cat_2015==1 & cat_2016==1 & failure2016!=1 & failure2015!=1 & failure2014!=1 & yr_b<2014 & drop2014==3 & drop2015==3
replace zombie_2016_2014="Medium-High Risk" if cat_2014==2 & cat_2015==1 & cat_2016==1 & failure2016!=1 & failure2015!=1 & failure2014!=1 & yr_b<2014 & drop2014==3 & drop2015==3
replace zombie_2016_2014="Medium-High Risk" if cat_2014==1 & cat_2015==2 & cat_2016==1 & failure2016!=1 & failure2015!=1 & failure2014!=1 & yr_b<2014 & drop2014==3 & drop2015==3
replace zombie_2016_2014="Medium Risk" if cat_2014==2 & cat_2015==2 & cat_2016==1 & failure2016!=1 & failure2015!=1 & failure2014!=1 & yr_b<2014 & drop2014==3 & drop2015==3
replace zombie_2016_2014="Medium Risk" if cat_2014==1 & cat_2015==1 & cat_2016==2 & failure2016!=1 & failure2015!=1 & failure2014!=1 & yr_b<2014 & drop2014==3 & drop2015==3
replace zombie_2016_2014="Medium-Low Risk" if cat_2014==1 & cat_2015==2 & cat_2016==2 & failure2016!=1 & failure2015!=1 & failure2014!=1 & yr_b<2014 & drop2014==3 & drop2015==3
replace zombie_2016_2014="Medium-Low Risk" if cat_2014==2 & cat_2015==1 & cat_2016==2 & failure2016!=1 & failure2015!=1 & failure2014!=1 & yr_b<2014 & drop2014==3 & drop2015==3
replace zombie_2016_2014="Low Risk" if cat_2014==2 & cat_2015==2 & cat_2016==2 & failure2016!=1 & failure2015!=1 & failure2014!=1 & yr_b<2014 & drop2014==3 & drop2015==3
tab zombie_2016_2014 if drop2014==3 & drop2015==3 

/*
zombie_2016_2014 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
               . |    105,641       95.10       95.10
       High Risk |      1,110        1.00       96.10
        Low Risk |        933        0.84       96.94
     Medium Risk |        778        0.70       97.64
Medium-High Risk |      1,300        1.17       98.81
 Medium-Low Risk |      1,325        1.19      100.00
-----------------+-----------------------------------
           Total |    111,087      100.00          */

tab zombie_2016_2014 if zombie_2016_2014!="." & drop2014==3 & drop2015==3 

gen dummy_2016_2014=.
replace dummy_2016_2014=1 if zombie_2016_2014=="High Risk" | zombie_2016_2014=="Medium-High Risk" | zombie_2016_2014=="Medium Risk" | zombie_2016_2014=="Medium-Low Risk" | zombie_2016_2014=="Low Risk"
replace dummy_2016_2014=0 if zombie_2016_2014=="." & drop2014==3 & drop2015==3 


********************************************************************************
********************************************************************************
********************************************************************************
*Merge Data (2013)
merge 1:1 BvD_ID_number using bart_pred_2013.dta /*master (yr_b) 5445 + 3595=9040 OK!,  using (yr_d) 809 OK! */
rename _merge drop2013
*drop if _merge==1
*drop if _merge==2
*drop _merge

*Generate Zombie (ruling out START UPS) 2013-2015
gen zombie_2015_2013="."
replace zombie_2015_2013="High Risk" if cat_2013==1 & cat_2014==1 & cat_2015==1 & failure2014!=1 & failure2015!=1 & failure2013!=1 & yr_b<2013 
replace zombie_2015_2013="Medium-High Risk" if cat_2013==2 & cat_2014==1 & cat_2015==1 & failure2015!=1 & failure2014!=1 & failure2013!=1 & yr_b<2013 
replace zombie_2015_2013="Medium-High Risk" if cat_2013==1 & cat_2014==2 & cat_2015==1 & failure2015!=1 & failure2014!=1 & failure2013!=1 & yr_b<2013 
replace zombie_2015_2013="Medium Risk" if cat_2013==2 & cat_2014==2 & cat_2015==1 & failure2015!=1 & failure2014!=1 & failure2013!=1 & yr_b<2013 
replace zombie_2015_2013="Medium Risk" if cat_2013==1 & cat_2014==1 & cat_2015==2 & failure2015!=1 & failure2014!=1 & failure2013!=1 & yr_b<2013 
replace zombie_2015_2013="Medium-Low Risk" if cat_2013==1 & cat_2014==2 & cat_2015==2 & failure2015!=1 & failure2014!=1 & failure2013!=1 & yr_b<2013 
replace zombie_2015_2013="Medium-Low Risk" if cat_2013==2 & cat_2014==1 & cat_2015==2 & failure2015!=1 & failure2014!=1 & failure2013!=1 & yr_b<2013 
replace zombie_2015_2013="Low Risk" if cat_2013==2 & cat_2014==2 & cat_2015==2 & failure2015!=1 & failure2014!=1 & failure2013!=1 & yr_b<2013 
tab zombie_2015_2013 if drop2015==3 & drop2014==3 & drop2013==3 

/*
zombie_2015_2013 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
               . |     99,802       94.44       94.44
       High Risk |      1,343        1.27       95.71
        Low Risk |        632        0.60       96.31
     Medium Risk |      1,585        1.50       97.81
Medium-High Risk |        816        0.77       98.58
 Medium-Low Risk |      1,502        1.42      100.00
-----------------+-----------------------------------
           Total |    105,680      100.00           */

tab zombie_2015_2013 if zombie_2015_2013!="." & drop2015==3 & drop2014==3 & drop2013==3 
tab zombie_2015_2013 failure2016 if drop2015==3 & drop2014==3 & drop2013==3

gen dummy_2015_2013=.
replace dummy_2015_2013=1 if zombie_2015_2013=="High Risk" | zombie_2015_2013=="Medium-High Risk" | zombie_2015_2013=="Medium Risk" | zombie_2015_2013=="Medium-Low Risk" | zombie_2015_2013=="Low Risk"
replace dummy_2015_2013=0 if zombie_2015_2013=="." & drop2015==3 & drop2014==3 & drop2013==3 

********************************************************************************
********************************************************************************
********************************************************************************
*Merge Data (2012)
merge 1:1 BvD_ID_number using bart_pred_2012.dta /*master (yr_b)= 3595 + 5445 +5883 = 14923 OK!, using (yr_d) = 531 OK! */
rename _merge drop2012
*drop if _merge==1
*drop if _merge==2
*drop _merge

*Generate Zombie (ruling out START UPS) 2012-2014
merge 1:1 BvD_ID_number using  name_birth_year.dta
*drop if _merge==1
*drop if _merge==2
drop _merge

*Gen Zombie 2014/2012
gen zombie_2014_2012="."
replace zombie_2014_2012="High Risk" if cat_2012==1 & cat_2013==1 & cat_2014==1 & failure2014!=1 & failure2012!=1 & failure2013!=1 & yr_b<2012 
replace zombie_2014_2012="Medium-High Risk" if cat_2012==2 & cat_2013==1 & cat_2014==1 & failure2012!=1 & failure2014!=1 & failure2013!=1 & yr_b<2012 
replace zombie_2014_2012="Medium-High Risk" if cat_2012==1 & cat_2013==2 & cat_2014==1 & failure2012!=1 & failure2014!=1 & failure2013!=1 & yr_b<2012 
replace zombie_2014_2012="Medium Risk" if cat_2012==2 & cat_2013==2 & cat_2014==1 & failure2012!=1 & failure2014!=1 & failure2013!=1 & yr_b<2012 
replace zombie_2014_2012="Medium Risk" if cat_2012==1 & cat_2013==1 & cat_2014==2 & failure2012!=1 & failure2014!=1 & failure2013!=1 & yr_b<2012 
replace zombie_2014_2012="Medium-Low Risk" if cat_2012==1 & cat_2013==2 & cat_2014==2 & failure2012!=1 & failure2014!=1 & failure2013!=1 & yr_b<2012 
replace zombie_2014_2012="Medium-Low Risk" if cat_2012==2 & cat_2013==1 & cat_2014==2 & failure2012!=1 & failure2014!=1 & failure2013!=1 & yr_b<2012 
replace zombie_2014_2012="Low Risk" if cat_2012==2 & cat_2013==2 & cat_2014==2 & failure2012!=1 & failure2014!=1 & failure2013!=1 & yr_b<2012 
tab zombie_2014_2012 if drop2012==3 & drop2014==3 & drop2013==3 

 /*
zombie_2014_2012 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
               . |     96,974       93.01       93.01
       High Risk |      2,344        2.25       95.26
        Low Risk |        700        0.67       95.93
     Medium Risk |      1,546        1.48       97.41
Medium-High Risk |      1,565        1.50       98.91
 Medium-Low Risk |      1,136        1.09      100.00
-----------------+-----------------------------------
           Total |    104,265      100.00          */
		   

tab zombie_2014_2012 if zombie_2014_2012!="." & drop2012==3 & drop2014==3 & drop2013==3 

tab zombie_2014_2012 failure2016
tab zombie_2014_2012 failure2015 

gen dummy_2014_2012=.
replace dummy_2014_2012=1 if zombie_2014_2012=="High Risk" | zombie_2014_2012=="Medium-High Risk" | zombie_2014_2012=="Medium Risk" | zombie_2014_2012=="Medium-Low Risk" | zombie_2014_2012=="Low Risk"
replace dummy_2014_2012=0 if zombie_2014_2012=="." & drop2012==3 & drop2014==3 & drop2013==3


********************************************************************************
*Zombie Analysis of Failure & Resilience 

*ADD DROP!

*Analysis of Failure
tab zombie_2014_2012 failure2015 
tab zombie_2014_2012 failure2016 
tab zombie_2014_2012 if failure2015==1 | failure2016==1
tab zombie_2014_2012 if zombie_2014_2012!="."
/* Aggregate: H 42% (992/2344), MH 36%, M 27%, ML 17%, L 15% , weighted: 31% */

*Zombie Analysis of Resilience (taking H and MH as dummy)
gen dummy_zombie_2014_2012=.
replace dummy_zombie_2014_2012=1 if zombie_2014_2012=="High Risk" | zombie_2014_2012=="Medium-High Risk" & drop2015==3 & drop2014==3 & drop2013==3 & drop2012==3
replace dummy_zombie_2014_2012=0 if zombie_2014_2012=="Medium Risk" | zombie_2014_2012=="Medium-Low Risk" | zombie_2014_2012=="Low Risk" & drop2015==3 & drop2014==3 & drop2013==3 & drop2012==3
tab dummy_zombie_2014_2012

*Resilience with categories
tab cat_2015 if dummy_zombie_2014_2012==1 & drop2015==3 & drop2014==3 & drop2013==3 & drop2012==3
/* 15% of the zombies gets better at t+1 */
tab cat_2016 if dummy_zombie_2014_2012==1 & drop2015==3 & drop2014==3 & drop2013==3 & drop2012==3
/* 20% of the zombies gets better at t+2 */

tab cat_2015 if zombie_2014_2012=="High Risk" 
tab cat_2016 if zombie_2014_2012=="High Risk"

*Resilience with Median
*Year: 2016
gen median_2016=0
_pctile pred_2016, nq(2)
return list
replace median_2016=1 if pred_2016>=.012253
replace median_2016=. if pred_2016==.

tab median_2016 if dummy_zombie_2014_2012==1 /* just 3.65% gets under median in 2 years */

*Year: 2015
gen median_2015=0
_pctile pred_2015, nq(2)
return list
replace median_2015=1 if pred_2015>=.009262 /*change accordingly*/
replace median_2015=. if pred_2015==.

tab median_2015 if dummy_zombie_2014_2012==1 /*just 1.64% gets under median in one year*/


********************************************************************************
****EFFECTS on REVENUES
*General Revenues
egen sumrvn_2014 = sum(rvn2014) if rvn2014!=. & drop2015==3 & drop2014==3 & drop2013==3 & drop2012==3
tab sumrvn_2014 /* 3.06e+11 total revenues 2014 */

*Aggregate Conservative
egen sumrvn_2014_zombie = sum(rvn2014) if dummy_zombie_2014_2012==1 & rvn2014!=. & drop2015==3 & drop2014==3 & drop2013==3 & drop2012==3
tab  sumrvn_2014_zombie /* 9.01e+08 / 3198 = 281738.59 */

*Aggregate not conservative
egen sumrvn_2014_all_zombie = sum(rvn2014) if zombie_2014_2012=="High Risk" | zombie_2014_2012=="Medium-High Risk" | zombie_2014_2012=="Medium Risk" | zombie_2014_2012=="Medium-Low Risk" | zombie_2014_2012=="Low Risk" & rvn2014!=. & drop2015==3 & drop2014==3 & drop2013==3 & drop2012==3
tab sumrvn_2014_all_zombie /* 2.35e+09 / 7217 = 325620.06 */


********************************************************************************
*Imputation on median firm active in 2014
_pctile pred_2014, nq(20)
return list
egen sumrvn_2014_no_zombie = sum(rvn2014) if pred_2014 > .005716 & pred_2014 < 0.005718 & rvn2014!=. & drop2015==3 & drop2014==3 & drop2013==3 & drop2012==3
tab sumrvn_2014_no_zombie /* 8.38e+07 / 25 = 3352000 */

*Conterfactual not conservative

di 3.06e+11 - 2.35e+09 + ( 3352000 * 7217)
di 3.278e+11 / 3.06e+11 /* + 7.12 % being not conservative */

*Counterfactual Conservative
di 3.06e+11 - 9.01e+08 + ( 3352000 * 3198) /* 3.164e+11 */
di 3.158e+11 / 3.06e+11 /* + 3.20 % being conservative */

********************************************************************************
*Imputation on new median new entries (a firm entering the market in 2012 and in the median risk in 2014)
_pctile pred_2014, nq(20)
return list
egen sumrvn_2014_median_new_entries = sum(rvn2014) if yr_b==2012 /*start up */ & pred_2014>.005029 & pred_2014<.006562  /*median */ & rvn2014!=.
tab sumrvn_2014_median_new_entries /* 9.28e+08 / 602 = 1541528.2  */

*Counterfactual new entries not conservative
di 3.06e+11 - 2.35e+09 + (1541528.2 * 7217)
di 3.148e+11 / 3.06e+11 /* + 2.87 % */

*Conterfactual new entries conservative
di 3.06e+11 - 9.01e+08 + (1541528.2 * 3198)
di 3.100e+11 / 3.06e+11 /* + 1.31 % */


********************************************************************************
*Imputation on new entries not failed
egen sumrvn_2014_new_entries = sum(rvn2014) if yr_b==2012 & failure2015!=1 & failure2016!=1 & rvn2014!=.
tab sumrvn_2014_new_entries /* 5.52e+09 / 4274 = 1291530.2  */

*Counterfactual new entries not conservative
di 3.06e+11 - 2.35e+09 + (1291530.2 * 7217)
di 3.130e+11 / 3.06e+11 /* + 2.28 % */

*Conterfactual new entries conservative
di 3.06e+11 - 9.01e+08 + (1291530.2 * 3198)
di 3.092e+11 / 3.06e+11 /* + 1.04 % */


********************************************************************************
********************************************************************************
********************************************************************************
*Merge Data (2011)
merge 1:1 BvD_ID_number using bart_pred_2011.dta /*master (yr_b) = 3595 +5445 +5883+5149 = 20072 OK!, using (yr_d) 447 OK! */
rename _merge drop2011
*drop if _merge==1
*drop if _merge==2
*drop _merge

merge 1:1 BvD_ID_number using  name_birth_year.dta
*drop if _merge==1
*drop if _merge==2
drop _merge


*Generate Zombie (ruling out START UPS) 2011-2013
gen zombie_2013_2011="."
replace zombie_2013_2011="High Risk" if cat_2011==1 & cat_2012==1 & cat_2013==1 & failure2011!=1 & failure2012!=1 & failure2013!=1 & yr_b<2011 
replace zombie_2013_2011="Medium-High Risk" if cat_2011==2 & cat_2012==1 & cat_2013==1 & failure2012!=1 & failure2011!=1 & failure2013!=1 & yr_b<2011 
replace zombie_2013_2011="Medium-High Risk" if cat_2011==1 & cat_2012==2 & cat_2013==1 & failure2012!=1 & failure2011!=1 & failure2013!=1 & yr_b<2011 
replace zombie_2013_2011="Medium Risk" if cat_2011==2 & cat_2012==2 & cat_2013==1 & failure2012!=1 & failure2011!=1 & failure2013!=1 & yr_b<2011 
replace zombie_2013_2011="Medium Risk" if cat_2011==1 & cat_2012==1 & cat_2013==2 & failure2012!=1 & failure2011!=1 & failure2013!=1 & yr_b<2011 
replace zombie_2013_2011="Medium-Low Risk" if cat_2011==1 & cat_2012==2 & cat_2013==2 & failure2012!=1 & failure2011!=1 & failure2013!=1 & yr_b<2011 
replace zombie_2013_2011="Medium-Low Risk" if cat_2011==2 & cat_2012==1 & cat_2013==2 & failure2012!=1 & failure2011!=1 & failure2013!=1 & yr_b<2011 
replace zombie_2013_2011="Low Risk" if cat_2011==2 & cat_2012==2 & cat_2013==2 & failure2012!=1 & failure2011!=1 & failure2013!=1 & yr_b<2011

tab zombie_2013_2011 if drop2013==3 & drop2012==3 & drop2011==3

/*

zombie_2013_2011 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
               . |     94,604       92.77       92.77
       High Risk |      2,389        2.34       95.11
        Low Risk |        786        0.77       95.89
     Medium Risk |      1,553        1.52       97.41
Medium-High Risk |      1,452        1.42       98.83
 Medium-Low Risk |      1,191        1.17      100.00
-----------------+-----------------------------------
           Total |    101,975      100.00          */

		   
tab zombie_2013_2011 if zombie_2013_2011!="."  & drop2013==3 & drop2012==3 & drop2011==3
tab zombie_2013_2011 failure2014 if drop2014==3 & drop2015==3 & drop2013==3 & drop2012==3 & drop2011==3

gen dummy_2013_2011=.
replace dummy_2013_2011=1 if zombie_2013_2011=="High Risk" | zombie_2013_2011=="Medium-High Risk" | zombie_2013_2011=="Medium Risk" | zombie_2013_2011=="Medium-Low Risk" | zombie_2013_2011=="Low Risk"
replace dummy_2013_2011=0 if zombie_2013_2011=="." & drop2013==3 & drop2012==3 & drop2011==3
********************************************************************************
*                 MACROECONOMIC ANALYSIS 2011/2013
********************************************************************************
*                          REVENUES

*Average Total Revenues 2011/2013
local revenues rvn2011 rvn2012 rvn2013 rvn2014 rvn2015
foreach x in `revenues' { 
egen sum_`x' = sum(`x') if `x'!=.
}

tab sum_rvn2013 if rvn2013!=. /*108777*/
tab sum_rvn2012 if rvn2012!=. /*102906*/
tab sum_rvn2011 if rvn2011!=. /*97798 */
di (2.99e+11*0.35) + (3.97e+11 * 0.33) + (3.03e+11 * 0.32)
/* weighted average of revenues 2011/2013 = 3.326e+11 */

*Average Total Revenues Zombies 2011/2013
local revenues rvn2011 rvn2012 rvn2013 rvn2014 rvn2015
foreach x in `revenues' { 
egen sum_`x'_zombies = sum(`x') if `x'!=. & zombie_2013_2011!="."  & drop2013==3 & drop2012==3 & drop2011==3
}

tab sum_rvn2011_zombies /*Average should be weighted with Total to be more precise*/
tab sum_rvn2012_zombies
tab sum_rvn2013_zombies
di ( 3.79e+09 + 3.62e+09 + 2.84e+09)/3 /*Average total zombies = 3.417e+09 */
di 3.417e+09/7371 /*Average revenues per zombie = 463573.46 */

*Average Total Revenues Newly born firm
local revenues rvn2011 rvn2012 rvn2013 rvn2014 rvn2015 
foreach x in `revenues' { 
egen sum_`x'_start_up = sum(`x') if `x'!=. & yr_b==2011 & failure2011!=. & failure2012!=. & failure2013!=. & dummy_2013_2011!=1
}

tab sum_rvn2011_start_up
tab sum_rvn2012_start_up
tab sum_rvn2013_start_up
di ( 1.69e+09 + 6.06e+09  + 5.78e+09)/ 3 /* Average total start up = 4.510e+09 */
di 4.510e+09/4926 /*Average revenues per start up = 915550.14 */

*Average Counterfactual Zombie VS Start Up
di  3.326e+11 /*Average Total*/ - 3.417e+09 /*Average Total Zombies*/ + ( 915550.14 * 7371 /*Average number of zombies*/ )
di 3.359e+11/3.326e+11 /* Total Increase by start up 1% for the average */ 

*For 2013 
tab sum_rvn2013_zombie /* 2.84e+09/7291 =  389521.33*/
di 5.78e+09/4795 /*Average revenue start up = 1205422.3 */
di 2.99e+11 /*total revenues 2013*/ - 2.84e+09 /*zombie revenues 2013*/ + (1205422.3 * 7291 /*zombie with rvn not missing in 2013*/)
di 3.049e+11/2.99e+11 /* Increase of 1.97% */

*Micro level
di 1205422.3 - 389521.33  /* = 815900.97 differential average rvn */
di 1205422.3 / 389521.33  /* 3.0946246 times the revenues of a zombie */

*For 2014 
tab sum_rvn2014_zombie /*2.71e+09 / 5963 = 454469.23 */
tab sum_rvn2014_start_up 
di 6.01e+09/4370 /*Average start up rvn in 2014 = 1375286 */
di sum_rvn2014
di 3.063e+11 /*tot rvn 2014*/ - 2.71e+09 /*tot zomb_rvn2014*/ + (1375286 * 5963 /*zombies 2014*/)
di 3.118e+11 / 3.063e+11 /*1.80 % */

*Micro level
di 1375286 - 454469.23 /* = 920816.77  adjust for inflation*/
di 1375286 / 454469.23 /* 3.0261367 */

*For 2015
tab sum_rvn2015_zombie /* 2.69e+09/ 4659 = 577377.12 */
tab sum_rvn2015_start_up 
di 6.09e+09/3829 /*1590493.6*/
di sum_rvn2015
di  3.193e+11 - 2.69e+09 + ( 1590493.6 * 4659)
di 3.240e+11/3.193e+11 /* 1.5 % */

*Micro level
di 1590493.6 - 577377.12 /* 1013116.5 */
di 1590493.6/577377.12 /*2.7546876*/

*Correct for Resilience (rule out resilient firms)
*2013 /*check pred*/
egen sum_rvn_zombie_resilience_2013 = sum(rvn2013) if pred_2014>.011328 & rvn2013!=. & zombie_2013_2011!="."  & drop2013==3 & drop2012==3 & drop2011==3
tab sum_rvn_zombie_resilience_2013 /*avg 1.97e+09/6366= 309456.49 */
di 2.99e+11 /*total revenues 2013*/ - 1.97e+09  + ( 1205422.3 * 6366)
di 3.047e+11/2.99e+11 /* Increase 1.90 */

*Micro level
di 1205422.3 - 309456.49
di 1205422.3 / 309456.49 /* 3.8952885 */

*2014
egen sum_rvn_zombie_resilience_2014 = sum(rvn2014) if pred_2014>.011328 & rvn2014!=. & zombie_2013_2011!="."  & drop2014==3 & drop2013==3 & drop2012==3 & drop2011==3
tab sum_rvn_zombie_resilience_2014 /* 1.80e+09 / 5029 = 357924.04 */
di 3.063e+11 -  1.80e+09 + (1375286  * 5029)
di 3.114e+11/ 3.063e+11 /* 1.67% */

*Micro level
di 1375286 - 357924.04
di 1375286 / 357924.04 /* 3.8423963 */

*2015 
egen sum_rvn_zombie_resilience_2015 = sum(rvn2015) if pred_2015>.023566 & rvn2015!=. & zombie_2013_2011!="."  & drop2014==3 & drop2013==3 & drop2012==3 & drop2011==3
tab sum_rvn_zombie_resilience_2015 /* 1.22e+09/3233 = 377358.49 */
di 3.193e+11 - 1.22e+09 + ( 1590493.6 * 3233)
di 3.232e+11/3.193e+11 /* 1.2% */

*Micro level
di  1590493.6 - 377358.49
di  1590493.6/377358.49 /* 4.214808*/

********************************************************************************
*                                 Employees
*Total Employees 
local revenues employees2013 employees2014 employees2015
foreach x in `revenues' { 
egen sum_`x' = sum(`x') if `x'!=.
}

tab sum_employees2013
tab sum_employees2014
tab sum_employees2015

*Employees in Zombie firms
local employees employees2013 employees2014 employees2015
foreach x in `employees' { 
egen sum_`x'_zombies = sum(`x') if `x'!=. & zombie_2013_2011!="."  & drop2013==3 & drop2012==3 & drop2011==3
}

tab sum_employees2013_zombies /*8.85*/
tab sum_employees2014_zombies /*10.23*/
tab sum_employees2015_zombies /*8.25*/

*Employees in Start Ups
local revenues employees2013 employees2014 employees2015
foreach x in `revenues' { 
egen sum_`x'_start_up = sum(`x') if `x'!=. & yr_b==2011 & failure2011!=. & failure2012!=. & failure2013!=. & dummy_2013_2011!=1
}

tab sum_employees2013_start_up /*11.44 employees per firm */
tab sum_employees2014_start_up /*11.94 */
tab sum_employees2015_start_up /*12.91*/

*MACROs
*2013
di 2672384 /*total employees in 2013*/ - 32258 + ( 11.44 /*avg emp st_up*/ * 3646 /*num zomb*/)
di 2681836.2/2672385 /* 0.3 % */

*On all the zombies alive
di 2672384 /*total employees in 2013*/ - (8.85 * 7371) + (11.44 * 7371)
di 2691474.9/2672384 /* 0.71 % */

*2014
di 2907019 /*total empl 2014*/ - 32165 /*emp zombies*/ + (11.94 * 3145)
di  2912405.3/2907019 /*0.1% */

*On all the zombies alive
di 2907019 - (10.23 * 6851 /*zombies alive in 2014*/ ) + (11.94 * 6851)
di 2918734.2/2907019 /* 0.40% */

*2015
di 2712283 /* t e 2015*/ - 21161 + (12.91*2564)
di 2712283/ 2712283 /*0.4 %*/

*On all zombies alive
di 2712283 - (8.25 * 6018 /*zombies alive in 2015*/) + (12.91 * 6018)
di 2740326.9/2712283 /*1.03% */

*Employees ruling out RESILIENT FIRMS
*2013
egen sum_emp_zombie_resilience_2013 = sum(employees2013) if pred_2014>.011328 & employees2013!=. & zombie_2013_2011!="."  & drop2013==3 & drop2012==3 & drop2011==3
tab sum_emp_zombie_resilience_2013 /*25759/2830 = 9.10 */

di 2672384 /*total employees in 2013*/ - 25759 /*emp zomb*/ + (11.44 *2830)
di 2679000.2/2672384 /* 0.2% */

*On all zombies alive 2013 (6368 firms)
di 2672384 - (9.10 * 6368) + (11.44 * 6368)
di 2687285.1/2672384 /* 0.55%*/

*2014
count if dummy_2013_2011==1 & pred_2014>.011328 /*6368 firms */
egen sum_emp_zombie_resilience_2014 = sum(employees2014) if pred_2014>.011328 & employees2014!=. & zombie_2013_2011!="."  & drop2013==3 & drop2012==3 & drop2011==3
tab sum_emp_zombie_resilience_2014 /*20337/2342 = 8.63 */

*On zombies alive in 2014
di 2907019 /*total empl 2014*/  - (8.63*6368) + (11.94 * 6368)
di 2928097.1/2907019 /* 0.72% */


*2015
egen sum_emp_zombie_resilience_2015 = sum(employees2015) if pred_2015>.023566 & employees2015!=. & zombie_2013_2011!="."  & drop2014==3 & drop2013==3 & drop2012==3 & drop2011==3
tab sum_emp_zombie_resilience_2015 /*10951/ 1333 = 8.21 */

di 2712283 /* t e 2015*/ - 10951 + (12.91*1333)
di 2718541/2712283 /* 0.2% */

*On all zombies alive in 2015(5769)
count if dummy_2013_2011==1 & pred_2015>.023566
di 2712283 - (8.21 * 5769) + (12.91 * 5769)
di 2739397.3/ 2712283 /* 1.00% */

********************************************************************************
*                                Value Added
*Merge with names & birth year
merge 1:1 BvD_ID_number using  value_added.dta
*drop if _merge==1
*drop if _merge==2
drop _merge

*Total Value Added
local va added_value2013 added_value2014 added_value2015
foreach x in `va' { 
egen sum_`x' = sum(`x') if `x'!=.
}

tab sum_added_value2013
tab sum_added_value2014
tab sum_added_value2015

*Value Added in Zombie firms
local va added_value2013 added_value2014 added_value2015
foreach x in `va' { 
egen sum_`x'_zombies = sum(`x') if `x'!=. & zombie_2013_2011!="."  & drop2013==3 & drop2012==3 & drop2011==3
}

tab sum_added_value2013_zombies /*19719.251*/
tab sum_added_value2014_zombies /*230356.46*/
tab sum_added_value2015_zombies /*95859.586*/

*Value Added in Start Ups
local va added_value2013 added_value2014 added_value2015
foreach x in `va' { 
egen sum_`x'_start_up = sum(`x') if `x'!=. & yr_b==2011 & failure2011!=. & failure2012!=. & failure2013!=. & dummy_2013_2011!=1
}

tab sum_added_value2013_start_up /*526315.79*/
tab sum_added_value2014_start_up /*585858.59*/
tab sum_added_value2015_start_up /*653698.98*/

*2013
di 1.56e+11  /*total va2013*/ - 5.90e+07 /*Va zomb*/ + ( 526315.79 /*avg start up*/ * 2992 /*zomb num*/)
di 1.575e+11/1.56e+11 /* 0.96% */

*On total number of zombies
di 1.56e+11  /*total va2013*/ - ( 19719.251 /*avg zombie*/ * 7371 /*zombies 2013*/) + ( 526315.79 /*avg start up*/ * 7371 /*zomb num*/)
di 1.597e+11/1.56e+11 /* 2.37 % */

*2014
di 1.70e+11 - 6.01e+08 + ( 585858.59 * 2609)
di 1.709e+11/1.70e+11 /* 0.52 % */

*On total number of zombies alive
di 1.70e+11 - (230356.46 * 6851) + ( 585858.59 * 6851)
di  1.724e+11/1.70e+11 /*1.41 % */

*2015
*On total number of zombies alive
di 1.74e+11 - (95859.586 * 6018) + ( 653698.98 * 6018)
di 1.774e+11/1.74e+11 /*1.95 % */

*Analysis on NOT RESILIENT firms
*2013  (6368 firms)
egen sum_added_value_nores_2013 = sum(added_value2013) if pred_2014>.011328 & added_value2013!=. & zombie_2013_2011!="."  & drop2013==3 & drop2012==3 & drop2011==3
tab sum_added_value_nores_2013 /*  -87735.416 */
di 1.56e+11  /*total va2013*/ - ( -87735.416 * 6368 ) + (  526315.79 /*avg start up*/ * 6368)
di 1.599e+11/1.56e+11 /* 2.50% */

*2014 
*On zombies alive and no resilient (6368 firms)
egen sum_added_value_nores_2014 = sum(added_value2014) if pred_2014>.011328 & added_value2014!=. & zombie_2013_2011!="."  & drop2013==3 & drop2012==3 & drop2011==3
tab sum_added_value_nores_2014 /* 219762.42 */
di 1.70e+11 - (219762.42 * 6368) + ( 585858.59  * 6368)
di 1.723e+11/1.70e+11 /* 1.35% */


*2015 (5769)
egen sum_added_value_nores_2015 = sum(added_value2015) if pred_2015>.023566 & added_value2015!=. & zombie_2013_2011!="."  & drop2013==3 & drop2012==3 & drop2011==3
tab sum_added_value_nores_2015 /* -188642.93 */
di 1.74e+11 - ( -188642.93  * 5769) + ( 653698.98 * 5769)
di 1.789e+11/1.74e+11 /* 2.81 */

********************************************************************************
*                ANALYSIS OF FAILURE/PERSISTENCE/RESILIENCE
********************************************************************************

*Failure
tab zombie_2013_2011 failure2014 if zombie_2013_2011!="." /* 520 / 7371 = 0.07 */
tab zombie_2013_2011 failure2015 if zombie_2013_2011!="." /* 833 / 6851 = 0.12 */
tab zombie_2013_2011 failure2016 if zombie_2013_2011!="." /* 917 / 6018 = 0.15 */

*Resilience VS Persistence
*2014
_pctile pred_2014, nq(10) /* 70th percentile on: .011328/.0057175= 2 times */
return list
*70%
tab zombie_2013_2011 if zombie_2013_2011!="." & pred_2014<.011328 & failure2014!=1
tab zombie_2013_2011 if zombie_2013_2011!="." & pred_2014>.011328 & failure2014!=1
*50%
tab zombie_2013_2011 if zombie_2013_2011!="." & pred_2014< .0057175 & failure2014!=1
tab zombie_2013_2011 if zombie_2013_2011!="." & pred_2014> .0057175 & failure2014!=1
count if dummy_2013_2011==1 

*2015
_pctile pred_2015, nq(10) /* .023566 / .009262 = 2.5 */
return list
*70%
tab zombie_2013_2011 if zombie_2013_2011!="." & pred_2015< .023566 & failure2015!=1 
tab zombie_2013_2011 if zombie_2013_2011!="." & pred_2015> .023566 & failure2015!=1 & pred_2015!=.
count if dummy_2013_2011==1 & failure2014!=1 & failure2015!=1
*50%
tab zombie_2013_2011 if zombie_2013_2011!="." & pred_2015< .009262 & failure2015!=1 
tab zombie_2013_2011 if zombie_2013_2011!="." & pred_2015> .009262 & failure2015!=1 & pred_2015!=.
count if dummy_2013_2011==1 & failure2014!=1

*2016
_pctile pred_2016, nq(10) /* .03222 / .012253 = 2.5 */
return list
*70%
tab zombie_2013_2011 if zombie_2013_2011!="." & pred_2016<  .03222   & failure2016!=1 
tab zombie_2013_2011 if zombie_2013_2011!="." & pred_2016 > .03222   & failure2016!=1 & pred_2016!=.
*50%
tab zombie_2013_2011 if zombie_2013_2011!="." & pred_2016<  .012253  & failure2016!=1 
tab zombie_2013_2011 if zombie_2013_2011!="." & pred_2016 > .012253   & failure2016!=1 & pred_2016!=.
count if dummy_2013_2011==1 & failure2014!=1 & failure2015!=1

*Analysis on H - MH (52% of all zombies/  3.8% of entire pop)

gen high_risk_2013_2011=.
replace high_risk_2013_2011=1 if zombie_2013_2011=="High Risk" | zombie_2013_2011=="Medium-High Risk"
tab high_risk_2013_2011 failure2014 if zombie_2013_2011!="." /* 323 / 3841 = 0.08 */
tab high_risk_2013_2011 failure2015 if zombie_2013_2011!="." /* 528 / 3518 = 0.15 */
tab high_risk_2013_2011 failure2016 if zombie_2013_2011!="." /* 553 / 2990 = 0.18 */

*Resilience VS Persistence
*2014
_pctile pred_2014, nq(10) /* 70th percentile on: .011328/.0057175= 2 times */
return list
*70 %
tab high_risk_2013_2011 if zombie_2013_2011!="." & pred_2014<.011328 & failure2014!=1
tab high_risk_2013_2011 if zombie_2013_2011!="." & pred_2014>.011328 & failure2014!=1

tab dummy_2014_2012 if high_risk_2013_2011==1 /*79% still zombies*/

*50%
tab high_risk_2013_2011 if zombie_2013_2011!="." & pred_2014<.0057175 & failure2014!=1
tab high_risk_2013_2011 if zombie_2013_2011!="." & pred_2014>.0057175 & failure2014!=1

tab dummy_2014_2012 if high_risk_2013_2011==1 /*96% still zombies*/

*2015 Total:3518 high risk zombies alive in 2015
count if high_risk_2013_2011==1  & failure2014!=1
tab failure2015 if high_risk_2013_2011==1 & failure2014!=1 /*15 %*/
_pctile pred_2015, nq(10) /* .023566 / .009262 = 2.5 */
return list
*50%
count if  pred_2015< .009262 & pred_2015!=. & high_risk_2013_2011==1 & failure2015!=1 /*7 % resilient */
count if pred_2015> .009262 & pred_2015!=. & high_risk_2013_2011==1 & failure2015!=1 /*66% persistent */
tab dummy_2015_2013 if high_risk_2013_2011==1  & failure2015!=1  /*56% still zombies*/

*70%
count if  pred_2015< .023566 & pred_2015!=. & high_risk_2013_2011==1 & failure2015!=1 /*17 % resilient */
count if pred_2015> .023566 & pred_2015!=. & high_risk_2013_2011==1 & failure2015!=1 /*66% persistent */
tab dummy_2015_2013 if high_risk_2013_2011==1  & failure2015!=1  /*56% still zombies*/


*2016 Total: 2990 high risk zombies alive in 2016
count if high_risk_2013_2011==1 & failure2015!=1 & failure2014!=1
tab failure2016 if high_risk_2013_2011==1 & failure2015!=1 & failure2014!=1 /*19 % */
_pctile pred_2016, nq(10) /* .03222 / .012253 = 2.5 */
return list
*70%
count if pred_2016<  .03222 & pred_2016!=. & high_risk_2013_2011==1 & failure2015!=1 & failure2014!=1 & failure2016!=1 /*19% resilient */ 
count if pred_2016 >= .03222  & pred_2016!=.  & high_risk_2013_2011==1 & failure2015!=1 & failure2014!=1  & failure2016!=1/*62% not resilient */

tab dummy_2016_2014 if high_risk_2013_2011==1  /*35% still zombies */

********************************************************************************
********************************************************************************
********************************************************************************
*Merge Data (2010)
merge 1:1 BvD_ID_number using bart_pred_2010.dta /*master 3595 + 5445 + 5883 + 5149 + 4933 = 25005 OK!, using (yr_d) 388 OK! */
rename _merge drop2010
*drop if _merge==1
*drop if _merge==2
*drop _merge


merge 1:1 BvD_ID_number using  name_birth_year.dta
*drop if _merge==1
*drop if _merge==2
drop _merge


*Generate Zombie (ruling out START UPS) 2010-2012
gen zombie_2012_2010="."
replace zombie_2012_2010="High Risk" if cat_2010==1 & cat_2011==1 & cat_2012==1 & failure2011!=1 & failure2012!=1 & failure2010!=1 & yr_b<2010
replace zombie_2012_2010="Medium-High Risk" if cat_2010==2 & cat_2011==1 & cat_2012==1 & failure2012!=1 & failure2011!=1 & failure2010!=1 & yr_b<2010
replace zombie_2012_2010="Medium-High Risk" if cat_2010==1 & cat_2011==2 & cat_2012==1 & failure2012!=1 & failure2011!=1 & failure2010!=1 & yr_b<2010
replace zombie_2012_2010="Medium Risk" if cat_2010==2 & cat_2011==2 & cat_2012==1 & failure2012!=1 & failure2011!=1 & failure2010!=1 & yr_b<2010
replace zombie_2012_2010="Medium Risk" if cat_2010==1 & cat_2011==1 & cat_2012==2 & failure2012!=1 & failure2011!=1 & failure2010!=1 & yr_b<2010
replace zombie_2012_2010="Medium-Low Risk" if cat_2010==1 & cat_2011==2 & cat_2012==2 & failure2012!=1 & failure2011!=1 & failure2010!=1 & yr_b<2010
replace zombie_2012_2010="Medium-Low Risk" if cat_2010==2 & cat_2011==1 & cat_2012==2 & failure2012!=1 & failure2011!=1 & failure2010!=1 & yr_b<2010
replace zombie_2012_2010="Low Risk" if cat_2010==2 & cat_2011==2 & cat_2012==2 & failure2012!=1 & failure2011!=1 & failure2010!=1 & yr_b<2010

tab zombie_2012_2010 if drop2012==3 & drop2011==3 & drop2010==3

/*

zombie_2012_2010 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
               . |     91,033       93.30       93.30
       High Risk |      2,284        2.34       95.64
        Low Risk |        592        0.61       96.24
     Medium Risk |      1,397        1.43       97.68
Medium-High Risk |      1,321        1.35       99.03
 Medium-Low Risk |        946        0.97      100.00
-----------------+-----------------------------------
           Total |     97,573      100.00           */



		   
tab zombie_2012_2010 if zombie_2012_2010!="."  & drop2012==3 & drop2011==3 & drop2010==3
tab zombie_2012_2010 failure2013

gen dummy_2012_2010=.
replace dummy_2012_2010=1 if zombie_2012_2010=="High Risk" | zombie_2012_2010=="Medium-High Risk" | zombie_2012_2010=="Medium Risk" | zombie_2012_2010=="Medium-Low Risk" | zombie_2012_2010=="Low Risk"
replace dummy_2012_2010=0 if zombie_2012_2010=="."  & drop2012==3 & drop2011==3 & drop2010==3

********************************************************************************
********************************************************************************
********************************************************************************
*Merge Data (2009) (I have no data on interest_diff for this year)
merge 1:1 BvD_ID_number using bart_pred_2009.dta /*master (yr_b) = 25,005 + 5055 = 30060 OK!, using (yr_d) 249 OK! */
rename _merge drop2009
*drop if _merge==1
*drop if _merge==2
*drop _merge

*Generate Zombie (ruling out START UPS) 2009-2011
gen zombie_2011_2009="."
replace zombie_2011_2009="High Risk" if cat_2009==1 & cat_2010==1 & cat_2011==1 & failure2011!=1 & failure2009!=1 & failure2010!=1 & yr_b<2009
replace zombie_2011_2009="Medium-High Risk" if cat_2009==2 & cat_2010==1 & cat_2011==1 & failure2009!=1 & failure2011!=1 & failure2010!=1 & yr_b<2009
replace zombie_2011_2009="Medium-High Risk" if cat_2009==1 & cat_2010==2 & cat_2011==1 & failure2009!=1 & failure2011!=1 & failure2010!=1 & yr_b<2009
replace zombie_2011_2009="Medium Risk" if cat_2009==2 & cat_2010==2 & cat_2011==1 & failure2009!=1 & failure2011!=1 & failure2010!=1 & yr_b<2009
replace zombie_2011_2009="Medium Risk" if cat_2009==1 & cat_2010==1 & cat_2011==2 & failure2009!=1 & failure2011!=1 & failure2010!=1 & yr_b<2009
replace zombie_2011_2009="Medium-Low Risk" if cat_2009==1 & cat_2010==2 & cat_2011==2 & failure2009!=1 & failure2011!=1 & failure2010!=1 & yr_b<2009
replace zombie_2011_2009="Medium-Low Risk" if cat_2009==2 & cat_2010==1 & cat_2011==2 & failure2009!=1 & failure2011!=1 & failure2010!=1 & yr_b<2009
replace zombie_2011_2009="Low Risk" if cat_2009==2 & cat_2010==2 & cat_2011==2 & failure2009!=1 & failure2011!=1 & failure2010!=1 & yr_b<2009

tab zombie_2011_2009 if  drop2011==3 & drop2010==3 & drop2009==3

/*
zombie_2011_2009 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
               . |     87,267       93.87       93.87
       High Risk |      1,938        2.08       95.96
        Low Risk |        565        0.61       96.56
     Medium Risk |        979        1.05       97.62
Medium-High Risk |      1,344        1.45       99.06
 Medium-Low Risk |        871        0.94      100.00
-----------------+-----------------------------------
           Total |     92,964      100.00          */



tab zombie_2011_2009 if zombie_2011_2009!="." &  drop2011==3 & drop2010==3 & drop2009==3
tab zombie_2011_2009 failure2012 if zombie_2011_2009!="."

gen dummy_2011_2009=.
replace dummy_2011_2009=1 if zombie_2011_2009=="High Risk" | zombie_2011_2009=="Medium-High Risk" | zombie_2011_2009=="Medium Risk" | zombie_2011_2009=="Medium-Low Risk" | zombie_2011_2009=="Low Risk"
replace dummy_2011_2009=0 if zombie_2011_2009=="." & drop2011==3 & drop2010==3 & drop2009==3

********************************************************************************
*                           MICRO ANALYSIS
********************************************************************************
tab company_name if zombie_2015_2013=="High Risk"
tab company_name if zombie_2015_2013=="High Risk" & rvn2013>1000000
tab company_name if zombie_2016_2014=="High Risk" & employees2014>=20 & employees2015!=.

_pctile employees2015, nq(20)
return list
/*consorzio toscana costruzioni, cartiere di lucca, ideal, la perla abbigliamento,
 start ITC: http://www.reportaziende.it/consorzio_start_spa?anno3=2011,
 C M L COSTRUZIONI METALLICHE LUCCHESI,

import delimited "C:\Users\Falco\Desktop\Research\Italian Firms\Zombie Hunting\Predictions_BART\name_birth_year.csv", varnames(1) clear 

*Date of Incorporation
gen newstrvar = subinstr(date_of_incorporation, "/", "", .)
replace newstrvar = "0101" + newstrvar if strlen(newstrvar)==4
gen my_date_of_incorporation=.
replace my_date_of_incorporation=date(newstrvar, "DMY") 
format my_date_of_incorporation %td

*Year of birth
gen yr_b=.
replace yr_b=year(my_date_of_incorporation)
tab yr_b

*TABLES

latabstat age employees2015 WE2015 NEG_VA2015 ICR_failure2015  if dummy_2016_2014==1, ///
	columns(statistics) statistics(mean p1 p25 p50 p75 p99) ///
	cap(Summary Statistics) clabel(summary-statistics) ///
	tf(summary-statistics) replace 
	
latabstat age employees2015 WE2015 NEG_VA2015 ICR_failure2015 if dummy_2016_2014==0, ///
	columns(statistics) statistics(mean p1 p25 p50 p75 p99) ///
	cap(Summary Statistics) clabel(summary-statistics) ///
	tf(summary-statistics) replace

latab zone if dummy_2016_2014==1
latab zone if dummy_2016_2014==0


levelsof region_in_country, local(levels) 
foreach l of local levels {
 count if dummy_2016_2014==1 & region_in_country == "`l'"
}

levelsof region_in_country, local(levels) 
foreach l of local levels {
 count if dummy_2013_2011==1 & region_in_country == "`l'" & (failure2014==1 | failure2015==1 | failure2016==1)
}

tab region, matcell(x)
matrix list x

tab region


