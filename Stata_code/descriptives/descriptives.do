*Descriptive Analysis

clear all
cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data" /*change path accordingly*/

use data_zombie_complete.dta, clear



* Country 

encode Country_ISO_Code, gen(Country)

count if Country_ISO_Code=="FR" | Country_ISO_Code=="DE" | Country_ISO_Code=="ES" | Country_ISO_Code=="IT"
di 597135/803277

catplot Country_ISO 

*graph export "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data\Images\Hist_by_country.png", as(png) replace

* Industry

destring NACE_Rev__2_Core_code__4_digits_, replace
gen nace2digits=NACE_Rev__2_Core_code__4_digits_/100
replace  nace2digits=floor(nace2digits)
label values nace2digits nace

latab nace2digits Country 


catplot nace2digits


*graph export "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data\Images\Hist_by_nace.png", as(png) replace



* Size  
gen size="."
replace size="micro" if Number_of_employees_2014<10
replace size="small" if Number_of_employees_2014>=10 & Number_of_employees_2014<50
replace size="medium" if Number_of_employees_2014>=50 & Number_of_employees_2014<250
replace size="large" if Number_of_employees_2014>=250 
replace size="." if Number_of_employees_2014==.

tab size if size!="."
catplot size if size!=".", sort(size)
graph bar size

*Cumulative (after a first cleaning)

di 697198*(.6860 + .7166 + .7514 + .7863 + .8280 + .8731 + .9197 + .9635 + .9989)

/* Born in year
       2008 |     22,575        3.24       68.60
       2009 |     21,324        3.06       71.66
       2010 |     24,275        3.48       75.14
       2011 |     24,345        3.49       78.63
       2012 |     29,048        4.17       82.80
       2013 |     31,451        4.51       87.31
       2014 |     32,467        4.66       91.97
       2015 |     30,570        4.38       96.35
       2016 |     24,679        3.54       99.89
       2017 |        711        0.10       99.99
       2018 |         47        0.01      100.00 */


/*  Died in |      Freq.     Percent        Cum.
------------+-----------------------------------
       2008 |        198        0.03        0.03
       2009 |        261        0.04        0.07
       2010 |        361        0.05        0.12
       2011 |        449        0.06        0.18
       2012 |        460        0.07        0.25
       2013 |        723        0.10        0.35
       2014 |        964        0.14        0.49
       2015 |      4,523        0.65        1.14
       2016 |      8,641        1.24        2.38
       2017 |     10,940        1.57        3.95
       2018 |    669,656       96.05      100.00
------------+-----------------------------------
      Total |    697,176      100.00
*/
count if failure==1 & yr_d!=.
di 5245369 - 30611

********************************************************************************
**********                       General Descriptives                ***********
********************************************************************************

use data_24_07.dta, clear

tab Status iso

estpost tab failure iso
esttab using foo.tex, replace cells("b") unstack noobs


forval j = 2009/2017 {
	count if iso=="ES" & failure_`j'==0
} /* 250218 */ 

forval j = 2009/2017 {
	count if iso=="IT" & failure_`j'==0
} /* 1208309 */

forval j = 2009/2017 {
	count if iso=="FR" & failure_`j'==0
} /* 607762 */

forval j = 2009/2017 {
	count if iso=="PT" & failure_`j'==0
} /* 309,875 */

tab failure iso, col
estpost tabulate failure iso

esttab using esttab-failure-iso.tex, booktabs replace ///
	unstack nonote noobs nonumber ///
	eqlabels(, lhs("`rowvar_label'")) ///
	nomtitles ///
	mgroups("`colvar_label'", pattern(1 0 0)    ///
        prefix(\multicolumn{@span}{c}{) suffix(})   ///
        span erepeat(\cmidrule(lr){@span}))


egen fail = group(failure), label

tab Status

local colvar_label : variable label Status
estpost tabulate Status

esttab using esttab-example.tex, booktabs ///
	cell("b rowpct(fmt(2))") collabels("N" "Row Pct") ///
	unstack nonote noobs nonumber ///
	eqlabels(, lhs("`rowvar_label'")) ///
	nomtitles ///
	mgroups("`colvar_label'", pattern(1 0 0)    ///
        prefix(\multicolumn{@span}{c}{) suffix(})   ///
        span erepeat(\cmidrule(lr){@span}))

  

*On year before failure or censore
estpost su ICR_failure NEG_VA  interest_diff profitability  misallocated_fixed if iso=="IT"
est store A

estpost su ICR_failure NEG_VA  interest_diff profitability  misallocated_fixed if iso=="ES"
est store B

estpost su ICR_failure NEG_VA  interest_diff profitability  misallocated_fixed if iso=="PT"
est store C

estpost su ICR_failure NEG_VA  interest_diff profitability  misallocated_fixed if iso=="FR"
est store D


