clear all
cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data\firms_data\Debiti_AIDA"

* Clean Data
for i = 1/6{
	import excel "Debiti_`i'.xlsx", sheet("Risultati") firstrow

	drop A Ragionesociale

	rename DebitiTributarientromiglEUR tax_payables_1_2016
	rename BvDIDnumber BvDIDnumber
	rename E tax_payables_1_2015
	rename F tax_payables_1_2014
	rename G tax_payables_1_2013
	rename H tax_payables_1_2012
	rename I tax_payables_1_2011
	rename J tax_payables_1_2010
	rename K tax_payables_1_2009

	rename DebitiTributarioltremiglEUR tax_payables_2_2016
	rename M tax_payables_2_2015
	rename N tax_payables_2_2014
	rename O tax_payables_2_2013
	rename P tax_payables_2_2012
	rename Q tax_payables_2_2011
	rename R tax_payables_2_2010
	rename S tax_payables_2_2009

	forval j = 2009/2016{ 
		gen tax_payables_`j' = tax_payables_1_`j' + tax_payables_2_`j'
	}


	drop tax_payables_1_*
	drop tax_payables_2_*

	rename IstitutiprevidenzaentromiglE pension_payables_1_2016
	rename U pension_payables_1_2015
	rename V pension_payables_1_2014
	rename W pension_payables_1_2013
	rename X pension_payables_1_2012
	rename Y pension_payables_1_2011
	rename Z pension_payables_1_2010
	rename AA pension_payables_1_2009

	rename IstitutiprevidenzaoltremiglE pension_payables_2_2016
	rename AC pension_payables_2_2015
	rename AD pension_payables_2_2014
	rename AE pension_payables_2_2013
	rename AF pension_payables_2_2012
	rename AG pension_payables_2_2011
	rename AH pension_payables_2_2010
	rename AI pension_payables_2_2009

	forval j = 2009/2016{ 
		gen pension_payables_`j' = pension_payables_1_`j' + pension_payables_2_`j'
	}

	drop pension_payables_1_*
	drop pension_payables_2_*

	save debts_`i'.dta
}


use debts_1.dta, replace


* Append all the dataframes
forval j = 2/6 { 
	append using "debts_`j'.dta"	 
}

save payables.dta
