********************************************************************************
*                                                                              *
* Generating Zombie Indicator for "Machine Learning for Zombie Hunting" paper  *
*                                                                              *
********************************************************************************

clear all 
cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data"

use "data_categories", clear

*Generate Zombie (ruling out START UPS) 2015-2017
gen zombie_2017="."
replace zombie_2017="No Zombie" if year_of_incorporation<2015 & failure_2017!=. & failure_2016!=. & failure_2015!=.
replace zombie_2017="High Risk" if cat_2015==1 & cat_2016==1 & cat_2017==1 & failure_2017==0 & failure_2016==0 & failure_2015==0 & year_of_incorporation<2015 
replace zombie_2017="Medium-High Risk" if cat_2015==2 & cat_2016==1 & cat_2017==1 & failure_2017==0 & failure_2016==0 & failure_2015==0 & year_of_incorporation<2015 
replace zombie_2017="Medium-High Risk" if cat_2015==1 & cat_2016==2 & cat_2017==1 & failure_2017==0 & failure_2016==0 & failure_2015==0 & year_of_incorporation<2015 
replace zombie_2017="Medium Risk" if cat_2015==2 & cat_2016==2 & cat_2017==1 & failure_2017==0 & failure_2016==0 & failure_2015==0 & year_of_incorporation<2015
replace zombie_2017="Medium Risk" if cat_2015==1 & cat_2016==1 & cat_2017==2 & failure_2017==0 & failure_2016==0 & failure_2015==0 & year_of_incorporation<2015 
replace zombie_2017="Medium-Low Risk" if cat_2015==1 & cat_2016==2 & cat_2017==2 & failure_2017==0 & failure_2016==0 & failure_2015==0 & year_of_incorporation<2015 
replace zombie_2017="Medium-Low Risk" if cat_2015==2 & cat_2016==1 & cat_2017==2 & failure_2017==0 & failure_2016==0 & failure_2015==0 & year_of_incorporation<2015 
replace zombie_2017="Low Risk" if cat_2015==2 & cat_2016==2 & cat_2017==2 & failure_2017==0 & failure_2016==0 & failure_2015==0 & year_of_incorporation<2015
tab zombie_2017 if zombie_2017!="."

/*
     zombie_2017 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |     12,708        2.77        2.77
        Low Risk |      8,507        1.85        4.62
     Medium Risk |      6,586        1.43        6.05
Medium-High Risk |      5,847        1.27        7.33
 Medium-Low Risk |      9,008        1.96        9.29
       No Zombie |    416,656       90.71      100.00
-----------------+-----------------------------------
           Total |    459,312      100.00
*/

tab zombie_2017 if iso=="IT" & zombie_2017!="."

/*
     zombie_2017 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |     10,144        3.74        3.74
        Low Risk |      7,062        2.61        6.35
     Medium Risk |      4,833        1.78        8.13
Medium-High Risk |      3,872        1.43        9.56
 Medium-Low Risk |      6,224        2.30       11.86
       No Zombie |    238,809       88.14      100.00
-----------------+-----------------------------------
           Total |    270,944      100.00
*/

gen dummy_2017=.
replace dummy_2017=1 if zombie_2017=="High Risk" | zombie_2017=="Medium-High Risk" | zombie_2017=="Medium Risk" | zombie_2017=="Medium-Low Risk" | zombie_2017=="Low Risk"
replace dummy_2017=0 if zombie_2017=="No Zombie" 
tab dummy_2017

/*
 dummy_2017 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    416,656       90.71       90.71
          1 |     42,656        9.29      100.00
------------+-----------------------------------
      Total |    459,312      100.00
*/

tab dummy_2017 if iso=="IT"

/*
 dummy_2017 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    238,809       88.14       88.14
          1 |     32,135       11.86      100.00
------------+-----------------------------------
      Total |    270,944      100.00
*/

tab dummy_2017 if iso=="ES"

/*
 dummy_2017 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     77,329       94.07       94.07
          1 |      4,871        5.93      100.00
------------+-----------------------------------
      Total |     82,200      100.00
*/

tab dummy_2017 if iso=="FR"

/*
 dummy_2017 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     67,627       97.09       97.09
          1 |      2,030        2.91      100.00
------------+-----------------------------------
      Total |     69,657      100.00
*/

tab dummy_2017 if iso=="PT"

/*
 dummy_2017 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     32,891       90.09       90.09
          1 |      3,620        9.91      100.00
------------+-----------------------------------
      Total |     36,511      100.00
*/

*Generate Zombie (ruling out START UPS) 2014-2016
gen zombie_2016="."
replace zombie_2016="No Zombie" if failure_2016!=. & failure_2015!=. & failure_2014!=. & year_of_incorporation<2014  
replace zombie_2016="High Risk" if cat_2014==1 & cat_2015==1 & cat_2016==1 & failure_2016==0 & failure_2015==0 & failure_2014==0 & year_of_incorporation<2014 
replace zombie_2016="Medium-High Risk" if cat_2014==2 & cat_2015==1 & cat_2016==1 & failure_2016==0 & failure_2015==0 & failure_2014==0 & year_of_incorporation<2014 
replace zombie_2016="Medium-High Risk" if cat_2014==1 & cat_2015==2 & cat_2016==1 & failure_2016==0 & failure_2015==0 & failure_2014==0 & year_of_incorporation<2014 
replace zombie_2016="Medium Risk" if cat_2014==2 & cat_2015==2 & cat_2016==1 & failure_2016==0 & failure_2015==0 & failure_2014==0 & year_of_incorporation<2014 
replace zombie_2016="Medium Risk" if cat_2014==1 & cat_2015==1 & cat_2016==2 & failure_2016==0 & failure_2015==0 & failure_2014==0 & year_of_incorporation<2014 
replace zombie_2016="Medium-Low Risk" if cat_2014==1 & cat_2015==2 & cat_2016==2 & failure_2016==0 & failure_2015==0 & failure_2014==0 & year_of_incorporation<2014 
replace zombie_2016="Medium-Low Risk" if cat_2014==2 & cat_2015==1 & cat_2016==2 & failure_2016==0 & failure_2015==0 & failure_2014==0 & year_of_incorporation<2014 
replace zombie_2016="Low Risk" if cat_2014==2 & cat_2015==2 & cat_2016==2 & failure_2016==0 & failure_2015==0 & failure_2014==0 & year_of_incorporation<2014 
tab zombie_2016 if zombie_2016!="."

/*
     zombie_2016 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |     12,567        2.88        2.88
        Low Risk |      6,908        1.58        4.47
     Medium Risk |      7,919        1.82        6.28
Medium-High Risk |      4,792        1.10        7.38
 Medium-Low Risk |      8,926        2.05        9.43
       No Zombie |    395,035       90.57      100.00
-----------------+-----------------------------------
           Total |    436,147      100.00
*/

tab zombie_2016 if iso=="IT" & zombie_2016!="."

/*
     zombie_2016 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |     10,076        3.97        3.97
        Low Risk |      6,142        2.42        6.39
     Medium Risk |      5,641        2.22        8.61
Medium-High Risk |      3,889        1.53       10.14
 Medium-Low Risk |      7,149        2.82       12.96
       No Zombie |    220,944       87.04      100.00
-----------------+-----------------------------------
           Total |    253,841      100.0
*/

