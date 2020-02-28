*Zombie Indicator
clear all 
cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data"

use "data_categories", clear

*Generate Zombie (ruling out START UPS) 2015-2017
gen zombie_2017="."
replace zombie_2017="No Zombie" if failure_2017==0 & failure_2016==0 & failure_2015==0
replace zombie_2017="High Risk" if cat_2015==1 & cat_2016==1 & cat_2017==1 & failure_2017==0 & failure_2016==0 & failure_2015==0 & year_of_incorporation<2015 
replace zombie_2017="Medium-High Risk" if cat_2015==2 & cat_2016==1 & cat_2017==1 & failure_2017==0 & failure_2016==0 & failure_2015==0 & year_of_incorporation<2015 
replace zombie_2017="Medium-High Risk" if cat_2015==1 & cat_2016==2 & cat_2017==1 & failure_2017==0 & failure_2016==0 & failure_2015==0 & year_of_incorporation<2015 
replace zombie_2017="Medium Risk" if cat_2015==2 & cat_2016==2 & cat_2017==1 & failure_2017==0 & failure_2016==0 & failure_2015==0 & year_of_incorporation<2015
replace zombie_2017="Medium Risk" if cat_2015==1 & cat_2016==1 & cat_2017==2 & failure_2017==0 & failure_2016==0 & failure_2015==0 & year_of_incorporation<2015 
replace zombie_2017="Medium-Low Risk" if cat_2015==1 & cat_2016==2 & cat_2017==2 & failure_2017==0 & failure_2016==0 & failure_2015==0 & year_of_incorporation<2015 
replace zombie_2017="Medium-Low Risk" if cat_2015==2 & cat_2016==1 & cat_2017==2 & failure_2017==0 & failure_2016==0 & failure_2015==0 & year_of_incorporation<2015 
replace zombie_2017="Low Risk" if cat_2015==2 & cat_2016==2 & cat_2017==2 & failure_2017==0 & failure_2016==0 & failure_2015==0 & year_of_incorporation<2015
tab zombie_2017

/*

*/

tab zombie_2017 if iso=="IT"

/*

*/

gen dummy_2017=.
replace dummy_2017=1 if zombie_2017=="High Risk" | zombie_2017=="Medium-High Risk" | zombie_2017=="Medium Risk" | zombie_2017=="Medium-Low Risk" | zombie_2017=="Low Risk"
replace dummy_2017=0 if zombie_2017=="No Zombie" 
tab dummy_2017

/*

*/

tab dummy_2017 if iso=="IT"

/*

*/

*Generate Zombie (ruling out START UPS) 2014-2016
gen zombie_2016="."
replace zombie_2016="No Zombie" if failure_2016==0 & failure_2015==0 & failure_2014==0
replace zombie_2016="High Risk" if cat_2014==1 & cat_2015==1 & cat_2016==1 & failure_2016==0 & failure_2015==0 & failure_2014==0 & year_of_incorporation<2014 
replace zombie_2016="Medium-High Risk" if cat_2014==2 & cat_2015==1 & cat_2016==1 & failure_2016==0 & failure_2015==0 & failure_2014==0 & year_of_incorporation<2014 
replace zombie_2016="Medium-High Risk" if cat_2014==1 & cat_2015==2 & cat_2016==1 & failure_2016==0 & failure_2015==0 & failure_2014==0 & year_of_incorporation<2014 
replace zombie_2016="Medium Risk" if cat_2014==2 & cat_2015==2 & cat_2016==1 & failure_2016==0 & failure_2015==0 & failure_2014==0 & year_of_incorporation<2014 
replace zombie_2016="Medium Risk" if cat_2014==1 & cat_2015==1 & cat_2016==2 & failure_2016==0 & failure_2015==0 & failure_2014==0 & year_of_incorporation<2014 
replace zombie_2016="Medium-Low Risk" if cat_2014==1 & cat_2015==2 & cat_2016==2 & failure_2016==0 & failure_2015==0 & failure_2014==0 & year_of_incorporation<2014 
replace zombie_2016="Medium-Low Risk" if cat_2014==2 & cat_2015==1 & cat_2016==2 & failure_2016==0 & failure_2015==0 & failure_2014==0 & year_of_incorporation<2014 
replace zombie_2016="Low Risk" if cat_2014==2 & cat_2015==2 & cat_2016==2 & failure_2016==0 & failure_2015==0 & failure_2014==0 & year_of_incorporation<2014 
tab zombie_2016

/*

*/

tab zombie_2016 if iso=="IT"

