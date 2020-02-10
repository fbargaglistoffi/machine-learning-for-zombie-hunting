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

gen dummy_fr_2016 = .
replace dummy_fr_2016 = 1 if zombie_fr_2016_2014!="." & drop_fr_2014==3 & drop_fr_2015==3 
replace dummy_fr_2016 = 0 if zombie_fr_2016_2014=="." & drop_fr_2014==3 & drop_fr_2015==3

gen dummy_es_2016 = .
replace dummy_es_2016 = 1 if zombie_es_2016_2014!="." & drop_es_2014==3 & drop_es_2015==3 
replace dummy_es_2016 = 0 if zombie_es_2016_2014=="." & drop_es_2014==3 & drop_es_2015==3

gen dummy_pt_2016 = .
replace dummy_pt_2016 = 1 if zombie_pt_2016_2014!="." & drop_pt_2014==3 & drop_pt_2015==3 
replace dummy_pt_2016 = 0 if zombie_pt_2016_2014=="." & drop_pt_2014==3 & drop_pt_2015==3

gen dummy_it_2017 = .
replace dummy_it_2017 = 1 if zombie_it_2017_2015!="." & drop_it_2015==3 & drop_it_2016==3 
replace dummy_it_2017 = 0 if zombie_it_2017_2015=="." & drop_it_2015==3 & drop_it_2016==3 

gen dummy_fr_2017 = .
replace dummy_fr_2017 = 1 if zombie_fr_2017_2015!="." & drop_fr_2015==3 & drop_fr_2016==3 
replace dummy_fr_2017 = 0 if zombie_fr_2017_2015=="." & drop_fr_2015==3 & drop_fr_2016==3

gen dummy_es_2017 = .
replace dummy_es_2017 = 1 if zombie_es_2017_2015!="." & drop_es_2015==3 & drop_es_2016==3 
replace dummy_es_2017 = 0 if zombie_es_2017_2015=="." & drop_es_2015==3 & drop_es_2016==3

gen dummy_pt_2017 = .
replace dummy_pt_2017 = 1 if zombie_pt_2017_2015!="." & drop_pt_2015==3 & drop_pt_2016==3 
replace dummy_pt_2017 = 0 if zombie_pt_2017_2015=="." & drop_pt_2015==3 & drop_pt_2016==3

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

*Descriptives
*Productivity Twoway

*2016
kdensity tfp_acf_2016, addplot(kdensity tfp_acf_2016 if dummy_it_2016==0 || ///
kdensity tfp_acf_2016 if dummy_it_2016==1) legend(ring(0) pos(2) label(1 "Total") label(2 "Not Zombies") label(3 "Zombies")) name(g1, replace) title("Italy")
kdensity tfp_acf_2016, addplot(kdensity tfp_acf_2016 if dummy_es_2016==0 || ///
kdensity tfp_acf_2016 if dummy_es_2016==1) legend(ring(0) pos(2) label(1 "Total") label(2 "Not Zombies") label(3 "Zombies")) name(g2, replace) title("Spain")
kdensity tfp_acf_2016, addplot(kdensity tfp_acf_2016 if dummy_pt_2016==0 || ///
kdensity tfp_acf_2016 if dummy_pt_2016==1) legend(ring(0) pos(2) label(1 "Total") label(2 "Not Zombies") label(3 "Zombies")) name(g3, replace) title("Portugal")
kdensity tfp_acf_2016, addplot(kdensity tfp_acf_2016 if dummy_fr_2016==0 || ///
kdensity tfp_acf_2016 if dummy_fr_2016==1) legend(ring(0) pos(2) label(1 "Total") label(2 "Not Zombies") label(3 "Zombies")) name(g4, replace) title("France")
graph combine g1 g2 g3 g4, ycommon name(combined, replace)