gen dummy_2016=.
replace dummy_2016=1 if zombie_2016=="High Risk" | zombie_2016=="Medium-High Risk" | zombie_2016=="Medium Risk" | zombie_2016=="Medium-Low Risk" | zombie_2016=="Low Risk"
replace dummy_2016=0 if zombie_2016=="No Zombie" 
tab dummy_2016

/*
 dummy_2016 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    395,035       90.57       90.57
          1 |     41,112        9.43      100.00
------------+-----------------------------------
      Total |    436,147      100.00
*/

tab dummy_2016 if iso=="IT"

/*
 dummy_2016 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    220,944       87.04       87.04
          1 |     32,897       12.96      100.00
------------+-----------------------------------
      Total |    253,841      100.00
*/

tab dummy_2016 if iso=="ES"

/*
 dummy_2016 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     76,108       95.14       95.14
          1 |      3,887        4.86      100.00
------------+-----------------------------------
      Total |     79,995      100.00
*/

tab dummy_2016 if iso=="FR"

/*
 dummy_2016 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     66,855       98.47       98.47
          1 |      1,039        1.53      100.00
------------+-----------------------------------
      Total |     67,894      100.00
*/

tab dummy_2016 if iso=="PT"

/*
 dummy_2016 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     31,128       90.44       90.44
          1 |      3,289        9.56      100.00
------------+-----------------------------------
      Total |     34,417      100.00
*/

*Generate Zombie (ruling out START UPS) 2013-2015
gen zombie_2015="."
replace zombie_2015="No Zombie" if failure_2013!=. & failure_2015!=. & failure_2014!=. & year_of_incorporation<2013
replace zombie_2015="High Risk" if cat_2013==1 & cat_2014==1 & cat_2015==1 & failure_2014==0 & failure_2015==0 & failure_2013==0 & year_of_incorporation<2013 
replace zombie_2015="Medium-High Risk" if cat_2013==2 & cat_2014==1 & cat_2015==1 & failure_2015==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2013 
replace zombie_2015="Medium-High Risk" if cat_2013==1 & cat_2014==2 & cat_2015==1 & failure_2015==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2013 
replace zombie_2015="Medium Risk" if cat_2013==2 & cat_2014==2 & cat_2015==1 & failure_2015==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2013 
replace zombie_2015="Medium Risk" if cat_2013==1 & cat_2014==1 & cat_2015==2 & failure_2015==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2013 
replace zombie_2015="Medium-Low Risk" if cat_2013==1 & cat_2014==2 & cat_2015==2 & failure_2015==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2013 
replace zombie_2015="Medium-Low Risk" if cat_2013==2 & cat_2014==1 & cat_2015==2 & failure_2015==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2013 
replace zombie_2015="Low Risk" if cat_2013==2 & cat_2014==2 & cat_2015==2 & failure_2015==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2013 
tab zombie_2015 if zombie_2015!="."

/*
     zombie_2015 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |     13,768        3.34        3.34
        Low Risk |      4,746        1.15        4.50
     Medium Risk |      6,828        1.66        6.16
Medium-High Risk |      5,566        1.35        7.51
 Medium-Low Risk |      5,897        1.43        8.94
       No Zombie |    374,831       91.06      100.00
-----------------+-----------------------------------
           Total |    411,636      100.00          
*/

tab zombie_2015 if iso=="IT" & zombie_2015!="."

/*
     zombie_2015 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |     10,998        4.64        4.64
        Low Risk |      4,537        1.92        6.56
     Medium Risk |      5,736        2.42        8.98
Medium-High Risk |      4,521        1.91       10.89
 Medium-Low Risk |      5,247        2.22       13.11
       No Zombie |    205,778       86.89      100.00
-----------------+-----------------------------------
           Total |    236,817      100.00
*/

gen dummy_2015=.
replace dummy_2015=1 if zombie_2015=="High Risk" | zombie_2015=="Medium-High Risk" | zombie_2015=="Medium Risk" | zombie_2015=="Medium-Low Risk" | zombie_2015=="Low Risk"
replace dummy_2015=0 if zombie_2015=="No Zombie" 
tab dummy_2015

/*
 dummy_2015 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    374,831       91.06       91.06
          1 |     36,805        8.94      100.00
------------+-----------------------------------
      Total |    411,636      100.00
*/

tab dummy_2015 if iso=="IT"

/*
 dummy_2015 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    205,778       86.89       86.89
          1 |     31,039       13.11      100.00
------------+-----------------------------------
      Total |    236,817      100.00
*/

tab dummy_2015 if iso=="ES"

/*
 dummy_2015 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     73,407       95.33       95.33
          1 |      3,596        4.67      100.00
------------+-----------------------------------
      Total |     77,003      100.00
*/

tab dummy_2015 if iso=="FR"

/*
 dummy_2015 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     64,165       98.10       98.10
          1 |      1,241        1.90      100.00
------------+-----------------------------------
      Total |     65,406      100.00
*/

tab dummy_2015 if iso=="PT"

/*
 dummy_2015 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     31,481       97.13       97.13
          1 |        929        2.87      100.00
------------+-----------------------------------
      Total |     32,410      100.00
*/


*Generate Zombie (ruling out START UPS) 2012-2014
gen zombie_2014="."
replace zombie_2014="No Zombie" if failure_2012!=. & failure_2013!=. & failure_2014!=. & year_of_incorporation<2012
replace zombie_2014="High Risk" if cat_2012==1 & cat_2013==1 & cat_2014==1 & failure_2014==0 & failure_2012==0 & failure_2013==0 & year_of_incorporation<2012 
replace zombie_2014="Medium-High Risk" if cat_2012==2 & cat_2013==1 & cat_2014==1 & failure_2012==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2012 
replace zombie_2014="Medium-High Risk" if cat_2012==1 & cat_2013==2 & cat_2014==1 & failure_2012==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2012 
replace zombie_2014="Medium Risk" if cat_2012==2 & cat_2013==2 & cat_2014==1 & failure_2012==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2012 
replace zombie_2014="Medium Risk" if cat_2012==1 & cat_2013==1 & cat_2014==2 & failure_2012==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2012 
replace zombie_2014="Medium-Low Risk" if cat_2012==1 & cat_2013==2 & cat_2014==2 & failure_2012==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2012 
replace zombie_2014="Medium-Low Risk" if cat_2012==2 & cat_2013==1 & cat_2014==2 & failure_2012==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2012 
replace zombie_2014="Low Risk" if cat_2012==2 & cat_2013==2 & cat_2014==2 & failure_2012==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2012 
tab zombie_2014 if zombie_2014!="."

/*
     zombie_2014 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |     13,542        3.48        3.48
        Low Risk |      3,271        0.84        4.32
     Medium Risk |      5,229        1.34        5.67
Medium-High Risk |      5,780        1.49        7.16
 Medium-Low Risk |      4,235        1.09        8.24
       No Zombie |    356,765       91.76      100.00
-----------------+-----------------------------------
           Total |    388,822      100.00     
*/
		   
