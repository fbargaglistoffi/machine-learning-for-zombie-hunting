********************************************************************************
*                          Generating Indicators                               *
********************************************************************************

* Capital Intensity
forval j = 2008/2016 { 
     gen capital_intensity_`j' = fixed_assets_`j'/employees_`j'
}

* Capital Intensity lagged values (2008-2016)
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

* Labor Productivity lagged values (2008-2016)
gen labour_product=.
replace labour_product= labour_product_2016 if year_of_status==2017 | year_of_status==2018 
forval j = 2008/2015 { 
     replace labour_product= labour_product_`j' if year_of_status==`j'+1 
}

********************************************************************************
* Financial Constraint indicator (Nickell & Nicolitsas, 1999)
forval j = 2008/2016 { 
    gen fin_cons_`j' =  (int_paid_`j')/(ebitda_`j') if ebitda_`j'!=. & int_paid_`j'!=.
	*replace fin_cons_`j'=1 if fin_cons_`j'<0 /*following N&N99 */
	*replace fin_cons_`j'=1 if fin_cons_`j'>1 & fin_cons_`j'!=. /* just for very small numbers */
	
}


* If you want to windsorize the data "uncomment" the chunk of code below

/* forval j = 2008/2016 { 
	quietly su fin_cons_`j', d 
	scalar fin_cons_`j'_1=r(p1)
	scalar fin_cons_`j'_99=r(p99)
	replace fin_cons_`j' = fin_cons_`j'_1 if fin_cons_`j'<= fin_cons_`j'_1 & fin_cons_`j'!=.
	replace fin_cons_`j' = fin_cons_`j'_99 if fin_cons_`j'>= fin_cons_`j'_99 & fin_cons_`j'!=.
	gen fin_cons100_`j'=fin_cons_`j'*100 /* to see the effect of 1 percentage increse */
} */

* Financial constraints lagged values (2008-2016)
gen fin_cons=.
replace fin_cons = fin_cons_2016 if (year_of_statu==2017 | year_of_status==2018) & ebitda_2016!=. & int_paid_2016!=./*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace fin_cons =  fin_cons_`j' if year_of_status==`j'+1 & ebitda_`j'!=. & int_paid_`j'!=.
}

*replace fin_cons=1 if fin_cons<0  /*following N&N99 */
*replace fin_cons=1 if fin_cons>1 & fin_cons!=. /* just 1.6% */ 
gen fin_cons100=fin_cons*100 /* to see the effect of 1 percentage increse */


********************************************************************************
* Investments
forval j = 2009/2016 { 
	local t = `j' - 1
     gen inv_`j' =  (fixed_assets_`j' - fixed_assets_`t' + depr`j')  if fixed_assets_`j'!=. & fixed_assets_`t'!=. & depr`j'!=. 
}

* Investments lagged values (2008-2016)
gen inv=.
replace inv= inv_2016 if (year_of_status==2017 | year_of_status==2018) & fixed_assets_2016!=. &  fixed_assets_2015!=. & depr2016!=./*just first 4 months of 2018*/
forval j = 2009/2015 { 
     replace inv= inv_`j' if year_of_status==`j'+1 & fixed_assets_`j'!=. &  fixed_assets_`j'-1!=. & depr`j'!=.
}


********************************************************************************
* Interest coverage ratio
* ICR=EBIT/Interest Expenses

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

* Generating Interest Coverage lagged values (2008-2016)
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
* Benchmark Interest Difference (prime rate / prime rate moving average)

* R_t = Short_term_loans_(t-1)* Prime_rate_(t-1) + Long_term_debt_(t-1) * Mov_Avg_5_years(Prime Rate)

* As we don't have data on prime rate, we use the "Long term government bond yields" EMU (Eurostat) as a proxy

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

* DIFF =  interest_paid - R
forval j = 2009/2016 { 
	gen DIFF_`j' = int_paid_`j' - R_`j' if int_paid_`j'!=. & R_`j'!=.
}

forval j = 2009/2016 { 
	gen interest_diff_`j' = cond(DIFF_`j' <0,0,1) if int_paid_`j'!=. & R_`j'!=.
}

* Interest difference lagged values (2008-2016)

gen interest_diff=.
replace interest_diff= cond(DIFF_2016 <0,0,1) if (year_of_status==2017 | year_of_status==2018) & DIFF_2016!=. 
forval j = 2009/2015 { 
	replace interest_diff = cond(DIFF_`j' <0,0,1) if year_of_status==(`j' + 1) & int_paid_`j'!=. & R_`j'!=.
}


