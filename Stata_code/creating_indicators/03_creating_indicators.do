***********************
* Creating Indicators *
***********************

* Set working directory
clear all 
cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data"
use data_clean.dta

* Generate failure variable
gen failure=0
replace failure=1 if Status=="Dissolved (bankruptcy)"  | Status=="Dissolved (demerger)" | Status=="Dissolved" | Status=="Dissolved (liquidation)" | Status=="Dissolved (merger or take-over)" | Status=="Bankruptcy" | Status=="In liquidation"
replace failure=. if Status=="Inactive (no precision)" | Status=="Unknown situation" 
tab failure

/*  
    failure |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    670,403       94.10       94.10
          1 |     42,034        5.90      100.00
------------+-----------------------------------
      Total |    712,437      100.00
*/

count if failure==1 & Status_date=="" /*12,640 without failure date if failed*/

* Generate year of failure variable
gen year_of_status=substr(Status_date, -4,4)
destring year_of_status, replace force /* possible attrition bias in failures */

* Generate year of incorporation variable
gen year_of_incorporation=substr(Date_of_incorporation, -4,4)

/* some dates are not coded properly so we use the following code
to get the correct years */
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
count if failure==1 & year_of_status==. /* 12,640 without failure date if failed */
drop if failure==1 & year_of_status==. 
count if year_of_incorporation==. /* 1,241 with no year of incorporation*/
count if  Status_date < Date_of_incorporation
count if  year_of_status < year_of_incorporation
tab Status if  year_of_status < year_of_incorporation
tab Status if  year_of_status < year_of_incorporation & year_of_incorporation!=.
/* 618 observtions where the failure date is after the year of status */
/* most of these are active firms, so year of status is not failure year */
drop if  year_of_status < year_of_incorporation & year_of_incorporation!=. & Status!="Active"
/* 2 obs deleted */

* Generate missing failure year for observations that didn't fail
replace year_of_status=2018 if  year_of_status < year_of_incorporation & year_of_incorporation!=. & Status=="Active"
replace year_of_status=. if failure==0  
/*Possible bias in the data: status date instead of date of incorporation */
*replace year_of_incorporation=year_of_status if  year_of_status!=. & failure==0
* replace year_of_status=. if  year_of_status!=. & failure==0

* Table variables
tab year_of_status
tab year_of_incorporation

* Generate firms age
gen age=.
replace age= 2018 -  year_of_incorporation if year_of_status==.
replace age=year_of_status - year_of_incorporation if year_of_status!=.

* Bysort data
*bysort id: egen minage=min(age) 
*gen statusdummy=1 if minage==age
*keep if statusdummy==1
*rename Status newstatus
*keep age newstatus BvD_ID_number
*rename BvD_ID_number id
*sort id

* For some observations we have financial account data even after failure (i.e., liquidated firms)
forval j = 2008/2016 { 
    count if total_assets_`j'!=. & year_of_status<`j' /* what to do with these obs? */
	tab Status if total_assets_`j'!=. & year_of_status<`j' 
	*tab iso if total_assets_`j'!=. & year_of_status<`j' 
	*drop if Status!="In liquidation" & total_assets_`j'!=. & year_of_status<`j'
	/* I am keeping liquidated firms */
}

* Generate censorship date (2018)
replace year_of_status=2018 if failure==0 /* censorship date */
drop if year_of_incorporation==. /* 77 deleted observations */
drop if failure==1 & year_of_status==.  /* 0 deleted observations */

* Drop if no status year
count if year_of_status==.
tab iso if year_of_status==.
tab Status if year_of_status==.
/* no status for firms recorded as "Inactive (no precision)" */
tab iso if Status=="Inactive (no precision)"
/* inactive firms are mostly in italy */
drop if Status=="Inactive (no precision)"

*STSET
*STSET format of data
stset year_of_status, origin(year_of_incorporation) failure(failure)

* Generate time variable
gen time=.
replace time=_t
*replace time=69 if _t>=69 /* 99th percentile */

* Generate NACE 2 digits variable
gen nace_2=.
destring nace, replace
replace nace_2= nace/100
replace nace_2=floor(nace_2)

* Drop observations with status year before 2009
drop if year_of_status<2009