/*

*/

gen dummy_2016=.
replace dummy_2016=1 if zombie_2016=="High Risk" | zombie_2016=="Medium-High Risk" | zombie_2016=="Medium Risk" | zombie_2016=="Medium-Low Risk" | zombie_2016=="Low Risk"
replace dummy_2016=0 if zombie_2016=="No Zombie" 
tab dummy_2016

/*

*/

tab dummy_2016 if iso=="IT"

/*

*/

*Generate Zombie (ruling out START UPS) 2013-2015
gen zombie_2015="."
replace zombie_2015="No Zombie" if failure_2013==0 & failure_2015==0 & failure_2014==0
replace zombie_2015="High Risk" if cat_2013==1 & cat_2014==1 & cat_2015==1 & failure_2014==0 & failure_2015==0 & failure_2013==0 & year_of_incorporation<2013 
replace zombie_2015="Medium-High Risk" if cat_2013==2 & cat_2014==1 & cat_2015==1 & failure_2015==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2013 
replace zombie_2015="Medium-High Risk" if cat_2013==1 & cat_2014==2 & cat_2015==1 & failure_2015==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2013 
replace zombie_2015="Medium Risk" if cat_2013==2 & cat_2014==2 & cat_2015==1 & failure_2015==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2013 
replace zombie_2015="Medium Risk" if cat_2013==1 & cat_2014==1 & cat_2015==2 & failure_2015==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2013 
replace zombie_2015="Medium-Low Risk" if cat_2013==1 & cat_2014==2 & cat_2015==2 & failure_2015==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2013 
replace zombie_2015="Medium-Low Risk" if cat_2013==2 & cat_2014==1 & cat_2015==2 & failure_2015==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2013 
replace zombie_2015="Low Risk" if cat_2013==2 & cat_2014==2 & cat_2015==2 & failure_2015==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2013 
tab zombie_2015  

/*
zombie_2015_2013 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
               . |     99,802       94.44       94.44
       High Risk |      1,343        1.27       95.71
        Low Risk |        632        0.60       96.31
     Medium Risk |      1,585        1.50       97.81
Medium-High Risk |        816        0.77       98.58
 Medium-Low Risk |      1,502        1.42      100.00
-----------------+-----------------------------------
           Total |    105,680      100.00           */

tab zombie_2015 if iso=="IT"

/*

*/

gen dummy_2015=.
replace dummy_2015=1 if zombie_2015=="High Risk" | zombie_2015=="Medium-High Risk" | zombie_2015=="Medium Risk" | zombie_2015=="Medium-Low Risk" | zombie_2015=="Low Risk"
replace dummy_2015 if zombie_2015_2013=="No Zombie" 
tab dummy_2015

/*

*/

tab dummy_2015 if iso=="IT"

*Gen Zombie 2014/2012
gen zombie_2014_2012="."
replace zombie_2016="No Zombie" if failure_2016==0 & failure_2015==0 & failure_2014==0

replace zombie_2014_2012="High Risk" if cat_2012==1 & cat_2013==1 & cat_2014==1 & failure_2014==0 & failure_2012==0 & failure_2013==0 & year_of_incorporation<2012 
replace zombie_2014_2012="Medium-High Risk" if cat_2012==2 & cat_2013==1 & cat_2014==1 & failure_2012==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2012 
replace zombie_2014_2012="Medium-High Risk" if cat_2012==1 & cat_2013==2 & cat_2014==1 & failure_2012==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2012 
replace zombie_2014_2012="Medium Risk" if cat_2012==2 & cat_2013==2 & cat_2014==1 & failure_2012==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2012 
replace zombie_2014_2012="Medium Risk" if cat_2012==1 & cat_2013==1 & cat_2014==2 & failure_2012==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2012 
replace zombie_2014_2012="Medium-Low Risk" if cat_2012==1 & cat_2013==2 & cat_2014==2 & failure_2012==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2012 
replace zombie_2014_2012="Medium-Low Risk" if cat_2012==2 & cat_2013==1 & cat_2014==2 & failure_2012==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2012 
replace zombie_2014_2012="Low Risk" if cat_2012==2 & cat_2013==2 & cat_2014==2 & failure_2012==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2012 
tab zombie_2014_2012 if drop2012==3 & drop2014==3 & drop2013==3 

 /*
zombie_2014_2012 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
               . |     96,974       93.01       93.01
       High Risk |      2,344        2.25       95.26
        Low Risk |        700        0.67       95.93
     Medium Risk |      1,546        1.48       97.41
Medium-High Risk |      1,565        1.50       98.91
 Medium-Low Risk |      1,136        1.09      100.00
-----------------+-----------------------------------
           Total |    104,265      100.00          */
		   