tab zombie_2014 if iso=="IT" & zombie_2014!="."

/*
     zombie_2014 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |     10,884        4.91        4.91
        Low Risk |      3,062        1.38        6.29
     Medium Risk |      4,534        2.04        8.33
Medium-High Risk |      4,700        2.12       10.45
 Medium-Low Risk |      3,837        1.73       12.18
       No Zombie |    194,831       87.82      100.00
-----------------+-----------------------------------
           Total |    221,848      100.00    
*/

gen dummy_2014=.
replace dummy_2014=1 if zombie_2014=="High Risk" | zombie_2014=="Medium-High Risk" | zombie_2014=="Medium Risk" | zombie_2014=="Medium-Low Risk" | zombie_2014=="Low Risk"
replace dummy_2014=0 if zombie_2014=="No Zombie" 
tab dummy_2014

/*
 dummy_2014 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    356,765       91.76       91.76
          1 |     32,057        8.24      100.00
------------+-----------------------------------
      Total |    388,822      100.00       
*/

tab dummy_2014 if iso=="IT"

/*
dummy_2014  |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    194,831       87.82       87.82
          1 |     27,017       12.18      100.00
------------+-----------------------------------
      Total |    221,848      100.00
*/

tab dummy_2014 if iso=="ES"

/*
 dummy_2014 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     69,855       94.51       94.51
          1 |      4,058        5.49      100.00
------------+-----------------------------------
      Total |     73,913      100.00      
*/

tab dummy_2014 if iso=="FR"

/*
 dummy_2014 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     62,212       99.34       99.34
          1 |        415        0.66      100.00
------------+-----------------------------------
      Total |     62,627      100.00    
*/

tab dummy_2014 if iso=="PT"

/*
 dummy_2014 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     29,867       98.14       98.14
          1 |        567        1.86      100.00
------------+-----------------------------------
      Total |     30,434      100.00     
*/

*Generate Zombie (ruling out START UPS) 2011-2013
gen zombie_2013="."
replace zombie_2013="No Zombie" if failure_2011!=. & failure_2012!=. & failure_2013!=. & year_of_incorporation<2011
replace zombie_2013="High Risk" if cat_2011==1 & cat_2012==1 & cat_2013==1 & failure_2011==0 & failure_2012==0 & failure_2013==0 & year_of_incorporation<2011 
replace zombie_2013="Medium-High Risk" if cat_2011==2 & cat_2012==1 & cat_2013==1 & failure_2012==0 & failure_2011==0 & failure_2013==0 & year_of_incorporation<2011 
replace zombie_2013="Medium-High Risk" if cat_2011==1 & cat_2012==2 & cat_2013==1 & failure_2012==0 & failure_2011==0 & failure_2013==0 & year_of_incorporation<2011 
replace zombie_2013="Medium Risk" if cat_2011==2 & cat_2012==2 & cat_2013==1 & failure_2012==0 & failure_2011==0 & failure_2013==0 & year_of_incorporation<2011 
replace zombie_2013="Medium Risk" if cat_2011==1 & cat_2012==1 & cat_2013==2 & failure_2012==0 & failure_2011==0 & failure_2013==0 & year_of_incorporation<2011 
replace zombie_2013="Medium-Low Risk" if cat_2011==1 & cat_2012==2 & cat_2013==2 & failure_2012==0 & failure_2011==0 & failure_2013==0 & year_of_incorporation<2011 
replace zombie_2013="Medium-Low Risk" if cat_2011==2 & cat_2012==1 & cat_2013==2 & failure_2012==0 & failure_2011==0 & failure_2013==0 & year_of_incorporation<2011 
replace zombie_2013="Low Risk" if cat_2011==2 & cat_2012==2 & cat_2013==2 & failure_2012==0 & failure_2011==0 & failure_2013==0 & year_of_incorporation<2011
tab zombie_2013 if zombie_2013!="."

/*
     zombie_2013 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |     12,633        3.43        3.43
        Low Risk |      3,427        0.93        4.36
     Medium Risk |      4,328        1.17        5.53
Medium-High Risk |      5,280        1.43        6.96
 Medium-Low Risk |      4,198        1.14        8.10
       No Zombie |    338,763       91.90      100.00
-----------------+-----------------------------------
           Total |    368,629      100.00      
*/
		   
tab zombie_2013 if iso=="IT" & zombie_2013!="."

/*
     zombie_2013 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |     10,339        4.96        4.96
        Low Risk |      3,268        1.57        6.52
     Medium Risk |      3,824        1.83        8.36
Medium-High Risk |      4,396        2.11       10.46
 Medium-Low Risk |      3,759        1.80       12.27
       No Zombie |    182,987       87.73      100.00
-----------------+-----------------------------------
           Total |    208,573      100.00      
*/

gen dummy_2013=.
replace dummy_2013=1 if zombie_2013=="High Risk" | zombie_2013=="Medium-High Risk" | zombie_2013=="Medium Risk" | zombie_2013=="Medium-Low Risk" | zombie_2013=="Low Risk"
replace dummy_2013=0 if zombie_2013=="No Zombie"
tab dummy_2013

/*
 dummy_2013 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    338,763       91.90       91.90
          1 |     29,866        8.10      100.00
------------+-----------------------------------
      Total |    368,629      100.00    
*/

tab dummy_2013 if iso=="IT"

/*
 dummy_2013 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    182,987       87.73       87.73
          1 |     25,586       12.27      100.00
------------+-----------------------------------
      Total |    208,573      100.00       
*/

tab dummy_2013 if iso=="ES"

/*
 dummy_2013 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     68,147       95.47       95.47
          1 |      3,234        4.53      100.00
------------+-----------------------------------
      Total |     71,381      100.00    
*/

tab dummy_2013 if iso=="FR"

/*
 dummy_2013 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     59,141       98.97       98.97
          1 |        614        1.03      100.00
------------+-----------------------------------
      Total |     59,755      100.00      
*/

tab dummy_2013 if iso=="PT"

/*
 dummy_2013 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     28,488       98.51       98.51
          1 |        432        1.49      100.00
------------+-----------------------------------
      Total |     28,920      100.00    
*/

*Generate Zombie (ruling out START UPS) 2010-2012
gen zombie_2012="."
replace zombie_2012="No Zombie" if failure_2010!=. & failure_2011!=. & failure_2012!=. & year_of_incorporation<2010
replace zombie_2012="High Risk" if cat_2010==1 & cat_2011==1 & cat_2012==1 & failure_2011==0 & failure_2012==0 & failure_2010==0 & year_of_incorporation<2010
replace zombie_2012="Medium-High Risk" if cat_2010==2 & cat_2011==1 & cat_2012==1 & failure_2012==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2010
replace zombie_2012="Medium-High Risk" if cat_2010==1 & cat_2011==2 & cat_2012==1 & failure_2012==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2010
replace zombie_2012="Medium Risk" if cat_2010==2 & cat_2011==2 & cat_2012==1 & failure_2012==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2010
replace zombie_2012="Medium Risk" if cat_2010==1 & cat_2011==1 & cat_2012==2 & failure_2012==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2010
replace zombie_2012="Medium-Low Risk" if cat_2010==1 & cat_2011==2 & cat_2012==2 & failure_2012==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2010
replace zombie_2012="Medium-Low Risk" if cat_2010==2 & cat_2011==1 & cat_2012==2 & failure_2012==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2010
replace zombie_2012="Low Risk" if cat_2010==2 & cat_2011==2 & cat_2012==2 & failure_2012==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2010
tab zombie_2012 if zombie_2012!="."