/* N.B. In the italian data many imputed values of revenues (all the same) */
count if revenue2016==revenue2015 & revenue2016!=.
tab iso if revenue2016==revenue2015 & revenue2016!=.
tab iso if revenue2015==revenue2014 & revenue2015!=.

********************************************************************************
*                       Generating Lagged Values (t-1)                         *
********************************************************************************

*Generating Financial Revenues Lagged Values
gen fin_rev=.
replace fin_rev = fin_rev_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  fin_rev= fin_rev_`j' if year_of_status==`j'+1
}

*Generating Interest Paid Lagged Values
gen int_paid=.
replace int_paid = int_paid_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace int_paid = int_paid_`j' if year_of_status==`j'+1
}

*Generating Cash Flow Lagged Values
gen cash_flow=.
replace cash_flow = cash_flow_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  cash_flow = cash_flow_`j' if year_of_status==`j'+1
}

*Generating Ebitda Lagged Values
gen ebitda=.
replace ebitda = ebitda_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  ebitda = ebitda_`j' if year_of_status==`j'+1
}

*Generating Depriciation Lagged Values
gen depr=.
replace depr = depr2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  depr = depr`j' if year_of_status==`j'+1
}

*Generating Revenues Lagged Values
gen revenue=.
replace revenue = revenue2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  revenue = revenue`j' if year_of_status==`j'+1
}

*Generating Total Assets Lagged Values
gen total_assets=.
replace total_assets = total_assets_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  total_assets = total_assets_`j' if year_of_status==`j'+1
}

*Generating Long Term Debt Lagged Values
gen long_term_debt=.
replace long_term_debt = long_term_debt_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  long_term_debt = long_term_debt_`j' if year_of_status==`j'+1
}

*Generating Employees Lagged Values
gen employees=.
replace employees = employees_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  employees = employees_`j' if year_of_status==`j'+1
}

*Generating Added Value Lagged Values
gen added_value=.
replace added_value = added_value_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  added_value = added_value_`j' if year_of_status==`j'+1
}

*Generating Materials Lagged Values
gen materials=.
replace materials = materials_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  materials = materials_`j' if year_of_status==`j'+1
}

*Generating Wage Bill Lagged Values
gen wage_bill=.
replace wage_bill = wage_bill_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  wage_bill = wage_bill_`j' if year_of_status==`j'+1
}

*Generating Loans Lagged Values
gen loans=.
replace loans = loans_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  loans = loans_`j' if year_of_status==`j'+1
}

*Generating Fixed assets Lagged Values
gen fixed_assets=.
replace fixed_assets = fixed_assets_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  fixed_assets = fixed_assets_`j' if year_of_status==`j'+1
}

*Generating Int fixed assets Lagged Values
gen int_fixed_assets=.
replace int_fixed_assets = int_fixed_assets_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  int_fixed_assets = int_fixed_assets_`j' if year_of_status==`j'+1
}

*Generating Tax Lagged Values
gen tax=.
replace tax = tax_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  tax = tax_`j' if year_of_status==`j'+1
}

*Generating Retained earnings Lagged Values
gen retained_earnings=.
replace retained_earnings = retained_earnings_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  retained_earnings = retained_earnings_`j' if year_of_status==`j'+1
}

*Generating Firm Value Lagged Values
gen firm_value=.
replace firm_value = firm_value_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  firm_value = firm_value_`j' if year_of_status==`j'+1
}

*Generating Current Liabilities Lagged Values
gen current_liabilities=.
replace current_liabilities = current_liabilities_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  current_liabilities = current_liabilities_`j' if year_of_status==`j'+1
}

*Generating Liquidity Ratio Lagged Values
gen liquidity_ratio=.
replace liquidity_ratio = liquidity_ratio_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  liquidity_ratio = liquidity_ratio_`j' if year_of_status==`j'+1
}

*Generating Solvency Ratio Lagged Values
gen solvency_ratio=.
replace solvency_ratio = solvency_ratio_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  solvency_ratio = solvency_ratio_`j' if year_of_status==`j'+1
}

*Generating Current Assets Lagged Values
gen current_assets=.
replace current_assets = current_assets_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  current_assets = current_assets_`j' if year_of_status==`j'+1
}