*Kdensity without total
kdensity tfp_acf_2016 if dummy_it_2016==1, addplot(kdensity tfp_acf_2016 if dummy_it_2016==0)  ///
legend(ring(0) pos(1) label(1 "Zombies") label(2 "Not Zombies")) name(g1, replace) title("Italy")
kdensity tfp_acf_2016 if dummy_es_2016==1, addplot(kdensity tfp_acf_2016 if dummy_es_2016==0)  ///
legend(ring(0) pos(2) label(1 "Zombies") label(2 "Not Zombies"))  name(g2, replace) title("Spain")
kdensity tfp_acf_2016 if dummy_pt_2016==1, addplot(kdensity tfp_acf_2016 if dummy_pt_2016==0)  ///
legend(ring(0) pos(2) label(1 "Zombies") label(2 "Not Zombies"))  name(g3, replace) title("Portugal")
kdensity tfp_acf_2016 if dummy_fr_2016==1, addplot(kdensity tfp_acf_2016 if dummy_fr_2016==0)  ///
legend(ring(0) pos(2) label(1 "Zombies") label(2 "Not Zombies"))  name(g4, replace) title("France")

graph combine g1 g2 g3 g4, ycommon name(combined, replace)

*2015
kdensity tfp_acf_2015, addplot(kdensity tfp_acf_2015 if dummy_it_2015==0 || ///
kdensity tfp_acf_2015 if dummy_it_2015==1) legend(ring(0) pos(2) label(1 "Total") label(2 "Not Zombies") label(3 "Zombies")) name(g1, replace) title("Italy")

ttest tfp_acf_2015, by(dummy_it_2015)

gen delta = tfp_acf_2016 - tfp_acf_2015 if tfp_acf_2016!=. & tfp_acf_2015!=.
kdensity delta, addplot(kdensity delta if dummy_it_2015==0 || kdensity delta if dummy_it_2015==1) legend(ring(0) pos(2) label(1 "Total") label(2 "Not Zombies") label(3 "Zombies")) 
kdensity delta if dummy_it_2015==0, addplot(kdensity delta if dummy_it_2015==1) legend(ring(0) pos(2) label(1 "Not Zombies") label(2 "Zombies") ) 
ttest delta, by(dummy_it_2015)


*Market Share Twoway
kdensity market_share_it_2015 if dummy_it_2015==0, addplot(kdensity market_share_it_2015 if dummy_it_2015==1) legend(ring(0) pos(2) label(1 "Not Zombies") label(2 "Zombies") ) 
ttest market_share_it_2015, by(dummy_it_2015)


*PRODUCTIVITY DECOMPOSITIONS (2015)

*baily et al. (1992) decomposition Italy

forval i = 2011/2015{
	local j = `i' + 1 
	
	gen factor_1_`i' = (market_share_it_`i')*(tfp_acf_`j'-tfp_acf_`i') if iso=="IT" & dummy_it_`i'!=.
	egen sum_factor_1_`i' = sum(factor_1_`i') if factor_1_`i'!=.

	gen factor_2_`i' = (market_share_it_`j' - market_share_it_`i')*tfp_acf_`j' if iso=="IT" ///
	& (year_of_status!=`i' | year_of_status!=`j') & tfp_acf_`j'!=. & tfp_acf_`i'!=. & dummy_it_`i'!=.
	egen sum_factor_2_`i' = sum(factor_2_`i') if factor_2_`i'!=.

	gen factor_3_`i' = market_share_it_`j'*tfp_acf_`j' if iso=="IT" & year_of_incorporation==`j' 
	egen sum_factor_3_`i' = sum(factor_3_`i')

	gen factor_4_`i' = market_share_it_`i'*tfp_acf_`i'  if iso=="IT" & year_of_status==`i'
	egen sum_factor_4_`i' = sum(factor_4_`i')

	gen baily_it_`i' = sum_factor_1_`i' + sum_factor_2_`i' + sum_factor_3_`i' - sum_factor_4_`i'
}

*Baily without Zombies

