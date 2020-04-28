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
       High Risk |      7,100        2.07        2.07
        Low Risk |      5,361        1.56        3.63
     Medium Risk |      3,975        1.16        4.78
Medium-High Risk |      3,739        1.09        5.87
 Medium-Low Risk |      4,828        1.41        7.28
       No Zombie |    318,525       92.72      100.00
-----------------+-----------------------------------
           Total |    343,528      100.00
*/

tab zombie_2017 if iso=="IT" & zombie_2017!="."

/*
     zombie_2017 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      5,245        2.73        2.73
        Low Risk |      4,275        2.23        4.96
     Medium Risk |      2,421        1.26        6.22
Medium-High Risk |      2,305        1.20        7.42
 Medium-Low Risk |      2,908        1.52        8.94
       No Zombie |    174,771       91.06      100.00
-----------------+-----------------------------------
           Total |    191,925      100.00
*/

gen dummy_2017=.
replace dummy_2017=1 if zombie_2017=="High Risk" | zombie_2017=="Medium-High Risk" | zombie_2017=="Medium Risk" | zombie_2017=="Medium-Low Risk" | zombie_2017=="Low Risk"
replace dummy_2017=0 if zombie_2017=="No Zombie" 
tab dummy_2017

/*
 dummy_2017 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    318,525       92.72       92.72
          1 |     25,003        7.28      100.00
------------+-----------------------------------
      Total |    343,528      100.00
*/

tab dummy_2017 if iso=="IT"

/*
 dummy_2017 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    174,771       91.06       91.06
          1 |     17,154        8.94      100.00
------------+-----------------------------------
      Total |    191,925      100.00
*/

tab dummy_2017 if iso=="ES"

/*
 dummy_2017 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     64,607       94.30       94.30
          1 |      3,905        5.70      100.00
------------+-----------------------------------
      Total |     68,512      100.00
*/

tab dummy_2017 if iso=="FR"

/*
 dummy_2017 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     54,523       97.08       97.08
          1 |      1,642        2.92      100.00
------------+-----------------------------------
      Total |     56,165      100.00
*/

tab dummy_2017 if iso=="PT"

/*
 dummy_2017 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     24,624       91.45       91.45
          1 |      2,302        8.55      100.00
------------+-----------------------------------
      Total |     26,926      100.00
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
       High Risk |      9,204        2.64        2.64
        Low Risk |      4,783        1.37        4.00
     Medium Risk |      4,998        1.43        5.44
Medium-High Risk |      4,287        1.23        6.66
 Medium-Low Risk |      5,289        1.51        8.18
       No Zombie |    320,720       91.82      100.00
-----------------+-----------------------------------
           Total |    349,281      100.00
*/

tab zombie_2016 if iso=="IT" & zombie_2016!="."

/*
     zombie_2016 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      6,879        3.53        3.53
        Low Risk |      3,915        2.01        5.54
     Medium Risk |      3,153        1.62        7.16
Medium-High Risk |      3,015        1.55        8.70
 Medium-Low Risk |      3,516        1.80       10.51
       No Zombie |    174,440       89.49      100.00
-----------------+-----------------------------------
           Total |    194,918      100.00
*/

gen dummy_2016=.
replace dummy_2016=1 if zombie_2016=="High Risk" | zombie_2016=="Medium-High Risk" | zombie_2016=="Medium Risk" | zombie_2016=="Medium-Low Risk" | zombie_2016=="Low Risk"
replace dummy_2016=0 if zombie_2016=="No Zombie" 
tab dummy_2016

/*
 dummy_2016 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    320,720       91.82       91.82
          1 |     28,561        8.18      100.00
------------+-----------------------------------
      Total |    349,281      100.00
*/

tab dummy_2016 if iso=="IT"

/*
 dummy_2016 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    174,440       89.49       89.49
          1 |     20,478       10.51      100.00
------------+-----------------------------------
      Total |    194,918      100.00
*/

tab dummy_2016 if iso=="ES"

/*
 dummy_2016 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     65,971       95.05       95.05
          1 |      3,439        4.95      100.00
------------+-----------------------------------
      Total |     69,410      100.00
*/

tab dummy_2016 if iso=="FR"

/*
 dummy_2016 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     55,387       96.37       96.37
          1 |      2,088        3.63      100.00
------------+-----------------------------------
      Total |     57,475      100.00
*/

tab dummy_2016 if iso=="PT"