/*
     zombie_2012 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      9,761        2.77        2.77
        Low Risk |      1,926        0.55        3.32
     Medium Risk |      4,040        1.15        4.46
Medium-High Risk |      4,547        1.29        5.75
 Medium-Low Risk |      3,204        0.91        6.66
       No Zombie |    328,886       93.34      100.00
-----------------+-----------------------------------
           Total |    352,364      100.00   
*/

tab zombie_2012 if iso=="IT" & zombie_2012!="."

/*
     zombie_2012 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      8,663        4.36        4.36
        Low Risk |      1,773        0.89        5.25
     Medium Risk |      3,571        1.80        7.05
Medium-High Risk |      3,755        1.89        8.94
 Medium-Low Risk |      2,726        1.37       10.32
       No Zombie |    178,116       89.68      100.00
-----------------+-----------------------------------
           Total |    198,604      100.00     
*/

gen dummy_2012=.
replace dummy_2012=1 if zombie_2012=="High Risk" | zombie_2012=="Medium-High Risk" | zombie_2012=="Medium Risk" | zombie_2012=="Medium-Low Risk" | zombie_2012=="Low Risk"
replace dummy_2012=0 if zombie_2012=="No Zombie"  
tab dummy_2012

/*
 dummy_2012 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    328,886       93.34       93.34
          1 |     23,478        6.66      100.00
------------+-----------------------------------
      Total |    352,364      100.00     
*/

tab dummy_2012 if iso=="IT"

/*
 dummy_2012 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    178,116       89.68       89.68
          1 |     20,488       10.32      100.00
------------+-----------------------------------
      Total |    198,604      100.00   
*/

tab dummy_2012 if iso=="ES"

/*
 dummy_2012 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     67,329       97.25       97.25
          1 |      1,905        2.75      100.00
------------+-----------------------------------
      Total |     69,234      100.00  
*/

tab dummy_2012 if iso=="FR"

/*
 dummy_2012 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     56,309       98.70       98.70
          1 |        742        1.30      100.00
------------+-----------------------------------
      Total |     57,051      100.00    
*/

tab dummy_2012 if iso=="PT"

/*
 dummy_2012 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     27,132       98.75       98.75
          1 |        343        1.25      100.00
------------+-----------------------------------
      Total |     27,475      100.00  
*/

*Generate Zombie (ruling out START UPS) 2009-2011
gen zombie_2011="."
replace zombie_2011="No Zombie" if failure_2010!=. & failure_2011!=. & failure_2009!=. & year_of_incorporation<2009
replace zombie_2011="High Risk" if cat_2009==1 & cat_2010==1 & cat_2011==1 & failure_2011==0 & failure_2009==0 & failure_2010==0 & year_of_incorporation<2009
replace zombie_2011="Medium-High Risk" if cat_2009==2 & cat_2010==1 & cat_2011==1 & failure_2009==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2009
replace zombie_2011="Medium-High Risk" if cat_2009==1 & cat_2010==2 & cat_2011==1 & failure_2009==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2009
replace zombie_2011="Medium Risk" if cat_2009==2 & cat_2010==2 & cat_2011==1 & failure_2009==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2009
replace zombie_2011="Medium Risk" if cat_2009==1 & cat_2010==1 & cat_2011==2 & failure_2009==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2009
replace zombie_2011="Medium-Low Risk" if cat_2009==1 & cat_2010==2 & cat_2011==2 & failure_2009==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2009
replace zombie_2011="Medium-Low Risk" if cat_2009==2 & cat_2010==1 & cat_2011==2 & failure_2009==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2009
replace zombie_2011="Low Risk" if cat_2009==2 & cat_2010==2 & cat_2011==2 & failure_2009==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2009
tab zombie_2011 if zombie_2011!="."

/*
     zombie_2011 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      8,197        2.45        2.45
        Low Risk |      1,493        0.45        2.89
     Medium Risk |      3,374        1.01        3.90
Medium-High Risk |      4,372        1.30        5.20
 Medium-Low Risk |      2,684        0.80        6.00
       No Zombie |    315,017       94.00      100.00
-----------------+-----------------------------------
           Total |    335,137      100.00     
*/

tab zombie_2011 if iso=="IT" & zombie_2011!="."

/*
     zombie_2011 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      7,525        4.02        4.02
        Low Risk |      1,350        0.72        4.74
     Medium Risk |      2,898        1.55        6.29
Medium-High Risk |      3,729        1.99        8.29
 Medium-Low Risk |      2,287        1.22        9.51
       No Zombie |    169,303       90.49      100.00
-----------------+-----------------------------------
           Total |    187,092      100.00       
*/

gen dummy_2011=.
replace dummy_2011=1 if zombie_2011=="High Risk" | zombie_2011=="Medium-High Risk" | zombie_2011=="Medium Risk" | zombie_2011=="Medium-Low Risk" | zombie_2011=="Low Risk"
replace dummy_2011=0 if zombie_2011=="No Zombie"
tab dummy_2011

/*
 dummy_2011 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    315,017       94.00       94.00
          1 |     20,120        6.00      100.00
------------+-----------------------------------
      Total |    335,137      100.00
*/

tab dummy_2011 if iso=="IT"

/*
 dummy_2011 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    169,303       90.49       90.49
          1 |     17,789        9.51      100.00
------------+-----------------------------------
      Total |    187,092      100.00     
*/ 

tab dummy_2011 if iso=="ES"

/*
 dummy_2011 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     65,809       97.82       97.82
          1 |      1,464        2.18      100.00
------------+-----------------------------------
      Total |     67,273      100.00       
*/ 

tab dummy_2011 if iso=="FR"

/*
 dummy_2011 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     54,076       99.27       99.27
          1 |        399        0.73      100.00
------------+-----------------------------------
      Total |     54,475      100.00      
*/ 

tab dummy_2011 if iso=="PT"

/*
 dummy_2011 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     25,829       98.22       98.22
          1 |        468        1.78      100.00
------------+-----------------------------------
      Total |     26,297      100.00
*/ 