*Generating Fin Expenses Lagged Values
gen fin_expenses=.
replace fin_expenses = fin_expenses_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  fin_expenses = fin_expenses_`j' if year_of_status==`j'+1
}

*Generating Fin Expenses Lagged Values
gen shareholders_funds=.
replace shareholders_funds = shareholders_funds_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  shareholders_funds = shareholders_funds_`j' if year_of_status==`j'+1
}

*Generating Net Income Lagged Values
gen net_income=.
replace net_income = net_income_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  net_income = net_income_`j' if year_of_status==`j'+1
}

********************************************************************************
*                      Generating Indicators (t-1)                             *
********************************************************************************

* Capital Intensity
forval j = 2008/2016 { 
     gen capital_intensity_`j' = fixed_assets_`j'/employees_`j'
}

*Introduce Capital Intensity Lagged Values (2016-2008)
gen capital_intensity=.
replace capital_intensity= capital_intensity_2016 if year_of_status==2017 | year_of_status==2018 
forval j = 2008/2015 { 
     replace capital_intensity= capital_intensity_`j' if year_of_status==`j'+1 
}

********************************************************************************

* Labour productivity
forval j = 2008/2016 { 
     gen labour_product_`j' = added_value_`j'/employees_`j'
}

*Introduce Labor Productivity Lagged Values (2016-2008)
gen labour_product=.
replace labour_product= labour_product_2016 if year_of_status==2017 | year_of_status==2018 
forval j = 2008/2015 { 
     replace labour_product= labour_product_`j' if year_of_status==`j'+1 
}


********************************************************************************
*Generating Financial Constraints (Nickell & Nicolitsas, 1999)
forval j = 2008/2016 { 
    gen fin_cons_`j' =  (int_paid_`j')/(ebitda_`j') if ebitda_`j'!=. & int_paid_`j'!=.
	*replace fin_cons_`j'=1 if fin_cons_`j'<0 /*following N&N99 */
	*replace fin_cons_`j'=1 if fin_cons_`j'>1 & fin_cons_`j'!=. /* just for very small numbers */
	
}


forval j = 2008/2016 { 
	quietly su fin_cons_`j', d /* windsorize */
	scalar fin_cons_`j'_1=r(p1)
	scalar fin_cons_`j'_99=r(p99)
	replace fin_cons_`j' = fin_cons_`j'_1 if fin_cons_`j'<= fin_cons_`j'_1 & fin_cons_`j'!=.
	replace fin_cons_`j' = fin_cons_`j'_99 if fin_cons_`j'>= fin_cons_`j'_99 & fin_cons_`j'!=.
	gen fin_cons100_`j'=fin_cons_`j'*100 /* to see the effect of 1 percentage increse */
}

*Generating Finantial constraints Lagged Values
gen fin_cons=.
replace fin_cons = fin_cons_2016 if (year_of_statu==2017 | year_of_status==2018) & ebitda_2016!=. & int_paid_2016!=./*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace fin_cons =  fin_cons_`j' if year_of_status==`j'+1 & ebitda_`j'!=. & int_paid_`j'!=.
} /* windsorize again? */

*replace fin_cons=1 if fin_cons<0  /*following N&N99 */
*replace fin_cons=1 if fin_cons>1 & fin_cons!=. /* just 1.6% */ 
gen fin_cons100=fin_cons*100 /* to see the effect of 1 percentage increse */



********************************************************************************
*Generate Investments
forval j = 2009/2016 { 
	local t = `j' - 1
     gen inv_`j' =  (fixed_assets_`j' - fixed_assets_`t' + depr`j')  if fixed_assets_`j'!=. & fixed_assets_`t'!=. & depr`j'!=. 
}

*Introduce Investments Lagged Values (2016-2010)
gen inv=.
replace inv= inv_2016 if (year_of_status==2017 | year_of_status==2018) & fixed_assets_2016!=. &  fixed_assets_2015!=. & depr2016!=./*just first 4 months of 2018*/
forval j = 2009/2015 { 
     replace inv= inv_`j' if year_of_status==`j'+1 & fixed_assets_`j'!=. &  fixed_assets_`j'-1!=. & depr`j'!=.
}


