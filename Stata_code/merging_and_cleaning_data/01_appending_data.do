**********************
* Appending All Data *
**********************

* Set working directoy
clear all
cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data" /*change path accordingly*/

** Corrupted files 1, 3, 172 were corrected before appending the data

* Append all the dataframes
forval j = 1/201 { 
	append using "orbis_export_`j'.dta"	 
}

*Merging with Additional Data 
forval j = 1/19{ 
	merge m:1 BvD_ID_number using additional`j'.dta, force
	drop if _merge==2 /*dropping merge from using*/
	drop _merge
}

* Destring Data
drop Mark
destring Financial_revenue_* Interest_paid_* Cash_flow_EUR_* EBITDA_EUR_* ///
         Depreciation___Amortization_* Operating_revenue__Turnover__*     ///
		 Total_assets_* Long_term_debt_* Number_of_employees_*            ///
		 Added_value_* Material_costs_* Costs_of_employees_* Loans_*      ///
		 Fixed_assets_* Intangible_fixed_assets_* Taxation_*              ///
		 P_L_for_period___Net_income* Retained_Earnings_* 				  ///
		 Enterprise_Value_* Current_liabilities_* Liquidity_ratio_*       ///
		 Solvency_ratio__Asset_based* Current_assets_* Number_of_patents  ///
		 Number_of_trademarks, replace force ignore(",")
replace BvD_ID_number= BvD_ID_number[_n-1] if BvD_ID_number==""

foreach v of var `r(varlist)' { 
	replace `v' = subinstr(`v', ",", ".", .)
	replace `v' = subinstr(`v', ".", "", .)
	replace `v'="." if `v'==""
	destring `v', replace force
}

* Sort data
sort BvD_ID_number

* Save data
save file_intermedio.dta, replace