******************************************************************************** 
*               Generate Zombie Alive (ruling out START UPS) 2015-2017         *
********************************************************************************
gen zombie_alive_2017="."
replace zombie_alive_2017="No Zombie" if failure_2017==0 & failure_2016==0 & failure_2015==0
replace zombie_alive_2017="High Risk" if cat_2015==1 & cat_2016==1 & cat_2017==1 & failure_2017==0 & failure_2016==0 & failure_2015==0 & year_of_incorporation<2015 
replace zombie_alive_2017="Medium-High Risk" if cat_2015==2 & cat_2016==1 & cat_2017==1 & failure_2017==0 & failure_2016==0 & failure_2015==0 & year_of_incorporation<2015 
replace zombie_alive_2017="Medium-High Risk" if cat_2015==1 & cat_2016==2 & cat_2017==1 & failure_2017==0 & failure_2016==0 & failure_2015==0 & year_of_incorporation<2015 
replace zombie_alive_2017="Medium Risk" if cat_2015==2 & cat_2016==2 & cat_2017==1 & failure_2017==0 & failure_2016==0 & failure_2015==0 & year_of_incorporation<2015
replace zombie_alive_2017="Medium Risk" if cat_2015==1 & cat_2016==1 & cat_2017==2 & failure_2017==0 & failure_2016==0 & failure_2015==0 & year_of_incorporation<2015 
replace zombie_alive_2017="Medium-Low Risk" if cat_2015==1 & cat_2016==2 & cat_2017==2 & failure_2017==0 & failure_2016==0 & failure_2015==0 & year_of_incorporation<2015 
replace zombie_alive_2017="Medium-Low Risk" if cat_2015==2 & cat_2016==1 & cat_2017==2 & failure_2017==0 & failure_2016==0 & failure_2015==0 & year_of_incorporation<2015 
replace zombie_alive_2017="Low Risk" if cat_2015==2 & cat_2016==2 & cat_2017==2 & failure_2017==0 & failure_2016==0 & failure_2015==0 & year_of_incorporation<2015
tab zombie_alive_2017 if zombie_alive_2017!="."

/*
     zombie_alive_2017 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |     12,708        2.77        2.77
        Low Risk |      8,507        1.85        4.62
     Medium Risk |      6,586        1.43        6.05
Medium-High Risk |      5,847        1.27        7.33
 Medium-Low Risk |      9,008        1.96        9.29
       No Zombie |    416,656       90.71      100.00
-----------------+-----------------------------------
           Total |    459,312      100.00
*/

tab zombie_alive_2017 if iso=="IT" & zombie_alive_2017!="."

/*
     zombie_alive_2017 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |     10,144        3.74        3.74
        Low Risk |      7,062        2.61        6.35
     Medium Risk |      4,833        1.78        8.13
Medium-High Risk |      3,872        1.43        9.56
 Medium-Low Risk |      6,224        2.30       11.86
       No Zombie |    238,809       88.14      100.00
-----------------+-----------------------------------
           Total |    270,944      100.00
*/

gen dummy_alive_2017=.
replace dummy_alive_2017=1 if zombie_alive_2017=="High Risk" | zombie_alive_2017=="Medium-High Risk" | zombie_alive_2017=="Medium Risk" | zombie_alive_2017=="Medium-Low Risk" | zombie_alive_2017=="Low Risk"
replace dummy_alive_2017=0 if zombie_alive_2017=="No Zombie" 
tab dummy_alive_2017

/*
 dummy_alive_2017 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    416,656       90.71       90.71
          1 |     42,656        9.29      100.00
------------+-----------------------------------
      Total |    459,312      100.00
*/

tab dummy_alive_2017 if iso=="IT"

/*
 dummy_alive_2017 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    238,809       88.14       88.14
          1 |     32,135       11.86      100.00
------------+-----------------------------------
      Total |    270,944      100.00
*/

tab dummy_alive_2017 if iso=="ES"

/*
 dummy_alive_2017 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     77,329       94.07       94.07
          1 |      4,871        5.93      100.00
------------+-----------------------------------
      Total |     82,200      100.00
*/

tab dummy_alive_2017 if iso=="FR"

/*
 dummy_alive_2017 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     67,627       97.09       97.09
          1 |      2,030        2.91      100.00
------------+-----------------------------------
      Total |     69,657      100.00
*/

tab dummy_alive_2017 if iso=="PT"

/*
 dummy_alive_2017 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     32,891       90.09       90.09
          1 |      3,620        9.91      100.00
------------+-----------------------------------
      Total |     36,511      100.00
*/

*Generate Zombie (ruling out START UPS) 2014-2016
gen zombie_alive_2016="."
replace zombie_alive_2016="No Zombie" if failure_2016==0 & failure_2015==0 & failure_2014==0
replace zombie_alive_2016="High Risk" if cat_2014==1 & cat_2015==1 & cat_2016==1 & failure_2016==0 & failure_2015==0 & failure_2014==0 & year_of_incorporation<2014 
replace zombie_alive_2016="Medium-High Risk" if cat_2014==2 & cat_2015==1 & cat_2016==1 & failure_2016==0 & failure_2015==0 & failure_2014==0 & year_of_incorporation<2014 
replace zombie_alive_2016="Medium-High Risk" if cat_2014==1 & cat_2015==2 & cat_2016==1 & failure_2016==0 & failure_2015==0 & failure_2014==0 & year_of_incorporation<2014 
replace zombie_alive_2016="Medium Risk" if cat_2014==2 & cat_2015==2 & cat_2016==1 & failure_2016==0 & failure_2015==0 & failure_2014==0 & year_of_incorporation<2014 
replace zombie_alive_2016="Medium Risk" if cat_2014==1 & cat_2015==1 & cat_2016==2 & failure_2016==0 & failure_2015==0 & failure_2014==0 & year_of_incorporation<2014 
replace zombie_alive_2016="Medium-Low Risk" if cat_2014==1 & cat_2015==2 & cat_2016==2 & failure_2016==0 & failure_2015==0 & failure_2014==0 & year_of_incorporation<2014 
replace zombie_alive_2016="Medium-Low Risk" if cat_2014==2 & cat_2015==1 & cat_2016==2 & failure_2016==0 & failure_2015==0 & failure_2014==0 & year_of_incorporation<2014 
replace zombie_alive_2016="Low Risk" if cat_2014==2 & cat_2015==2 & cat_2016==2 & failure_2016==0 & failure_2015==0 & failure_2014==0 & year_of_incorporation<2014 
tab zombie_alive_2016 if zombie_alive_2016!="."

/*
     zombie_alive_2016 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |     12,567        2.88        2.88
        Low Risk |      6,908        1.58        4.47
     Medium Risk |      7,919        1.82        6.28
Medium-High Risk |      4,792        1.10        7.38
 Medium-Low Risk |      8,926        2.05        9.43
       No Zombie |    395,035       90.57      100.00
-----------------+-----------------------------------
           Total |    436,147      100.00
*/

tab zombie_alive_2016 if iso=="IT" & zombie_alive_2016!="."

/*
     zombie_alive_2016 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |     10,076        3.97        3.97
        Low Risk |      6,142        2.42        6.39
     Medium Risk |      5,641        2.22        8.61
Medium-High Risk |      3,889        1.53       10.14
 Medium-Low Risk |      7,149        2.82       12.96
       No Zombie |    220,944       87.04      100.00
-----------------+-----------------------------------
           Total |    253,841      100.0
*/

gen dummy_alive_2016=.
replace dummy_alive_2016=1 if zombie_alive_2016=="High Risk" | zombie_alive_2016=="Medium-High Risk" | zombie_alive_2016=="Medium Risk" | zombie_alive_2016=="Medium-Low Risk" | zombie_alive_2016=="Low Risk"
replace dummy_alive_2016=0 if zombie_alive_2016=="No Zombie" 
tab dummy_alive_2016

/*
 dummy_alive_2016 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    395,035       90.57       90.57
          1 |     41,112        9.43      100.00
------------+-----------------------------------
      Total |    436,147      100.00
*/