********************************************************************************
*Interest coverage ratio
*ICR=EBIT/Interest Expenses
forval j = 2008/2016 { 
    gen ebit_`j'= (ebitda_`j' - depr`j') if ebitda_`j'!=. & depr`j'!=. 
	gen ICR_`j'=ebit_`j'/int_paid_`j' if ebit_`j'!=. & int_paid_`j'!=.
}

forval j = 2008/2009 { 
    hist ICR_`j' if ICR_`j'<100 & ICR_`j'>-100
}

forval j = 2008/2016 { 
    gen ICR_failure_`j'=.
	replace ICR_failure_`j'=1 if ICR_`j'<=1 
	replace ICR_failure_`j'=0 if ICR_`j'>1
	replace ICR_failure_`j'=. if ICR_`j'==.
}

*Generating Interest Coverage Ratio Lagged Values
*ICR t-1
gen ICR_t=.
replace ICR_t=ICR_2016 if year_of_status==2017 |  year_of_status==2018 
forval j = 2008/2015 { 
	replace ICR_t = ICR_`j' if year_of_status==`j'+1
}

hist ICR_t if ICR_t<100 & ICR_t>-100
hist ICR_t if ICR_t<20 & ICR_t>-20

gen ICR_failure=.
replace ICR_failure=1 if ICR_t<=1 
replace ICR_failure=0 if ICR_t>1
replace ICR_failure=. if ICR_t==.

********************************************************************************
*Benchmark Interest Difference (prime rate / prime rate moving average)

* R_t = Short_term_loans_(t-1)* Prime_rate_(t-1) + Long_term_debt_(t-1) * Mov_Avg_5_years(Prime Rate)
* Lending Rate from World Bank 

/*We don't have prime rate: I use the interest rate from world bank
di (5.506 + 5.314 + 5.622 + 6.335 + 6.837)/5 /* 2008 */
di (5.314 + 5.622 + 6.335 + 6.837 + 4.757)/5
di (5.622 + 6.335 + 6.837 + 4.757 + 4.032)/5
di (6.335 + 6.837 + 4.757 + 4.032 + 4.599)/5
di (6.837 + 4.757 + 4.032 + 4.599 + 5.223)/5
di (4.757 + 4.032 + 4.599 + 5.223 + 5.144)/5
di (4.032 + 4.599 + 5.223 + 5.144 + 4.867)/5
di (4.599 + 5.223 + 5.144 + 4.867 + 4.129)/5 /* 2015 */

gen R2016= loans_2015 * 4.129 + (4.7924)* long_term_debt_2015
gen R2015= loans_2014 * 4.867 + (4.773)* long_term_debt_2014
gen R2014= loans_2013 * 5.144 + (4.751)* long_term_debt_2013
gen R2013= loans_2012 * 5.223 + (5.0896)* long_term_debt_2012
gen R2012= loans_2011 * 4.599 + (5.312)* long_term_debt_2011
gen R2011= loans_2010 * 4.032 + (5.5166)* long_term_debt_2010
gen R2010= loans_2009 * 4.757 + (5.773)* long_term_debt_2009
gen R2009= loans_2008 * 6.837 + (5.9228)* long_term_debt_2008 */

*We don't have prime rate: here I use the "Long term government bond yields" EMU (Eurostat)
*Spain
gen i_2016_spain= 1.39
gen i_2015_spain= 1.74
gen i_2014_spain= 2.72
gen i_2013_spain= 4.56
gen i_2012_spain= 5.85
gen i_2011_spain= 5.44
gen i_2010_spain= 4.25
gen i_2009_spain= 3.98
gen i_2008_spain= 4.37
gen i_2007_spain= 4.31
gen i_2006_spain= 3.79
gen i_2005_spain= 3.39
gen i_2004_spain= 4.1

*Italy
gen i_2016_italy= 1.49
gen i_2015_italy= 1.71
gen i_2014_italy= 2.89
gen i_2013_italy= 4.32
gen i_2012_italy= 5.49
gen i_2011_italy= 5.42
gen i_2010_italy= 4.04
gen i_2009_italy= 4.31
gen i_2008_italy= 4.68
gen i_2007_italy= 4.49
gen i_2006_italy= 4.05
gen i_2005_italy= 3.56
gen i_2004_italy= 4.26