/*
 dummy_2016 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     24,922       90.70       90.70
          1 |      2,556        9.30      100.00
------------+-----------------------------------
      Total |     27,478      100.00
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
       High Risk |     10,995        3.12        3.12
        Low Risk |      4,487        1.27        4.39
     Medium Risk |      5,365        1.52        5.91
Medium-High Risk |      5,283        1.50        7.41
 Medium-Low Risk |      4,137        1.17        8.59
       No Zombie |    322,265       91.41      100.00
-----------------+-----------------------------------
           Total |    352,532      100.00       
*/

tab zombie_2015 if iso=="IT" & zombie_2015!="."

/*
     zombie_2015 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      8,521        4.33        4.33
        Low Risk |      3,888        1.97        6.30
     Medium Risk |      3,781        1.92        8.22
Medium-High Risk |      3,710        1.88       10.10
 Medium-Low Risk |      3,152        1.60       11.70
       No Zombie |    173,955       88.30      100.00
-----------------+-----------------------------------
           Total |    197,007      100.00
*/

gen dummy_2015=.
replace dummy_2015=1 if zombie_2015=="High Risk" | zombie_2015=="Medium-High Risk" | zombie_2015=="Medium Risk" | zombie_2015=="Medium-Low Risk" | zombie_2015=="Low Risk"
replace dummy_2015=0 if zombie_2015=="No Zombie" 
tab dummy_2015

/*
 dummy_2015 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    322,265       91.41       91.41
          1 |     30,267        8.59      100.00
------------+-----------------------------------
      Total |    352,532      100.00
*/

tab dummy_2015 if iso=="IT"

/*
 dummy_2015 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    173,955       88.30       88.30
          1 |     23,052       11.70      100.00
------------+-----------------------------------
      Total |    197,007      100.00
*/

tab dummy_2015 if iso=="ES"

/*
 dummy_2015 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     65,940       94.41       94.41
          1 |      3,904        5.59      100.00
------------+-----------------------------------
      Total |     69,844      100.00
*/

tab dummy_2015 if iso=="FR"

/*
 dummy_2015 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     55,530       96.22       96.22
          1 |      2,184        3.78      100.00
------------+-----------------------------------
      Total |     57,714      100.00
*/

tab dummy_2015 if iso=="PT"

/*
  dummy_2015 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     26,840       95.97       95.97
          1 |      1,127        4.03      100.00
------------+-----------------------------------
      Total |     27,967      100.00
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
       High Risk |     11,457        3.24        3.24
        Low Risk |      3,958        1.12        4.36
     Medium Risk |      5,100        1.44        5.81
Medium-High Risk |      5,768        1.63        7.44
 Medium-Low Risk |      4,768        1.35        8.79
       No Zombie |    322,258       91.21      100.00
-----------------+-----------------------------------
           Total |    353,309      100.00    
*/
		   
tab zombie_2014 if iso=="IT" & zombie_2014!="."

/*
     zombie_2014 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      8,827        4.47        4.47
        Low Risk |      3,486        1.76        6.23
     Medium Risk |      3,907        1.98        8.21
Medium-High Risk |      4,076        2.06       10.27
 Medium-Low Risk |      3,933        1.99       12.26
       No Zombie |    173,384       87.74      100.00
-----------------+-----------------------------------
           Total |    197,613      100.00  
*/

gen dummy_2014=.
replace dummy_2014=1 if zombie_2014=="High Risk" | zombie_2014=="Medium-High Risk" | zombie_2014=="Medium Risk" | zombie_2014=="Medium-Low Risk" | zombie_2014=="Low Risk"
replace dummy_2014=0 if zombie_2014=="No Zombie" 
tab dummy_2014

/*
 dummy_2014 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    322,258       91.21       91.21
          1 |     31,051        8.79      100.00
------------+-----------------------------------
      Total |    353,309      100.00     
*/

tab dummy_2014 if iso=="IT"

/*
 dummy_2014 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    173,384       87.74       87.74
          1 |     24,229       12.26      100.00
------------+-----------------------------------
      Total |    197,613      100.00
*/

tab dummy_2014 if iso=="ES"

/*
 dummy_2014 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     65,355       93.44       93.44
          1 |      4,588        6.56      100.00
------------+-----------------------------------
      Total |     69,943      100.00    
*/

tab dummy_2014 if iso=="FR"

