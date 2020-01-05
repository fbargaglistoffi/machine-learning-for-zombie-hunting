*Cleaning

clear all
cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data" /*change path accordingly*/

use data_clean_2505.dta, clear

/*Claning if Date of incorporation is the same of status date*/
count if Status_date==Date_of_incorporation /*58,898 obs anno stesso anno nascita e fallimento*/
tab Status if Status_date==Date_of_incorporation /*  58,752 sono ancora attive */
tab age  if Status_date==Date_of_incorporation /* bias in age */
tab iso if Status_date==Date_of_incorporation /*the bias is mainly spanish */
tab Status if Status_date==Date_of_incorporation & iso=="ES" /* spanish firms are 87,786*/
tab Status if Status_date!=Date_of_incorporation & iso=="ES"
 
drop if Status_date==Date_of_incorporation & Status!="Active"
 
replace age=. if Status_date==Date_of_incorporation
replace Date_of_incorporation="" if Status_date==Date_of_incorporation
 
/* Work with duplicates */
sort id
quietly by id: gen dup = cond(_N==1,0,_n) /*no duplicates*/
tab dup
 
 
edit if dup==5
edit if dup==4 
edit if dup==1

tab newstatus if dup==1

count if dup==2 & Status[_n]==Status[_n - 1]
count if dup==2 & Status_date[_n]==Status_date[_n - 1] 
count if dup==2 & fin_rev_2014[_n]==fin_rev_2014[_n - 1]
/*the information in the second duplicates are redundant */
count if dup==3 & Status[_n]==Status[_n - 1] & Status[_n]==Status[_n - 2]
count if dup==3 & Status_date[_n]==Status_date[_n - 1] & Status_date[_n]==Status_date[_n - 2]
count if dup==3 & fin_rev_2014[_n]==fin_rev_2014[_n - 1] & fin_rev_2014[_n]==fin_rev_2014[_n - 2]
/*the information in the second duplicates are redundant */
drop if dup==2
drop if dup==2 | dup==3 | dup==4 | dup==5

save data_clean_2805