*France
gen i_2016_france= .47
gen i_2015_france= .84
gen i_2014_france= 1.67
gen i_2013_france= 2.2
gen i_2012_france= 2.54
gen i_2011_france= 3.32
gen i_2010_france= 3.12
gen i_2009_france= 3.65
gen i_2008_france= 4.23
gen i_2007_france= 4.3
gen i_2006_france= 3.8
gen i_2005_france= 3.41
gen i_2004_france= 4.1


*Portugal
gen i_2016_portugal= 3.17
gen i_2015_portugal= 2.42
gen i_2014_portugal= 3.75
gen i_2013_portugal= 6.29
gen i_2012_portugal= 10.55
gen i_2011_portugal= 10.24
gen i_2010_portugal= 5.4
gen i_2009_portugal= 4.21
gen i_2008_portugal= 4.52
gen i_2007_portugal= 4.43
gen i_2006_portugal= 3.91
gen i_2005_portugal= 3.44
gen i_2004_portugal= 4.14


forval j = 2008/2015 { 
	count if long_term_debt_`j' <0 /* some negative debts*/
}

forval j = 2008/2015 { 
	drop if long_term_debt_`j' <0 /*we drop negative debts out*/
}


forval j = 2009/2016 { 
	local t  = `j' - 1
	local x  = `j' - 2
	local y  = `j' - 3
	local z  = `j' - 4
	local q  = `j' - 5
	gen R_`j'_it = loans_`t'* i_`t'_italy + long_term_debt_`t' * (i_`t'_italy + i_`x'_italy + i_`y'_italy + i_`z'_italy + i_`q'_italy)/5 if loans_`t'!=. & long_term_debt_`t'!=. & iso=="IT"
	gen R_`j'_fr = loans_`t'* i_`t'_france + long_term_debt_`t' * (i_`t'_france + i_`x'_france + i_`y'_france + i_`z'_france + i_`q'_france)/5 if loans_`t'!=. & long_term_debt_`t'!=. & iso=="FR"
	gen R_`j'_es = loans_`t'* i_`t'_spain + long_term_debt_`t' * (i_`t'_spain + i_`x'_spain + i_`y'_spain + i_`z'_spain + i_`q'_spain)/5 if loans_`t'!=. & long_term_debt_`t'!=. & iso=="ES"
	gen R_`j'_pt = loans_`t'* i_`t'_portugal + long_term_debt_`t' * (i_`t'_portugal + i_`x'_portugal + i_`y'_portugal + i_`z'_portugal + i_`q'_portugal)/5 if loans_`t'!=. & long_term_debt_`t'!=. & iso=="PT"
}

forval j = 2009/2016 {
	egen R_`j' = rowtotal(R_`j'_es R_`j'_it R_`j'_fr R_`j'_pt)
}

*gen DIFF2015=  interest_paid2015-R2015
forval j = 2009/2016 { 
	gen DIFF_`j' = int_paid_`j' - R_`j' if int_paid_`j'!=. & R_`j'!=.
}

forval j = 2009/2016 { 
	gen interest_diff_`j' = cond(DIFF_`j' <0,0,1) if int_paid_`j'!=. & R_`j'!=.
}


gen interest_diff=.
replace interest_diff= cond(DIFF_2016 <0,0,1) if (year_of_status==2017 | year_of_status==2018) & DIFF_2016!=. 
forval j = 2009/2015 { 
	replace interest_diff = cond(DIFF_`j' <0,0,1) if year_of_status==(`j' + 1) & int_paid_`j'!=. & R_`j'!=.
}


********************************************************************************
*Generate SIZE AGE INDICATOR

