gen factor_1 = (market_share_it_2015)*(tfp_acf_2016-tfp_acf_2015) if iso=="IT" & dummy_it_2015!=.
su factor_1
egen sum_factor_1 = sum(factor_1) if factor_1!=.
su sum_factor_1 /* .0133617 */

gen factor_2 = (market_share_it_2016 - market_share_it_2015)*tfp_acf_2016 if iso=="IT" ///
& (year_of_status!=2015 | year_of_status!=2016) & tfp_acf_2016!=. & tfp_acf_2015!=. & dummy_it_2015!=.
egen sum_factor_2 = sum(factor_2) if factor_2!=.
su sum_factor_2 /* .1781316  */

gen factor_3 = market_share_it_2016*tfp_acf_2016 if iso=="IT" & year_of_incorporation==2016 
egen sum_factor_3 = sum(factor_3)
su sum_factor_3 /* .0158444 */

gen factor_4 = market_share_it_2015*tfp_acf_2015  if iso=="IT" & year_of_status==2015
egen sum_factor_4 = sum(factor_4)
su sum_factor_4 /* .0020011 */

gen op_it = sum_factor_1 + sum_factor_2 + sum_factor_3 - sum_factor_4
su op_it

* Baily without zombies

gen factor_z_1 = (market_share_it_2015) * (tfp_acf_2016 - tfp_acf_2015) if iso=="IT" ///
& dummy_it_2015==0 
su factor_z_1
egen sum_factor_z_1 = sum(factor_z_1)  if factor_z_1!=.
su sum_factor_z_1

gen factor_z_2 = (market_share_it_2016 - market_share_it_2015)*tfp_acf_2016 if iso=="IT" ///
& (year_of_status!=2015 | year_of_status!=2016) & dummy_it_2015==0  & tfp_acf_2016!=. & tfp_acf_2015!=.
egen sum_factor_z_2 = sum(factor_z_2) if factor_z_2!=.
su sum_factor_z_2

gen factor_z_3 = market_share_it_2016*tfp_acf_2016 if iso=="IT" & year_of_incorporation==2016
egen sum_factor_z_3 = sum(factor_z_3)
su sum_factor_z_3

gen factor_z_4 = market_share_it_2015*tfp_acf_2015  if iso=="IT" & year_of_status==2015
egen sum_factor_z_4 = sum(factor_z_4) 
su sum_factor_z_4

gen factor_z_5 = (market_share_it_2015) * (tfp_acf_2016 - tfp_acf_2015) if iso=="IT" ///
& dummy_it_2015==1 
su factor_z_5
egen sum_factor_z_5 = sum(factor_z_5) 
su sum_factor_z_5

gen factor_z_6 = (market_share_it_2016 - market_share_it_2015)*tfp_acf_2016 if iso=="IT" ///
& (year_of_status!=2015 | year_of_status!=2016) & dummy_it_2015==1  & tfp_acf_2016!=. & tfp_acf_2015!=.
egen sum_factor_z_6 = sum(factor_z_6)
su sum_factor_z_6

gen baily_z_it = sum_factor_z_1 + sum_factor_z_2 + sum_factor_z_3 - sum_factor_z_4 + sum_factor_z_5 + sum_factor_z_6
su baily_z_it
su baily_it

gen factor_1 = (market_share_it_2015)*(tfp_acf_2016-tfp_acf_2015) if iso=="IT" & dummy_it_2015!=.
su factor_1
egen sum_factor_1 = sum(factor_1) if factor_1!=.
su sum_factor_1 

gen weighted_tfp_2015 = tfp_acf_2015 * market_share_it_2015
egen tot_tfp_2015 = sum(weighted_tfp_2015) if  iso=="IT"
gen factor_2 = (market_share_it_2016 - market_share_it_2015)*(tfp_acf_2015- tot_tfp_2015) if iso=="IT" & dummy_it_2015!=.
su factor_2
egen sum_factor_2 = sum(factor_2) if factor_2!=.
su sum_factor_2

gen factor_3 = (market_share_it_2016 - market_share_it_2015)*(tfp_acf_2016- tfp_acf_2015) if iso=="IT" & dummy_it_2015!=.
su factor_3
egen sum_factor_3 = sum(factor_3) if factor_3!=.
su sum_factor_3

gen factor_4 = market_share_it_2016 * (tfp_acf_2016 -  tot_tfp_2015 /*tot tfp 2015*/) if iso=="IT" & year_of_incorporation==2016 
su factor_4
egen sum_factor_4 = sum(factor_4) 
su sum_factor_4

gen factor_5 = market_share_it_2015 * (tfp_acf_2015 -  tot_tfp_2015 /*tot tfp 2015*/) if iso=="IT" & year_of_status==2015
su factor_5
egen sum_factor_5 = sum(factor_5) 
su sum_factor_5

gen foster_2015 = sum_factor_1 + sum_factor_2 + sum_factor_3 + sum_factor_4 - sum_factor_5
su foster_2015

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
