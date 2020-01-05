********************************************************************************
*Productivity Decomposition

clear all 
cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data"
use zombie_indicator_by_country.dta, replace

* Zombie Dummies Generation

gen dummy_it_2011 = .
replace dummy_it_2011 = 1 if zombie_it_2011_2009!="." & drop_it_2010==3 & drop_it_2009==3 
replace dummy_it_2011 = 0 if zombie_it_2011_2009=="." & drop_it_2010==3 & drop_it_2009==3

gen dummy_it_2012 = .
replace dummy_it_2012 = 1 if zombie_it_2012_2010!="." & drop_it_2011==3 & drop_it_2010==3 
replace dummy_it_2012 = 0 if zombie_it_2012_2010=="." & drop_it_2011==3 & drop_it_2010==3

gen dummy_it_2013 = .
replace dummy_it_2013 = 1 if zombie_it_2013_2011!="." & drop_it_2012==3 & drop_it_2011==3 
replace dummy_it_2013 = 0 if zombie_it_2013_2011=="." & drop_it_2012==3 & drop_it_2011==3

gen dummy_it_2014 = .
replace dummy_it_2014 = 1 if zombie_it_2014_2012!="." & drop_it_2013==3 & drop_it_2012==3 
replace dummy_it_2014 = 0 if zombie_it_2014_2012=="." & drop_it_2013==3 & drop_it_2012==3

gen dummy_it_2015 = .
replace dummy_it_2015 = 1 if zombie_it_2015_2013!="." & drop_it_2014==3 & drop_it_2013==3 
replace dummy_it_2015 = 0 if zombie_it_2015_2013=="." & drop_it_2014==3 & drop_it_2013==3

gen dummy_it_2016 = .
replace dummy_it_2016 = 1 if zombie_it_2016_2014!="." & drop_it_2014==3 & drop_it_2015==3 
replace dummy_it_2016 = 0 if zombie_it_2016_2014=="." & drop_it_2014==3 & drop_it_2015==3 

* ICR & ZOMBIE OVERLAP
count if ICR_failure_2014 == 1 & dummy_it_2014 == 1
count if dummy_it_2014 == 1

*Market Shares

forval i = 2011/2016 {
	egen sum_rev_it_`i' = sum(revenue`i') if iso == "IT" & revenue`i'!=.
	egen sum_rev_es_`i' = sum(revenue`i') if iso == "ES" & revenue`i'!=.
	egen sum_rev_pt_`i' = sum(revenue`i') if iso == "PT" & revenue`i'!=.
	egen sum_rev_fr_`i' = sum(revenue`i') if iso == "FR" & revenue`i'!=.
	gen market_share_it_`i' = revenue`i' / sum_rev_it_`i' if  iso == "IT" & revenue`i'!=.
	gen market_share_es_`i' = revenue`i' / sum_rev_es_`i' if  iso == "ES" & revenue`i'!=.
	gen market_share_pt_`i' = revenue`i' / sum_rev_pt_`i' if  iso == "PT" & revenue`i'!=.
	gen market_share_fr_`i' = revenue`i' / sum_rev_fr_`i' if  iso == "FR" & revenue`i'!=.
}


*PRODUCTIVITY DECOMPOSITIONS (2015)

*baily et al. (1992) decomposition Italy
forval i = 2011/2015{
	local j = `i' + 1 
	
	gen factor_1_`i' = (market_share_it_`i')*(tfp_acf_`j'-tfp_acf_`i') if iso=="IT" & dummy_it_`i'!=.
	egen sum_factor_1_`i' = sum(factor_1_`i') if factor_1_`i'!=. & ICR_failure_`i'!=.

	gen factor_2_`i' = (market_share_it_`j' - market_share_it_`i')*tfp_acf_`j' if iso=="IT" ///
	& (year_of_status!=`i' | year_of_status!=`j') & tfp_acf_`j'!=. & tfp_acf_`i'!=. & dummy_it_`i'!=.
	egen sum_factor_2_`i' = sum(factor_2_`i') if factor_2_`i'!=. & ICR_failure_`i'!=.

	gen factor_3_`i' = market_share_it_`j'*tfp_acf_`j' if iso=="IT" & year_of_incorporation==`j' ///
	& ICR_failure_`i'!=.
	egen sum_factor_3_`i' = sum(factor_3_`i')

	gen factor_4_`i' = market_share_it_`i'*tfp_acf_`i'  if iso=="IT" & year_of_status==`i' ///
	& ICR_failure_`i'!=.
	egen sum_factor_4_`i' = sum(factor_4_`i')

	gen baily_it_`i' = sum_factor_1_`i' + sum_factor_2_`i' + sum_factor_3_`i' - sum_factor_4_`i'
}

*Baily without Zombies

