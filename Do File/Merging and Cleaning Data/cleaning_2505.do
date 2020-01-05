*Cleaning

clear all
cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data" /*change path accordingly*/

use data_zombie_complete.dta, clear

*keep BvD_ID_number Company_name

*save names_data_zombie_complete

*keep Date_of_incorporation Status_date BvD_ID_number Status

*save status_data_zombie_complete

drop Company_name

count if iso!=""
drop if iso==""

rename BvD_ID_number id
rename Country_ISO_Code iso
rename NUTS2 nuts2 
rename NUTS3 nuts3
rename Region_in_country region
rename City city
rename Cons__code conscode /*bilanci consolidati*/

gen consdummy=0
replace consdummy=1 if conscode=="C1" | conscode=="C2" /*7953 consolidate*/

save file_intermedio

use status_data_zombie_complete.dta, clear

/*se non abbiamo la data di status non è possibile calcolare l'età */

gen year_of_status=substr(Status_date, -4,4) /*31 obs hanno problemi con la variabile ma sono tutte attive, quindi procediamo */
destring year_of_status, replace force /*possibile attrition bias nei fallimenti */
*edit if year_of_i>"2018"

gen year_of_incorporation=substr(Date_of_incorporation, -4,4)

gen year_of_problems=substr(Date_of_incorporation, -2,4) if year_of_i>"2018"
replace year_of_problem="19"+year_of_problem if year_of_problem>"18"
replace year_of_problem="20"+year_of_problem if year_of_problem<="18"
replace year_of_problem="" if year_of_problem=="20"
tab year_of_problem

replace year_of_incorporation=year_of_problem if year_of_i>"2018"
drop year_of_problem
tab year_of_i

destring year_of_incorporation, replace
destring year_of_status, replace

gen age=.
replace age=2018 -  year_of_incorporation if year_of_status==.
replace age=year_of_status - year_of_incorporation if year_of_status!=.


bysort BvD_ID: egen minage=min(age) 
gen statusdummy=1 if minage==age

keep if statusdummy==1
rename Status newstatus
keep age newstatus BvD_ID_number
rename BvD_ID_number id
sort id
save age_status, replace

use file_intermedio.dta, replace
sort id
merge id using age_status
tab _merge
drop _merge
drop Status
drop Status_data

rename NAICS naics
rename NACE_Rev__2_Core_code__4_digits_ nace
ren Shareholders_funds_EUR_* shareholders_funds_*
ren Retained_Earnings_EUR_* retained_earnings_*
ren Added_value_EUR_* added_value_*
ren Shareholders_funds_EUR_* shareholders_funds_*
ren Retained_Earnings_EUR_* retained_earnings_*

*Errori di misurazione

ren Liquidity_ratio_* liquidity_ratio_*
forval v = 2008/2016{
	replace liquidity_ratio_`v'=. if liquidity_ratio_`v'<0
}

ren Solvency_ratio__Asset_based____2 solvency_ratio_2016
ren Solvency_ratio__Asset_based____0 solvency_ratio_2015
ren Solvency_ratio__Asset_based____1 solvency_ratio_2014
ren Solvency_ratio__Asset_based____3 solvency_ratio_2013
ren Solvency_ratio__Asset_based____4 solvency_ratio_2012
ren Solvency_ratio__Asset_based____5 solvency_ratio_2011
ren Solvency_ratio__Asset_based____6 solvency_ratio_2010
ren Solvency_ratio__Asset_based____7 solvency_ratio_2009
ren Solvency_ratio__Asset_based____8 solvency_ratio_2008

forval v = 2008/2016{
	replace solvency_ratio_`v'=. if solvency_ratio_`v'<0
}

rename Financial_revenue_EUR_* fin_rev_*
sum fin_rev_*, d
tabstat fin_rev_2008 if fin_rev_2008<0, by(newstatus)
count if fin_rev_2008<0

forval v = 2008/2016{
	replace fin_rev_`v'=. if fin_rev_`v'<0
}

rename Interest_paid_EUR_* int_paid_*
forval v = 2008/2016 {
	count if int_paid_`v'<0
}

forval v = 2008/2016 {
	replace int_paid_`v'=. if int_paid_`v'<0
}

rename Cash_flow_EUR_* cash_flow_* /* ok, può essere negativo */
forval v = 2008/2016 {
	count if cash_flow_`v'<0
}

tabstat cash_flow_2016 if cash_flow_2016<0, by(newstatus) statistics(mean N)
tabstat cash_flow_2016 if cash_flow_2016<0, by(iso) statistics(mean N)

rename EBITDA_EUR_* ebitda_* /*can be negative*/
forval v = 2008/2016 {
	count if ebitda_`v'<0
}