forval j = 2008/2016 { 
	gen real_SA_`j' = (-0.737*log(total_assets_`j')) + (0.043*log(total_assets_`j'))^2 - (0.040 * (time)) if year_of_status==`j'
	replace real_SA_`j' = (-0.737*log(total_assets_`j')) + (0.043*log(total_assets_`j'))^2 - (0.040 * (time - (year_of_status - `j'))) if year_of_status!=`j'
}

gen real_SA=. /*adjust for inflation*/
replace real_SA=(-0.737*log(total_assets_2016)) + (0.043*log(total_assets_2016))^2 - (0.040 * (time)) if (year_of_status==2017 | year_of_status==2018) & total_assets_2016!=.
replace real_SA=(-0.737*log(total_assets_2015)) + (0.043*log(total_assets_2015))^2 - (0.040 * (time)) if year_of_status==2016  & total_assets_2015!=.
replace real_SA=(-0.737*log(total_assets_2014)) + (0.043*log(total_assets_2014))^2 - (0.040 * (time)) if year_of_status==2015  & total_assets_2014!=.
replace real_SA=(-0.737*log(total_assets_2013)) + (0.043*log(total_assets_2013))^2 - (0.040 * (time)) if year_of_status==2014  & total_assets_2013!=.
replace real_SA=(-0.737*log(total_assets_2012)) + (0.043*log(total_assets_2012))^2 - (0.040 * (time)) if year_of_status==2013  & total_assets_2012!=.
replace real_SA=(-0.737*log(total_assets_2011)) + (0.043*log(total_assets_2011))^2 - (0.040 * (time)) if year_of_status==2012  & total_assets_2011!=.
replace real_SA=(-0.737*log(total_assets_2010)) + (0.043*log(total_assets_2010))^2 - (0.040 * (time)) if year_of_status==2011  & total_assets_2010!=.
replace real_SA=(-0.737*log(total_assets_2009)) + (0.043*log(total_assets_2009))^2 - (0.040 * (time)) if year_of_status==2010  & total_assets_2009!=.
replace real_SA=(-0.737*log(total_assets_2008)) + (0.043*log(total_assets_2008))^2 - (0.040 * (time)) if year_of_status==2009  & total_assets_2008!=.
count if real_SA==.

********************************************************************************
*Negative Value Added

forval j = 2008/2016 { 
	gen NEG_VA_`j' = .
	replace NEG_VA_`j' = 1 if added_value_`j' <= 0
	replace NEG_VA_`j' = 0 if added_value_`j' > 0 & added_value_`j'!=.
} 

gen NEG_VA=.
replace NEG_VA= cond(added_value_2016<=0,1,0) if year_of_status==2017 | year_of_status==2018 & added_value_2016!=.
forval j = 2008/2015 { 
	replace NEG_VA= cond(added_value_`j'<=0,1,0) if year_of_status==(`j' + 1) & added_value_`j'!=.
}
count if NEG_VA==.

********************************************************************************
* Misallocated Capital (Schivardi & Tabellini, 2017)

* ROA = Moving Average Ebitda (3 years) / Total Assets

forval j = 2008/2016 { 
	gen roa_`j' = (ebitda_`j')/(total_assets_`j') /* we don't have moving average for 2009 and 2010 */
    *gen roa_`j' = ((ebitda_`j' + ebitda_`j-1' + ebitda_`j-2')/3)/(total_assets_`j')
    *replace roa_`j'=0 if roa_`j'<=0 /* some negative values */
	*replace roa_`j'=0 if roa_`j'>1 & roa_`j'!=.
	quietly su roa_`j', d /* windsorize */
	scalar roa_`j'_99=r(p99)
	scalar roa_`j'_1=r(p1)
	replace roa_`j'=roa_`j'_99 if roa_`j'>= roa_`j'_99 & roa_`j'!=.
	replace roa_`j'=roa_`j'_1 if roa_`j'<= roa_`j'_1 & roa_`j'!=.
	replace roa_`j'= roa_`j'*100
}

su roa_2016,d
_pctile roa_2016, nq(20)
return list

*Z SCORE for private firms Z′ = 0.717X1 + 0.847X2 + 3.107X3 + 0.420X4 + 0.998X5

*Z score Altman + Zingales
forval j = 2008/2016 { 
	gen X1_`j' = (current_assets_`j' - current_liabilities_`j')/(total_assets_`j')
	replace X1_`j'=0 if X1_`j'==.
	gen X2_`j' = (retained_earnings_`j')/(total_assets_`j')
	replace X2_`j'=0 if X2_`j'==.
	gen X3_`j' = (ebitda_`j' - depr`j')/(total_assets_`j')
	replace X3_`j'=0 if X3_`j'==.
	gen X4_`j' = (firm_value_`j')/(current_liabilities_`j' + long_term_debt_`j')
	/*proxy for total liabilities = current + long term debt */
	replace X4_`j'=0 if X4_`j'==.
	gen X5_`j' =  (revenue`j'/*proxy for sales*/)/(total_assets_`j')
	replace X5_`j'=0 if X5_`j'==.
}

