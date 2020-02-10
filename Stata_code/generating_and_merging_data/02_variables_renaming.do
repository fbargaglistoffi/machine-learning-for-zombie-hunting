*****************
* Renaming Data *
*****************

*Set working directory
clear all
cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data" /*change path accordingly*/

* Upload data
use file_intermedio.dta, clear

* Drop company name (to decrease the size of data)
*drop Company_name

* Rename variables
ren BvD_ID_number id
ren GUO___BvD_ID_number guo
ren Country_ISO_Code iso
ren NUTS2 nuts2 
ren NUTS3 nuts3
ren Region_in_country region
ren City city
ren Cons__code conscode

ren NAICS naics
ren NACE_Rev__2_Core_code__4_digits_ nace
ren Shareholders_funds_EUR_* shareholders_funds_*
ren Retained_Earnings_EUR_* retained_earnings_*
ren Added_value_EUR_* added_value_*
ren Cash_flow_EUR_* cash_flow_* 
ren EBITDA_EUR_* ebitda_*
ren Financial_revenue_EUR_* fin_rev_*
ren Liquidity_ratio_* liquidity_ratio_*
ren Total_assets_EUR_* total_assets_*
ren Depreciation___Amortization_* depr*
ren Operating_revenue__Turnover__EU* revenue*
ren Long_term_debt_EUR_* long_term_debt_*
ren Number_of_employees_* employees_*
ren Enterprise_Value_EUR_* firm_value_*
ren Material_costs_EUR_* materials_*
ren Costs_of_employees_EUR_* wage_bill_*
ren Loans_EUR_* loans_*
ren Fixed_assets_EUR_* fixed_assets_* 
ren Intangible_fixed_assets_EUR_* int_fixed_assets_*
ren Taxation_EUR_* tax_* 
ren Current_liabilities_EUR_* current_liabilities_*
ren Current_assets_EUR_* current_assets_*
ren Financial_expenses_EUR_* fin_expenses_*
ren Interest_paid_EUR_* int_paid_*
ren Solvency_ratio__Asset_based____2 solvency_ratio_2016
ren Solvency_ratio__Asset_based____0 solvency_ratio_2015
ren Solvency_ratio__Asset_based____1 solvency_ratio_2014
ren Solvency_ratio__Asset_based____3 solvency_ratio_2013
ren Solvency_ratio__Asset_based____4 solvency_ratio_2012
ren Solvency_ratio__Asset_based____5 solvency_ratio_2011
ren Solvency_ratio__Asset_based____6 solvency_ratio_2010
ren Solvency_ratio__Asset_based____7 solvency_ratio_2009
ren Solvency_ratio__Asset_based____8 solvency_ratio_2008
ren P_L_for_period___Net_income__EUR  net_income_2016
ren P_L_for_period___Net_income__EU0 net_income_2015
ren P_L_for_period___Net_income__EU1 net_income_2014
ren P_L_for_period___Net_income__EU2 net_income_2013
ren P_L_for_period___Net_income__EU3 net_income_2012
ren P_L_for_period___Net_income__EU4 net_income_2011
ren P_L_for_period___Net_income__EU5 net_income_2010
ren P_L_for_period___Net_income__EU6 net_income_2009
ren P_L_for_period___Net_income__EU7 net_income_2008
ren deprEUR_ depr2016
ren deprEUR0 depr2015
ren deprEUR1 depr2014
ren deprEUR2 depr2013
ren deprEUR3 depr2012
ren deprEUR4 depr2011
ren deprEUR5 depr2010
ren deprEUR6 depr2009
ren deprEUR7 depr2008
ren revenueR revenue2016
ren revenue0 revenue2015 
ren revenue1 revenue2014
ren revenue2 revenue2013
ren revenue3 revenue2012
ren revenue4 revenue2011
ren revenue5 revenue2010
ren revenue6 revenue2009
ren revenue7 revenue2008

* Drop Poland and UK (scarce representativeness)
drop if iso=="GB" | iso=="PL" | iso=="DE" | iso=="RO" | iso=="SE"
count if id==""

* Dropping if date of incorporation is the same of status date
drop if Status_date==Date_of_incorporation & Status!="Active"

* Dropping duplicates 
sort id
quietly by id: gen dup = cond(_N==1,0,_n) 
/*the information in the second duplicates are redundant */
drop if dup==2 
drop dup

save analysis_data.dta, replace
