*Appending all data
clear all


*cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data" /*change path accordingly*/

cd "C:\Users\a.rungi\Dropbox\Tesi PhD\Bargagli Stoffi\Data for machine learning zombie"

use orbis_export_2.dta, clear

*First append all the good dataframes
forval j = 4/171 { 
	append using "orbis_export_`j'.dta"	 
}

forval j = 173/201 { 
	append using "orbis_export_`j'.dta"
}



*** corrupted files 1, 3, 172 were appended manually by copy and paste from excel

drop Mark
destring Financial_revenue_* Interest_paid_* Cash_flow_EUR_* EBITDA_EUR_* Depreciation___Amortization_* Operating_revenue__Turnover__* Total_assets_* Long_term_debt_* Number_of_employees_* Added_value_* Material_costs_* Costs_of_employees_* Loans_* Fixed_assets_* Intangible_fixed_assets_* Taxation_* P_L_for_period___Net_income* Retained_Earnings_* Enterprise_Value_* Current_liabilities_* Liquidity_ratio_* Solvency_ratio__Asset_based* Current_assets_* Number_of_patents Number_of_trademarks, replace force ignore(",")

replace BvD_ID_number= BvD_ID_number[_n-1] if BvD_ID_number==""

save data_zombie_complete1.dta, replace

sort BvD_ID_number

merge m:1 BvD_ID_number using "additional.dta", force
drop if _merge==2 
drop _merge
	

save data_zombie_complete.dta, replace