tab zombie_2014_2012 if zombie_2014_2012!="." & drop2012==3 & drop2014==3 & drop2013==3 

tab zombie_2014_2012 failure_2016
tab zombie_2014_2012 failure_2015 

gen dummy_2014_2012=.
replace dummy_2014_2012=1 if zombie_2014_2012=="High Risk" | zombie_2014_2012=="Medium-High Risk" | zombie_2014_2012=="Medium Risk" | zombie_2014_2012=="Medium-Low Risk" | zombie_2014_2012=="Low Risk"
replace dummy_2014_2012=0 if zombie_2014_2012=="." & drop2012==3 & drop2014==3 & drop2013==3


*Generate Zombie (ruling out START UPS) 2011-2013
gen zombie_2013_2011="."
replace zombie_2016="No Zombie" if failure_2016==0 & failure_2015==0 & failure_2014==0

replace zombie_2013_2011="High Risk" if cat_2011==1 & cat_2012==1 & cat_2013==1 & failure_2011==0 & failure_2012==0 & failure_2013==0 & year_of_incorporation<2011 
replace zombie_2013_2011="Medium-High Risk" if cat_2011==2 & cat_2012==1 & cat_2013==1 & failure_2012==0 & failure_2011==0 & failure_2013==0 & year_of_incorporation<2011 
replace zombie_2013_2011="Medium-High Risk" if cat_2011==1 & cat_2012==2 & cat_2013==1 & failure_2012==0 & failure_2011==0 & failure_2013==0 & year_of_incorporation<2011 
replace zombie_2013_2011="Medium Risk" if cat_2011==2 & cat_2012==2 & cat_2013==1 & failure_2012==0 & failure_2011==0 & failure_2013==0 & year_of_incorporation<2011 
replace zombie_2013_2011="Medium Risk" if cat_2011==1 & cat_2012==1 & cat_2013==2 & failure_2012==0 & failure_2011==0 & failure_2013==0 & year_of_incorporation<2011 
replace zombie_2013_2011="Medium-Low Risk" if cat_2011==1 & cat_2012==2 & cat_2013==2 & failure_2012==0 & failure_2011==0 & failure_2013==0 & year_of_incorporation<2011 
replace zombie_2013_2011="Medium-Low Risk" if cat_2011==2 & cat_2012==1 & cat_2013==2 & failure_2012==0 & failure_2011==0 & failure_2013==0 & year_of_incorporation<2011 
replace zombie_2013_2011="Low Risk" if cat_2011==2 & cat_2012==2 & cat_2013==2 & failure_2012==0 & failure_2011==0 & failure_2013==0 & year_of_incorporation<2011

tab zombie_2013_2011 if drop2013==3 & drop2012==3 & drop2011==3

/*

zombie_2013_2011 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
               . |     94,604       92.77       92.77
       High Risk |      2,389        2.34       95.11
        Low Risk |        786        0.77       95.89
     Medium Risk |      1,553        1.52       97.41
Medium-High Risk |      1,452        1.42       98.83
 Medium-Low Risk |      1,191        1.17      100.00
-----------------+-----------------------------------
           Total |    101,975      100.00          */

		   
tab zombie_2013_2011 if zombie_2013_2011!="."  & drop2013==3 & drop2012==3 & drop2011==3
tab zombie_2013_2011 failure_2014 if drop2014==3 & drop2015==3 & drop2013==3 & drop2012==3 & drop2011==3

gen dummy_2013_2011=.
replace dummy_2013_2011=1 if zombie_2013_2011=="High Risk" | zombie_2013_2011=="Medium-High Risk" | zombie_2013_2011=="Medium Risk" | zombie_2013_2011=="Medium-Low Risk" | zombie_2013_2011=="Low Risk"
replace dummy_2013_2011=0 if zombie_2013_2011=="." & drop2013==3 & drop2012==3 & drop2011==3

*Generate Zombie (ruling out START UPS) 2010-2012
gen zombie_2012_2010="."
replace zombie_2016="No Zombie" if failure_2016==0 & failure_2015==0 & failure_2014==0