forval i = 2011/2015{
	local j = `i' + 1
	
	gen factor_z_1_`i' = (market_share_it_`i') * (tfp_acf_`j' - tfp_acf_`i') if iso=="IT" ///
	& dummy_it_`i'==0 
	egen sum_factor_z_1_`i' = sum(factor_z_1_`i')  if factor_z_1_`i'!=.

	gen factor_z_2_`i' = (market_share_it_`j' - market_share_it_`i')*tfp_acf_`j' if iso=="IT" ///
	& (year_of_status!=`i' | year_of_status!=`j') & dummy_it_`i'==0  & tfp_acf_`j'!=. & tfp_acf_`i'!=.
	egen sum_factor_z_2_`i' = sum(factor_z_2_`i') if factor_z_2_`i'!=.

	gen factor_z_3_`i' = market_share_it_`j'*tfp_acf_`j' if iso=="IT" & year_of_incorporation==`j'
	egen sum_factor_z_3_`i' = sum(factor_z_3_`i')

	gen factor_z_4_`i' = market_share_it_`i'*tfp_acf_`i'  if iso=="IT" & year_of_status==`i'
	egen sum_factor_z_4_`i' = sum(factor_z_4_`i') 

	gen factor_z_5_`i' = (market_share_it_`i') * (tfp_acf_`j' - tfp_acf_`i') if iso=="IT" ///
	& dummy_it_`i'==1 
	egen sum_factor_z_5_`i' = sum(factor_z_5_`i') 

	gen factor_z_6_`i' = (market_share_it_`j' - market_share_it_`i')*tfp_acf_`j' if iso=="IT" ///
	& (year_of_status!=`i' | year_of_status!=`j') & dummy_it_`i'==1  & tfp_acf_`j'!=. & tfp_acf_`i'!=.
	egen sum_factor_z_6_`i' = sum(factor_z_6_`i')

	gen baily_z_it_`i' = sum_factor_z_1_`i' + sum_factor_z_2_`i' + sum_factor_z_3_`i' - sum_factor_z_4_`i' + sum_factor_z_5_`i' + sum_factor_z_6_`i'
}

forval i = 2011/2015{
	su baily_it_`i'
	su baily_z_it_`i'
}

forval i = 2011/2015{
	su sum_factor_1_`i'
	su sum_factor_z_1_`i'
}

forval i = 2011/2015{
	su sum_factor_2_`i'
	su sum_factor_z_2_`i'
}

forval i = 2011/2015{
	su sum_factor_z_5_`i'
	su sum_factor_z_6_`i'
}

*Olley-Pakes (1996) decomposition by country (2016)

*Italy

forval j= 2011/2016 {
	quietly su tfp_acf_`j' if iso=="IT" & dummy_it_`j'==0
	scalar mean_tfp_it_nz_`j'=r(mean) 
	quietly su tfp_acf_`j' if iso=="IT" & dummy_it_`j'==1
	scalar mean_tfp_it_z_`j'=r(mean) 
	quietly su market_share_it_`j' if dummy_it_`j'==0
	scalar market_it_nz_`j'=r(mean) 
	quietly su market_share_it_`j' if dummy_it_`j'==1
	scalar market_it_z_`j'=r(mean) 
	gen cov_op_it_`j' = (market_share_it_`j' - market_it_nz_`j')*(tfp_acf_`j' - mean_tfp_it_nz_`j') if dummy_it_`j'==0
	gen cov_op_z_it_`j' =  (market_share_it_`j' - market_it_z_`j')*(tfp_acf_`j' - mean_tfp_it_z_`j') if dummy_it_`j'==1
	gen op_it_`j' = mean_tfp_it_nz_`j' + cov_op_it_`j'  if dummy_it_`j'==0
	gen op_it_z_`j' = mean_tfp_it_z_`j' + cov_op_z_it_`j' if dummy_it_`j'==1
}

forval j=2011/2016{
	su op_it_`j'
	su op_it_z_`j'
}

*Spain

forval j= 2016/2017 {
	quietly su tfp_acf_`j' if iso=="ES" & dummy_es_`j'==0
	scalar mean_tfp_es_nz_`j'=r(mean) 
	quietly su tfp_acf_`j' if iso=="ES" & dummy_es_`j'==1
	scalar mean_tfp_es_z_`j'=r(mean) 
	quietly su market_share_es_`j' if dummy_es_`j'==0
	scalar market_es_nz_`j'=r(mean) 
	quietly su market_share_es_`j' if dummy_es_`j'==1
	scalar market_es_z_`j'=r(mean) 
	gen cov_op_es_`j' = (market_share_es_`j' - market_es_nz_`j')*(tfp_acf_`j' - mean_tfp_es_nz_`j') if dummy_es_`j'==0
	gen cov_op_z_es_`j' =  (market_share_es_`j' - market_es_z_`j')*(tfp_acf_`j' - mean_tfp_es_z_`j') if dummy_es_`j'==1
	gen op_es_`j' = mean_tfp_es_nz_`j' + cov_op_es_`j'  if dummy_es_`j'==0
	gen op_es_z_`j' = mean_tfp_es_z_`j' + cov_op_z_es_`j' if dummy_es_`j'==1
}

forval j=2016/2017{
	su op_es_`j'
	su op_es_z_`j'
}

*France

forval j= 2016/2017 {
	quietly su tfp_acf_`j' if iso=="FR" & dummy_fr_`j'==0
	scalar mean_tfp_fr_nz_`j'=r(mean) 
	quietly su tfp_acf_`j' if iso=="FR" & dummy_fr_`j'==1
	scalar mean_tfp_fr_z_`j'=r(mean) 
	quietly su market_share_fr_`j' if dummy_fr_`j'==0
	scalar market_fr_nz_`j'=r(mean) 
	quietly su market_share_fr_`j' if dummy_fr_`j'==1
	scalar market_fr_z_`j'=r(mean) 
	gen cov_op_fr_`j' = (market_share_fr_`j' - market_fr_nz_`j')*(tfp_acf_`j' - mean_tfp_fr_nz_`j') if dummy_fr_`j'==0
	gen cov_op_z_fr_`j' =  (market_share_fr_`j' - market_fr_z_`j')*(tfp_acf_`j' - mean_tfp_fr_z_`j') if dummy_fr_`j'==1
	gen op_fr_`j' = mean_tfp_fr_nz_`j' + cov_op_fr_`j'  if dummy_fr_`j'==0
	gen op_fr_z_`j' = mean_tfp_fr_z_`j' + cov_op_z_fr_`j' if dummy_fr_`j'==1
}

forval j=2016/2017{
	su op_fr_`j'
	su op_fr_z_`j'
}

*Portugal

forval j= 2016/2017 {
	quietly su tfp_acf_`j' if iso=="PT" & dummy_pt_`j'==0
	scalar mean_tfp_pt_nz_`j'=r(mean) 
	quietly su tfp_acf_`j' if iso=="PT" & dummy_pt_`j'==1
	scalar mean_tfp_pt_z_`j'=r(mean) 
	quietly su market_share_pt_`j' if dummy_pt_`j'==0
	scalar market_pt_nz_`j'=r(mean) 
	quietly su market_share_pt_`j' if dummy_pt_`j'==1
	scalar market_pt_z_`j'=r(mean) 
	gen cov_op_pt_`j' = (market_share_pt_`j' - market_pt_nz_`j')*(tfp_acf_`j' - mean_tfp_pt_nz_`j') if dummy_pt_`j'==0
	gen cov_op_z_pt_`j' =  (market_share_pt_`j' - market_pt_z_`j')*(tfp_acf_`j' - mean_tfp_pt_z_`j') if dummy_pt_`j'==1
	gen op_pt_`j' = mean_tfp_pt_nz_`j' + cov_op_pt_`j'  if dummy_pt_`j'==0
	gen op_pt_z_`j' = mean_tfp_pt_z_`j' + cov_op_z_pt_`j' if dummy_pt_`j'==1
}

forval j=2016/2017{
	su op_pt_`j'
	su op_pt_z_`j'
}

*Foster et al (2001) Decomposition}

forval i = 2011/2015{
	local j = `i' + 1
	
	gen fact_1_`i' = (market_share_it_`i')*(tfp_acf_`j'-tfp_acf_`i') if iso=="IT" & dummy_it_`i'!=.
	egen sum_fact_1_`i' = sum(fact_1_`i') if fact_1_`i'!=.

	gen weighted_tfp_`i' = tfp_acf_`i' * market_share_it_`i'
	egen tot_tfp_`i' = sum(weighted_tfp_`i') if iso=="IT"
	gen fact_2_`i' = (market_share_it_`j' - market_share_it_`i')*(tfp_acf_`i'- tot_tfp_`i') if iso=="IT" & dummy_it_`i'!=.
	egen sum_fact_2_`i' = sum(fact_2_`i') if fact_2_`i'!=.

	gen fact_3_`i' = (market_share_it_`j' - market_share_it_`i')*(tfp_acf_`j'- tfp_acf_`i') if iso=="IT" & dummy_it_`i'!=.
	egen sum_fact_3_`i' = sum(fact_3_`i') if fact_3_`i'!=.

	gen fact_4_`i' = market_share_it_`j' * (tfp_acf_`j' -  tot_tfp_`i') if iso=="IT" & year_of_incorporation==`j' 
	egen sum_fact_4_`i' = sum(fact_4_`i') 

	gen fact_5_`i' = market_share_it_`i' * (tfp_acf_`i' - tot_tfp_`i' ) if iso=="IT" & year_of_status==`i'
	egen sum_fact_5_`i' = sum(fact_5_`i') 
	
	gen foster_`i' = sum_fact_1_`i' + sum_fact_2_`i' + sum_fact_3_`i' + sum_fact_4_`i' - sum_fact_5_`i'
}


