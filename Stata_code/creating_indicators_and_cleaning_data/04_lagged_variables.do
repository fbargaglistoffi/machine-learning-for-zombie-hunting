********************************************************************************
*                     Generating lagged variables (t-1)                        *
********************************************************************************

*Generating Financial Revenues Lagged Values
gen fin_rev=.
replace fin_rev = fin_rev_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  fin_rev= fin_rev_`j' if year_of_status==`j'+1
}

*Generating Interest Paid Lagged Values
gen int_paid=.
replace int_paid = int_paid_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace int_paid = int_paid_`j' if year_of_status==`j'+1
}

*Generating Cash Flow Lagged Values
gen cash_flow=.
replace cash_flow = cash_flow_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  cash_flow = cash_flow_`j' if year_of_status==`j'+1
}

*Generating Ebitda Lagged Values
gen ebitda=.
replace ebitda = ebitda_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  ebitda = ebitda_`j' if year_of_status==`j'+1
}

*Generating Depriciation Lagged Values
gen depr=.
replace depr = depr2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  depr = depr`j' if year_of_status==`j'+1
}

*Generating Revenues Lagged Values
gen revenue=.
replace revenue = revenue2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  revenue = revenue`j' if year_of_status==`j'+1
}

*Generating Total Assets Lagged Values
gen total_assets=.
replace total_assets = total_assets_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  total_assets = total_assets_`j' if year_of_status==`j'+1
}

*Generating Long Term Debt Lagged Values
gen long_term_debt=.
replace long_term_debt = long_term_debt_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  long_term_debt = long_term_debt_`j' if year_of_status==`j'+1
}

*Generating Employees Lagged Values
gen employees=.
replace employees = employees_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  employees = employees_`j' if year_of_status==`j'+1
}

*Generating Added Value Lagged Values
gen added_value=.
replace added_value = added_value_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  added_value = added_value_`j' if year_of_status==`j'+1
}

*Generating Materials Lagged Values
gen materials=.
replace materials = materials_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  materials = materials_`j' if year_of_status==`j'+1
}

*Generating Wage Bill Lagged Values
gen wage_bill=.
replace wage_bill = wage_bill_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  wage_bill = wage_bill_`j' if year_of_status==`j'+1
}

*Generating Loans Lagged Values
gen loans=.
replace loans = loans_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  loans = loans_`j' if year_of_status==`j'+1
}

*Generating Fixed assets Lagged Values
gen fixed_assets=.
replace fixed_assets = fixed_assets_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  fixed_assets = fixed_assets_`j' if year_of_status==`j'+1
}

*Generating Int fixed assets Lagged Values
gen int_fixed_assets=.
replace int_fixed_assets = int_fixed_assets_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  int_fixed_assets = int_fixed_assets_`j' if year_of_status==`j'+1
}

*Generating Tax Lagged Values
gen tax=.
replace tax = tax_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  tax = tax_`j' if year_of_status==`j'+1
}

*Generating Retained earnings Lagged Values
gen retained_earnings=.
replace retained_earnings = retained_earnings_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  retained_earnings = retained_earnings_`j' if year_of_status==`j'+1
}

*Generating Firm Value Lagged Values
gen firm_value=.
replace firm_value = firm_value_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  firm_value = firm_value_`j' if year_of_status==`j'+1
}

*Generating Current Liabilities Lagged Values
gen current_liabilities=.
replace current_liabilities = current_liabilities_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  current_liabilities = current_liabilities_`j' if year_of_status==`j'+1
}

*Generating Liquidity Ratio Lagged Values
gen liquidity_ratio=.
replace liquidity_ratio = liquidity_ratio_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  liquidity_ratio = liquidity_ratio_`j' if year_of_status==`j'+1
}

*Generating Solvency Ratio Lagged Values
gen solvency_ratio=.
replace solvency_ratio = solvency_ratio_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  solvency_ratio = solvency_ratio_`j' if year_of_status==`j'+1
}

*Generating Current Assets Lagged Values
gen current_assets=.
replace current_assets = current_assets_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  current_assets = current_assets_`j' if year_of_status==`j'+1
}

*Generating Fin Expenses Lagged Values
gen fin_expenses=.
replace fin_expenses = fin_expenses_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  fin_expenses = fin_expenses_`j' if year_of_status==`j'+1
}

*Generating Fin Expenses Lagged Values
gen shareholders_funds=.
replace shareholders_funds = shareholders_funds_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  shareholders_funds = shareholders_funds_`j' if year_of_status==`j'+1
}

*Generating Net Income Lagged Values
gen net_income=.
replace net_income = net_income_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2008/2015 { 
     replace  net_income = net_income_`j' if year_of_status==`j'+1
}

*Generating Pension Payables Lagged Values (2009-2016)
gen pension_payables=.
replace pension_payables = pension_payables_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2009/2015 { 
     replace  pension_payables = pension_payables_`j' if year_of_status==`j'+1
}

*Generating Tax Payables Lagged Values (2009-2016)
gen tax_payables=.
replace tax_payables = tax_payables_2016 if year_of_status==2017 | year_of_status==2018 /*just first 4 months of 2017*/
forval j = 2009/2015 { 
     replace  tax_payables = tax_payables_`j' if year_of_status==`j'+1
}
