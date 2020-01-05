********************************************************************************
*Zombie prediction with LASSO

clear all 
cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data"
use zombie_indicator_by_country.dta, replace

*Missing data
misstable summarize
misstable patterns

*Italian Data

*Zombies 2017
gen dummy_it_2017 = .
replace dummy_it_2017 = 1 if zombie_it_2017_2015!="." & drop_it_2016==3 & drop_it_2015==3 
replace dummy_it_2017 = 0 if zombie_it_2017_2015=="." & drop_it_2016==3 & drop_it_2015==3 


preserve
foreach v of var dummy_it_2017 tfp_acf_2016 dummy_patents dummy_trademark consdummy control ///
                nace_2 fin_rev_2016 int_paid_2016 ebitda_2016 cash_flow_2016 ///
                revenue2016 total_assets_2016  long_term_debt_2016 employees_2016 added_value_2016 ///
                materials_2016 wage_bill_2016 loans_2016  int_fixed_assets_2016 fixed_assets_2016 ///
                current_liabilities_2016  liquidity_ratio_2016  solvency_ratio_2016 current_assets_2016 ///
                fin_expenses_2016 net_income_2016  fin_cons100_2016  inv_2016  real_SA_2016 ///
                shareholders_funds_2016  NEG_VA_2016  ICR_failure_2016  profitability_2016 ///
                interest_diff_2016 misallocated_2016_fixed{ 
	drop if missing(`v') 
}

/* Lasso without variable "control"*/
lars dummy_it_2017 fin_rev_2016 int_paid_2016 ebitda_2016 cash_flow_2016 ///
                revenue2016 total_assets_2016  long_term_debt_2016 employees_2016 added_value_2016 ///
                materials_2016 wage_bill_2016 loans_2016  int_fixed_assets_2016 fixed_assets_2016 ///
                current_liabilities_2016  liquidity_ratio_2016  solvency_ratio_2016 current_assets_2016 ///
                fin_expenses_2016 net_income_2016  fin_cons100_2016  inv_2016  real_SA_2016 ///
                shareholders_funds_2016  NEG_VA_2016  ICR_failure_2016  profitability_2016 ///
                interest_diff_2016 misallocated_2016_fixed tfp_acf_2016 dummy_patents ///
				dummy_trademark consdummy, a(lasso) cluster(nace_2) vce(robust)
restore

*Zombies 2016
gen dummy_it_2016 = .
replace dummy_it_2016 = 1 if zombie_it_2016_2014!="." & drop_it_2015==3 & drop_it_2014==3 
replace dummy_it_2016 = 0 if zombie_it_2016_2014=="." & drop_it_2015==3 & drop_it_2014==3 

preserve
foreach v of var dummy_it_2016 tfp_acf_2015 dummy_patents dummy_trademark consdummy control ///
                nace_2 fin_rev_2015 int_paid_2015 ebitda_2015 cash_flow_2015 depr2015 ///
                revenue2015 total_assets_2015  long_term_debt_2015 employees_2015 added_value_2015 ///
                materials_2015 wage_bill_2015 loans_2015  int_fixed_assets_2015 fixed_assets_2015 ///
                current_liabilities_2015  liquidity_ratio_2015  solvency_ratio_2015 current_assets_2015 ///
                fin_expenses_2015 net_income_2015  fin_cons100_2015  inv_2015  real_SA_2015 ///
                shareholders_funds_2015  NEG_VA_2015  ICR_failure_2015  profitability_2015 ///
                interest_diff_2015 misallocated_2015_fixed{ 
	drop if missing(`v') 
}

/* Lasso without variable "control"*/
lars dummy_it_2016 fin_rev_2015 int_paid_2015 ebitda_2015 cash_flow_2015 depr2015 ///
                revenue2015 total_assets_2015  long_term_debt_2015 employees_2015 added_value_2015 ///
                materials_2015 wage_bill_2015 loans_2015  int_fixed_assets_2015 fixed_assets_2015 ///
                current_liabilities_2015  liquidity_ratio_2015  solvency_ratio_2015 current_assets_2015 ///
                fin_expenses_2015 net_income_2015  fin_cons100_2015  inv_2015  real_SA_2015 ///
                shareholders_funds_2015  NEG_VA_2015  ICR_failure_2015  profitability_2015 ///
                interest_diff_2015 misallocated_2015_fixed tfp_acf_2015 dummy_patents ///
				dummy_trademark consdummy, a(lasso) cluster(nace_2) vce(robust)
restore



*Zombies 2015
gen dummy_it_2015 = .
replace dummy_it_2015 = 1 if zombie_it_2015_2013!="." & drop_it_2014==3 & drop_it_2013==3 
replace dummy_it_2015 = 0 if zombie_it_2015_2013=="." & drop_it_2014==3 & drop_it_2013==3 

preserve
foreach v of var dummy_it_2015 tfp_acf_2014 dummy_patents dummy_trademark consdummy control ///
                nace_2 fin_rev_2014 int_paid_2014 ebitda_2014 cash_flow_2014 depr2014 ///
                revenue2014 total_assets_2014  long_term_debt_2014 employees_2014 added_value_2014 ///
                materials_2014 wage_bill_2014 loans_2014  int_fixed_assets_2014 fixed_assets_2014 ///
                current_liabilities_2014  liquidity_ratio_2014  solvency_ratio_2014 current_assets_2014 ///
                fin_expenses_2014 net_income_2014  fin_cons100_2014  inv_2014  real_SA_2014 ///
                shareholders_funds_2014  NEG_VA_2014  ICR_failure_2014  profitability_2014 ///
                interest_diff_2014 misallocated_2014_fixed{ 
	drop if missing(`v') 
}

/* Lasso without variable "control"*/
lars dummy_it_2015 fin_rev_2014 int_paid_2014 ebitda_2014 cash_flow_2014 depr2014 ///
                revenue2014 total_assets_2014  long_term_debt_2014 employees_2014 added_value_2014 ///
                materials_2014 wage_bill_2014 loans_2014  int_fixed_assets_2014 fixed_assets_2014 ///
                current_liabilities_2014  liquidity_ratio_2014  solvency_ratio_2014 current_assets_2014 ///
                fin_expenses_2014 net_income_2014  fin_cons100_2014  inv_2014  real_SA_2014 ///
                shareholders_funds_2014  NEG_VA_2014  ICR_failure_2014  profitability_2014 ///
                interest_diff_2014 misallocated_2014_fixed tfp_acf_2014 dummy_patents ///
				dummy_trademark consdummy, a(lasso) cluster(nace_2) vce(robust)
restore

*Zombies 2014

*LASSO REGRESSION
gen dummy_it_2014 = .
replace dummy_it_2014 = 1 if zombie_it_2014_2012!="." & drop_it_2012==3 & drop_it_2013==3 
replace dummy_it_2014 = 0 if zombie_it_2014_2012=="." & drop_it_2012==3 & drop_it_2013==3 

preserve
foreach v of var dummy_it_2014 tfp_acf_2013 dummy_patents dummy_trademark consdummy control ///
                nace_2 fin_rev_2013 int_paid_2013 ebitda_2013 cash_flow_2013 depr2014 ///
                revenue2013 total_assets_2013  long_term_debt_2013 employees_2013 added_value_2013 ///
                materials_2013 wage_bill_2013 loans_2013  int_fixed_assets_2013 fixed_assets_2013 ///
                current_liabilities_2013  liquidity_ratio_2013  solvency_ratio_2013 current_assets_2013 ///
                fin_expenses_2013 net_income_2013  fin_cons100_2013  inv_2013  real_SA_2013 ///
                shareholders_funds_2013  NEG_VA_2013  ICR_failure_2013  profitability_2013 ///
                interest_diff_2013 misallocated_2013_fixed{ 
	drop if missing(`v') 
}

/* Lasso without variable "control"*/
lars dummy_it_2014 fin_rev_2013 int_paid_2013 ebitda_2013 cash_flow_2013 depr2013 ///
                revenue2013 total_assets_2013  long_term_debt_2013 employees_2013 added_value_2013 ///
                materials_2013 wage_bill_2013 loans_2013  int_fixed_assets_2013 fixed_assets_2013 ///
                current_liabilities_2013  liquidity_ratio_2013  solvency_ratio_2013 current_assets_2013 ///
                fin_expenses_2013 net_income_2013  fin_cons100_2013  inv_2013  real_SA_2013 ///
                shareholders_funds_2013  NEG_VA_2013  ICR_failure_2013  profitability_2013 ///
                interest_diff_2013 misallocated_2013_fixed tfp_acf_2013 dummy_patents ///
				dummy_trademark consdummy, a(lasso) cluster(nace_2) vce(robust)
restore

*FE LINEAR PROBABILITY MODEL
reghdfe dummy_it_2014 fin_rev_2013 int_paid_2013 ebitda_2013 cash_flow_2013 depr2013 ///
                revenue2013 total_assets_2013  long_term_debt_2013 employees_2013 added_value_2013 ///
                materials_2013 wage_bill_2013 loans_2013  int_fixed_assets_2013 fixed_assets_2013 ///
                current_liabilities_2013  liquidity_ratio_2013  solvency_ratio_2013 current_assets_2013 ///
                fin_expenses_2013 net_income_2013  fin_cons100_2013  inv_2013  real_SA_2013 ///
                shareholders_funds_2013  NEG_VA_2013  ICR_failure_2013  profitability_2013 ///
                interest_diff_2013 misallocated_2013_fixed tfp_acf_2013 dummy_patents ///
				dummy_trademark consdummy, absorb(nace_2) vce(cluster nace_2)
reghdfe dummy_it_2014 fin_rev_2013 int_paid_2013 ebitda_2013 cash_flow_2013 depr2015 ///
                revenue2013 total_assets_2013  long_term_debt_2013 employees_2013 added_value_2013 ///
                materials_2013 wage_bill_2013 loans_2013  int_fixed_assets_2013 fixed_assets_2013 ///
                current_liabilities_2013  liquidity_ratio_2013  solvency_ratio_2013 current_assets_2013 ///
                fin_expenses_2013 net_income_2013  fin_cons100_2013  inv_2013  real_SA_2013 ///
                shareholders_funds_2013  NEG_VA_2013  ICR_failure_2013  profitability_2013 ///
                interest_diff_2013 misallocated_2013_fixed tfp_acf_2013 dummy_patents ///
				dummy_trademark consdummy, absorb(nace_2) vce(robust)

*LOGISTIC REGRESSION & MULTINOMIAL LOGIT
logit dummy_it_2014 fin_rev_2013 int_paid_2013 ebitda_2013 cash_flow_2013 depr2013 ///
                revenue2013 total_assets_2013  long_term_debt_2013 employees_2013 added_value_2013 ///
                materials_2013 wage_bill_2013 loans_2013  int_fixed_assets_2013 fixed_assets_2013 ///
                current_liabilities_2013  liquidity_ratio_2013  solvency_ratio_2013 current_assets_2013 ///
                fin_expenses_2013 net_income_2013  fin_cons100_2013  inv_2013  real_SA_2013 ///
                shareholders_funds_2013  NEG_VA_2013  ICR_failure_2013  profitability_2013 ///
                interest_diff_2013 misallocated_2013_fixed tfp_acf_2013 dummy_patents ///
				dummy_trademark consdummy, cluster(nace_2) robust
encode zombie_it_2014_2012 , gen(zombie_it_2014)
mlogit zombie_it_2014 fin_rev_2013 int_paid_2013 ebitda_2013 cash_flow_2013 depr2013 ///
                revenue2013 total_assets_2013  long_term_debt_2013 employees_2013 added_value_2013 ///
                materials_2013 wage_bill_2013 loans_2013  int_fixed_assets_2013 fixed_assets_2013 ///
                current_liabilities_2013  liquidity_ratio_2013  solvency_ratio_2013 current_assets_2013 ///
                fin_expenses_2013 net_income_2013  fin_cons100_2013  inv_2013  real_SA_2013 ///
                shareholders_funds_2013  NEG_VA_2013  ICR_failure_2013  profitability_2013 ///
                interest_diff_2013 misallocated_2013_fixed tfp_acf_2013 dummy_patents ///
				dummy_trademark consdummy, cluster(nace_2) robust
restore

*Zombies 2013
gen dummy_it_2013 = .
replace dummy_it_2013 = 1 if zombie_it_2013_2011!="." & drop_it_2011==3 & drop_it_2012==3 
replace dummy_it_2013 = 0 if zombie_it_2013_2011=="." & drop_it_2011==3 & drop_it_2012==3 

preserve
foreach v of var dummy_it_2013 tfp_acf_2012 dummy_patents dummy_trademark consdummy control ///
                nace_2 fin_rev_2012 int_paid_2012 ebitda_2012 cash_flow_2012 depr2012 ///
                revenue2012 total_assets_2012  long_term_debt_2012 employees_2012 added_value_2012 ///
                materials_2012 wage_bill_2012 loans_2012  int_fixed_assets_2012 fixed_assets_2012 ///
                current_liabilities_2012  liquidity_ratio_2012  solvency_ratio_2012 current_assets_2012 ///
                fin_expenses_2012 net_income_2012  fin_cons100_2012  inv_2012  real_SA_2012 ///
                shareholders_funds_2012  NEG_VA_2012  ICR_failure_2012  profitability_2012 ///
                interest_diff_2012 misallocated_2012_fixed{ 
	drop if missing(`v') 
}

/* Lasso without variable "control"*/
lars dummy_it_2013 fin_rev_2012 int_paid_2012 ebitda_2012 cash_flow_2012 depr2012 ///
                revenue2012 total_assets_2012  long_term_debt_2012 employees_2012 added_value_2012 ///
                materials_2012 wage_bill_2012 loans_2012  int_fixed_assets_2012 fixed_assets_2012 ///
                current_liabilities_2012  liquidity_ratio_2012  solvency_ratio_2012 current_assets_2012 ///
                fin_expenses_2012 net_income_2012  fin_cons100_2012  inv_2012  real_SA_2012 ///
                shareholders_funds_2012  NEG_VA_2012  ICR_failure_2012  profitability_2012 ///
                interest_diff_2012 misallocated_2012_fixed tfp_acf_2012 dummy_patents ///
				dummy_trademark consdummy, a(lasso) cluster(nace_2) vce(robust)
restore

*Zombies 2012
gen dummy_it_2012 = .
replace dummy_it_2012 = 1 if zombie_it_2012_2010!="." & drop_it_2010==3 & drop_it_2011==3 
replace dummy_it_2012 = 0 if zombie_it_2012_2010=="." & drop_it_2010==3 & drop_it_2011==3 

preserve
foreach v of var dummy_it_2012 tfp_acf_2011 dummy_patents dummy_trademark consdummy control ///
                nace_2 fin_rev_2011 int_paid_2011 ebitda_2011 cash_flow_2011 depr2011 ///
                revenue2011 total_assets_2011  long_term_debt_2011 employees_2011 added_value_2011 ///
                materials_2011 wage_bill_2011 loans_2011  int_fixed_assets_2011 fixed_assets_2011 ///
                current_liabilities_2011  liquidity_ratio_2011  solvency_ratio_2011 current_assets_2011 ///
                fin_expenses_2011 net_income_2011  fin_cons100_2011  inv_2011  real_SA_2011 ///
                shareholders_funds_2011  NEG_VA_2011  ICR_failure_2011  profitability_2011 ///
                interest_diff_2011 misallocated_2011_fixed{ 
	drop if missing(`v') 
}

/* Lasso without variable "control"*/
lars dummy_it_2012 fin_rev_2011 int_paid_2011 ebitda_2011 cash_flow_2011 depr2011 ///
                revenue2011 total_assets_2011  long_term_debt_2011 employees_2011 added_value_2011 ///
                materials_2011 wage_bill_2011 loans_2011  int_fixed_assets_2011 fixed_assets_2011 ///
                current_liabilities_2011  liquidity_ratio_2011  solvency_ratio_2011 current_assets_2011 ///
                fin_expenses_2011 net_income_2011  fin_cons100_2011  inv_2011  real_SA_2011 ///
                shareholders_funds_2011  NEG_VA_2011  ICR_failure_2011  profitability_2011 ///
                interest_diff_2011 misallocated_2011_fixed tfp_acf_2011 dummy_patents ///
				dummy_trademark consdummy, a(lasso) cluster(nace_2) vce(robust)
restore

*Zombies 2011
gen dummy_it_2011 = .
replace dummy_it_2011 = 1 if zombie_it_2011_2009!="." & drop_it_2009==3 & drop_it_2010==3 
replace dummy_it_2011 = 0 if zombie_it_2011_2009=="." & drop_it_2009==3 & drop_it_2010==3 

preserve
foreach v of var dummy_it_2011 tfp_acf_2010 dummy_patents dummy_trademark consdummy control ///
                nace_2 fin_rev_2010 int_paid_2010 ebitda_2010 cash_flow_2010 depr2010 ///
                revenue2010 total_assets_2010  long_term_debt_2010 employees_2010 added_value_2010 ///
                materials_2010 wage_bill_2010 loans_2010  int_fixed_assets_2010 fixed_assets_2010 ///
                current_liabilities_2010  liquidity_ratio_2010  solvency_ratio_2010 current_assets_2010 ///
                fin_expenses_2010 net_income_2010  fin_cons100_2010  inv_2010  real_SA_2010 ///
                shareholders_funds_2010  NEG_VA_2010  ICR_failure_2010  profitability_2010 ///
                interest_diff_2010 misallocated_2010_fixed{ 
	drop if missing(`v') 
}

/* Lasso without variable "control"*/
lars dummy_it_2011 fin_rev_2010 int_paid_2010 ebitda_2010 cash_flow_2010 depr2010 ///
                revenue2010 total_assets_2010  long_term_debt_2010 employees_2010 added_value_2010 ///
                materials_2010 wage_bill_2010 loans_2010  int_fixed_assets_2010 fixed_assets_2010 ///
                current_liabilities_2010  liquidity_ratio_2010  solvency_ratio_2010 current_assets_2010 ///
                fin_expenses_2010 net_income_2010  fin_cons100_2010  inv_2010  real_SA_2010 ///
                shareholders_funds_2010  NEG_VA_2010  ICR_failure_2010  profitability_2010 ///
                interest_diff_2010 misallocated_2010_fixed tfp_acf_2010 dummy_patents ///
				dummy_trademark consdummy, a(lasso) cluster(nace_2) vce(robust)
restore

*Spanish Data

*Zombies 2017
gen dummy_es_2017 = .
replace dummy_es_2017 = 1 if zombie_es_2017_2015!="." & drop_es_2016==3 & drop_es_2015==3 
replace dummy_es_2017 = 0 if zombie_es_2017_2015=="." & drop_es_2016==3 & drop_es_2015==3 


preserve
foreach v of var dummy_es_2017 tfp_acf_2016 dummy_patents dummy_trademark consdummy control ///
                nace_2 fin_rev_2016 int_paid_2016 ebitda_2016 cash_flow_2016 ///
                revenue2016 total_assets_2016  long_term_debt_2016 employees_2016 added_value_2016 ///
                materials_2016 wage_bill_2016 loans_2016  int_fixed_assets_2016 fixed_assets_2016 ///
                current_liabilities_2016  liquidity_ratio_2016  solvency_ratio_2016 current_assets_2016 ///
                fin_expenses_2016 net_income_2016  fin_cons100_2016  inv_2016  real_SA_2016 ///
                shareholders_funds_2016  NEG_VA_2016  ICR_failure_2016  profitability_2016 ///
                interest_diff_2016 misallocated_2016_fixed{ 
	drop if missing(`v') 
}

/* Lasso weshout variable "control"*/
lars dummy_es_2017 fin_rev_2016 int_paid_2016 ebitda_2016 cash_flow_2016 ///
                revenue2016 total_assets_2016  long_term_debt_2016 employees_2016 added_value_2016 ///
                materials_2016 wage_bill_2016 loans_2016  int_fixed_assets_2016 fixed_assets_2016 ///
                current_liabilities_2016  liquidity_ratio_2016  solvency_ratio_2016 current_assets_2016 ///
                fin_expenses_2016 net_income_2016  fin_cons100_2016  inv_2016  real_SA_2016 ///
                shareholders_funds_2016  NEG_VA_2016  ICR_failure_2016  profitability_2016 ///
                interest_diff_2016 misallocated_2016_fixed tfp_acf_2016 dummy_patents ///
				dummy_trademark consdummy, a(lasso) cluster(nace_2) vce(robust)
restore

*Zombies 2016
gen dummy_es_2016 = .
replace dummy_es_2016 = 1 if zombie_es_2016_2014!="." & drop_es_2015==3 & drop_es_2014==3 
replace dummy_es_2016 = 0 if zombie_es_2016_2014=="." & drop_es_2015==3 & drop_es_2014==3 

preserve
foreach v of var dummy_es_2016 tfp_acf_2015 dummy_patents dummy_trademark consdummy control ///
                nace_2 fin_rev_2015 int_paid_2015 ebitda_2015 cash_flow_2015 depr2015 ///
                revenue2015 total_assets_2015  long_term_debt_2015 employees_2015 added_value_2015 ///
                materials_2015 wage_bill_2015 loans_2015  int_fixed_assets_2015 fixed_assets_2015 ///
                current_liabilities_2015  liquidity_ratio_2015  solvency_ratio_2015 current_assets_2015 ///
                fin_expenses_2015 net_income_2015  fin_cons100_2015  inv_2015  real_SA_2015 ///
                shareholders_funds_2015  NEG_VA_2015  ICR_failure_2015  profitability_2015 ///
                interest_diff_2015 misallocated_2015_fixed{ 
	drop if missing(`v') 
}

/* Lasso without variable "control"*/
lars dummy_es_2016 fin_rev_2015 int_paid_2015 ebitda_2015 cash_flow_2015 depr2015 ///
                revenue2015 total_assets_2015  long_term_debt_2015 employees_2015 added_value_2015 ///
                materials_2015 wage_bill_2015 loans_2015  int_fixed_assets_2015 fixed_assets_2015 ///
                current_liabilities_2015  liquidity_ratio_2015  solvency_ratio_2015 current_assets_2015 ///
                fin_expenses_2015 net_income_2015  fin_cons100_2015  inv_2015  real_SA_2015 ///
                shareholders_funds_2015  NEG_VA_2015  ICR_failure_2015  profitability_2015 ///
                interest_diff_2015 misallocated_2015_fixed tfp_acf_2015 dummy_patents ///
				dummy_trademark consdummy, a(lasso) cluster(nace_2) vce(robust)
restore

*Portuguese Data

*Zombies 2017
gen dummy_pt_2017 = .
replace dummy_pt_2017 = 1 if zombie_pt_2017_2015!="." & drop_pt_2016==3 & drop_pt_2015==3 
replace dummy_pt_2017 = 0 if zombie_pt_2017_2015=="." & drop_pt_2016==3 & drop_pt_2015==3 


preserve
foreach v of var dummy_pt_2017 tfp_acf_2016 dummy_patents dummy_trademark consdummy control ///
                nace_2 fin_rev_2016 int_paid_2016 ebitda_2016 cash_flow_2016 ///
                revenue2016 total_assets_2016  long_term_debt_2016 employees_2016 added_value_2016 ///
                materials_2016 wage_bill_2016 loans_2016  int_fixed_assets_2016 fixed_assets_2016 ///
                current_liabilities_2016  liquidity_ratio_2016  solvency_ratio_2016 current_assets_2016 ///
                fin_expenses_2016 net_income_2016  fin_cons100_2016  inv_2016  real_SA_2016 ///
                shareholders_funds_2016  NEG_VA_2016  ICR_failure_2016  profitability_2016 ///
                interest_diff_2016 misallocated_2016_fixed{ 
	drop if missing(`v') 
}

/* Lasso weshout variable "control"*/
lars dummy_pt_2017 fin_rev_2016 int_paid_2016 ebitda_2016 cash_flow_2016 ///
                revenue2016 total_assets_2016  long_term_debt_2016 employees_2016 added_value_2016 ///
                materials_2016 wage_bill_2016 loans_2016  int_fixed_assets_2016 fixed_assets_2016 ///
                current_liabilities_2016  liquidity_ratio_2016  solvency_ratio_2016 current_assets_2016 ///
                fin_expenses_2016 net_income_2016  fin_cons100_2016  inv_2016  real_SA_2016 ///
                shareholders_funds_2016  NEG_VA_2016  ICR_failure_2016  profitability_2016 ///
                interest_diff_2016 misallocated_2016_fixed tfp_acf_2016 dummy_patents ///
				dummy_trademark consdummy, a(lasso) cluster(nace_2) vce(robust)
restore

*Zombies 2016
gen dummy_pt_2016 = .
replace dummy_pt_2016 = 1 if zombie_pt_2016_2014!="." & drop_pt_2015==3 & drop_pt_2014==3 
replace dummy_pt_2016 = 0 if zombie_pt_2016_2014=="." & drop_pt_2015==3 & drop_pt_2014==3 

preserve
foreach v of var dummy_pt_2016 tfp_acf_2015 dummy_patents dummy_trademark consdummy control ///
                nace_2 fin_rev_2015 int_paid_2015 ebitda_2015 cash_flow_2015 depr2015 ///
                revenue2015 total_assets_2015  long_term_debt_2015 employees_2015 added_value_2015 ///
                materials_2015 wage_bill_2015 loans_2015  int_fixed_assets_2015 fixed_assets_2015 ///
                current_liabilities_2015  liquidity_ratio_2015  solvency_ratio_2015 current_assets_2015 ///
                fin_expenses_2015 net_income_2015  fin_cons100_2015  inv_2015  real_SA_2015 ///
                shareholders_funds_2015  NEG_VA_2015  ICR_failure_2015  profitability_2015 ///
                interest_diff_2015 misallocated_2015_fixed{ 
	drop if missing(`v') 
}

/* Lasso without variable "control"*/
lars dummy_pt_2016 fin_rev_2015 int_paid_2015 ebitda_2015 cash_flow_2015 depr2015 ///
                revenue2015 total_assets_2015  long_term_debt_2015 employees_2015 added_value_2015 ///
                materials_2015 wage_bill_2015 loans_2015  int_fixed_assets_2015 fixed_assets_2015 ///
                current_liabilities_2015  liquidity_ratio_2015  solvency_ratio_2015 current_assets_2015 ///
                fin_expenses_2015 net_income_2015  fin_cons100_2015  inv_2015  real_SA_2015 ///
                shareholders_funds_2015  NEG_VA_2015  ICR_failure_2015  profitability_2015 ///
                interest_diff_2015 misallocated_2015_fixed tfp_acf_2015 dummy_patents ///
				dummy_trademark consdummy, a(lasso) cluster(nace_2) vce(robust)
restore

*French Data

*Zombies 2017
gen dummy_fr_2017 = .
replace dummy_fr_2017 = 1 if zombie_fr_2017_2015!="." & drop_fr_2016==3 & drop_fr_2015==3 
replace dummy_fr_2017 = 0 if zombie_fr_2017_2015=="." & drop_fr_2016==3 & drop_fr_2015==3 


preserve
foreach v of var dummy_fr_2017 tfp_acf_2016 dummy_patents dummy_trademark consdummy control ///
                nace_2 fin_rev_2016 int_paid_2016 ebitda_2016 cash_flow_2016 ///
                revenue2016 total_assets_2016  long_term_debt_2016 employees_2016 added_value_2016 ///
                materials_2016 wage_bill_2016 loans_2016  int_fixed_assets_2016 fixed_assets_2016 ///
                current_liabilities_2016  liquidity_ratio_2016  solvency_ratio_2016 current_assets_2016 ///
                fin_expenses_2016 net_income_2016  fin_cons100_2016  inv_2016  real_SA_2016 ///
                shareholders_funds_2016  NEG_VA_2016  ICR_failure_2016  profitability_2016 ///
                interest_diff_2016 misallocated_2016_fixed{ 
	drop if missing(`v') 
}

/* Lasso weshout variable "control"*/
lars dummy_fr_2017 fin_rev_2016 int_paid_2016 ebitda_2016 cash_flow_2016 ///
                revenue2016 total_assets_2016  long_term_debt_2016 employees_2016 added_value_2016 ///
                materials_2016 wage_bill_2016 loans_2016  int_fixed_assets_2016 fixed_assets_2016 ///
                current_liabilities_2016  liquidity_ratio_2016  solvency_ratio_2016 current_assets_2016 ///
                fin_expenses_2016 net_income_2016  fin_cons100_2016  inv_2016  real_SA_2016 ///
                shareholders_funds_2016  NEG_VA_2016  ICR_failure_2016  profitability_2016 ///
                interest_diff_2016 misallocated_2016_fixed tfp_acf_2016 dummy_patents ///
				dummy_trademark consdummy, a(lasso) cluster(nace_2) vce(robust)
restore

*Zombies 2016
gen dummy_fr_2016 = .
replace dummy_fr_2016 = 1 if zombie_fr_2016_2014!="." & drop_fr_2015==3 & drop_fr_2014==3 
replace dummy_fr_2016 = 0 if zombie_fr_2016_2014=="." & drop_fr_2015==3 & drop_fr_2014==3 

preserve
foreach v of var dummy_fr_2016 tfp_acf_2015 dummy_patents dummy_trademark consdummy control ///
                nace_2 fin_rev_2015 int_paid_2015 ebitda_2015 cash_flow_2015 depr2015 ///
                revenue2015 total_assets_2015  long_term_debt_2015 employees_2015 added_value_2015 ///
                materials_2015 wage_bill_2015 loans_2015  int_fixed_assets_2015 fixed_assets_2015 ///
                current_liabilities_2015  liquidity_ratio_2015  solvency_ratio_2015 current_assets_2015 ///
                fin_expenses_2015 net_income_2015  fin_cons100_2015  inv_2015  real_SA_2015 ///
                shareholders_funds_2015  NEG_VA_2015  ICR_failure_2015  profitability_2015 ///
                interest_diff_2015 misallocated_2015_fixed{ 
	drop if missing(`v') 
}

/* Lasso without variable "control"*/
lars dummy_fr_2016 fin_rev_2015 int_paid_2015 ebitda_2015 cash_flow_2015 depr2015 ///
                revenue2015 total_assets_2015  long_term_debt_2015 employees_2015 added_value_2015 ///
                materials_2015 wage_bill_2015 loans_2015  int_fixed_assets_2015 fixed_assets_2015 ///
                current_liabilities_2015  liquidity_ratio_2015  solvency_ratio_2015 current_assets_2015 ///
                fin_expenses_2015 net_income_2015  fin_cons100_2015  inv_2015  real_SA_2015 ///
                shareholders_funds_2015  NEG_VA_2015  ICR_failure_2015  profitability_2015 ///
                interest_diff_2015 misallocated_2015_fixed tfp_acf_2015 dummy_patents ///
				dummy_trademark consdummy, a(lasso) cluster(nace_2) vce(robust)
restore