esttab A B C D using table2.tex, replace ///
mtitle("Italy" "Spain" "Portugal" "France") ///
cells(ean(fmt(2)) sd(fmt(2)))  label booktabs 


*Summaries Year by Year
*Profitability
preserve
keep id iso profitability_2008 profitability_2009 profitability_2010 profitability_2011 profitability_2012 profitability_2013 profitability_2014 profitability_2015 profitability_2016
reshape long profitability_ , i(id) j(year)
egen mean_profitability = mean(profitability_), by(year iso) 
xtline mean_profitability, t(year) i(iso) ytitle("Low Profitability Zombies") overlay
restore

*Interest Coverage Ratio
preserve
keep id iso ICR_failure_2008 ICR_failure_2009 ICR_failure_2010 ICR_failure_2011 ICR_failure_2012 ICR_failure_2013 ICR_failure_2014 ICR_failure_2015 ICR_failure_2016
reshape long ICR_failure_ , i(id) j(year)
egen mean_ICR_failure = mean(ICR_failure_), by(year iso) 
xtline mean_ICR_failure, t(year) i(iso) ytitle("Interest Coverage Ratio Zombies") overlay
restore

*Negative Added Value
preserve
keep id iso NEG_VA_2008 NEG_VA_2009 NEG_VA_2010 NEG_VA_2011 NEG_VA_2012 NEG_VA_2013 NEG_VA_2014 NEG_VA_2015 NEG_VA_2016
reshape long NEG_VA_ , i(id) j(year)
egen mean_NEG_VA = mean(NEG_VA_), by(year iso) 
xtline mean_NEG_VA, t(year) i(iso) ytitle("Negative Added Value Zombies") overlay
restore

*Interest Diff
preserve
keep id iso interest_diff_2009 interest_diff_2010 interest_diff_2011 interest_diff_2012 interest_diff_2013 interest_diff_2014 interest_diff_2015 interest_diff_2016
reshape long interest_diff_ , i(id) j(year)
egen mean_interest_diff = mean(interest_diff_), by(year iso) 
xtline mean_interest_diff, t(year) i(iso) ytitle("Interest Benchmark Difference Zombies") overlay
restore

*Missallocated
rename misallocated_*_fixed misallocated_*

preserve
keep id iso misallocated_2008 misallocated_2009 misallocated_2010 misallocated_2011 misallocated_2012 misallocated_2013 misallocated_2014 misallocated_2015 misallocated_2016
reshape long misallocated_ , i(id) j(year)
egen mean_misallocated = mean(misallocated_), by(year iso) 
xtline mean_misallocated, t(year) i(iso) ytitle("Misallocation of Capital Zombies") overlay
restore

*TFP
preserve
keep id iso tfp_acf_10* tfp_acf_11* tfp_acf_12* tfp_acf_13* tfp_acf_14* tfp_acf_15* tfp_acf_16* tfp_acf_17* tfp_acf_18* tfp_acf_19* tfp_acf_20* tfp_acf_21* tfp_acf_22* tfp_acf_23* tfp_acf_24* tfp_acf_25* tfp_acf_26* tfp_acf_27* tfp_acf_28* tfp_acf_29* tfp_acf_30* tfp_acf_31* tfp_acf_32* tfp_acf_33*
forval j = 2008/2016 {
	egen tfp_acf_`j' = rowtotal(tfp_acf_10`j' tfp_acf_11`j' tfp_acf_12`j' tfp_acf_13`j' tfp_acf_14`j' tfp_acf_15`j' tfp_acf_16`j' tfp_acf_17`j' tfp_acf_18`j' tfp_acf_19`j' tfp_acf_20`j' tfp_acf_21`j' tfp_acf_22`j' tfp_acf_23`j' tfp_acf_24`j' tfp_acf_25`j' tfp_acf_26`j' tfp_acf_27`j' tfp_acf_28`j' tfp_acf_29`j' tfp_acf_30`j' tfp_acf_31`j' tfp_acf_32`j' tfp_acf_33`j')
	replace tfp_acf_`j' = . if tfp_acf_`j'==0
	egen tot_acf_it_`j'= sum(tfp_acf_`j') if iso=="IT"
	egen tot_acf_es_`j'= sum(tfp_acf_`j') if iso=="ES"
	egen tot_acf_fr_`j'= sum(tfp_acf_`j') if iso=="FR"
	egen tot_acf_pt_`j'= sum(tfp_acf_`j') if iso=="PT"
	gen share_acf_it_`j'= tfp_acf_`j'/ tot_acf_it_`j' if iso=="IT"
	gen share_acf_es_`j'= tfp_acf_`j'/ tot_acf_es_`j' if iso=="ES"
	gen share_acf_fr_`j'= tfp_acf_`j'/ tot_acf_fr_`j' if iso=="FR"
	gen share_acf_pt_`j'= tfp_acf_`j'/ tot_acf_pt_`j' if iso=="PT"
} 

