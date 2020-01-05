*Analysis of Zombies 

tab zombie_it_2011_2009 if drop_it_2009==3 & drop_it_2010==3 

count if zombie_it_2011_2009!="." & drop_it_2009==3 & drop_it_2010==3 
count if zombie_it_2011_2009!="." & drop_it_2009==3 & drop_it_2010==3  & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
/* 38.24 % overall */

count if zombie_it_2011_2009=="High Risk" & drop_it_2009==3 & drop_it_2010==3 
count if zombie_it_2011_2009=="High Risk" & drop_it_2009==3 & drop_it_2010==3  & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
/* 47.32% within high risk */

count if zombie_it_2011_2009=="Medium-High Risk" & drop_it_2009==3 & drop_it_2010==3 
count if zombie_it_2011_2009=="Medium-High Risk" & drop_it_2009==3 & drop_it_2010==3  & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
/* 39.38% within medium-high risk */

count if zombie_it_2011_2009=="Medium Risk" & drop_it_2009==3 & drop_it_2010==3 
count if zombie_it_2011_2009=="Medium Risk" & drop_it_2009==3 & drop_it_2010==3 & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
/* 35.78% within medium risk */

count if zombie_it_2011_2009=="Medium-Low Risk" & drop_it_2009==3 & drop_it_2010==3 
count if zombie_it_2011_2009=="Medium-Low Risk" & drop_it_2009==3 & drop_it_2010==3 & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
/* 27.41% within medium low risk*/

count if zombie_it_2011_2009=="Low Risk" & drop_it_2009==3 & drop_it_2010==3 
count if zombie_it_2011_2009=="Low Risk" & drop_it_2009==3 & drop_it_2010==3 & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
/* 26.59% within low risk */

count if zombie_it_2011_2009=="." & drop_it_2009==3 & drop_it_2010==3 
count if zombie_it_2011_2009=="." & drop_it_2009==3 & drop_it_2010==3  & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
/* 8.29% within no risk */

*Futile Procedures: ACTIVE (insolvent/default)
tab Status if zombie_it_2011_2009=="High Risk" & drop_it_2009==3 & drop_it_2010==3

tab Status if zombie_it_2011_2009=="Medium-High Risk" & drop_it_2009==3 & drop_it_2010==3

tab Status if zombie_it_2011_2009=="Medium Risk" & drop_it_2009==3 & drop_it_2010==3

tab Status if zombie_it_2011_2009=="Medium-Low Risk" & drop_it_2009==3 & drop_it_2010==3

tab Status if zombie_it_2011_2009=="Low Risk" & drop_it_2009==3 & drop_it_2010==3

tab Status if zombie_it_2011_2009=="." & drop_it_2009==3 & drop_it_2010==3

*Cumulative probability not feasible because of bias in record of failures (more records in recent years)

*Cumulative debt
egen sum_debt_h = sum(long_term_debt_2011) if zombie_it_2011_2009=="High Risk" ///
& drop_it_2009==3 & drop_it_2010==3  & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_debt_h /* 1.97e+08: 125878.59 per firm */

egen sum_debt_mh = sum(long_term_debt_2011) if zombie_it_2011_2009=="Medium-High Risk" ///
& drop_it_2009==3 & drop_it_2010==3  & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_debt_mh /* 2.45e+08: 339805.83 per firm */

egen sum_debt_m = sum(long_term_debt_2011) if zombie_it_2011_2009=="Medium Risk" ///
& drop_it_2009==3 & drop_it_2010==3  & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_debt_m /* 3.93e+07: 62085.308 per firm */

egen sum_debt_ml = sum(long_term_debt_2011) if zombie_it_2011_2009=="Medium-Low Risk" ///
& drop_it_2009==3 & drop_it_2010==3  & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_debt_ml /* 4.30e+07: 119113.57 per firm */

egen sum_debt_l = sum(long_term_debt_2011) if zombie_it_2011_2009=="Low Risk" ///
& drop_it_2009==3 & drop_it_2010==3  & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_debt_l /* 1.61e+07: 52103.56 per firm */

egen sum_debt_no = sum(long_term_debt_2011) if zombie_it_2011_2009=="." ///
& drop_it_2009==3 & drop_it_2010==3  & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_debt_no /* 575994 per firm */

*Cumulative added value
egen sum_va_h = sum(added_value_2011) if zombie_it_2011_2009=="High Risk" ///
& drop_it_2009==3 & drop_it_2010==3  & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_va_h /* 56357.827 per firm */

egen sum_va_mh = sum(added_value_2011) if zombie_it_2011_2009=="Medium-High Risk" ///
& drop_it_2009==3 & drop_it_2010==3  & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_va_mh /* 178918.17 per firm */

egen sum_va_m = sum(added_value_2011) if zombie_it_2011_2009=="Medium Risk" ///
& drop_it_2009==3 & drop_it_2010==3  & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_va_m /* 115007.9 per firm */

egen sum_va_ml = sum(added_value_2011) if zombie_it_2011_2009=="Medium-Low Risk" ///
& drop_it_2009==3 & drop_it_2010==3  & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_va_ml /* 21009.285 per firm */

egen sum_va_l = sum(added_value_2011) if zombie_it_2011_2009=="Low Risk" ///
& drop_it_2009==3 & drop_it_2010==3  & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_va_l /* 96440.129 per firm */

egen sum_va_no = sum(added_value_2011) if zombie_it_2011_2009=="." ///
& drop_it_2009==3 & drop_it_2010==3  & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_va_no /* 888710.05 per firm */

*Cumulative Employees
egen sum_employees_h = sum(employees_2011) if zombie_it_2011_2009=="High Risk" ///
& drop_it_2009==3 & drop_it_2010==3  & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_employees_h /* 2.886262 per firm */

egen sum_employees_mh = sum(employees_2011) if zombie_it_2011_2009=="Medium-High Risk" ///
& drop_it_2009==3 & drop_it_2010==3  & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_employees_mh /* 8.4563107 per firm */

egen sum_employees_m = sum(employees_2011) if zombie_it_2011_2009=="Medium Risk" ///
& drop_it_2009==3 & drop_it_2010==3  & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_employees_m /* 3.9052133 per firm */

egen sum_employees_ml = sum(employees_2011) if zombie_it_2011_2009=="Medium-Low Risk" ///
& drop_it_2009==3 & drop_it_2010==3  & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_employees_ml /* 6.0581717 per firm */

egen sum_employees_l = sum(employees_2011) if zombie_it_2011_2009=="Low Risk" ///
& drop_it_2009==3 & drop_it_2010==3  & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_employees_l /* 3.0420712 per firm */

egen sum_employees_no = sum(employees_2011) if zombie_it_2011_2009=="." ///
& drop_it_2009==3 & drop_it_2010==3  & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_employees_no /* 15.898023 per firm */