tab dummy_alive_2016 if iso=="IT"

/*
 dummy_alive_2016 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    220,944       87.04       87.04
          1 |     32,897       12.96      100.00
------------+-----------------------------------
      Total |    253,841      100.00
*/

tab dummy_alive_2016 if iso=="ES"

/*
 dummy_alive_2016 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     76,108       95.14       95.14
          1 |      3,887        4.86      100.00
------------+-----------------------------------
      Total |     79,995      100.00
*/

tab dummy_alive_2016 if iso=="FR"

/*
 dummy_alive_2016 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     66,855       98.47       98.47
          1 |      1,039        1.53      100.00
------------+-----------------------------------
      Total |     67,894      100.00
*/

tab dummy_alive_2016 if iso=="PT"

/*
 dummy_alive_2016 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     31,128       90.44       90.44
          1 |      3,289        9.56      100.00
------------+-----------------------------------
      Total |     34,417      100.00
*/

*Generate Zombie (ruling out START UPS) 2013-2015
gen zombie_alive_2015="."
replace zombie_alive_2015="No Zombie" if failure_2013==0 & failure_2015==0 & failure_2014==0
replace zombie_alive_2015="High Risk" if cat_2013==1 & cat_2014==1 & cat_2015==1 & failure_2014==0 & failure_2015==0 & failure_2013==0 & year_of_incorporation<2013 
replace zombie_alive_2015="Medium-High Risk" if cat_2013==2 & cat_2014==1 & cat_2015==1 & failure_2015==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2013 
replace zombie_alive_2015="Medium-High Risk" if cat_2013==1 & cat_2014==2 & cat_2015==1 & failure_2015==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2013 
replace zombie_alive_2015="Medium Risk" if cat_2013==2 & cat_2014==2 & cat_2015==1 & failure_2015==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2013 
replace zombie_alive_2015="Medium Risk" if cat_2013==1 & cat_2014==1 & cat_2015==2 & failure_2015==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2013 
replace zombie_alive_2015="Medium-Low Risk" if cat_2013==1 & cat_2014==2 & cat_2015==2 & failure_2015==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2013 
replace zombie_alive_2015="Medium-Low Risk" if cat_2013==2 & cat_2014==1 & cat_2015==2 & failure_2015==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2013 
replace zombie_alive_2015="Low Risk" if cat_2013==2 & cat_2014==2 & cat_2015==2 & failure_2015==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2013 
tab zombie_alive_2015 if zombie_alive_2015!="."

/*
     zombie_alive_2015 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |     13,768        3.34        3.34
        Low Risk |      4,746        1.15        4.50
     Medium Risk |      6,828        1.66        6.16
Medium-High Risk |      5,566        1.35        7.51
 Medium-Low Risk |      5,897        1.43        8.94
       No Zombie |    374,831       91.06      100.00
-----------------+-----------------------------------
           Total |    411,636      100.00          
*/

tab zombie_alive_2015 if iso=="IT" & zombie_alive_2015!="."

/*
     zombie_alive_2015 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |     10,998        4.64        4.64
        Low Risk |      4,537        1.92        6.56
     Medium Risk |      5,736        2.42        8.98
Medium-High Risk |      4,521        1.91       10.89
 Medium-Low Risk |      5,247        2.22       13.11
       No Zombie |    205,778       86.89      100.00
-----------------+-----------------------------------
           Total |    236,817      100.00
*/

gen dummy_alive_2015=.
replace dummy_alive_2015=1 if zombie_alive_2015=="High Risk" | zombie_alive_2015=="Medium-High Risk" | zombie_alive_2015=="Medium Risk" | zombie_alive_2015=="Medium-Low Risk" | zombie_alive_2015=="Low Risk"
replace dummy_alive_2015=0 if zombie_alive_2015=="No Zombie" 
tab dummy_alive_2015

/*
 dummy_alive_2015 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    374,831       91.06       91.06
          1 |     36,805        8.94      100.00
------------+-----------------------------------
      Total |    411,636      100.00
*/

tab dummy_alive_2015 if iso=="IT"

/*
 dummy_alive_2015 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    205,778       86.89       86.89
          1 |     31,039       13.11      100.00
------------+-----------------------------------
      Total |    236,817      100.00
*/

tab dummy_alive_2015 if iso=="ES"

/*
 dummy_alive_2015 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     73,407       95.33       95.33
          1 |      3,596        4.67      100.00
------------+-----------------------------------
      Total |     77,003      100.00
*/

tab dummy_alive_2015 if iso=="FR"

/*
 dummy_alive_2015 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     64,165       98.10       98.10
          1 |      1,241        1.90      100.00
------------+-----------------------------------
      Total |     65,406      100.00
*/

tab dummy_alive_2015 if iso=="PT"

/*
 dummy_alive_2015 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     31,481       97.13       97.13
          1 |        929        2.87      100.00
------------+-----------------------------------
      Total |     32,410      100.00
*/


*Generate Zombie (ruling out START UPS) 2012-2014
gen zombie_alive_2014="."
replace zombie_alive_2014="No Zombie" if failure_2012==0 & failure_2013==0 & failure_2014==0
replace zombie_alive_2014="High Risk" if cat_2012==1 & cat_2013==1 & cat_2014==1 & failure_2014==0 & failure_2012==0 & failure_2013==0 & year_of_incorporation<2012 
replace zombie_alive_2014="Medium-High Risk" if cat_2012==2 & cat_2013==1 & cat_2014==1 & failure_2012==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2012 
replace zombie_alive_2014="Medium-High Risk" if cat_2012==1 & cat_2013==2 & cat_2014==1 & failure_2012==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2012 
replace zombie_alive_2014="Medium Risk" if cat_2012==2 & cat_2013==2 & cat_2014==1 & failure_2012==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2012 
replace zombie_alive_2014="Medium Risk" if cat_2012==1 & cat_2013==1 & cat_2014==2 & failure_2012==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2012 
replace zombie_alive_2014="Medium-Low Risk" if cat_2012==1 & cat_2013==2 & cat_2014==2 & failure_2012==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2012 
replace zombie_alive_2014="Medium-Low Risk" if cat_2012==2 & cat_2013==1 & cat_2014==2 & failure_2012==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2012 
replace zombie_alive_2014="Low Risk" if cat_2012==2 & cat_2013==2 & cat_2014==2 & failure_2012==0 & failure_2014==0 & failure_2013==0 & year_of_incorporation<2012 
tab zombie_alive_2014 if zombie_alive_2014!="."

/*
     zombie_alive_2014 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |     13,542        3.48        3.48
        Low Risk |      3,271        0.84        4.32
     Medium Risk |      5,229        1.34        5.67
Medium-High Risk |      5,780        1.49        7.16
 Medium-Low Risk |      4,235        1.09        8.24
       No Zombie |    356,765       91.76      100.00
-----------------+-----------------------------------
           Total |    388,822      100.00     
*/
		   
tab zombie_alive_2014 if iso=="IT" & zombie_alive_2014!="."

