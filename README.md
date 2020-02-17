# Code for the paper "Machine learning for zombie hunting"

In this repository we provide the code for the data analysis part of the paper _"Machine learning for zombie hunting. Firms' failures, financial constraints, and misallocation"_ by F.J. Bargagli-Stoffi, M. Riccaboni and A. Rungi. <br />
The code is written both in <tt>`Stata`</tt> and <tt>`R`</tt>. The data cleaning and the creation of the indicators were performed in <tt>`Stata`</tt>. <tt>`R`</tt> was used for the machine learning analysis.

Below a brief legend of the Data and the <tt>`Stata`</tt> and <tt>`R`</tt> code files. 

# Data

First, we downloaded data on firm level characteristics and financial accounts for 803,227 enterprises in Italy, Germany, Spain, France, Great Britain, Poland, Portugal, Romania and Sweden from the ORBIS database (Bureau Van Dijk). The status data (e.g., active firms, bankrupted firms, etc.) are available for the years 2008 - 2018, while financial account data are available for the year 2008-2016.
The variables that we downloaded are the following: 

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

After running the files in the <tt>`creating_indicators_and_cleaning_data`</tt> folder we add the following additional indicators to the dataset:
* <tt>`capital intensity`</tt>: ratio of fixed assets over employees;
* <tt>`labour_productivity`</tt>: ratio of added value over employees;
* <tt>`fin_cons`</tt>: financial constraint indicator by [Nickell and Nicolitsas, 1999](https://econpapers.repec.org/article/eeeeecrev/v_3a43_3ay_3a1999_3ai_3a8_3ap_3a1435-1456.html);
* <tt>`inv`</tt>: investments indicator computed as the sum between depreciation at time t and the difference between fixed assets at time t and t-1 ;
* <tt>`ICR`</tt>: interest coverage ratio computed as the ratio between EBIT and interest paid;
* <tt>`ICR_failure`</tt>: indicator variable equal to 1 if <tt>`ICR`</tt><= 1 by [Bank of England, 2013](https://www.bankofengland.co.uk/inflation-report/2013/august-2013);
* <tt>`interest_diff`</tt>: benchmark interest difference indicator by [Caballero, 2008](https://www.aeaweb.org/articles?id=10.1257/aer.98.5.1943);
* <tt>`NEG_VA`</tt>: negative added value indicator by [Bank of Korea, 2013];
* <tt>`real_SA`</tt>: size-age indicator by ; 
* <tt>`Z_score`</tt>: Altman Z-score by [Altman, 2000](http://pages.stern.nyu.edu/~ealtman/Zscores.pdf);
* <tt>`misallocated`</tt>: misallocated capital indicator by [Schivardi et al, 2017](https://www.bis.org/publ/work669.pdf);
* <tt>`profitability`</tt>: profitability indicator by [Schivardi et al, 2017](https://www.bis.org/publ/work669.pdf);
* <tt>`area`</tt>: area of Italy (north, center, south, island);
* <tt>`dummy_patents`</tt>: dummy variable assuming value 1 if the enterprise issued at leas one patent and 0 otherwise;
* <tt>`dummy_trademark`</tt>: dummy variable assuming value 1 if the enterprise issued at leas one trademark and 0 otherwise;
* <tt>`financial_sustainability`</tt>: ratio of financial expenses over revenues;
* <tt>`car`</tt>: capital adeguacy ratio: ratio of shareholder funds over the sum of short and long term debt;
* <tt>`liquidity_Return`</tt>: ratio of cash flow over total assets;
* <tt>`pension_tax_debts`</tt>: ratio of the sum of tax and pension payables over total assets (available for years between 2009-2016).

# Stata Code

The <tt>`Stata`</tt> code files can be found </b> [<a href="https://github.com/barstoff/ml-zombie-hunting/tree/master/Stata_code">here</a>]. The files are devided in three folders:
* <tt>`generating_and_merging_data`</tt>;
* <tt>`creating_indicators_and_cleaning_data`</tt>;
* <tt>`descriptives`</tt>.
The files in the the first two folder can be run following their numbering to create the dataset used for the ML analysis.

Within the <tt>`generating_and_merging_data`</tt> folder you can find the following files:
* <tt>`00.1_generate_data_on_payables.do`</tt>: code to generate variables needed for indicators from AIDA;
* <tt>`00.2_generate_data_on_tfp.do`</tt>: code to generate the total factor productivity data;
* <tt>`00.3_correcting_corrupted_data`</tt>: code to correct the corrupted Orbis files;
* <tt>`01_appending_data`</tt>: code to append the data;
* <tt>`02_variables_renaming`</tt>: code to rename variable. <br />
As the data come in 201 different <tt>`.dta`</tt> files, the first two code files are used to correct the corrupted data files and append them to get the initial dataset.  <br />
N.B.1 The <tt>`02_variables_renaming`</tt> file is used also to exclude countries that have scarce representativity (i.e., Great Britain, Poland, Germany, Romania, Sweden) and duplicate observations.  <br />
N.B.2 The output of the <tt>`generating_and_merging_data`</tt> files is the <tt>`analysis_data.dta`</tt> file.

Within the <tt>`creating_indicators_and_cleaning_data`</tt> folder you can find the following files:
* <tt>`03_failure_and_time_variables`</tt>: code to create the outcome variable and the time related variables;
* <tt>`04_lagged_variables`</tt>: code to create lagged variables;
* <tt>`05_indicators`</tt>: code to create the indicators used in the ML analysis. <br />
N.B.1 The lagged variables were created to run a series of machine learning models with lagger predictors used to assess the performance of each model. In particular, the lagged variable assumes the values of the corresponding variable at "t-1", where "t" is either the censorship time for those firms that did not fail in the time span of the analysis (2008-2018), or the failure time for those firms that failed in the same time span. <br />
N.B.2 The data cleaning is performed in multiple do files and not just in one specific file.

Within the <tt>`descriptives`</tt> folder you can find the following files:
* <tt>`descriptives`</tt>: code to create general descriptive statistics (later I will add more detailed references to the papers tables);
* <tt>`eurostat_vs_orbis`</tt>: code to compare orbis data with Eurostat;
* <tt>`eurostat_vs_orbis_MSE`</tt>: code to compare orbis data with Eurostat with the proposed MSE methodology;
* <tt>`zombies_descriptives`</tt>: code to create general descriptive statistics for the zombie firms (after the ML analysis).