forval i = 2011/2015{
	local j = `i' + 1
	
	gen fact_z_1_`i' = (market_share_it_`i')*(tfp_acf_`j'-tfp_acf_`i') if iso=="IT" & dummy_it_`i'== 0
	egen sum_fact_z_1_`i' = sum(fact_z_1_`i') 

	gen fact_z_2_`i' = (market_share_it_`j' - market_share_it_`i')*(tfp_acf_`i'- tot_tfp_`i') if iso=="IT" & dummy_it_`i'==0
	egen sum_fact_z_2_`i' = sum(fact_z_2_`i')

	gen fact_z_3_`i' = (market_share_it_`j' - market_share_it_`i')*(tfp_acf_`j'- tfp_acf_`i') if iso=="IT" & dummy_it_`i'==0
	egen sum_fact_z_3_`i' = sum(fact_z_3_`i') 
	
	gen fact_z_4_`i' = (market_share_it_`i')*(tfp_acf_`j'-tfp_acf_`i') if iso=="IT" & dummy_it_`i'== 1
	egen sum_fact_z_4_`i' = sum(fact_z_4_`i') 

	gen fact_z_5_`i' = (market_share_it_`j' - market_share_it_`i')*(tfp_acf_`i'- tot_tfp_`i') if iso=="IT" & dummy_it_`i'==1
	egen sum_fact_z_5_`i' = sum(fact_z_5_`i') 

	gen fact_z_6_`i' = (market_share_it_`j' - market_share_it_`i')*(tfp_acf_`j'- tfp_acf_`i') if iso=="IT" & dummy_it_`i'==1
	egen sum_fact_z_6_`i' = sum(fact_z_6_`i') 

	gen fact_z_7_`i' = market_share_it_`j' * (tfp_acf_`j' -  tot_tfp_`i') if iso=="IT" & year_of_incorporation==`j' 
	egen sum_fact_z_7_`i' = sum(fact_z_7_`i') 

	gen fact_z_8_`i' = market_share_it_`i' * (tfp_acf_`i' - tot_tfp_`i' ) if iso=="IT" & year_of_status==`i'
	egen sum_fact_z_8_`i' = sum(fact_z_8_`i') 
	
	gen foster_z_`i' = sum_fact_z_1_`i' + sum_fact_z_2_`i' + sum_fact_z_3_`i' + sum_fact_z_4_`i' + sum_fact_z_5_`i' + sum_fact_z_6_`i' + sum_fact_z_7_`i' - sum_fact_z_8_`i'
}

forval i = 2011/2015{
	su foster_`i'
	su foster_z_`i'
}