kdensity tfp_acf

keep id iso share_acf_pt_2008 share_acf_pt_2009 share_acf_pt_2010 share_acf_pt_2011 share_acf_pt_2012 share_acf_pt_2013 share_acf_pt_2014 share_acf_pt_2015 share_acf_pt_2016 share_acf_es_2008 share_acf_es_2009 share_acf_es_2010 share_acf_es_2011 share_acf_es_2012 share_acf_es_2013 share_acf_es_2014 share_acf_es_2015 share_acf_es_2016 share_acf_fr_2008 share_acf_fr_2009 share_acf_fr_2010 share_acf_fr_2011 share_acf_fr_2012 share_acf_fr_2013 share_acf_fr_2014 share_acf_fr_2015 share_acf_fr_2016 share_acf_it_2008 share_acf_it_2009 share_acf_it_2010 share_acf_it_2011 share_acf_it_2012 share_acf_it_2013 share_acf_it_2014 share_acf_it_2015 share_acf_it_2016 tfp_acf_2008 tfp_acf_2009 tfp_acf_2010 tfp_acf_2011 tfp_acf_2012 tfp_acf_2013 tfp_acf_2014 tfp_acf_2015 tfp_acf_2016
reshape long share_acf_it_ share_acf_es_ share_acf_fr_ share_acf_pt_ tfp_acf_ , i(id) j(year)

egen mean_tfp_acf = mean(tfp_acf_), by(year iso)
egen mean_tfp_acf_it = mean(tfp_acf_ * share_acf_it_ ), by(year iso) 
egen mean_tfp_acf_es = mean(tfp_acf_ * share_acf_es_ ), by(year iso) 
egen mean_tfp_acf_fr = mean(tfp_acf_ * share_acf_fr_ ), by(year iso) 
egen mean_tfp_acf_pt = mean(tfp_acf_ * share_acf_pt_ ), by(year iso) 

*sparkline mean_tfp_acf_it mean_tfp_acf_es mean_tfp_acf_fr mean_tfp_acf_pt year
tsline mean_tfp_acf_it mean_tfp_acf_es mean_tfp_acf_fr mean_tfp_acf_pt
xtline share_mean_acf, t(year) i(iso) ytitle("ACF Total Factor Productivity") overlay
restore

*Liquidity
preserve
keep id iso liquidity_ratio_2008 liquidity_ratio_2009 liquidity_ratio_2010 liquidity_ratio_2011 liquidity_ratio_2012 liquidity_ratio_2013 liquidity_ratio_2014 liquidity_ratio_2015 liquidity_ratio_2016
reshape long liquidity_ratio_ , i(id) j(year)
egen mean_liquidity_ratio = mean(liquidity_ratio_), by(year iso) 
xtline mean_liquidity_ratio, t(year) i(iso) ytitle("Liquidity Ratio") overlay
restore

*Solvency
preserve
keep id iso solvency_ratio_2008 solvency_ratio_2009 solvency_ratio_2010 solvency_ratio_2011 solvency_ratio_2012 solvency_ratio_2013 solvency_ratio_2014 solvency_ratio_2015 solvency_ratio_2016
reshape long solvency_ratio_ , i(id) j(year)
egen mean_solvency_ratio = mean(solvency_ratio_), by(year iso) 
xtline mean_solvency_ratio, t(year) i(iso) ytitle("Solvency Ratio") overlay
restore

*Kernel Density
use data_24_07.dta, replace

