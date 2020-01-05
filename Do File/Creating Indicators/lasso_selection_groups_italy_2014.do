********************************************************************************
*Zombie prediction with LASSO

clear all 
cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data"
use zombie_indicator_by_country.dta, replace

*Zombies 2014

*LASSO REGRESSION
gen dummy_it_2014 = .
replace dummy_it_2014 = 1 if zombie_it_2014_2012!="." & drop_it_2012==3 & drop_it_2013==3 
replace dummy_it_2014 = 0 if zombie_it_2014_2012=="." & drop_it_2012==3 & drop_it_2013==3 

/* Lasso on Start Ups (time<=10) */
preserve
foreach v of var dummy_it_2014 tfp_acf_2013 dummy_patents dummy_trademark consdummy control ///
                nace_2 fin_rev_2013 int_paid_2013 ebitda_2013 cash_flow_2013 depr2013 ///
                revenue2013 total_assets_2013  long_term_debt_2013 employees_2013 added_value_2013 ///
                materials_2013 wage_bill_2013 loans_2013  int_fixed_assets_2013 fixed_assets_2013 ///
                current_liabilities_2013  liquidity_ratio_2013  solvency_ratio_2013 current_assets_2013 ///
                fin_expenses_2013 net_income_2013  fin_cons100_2013  inv_2013  real_SA_2013 ///
                shareholders_funds_2013  NEG_VA_2013  ICR_failure_2013  profitability_2013 ///
                interest_diff_2013 misallocated_2013_fixed{ 
	drop if missing(`v') 
}

keep if time <= 6 & dummy_it_2014!=.
lars dummy_it_2014 fin_rev_2013 int_paid_2013 ebitda_2013 cash_flow_2013 depr2013 ///
                revenue2013 total_assets_2013  long_term_debt_2013 employees_2013 added_value_2013 ///
                materials_2013 wage_bill_2013 loans_2013  int_fixed_assets_2013 fixed_assets_2013 ///
                current_liabilities_2013  liquidity_ratio_2013  solvency_ratio_2013 current_assets_2013 ///
                fin_expenses_2013 net_income_2013  fin_cons100_2013  inv_2013  real_SA_2013 ///
                shareholders_funds_2013  NEG_VA_2013  ICR_failure_2013  profitability_2013 ///
                interest_diff_2013 misallocated_2013_fixed tfp_acf_2013 dummy_patents ///
				dummy_trademark consdummy, a(lasso) cluster(nace_2) vce(robust)
restore

/* Lasso on innovative firms (dummy_patent == 1) [if not working omit depr2013] */
preserve
foreach v of var dummy_it_2014 tfp_acf_2013 dummy_patents dummy_trademark consdummy control ///
                nace_2 fin_rev_2013 int_paid_2013 ebitda_2013 cash_flow_2013 depr2013 ///
                revenue2013 total_assets_2013  long_term_debt_2013 employees_2013 added_value_2013 ///
                materials_2013 wage_bill_2013 loans_2013  int_fixed_assets_2013 fixed_assets_2013 ///
                current_liabilities_2013  liquidity_ratio_2013  solvency_ratio_2013 current_assets_2013 ///
                fin_expenses_2013 net_income_2013  fin_cons100_2013  inv_2013  real_SA_2013 ///
                shareholders_funds_2013  NEG_VA_2013  ICR_failure_2013  profitability_2013 ///
                interest_diff_2013 misallocated_2013_fixed{ 
	drop if missing(`v') 
}

keep if dummy_patent == 1 & dummy_it_2014!=.
lars dummy_it_2014 fin_rev_2013 int_paid_2013 ebitda_2013 cash_flow_2013 depr2013 ///
                revenue2013 total_assets_2013  long_term_debt_2013 employees_2013 added_value_2013 ///
                materials_2013 wage_bill_2013 loans_2013  int_fixed_assets_2013 fixed_assets_2013 ///
                current_liabilities_2013  liquidity_ratio_2013  solvency_ratio_2013 current_assets_2013 ///
                fin_expenses_2013 net_income_2013  fin_cons100_2013  inv_2013  real_SA_2013 ///
                shareholders_funds_2013  NEG_VA_2013  ICR_failure_2013  profitability_2013 ///
                interest_diff_2013 misallocated_2013_fixed tfp_acf_2013 dummy_patents ///
				dummy_trademark consdummy, a(lasso) cluster(nace_2) vce(robust)
restore

/* Lasso on Metal Products Firms (NACE_2==25) */
preserve
foreach v of var dummy_it_2014 tfp_acf_2013 dummy_patents dummy_trademark consdummy control ///
                nace_2 fin_rev_2013 int_paid_2013 ebitda_2013 cash_flow_2013 depr2013 ///
                revenue2013 total_assets_2013  long_term_debt_2013 employees_2013 added_value_2013 ///
                materials_2013 wage_bill_2013 loans_2013  int_fixed_assets_2013 fixed_assets_2013 ///
                current_liabilities_2013  liquidity_ratio_2013  solvency_ratio_2013 current_assets_2013 ///
                fin_expenses_2013 net_income_2013  fin_cons100_2013  inv_2013  real_SA_2013 ///
                shareholders_funds_2013  NEG_VA_2013  ICR_failure_2013  profitability_2013 ///
                interest_diff_2013 misallocated_2013_fixed{ 
	drop if missing(`v') 
}

keep if nace_2 == 25 & dummy_it_2014!=.
lars dummy_it_2014 fin_rev_2013 int_paid_2013 ebitda_2013 cash_flow_2013 depr2013 ///
                revenue2013 total_assets_2013  long_term_debt_2013 employees_2013 added_value_2013 ///
                materials_2013 wage_bill_2013 loans_2013  int_fixed_assets_2013 fixed_assets_2013 ///
                current_liabilities_2013  liquidity_ratio_2013  solvency_ratio_2013 current_assets_2013 ///
                fin_expenses_2013 net_income_2013  fin_cons100_2013  inv_2013  real_SA_2013 ///
                shareholders_funds_2013  NEG_VA_2013  ICR_failure_2013  profitability_2013 ///
                interest_diff_2013 misallocated_2013_fixed tfp_acf_2013 dummy_patents ///
				dummy_trademark consdummy, a(lasso) cluster(nace_2) vce(robust)
restore

/* Lasso on Food Products Firms (NACE_2==10) */
preserve
foreach v of var dummy_it_2014 tfp_acf_2013 dummy_patents dummy_trademark consdummy control ///
                nace_2 fin_rev_2013 int_paid_2013 ebitda_2013 cash_flow_2013 depr2013 ///
                revenue2013 total_assets_2013  long_term_debt_2013 employees_2013 added_value_2013 ///
                materials_2013 wage_bill_2013 loans_2013  int_fixed_assets_2013 fixed_assets_2013 ///
                current_liabilities_2013  liquidity_ratio_2013  solvency_ratio_2013 current_assets_2013 ///
                fin_expenses_2013 net_income_2013  fin_cons100_2013  inv_2013  real_SA_2013 ///
                shareholders_funds_2013  NEG_VA_2013  ICR_failure_2013  profitability_2013 ///
                interest_diff_2013 misallocated_2013_fixed{ 
	drop if missing(`v') 
}

keep if nace_2 == 10 & dummy_it_2014!=.
lars dummy_it_2014 fin_rev_2013 int_paid_2013 ebitda_2013 cash_flow_2013 depr2013 ///
                revenue2013 total_assets_2013  long_term_debt_2013 employees_2013 added_value_2013 ///
                materials_2013 wage_bill_2013 loans_2013  int_fixed_assets_2013 fixed_assets_2013 ///
                current_liabilities_2013  liquidity_ratio_2013  solvency_ratio_2013 current_assets_2013 ///
                fin_expenses_2013 net_income_2013  fin_cons100_2013  inv_2013  real_SA_2013 ///
                shareholders_funds_2013  NEG_VA_2013  ICR_failure_2013  profitability_2013 ///
                interest_diff_2013 misallocated_2013_fixed tfp_acf_2013 dummy_patents ///
				dummy_trademark consdummy, a(lasso) cluster(nace_2) vce(robust)
restore

/* Lasso on Wearing Apparel Firms (NACE_2==14) */
preserve
foreach v of var dummy_it_2014 tfp_acf_2013 dummy_patents dummy_trademark consdummy control ///
                nace_2 fin_rev_2013 int_paid_2013 ebitda_2013 cash_flow_2013 depr2013 ///
                revenue2013 total_assets_2013  long_term_debt_2013 employees_2013 added_value_2013 ///
                materials_2013 wage_bill_2013 loans_2013  int_fixed_assets_2013 fixed_assets_2013 ///
                current_liabilities_2013  liquidity_ratio_2013  solvency_ratio_2013 current_assets_2013 ///
                fin_expenses_2013 net_income_2013  fin_cons100_2013  inv_2013  real_SA_2013 ///
                shareholders_funds_2013  NEG_VA_2013  ICR_failure_2013  profitability_2013 ///
                interest_diff_2013 misallocated_2013_fixed{ 
	drop if missing(`v') 
}

keep if nace_2 == 14 & dummy_it_2014!=.
lars dummy_it_2014 fin_rev_2013 int_paid_2013 ebitda_2013 cash_flow_2013 depr2013 ///
                revenue2013 total_assets_2013  long_term_debt_2013 employees_2013 added_value_2013 ///
                materials_2013 wage_bill_2013 loans_2013  int_fixed_assets_2013 fixed_assets_2013 ///
                current_liabilities_2013  liquidity_ratio_2013  solvency_ratio_2013 current_assets_2013 ///
                fin_expenses_2013 net_income_2013  fin_cons100_2013  inv_2013  real_SA_2013 ///
                shareholders_funds_2013  NEG_VA_2013  ICR_failure_2013  profitability_2013 ///
                interest_diff_2013 misallocated_2013_fixed tfp_acf_2013 dummy_patents ///
				dummy_trademark consdummy, a(lasso) cluster(nace_2) vce(robust)
restore


/* Lasso on Big Firms (more/equal than 20 employees 11.48%) */
preserve
foreach v of var dummy_it_2014 tfp_acf_2013 dummy_patents dummy_trademark consdummy control ///
                nace_2 fin_rev_2013 int_paid_2013 ebitda_2013 cash_flow_2013 depr2013 ///
                revenue2013 total_assets_2013  long_term_debt_2013 employees_2013 added_value_2013 ///
                materials_2013 wage_bill_2013 loans_2013  int_fixed_assets_2013 fixed_assets_2013 ///
                current_liabilities_2013  liquidity_ratio_2013  solvency_ratio_2013 current_assets_2013 ///
                fin_expenses_2013 net_income_2013  fin_cons100_2013  inv_2013  real_SA_2013 ///
                shareholders_funds_2013  NEG_VA_2013  ICR_failure_2013  profitability_2013 ///
                interest_diff_2013 misallocated_2013_fixed{ 
	drop if missing(`v') 
}

keep if employees_2013>=20 & dummy_it_2014!=.
lars dummy_it_2014 fin_rev_2013 int_paid_2013 ebitda_2013 cash_flow_2013 depr2013 ///
                revenue2013 total_assets_2013  long_term_debt_2013 employees_2013 added_value_2013 ///
                materials_2013 wage_bill_2013 loans_2013  int_fixed_assets_2013 fixed_assets_2013 ///
                current_liabilities_2013  liquidity_ratio_2013  solvency_ratio_2013 current_assets_2013 ///
                fin_expenses_2013 net_income_2013  fin_cons100_2013  inv_2013  real_SA_2013 ///
                shareholders_funds_2013  NEG_VA_2013  ICR_failure_2013  profitability_2013 ///
                interest_diff_2013 misallocated_2013_fixed tfp_acf_2013 dummy_patents ///
				dummy_trademark consdummy, a(lasso) cluster(nace_2) vce(robust)
restore

/* Lasso on Small Firms (less/equal than 3 employees 56.67%) */
preserve
foreach v of var dummy_it_2014 tfp_acf_2013 dummy_patents dummy_trademark consdummy control ///
                nace_2 fin_rev_2013 int_paid_2013 ebitda_2013 cash_flow_2013 depr2013 ///
                revenue2013 total_assets_2013  long_term_debt_2013 employees_2013 added_value_2013 ///
                materials_2013 wage_bill_2013 loans_2013  int_fixed_assets_2013 fixed_assets_2013 ///
                current_liabilities_2013  liquidity_ratio_2013  solvency_ratio_2013 current_assets_2013 ///
                fin_expenses_2013 net_income_2013  fin_cons100_2013  inv_2013  real_SA_2013 ///
                shareholders_funds_2013  NEG_VA_2013  ICR_failure_2013  profitability_2013 ///
                interest_diff_2013 misallocated_2013_fixed{ 
	drop if missing(`v') 
}

keep if employees_2013<=3 & dummy_it_2014!=.
lars dummy_it_2014 fin_rev_2013 int_paid_2013 ebitda_2013 cash_flow_2013 depr2013 ///
                revenue2013 total_assets_2013  long_term_debt_2013 employees_2013 added_value_2013 ///
                materials_2013 wage_bill_2013 loans_2013  int_fixed_assets_2013 fixed_assets_2013 ///
                current_liabilities_2013  liquidity_ratio_2013  solvency_ratio_2013 current_assets_2013 ///
                fin_expenses_2013 net_income_2013  fin_cons100_2013  inv_2013  real_SA_2013 ///
                shareholders_funds_2013  NEG_VA_2013  ICR_failure_2013  profitability_2013 ///
                interest_diff_2013 misallocated_2013_fixed tfp_acf_2013 dummy_patents ///
				dummy_trademark consdummy, a(lasso) cluster(nace_2) vce(robust)
restore

/* Lasso on Southern Firms */
preserve
foreach v of var dummy_it_2014 tfp_acf_2013 dummy_patents dummy_trademark consdummy control ///
                nace_2 fin_rev_2013 int_paid_2013 ebitda_2013 cash_flow_2013 depr2013 ///
                revenue2013 total_assets_2013  long_term_debt_2013 employees_2013 added_value_2013 ///
                materials_2013 wage_bill_2013 loans_2013  int_fixed_assets_2013 fixed_assets_2013 ///
                current_liabilities_2013  liquidity_ratio_2013  solvency_ratio_2013 current_assets_2013 ///
                fin_expenses_2013 net_income_2013  fin_cons100_2013  inv_2013  real_SA_2013 ///
                shareholders_funds_2013  NEG_VA_2013  ICR_failure_2013  profitability_2013 ///
                interest_diff_2013 misallocated_2013_fixed{ 
	drop if missing(`v') 
}

keep if area == "south" & dummy_it_2014!=.
lars dummy_it_2014 fin_rev_2013 int_paid_2013 ebitda_2013 cash_flow_2013 depr2013 ///
                revenue2013 total_assets_2013  long_term_debt_2013 employees_2013 added_value_2013 ///
                materials_2013 wage_bill_2013 loans_2013  int_fixed_assets_2013 fixed_assets_2013 ///
                current_liabilities_2013  liquidity_ratio_2013  solvency_ratio_2013 current_assets_2013 ///
                fin_expenses_2013 net_income_2013  fin_cons100_2013  inv_2013  real_SA_2013 ///
                shareholders_funds_2013  NEG_VA_2013  ICR_failure_2013  profitability_2013 ///
                interest_diff_2013 misallocated_2013_fixed tfp_acf_2013 dummy_patents ///
				dummy_trademark consdummy, a(lasso) cluster(nace_2) vce(robust)
restore
				
				