/*
     zombie_alive_2014 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |     10,884        4.91        4.91
        Low Risk |      3,062        1.38        6.29
     Medium Risk |      4,534        2.04        8.33
Medium-High Risk |      4,700        2.12       10.45
 Medium-Low Risk |      3,837        1.73       12.18
       No Zombie |    194,831       87.82      100.00
-----------------+-----------------------------------
           Total |    221,848      100.00    
*/

gen dummy_alive_2014=.
replace dummy_alive_2014=1 if zombie_alive_2014=="High Risk" | zombie_alive_2014=="Medium-High Risk" | zombie_alive_2014=="Medium Risk" | zombie_alive_2014=="Medium-Low Risk" | zombie_alive_2014=="Low Risk"
replace dummy_alive_2014=0 if zombie_alive_2014=="No Zombie" 
tab dummy_alive_2014

/*
 dummy_alive_2014 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    356,765       91.76       91.76
          1 |     32,057        8.24      100.00
------------+-----------------------------------
      Total |    388,822      100.00       
*/

tab dummy_alive_2014 if iso=="IT"

/*
dummy_alive_2014  |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    194,831       87.82       87.82
          1 |     27,017       12.18      100.00
------------+-----------------------------------
      Total |    221,848      100.00
*/

tab dummy_alive_2014 if iso=="ES"

/*
 dummy_alive_2014 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     69,855       94.51       94.51
          1 |      4,058        5.49      100.00
------------+-----------------------------------
      Total |     73,913      100.00      
*/

tab dummy_alive_2014 if iso=="FR"

/*
 dummy_alive_2014 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     62,212       99.34       99.34
          1 |        415        0.66      100.00
------------+-----------------------------------
      Total |     62,627      100.00    
*/

tab dummy_alive_2014 if iso=="PT"

/*
 dummy_alive_2014 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     29,867       98.14       98.14
          1 |        567        1.86      100.00
------------+-----------------------------------
      Total |     30,434      100.00     
*/

*Generate Zombie (ruling out START UPS) 2011-2013
gen zombie_alive_2013="."
replace zombie_alive_2013="No Zombie" if failure_2011==0 & failure_2012==0 & failure_2013==0
replace zombie_alive_2013="High Risk" if cat_2011==1 & cat_2012==1 & cat_2013==1 & failure_2011==0 & failure_2012==0 & failure_2013==0 & year_of_incorporation<2011 
replace zombie_alive_2013="Medium-High Risk" if cat_2011==2 & cat_2012==1 & cat_2013==1 & failure_2012==0 & failure_2011==0 & failure_2013==0 & year_of_incorporation<2011 
replace zombie_alive_2013="Medium-High Risk" if cat_2011==1 & cat_2012==2 & cat_2013==1 & failure_2012==0 & failure_2011==0 & failure_2013==0 & year_of_incorporation<2011 
replace zombie_alive_2013="Medium Risk" if cat_2011==2 & cat_2012==2 & cat_2013==1 & failure_2012==0 & failure_2011==0 & failure_2013==0 & year_of_incorporation<2011 
replace zombie_alive_2013="Medium Risk" if cat_2011==1 & cat_2012==1 & cat_2013==2 & failure_2012==0 & failure_2011==0 & failure_2013==0 & year_of_incorporation<2011 
replace zombie_alive_2013="Medium-Low Risk" if cat_2011==1 & cat_2012==2 & cat_2013==2 & failure_2012==0 & failure_2011==0 & failure_2013==0 & year_of_incorporation<2011 
replace zombie_alive_2013="Medium-Low Risk" if cat_2011==2 & cat_2012==1 & cat_2013==2 & failure_2012==0 & failure_2011==0 & failure_2013==0 & year_of_incorporation<2011 
replace zombie_alive_2013="Low Risk" if cat_2011==2 & cat_2012==2 & cat_2013==2 & failure_2012==0 & failure_2011==0 & failure_2013==0 & year_of_incorporation<2011
tab zombie_alive_2013 if zombie_alive_2013!="."

/*
     zombie_alive_2013 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |     12,633        3.43        3.43
        Low Risk |      3,427        0.93        4.36
     Medium Risk |      4,328        1.17        5.53
Medium-High Risk |      5,280        1.43        6.96
 Medium-Low Risk |      4,198        1.14        8.10
       No Zombie |    338,763       91.90      100.00
-----------------+-----------------------------------
           Total |    368,629      100.00      
*/
		   
tab zombie_alive_2013 if iso=="IT" & zombie_alive_2013!="."

/*
     zombie_alive_2013 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |     10,339        4.96        4.96
        Low Risk |      3,268        1.57        6.52
     Medium Risk |      3,824        1.83        8.36
Medium-High Risk |      4,396        2.11       10.46
 Medium-Low Risk |      3,759        1.80       12.27
       No Zombie |    182,987       87.73      100.00
-----------------+-----------------------------------
           Total |    208,573      100.00      
*/

gen dummy_alive_2013=.
replace dummy_alive_2013=1 if zombie_alive_2013=="High Risk" | zombie_alive_2013=="Medium-High Risk" | zombie_alive_2013=="Medium Risk" | zombie_alive_2013=="Medium-Low Risk" | zombie_alive_2013=="Low Risk"
replace dummy_alive_2013=0 if zombie_alive_2013=="No Zombie"
tab dummy_alive_2013

/*
 dummy_alive_2013 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    338,763       91.90       91.90
          1 |     29,866        8.10      100.00
------------+-----------------------------------
      Total |    368,629      100.00    
*/

tab dummy_alive_2013 if iso=="IT"

/*
 dummy_alive_2013 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    182,987       87.73       87.73
          1 |     25,586       12.27      100.00
------------+-----------------------------------
      Total |    208,573      100.00       
*/

tab dummy_alive_2013 if iso=="ES"

/*
 dummy_alive_2013 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     68,147       95.47       95.47
          1 |      3,234        4.53      100.00
------------+-----------------------------------
      Total |     71,381      100.00    
*/

tab dummy_alive_2013 if iso=="FR"

/*
 dummy_alive_2013 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     59,141       98.97       98.97
          1 |        614        1.03      100.00
------------+-----------------------------------
      Total |     59,755      100.00      
*/

tab dummy_alive_2013 if iso=="PT"

/*
 dummy_alive_2013 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     28,488       98.51       98.51
          1 |        432        1.49      100.00
------------+-----------------------------------
      Total |     28,920      100.00    
*/

*Generate Zombie (ruling out START UPS) 2010-2012
gen zombie_alive_2012="."
replace zombie_alive_2012="No Zombie" if failure_2010==0 & failure_2011==0 & failure_2012==0
replace zombie_alive_2012="High Risk" if cat_2010==1 & cat_2011==1 & cat_2012==1 & failure_2011==0 & failure_2012==0 & failure_2010==0 & year_of_incorporation<2010
replace zombie_alive_2012="Medium-High Risk" if cat_2010==2 & cat_2011==1 & cat_2012==1 & failure_2012==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2010
replace zombie_alive_2012="Medium-High Risk" if cat_2010==1 & cat_2011==2 & cat_2012==1 & failure_2012==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2010
replace zombie_alive_2012="Medium Risk" if cat_2010==2 & cat_2011==2 & cat_2012==1 & failure_2012==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2010
replace zombie_alive_2012="Medium Risk" if cat_2010==1 & cat_2011==1 & cat_2012==2 & failure_2012==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2010
replace zombie_alive_2012="Medium-Low Risk" if cat_2010==1 & cat_2011==2 & cat_2012==2 & failure_2012==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2010
replace zombie_alive_2012="Medium-Low Risk" if cat_2010==2 & cat_2011==1 & cat_2012==2 & failure_2012==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2010
replace zombie_alive_2012="Low Risk" if cat_2010==2 & cat_2011==2 & cat_2012==2 & failure_2012==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2010
tab zombie_alive_2012 if zombie_alive_2012!="."

