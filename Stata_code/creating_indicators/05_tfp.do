********************************************************************************
*                             TFP GENERATION
********************************************************************************

* Generate NACE 2 digits variable
gen nace_2=.
destring nace, replace
replace nace_2= nace/100
replace nace_2=floor(nace_2)

/* N.B. In the italian data many imputed values of revenues (all the same) */
count if revenue2016==revenue2015 & revenue2016!=.
tab iso if revenue2016==revenue2015 & revenue2016!=.
tab iso if revenue2015==revenue2014 & revenue2015!=.

*Generate LOG for TFP 2015/2008
forval j = 2008/2016 { 
     gen ln_fa_`j' =  ln(fixed_assets_`j' + 1) if fixed_assets_`j'!=. 
}

forval j = 2008/2016 { /*negative values? */
     gen ln_av_`j' =  ln(added_value_`j') if added_value_`j'!=. 
}

forval j = 2008/2016 { 
     gen ln_mat_`j' =  ln(materials_`j' + 1) if materials_`j'!=. 
}

forval j = 2008/2016 { 
     gen ln_emp_`j' =  ln(employees_`j' + 1) if employees_`j'!=. 
}

forval j = 2008/2016 { 
     gen ln_inv_`j' =  ln(inv_`j' + 1) if inv_`j'!=. 
}

forval j = 2008/2016 { 
     gen ln_rev_`j' =  ln(revenue`j' + 1) if revenue`j'!=. 
}

********************************************************************************
*TFP ESTIMATION for MANUFACTURING FIRMS (NAICS 2 DIGIT)
*Estimation of TFP LEVPET for each Nace in logs, and store estimates in latex table

preserve
keep id nace_2 ln_rev_2008 ln_rev_2009 ln_rev_2010 ln_rev_2011 ln_rev_2012 ln_rev_2013 ln_rev_2014 ln_rev_2015 ln_rev_2016 ln_fa_2016 ln_fa_2008 ln_fa_2009 ln_fa_2010 ln_fa_2011 ln_fa_2012 ln_fa_2014 ln_fa_2013 ln_fa_2015 ln_av_2016 ln_av_2008 ln_av_2009 ln_av_2010 ln_av_2011 ln_av_2012 ln_av_2013 ln_av_2014 ln_av_2015 ln_mat_2016 ln_mat_2008 ln_mat_2009 ln_mat_2010 ln_mat_2011 ln_mat_2012 ln_mat_2013 ln_mat_2014 ln_mat_2015 ln_emp_2016 ln_emp_2008 ln_emp_2009 ln_emp_2010 ln_emp_2011 ln_emp_2012 ln_emp_2013 ln_emp_2014 ln_emp_2015 ln_inv_2016 ln_inv_2008 ln_inv_2009 ln_inv_2010 ln_inv_2011 ln_inv_2012 ln_inv_2013 ln_inv_2014 ln_inv_2015

*forval i = 2008/2015 {
*         keep ln_fa_`i' ln_av_`i' ln_mat_`i' ln_emp_`i' ln_inv_`i' 
*}

reshape long ln_rev_ ln_fa_ ln_av_ ln_mat_ ln_emp_ ln_inv_ , i(id) j(year)
egen id_tfp=group(id)
save tfp_data, replace

forvalues i = 10(1)33{
		levpet ln_rev_ if nace_2==`i', free(ln_emp_) proxy(ln_mat_) capital(ln_fa_) i(id_tfp) t(year) revenue
		*levpet ln_av_ /*revenues */ if nace_2==`i', free(ln_emp_) proxy(ln_mat_) capital(ln_fa_) i(id_tfp) t(year) valueadded /*scrivi revenues */
		estimates store tp_`i'
		predict tfp_lp_`i' if nace_2==`i' & e(sample), omega
}
estimates table tp_10 tp_11 tp_12 tp_13 tp_14 tp_15 tp_16 tp_17 tp_18 tp_19 tp_20 tp_21 tp_22 tp_23 tp_24 tp_25 tp_26 tp_27 tp_28 tp_29 tp_30 tp_31 tp_32 tp_33
outreg2[tp_10 tp_11 tp_12 tp_13 tp_14 tp_15 tp_16 tp_17 tp_18 tp_19 tp_20 tp_21 tp_22 tp_23 tp_24 tp_25 tp_26 tp_27 tp_28 tp_29 tp_30 tp_31 tp_32 tp_33] using tfp_estimates_10_07_2018.tex, replace
 
