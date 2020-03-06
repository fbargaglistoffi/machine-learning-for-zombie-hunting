* Zombie Descriptives 
clear all 
cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data"

* Upload Data
use zombie_data, clear

keep if iso=="IT"

* Table
tab zombie_2011 if zombie_2011!="."

/*
     zombie_2011 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      7,278        3.85        3.85
Medium-High Risk |      4,600        2.44        9.62
     Medium Risk |      3,567        1.89        7.19
 Medium-Low Risk |      3,435        1.82       11.44
        Low Risk |      2,721        1.44        5.30
       No Zombie |    167,195       88.56      100.00
-----------------+-----------------------------------
           Total |    188,796      100.00
*/


* Zombie 2011
*Cumulative added value
egen sum_va_h = sum(added_value_2011) if zombie_2011=="High Risk" ///
& (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_va_h /* 89,853.092 per firm */

egen sum_va_mh = sum(added_value_2011) if zombie_2011=="Medium-High Risk" ///
& (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_va_mh /* 232,508.83 per firm */

egen sum_va_m = sum(added_value_2011) if zombie_2011=="Medium Risk" ///
& (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_va_m /* 254,970.76 per firm */

egen sum_va_ml = sum(added_value_2011) if zombie_2011=="Medium-Low Risk" ///
& (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_va_ml /* 415,929.2 per firm */

egen sum_va_l = sum(added_value_2011) if zombie_2011=="Low Risk" ///
& (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_va_l /* 392,771.08 per firm */

egen sum_va_no = sum(added_value_2011) if zombie_2011=="No Zombie" 
su sum_va_no /* 1,130,416.6 per firm */

*Cumulative Employees
egen sum_employees_h = sum(employees_2011) if zombie_2011=="High Risk" ///
& (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_employees_h /* 4.4031 per firm */

egen sum_employees_mh = sum(employees_2011) if zombie_2011=="Medium-High Risk" ///
& (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_employees_mh /* 6.9144876 per firm */

egen sum_employees_m = sum(employees_2011) if zombie_2011=="Medium Risk" ///
& (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_employees_m /* 7.3181287 per firm */

egen sum_employees_ml = sum(employees_2011) if zombie_2011=="Medium-Low Risk" ///
& (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_employees_ml /* 9.7566372 per firm */

egen sum_employees_l = sum(employees_2011) if zombie_2011=="Low Risk" ///
&    & (failure_2012==1 | failure_2013==1 | ///
failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
su sum_employees_l /* 9.7373494 per firm */

egen sum_employees_no = sum(employees_2011) if zombie_2011=="No Zombie"
su sum_employees_no /* 16.913281 per firm */
