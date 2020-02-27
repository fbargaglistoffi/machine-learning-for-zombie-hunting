********************************************************************************
*                                fixed assets
*Total Employees 
local fa fixedassets2013 fixedassets2014 fixedassets2015
foreach x in `fa' { 
egen sum_`x' = sum(`x') if `x'!=.
}

tab sum_fixedassets2013
tab sum_fixedassets2014
tab sum_fixedassets2015

*Employees in Zombie firms
local fa fixedassets2013 fixedassets2014 fixedassets2015
foreach x in `fa' { 
egen sum_`x'_zombies = sum(`x') if `x'!=. & dummy_2013_2011==1 & drop2013==3 & drop2012==3 & drop2011==3
}

tab sum_fixedassets2013_zombies /* 517430.69 */
tab sum_fixedassets2014_zombies /* 551920.82 */
tab sum_fixedassets2015_zombies /* 562554.3  */
/*avg 543968 */

*Employees in Start Ups
local fa fixedassets2013 fixedassets2014 fixedassets2015
foreach x in `fa' { 
egen sum_`x'_start_up = sum(`x') if `x'!=. & yr_b==2013 
}

tab sum_fixedassets2013_start_up /* 831432.72 */
tab sum_fixedassets2014_start_up /* 871944.55 */
tab sum_fixedassets2015_start_up /* 467038.64 */
/*723471 */

*How many new firms would I create investing the "capital" of zombies
di 543968 * 6747
/* 3.670e+09 avg total sunk capital */
di 3.670e+09/723471
/* 5073 number of new firms */



*MACROs on avg number of zombies 6747
*2013
*On all the zombies alive
di 2672384 /*total employees in 2013*/ - (8.85 * 6747) + (11.36 * 5073)
di 2670302.3/2672384 /* 0 % */ 

*2014 ( 
*On all the zombies alive
di 2907019 - (10.23 * 6747 /*zombies alive in 2014*/ ) + (11.84 * 5073)
di 2898061.5/2907019 /* -0.3% */

*2015
*On all zombies alive
di 2898061.5 - (8.25 * 6747 /*zombies alive in 2015*/) + (11.67 * 5073)
di 2901600.7/2898061.5 /* +0.1% */

*Employees ruling out RESILIENT FIRMS
*2013
egen sum_emp_zombie_resilience_2013 = sum(employees2013) if pred_2014>.011328 & employees2013!=. & zombie_2013_2011!="."  & drop2013==3 & drop2012==3 & drop2011==3
tab sum_emp_zombie_resilience_2013 /*25759/2830 = 9.10 */

*On all zombies alive 2013 (6368 firms)
di 2672384 - (9.10 * 6747) + (11.36 * 5073)
di 2666543.5/2672384 /* -0.2%*/

*2014
count if dummy_2013_2011==1 & pred_2014>.011328 /*6368 firms */
egen sum_emp_zombie_resilience_2014 = sum(employees2014) if pred_2014>.011328 & employees2014!=. & zombie_2013_2011!="."  & drop2013==3 & drop2012==3 & drop2011==3
tab sum_emp_zombie_resilience_2014 /*20337/2342 = 8.63 */

*On zombies alive in 2014
di 2907019 /*total empl 2014*/  - (8.63*6747) + (11.84 * 5073)
di 2906373.2/2907019 /* 0.0% */


*2015
egen sum_emp_zombie_resilience_2015 = sum(employees2015) if pred_2015>.023566 & employees2015!=. & zombie_2013_2011!="."  & drop2014==3 & drop2013==3 & drop2012==3 & drop2011==3
tab sum_emp_zombie_resilience_2015 /*10951/ 1333 = 8.21 */


*On all zombies alive in 2015(5769)
count if dummy_2013_2011==1 & pred_2015>.023566
di 2712283 - (8.21 * 6747) + (11.67 * 5073)
di 2718449.8/ 2712283 /* +0.22% */

*2013
*On total number of zombies
di 1.56e+11  /*total va2013*/ - ( 19719.251 /*avg zombie*/ * 6747 /*zombies 2013*/) + ( 293370.94 /*avg start up*/ * 5073 /*zomb num*/)
di 1.574e+11/1.56e+11 /* +0.90 % */

*2014
*On total number of zombies alive
di 1.70e+11 - (230356.46 * 6747) + (583229.04 * 5073)
di  1.714e+11/1.70e+11 /* + 0.82 % */

*2015
*On total number of zombies alive
di 1.74e+11 - (95859.586 * 6747) + ( 498981.67 * 5073)
di 1.759e+11/1.74e+11 /* + 1.09 % */


