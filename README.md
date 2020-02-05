# Code for the paper "Machine learning for zombie hunting"

In this repository we provide the code for the data analysis part of the paper _"Machine learning for zombie hunting. Firms' failures, financial constraints, and misallocation"_ by F.J. Bargagli-Stoffi, M. Riccaboni and A. Rungi.

The code is written both in <tt>`Stata`</tt> and <tt>`R`</tt>. The data cleaning and the creation of the indicators were performed in Stata. R was used for the machine learning analysis.

Below a brief legend of the Data and the <tt>`Stata`</tt> and <tt>`R`</tt> code files. 

# Data

First, we downloaded data on firm level characteristics and financial accounts for  803,227 enterprises (2008-2018) in Italy, Germany, Spain, France, Great Britain, Poland, Portugal, Romania and Sweden from the ORBIS database (Bureau Van Dijk). The variables that we downloaded are the following: 

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
* <tt>`revenus`</tt>: sales in Euro;
* <tt>`payables`</tt>: tax and pension payables in Euro (2009-2016).

# Stata Code

The <tt>`Stata`</tt> code files can be found </b> [<a href="https://github.com/barstoff/ml-zombie-hunting/tree/master/Stata_code">here</a>]. The files are devided in three folders:
* <tt>`merging_and_cleaning_data`</tt>;
* <tt>`creating_indicators`</tt>;
* <tt>`descriptives`</tt>.
The files in the the first two folder can be run following their numbering to create the dataset used for the ML analysis.

Within the <tt>`merging_and_cleaning_data`</tt> folder you can find the following files:
* <tt>`00_correcting_corrupted_data`</tt>: code to correct the corrupted Orbis files;
* <tt>`01_appending_data`</tt>: code to append the data;
* <tt>`02_data_cleaning`</tt>: code to clean data.
As the data come in 201 different <tt>`.dta`</tt> files, the first two code files are used to correct the corrupted data files and append them to get the initial dataset.
The <tt>`02_data_cleaning`</tt> file is used to rename the variables and exclude countries that have scarce representativity (i.e., Great Britain, Poland, Germany, Romania, Sweden) and duplicate observations.

Within the <tt>`creating_indicators`</tt> folder you can find the following files:
* <tt>`03_failure_and_time_variables`</tt>: code to create the outcome variable and the time related variables;
* <tt>`04_lagged_variables`</tt>: code to create lagged variables;
* <tt>`05_indicators`</tt>: code to create the indicators used in the ML analysis;
* <tt>`06_tfp`</tt>: code to generate the total factor productivity.
N.B. The lagged variables were created to perform a general model. Indeed, the lagged variable assumes the values of the correspondig variable at "t-1". "t" is either the censorship time for those firms that did not fail in the time span of the analysis (2008-2018) or the failure time for those firms that failed in the same time span.

Within the <tt>`descriptives`</tt> folder you can find the following files:
* <tt>`descriptives`</tt>: code to create general descriptive statistics (later I will add more detailed references to the papers tables);
* <tt>`eurostat_vs_orbis`</tt>: code to compare orbis data with Eurostat;
* <tt>`eurostat_vs_orbis_MSE`</tt>: code to compare orbis data with Eurostat with the proposed MSE methodology;
* <tt>`zombies_descriptives`</tt>: code to create general descriptive statistics for the zombie firms (after the ML analysis).