*TFP
forval j = 2008/2016 {
	egen tfp_acf_`j' = rowtotal(tfp_acf_10`j' tfp_acf_11`j' tfp_acf_12`j' tfp_acf_13`j' tfp_acf_14`j' tfp_acf_15`j' tfp_acf_16`j' tfp_acf_17`j' tfp_acf_18`j' tfp_acf_19`j' tfp_acf_20`j' tfp_acf_21`j' tfp_acf_22`j' tfp_acf_23`j' tfp_acf_24`j' tfp_acf_25`j' tfp_acf_26`j' tfp_acf_27`j' tfp_acf_28`j' tfp_acf_29`j' tfp_acf_30`j' tfp_acf_31`j' tfp_acf_32`j' tfp_acf_33`j')
} 

gen log_acf_2014 = log(tfp_acf_2014)

sum log_acf_2014 if iso=="IT", meanonly
twoway histogram log_acf_2014 || kdensity log_acf_2014 if iso=="IT", name(g1, replace) xline(`r(mean)') col(blue) title("Italy")
sum log_acf_2014 if iso=="ES", meanonly
twoway histogram log_acf_2014 || kdensity log_acf_2014 if iso=="ES", name(g2, replace) xline(`r(mean)') col(blue) title("Spain")
sum log_acf_2014 if iso=="PT", meanonly
twoway histogram log_acf_2014 || kdensity log_acf_2014 if iso=="PT", name(g3, replace) xline(`r(mean)') col(blue) title("Portugal")
sum log_acf_2014 if iso=="FR", meanonly
twoway histogram log_acf_2014 || kdensity log_acf_2014 if iso=="FR", name(g4, replace) xline(`r(mean)') col(blue) title("France")

graph combine g1 g2 g3 g4, ycommon name(combined, replace)

sum tfp_acf_2014 if iso=="IT", meanonly
twoway histogram tfp_acf_2014 || kdensity tfp_acf_2014 if iso=="IT", name(g1, replace) col(blue) title("Italy")
sum tfp_acf_2014 if iso=="ES", meanonly
twoway histogram tfp_acf_2014 || kdensity tfp_acf_2014 if iso=="ES", name(g2, replace) col(blue) title("Spain")
sum tfp_acf_2014 if iso=="PT", meanonly
twoway histogram tfp_acf_2014 || kdensity tfp_acf_2014 if iso=="PT", name(g3, replace)  col(blue) title("Portugal")
sum tfp_acf_2014 if iso=="FR", meanonly
twoway histogram tfp_acf_2014 || kdensity tfp_acf_2014 if iso=="FR", name(g4, replace)  col(blue) title("France")

graph combine g1 g2 g3 g4, ycommon name(combined, replace)

*NACE

twoway histogram nace_2, col(blue) xlabel(10[1]33) title("Firms by Sector") xtitle("Nace 2") 

twoway histogram nace_2 if iso=="IT", xscale(range(10(1)33)) xtitle("Nace 2 Digits") xlabel(10[1]33) name(g1, replace)  title("Italy")  
twoway histogram nace_2 if iso=="ES", name(g2, replace) xlabel(10[1]33) title("Spain") xtitle("Nace 2 Digits") 
twoway histogram nace_2 if iso=="PT", name(g3, replace) xlabel(10[1]33) title("Portugal") xtitle("Nace 2 Digits") 
twoway histogram nace_2 if iso=="FR", name(g4, replace) xlabel(10[1]33) title("France") xtitle("Nace 2 Digits") 

graph combine g1 g2 g3 g4, ycommon name(combined, replace)

*CORRELATIONS
corr(fin_rev_2016 int_paid_2016 cash_flow_2016 ebitda_2016 depr2016 revenue2016 total_assets_2016 long_term_debt_2016 employees_2016 added_value_2016 materials_2016 wage_bill_2016 loans_2016 fixed_assets_2016 int_fixed_assets_2016 tax_2016 net_income_2016 retained_earnings_2016 firm_value_2016 current_liabilities_2016 liquidity_ratio_2016 solvency_ratio_2016 current_assets_2016 Number_of_patents Number_of_trademarks fin_expenses_2016 shareholders_funds_2016 fin_cons_2016 fin_cons100_2016 inv_2016 ICR_failure_2016 interest_diff_2016 real_SA_2016 NEG_VA_2016 roa_2016 leverage_2016 misallocated_2016 tfp_acf_2016 profitability_2016)

corr(Number_of_patents Number_of_trademarks  fin_cons100_2016 inv_2016 ICR_failure_2016 interest_diff_2016 real_SA_2016 NEG_VA_2016 roa_2016 leverage_2016 misallocated_2016 tfp_acf_2016 profitability_2016)


*Correlations with significance

pwcorr fin_rev_2016 int_paid_2016 cash_flow_2016 ebitda_2016 depr2016 revenue2016 total_assets_2016 long_term_debt_2016 employees_2016 added_value_2016 materials_2016 wage_bill_2016 loans_2016 fixed_assets_2016 int_fixed_assets_2016 tax_2016 net_income_2016 retained_earnings_2016 firm_value_2016 current_liabilities_2016 liquidity_ratio_2016 solvency_ratio_2016 current_assets_2016 Number_of_patents Number_of_trademarks fin_expenses_2016 shareholders_funds_2016 fin_cons_2016 fin_cons100_2016 inv_2016 ICR_failure_2016 interest_diff_2016 real_SA_2016 NEG_VA_2016 roa_2016 leverage_2016 misallocated_2016 tfp_acf_2016 profitability_2016, sig star(.01)

pwcorr fin_cons100_2016 inv_2016 ICR_failure_2016 interest_diff_2016 real_SA_2016 NEG_VA_2016 roa_2016 leverage_2016 misallocated_2016 tfp_acf_2016 profitability_2016, sig star(.001)
