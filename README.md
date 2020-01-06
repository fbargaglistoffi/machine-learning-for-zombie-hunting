# Code for the paper "Machine learning for zombie hunting"

In this repository we provide the code for the data analysis part of the paper _"Machine learning for zombie hunting. Firms' failures, financial constraints, and misallocation"_ by F.J. Bargagli-Stoffi, M. Riccaboni and A. Rungi.

The code is written both in Stata and R. The data cleaning and the creation of the indicators were performed in Stata. R was used for the machine learning analysis.

Below a brief legend of the Stata files. 

# Data

First, we downloaded data on firm level characteristics and financial accounts for  803,227 enterprises in Italy, Germany, Spain, France, Great Britain, Poland, Portugal, Romania and Sweden from the ORBIS database (Bureau Van Dijk). The variables that we downloaded are the following: 

* <tt>`id`</tt>: firm's id;
* <tt>`guo`</tt>: global ultimate owner;
* <tt>`iso`</tt>: country indicator;
* <tt>`region`</tt>: region indicator;
* <tt>`city`</tt>: city indicator;
* <tt>`nut`</tt>: "Nomenclature des unités territoriales statistiques" (country and region reference numbers);
* <tt>`conscode`</tt>: consolidate financial account indicator;
* <tt>`nace`</tt>: the Statistical classification of economic activities in the European Community;
* <tt>`naics`</tt>: North American Industry Classification System;
* <tt>`shareholders_funds`</tt>: shareholders funds in Euro;
* <tt>`retained_earnings`</tt>: retained earnings in Euro;
* <tt>`added_value`</tt>: added value in Euro;
* <tt>`cash_flow`</tt>: cash flow in Euro;
* <tt>`ebitda`</tt>: earnings before interest, taxation, depreciation and ammortization in Euro;
* <tt>`financial_revenues`</tt>: financial revenues in Euro;
* <tt>`liquidity_ratio`</tt>: liquidity ratio;
* <tt>`total_assets`</tt>: total assets in Euro;
* <tt>`deprecitation_ammortization`</tt>: depretiaction and ammortization in Euro;
* <tt>`operating_revenue_turnover`</tt>: turnover in Euro;
* <tt>`long_term_debt`</tt>: long term debt in Euro;
* <tt>`employees`</tt>: number of employees;
* <tt>`enterprise_value`</tt>: firm's value in Euro;
* <tt>`material_costs`</tt>: cost of materials in Euro;
* <tt>`costs_of_employees`</tt>: cost for salaries in Euro;
* <tt>`loans`</tt>: loans expenses in Euro;
* <tt>`fixed_assets`</tt>: fixed assets expenses in Euro;
* <tt>`intangible_fixed_assets`</tt>: intangible fixed assets expenses in Euro; 
* <tt>`taxation`</tt>: tax related expenses;
* <tt>`current_liabilities`</tt>: current liabilities in Euro;
* <tt>`current_assets`</tt>: current assets in Euro;
* <tt>`financial_expenses`</tt>: financial expenses in Euro;
* <tt>`interest_paid`</tt>: interests paid in Euro;
* <tt>`solvency_ratio`</tt>: firm's solvency ratio;
* <tt>`net_income`</tt>: net income in Euro;
* <tt>`depreciation`</tt>: depreciation in Euro;
* <tt>`revenus`</tt>: sales in Euro.

# Stata Code
