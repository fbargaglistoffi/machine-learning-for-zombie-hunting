********************************************************************************
*                         Generate failure and time variables                  *
********************************************************************************

* Generate failure variable
gen failure=0
replace failure=1 if Status=="Dissolved (bankruptcy)"  | Status=="Dissolved (demerger)" | Status=="Dissolved" | Status=="Dissolved (liquidation)" | Status=="Dissolved (merger or take-over)" | Status=="Bankruptcy" | Status=="In liquidation"
replace failure=. if Status=="Inactive (no precision)" | Status=="Unknown situation" 

* Drop observations without failure date if failed
drop if failure==1 & Status_date=="" /* 5,846 obs dropped */

* Generate year of failure variable
gen year_of_status=substr(Status_date, -4,4)
destring year_of_status, replace force /* possible attrition bias in failures */

* Generate year of incorporation variable
gen year_of_incorporation=substr(Date_of_incorporation, -4,4)

* Some dates are not coded properly so we use the following code to get the correct years
gen year_of_problems=substr(Date_of_incorporation, -2,4) if year_of_i>"2018"
replace year_of_problem="19"+year_of_problem if year_of_problem>"18"
replace year_of_problem="20"+year_of_problem if year_of_problem<="18"
replace year_of_problem="" if year_of_problem=="20"
replace year_of_incorporation=year_of_problem if year_of_i>"2018"
drop year_of_problem
destring year_of_incorporation, replace

* Table variables
tab year_of_status
tab year_of_incorporation

* Check for possible issues in the data
count if year_of_incorporation==. 
drop if year_of_incorporation==. /* 77 with no year of incorporation*/
count if  year_of_status < year_of_incorporation /* 618 observtions where the failure date is after the year of status */
tab Status if  year_of_status < year_of_incorporation /* most of these are active firms, so year of status is not failure year */
drop if  year_of_status < year_of_incorporation & Status!="Active" /* 2 obs deleted */

* Generate missing failure year for observations that didn't fail
replace year_of_status=2018 if  year_of_status < year_of_incorporation & year_of_incorporation!=. & Status=="Active"
replace year_of_status=. if failure==0   /*Possible bias in the data: status date instead of date of incorporation */

* Table variables
tab year_of_status
tab year_of_incorporation

* Generate firms age
gen age=.
replace age= 2018 -  year_of_incorporation if year_of_status==.
replace age=year_of_status - year_of_incorporation if year_of_status!=.

* For some observations we have financial account data even after failure (i.e., liquidated firms)
forval j = 2008/2016 { 
    count if total_assets_`j'!=. & year_of_status<`j' /* what to do with these obs? */
	tab Status if total_assets_`j'!=. & year_of_status<`j' 
	*tab iso if total_assets_`j'!=. & year_of_status<`j' 
	*drop if Status!="In liquidation" & total_assets_`j'!=. & year_of_status<`j'
	/* keeping liquidated firms */
}

* Generate censorship date (2018)
replace year_of_status=2018 if failure==0 /* censorship date */

* Drop if no status year
count if year_of_status==.
tab Status if year_of_status==. /* no status for firms recorded as "Inactive (no precision)" */
tab iso if Status=="Inactive (no precision)" /* inactive firms are mostly in italy */
drop if Status=="Inactive (no precision)"

* Drop observations with status year before 2009
drop if year_of_status<2009

* Table failure
tab failure

/* 
    failure |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    479,817       94.44       94.44
          1 |     28,226        5.56      100.00
------------+-----------------------------------
      Total |    508,043      100.00

*/

********************************************************************************
*                                  STSET data                                  *  
********************************************************************************

* Run this chunk of code to generate STSET data

* Generate STSET data
stset year_of_status, origin(year_of_incorporation) failure(failure)

* Generate time variable
gen time=.
replace time=_t
