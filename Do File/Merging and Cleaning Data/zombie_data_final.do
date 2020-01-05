*Appending all data
clear all
cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data" /*change path accordingly*/
use orbis_export_2.dta, clear

*First append all the good dataframes
forval j = 4/171 { 
	append using "orbis_export_`j'.dta"	 
}

forval j = 173/201 { 
	append using "orbis_export_`j'.dta"
}

*Then append the three dataframes that were corrupted using "force"
foreach j in 1 3 172{ 
	append using "orbis_export_`j'.dta", force	 
}


*Merging with Additional
forval j = 1/19{ 
	merge m:1 BvD_ID_number using additional`j'.dta, force
	drop if _merge==2 /*dropping merge from using*/
	drop _merge
}

*Destringing Variables
ds GUO___BvD_ID_number Mark Company_name BvD_ID_number Country_ISO_Code NUTS2 NUTS3 Region_in_country City Cons__code Date_of_incorporation Status NACE_Rev__2_Core_code__4_digits_ Status_date NAICS_2017_Primary_code_s_, not 

foreach v of var `r(varlist)' { 
	replace `v' = subinstr(`v', ",", ".", .)
	replace `v' = subinstr(`v', ".", "", .)
	replace `v'="." if `v'==""
	destring `v', replace force
}

save data_zombie_complete.dta, replace
