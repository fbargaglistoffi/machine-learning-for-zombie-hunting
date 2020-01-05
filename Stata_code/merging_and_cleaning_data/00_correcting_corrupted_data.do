****************************
*Correting corrupted files *
****************************

clear all 
cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data\Corrupted Data Corrected"
use "orbis_export_1.dta", clear

rename GUOBvDIDnumber GUO___BvD_ID_number 
rename Companyname Company_name 
rename BvDIDnumber BvD_ID_number
rename CountryISOCode Country_ISO_Code 
rename Regionincountry Region_in_country 
rename Conscode Cons__code
rename Dateofincorporation Date_of_incorporation
rename NACERev2Corecode4digits NACE_Rev__2_Core_code__4_digits_ 
rename Statusdate Status_date 
rename NAICS2017Primarycodes NAICS_2017_Primary_code_s_
rename Numberofpatents Number_of_patents 
rename Numberoftrademarks Number_of_trademarks

rename DepreciationAmortizationEUR Depreciation___Amortization_EUR_ 
rename AZ Depreciation___Amortization_EUR0 
rename BA Depreciation___Amortization_EUR1 
rename BB Depreciation___Amortization_EUR2 
rename BC Depreciation___Amortization_EUR3 
rename BD Depreciation___Amortization_EUR4 
rename BE Depreciation___Amortization_EUR5 
rename BF Depreciation___Amortization_EUR6 
rename BG Depreciation___Amortization_EUR7

rename PLforperiodNetincomeEUR P_L_for_period___Net_income__EUR
rename FD P_L_for_period___Net_income__EU0 
rename FE P_L_for_period___Net_income__EU1 
rename FF P_L_for_period___Net_income__EU2 
rename FG P_L_for_period___Net_income__EU3 
rename FH P_L_for_period___Net_income__EU4 
rename FI P_L_for_period___Net_income__EU5 
rename FJ P_L_for_period___Net_income__EU6 
rename FK P_L_for_period___Net_income__EU7

rename SolvencyratioAssetbased2 Solvency_ratio__Asset_based____2 
rename GW Solvency_ratio__Asset_based____0 
rename GX Solvency_ratio__Asset_based____1 
rename GY Solvency_ratio__Asset_based____3 
rename GZ Solvency_ratio__Asset_based____4 
rename HA Solvency_ratio__Asset_based____5 
rename HB Solvency_ratio__Asset_based____6 
rename HC Solvency_ratio__Asset_based____7 
rename HD Solvency_ratio__Asset_based____8

rename OperatingrevenueTurnoverEUR Operating_revenue__Turnover__EUR 
rename BI Operating_revenue__Turnover__EU0 
rename BJ Operating_revenue__Turnover__EU1 
rename BK Operating_revenue__Turnover__EU2 
rename BL Operating_revenue__Turnover__EU3 
rename BM Operating_revenue__Turnover__EU4 
rename BN Operating_revenue__Turnover__EU5 
rename BO Operating_revenue__Turnover__EU6 
rename BP Operating_revenue__Turnover__EU7


forval j = 2008/2016 { 
	rename FinancialrevenueEUR`j' Financial_revenue_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename InterestpaidEUR`j' Interest_paid_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename CashflowEUR`j' Cash_flow_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename EBITDAEUR`j' EBITDA_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename TotalassetsEUR`j' Total_assets_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename LongtermdebtEUR`j' Long_term_debt_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename Numberofemployees`j' Number_of_employees_`j'	 
}

forval j = 2008/2016 { 
	rename AddedvalueEUR`j' Added_value_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename MaterialcostsEUR`j' Material_costs_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename CostsofemployeesEUR`j' Costs_of_employees_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename LoansEUR`j' Loans_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename FixedassetsEUR`j' Fixed_assets_EUR_`j'	 
}


forval j = 2008/2016 { 
	rename IntangiblefixedassetsEUR`j' Intangible_fixed_assets_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename TaxationEUR`j' Taxation_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename RetainedEarningsEUR`j' Retained_Earnings_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename EnterpriseValueEUR`j' Enterprise_Value_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename CurrentliabilitiesEUR`j' Current_liabilities_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename CurrentassetsEUR`j' Current_assets_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename Liquidityratio`j' Liquidity_ratio_`j'	 
}

cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data"
save orbis_export_1.dta, replace

********************************************************************************
clear all 
cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data\Corrupted Data Corrected"
use "orbis_export_3.dta", clear

rename GUOBvDIDnumber GUO___BvD_ID_number 
rename Companyname Company_name 
rename BvDIDnumber BvD_ID_number
rename CountryISOCode Country_ISO_Code 
rename Regionincountry Region_in_country 
rename Conscode Cons__code
rename Dateofincorporation Date_of_incorporation
rename NACERev2Corecode4digits NACE_Rev__2_Core_code__4_digits_ 
rename Statusdate Status_date 
rename NAICS2017Primarycodes NAICS_2017_Primary_code_s_
rename Numberofpatents Number_of_patents 
rename Numberoftrademarks Number_of_trademarks

rename DepreciationAmortizationEUR Depreciation___Amortization_EUR_ 
rename AZ Depreciation___Amortization_EUR0 
rename BA Depreciation___Amortization_EUR1 
rename BB Depreciation___Amortization_EUR2 
rename BC Depreciation___Amortization_EUR3 
rename BD Depreciation___Amortization_EUR4 
rename BE Depreciation___Amortization_EUR5 
rename BF Depreciation___Amortization_EUR6 
rename BG Depreciation___Amortization_EUR7

rename PLforperiodNetincomeEUR P_L_for_period___Net_income__EUR
rename FD P_L_for_period___Net_income__EU0 
rename FE P_L_for_period___Net_income__EU1 
rename FF P_L_for_period___Net_income__EU2 
rename FG P_L_for_period___Net_income__EU3 
rename FH P_L_for_period___Net_income__EU4 
rename FI P_L_for_period___Net_income__EU5 
rename FJ P_L_for_period___Net_income__EU6 
rename FK P_L_for_period___Net_income__EU7

rename SolvencyratioAssetbased2 Solvency_ratio__Asset_based____2 
rename GW Solvency_ratio__Asset_based____0 
rename GX Solvency_ratio__Asset_based____1 
rename GY Solvency_ratio__Asset_based____3 
rename GZ Solvency_ratio__Asset_based____4 
rename HA Solvency_ratio__Asset_based____5 
rename HB Solvency_ratio__Asset_based____6 
rename HC Solvency_ratio__Asset_based____7 
rename HD Solvency_ratio__Asset_based____8

rename OperatingrevenueTurnoverEUR Operating_revenue__Turnover__EUR 
rename BI Operating_revenue__Turnover__EU0 
rename BJ Operating_revenue__Turnover__EU1 
rename BK Operating_revenue__Turnover__EU2 
rename BL Operating_revenue__Turnover__EU3 
rename BM Operating_revenue__Turnover__EU4 
rename BN Operating_revenue__Turnover__EU5 
rename BO Operating_revenue__Turnover__EU6 
rename BP Operating_revenue__Turnover__EU7


forval j = 2008/2016 { 
	rename FinancialrevenueEUR`j' Financial_revenue_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename InterestpaidEUR`j' Interest_paid_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename CashflowEUR`j' Cash_flow_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename EBITDAEUR`j' EBITDA_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename TotalassetsEUR`j' Total_assets_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename LongtermdebtEUR`j' Long_term_debt_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename Numberofemployees`j' Number_of_employees_`j'	 
}

forval j = 2008/2016 { 
	rename AddedvalueEUR`j' Added_value_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename MaterialcostsEUR`j' Material_costs_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename CostsofemployeesEUR`j' Costs_of_employees_EUR_`j'	 
}


forval j = 2008/2016 { 
	rename FixedassetsEUR`j' Fixed_assets_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename LoansEUR`j' Loans_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename IntangiblefixedassetsEUR`j' Intangible_fixed_assets_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename TaxationEUR`j' Taxation_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename RetainedEarningsEUR`j' Retained_Earnings_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename EnterpriseValueEUR`j' Enterprise_Value_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename CurrentliabilitiesEUR`j' Current_liabilities_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename CurrentassetsEUR`j' Current_assets_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename Liquidityratio`j' Liquidity_ratio_`j'	 
}

cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data"
save orbis_export_3.dta, replace

********************************************************************************
clear all 
cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data\Corrupted Data Corrected"
use "orbis_export_172.dta", clear

rename GUOBvDIDnumber GUO___BvD_ID_number 
rename Companyname Company_name 
rename BvDIDnumber BvD_ID_number
rename CountryISOCode Country_ISO_Code 
rename Regionincountry Region_in_country 
rename Conscode Cons__code
rename Dateofincorporation Date_of_incorporation
rename NACERev2Corecode4digits NACE_Rev__2_Core_code__4_digits_ 
rename Statusdate Status_date 
rename NAICS2017Primarycodes NAICS_2017_Primary_code_s_
rename Numberofpatents Number_of_patents 
rename Numberoftrademarks Number_of_trademarks

rename DepreciationAmortizationEUR Depreciation___Amortization_EUR_ 
rename AZ Depreciation___Amortization_EUR0 
rename BA Depreciation___Amortization_EUR1 
rename BB Depreciation___Amortization_EUR2 
rename BC Depreciation___Amortization_EUR3 
rename BD Depreciation___Amortization_EUR4 
rename BE Depreciation___Amortization_EUR5 
rename BF Depreciation___Amortization_EUR6 
rename BG Depreciation___Amortization_EUR7

rename PLforperiodNetincomeEUR P_L_for_period___Net_income__EUR
rename FD P_L_for_period___Net_income__EU0 
rename FE P_L_for_period___Net_income__EU1 
rename FF P_L_for_period___Net_income__EU2 
rename FG P_L_for_period___Net_income__EU3 
rename FH P_L_for_period___Net_income__EU4 
rename FI P_L_for_period___Net_income__EU5 
rename FJ P_L_for_period___Net_income__EU6 
rename FK P_L_for_period___Net_income__EU7

rename SolvencyratioAssetbased2 Solvency_ratio__Asset_based____2 
rename GW Solvency_ratio__Asset_based____0 
rename GX Solvency_ratio__Asset_based____1 
rename GY Solvency_ratio__Asset_based____3 
rename GZ Solvency_ratio__Asset_based____4 
rename HA Solvency_ratio__Asset_based____5 
rename HB Solvency_ratio__Asset_based____6 
rename HC Solvency_ratio__Asset_based____7 
rename HD Solvency_ratio__Asset_based____8

rename OperatingrevenueTurnoverEUR Operating_revenue__Turnover__EUR 
rename BI Operating_revenue__Turnover__EU0 
rename BJ Operating_revenue__Turnover__EU1 
rename BK Operating_revenue__Turnover__EU2 
rename BL Operating_revenue__Turnover__EU3 
rename BM Operating_revenue__Turnover__EU4 
rename BN Operating_revenue__Turnover__EU5 
rename BO Operating_revenue__Turnover__EU6 
rename BP Operating_revenue__Turnover__EU7


forval j = 2008/2016 { 
	rename FinancialrevenueEUR`j' Financial_revenue_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename InterestpaidEUR`j' Interest_paid_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename CashflowEUR`j' Cash_flow_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename EBITDAEUR`j' EBITDA_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename TotalassetsEUR`j' Total_assets_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename LongtermdebtEUR`j' Long_term_debt_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename Numberofemployees`j' Number_of_employees_`j'	 
}

forval j = 2008/2016 { 
	rename AddedvalueEUR`j' Added_value_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename MaterialcostsEUR`j' Material_costs_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename CostsofemployeesEUR`j' Costs_of_employees_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename FixedassetsEUR`j' Fixed_assets_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename LoansEUR`j' Loans_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename IntangiblefixedassetsEUR`j' Intangible_fixed_assets_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename TaxationEUR`j' Taxation_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename RetainedEarningsEUR`j' Retained_Earnings_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename EnterpriseValueEUR`j' Enterprise_Value_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename CurrentliabilitiesEUR`j' Current_liabilities_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename CurrentassetsEUR`j' Current_assets_EUR_`j'	 
}

forval j = 2008/2016 { 
	rename Liquidityratio`j' Liquidity_ratio_`j'	 
}

cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data"
save orbis_export_172.dta, replace