/*
 dummy_2014 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     55,932       96.90       96.90
          1 |      1,791        3.10      100.00
------------+-----------------------------------
      Total |     57,723      100.00 
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
       High Risk |     10,916        3.08        3.08
        Low Risk |      3,754        1.06        4.14
     Medium Risk |      5,042        1.42        5.57
Medium-High Risk |      5,772        1.63        7.20
 Medium-Low Risk |      4,572        1.29        8.49
       No Zombie |    323,900       91.51      100.00
-----------------+-----------------------------------
           Total |    353,956      100.00 
*/
		   
tab zombie_2013 if iso=="IT" & zombie_2013!="."

/*
     zombie_2013 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      8,782        4.43        4.43
        Low Risk |      3,302        1.67        6.10
     Medium Risk |      4,055        2.05        8.14
Medium-High Risk |      4,459        2.25       10.39
 Medium-Low Risk |      3,739        1.89       12.28
       No Zombie |    173,830       87.72      100.00
-----------------+-----------------------------------
           Total |    198,167      100.00    
*/

gen dummy_2013=.
replace dummy_2013=1 if zombie_2013=="High Risk" | zombie_2013=="Medium-High Risk" | zombie_2013=="Medium Risk" | zombie_2013=="Medium-Low Risk" | zombie_2013=="Low Risk"
replace dummy_2013=0 if zombie_2013=="No Zombie"
tab dummy_2013

/*
 dummy_2013 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    323,900       91.51       91.51
          1 |     30,056        8.49      100.00
------------+-----------------------------------
      Total |    353,956      100.00  
*/

tab dummy_2013 if iso=="IT"

/*
 dummy_2013 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    173,830       87.72       87.72
          1 |     24,337       12.28      100.00
------------+-----------------------------------
      Total |    198,167      100.00       
*/

tab dummy_2013 if iso=="ES"8

/*
 dummy_2013 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     65,647       93.76       93.76
          1 |      4,370        6.24      100.00
------------+-----------------------------------
      Total |     70,017      100.00
*/

tab dummy_2013 if iso=="FR"

/*
 dummy_2013 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     56,977       98.69       98.69
          1 |        759        1.31      100.00
------------+-----------------------------------
      Total |     57,736      100.00    
*/

tab dummy_2013 if iso=="PT"

/*
 dummy_2013 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     27,446       97.90       97.90
          1 |        590        2.10      100.00
------------+-----------------------------------
      Total |     28,036      100.00
    
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
       High Risk |      8,728        2.46        2.46
        Low Risk |      3,021        0.85        3.32
     Medium Risk |      4,971        1.40        4.72
Medium-High Risk |      4,994        1.41        6.13
 Medium-Low Risk |      4,069        1.15        7.28
       No Zombie |    328,616       92.72      100.00
-----------------+-----------------------------------
           Total |    354,399      100.00   
*/

tab zombie_2012 if iso=="IT" & zombie_2012!="."

/*
     zombie_2012 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      7,810        3.93        3.93
        Low Risk |      2,781        1.40        5.33
     Medium Risk |      4,254        2.14        7.48
Medium-High Risk |      4,213        2.12        9.60
 Medium-Low Risk |      3,390        1.71       11.31
       No Zombie |    176,110       88.69      100.00
-----------------+-----------------------------------
           Total |    198,558      100.00
*/

gen dummy_2012=.
replace dummy_2012=1 if zombie_2012=="High Risk" | zombie_2012=="Medium-High Risk" | zombie_2012=="Medium Risk" | zombie_2012=="Medium-Low Risk" | zombie_2012=="Low Risk"
replace dummy_2012=0 if zombie_2012=="No Zombie"  
tab dummy_2012

/*
 dummy_2012 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    328,616       92.72       92.72
          1 |     25,783        7.28      100.00
------------+-----------------------------------
      Total |    354,399      100.00    
*/

tab dummy_2012 if iso=="IT"

/*
 dummy_2012 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    176,110       88.69       88.69
          1 |     22,448       11.31      100.00
------------+-----------------------------------
      Total |    198,558      100.00  
*/

tab dummy_2012 if iso=="ES"

/*
 dummy_2012 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     68,018       97.08       97.08
          1 |      2,045        2.92      100.00
------------+-----------------------------------
      Total |     70,063      100.00
*/

tab dummy_2012 if iso=="FR"

/*
 dummy_2012 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     57,035       98.78       98.78
          1 |        702        1.22      100.00
------------+-----------------------------------
      Total |     57,737      100.00 
*/

tab dummy_2012 if iso=="PT"