rename Depreciation___Amortization_* depr*
rename deprEUR_ depr2016
rename deprEUR0 depr2015
rename deprEUR1 depr2014
rename deprEUR2 depr2013
rename deprEUR3 depr2012
rename deprEUR4 depr2011
rename deprEUR5 depr2010
rename deprEUR6 depr2009
rename deprEUR7 depr2008

forval v = 2008/2016 {
	count if depr`v'<0
}
forval v = 2008/2016 {
	replace depr`v'=. if depr`v'<0
}

ren Operating_revenue__Turnover__EU* revenue*
ren revenue revenue2016
ren revenue0 revenue2015 
ren revenue1 revenue2014
ren revenue2 revenue2013
ren revenue3 revenue2012
ren revenue4 revenue2011
ren revenue5 revenue2010
ren revenue6 revenue2009
ren revenue7 revenue2008

forval v = 2008/2016 {
	count if revenue`v'<0
}

forval v = 2008/2016 {
	replace revenue`v'=. if revenue`v'<0
}

ren Total_assets_EUR_* total_assets_*

forval v = 2008/2016 {
	count if total_assets_`v'<0
}
forval v = 2008/2016 {
	replace total_assets_`v'=. if total_assets_`v'<0
}

ren Long_term_debt_EUR_* long_term_debt_*

forval v = 2008/2016 {
	count if long_term_debt_`v'<0
}
forval v = 2008/2016 {
	replace long_term_debt_`v'=. if tlong_term_debt_`v'<0
}
ren Number_of_employees_* employees_*

forval v = 2008/2016 {
	count if employees_`v'<0
}

ren Enterprise_Value_EUR_* firm_value_*
forval v = 2008/2016{
	replace firm_value_`v'=. if firm_value_`v'<0
}
forval v = 2008/2016 {
	replace firm_value_`v'=. if firm_value_`v'<0
}


ren Material_costs_EUR_* materials_*

forval v = 2008/2016 {
	count if materials_`v'<0
}
forval v = 2008/2016 {
	replace materials_`v'=. if materials_`v'<0
}

ren Costs_of_employees_EUR_* wage_bill_*

forval v = 2008/2016 {
	count if wage_bill_`v'<0
}
forval v = 2008/2016 {
	replace wage_bill_`v'=. if wage_bill_`v'<0
}

ren Loans_EUR_* loans_*

forval v = 2008/2016 {
	count if loans_`v'<0
}
forval v = 2008/2016 {
	replace loans_`v'=. if loans_`v'<0
}

ren Fixed_assets_EUR_* fixed_assets_* 

forval v = 2008/2016 {
	count if fixed_assets_`v'<0
}
forval v = 2008/2016 {
	replace fixed_assets_`v'=. if fixed_assets_`v'<0
}

ren Intangible_fixed_assets_EUR_* int_fixed_assets_*

forval v = 2008/2016 {
	count if int_fixed_assets_`v'<0
}
forval v = 2008/2016 {
	replace int_fixed_assets_`v'=. if int_fixed_assets_`v'<0
}

ren Taxation_EUR_* tax_* /*many negative values*/

forval v = 2008/2016 {
	count if tax_`v'<0
}
*forval v = 2008/2016 {
*	replace tax_`v'=. if tax_`v'<0
*}

ren Current_liabilities_EUR_* current_liabilities_*

forval v = 2008/2016 {
	count if current_liabilities_`v'<0
}
forval v = 2008/2016 {
	replace current_liabilities_`v'=. if current_liabilities_`v'<0
}

ren Current_assets_EUR_* current_assets_*

forval v = 2008/2016 {
	count if current_assets_`v'<0
}
forval v = 2008/2016 {
	replace current_assets_`v'=. if current_assets_`v'<0
}

count if Number_of_patents<0
count if Number_of_trademarks<0 

ren Financial_expenses_EUR_* fin_expenses_*

forval v = 2008/2016 {
	count if fin_expenses_`v'<0
}
forval v = 2008/2016 {
	replace fin_expenses_`v'=. if fin_expenses_`v'<0
}

rename GUO___BvD_ID_number guo

gen guo_iso = substr(guo, 1,2)

gen control=""
replace control="dom ind" if guo==""
replace control="dom subs" if iso==guo_iso
replace control="for subs" if iso!=guo_iso & guo_iso!=""

tab guo_iso if iso=="IT"

save data_clean_2505