forval i = 2011/2015{
	local j = `i' + 1
	
	gen factor_z_1_`i' = (market_share_it_`i') * (tfp_acf_`j' - tfp_acf_`i') if iso=="IT" ///
	& dummy_it_`i'==0 & ICR_failure_`i'!=.
	egen sum_factor_z_1_`i' = sum(factor_z_1_`i')  if factor_z_1_`i'!=.

	gen factor_z_2_`i' = (market_share_it_`j' - market_share_it_`i')*tfp_acf_`j' if iso=="IT" ///
	& (year_of_status!=`i' | year_of_status!=`j') & dummy_it_`i'==0  & tfp_acf_`j'!=. & tfp_acf_`i'!=. ///
	& ICR_failure_`i'!=.
	egen sum_factor_z_2_`i' = sum(factor_z_2_`i') if factor_z_2_`i'!=.

	gen factor_z_3_`i' = market_share_it_`j'*tfp_acf_`j' if iso=="IT" & year_of_incorporation==`j' ///
	& ICR_failure_`i'!=.
	egen sum_factor_z_3_`i' = sum(factor_z_3_`i')

	gen factor_z_4_`i' = market_share_it_`i'*tfp_acf_`i'  if iso=="IT" & year_of_status==`i' ///
	& ICR_failure_`i'!=.
	egen sum_factor_z_4_`i' = sum(factor_z_4_`i') 

	gen factor_z_5_`i' = (market_share_it_`i') * (tfp_acf_`j' - tfp_acf_`i') if iso=="IT" ///
	& dummy_it_`i'==1 & ICR_failure_`i'!=. 
	egen sum_factor_z_5_`i' = sum(factor_z_5_`i') 

	gen factor_z_6_`i' = (market_share_it_`j' - market_share_it_`i')*tfp_acf_`j' if iso=="IT" ///
	& (year_of_status!=`i' | year_of_status!=`j') & dummy_it_`i'==1  & tfp_acf_`j'!=. & tfp_acf_`i'!=. ///
	& ICR_failure_`i'!=.
	egen sum_factor_z_6_`i' = sum(factor_z_6_`i')

	gen baily_z_it_`i' = sum_factor_z_1_`i' + sum_factor_z_2_`i' + sum_factor_z_3_`i' - sum_factor_z_4_`i' + sum_factor_z_5_`i' + sum_factor_z_6_`i'
}

*Baily without ICR

forval i = 2011/2015{
	local j = `i' + 1
	
	gen factor_icr_1_`i' = (market_share_it_`i') * (tfp_acf_`j' - tfp_acf_`i') if iso=="IT" ///
	& ICR_failure_`i'==0 & ICR_failure_`i'!=.
	egen sum_factor_icr_1_`i' = sum(factor_icr_1_`i')  if factor_icr_1_`i'!=.

	gen factor_icr_2_`i' = (market_share_it_`j' - market_share_it_`i')*tfp_acf_`j' if iso=="IT" ///
	& (year_of_status!=`i' | year_of_status!=`j') & ICR_failure_`i'==0  & tfp_acf_`j'!=. & tfp_acf_`i'!=. ///
	& ICR_failure_`i'!=.
	egen sum_factor_icr_2_`i' = sum(factor_icr_2_`i') if factor_icr_2_`i'!=.

	gen factor_icr_3_`i' = market_share_it_`j'*tfp_acf_`j' if iso=="IT" & year_of_incorporation==`j' ///
	& ICR_failure_`i'!=.
	egen sum_factor_icr_3_`i' = sum(factor_icr_3_`i')

	gen factor_icr_4_`i' = market_share_it_`i'*tfp_acf_`i'  if iso=="IT" & year_of_status==`i' ///
	& ICR_failure_`i'!=.
	egen sum_factor_icr_4_`i' = sum(factor_icr_4_`i') 

	gen factor_icr_5_`i' = (market_share_it_`i') * (tfp_acf_`j' - tfp_acf_`i') if iso=="IT" ///
	& ICR_failure_`i'==1  & ICR_failure_`i'!=.
	egen sum_factor_icr_5_`i' = sum(factor_icr_5_`i') 

	gen factor_icr_6_`i' = (market_share_it_`j' - market_share_it_`i')*tfp_acf_`j' if iso=="IT" ///
	& (year_of_status!=`i' | year_of_status!=`j') & ICR_failure_`i'==1  & tfp_acf_`j'!=. & tfp_acf_`i'!=. ///
	& ICR_failure_`i'!=.
	egen sum_factor_icr_6_`i' = sum(factor_icr_6_`i')

	gen baily_icr_it_`i' = sum_factor_icr_1_`i' + sum_factor_icr_2_`i' + sum_factor_icr_3_`i' - sum_factor_icr_4_`i' + sum_factor_icr_5_`i' + sum_factor_icr_6_`i'
}

forval i = 2011/2015{
	su baily_it_`i'
	su baily_icr_it_`i'
	su baily_z_it_`i'
}

forval i = 2011/2015{
	egen mean_baily_it_`i' = mean(baily_it_`i') 
	egen sum_employees_it_`i' = sum(employees_`i') if baily_it_`i'!=.
	gen weighted_`i' = 0.5*mean_baily_it_`i' + 0.5*sum_employees_it_`i' * 0.000001
	egen mean_baily_icr_it_`i' = mean(baily_icr_it_`i') 
	egen sum_employees_icr_it_`i' = sum(employees_`i') if baily_icr_it_`i'!=.
	gen weighted_icr_`i' = 0.5*mean_baily_icr_it_`i' + 0.5*sum_employees_icr_it_`i' * 0.000001
	egen mean_baily_z_it_`i' = mean(baily_z_it_`i') 
	egen sum_employees_z_it_`i' = sum(employees_`i') if baily_z_it_`i'!=.
	gen weighted_z_`i' = 0.5*mean_baily_z_it_`i' + 0.5*sum_employees_z_it_`i' * 0.000001
}
drop sum_employees_*
drop mean_baily_*
drop weighted_*


forval i = 2011/2015{
		su weighted_`i'
		su weighted_icr_`i'
		su weighted_z_`i'
}

forval i = 2011/2015{
	su sum_factor_1_`i'
	su sum_factor_icr_1_`i'
	su sum_factor_z_`i'
}

forval i = 2011/2015{
	su sum_factor_2_`i'
	su sum_factor_icr_2_`i'
	su sum_factor_z_2_`i'
}

forval i = 2011/2015{
	su sum_factor_icr_5_`i'
	su sum_factor_icr_6_`i'
}

drop factor_*
drop sum_factor_*
drop baily_it_*
drop baily_z_it_*
drop baily_icr_it_*