/*
 dummy_2012 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     27,453       97.90       97.90
          1 |        588        2.10      100.00
------------+-----------------------------------
      Total |     28,041      100.00 
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
       High Risk |      7,665        2.26        2.26
        Low Risk |      2,830        0.83        3.09
     Medium Risk |      4,050        1.19        4.29
Medium-High Risk |      5,023        1.48        5.77
 Medium-Low Risk |      3,895        1.15        6.92
       No Zombie |    315,700       93.08      100.00
-----------------+-----------------------------------
           Total |    339,163      100.00   
*/

tab zombie_2011 if iso=="IT" & zombie_2011!="."

/*
     zombie_2011 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      7,278        3.85        3.85
        Low Risk |      2,721        1.44        5.30
     Medium Risk |      3,567        1.89        7.19
Medium-High Risk |      4,600        2.44        9.62
 Medium-Low Risk |      3,435        1.82       11.44
       No Zombie |    167,195       88.56      100.00
-----------------+-----------------------------------
           Total |    188,796      100.00       
*/

gen dummy_2011=.
replace dummy_2011=1 if zombie_2011=="High Risk" | zombie_2011=="Medium-High Risk" | zombie_2011=="Medium Risk" | zombie_2011=="Medium-Low Risk" | zombie_2011=="Low Risk"
replace dummy_2011=0 if zombie_2011=="No Zombie"
tab dummy_2011

/*
 dummy_2011 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    315,700       93.08       93.08
          1 |     23,463        6.92      100.00
------------+-----------------------------------
      Total |    339,163      100.00
*/

tab dummy_2011 if iso=="IT"

/*
 dummy_2011 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    167,195       88.56       88.56
          1 |     21,601       11.44      100.00
------------+-----------------------------------
      Total |    188,796      100.00  
*/ 

tab dummy_2011 if iso=="ES"

/*
 dummy_2011 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     67,258       98.61       98.61
          1 |        948        1.39      100.00
------------+-----------------------------------
      Total |     68,206      100.00   
*/ 

tab dummy_2011 if iso=="FR"

/*
 dummy_2011 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     54,769       99.09       99.09
          1 |        504        0.91      100.00
------------+-----------------------------------
      Total |     55,273      100.00      
*/ 

tab dummy_2011 if iso=="PT"

/*
 dummy_2011 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     26,478       98.48       98.48
          1 |        410        1.52      100.00
------------+-----------------------------------
      Total |     26,888      100.00
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
zombie_alive_201 |
               7 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      7,100        2.12        2.12
        Low Risk |      5,361        1.60        3.72
     Medium Risk |      3,975        1.19        4.90
Medium-High Risk |      3,739        1.12        6.02
 Medium-Low Risk |      4,828        1.44        7.46
       No Zombie |    310,134       92.54      100.00
-----------------+-----------------------------------
           Total |    335,137      100.00
*/

tab zombie_alive_2017 if iso=="IT" & zombie_alive_2017!="."

/*
zombie_alive_201 |
               7 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      5,245        2.80        2.80
        Low Risk |      4,275        2.28        5.09
     Medium Risk |      2,421        1.29        6.38
Medium-High Risk |      2,305        1.23        7.61
 Medium-Low Risk |      2,908        1.55        9.17
       No Zombie |    169,938       90.83      100.00
-----------------+-----------------------------------
           Total |    187,092      100.00
*/

gen dummy_alive_2017=.
replace dummy_alive_2017=1 if zombie_alive_2017=="High Risk" | zombie_alive_2017=="Medium-High Risk" | zombie_alive_2017=="Medium Risk" | zombie_alive_2017=="Medium-Low Risk" | zombie_alive_2017=="Low Risk"
replace dummy_alive_2017=0 if zombie_alive_2017=="No Zombie" 
tab dummy_alive_2017

/*
dummy_alive |
      _2017 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    310,134       92.54       92.54
          1 |     25,003        7.46      100.00
------------+-----------------------------------
      Total |    335,137      100.00
*/

tab dummy_alive_2017 if iso=="IT"

/*
dummy_alive |
      _2017 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    169,938       90.83       90.83
          1 |     17,154        9.17      100.00
------------+-----------------------------------
      Total |    187,092      100.00
*/

tab dummy_alive_2017 if iso=="ES"

/*
dummy_alive |
      _2017 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     63,368       94.20       94.20
          1 |      3,905        5.80      100.00
------------+-----------------------------------
      Total |     67,273      100.00
*/