********************************************************************************
* SIZE-AGE indicator

forval j = 2008/2016 { 
	gen real_SA_`j' = (-0.737*log(total_assets_`j')) + (0.043*log(total_assets_`j'))^2 - (0.040 * (time)) if year_of_status==`j'
	replace real_SA_`j' = (-0.737*log(total_assets_`j')) + (0.043*log(total_assets_`j'))^2 - (0.040 * (time - (year_of_status - `j'))) if year_of_status!=`j'
}


* Size-age indicator lagged values (2008-2016)

gen real_SA=. 
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
* Negative Value Added

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
* Z score Altman & Zingales
* Z SCORE for private firms Z′ = 0.717X1 + 0.847X2 + 3.107X3 + 0.420X4 + 0.998X5

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

********************************************************************************
* Misallocated Capital (Schivardi & Tabellini, 2017)

* ROA = Moving Average Ebitda (3 years) / Total Assets -> we don't do the moving average to keep the time series as wide as possible

forval j = 2008/2016 { 
	gen roa_`j' = (ebitda_`j')/(total_assets_`j') /* we don't have moving average for 2009 and 2010 */
    *gen roa_`j' = ((ebitda_`j' + ebitda_`j-1' + ebitda_`j-2')/3)/(total_assets_`j')
    *replace roa_`j'=0 if roa_`j'<=0 /* some negative values */
	*replace roa_`j'=0 if roa_`j'>1 & roa_`j'!=.
	
	/* If you want to windsorize the data "uncomment" the chunk of code below
	quietly su roa_`j', d 
	scalar roa_`j'_99=r(p99)
	scalar roa_`j'_1=r(p1)
	replace roa_`j'=roa_`j'_99 if roa_`j'>= roa_`j'_99 & roa_`j'!=.
	replace roa_`j'=roa_`j'_1 if roa_`j'<= roa_`j'_1 & roa_`j'!=.
	replace roa_`j'= roa_`j'*100 */
}

su roa_2016,d
_pctile roa_2016, nq(20)
return list


forval j = 2008/2016 { 
	gen leverage_`j' = fin_expenses_`j' /*long term debt for financial debt*/ / total_assets_`j'
	replace leverage_`j' = leverage_`j' * 100
}

su leverage_2008
_pctile leverage_2008, nq(20)
return list


* Misallocated Capital: ROA < PRIME RATE (Z-score 1/2) & Leverage > Median Leverage (2005)

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
* Profitability (Schivardi & Tabellini, 2017)

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
* Area (for Italy)
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

********************************************************************************
* Indicators from new Italian legislation on firms' failure

* 1. INDICE DI SOSTENIBILITÀ ONERI FINANZIARI: Financial expenses/Revenues

forval j = 2008/2016 { 
	gen financial_sustainability_`j' = fin_expenses_`j' / revenue`j'
}

* Lagged values (2008-2016)
gen financial_sustainability =.
replace financial_sustainability = financial_sustainability_2016 if year_of_status==2017 | year_of_status==2018 
forval j = 2008/2015 { 
	replace financial_sustainability = financial_sustainability_`j' if year_of_status==(`j' + 1) 
}

* 2. INDICE DI ADEGUATEZZA PATRIMONIALE: Equity/(Short-term debts + Long-term debts)

/* Download equity & short term debt */
forval j = 2008/2016 { 
	gen car_`j' = equity_`j' / (short_term_debt_`j' + long_term_debt) /* capital adeguacy index */
}

* Lagged values (2008-2016)
gen car =.
replace car = car_2016 if year_of_status==2017 | year_of_status==2018 
forval j = 2008/2015 { 
	replace car = car_`j' if year_of_status==(`j' + 1) 
}

* 3. INDICE DI RITORNO LIQUIDO DELL’ATTIVO: Cash flow/Total assets

forval j = 2008/2016 { 
	gen liquidity_return_`j' = cash_flow_`j' / total_assets_`j'
}

* Lagged values (2008-2016)
gen liquidity_return =.
replace liquidity_return = liquidity_return_2016 if year_of_status==2017 | year_of_status==2018 
forval j = 2008/2015 { 
	replace liquidity_return = liquidity_return_`j' if year_of_status==(`j' + 1) 
}


* 4. INDICE DI LIQUIDITÀ: liquidity_ratio is already in the data

* 5. INDICE DI INDEBITAMENTO PREVIDENZIALE E TRIBUTARIO: (Tax liabilities + Social securityliabilities)/Total assets


