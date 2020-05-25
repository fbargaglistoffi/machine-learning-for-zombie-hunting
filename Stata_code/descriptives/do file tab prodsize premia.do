use "C:\Users\arman\Downloads\zombie_data.dta", clear
ren id bvd_id_number
sort bvd_id_number
keep bvd_id_number *alive*
reshape long zombie_alive_ dummy_alive_, i( bvd_id_number) j(year)
merge bvd_id_number year using "C:\Users\arman\Dropbox\Tesi PhD\Bargagli Stoffi\tfp data.dta"
drop if _merge==2
reghdfe tfp_ACF dummy_alive, absorb( nuts3 Industry) vce(cluster nuts3 Industry)
gen log_labprod=log( Y/L)
reghdfe log_labprod dummy_alive, absorb( nuts3 Industry) vce(cluster nuts3 Industry)
reghdfe log_y dummy_alive, absorb( nuts3 Industry) vce(cluster nuts3 Industry)
reghdfe log_l dummy_alive, absorb( nuts3 Industry) vce(cluster nuts3 Industry)