forval j = 2008/2016 { 
	gen Z_`j' = 0.717*X1_`j' + 0.847*X2_`j' + 3.107*X3_`j' + 0.420*X4_`j' + 0.998*X5_`j'
	replace Z_`j'=. if Z_`j' <= 0 /* bounded between 0 and 9 */
	replace Z_`j'=9 if  Z_`j'>=9 & Z_`j'!=.
}
su Z_2016
_pctile Z_2016, nq(20)
return list


forval j = 2008/2016 { 
	gen leverage_`j' = fin_expenses_`j' /*long term debt for financial debt*/ / total_assets_`j'
	replace leverage_`j' = leverage_`j' * 100
}

su leverage_2008
_pctile leverage_2008, nq(20)
return list


*Misallocated Capital: ROA < PRIME RATE (Z-score 1/2) & Leverage > Median Leverage (2005)

forval j = 2008/2016 { 
	gen misallocated_`j'_fixed = .
	replace misallocated_`j'_fixed = 0 if  roa_`j'!=. 
	*quietly su leverage_`j', d
	quietly su leverage_2008 if iso=="IT" & year_of_status==2009 | year_of_status==2010 & (roa_2008 < i_2008_italy | roa_2009 < i_2009_italy | roa_2010 < i_2010_italy), d/*fixed threshold Italy */
	scalar leverage_`j'_50_it=r(p50)
	replace misallocated_`j'_fixed = 1 if leverage_`j'>=leverage_`j'_50_it & leverage_`j'!=. & iso=="IT" & roa_`j' < i_`j'_italy & roa_`j'!=.
	quietly	su leverage_2008 if iso=="ES" & (year_of_status==2009 | year_of_status==2010) & (roa_2008 < i_2008_spain | roa_2009 < i_2009_spain | roa_2010 < i_2010_spain), d/*fixed threshold Spain */
	scalar leverage_`j'_50_es=r(p50)
	replace misallocated_`j'_fixed = 1 if leverage_`j'>=leverage_`j'_50_es & leverage_`j'!=. & iso=="ES" & roa_`j' < i_`j'_spain & roa_`j'!=. 
	quietly	su leverage_2008 if iso=="FR" & (year_of_status==2009 | year_of_status==2010) & (roa_2008 < i_2008_france | roa_2009 < i_2009_france | roa_2010 < i_2010_france), d/*fixed threshold France*/
	scalar leverage_`j'_50_fr=r(p50)
	replace misallocated_`j'_fixed = 1 if leverage_`j'>=leverage_`j'_50_fr & leverage_`j'!=. & iso=="FR" & roa_`j' < i_`j'_france & roa_`j'!=. 
	quietly	su leverage_2008 if iso=="PT" & (year_of_status==2009 | year_of_status==2010) & (roa_2008 < i_2008_portugal | roa_2009 < i_2009_portugal | roa_2010 < i_2010_portugal), d/*fixed threshold Portugal*/
	scalar leverage_`j'_50_pt=r(p50)
	replace misallocated_`j'_fixed = 1 if leverage_`j'>=leverage_`j'_50_pt & leverage_`j'!=. & iso=="PT" & roa_`j' < i_`j'_portugal & roa_`j'!=. 
}


forval j = 2008/2016 { 	
	tab misallocated_`j'_fixed iso, col
}

gen misallocated_fixed=.
replace misallocated_fixed = misallocated_2016_fixed if year_of_status==2017 | year_of_status==2018 
forval j = 2008/2015 { 
	replace misallocated_fixed = misallocated_`j'_fixed if year_of_status==(`j' + 1) 
}
count if misallocated_fixed==.
tab misallocated_fixed

