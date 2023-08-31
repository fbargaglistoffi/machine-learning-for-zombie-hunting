# Code for the paper "Machine Learning for Zombie Hunting"

In this repository, we provide the code for the data analysis part of the paper [_"Machine Learning for Zombie Hunting:
Predicting Distress from Firms’ Accounts and Missing Values"_](https://arxiv.org/pdf/2306.08165.pdf) by F.J. Bargagli-Stoffi, F. Incerti, M. Riccaboni and A. Rungi. <br />

The code is written both in <tt>`Stata`</tt> and <tt>`R`</tt>. The data cleaning, the creation of the indicators, the Logit missingness and LOGIT-LASSO analyses were performed in <tt>`Stata`</tt>. <tt>`R`</tt> was used for the machine learning analyses.

Below is a brief legend of the data and the <tt>`Stata`</tt> and <tt>`R`</tt> code files. If you use this code, in any of its parts, please make sure to cite the original paper (please see the reference below).

# Data

Unfortunately, we are unable to disclose the data used for our application due to our privacy policy agreement with (Bureau Van Dijk)[https://www.bvdinfo.com/en-us/]. However, we provide detailed information on which data were downloaded below.

First, we downloaded data on firm-level characteristics and financial accounts for around 300,000 enterprises in Italy from the ORBIS database (Bureau Van Dijk). The status data (e.g., active firms, bankrupted firms, etc.) are available for the years 2008-2018 (first four months), while financial account data are available for the year 2008-2016.

The variables that we downloaded are the following: 

* <tt>`id`</tt>: firm's id;
* <tt>`guo`</tt>: global ultimate owner;
* <tt>`iso`</tt>: country indicator;
* <tt>`region`</tt>: region indicator;
* <tt>`city`</tt>: city indicator;
* <tt>`nut`</tt>: "Nomenclature des unités territoriales statistiques" (country and region reference numbers);
* <tt>`conscode`</tt>: consolidate financial account indicator;
* <tt>`nace`</tt>: the Statistical classification of economic activities in the European Community;
* <tt>`Number_of_patents`</tt>: number of patents issued by a certain firm;
* <tt>`Number_of_trademarks`</tt>: number of trademarks issued by a certain firm;
* <tt>`naics`</tt>: North American Industry Classification System;
* <tt>`shareholders_funds`</tt>: shareholders funds in Euro;
* <tt>`retained_earnings`</tt>: retained earnings in Euro;
* <tt>`added_value`</tt>: added value in Euro;
* <tt>`cash_flow`</tt>: cash flow in Euro;
* <tt>`ebitda`</tt>: earnings before interest, taxation, depreciation and amortization in Euro;
* <tt>`financial_revenues`</tt>: financial revenues in Euro;
* <tt>`liquidity_ratio`</tt>: liquidity ratio;
* <tt>`total_assets`</tt>: total assets in Euro;
* <tt>`deprecitation_ammortization`</tt>: depreciation and amortization in Euro;
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
* <tt>`revenues`</tt>: sales in Euro;
* <tt>`payables`</tt>: tax and pension payables in Euro (2009-2016).

After running the files in the <tt>`creating_indicators_and_cleaning_data`</tt> folder we add the following additional indicators to the dataset:
* <tt>`tfp_acf`</tt>: total factor productivity computed as in [Ackerberg, Caves and Frazer, 2006](https://mpra.ub.uni-muenchen.de/38349/);
* <tt>`consdummy`</tt>: dummy variable assuming value 1 if the financial account is consolidated and 0 otherwise;
* <tt>`capital_intensity`</tt>: ratio of fixed assets over employees;
* <tt>`labour_productivity`</tt>: ratio of added value over employees;
* <tt>`fin_cons`</tt>: financial constraint indicator by [Nickell and Nicolitsas, 1999](https://econpapers.repec.org/article/eeeeecrev/v_3a43_3ay_3a1999_3ai_3a8_3ap_3a1435-1456.html);
* <tt>`inv`</tt>: investments indicator computed as the sum between depreciation at time t and the difference between fixed assets at time t and t-1;
* <tt>`ICR`</tt>: interest coverage ratio computed as the ratio between EBIT and interests paid;
* <tt>`ICR_failure`</tt>: indicator variable equal to 1 if <tt>`ICR`</tt><= 1 by [Bank of England, 2013](https://www.bankofengland.co.uk/inflation-report/2013/august-2013);
* <tt>`interest_diff`</tt>: benchmark interest difference indicator by [Caballero, 2008](https://www.aeaweb.org/articles?id=10.1257/aer.98.5.1943);
* <tt>`NEG_VA`</tt>: negative added value indicator by Bank of Korea, 2013;
* <tt>`real_SA`</tt>: size-age indicator by [Handlock and Pierce, 2010](https://academic.oup.com/rfs/article-abstract/23/5/1909/1602852?redirectedFrom=PDF); 
* <tt>`Z_score`</tt>: Altman Z-score by [Altman, 2000](http://pages.stern.nyu.edu/~ealtman/Zscores.pdf);
* <tt>`misallocated`</tt>: misallocated capital indicator by [Schivardi et al, 2017](https://www.bis.org/publ/work669.pdf);
* <tt>`profitability`</tt>: profitability indicator by [Schivardi et al, 2017](https://www.bis.org/publ/work669.pdf);
* <tt>`area`</tt>: area of Italy (North, Center, South, Islands);
* <tt>`dummy_patents`</tt>: dummy variable assuming value 1 if the enterprise issued at least one patent and 0 otherwise;
* <tt>`dummy_trademark`</tt>: dummy variable assuming value 1 if the enterprise issued at least one trademark and 0 otherwise;
* <tt>`financial_sustainability`</tt>: ratio of financial expenses over revenues;
* <tt>`car`</tt>: capital adequacy ratio: ratio of shareholder funds over the sum of short and long-term debt;
* <tt>`liquidity_return`</tt>: ratio of cash flow over total assets;
* <tt>`pension_tax_debts`</tt>: ratio of the sum of tax and pension payables over total assets (available for years between 2009-2016).

# Stata Code

The <tt>`Stata`</tt> code files can be found </b>[<a href="https://github.com/barstoff/ml-zombie-hunting/tree/master/Stata_code">here</a>]. The files are divided in five folders:
* <tt>`generating_and_merging_data`</tt>;
* <tt>`creating_indicators_and_cleaning_data`</tt>;
* <tt>`lasso_analyses`</tt>;
* <tt>`logit_missingness_analyses`</tt>;
* <tt>`productivity_zombie`</tt>.

The files in the first two folders can be run following their numbering to create the dataset used for the ML analysis.

Within the <tt>`generating_and_merging_data`</tt> folder you can find the following files:
* <tt>`00.1_generate_data_on_payables.do`</tt>: code to generate variables needed for indicators from AIDA;
* <tt>`00.2_generate_data_on_tfp.do`</tt>: code to generate the total factor productivity data;
* <tt>`00.3_correcting_corrupted_data`</tt>: code to correct the corrupted Orbis files;
* <tt>`01_appending_data`</tt>: code to append the data;
* <tt>`02_variables_renaming`</tt>: code to rename variable. <br />
As the data come in 201 different <tt>`.dta`</tt> files, the first two code files are used to correct the corrupted data files and append them to get the initial dataset.  <br />
N.B.1 The <tt>`02_variables_renaming`</tt> file is also used to exclude non-Italian firms and duplicate observations.  <br />
N.B.2 The output of the <tt>`generating_and_merging_data`</tt> files is the <tt>`analysis_data.dta`</tt> file.

Within the <tt>`creating_indicators_and_cleaning_data`</tt> folder you can find the following files:
* <tt>`03_failure_and_time_variables`</tt>: code to create the outcome variable and the time-related variables;
* <tt>`04_lagged_variables`</tt>: code to create lagged variables;
* <tt>`05_indicators`</tt>: code to create the indicators used in the ML analysis. <br />
N.B.1 The lagged variables were created to run a series of machine learning models with lagger predictors used to assess the performance of each model. In particular, the lagged variable assumes the values of the corresponding variable at "t-1", where "t" is either the censorship time for those firms that did not fail in the time span of the analysis (2008-2018), or the failure time for those firms that failed in the same time span. <br />
N.B.2. The data cleaning is performed in multiple do files and not just in one specific file.

Within the <tt>`logit_lasso_analyses`</tt> folder, you can find the code to extract the set of predictors with the highest ability to detect financial distress with the LOGIT-LASSO model (the results are used for Table C.1).

Within the <tt>`logit_missingness_analyses`</tt> folder, you can find the code for the logit missingness analyses (the results are depicted in Table 2).

Within the <tt>`productivity_zombie`</tt> folder, you can find the code to create Table 6 (Productivity and size premia for healthy firms vs. zombies).


# R code

The <tt>`R`</tt> code files can be found </b> [<a href="https://github.com/barstoff/ml-zombie-hunting/tree/master/R_code">here</a>]. The files are divided into four folders:
* <tt>`functions`</tt>;
* <tt>`lagged_analysis`</tt>;
* <tt>`Shapley`</tt>;
* <tt>`year_by_year_analyses`</tt>.

Within the <tt>`functions`</tt> folder, you can find the main functions used in the analyses (Distance-to-Default, F1-Score, Balanced Accuracy, Models Comparisons and others).

Within the <tt>`lagged_analysis`</tt> folder, you can find the code to reproduce the lagged machine learning analyses (Tables 3, 4, D.1, D.2; Figure 4).

Within the <tt>`year_by_year_analyses`</tt> folder you can find the following files:
* <tt>`year_by_year.R`</tt>: R code to reproduce the yearly machine learning analyses (Tables A.3, A.4; Figures 9, 10, A.2);
* <tt>`generate_categories.R`</tt>: R code to generate transitions across deciles of risk (Table 5), transitions of zombies to other risk categories (Figure 8) and to create the panel dataset for Table 6.
 

# References

Machine Learning for Zombie Hunting ([paper](https://arxiv.org/abs/2306.08165))
```
@article{bargagli2023machine,
  title={Machine Learning for Zombie Hunting: Predicting Distress from Firms' Accounts and Missing Values},
  author={Bargagli-Stoffi, Falco J and Incerti, Fabio and Riccaboni, Massimo and Rungi, Armando},
  journal={arXiv preprint arXiv:2306.08165},
  year={2023}
}={2023}
}
```



