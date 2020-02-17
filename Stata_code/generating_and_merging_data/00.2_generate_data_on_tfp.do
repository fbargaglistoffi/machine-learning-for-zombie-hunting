* Generating TFP data files

* ACF TFP estimated with Turnover
cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data\results_ACF_TURNOVER"
use results_ACF_TURNOVER.dta, replace

keep bvd_id_number year tfp_ACF
rename bvd_id_number id
rename tfp_ACF tfp_acf_
reshape wide tfp_acf_ , i(id) j(year)

drop tfp_acf_2007 tfp_acf_2017 tfp_acf_2018

save tfp_acf_turnover.dta /* 169,154 observations */

* ACF TFP estimated with Added Value
cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data\results_ACF_VA"
use results_ACF_VA.dta, replace

keep bvd_id_number year tfp_ACF
rename bvd_id_number id
rename tfp_ACF tfp_acf_
reshape wide tfp_acf_ , i(id) j(year)

drop tfp_acf_2007 tfp_acf_2017 tfp_acf_2018

save tfp_acf_va.dta /* 165,157 observations */