* "predict" in Levpet predicts for all observations the TFP- not Nace specific --- drop all tfp estimates for not-equal Nace
save tfp_data,replace
keep tfp_lp_10 tfp_lp_11 tfp_lp_12 tfp_lp_13 tfp_lp_14 tfp_lp_15 tfp_lp_16 tfp_lp_17 tfp_lp_18 tfp_lp_19 tfp_lp_20 tfp_lp_21 tfp_lp_22 tfp_lp_23 tfp_lp_24 tfp_lp_25 tfp_lp_26 tfp_lp_27 tfp_lp_28 tfp_lp_29 tfp_lp_30 tfp_lp_31 tfp_lp_32 tfp_lp_33 id nace_2 year

forvalues i = 10(1)33{
		replace tfp_lp_`i'=. if nace_2!=`i'
}

reshape wide tfp_lp_10 tfp_lp_11 tfp_lp_12 tfp_lp_13 tfp_lp_14 tfp_lp_15 tfp_lp_16 tfp_lp_17 tfp_lp_18 tfp_lp_19 tfp_lp_20 tfp_lp_21 tfp_lp_22 tfp_lp_23 tfp_lp_24 tfp_lp_25 tfp_lp_26 tfp_lp_27 tfp_lp_28 tfp_lp_29 tfp_lp_30 tfp_lp_31 tfp_lp_32 tfp_lp_33, i(id) j(year)
save tfp_data_lev_pet, replace
restore

merge 1:1 id using tfp_data_lev_pet
drop _merge

*TFP L Lagged Values
forvalues i = 10(1)33{
		gen tfp_lp_`i'=. 
		replace tfp_lp_`i'=tfp_lp_`i'2016 if  year_of_status==2017 | year_of_status==2018
}