replace zombie_2012_2010="High Risk" if cat_2010==1 & cat_2011==1 & cat_2012==1 & failure_2011==0 & failure_2012==0 & failure_2010==0 & year_of_incorporation<2010
replace zombie_2012_2010="Medium-High Risk" if cat_2010==2 & cat_2011==1 & cat_2012==1 & failure_2012==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2010
replace zombie_2012_2010="Medium-High Risk" if cat_2010==1 & cat_2011==2 & cat_2012==1 & failure_2012==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2010
replace zombie_2012_2010="Medium Risk" if cat_2010==2 & cat_2011==2 & cat_2012==1 & failure_2012==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2010
replace zombie_2012_2010="Medium Risk" if cat_2010==1 & cat_2011==1 & cat_2012==2 & failure_2012==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2010
replace zombie_2012_2010="Medium-Low Risk" if cat_2010==1 & cat_2011==2 & cat_2012==2 & failure_2012==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2010
replace zombie_2012_2010="Medium-Low Risk" if cat_2010==2 & cat_2011==1 & cat_2012==2 & failure_2012==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2010
replace zombie_2012_2010="Low Risk" if cat_2010==2 & cat_2011==2 & cat_2012==2 & failure_2012==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2010

tab zombie_2012_2010 

/*

zombie_2012_2010 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
               . |     91,033       93.30       93.30
       High Risk |      2,284        2.34       95.64
        Low Risk |        592        0.61       96.24
     Medium Risk |      1,397        1.43       97.68
Medium-High Risk |      1,321        1.35       99.03
 Medium-Low Risk |        946        0.97      100.00
-----------------+-----------------------------------
           Total |     97,573      100.00           */



		   
tab zombie_2012_2010 if zombie_2012_2010!="."  & drop2012==3 & drop2011==3 & drop2010==3
tab zombie_2012_2010 failure_2013

gen dummy_2012_2010=.
replace dummy_2012_2010=1 if zombie_2012_2010=="High Risk" | zombie_2012_2010=="Medium-High Risk" | zombie_2012_2010=="Medium Risk" | zombie_2012_2010=="Medium-Low Risk" | zombie_2012_2010=="Low Risk"
replace dummy_2012_2010=0 if zombie_2012_2010=="."  & drop2012==3 & drop2011==3 & drop2010==3


*Generate Zombie (ruling out START UPS) 2009-2011
gen zombie_2011_2009="."


replace zombie_2011_2009="High Risk" if cat_2009==1 & cat_2010==1 & cat_2011==1 & failure_2011==0 & failure_2009==0 & failure_2010==0 & year_of_incorporation<2009
replace zombie_2011_2009="Medium-High Risk" if cat_2009==2 & cat_2010==1 & cat_2011==1 & failure_2009==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2009
replace zombie_2011_2009="Medium-High Risk" if cat_2009==1 & cat_2010==2 & cat_2011==1 & failure_2009==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2009
replace zombie_2011_2009="Medium Risk" if cat_2009==2 & cat_2010==2 & cat_2011==1 & failure_2009==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2009
replace zombie_2011_2009="Medium Risk" if cat_2009==1 & cat_2010==1 & cat_2011==2 & failure_2009==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2009
replace zombie_2011_2009="Medium-Low Risk" if cat_2009==1 & cat_2010==2 & cat_2011==2 & failure_2009==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2009
replace zombie_2011_2009="Medium-Low Risk" if cat_2009==2 & cat_2010==1 & cat_2011==2 & failure_2009==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2009
replace zombie_2011_2009="Low Risk" if cat_2009==2 & cat_2010==2 & cat_2011==2 & failure_2009==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2009

tab zombie_2011_2009 if  drop2011==3 & drop2010==3 & drop2009==3

/*
zombie_2011_2009 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
               . |     87,267       93.87       93.87
       High Risk |      1,938        2.08       95.96
        Low Risk |        565        0.61       96.56
     Medium Risk |        979        1.05       97.62
Medium-High Risk |      1,344        1.45       99.06
 Medium-Low Risk |        871        0.94      100.00
-----------------+-----------------------------------
           Total |     92,964      100.00          */



tab zombie_2011_2009 if zombie_2011_2009!="." &  drop2011==3 & drop2010==3 & drop2009==3
tab zombie_2011_2009 failure_2012 if zombie_2011_2009!="."

gen dummy_2011_2009=.
replace dummy_2011_2009=1 if zombie_2011_2009=="High Risk" | zombie_2011_2009=="Medium-High Risk" | zombie_2011_2009=="Medium Risk" | zombie_2011_2009=="Medium-Low Risk" | zombie_2011_2009=="Low Risk"
replace dummy_2011_2009=0 if zombie_2011_2009=="." & drop2011==3 & drop2010==3 & drop2009==3