tab dummy_alive_2017 if iso=="FR"

/*
dummy_alive |
      _2017 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     52,833       96.99       96.99
          1 |      1,642        3.01      100.00
------------+-----------------------------------
      Total |     54,475      100.00
*/

tab dummy_alive_2017 if iso=="PT"

/*
dummy_alive |
      _2017 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     23,995       91.25       91.25
          1 |      2,302        8.75      100.00
------------+-----------------------------------
      Total |     26,297      100.00

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
zombie_alive_201 |
               6 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      9,204        2.68        2.68
        Low Risk |      4,783        1.39        4.07
     Medium Risk |      4,998        1.45        5.53
Medium-High Risk |      4,287        1.25        6.77
 Medium-Low Risk |      5,289        1.54        8.31
       No Zombie |    314,967       91.69      100.00
-----------------+-----------------------------------
           Total |    343,528      100.00
*/

tab zombie_alive_2016 if iso=="IT" & zombie_alive_2016!="."

/*
zombie_alive_201 |
               6 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      6,879        3.58        3.58
        Low Risk |      3,915        2.04        5.62
     Medium Risk |      3,153        1.64        7.27
Medium-High Risk |      3,015        1.57        8.84
 Medium-Low Risk |      3,516        1.83       10.67
       No Zombie |    171,447       89.33      100.00
-----------------+-----------------------------------
           Total |    191,925      100.00
*/

gen dummy_alive_2016=.
replace dummy_alive_2016=1 if zombie_alive_2016=="High Risk" | zombie_alive_2016=="Medium-High Risk" | zombie_alive_2016=="Medium Risk" | zombie_alive_2016=="Medium-Low Risk" | zombie_alive_2016=="Low Risk"
replace dummy_alive_2016=0 if zombie_alive_2016=="No Zombie" 
tab dummy_alive_2016

/*
dummy_alive |
      _2016 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    314,967       91.69       91.69
          1 |     28,561        8.31      100.00
------------+-----------------------------------
      Total |    343,528      100.00
*/

tab dummy_alive_2016 if iso=="IT"

/*
dummy_alive |
      _2016 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    171,447       89.33       89.33
          1 |     20,478       10.67      100.00
------------+-----------------------------------
      Total |    191,925      100.00
*/

tab dummy_alive_2016 if iso=="ES"

/*
dummy_alive |
      _2016 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     65,073       94.98       94.98
          1 |      3,439        5.02      100.00
------------+-----------------------------------
      Total |     68,512      100.00
*/

tab dummy_alive_2016 if iso=="FR"

/*
dummy_alive |
      _2016 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     54,077       96.28       96.28
          1 |      2,088        3.72      100.00
------------+-----------------------------------
      Total |     56,165      100.00
*/

tab dummy_alive_2016 if iso=="PT"

/*
dummy_alive |
      _2016 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     24,370       90.51       90.51
          1 |      2,556        9.49      100.00
------------+-----------------------------------
      Total |     26,926      100.00
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
zombie_alive_201 |
               5 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |     10,995        3.15        3.15
        Low Risk |      4,487        1.28        4.43
     Medium Risk |      5,365        1.54        5.97
Medium-High Risk |      5,283        1.51        7.48
 Medium-Low Risk |      4,137        1.18        8.67
       No Zombie |    319,014       91.33      100.00
-----------------+-----------------------------------
           Total |    349,281      100.00         
*/

tab zombie_alive_2015 if iso=="IT" & zombie_alive_2015!="."

/*
zombie_alive_201 |
               5 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      8,521        4.37        4.37
        Low Risk |      3,888        1.99        6.37
     Medium Risk |      3,781        1.94        8.31
Medium-High Risk |      3,710        1.90       10.21
 Medium-Low Risk |      3,152        1.62       11.83
       No Zombie |    171,866       88.17      100.00
-----------------+-----------------------------------
           Total |    194,918      100.00
*/

gen dummy_alive_2015=.
replace dummy_alive_2015=1 if zombie_alive_2015=="High Risk" | zombie_alive_2015=="Medium-High Risk" | zombie_alive_2015=="Medium Risk" | zombie_alive_2015=="Medium-Low Risk" | zombie_alive_2015=="Low Risk"
replace dummy_alive_2015=0 if zombie_alive_2015=="No Zombie" 
tab dummy_alive_2015