/*
     zombie_alive_2012 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      9,761        2.77        2.77
        Low Risk |      1,926        0.55        3.32
     Medium Risk |      4,040        1.15        4.46
Medium-High Risk |      4,547        1.29        5.75
 Medium-Low Risk |      3,204        0.91        6.66
       No Zombie |    328,886       93.34      100.00
-----------------+-----------------------------------
           Total |    352,364      100.00   
*/

tab zombie_alive_2012 if iso=="IT" & zombie_alive_2012!="."

/*
     zombie_alive_2012 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      8,663        4.36        4.36
        Low Risk |      1,773        0.89        5.25
     Medium Risk |      3,571        1.80        7.05
Medium-High Risk |      3,755        1.89        8.94
 Medium-Low Risk |      2,726        1.37       10.32
       No Zombie |    178,116       89.68      100.00
-----------------+-----------------------------------
           Total |    198,604      100.00     
*/

gen dummy_alive_2012=.
replace dummy_alive_2012=1 if zombie_alive_2012=="High Risk" | zombie_alive_2012=="Medium-High Risk" | zombie_alive_2012=="Medium Risk" | zombie_alive_2012=="Medium-Low Risk" | zombie_alive_2012=="Low Risk"
replace dummy_alive_2012=0 if zombie_alive_2012=="No Zombie"  
tab dummy_alive_2012

/*
 dummy_alive_2012 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    328,886       93.34       93.34
          1 |     23,478        6.66      100.00
------------+-----------------------------------
      Total |    352,364      100.00     
*/

tab dummy_alive_2012 if iso=="IT"

/*
 dummy_alive_2012 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    178,116       89.68       89.68
          1 |     20,488       10.32      100.00
------------+-----------------------------------
      Total |    198,604      100.00   
*/

tab dummy_alive_2012 if iso=="ES"

/*
 dummy_alive_2012 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     67,329       97.25       97.25
          1 |      1,905        2.75      100.00
------------+-----------------------------------
      Total |     69,234      100.00  
*/

tab dummy_alive_2012 if iso=="FR"

/*
 dummy_alive_2012 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     56,309       98.70       98.70
          1 |        742        1.30      100.00
------------+-----------------------------------
      Total |     57,051      100.00    
*/

tab dummy_alive_2012 if iso=="PT"

/*
 dummy_alive_2012 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     27,132       98.75       98.75
          1 |        343        1.25      100.00
------------+-----------------------------------
      Total |     27,475      100.00  
*/

*Generate Zombie (ruling out START UPS) 2009-2011
gen zombie_alive_2011="."
replace zombie_alive_2011="No Zombie" if failure_2010==0 & failure_2011==0 & failure_2009==0
replace zombie_alive_2011="High Risk" if cat_2009==1 & cat_2010==1 & cat_2011==1 & failure_2011==0 & failure_2009==0 & failure_2010==0 & year_of_incorporation<2009
replace zombie_alive_2011="Medium-High Risk" if cat_2009==2 & cat_2010==1 & cat_2011==1 & failure_2009==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2009
replace zombie_alive_2011="Medium-High Risk" if cat_2009==1 & cat_2010==2 & cat_2011==1 & failure_2009==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2009
replace zombie_alive_2011="Medium Risk" if cat_2009==2 & cat_2010==2 & cat_2011==1 & failure_2009==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2009
replace zombie_alive_2011="Medium Risk" if cat_2009==1 & cat_2010==1 & cat_2011==2 & failure_2009==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2009
replace zombie_alive_2011="Medium-Low Risk" if cat_2009==1 & cat_2010==2 & cat_2011==2 & failure_2009==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2009
replace zombie_alive_2011="Medium-Low Risk" if cat_2009==2 & cat_2010==1 & cat_2011==2 & failure_2009==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2009
replace zombie_alive_2011="Low Risk" if cat_2009==2 & cat_2010==2 & cat_2011==2 & failure_2009==0 & failure_2011==0 & failure_2010==0 & year_of_incorporation<2009
tab zombie_alive_2011 if zombie_alive_2011!="."

/*
     zombie_alive_2011 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      8,197        2.45        2.45
        Low Risk |      1,493        0.45        2.89
     Medium Risk |      3,374        1.01        3.90
Medium-High Risk |      4,372        1.30        5.20
 Medium-Low Risk |      2,684        0.80        6.00
       No Zombie |    315,017       94.00      100.00
-----------------+-----------------------------------
           Total |    335,137      100.00     
*/

tab zombie_alive_2011 if iso=="IT" & zombie_alive_2011!="."

/*
     zombie_alive_2011 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      7,525        4.02        4.02
        Low Risk |      1,350        0.72        4.74
     Medium Risk |      2,898        1.55        6.29
Medium-High Risk |      3,729        1.99        8.29
 Medium-Low Risk |      2,287        1.22        9.51
       No Zombie |    169,303       90.49      100.00
-----------------+-----------------------------------
           Total |    187,092      100.00       
*/

gen dummy_alive_2011=.
replace dummy_alive_2011=1 if zombie_alive_2011=="High Risk" | zombie_alive_2011=="Medium-High Risk" | zombie_alive_2011=="Medium Risk" | zombie_alive_2011=="Medium-Low Risk" | zombie_alive_2011=="Low Risk"
replace dummy_alive_2011=0 if zombie_alive_2011=="No Zombie"
tab dummy_alive_2011

/*
 dummy_alive_2011 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    315,017       94.00       94.00
          1 |     20,120        6.00      100.00
------------+-----------------------------------
      Total |    335,137      100.00
*/

tab dummy_alive_2011 if iso=="IT"

/*
 dummy_alive_2011 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    169,303       90.49       90.49
          1 |     17,789        9.51      100.00
------------+-----------------------------------
      Total |    187,092      100.00     
*/ 

tab dummy_alive_2011 if iso=="ES"

/*
 dummy_alive_2011 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     65,809       97.82       97.82
          1 |      1,464        2.18      100.00
------------+-----------------------------------
      Total |     67,273      100.00       
*/ 

tab dummy_alive_2011 if iso=="FR"

/*
 dummy_alive_2011 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     54,076       99.27       99.27
          1 |        399        0.73      100.00
------------+-----------------------------------
      Total |     54,475      100.00      
*/ 

tab dummy_alive_2011 if iso=="PT"

/*
 dummy_alive_2011 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     25,829       98.22       98.22
          1 |        468        1.78      100.00
------------+-----------------------------------
      Total |     26,297      100.00
*/ 

save zombie_data.dta, replace

