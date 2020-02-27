*                          REVENUES

*Average Total Revenues 2011/2013
local revenues rvn2013 rvn2014 rvn2015
foreach x in `revenues' { 
egen sum_`x' = sum(`x') if `x'!=.
}

tab sum_rvn2013 if rvn2013!=. /*108777 per firm; 2.99e+11 total*/
tab sum_rvn2014 if rvn2012!=. /*102906 per firm; 3.06e+11 total*/
tab sum_rvn2015 if rvn2011!=. /* 97798 per firm; 3.19e+11 total*/


*Average Total Revenues Zombies 2011/2013
local revenues rvn2013 rvn2014 rvn2015
foreach x in `revenues' { 
egen sum_`x'_zombies = sum(`x') if `x'!=. & dummy_2013_2011==1  & drop2013==3 & drop2012==3 & drop2011==3
}

tab sum_rvn2013_zombies /* 389521.33 */
tab sum_rvn2014_zombies /* 454469.23 */
tab sum_rvn2015_zombies /* 577377.12 */

*Average Total Revenues Newly born firm
local revenues  rvn2013 rvn2014 rvn2015 
foreach x in `revenues' { 
egen sum_`x'_start_up = sum(`x') if `x'!=. & yr_b==2013
}

tab sum_rvn2013_start_up /* 414507.77 */
tab sum_rvn2014_start_up /* 1113744.1 */
tab sum_rvn2015_start_up /* 1372388.4 */

*Average Counterfactual Zombie VS Start Up (7371 - 6851 - 6018)
*2013 on all zombies
di  2.99e+11 /*Average Total*/ - ( 389521.33 * 7371) /*Average * Total Zombies*/ + ( 414507.77 * 7371 /*Average number of zombies*/ )
di 2.992e+11/2.99e+11 /* Total Increase by start up 0.06% for the average */ 

*Micro level
di 414507.77/ 389521.33  /* 1.06 times the revenues of a zombie */

*For 2014 on all zombies
di 3.06e+11 /*tot rvn 2014*/ - (454469.23 * 6851) /*tot zomb_rvn2014*/ + (1113744.1 * 6851 /*zombies 2014*/)
di 3.105e+11 / 3.06e+11 /*1.47 % */

*Micro level
di 1113744.1 / 454469.23 /* 2.45 */

*For 2015 on all zombies
di  3.19e+11 - (577377.12 * 6018) + ( 1372388.4 * 6018)
di 3.238e+11/3.193e+11 /* 1.41 % */

*Micro level
di  1372388.4/577377.12 /*2.38*/

*Correct for Resilience (rule out resilient firms)
*2013 /*check pred*/
egen sum_rvn_zombie_resilience_2013 = sum(rvn2013) if pred_2014>.011328 & rvn2013!=. & zombie_2013_2011!="."  & drop2013==3 & drop2012==3 & drop2011==3
tab sum_rvn_zombie_resilience_2013 /*avg 1.97e+09/6366= 309456.49 */
di 2.99e+11 /*total revenues 2013*/ -( 309456.49 * 7371)  + ( 414507.77 * 7371)
di 2.998e+11/2.99e+11 /* + 0.26 % */

*Micro level
di 414507.77 /309456.49 /*1.34*/

*2014
egen sum_rvn_zombie_resilience_2014 = sum(rvn2014) if pred_2014>.011328 & rvn2014!=. & zombie_2013_2011!="."  & drop2014==3 & drop2013==3 & drop2012==3 & drop2011==3
tab sum_rvn_zombie_resilience_2014 /* 1.80e+09 / 5029 = 357924.04 */
di 3.063e+11  - (357924.04  * 6851) +  (1113744.1 * 6851)
di 3.115e+11/ 3.063e+11 /* + 1.69 % */

*Micro level
di 1113744.1 / 357924.04 /* 3.11 */

*2015 
egen sum_rvn_zombie_resilience_2015 = sum(rvn2015) if pred_2015>.023566 & rvn2015!=. & zombie_2013_2011!="."  & drop2014==3 & drop2013==3 & drop2012==3 & drop2011==3
tab sum_rvn_zombie_resilience_2015 /* 1.22e+09/3233 = 377358.49 */
di 3.193e+11 - (377358.49 * 6018) + ( 1372388.4 * 6018)
di 3.253e+11/3.193e+11 /* +1.88% */

*Micro level
di   1372388.4 /377358.49 /* 3.64 */ 

********************************************************************************
*                                 Employees
*Total Employees 
local employees employees2013 employees2014 employees2015
foreach x in `employees' { 
egen sum_`x' = sum(`x') if `x'!=.
}

tab sum_employees2013
tab sum_employees2014
tab sum_employees2015

*Employees in Zombie firms
local employees employees2013 employees2014 employees2015
foreach x in `employees' { 
egen sum_`x'_zombies = sum(`x') if `x'!=. & dummy_2013_2011==1 & drop2013==3 & drop2012==3 & drop2011==3
}

tab sum_employees2013_zombies /*8.85*/
tab sum_employees2014_zombies /*10.23*/
tab sum_employees2015_zombies /*8.25*/

*Employees in Start Ups
local revenues employees2013 employees2014 employees2015
foreach x in `revenues' { 
egen sum_`x'_start_up = sum(`x') if `x'!=. & yr_b==2013 
}