forval j = 2008/2015 {
	forval i =10(1)33{
		replace tfp_lp_`i'=tfp_lp_`i'`j' if  year_of_status==`j'+1
	}
}

egen tfp_lp = rowtotal(tfp_lp_10 - tfp_lp_33)
count if tfp_lp == 0
count if tfp_lp ==0 & (tfp_lp_10 - tfp_lp_33)==.
replace tfp_lp = . if tfp_lp==0

********************************************************************************
*                                TFP ACF
********************************************************************************
preserve
keep id nace_2 ln_rev_2008 ln_rev_2009 ln_rev_2010 ln_rev_2011 ln_rev_2012 ln_rev_2013 ln_rev_2014 ln_rev_2015 ln_rev_2016 ln_fa_2016 ln_fa_2008 ln_fa_2009 ln_fa_2010 ln_fa_2011 ln_fa_2012 ln_fa_2014 ln_fa_2013 ln_fa_2015 ln_av_2016 ln_av_2008 ln_av_2009 ln_av_2010 ln_av_2011 ln_av_2012 ln_av_2013 ln_av_2014 ln_av_2015 ln_mat_2016 ln_mat_2008 ln_mat_2009 ln_mat_2010 ln_mat_2011 ln_mat_2012 ln_mat_2013 ln_mat_2014 ln_mat_2015 ln_emp_2016 ln_emp_2008 ln_emp_2009 ln_emp_2010 ln_emp_2011 ln_emp_2012 ln_emp_2013 ln_emp_2014 ln_emp_2015 ln_inv_2016 ln_inv_2008 ln_inv_2009 ln_inv_2010 ln_inv_2011 ln_inv_2012 ln_inv_2013 ln_inv_2014 ln_inv_2015

reshape long ln_fa_ ln_av_ ln_mat_ ln_emp_ ln_inv_ , i(id) j(year)
egen id_tfp=group(id)

forvalues i = 10(1)33{
	*prodest ln_rev_ /*revenues */ if nace_2==`i', free(ln_emp_) state(ln_fa_) proxy(ln_inv_) /*va*/ /*met(op)*/ acf /*opt(nm)*/ reps(10) id(id_tfp) t(year)
	*prodest ln_av_ /*revenues */ if nace_2==`i', free(ln_emp_) state(ln_fa_) proxy(ln_inv_) /*va*/ /*met(op)*/ acf /*opt(nm)*/ reps(10) id(id_tfp) t(year)
	acfest ln_rev_ if nace_2==`i', free(ln_emp_) proxy(ln_mat_) state(ln_fa_)  i(id_tfp) t(year) intmat(ln_mat_) robust
	estimates store acf_`i'
	predict tfp_acf_`i' if nace_2==`i' /*, omega */
}


*estimates table acf_10 acf_11 acf_12 acf_13 acf_14 acf_15 acf_16 acf_17 acf_18 acf_19 acf_20 acf_21 acf_22 acf_23 acf_24 acf_25 acf_26 acf_27 acf_28 acf_29 acf_30 acf_31 acf_32 acf_33
*outreg2[acf_10 acf_11 acf_12 acf_13 acf_14 acf_15 acf_16 acf_17 acf_18 acf_19 acf_20 acf_21 acf_22 acf_23 acf_24 acf_25 acf_26 acf_27 acf_28 acf_29 acf_30 acf_31 acf_32 acf_33] using tfp_estimates_20_06_2018.tex, replace

keep tfp_acf_10 tfp_acf_11 tfp_acf_12 tfp_acf_13 tfp_acf_14 tfp_acf_15 tfp_acf_16 tfp_acf_17 tfp_acf_18 tfp_acf_19 tfp_acf_20 tfp_acf_21 tfp_acf_22 tfp_acf_23 tfp_acf_24 tfp_acf_25 tfp_acf_26 tfp_acf_27 tfp_acf_28 tfp_acf_29 tfp_acf_30 tfp_acf_31  tfp_acf_32 tfp_acf_33 id nace_2 year

forvalues i = 10(1)33{
		replace tfp_acf_`i'=. if nace_2!=`i'
}

reshape wide tfp_acf_10 tfp_acf_11 tfp_acf_12 tfp_acf_13 tfp_acf_14 tfp_acf_15 tfp_acf_16 tfp_acf_17 tfp_acf_18 tfp_acf_19 tfp_acf_20 tfp_acf_21 tfp_acf_22 tfp_acf_23 tfp_acf_24 tfp_acf_25 tfp_acf_26 tfp_acf_27 tfp_acf_28 tfp_acf_29 tfp_acf_30 tfp_acf_31  tfp_acf_32 tfp_acf_33, i(id) j(year)
save tfp_data_acf, replace
restore

merge 1:1 id using tfp_data_acf
drop _merge

*TFP ACF Lagged Values

forvalues i = 10(1)33{
		gen tfp_acf_`i'=. 
		replace tfp_acf_`i'=tfp_acf_`i'2016 if  year_of_status==2017 | year_of_status==2018
}


forval j = 2008/2015 {
	forval i =10(1)33{
		replace tfp_acf_`i'=tfp_acf_`i'`j' if  year_of_status==`j'+1
	}
}

egen tfp_acf = rowtotal(tfp_acf_10 - tfp_acf_33)
count if tfp_acf == 0
count if tfp_acf ==0 & (tfp_acf_10 - tfp_acf_33)==.
replace tfp_acf = . if tfp_acf==0 /*& tfp_acf_31!=0 & tfp_acf_32!=0 & tfp_acf_33!=0 */

kdensity tfp_acf

preserve 
keep id iso tfp_acf tfp_lp region city conscode Date_of_incorporation Status Status_date naics nace Number_of_patents Number_of_trademarks consdummy newstatus control failure dup guo_iso  failure year_of_incorporation year_of_status nace_2 fin_rev int_paid ebitda cash_flow depr revenue total_assets long_term_debt employees added_value materials wage_bill loans int_fixed_assets fixed_assets tax retained_earnings firm_value current_liabilities liquidity_ratio solvency_ratio current_assets fin_expenses net_income shareholders_funds fin_cons fin_cons100 inv ICR_t time real_SA NEG_VA ICR_failure profitability misallocated_fixed capital_intensity labour_product interest_diff area zone
save data_lagged.dta, replace
restore

********************************************************************************
*                      Generate Year/Country TFP data                          *
********************************************************************************

gen failure_2017= . 
replace failure_2017 = 1 if year_of_status == 2017 | year_of_status == 2018 & failure == 1
replace failure_2017 = 0 if year_of_status == 2018 & failure == 0 /*& year_of_incorporation<=2017*/

forval j = 2009/2016 {
	gen failure_`j' = .
	replace failure_`j' = 0 if year_of_incorporation<= `j' & year_of_status != `j'
	replace failure_`j' = 1 if year_of_status == `j' & failure == 1
	replace failure_`j' = . if year_of_incorporation> `j' /* maybe oversampling no failure */
}

*GENERAL

preserve 
*drop if year_of_status < 2017 | year_of_incorporation >= 2017
forval j = 2008/2016 {
	egen tfp_acf_`j' = rowtotal(tfp_acf_10`j' tfp_acf_11`j' tfp_acf_12`j' tfp_acf_13`j' tfp_acf_14`j' tfp_acf_15`j' tfp_acf_16`j' tfp_acf_17`j' tfp_acf_18`j' tfp_acf_19`j' tfp_acf_20`j' tfp_acf_21`j' tfp_acf_22`j' tfp_acf_23`j' tfp_acf_24`j' tfp_acf_25`j' tfp_acf_26`j' tfp_acf_27`j' tfp_acf_28`j' tfp_acf_29`j' tfp_acf_30`j' tfp_acf_31`j' tfp_acf_32`j' tfp_acf_33`j')
	replace tfp_acf_`j' = . if tfp_acf_`j'==0
}
keep id iso tfp_acf_* region city conscode Date_of_incorporation Status Status_date naics nace dummy_patent dummy_trademark consdummy newstatus control failure_* dup guo_iso  failure year_of_incorporation year_of_status nace_2 fin_rev_* int_paid_* ebitda_* cash_flow_* depr* revenue* total_assets_* long_term_debt_* employees_* added_value_* materials_* wage_bill_* loans_* int_fixed_assets_* fixed_assets_* tax_* retained_earnings_* firm_value_* current_liabilities_* liquidity_ratio_* solvency_ratio_* current_assets_* fin_expenses_* net_income_* shareholders_funds_* fin_cons_* fin_cons100_* inv_* ICR_* time real_SA_* NEG_VA_* ICR_failure_* profitability_* misallocated_*_fixed capital_intensity_* labour_product_* interest_diff_* area zone
save data_all_countries.dta, replace
restore


*SPAIN

preserve 
*drop if year_of_status < 2017 | year_of_incorporation >= 2017
forval j = 2008/2016 {
	egen tfp_acf_`j' = rowtotal(tfp_acf_10`j' tfp_acf_11`j' tfp_acf_12`j' tfp_acf_13`j' tfp_acf_14`j' tfp_acf_15`j' tfp_acf_16`j' tfp_acf_17`j' tfp_acf_18`j' tfp_acf_19`j' tfp_acf_20`j' tfp_acf_21`j' tfp_acf_22`j' tfp_acf_23`j' tfp_acf_24`j' tfp_acf_25`j' tfp_acf_26`j' tfp_acf_27`j' tfp_acf_28`j' tfp_acf_29`j' tfp_acf_30`j' tfp_acf_31`j' tfp_acf_32`j' tfp_acf_33`j')
	replace tfp_acf_`j' = . if tfp_acf_`j'==0
}
keep if iso=="ES"
keep id iso tfp_acf_* region city conscode Date_of_incorporation Status Status_date naics nace dummy_patent dummy_trademark consdummy newstatus control failure_* dup guo_iso  failure year_of_incorporation year_of_status nace_2 fin_rev_* int_paid_* ebitda_* cash_flow_* depr* revenue* total_assets_* long_term_debt_* employees_* added_value_* materials_* wage_bill_* loans_* int_fixed_assets_* fixed_assets_* tax_* retained_earnings_* firm_value_* current_liabilities_* liquidity_ratio_* solvency_ratio_* current_assets_* fin_expenses_* net_income_* shareholders_funds_* fin_cons_* fin_cons100_* inv_* ICR_* time real_SA_* NEG_VA_* ICR_failure_* profitability_* misallocated_*_fixed capital_intensity_* labour_product_* interest_diff_* area zone
save data_spain.dta, replace
restore

*PORTUGAL

preserve 
*drop if year_of_status < 2017 | year_of_incorporation >= 2017
forval j = 2008/2016 {
	egen tfp_acf_`j' = rowtotal(tfp_acf_10`j' tfp_acf_11`j' tfp_acf_12`j' tfp_acf_13`j' tfp_acf_14`j' tfp_acf_15`j' tfp_acf_16`j' tfp_acf_17`j' tfp_acf_18`j' tfp_acf_19`j' tfp_acf_20`j' tfp_acf_21`j' tfp_acf_22`j' tfp_acf_23`j' tfp_acf_24`j' tfp_acf_25`j' tfp_acf_26`j' tfp_acf_27`j' tfp_acf_28`j' tfp_acf_29`j' tfp_acf_30`j' tfp_acf_31`j' tfp_acf_32`j' tfp_acf_33`j')
	replace tfp_acf_`j' = . if tfp_acf_`j'==0
}
keep if iso=="PT"
keep id iso tfp_acf_* region city conscode Date_of_incorporation Status Status_date naics nace dummy_patent dummy_trademark consdummy newstatus control failure_* dup guo_iso  failure year_of_incorporation year_of_status nace_2 fin_rev_* int_paid_* ebitda_* cash_flow_* depr* revenue* total_assets_* long_term_debt_* employees_* added_value_* materials_* wage_bill_* loans_* int_fixed_assets_* fixed_assets_* tax_* retained_earnings_* firm_value_* current_liabilities_* liquidity_ratio_* solvency_ratio_* current_assets_* fin_expenses_* net_income_* shareholders_funds_* fin_cons_* fin_cons100_* inv_* ICR_* time real_SA_* NEG_VA_* ICR_failure_* profitability_* misallocated_*_fixed capital_intensity_* labour_product_* interest_diff_* area zone
save data_portugal.dta, replace
restore

*FRANCE

preserve 
*drop if year_of_status < 2017 | year_of_incorporation >= 2017
forval j = 2008/2016 {
	egen tfp_acf_`j' = rowtotal(tfp_acf_10`j' tfp_acf_11`j' tfp_acf_12`j' tfp_acf_13`j' tfp_acf_14`j' tfp_acf_15`j' tfp_acf_16`j' tfp_acf_17`j' tfp_acf_18`j' tfp_acf_19`j' tfp_acf_20`j' tfp_acf_21`j' tfp_acf_22`j' tfp_acf_23`j' tfp_acf_24`j' tfp_acf_25`j' tfp_acf_26`j' tfp_acf_27`j' tfp_acf_28`j' tfp_acf_29`j' tfp_acf_30`j' tfp_acf_31`j' tfp_acf_32`j' tfp_acf_33`j')
	replace tfp_acf_`j' = . if tfp_acf_`j'==0
}
keep if iso=="FR"
keep id iso tfp_acf_* region city conscode Date_of_incorporation Status Status_date naics nace dummy_patent dummy_trademark consdummy newstatus control failure_* dup guo_iso  failure year_of_incorporation year_of_status nace_2 fin_rev_* int_paid_* ebitda_* cash_flow_* depr* revenue* total_assets_* long_term_debt_* employees_* added_value_* materials_* wage_bill_* loans_* int_fixed_assets_* fixed_assets_* tax_* retained_earnings_* firm_value_* current_liabilities_* liquidity_ratio_* solvency_ratio_* current_assets_* fin_expenses_* net_income_* shareholders_funds_* fin_cons_* fin_cons100_* inv_* ICR_* time real_SA_* NEG_VA_* ICR_failure_* profitability_* misallocated_*_fixed capital_intensity_* labour_product_* interest_diff_* area zone
save data_france.dta, replace
restore

*ITALY (without imputed values of revenues/employees)

preserve 
*drop if year_of_status < 2017 | year_of_incorporation >= 2017
forval j = 2008/2016 {
	egen tfp_acf_`j' = rowtotal(tfp_acf_10`j' tfp_acf_11`j' tfp_acf_12`j' tfp_acf_13`j' tfp_acf_14`j' tfp_acf_15`j' tfp_acf_16`j' tfp_acf_17`j' tfp_acf_18`j' tfp_acf_19`j' tfp_acf_20`j' tfp_acf_21`j' tfp_acf_22`j' tfp_acf_23`j' tfp_acf_24`j' tfp_acf_25`j' tfp_acf_26`j' tfp_acf_27`j' tfp_acf_28`j' tfp_acf_29`j' tfp_acf_30`j' tfp_acf_31`j' tfp_acf_32`j' tfp_acf_33`j')
	replace tfp_acf_`j' = . if tfp_acf_`j'==0
}
keep if iso=="IT"
keep id iso tfp_acf_* region city conscode Date_of_incorporation Status Status_date naics nace dummy_patent dummy_trademark consdummy newstatus control failure_* dup guo_iso  failure year_of_incorporation year_of_status nace_2 fin_rev_* int_paid_* ebitda_* cash_flow_* depr* revenue* total_assets_* long_term_debt_* employees_* added_value_* materials_* wage_bill_* loans_* int_fixed_assets_* fixed_assets_* tax_* retained_earnings_* firm_value_* current_liabilities_* liquidity_ratio_* solvency_ratio_* current_assets_* fin_expenses_* net_income_* shareholders_funds_* fin_cons_* fin_cons100_* inv_* ICR_* time real_SA_* NEG_VA_* ICR_failure_* profitability_* misallocated_*_fixed capital_intensity_* labour_product_* interest_diff_* area zone
save data_italy.dta, replace
restore