/*
dummy_alive |
      _2015 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    319,014       91.33       91.33
          1 |     30,267        8.67      100.00
------------+-----------------------------------
      Total |    349,281      100.00
*/

tab dummy_alive_2015 if iso=="IT"

/*
dummy_alive |
      _2015 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    171,866       88.17       88.17
          1 |     23,052       11.83      100.00
------------+-----------------------------------
      Total |    194,918      100.00
*/

tab dummy_alive_2015 if iso=="ES"

/*
dummy_alive |
      _2015 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     65,506       94.38       94.38
          1 |      3,904        5.62      100.00
------------+-----------------------------------
      Total |     69,410      100.00
*/

tab dummy_alive_2015 if iso=="FR"

/*
dummy_alive |
      _2015 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     55,291       96.20       96.20
          1 |      2,184        3.80      100.00
------------+-----------------------------------
      Total |     57,475      100.00
*/

tab dummy_alive_2015 if iso=="PT"

/*
dummy_alive |
      _2015 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     26,351       95.90       95.90
          1 |      1,127        4.10      100.00
------------+-----------------------------------
      Total |     27,478      100.00
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
zombie_alive_201 |
               4 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |     11,457        3.25        3.25
        Low Risk |      3,958        1.12        4.37
     Medium Risk |      5,100        1.45        5.82
Medium-High Risk |      5,768        1.64        7.46
 Medium-Low Risk |      4,768        1.35        8.81
       No Zombie |    321,481       91.19      100.00
-----------------+-----------------------------------
           Total |    352,532      100.00  
*/
		   
tab zombie_alive_2014 if iso=="IT" & zombie_alive_2014!="."

/*
zombie_alive_201 |
               4 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      8,827        4.48        4.48
        Low Risk |      3,486        1.77        6.25
     Medium Risk |      3,907        1.98        8.23
Medium-High Risk |      4,076        2.07       10.30
 Medium-Low Risk |      3,933        2.00       12.30
       No Zombie |    172,778       87.70      100.00
-----------------+-----------------------------------
           Total |    197,007      100.00
*/

gen dummy_alive_2014=.
replace dummy_alive_2014=1 if zombie_alive_2014=="High Risk" | zombie_alive_2014=="Medium-High Risk" | zombie_alive_2014=="Medium Risk" | zombie_alive_2014=="Medium-Low Risk" | zombie_alive_2014=="Low Risk"
replace dummy_alive_2014=0 if zombie_alive_2014=="No Zombie" 
tab dummy_alive_2014

/*
dummy_alive |
      _2014 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    321,481       91.19       91.19
          1 |     31,051        8.81      100.00
------------+-----------------------------------
      Total |    352,532      100.00     
*/

tab dummy_alive_2014 if iso=="IT"

/*
dummy_alive |
      _2014 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    172,778       87.70       87.70
          1 |     24,229       12.30      100.00
------------+-----------------------------------
      Total |    197,007      100.00
*/

tab dummy_alive_2014 if iso=="ES"

/*
dummy_alive |
      _2014 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     65,256       93.43       93.43
          1 |      4,588        6.57      100.00
------------+-----------------------------------
      Total |     69,844      100.00
*/

tab dummy_alive_2014 if iso=="FR"

/*
dummy_alive |
      _2014 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     55,923       96.90       96.90
          1 |      1,791        3.10      100.00
------------+-----------------------------------
      Total |     57,714      100.00
*/

tab dummy_alive_2014 if iso=="PT"

/*
dummy_alive |
      _2014 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     27,524       98.42       98.42
          1 |        443        1.58      100.00
------------+-----------------------------------
      Total |     27,967      100.00 
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
zombie_alive_201 |
               3 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |     10,916        3.09        3.09
        Low Risk |      3,754        1.06        4.15
     Medium Risk |      5,042        1.43        5.58
Medium-High Risk |      5,772        1.63        7.21
 Medium-Low Risk |      4,572        1.29        8.51
       No Zombie |    323,253       91.49      100.00
-----------------+-----------------------------------
           Total |    353,309      100.00
*/
		   
tab zombie_alive_2013 if iso=="IT" & zombie_alive_2013!="."

/*
zombie_alive_201 |
               3 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      8,782        4.44        4.44
        Low Risk |      3,302        1.67        6.11
     Medium Risk |      4,055        2.05        8.17
Medium-High Risk |      4,459        2.26       10.42
 Medium-Low Risk |      3,739        1.89       12.32
       No Zombie |    173,276       87.68      100.00
-----------------+-----------------------------------
           Total |    197,613      100.00 
*/

