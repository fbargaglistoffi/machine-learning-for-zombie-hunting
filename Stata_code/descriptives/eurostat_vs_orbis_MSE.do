*Generating SE

clear all

import excel "C:\Users\Falco\Desktop\Eurostat_VS_Orbis\Eurostat_VS_Orbis_MSE.xls", sheet("Foglio1") firstrow clear
import excel "C:\Users\Falco\Desktop\Eurostat_VS_Orbis\Eurostat_VS_Orbis_Size.xls", sheet("Foglio1") firstrow clear


forval j = 1/9 {
	scalar se_`j'=((ORB_`j' - EUR_`j')^2)
	di se_`j'*1000
}

forval j = 1/9 {
	scalar se_`j'=((ORB`j' - EUR`j')^2)
	di se_`j'*100
}


import excel "C:\Users\Falco\Desktop\Eurostat_VS_Orbis\Computed_SE.xls",sheet("Foglio1") firstrow clear

*Industry
su SE
kdensity SE

egen mean = mean(SE)
egen sd = sd(SE)

egen group = group(SE)
gen sum_se=.
su group, meanonly
forval i = 1/9 {
         gen normalize_SE`i' = SE - mean / (sd) if group == `i'
		 replace sum_se=sum(normalize_SE`i') if group == `i'
		 drop normalize_SE`i' 
}

*T-distributed Confidence intervals for Industry
kdensity sum_se
egen mean_sum_se=mean(sum_se)
di mean_sum_se + 2.30 /*t-table value associated with 8 DoF*/ * (sd/sqrt(9)) /*1.0142138*/
di mean_sum_se - 2.30 /*t-table value associated with 8 DoF*/ * (sd/sqrt(9)) /*-.76972365*/

drop if sum_se<-.76972365 | sum_se>1.0142138
/* Observation of Poland and Great Britain (5/9) would be ruled out */

*Detection with Interquartile distribution (1.5*IQR)
egen myiqr=iqr(SE)
_pctile SE, nq(4)
return list
di r(r3) + 1.5*myiqr /* Observation of Poland and Great Britain (5/9) would be ruled out */

*Size
su SE_size
kdensity SE_size


egen mean_size = mean(SE_size)
egen sd_size = sd(SE_size)

gen sum_se_size=.
su group, meanonly
forval i = 1/9 {
         gen normalize_SE`i'_size = SE_size - mean_size / (sd_size) if group == `i'
		 replace sum_se_size=sum(normalize_SE`i'_size) if group == `i'
		 drop normalize_SE`i'_size
}

*T-distributed Confidence intervals for Industry (centred on the mean: perverse effect*)
kdensity sum_se_size
egen mean_sum_se_size=mean(sum_se_size)
di mean_sum_se_size + 2.30 /*t-table value associated with 8 DoF*/ * (sd_size/sqrt(9))
di mean_sum_se_size - 2.30 /*t-table value associated with 8 DoF*/ * (sd_size/sqrt(9))

*Detection with Interquartile distribution (IQR)
egen myiqr_size=iqr(SE_size)
_pctile SE_size, nq(4)
return list
di r(r3) + 1.5*myiqr_size /* Observation of Poland and Great Britain (5/9) would be ruled out */