********************************************************************************
*Profitability (Schivardi & Tabellini, 2017)

forval j = 2008/2016 { 
	gen profit_ratio_`j' = ebitda_`j' / int_paid_`j'
}

forval j = 2008/2016 { 
	gen profitability_`j' = .
	replace profitability_`j' = 0 if  profit_ratio_`j'!=. 
	*quietly su leverage_`j', d
	quietly su leverage_2008 if iso=="IT" & (year_of_status==2009 | year_of_status==2010) & (roa_2008 < i_2008_italy | roa_2009 < i_2009_italy | roa_2010 < i_2010_italy), d/*fixed threshold Italy */
	scalar leverage_`j'_50_it=r(p50)
	replace profitability_`j' = 1 if leverage_`j'>=leverage_`j'_50_it & leverage_`j'!=. & iso=="IT" & roa_`j' < i_`j'_italy & profit_ratio_`j'<1
	quietly	su leverage_2008 if iso=="ES" & (year_of_status==2009 | year_of_status==2010) & (roa_2008 < i_2008_spain | roa_2009 < i_2009_spain | roa_2010 < i_2010_spain), d/*fixed threshold Spain */
	scalar leverage_`j'_50_es=r(p50)
	replace profitability_`j' = 1 if leverage_`j'>=leverage_`j'_50_es & leverage_`j'!=. & iso=="ES" & roa_`j' < i_`j'_spain & profit_ratio_`j'<1
	quietly	su leverage_2008 if iso=="FR" & (year_of_status==2009 | year_of_status==2010) & (roa_2008 < i_2008_france | roa_2009 < i_2009_france | roa_2010 < i_2010_france), d/*fixed threshold France*/
	scalar leverage_`j'_50_fr=r(p50)
	replace profitability_`j' = 1 if leverage_`j'>=leverage_`j'_50_fr & leverage_`j'!=. & iso=="FR" & roa_`j' < i_`j'_france & profit_ratio_`j'<1
	quietly	su leverage_2008 if iso=="PT" & (year_of_status==2009 | year_of_status==2010) & (roa_2008 < i_2008_portugal | roa_2009 < i_2009_portugal | roa_2010 < i_2010_portugal), d/*fixed threshold Portugal*/
	scalar leverage_`j'_50_pt=r(p50)
	replace profitability_`j' = 1 if leverage_`j'>=leverage_`j'_50_pt & leverage_`j'!=. & iso=="PT" & roa_`j' < i_`j'_portugal & profit_ratio_`j'<1
}

forval j = 2008/2016 { 	
	tab profitability_`j' iso, col
}

gen profitability=.
replace profitability = profitability_2016 if year_of_status==2017 | year_of_status==2018 
forval j = 2008/2015 { 
	replace profitability = profitability_`j' if year_of_status==(`j' + 1) 
}
count if profitability==.
tab profitability


********************************************************************************
*Introducing area (for Italy)
gen area="north" if region=="Lombardia" | region=="Friuli-Venezia Giulia" | region=="Liguria" | region=="Piemonte" | region=="Trentino-Alto Adige" | region=="Valle D'Aosta" | region=="Veneto" | region=="Emilia-Romagna"
replace area="center" if region=="Toscana"  | region=="Marche" | region=="Umbria" | region=="Lazio"
replace area="south" if region=="Abruzzo" | region=="Molise" | region=="Puglia" | region=="Basilicata" | region=="Calabria" | region=="Campania"
replace area="island" if region=="Sicilia" | region=="Sardegna"
encode area, gen(zone)

********************************************************************************
* Patent and Trademark Dummies

gen dummy_patents = .
replace dummy_patent = 1 if  Number_of_patents >0 & Number_of_patents !=.
replace dummy_patent = 0 if  Number_of_patents==0

gen dummy_trademark = .
replace dummy_trademark = 1 if  Number_of_trademarks>0 & Number_of_trademarks!=.
replace dummy_trademark = 0 if  Number_of_trademarks==0


*save working_data_2006.dta, replace

********************************************************************************
*                             TFP GENERATION
********************************************************************************

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
********************************************************************************
********************          GENERATE YEARLY DATA              ****************
********************************************************************************
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

*save data_24_07.dta, replace