gen dummy_alive_2013=.
replace dummy_alive_2013=1 if zombie_alive_2013=="High Risk" | zombie_alive_2013=="Medium-High Risk" | zombie_alive_2013=="Medium Risk" | zombie_alive_2013=="Medium-Low Risk" | zombie_alive_2013=="Low Risk"
replace dummy_alive_2013=0 if zombie_alive_2013=="No Zombie"
tab dummy_alive_2013

/*
dummy_alive |
      _2013 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    323,253       91.49       91.49
          1 |     30,056        8.51      100.00
------------+-----------------------------------
      Total |    353,309      100.00 
*/

tab dummy_alive_2013 if iso=="IT"

/*
dummy_alive |
      _2013 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    173,276       87.68       87.68
          1 |     24,337       12.32      100.00
------------+-----------------------------------
      Total |    197,613      100.00
*/

tab dummy_alive_2013 if iso=="ES"

/*
dummy_alive |
      _2013 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     65,573       93.75       93.75
          1 |      4,370        6.25      100.00
------------+-----------------------------------
      Total |     69,943      100.00  
*/

tab dummy_alive_2013 if iso=="FR"

/*
dummy_alive |
      _2013 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     56,964       98.69       98.69
          1 |        759        1.31      100.00
------------+-----------------------------------
      Total |     57,723      100.00      
*/

tab dummy_alive_2013 if iso=="PT"

/*
dummy_alive |
      _2013 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     27,440       97.90       97.90
          1 |        590        2.10      100.00
------------+-----------------------------------
      Total |     28,030      100.00   
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
zombie_alive_201 |
               2 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      8,728        2.47        2.47
        Low Risk |      3,021        0.85        3.32
     Medium Risk |      4,971        1.40        4.72
Medium-High Risk |      4,994        1.41        6.13
 Medium-Low Risk |      4,069        1.15        7.28
       No Zombie |    328,173       92.72      100.00
-----------------+-----------------------------------
           Total |    353,956      100.00
*/

tab zombie_alive_2012 if iso=="IT" & zombie_alive_2012!="."

/*
zombie_alive_201 |
               2 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      7,810        3.94        3.94
        Low Risk |      2,781        1.40        5.34
     Medium Risk |      4,254        2.15        7.49
Medium-High Risk |      4,213        2.13        9.62
 Medium-Low Risk |      3,390        1.71       11.33
       No Zombie |    175,719       88.67      100.00
-----------------+-----------------------------------
           Total |    198,167      100.00    
*/

gen dummy_alive_2012=.
replace dummy_alive_2012=1 if zombie_alive_2012=="High Risk" | zombie_alive_2012=="Medium-High Risk" | zombie_alive_2012=="Medium Risk" | zombie_alive_2012=="Medium-Low Risk" | zombie_alive_2012=="Low Risk"
replace dummy_alive_2012=0 if zombie_alive_2012=="No Zombie"  
tab dummy_alive_2012

/*
dummy_alive |
      _2012 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    328,173       92.72       92.72
          1 |     25,783        7.28      100.00
------------+-----------------------------------
      Total |    353,956      100.00    
*/

tab dummy_alive_2012 if iso=="IT"

/*
dummy_alive |
      _2012 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    175,719       88.67       88.67
          1 |     22,448       11.33      100.00
------------+-----------------------------------
      Total |    198,167      100.00
*/

tab dummy_alive_2012 if iso=="ES"

/*
dummy_alive |
      _2012 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     67,972       97.08       97.08
          1 |      2,045        2.92      100.00
------------+-----------------------------------
      Total |     70,017      100.00 
*/

tab dummy_alive_2012 if iso=="FR"

/*
dummy_alive |
      _2012 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     57,034       98.78       98.78
          1 |        702        1.22      100.00
------------+-----------------------------------
      Total |     57,736      100.00  
*/

tab dummy_alive_2012 if iso=="PT"

/*
dummy_alive |
      _2012 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     27,448       97.90       97.90
          1 |        588        2.10      100.00
------------+-----------------------------------
      Total |     28,036      100.00  
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
zombie_alive_201 |
               1 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      7,665        2.16        2.16
        Low Risk |      2,830        0.80        2.96
     Medium Risk |      4,050        1.14        4.10
Medium-High Risk |      5,023        1.42        5.52
 Medium-Low Risk |      3,895        1.10        6.62
       No Zombie |    330,936       93.38      100.00
-----------------+-----------------------------------
           Total |    354,399      100.00
*/

