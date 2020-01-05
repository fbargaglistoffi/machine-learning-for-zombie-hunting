*From TXT to dta
clear all
cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data" /*change path accordingly*/

forval j = 1/19{ 
	import delimited "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data\additional`j'.txt", clear
	rename companyname Company_name 
	rename bvdidnumber BvD_ID_number
	rename ÿþmark Mark
	save additional`j'.dta, replace
}