tab sum_employees2013_start_up /*11.36 employees per firm */
tab sum_employees2014_start_up /*11.84 */
tab sum_employees2015_start_up /*11.67*/

*MACROs
*2013
*On all the zombies alive
di 2672384 /*total employees in 2013*/ - (8.85 * 7371) + (11.36 * 7371)
di 2690885.2/2672384 /* 0.69 % */

*2014
*On all the zombies alive
di 2907019 - (10.23 * 6851 /*zombies alive in 2014*/ ) + (11.84 * 6851)
di 2918049.1/2907019 /* 0.38% */

*2015
*On all zombies alive
di 2712283 - (8.25 * 6018 /*zombies alive in 2015*/) + (11.67 * 6018)
di 2732864.6/2712283 /* 0.76% */

*Employees ruling out RESILIENT FIRMS
*2013
egen sum_emp_zombie_resilience_2013 = sum(employees2013) if pred_2014>.011328 & employees2013!=. & zombie_2013_2011!="."  & drop2013==3 & drop2012==3 & drop2011==3
tab sum_emp_zombie_resilience_2013 /*25759/2830 = 9.10 */

*On all zombies alive 2013 (6368 firms)
di 2672384 - (9.10 * 6368) + (11.36 * 6368)
di 2686775.7/2672384 /* 0.54%*/

*2014
count if dummy_2013_2011==1 & pred_2014>.011328 /*6368 firms */
egen sum_emp_zombie_resilience_2014 = sum(employees2014) if pred_2014>.011328 & employees2014!=. & zombie_2013_2011!="."  & drop2013==3 & drop2012==3 & drop2011==3
tab sum_emp_zombie_resilience_2014 /*20337/2342 = 8.63 */

*On zombies alive in 2014
di 2907019 /*total empl 2014*/  - (8.63*6368) + (11.84 * 6368)
di 2927460.3/2907019 /* 0.70% */


*2015
egen sum_emp_zombie_resilience_2015 = sum(employees2015) if pred_2015>.023566 & employees2015!=. & zombie_2013_2011!="."  & drop2014==3 & drop2013==3 & drop2012==3 & drop2011==3
tab sum_emp_zombie_resilience_2015 /*10951/ 1333 = 8.21 */


*On all zombies alive in 2015(5769)
count if dummy_2013_2011==1 & pred_2015>.023566
di 2712283 - (8.21 * 5769) + (11.67 * 5769)
di 2732243.7/ 2712283 /* 0.73% */



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
egen sum_`x'_start_up = sum(`x') if `x'!=. & yr_b==2011  
}

tab sum_added_value2013_start_up /*293370.94*/
tab sum_added_value2014_start_up /*583229.04*/
tab sum_added_value2015_start_up /*498981.67*/

*2013
*On total number of zombies
di 1.56e+11  /*total va2013*/ - ( 19719.251 /*avg zombie*/ * 7371 /*zombies 2013*/) + ( 293370.94 /*avg start up*/ * 7371 /*zomb num*/)
di 1.580e+11/1.56e+11 /* 1.28 % */

*2014
*On total number of zombies alive
di 1.70e+11 - (230356.46 * 6851) + (583229.04 * 6851)
di  1.724e+11/1.70e+11 /*1.41 % */

*2015
*On total number of zombies alive
di 1.74e+11 - (95859.586 * 6018) + ( 498981.67 * 6018)
di 1.764e+11/1.74e+11 /*1.37 % */

*Analysis on NOT RESILIENT firms
*2013  (6368 firms)
egen sum_added_value_nores_2013 = sum(added_value2013) if pred_2014>.011328 & added_value2013!=. & zombie_2013_2011!="."  & drop2013==3 & drop2012==3 & drop2011==3
tab sum_added_value_nores_2013 /*  -87735.416 */
di 1.56e+11  /*total va2013*/ - ( -87735.416 * 6368 ) + (  293370.94 /*avg start up*/ * 6368)
di 1.584e+11/1.56e+11 /* 1.53% */

*2014 
*On zombies alive and no resilient (6368 firms)
egen sum_added_value_nores_2014 = sum(added_value2014) if pred_2014>.011328 & added_value2014!=. & zombie_2013_2011!="."  & drop2013==3 & drop2012==3 & drop2011==3
tab sum_added_value_nores_2014 /* 219762.42 */
di 1.70e+11 - (219762.42 * 6368) + ( 583229.04  * 6368)
di 1.723e+11/1.70e+11 /* 1.35% */


*2015 (5769)
egen sum_added_value_nores_2015 = sum(added_value2015) if pred_2015>.023566 & added_value2015!=. & zombie_2013_2011!="."  & drop2013==3 & drop2012==3 & drop2011==3
tab sum_added_value_nores_2015 /* -188642.93 */
di 1.74e+11 - ( -188642.93  * 5769) + ( 498981.67 * 5769)
di 1.780e+11/1.74e+11 /* 2.30 */