tab zombie_alive_2011 if iso=="IT" & zombie_alive_2011!="."

/*
zombie_alive_201 |
               1 |      Freq.     Percent        Cum.
-----------------+-----------------------------------
       High Risk |      7,278        3.67        3.67
        Low Risk |      2,721        1.37        5.04
     Medium Risk |      3,567        1.80        6.83
Medium-High Risk |      4,600        2.32        9.15
 Medium-Low Risk |      3,435        1.73       10.88
       No Zombie |    176,957       89.12      100.00
-----------------+-----------------------------------
           Total |    198,558      100.00      
*/

gen dummy_alive_2011=.
replace dummy_alive_2011=1 if zombie_alive_2011=="High Risk" | zombie_alive_2011=="Medium-High Risk" | zombie_alive_2011=="Medium Risk" | zombie_alive_2011=="Medium-Low Risk" | zombie_alive_2011=="Low Risk"
replace dummy_alive_2011=0 if zombie_alive_2011=="No Zombie"
tab dummy_alive_2011

/*
dummy_alive |
      _2011 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    330,936       93.38       93.38
          1 |     23,463        6.62      100.00
------------+-----------------------------------
      Total |    354,399      100.00
*/

tab dummy_alive_2011 if iso=="IT"

/*
dummy_alive |
      _2011 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    176,957       89.12       89.12
          1 |     21,601       10.88      100.00
------------+-----------------------------------
      Total |    198,558      100.00  
*/ 

tab dummy_alive_2011 if iso=="ES"

/*
dummy_alive |
      _2011 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     69,115       98.65       98.65
          1 |        948        1.35      100.00
------------+-----------------------------------
      Total |     70,063      100.00    
*/ 

tab dummy_alive_2011 if iso=="FR"

/*
dummy_alive |
      _2011 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     57,233       99.13       99.13
          1 |        504        0.87      100.00
------------+-----------------------------------
      Total |     57,737      100.00     
*/ 

tab dummy_alive_2011 if iso=="PT"

/*
dummy_alive |
      _2011 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |     27,631       98.54       98.54
          1 |        410        1.46      100.00
------------+-----------------------------------
      Total |     28,041      100.00
*/ 

********************************************************************************
* Generate High-Risk Zombies (HRZ): enteprises above 9th decile for 3 consecutive years

forval j = 2011/2017 {
	 gen dummy_hrz_`j'=.
     replace dummy_hrz_`j' = 1 if zombie_`j'=="High Risk"
	 replace dummy_hrz_`j' = 0 if zombie_`j'=="Medium-High Risk"
	 replace dummy_hrz_`j' = 0 if zombie_`j'=="Medium Risk"
	 replace dummy_hrz_`j' = 0 if zombie_`j'=="Medium-Low Risk"
	 replace dummy_hrz_`j' = 0 if zombie_`j'=="Low Risk"
	 replace dummy_hrz_`j' = 0 if zombie_`j'=="No Zombie"
}

forval j= 2011/2017{
	tab dummy_hrz_`j'
}

/*
dummy_hrz_2 |
        011 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    181,518       96.15       96.15
          1 |      7,278        3.85      100.00
------------+-----------------------------------
      Total |    188,796      100.00

dummy_hrz_2 |
        012 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    190,748       96.07       96.07
          1 |      7,810        3.93      100.00
------------+-----------------------------------
      Total |    198,558      100.00

dummy_hrz_2 |
        013 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    189,385       95.57       95.57
          1 |      8,782        4.43      100.00
------------+-----------------------------------
      Total |    198,167      100.00

dummy_hrz_2 |
        014 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    188,786       95.53       95.53
          1 |      8,827        4.47      100.00
------------+-----------------------------------
      Total |    197,613      100.00

dummy_hrz_2 |
        015 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    188,486       95.67       95.67
          1 |      8,521        4.33      100.00
------------+-----------------------------------
      Total |    197,007      100.00

dummy_hrz_2 |
        016 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    188,039       96.47       96.47
          1 |      6,879        3.53      100.00
------------+-----------------------------------
      Total |    194,918      100.00

dummy_hrz_2 |
        017 |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |    186,680       97.27       97.27
          1 |      5,245        2.73      100.00
------------+-----------------------------------
      Total |    191,925      100.00
*/


save zombie_data.dta, replace

