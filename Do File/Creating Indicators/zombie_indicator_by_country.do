*ZOMBIE INDICATOR CREATION

clear all 
cd "G:\Il mio Drive\Research\Italian Firms\Zombie Hunting New Data"
use data_all_countries.dta, replace

*SPAIN

merge 1:1 id using dati_es_2016.dta
rename _merge drop_es_2016

merge 1:1 id using dati_es_2015.dta
rename _merge drop_es_2015

merge 1:1 id using dati_es_2014.dta
rename _merge drop_es_2014

merge 1:1 id using dati_es_2013.dta
rename _merge drop_es_2013

gen zombie_es_2017_2015="."
replace zombie_es_2017_2015="High Risk" if cat_es_2015==1 & cat_es_2016==1 & cat_es_2017==1 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_es_2015==3 & drop_es_2016==3 & iso=="ES"
replace zombie_es_2017_2015="Medium-High Risk" if cat_es_2015==2 & cat_es_2016==1 & cat_es_2017==1 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_es_2015==3 & drop_es_2016==3 & iso=="ES"
replace zombie_es_2017_2015="Medium-High Risk" if cat_es_2015==1 & cat_es_2016==2 & cat_es_2017==1 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_es_2015==3 & drop_es_2016==3 & iso=="ES"
replace zombie_es_2017_2015="Medium Risk" if cat_es_2015==2 & cat_es_2016==2 & cat_es_2017==1 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_es_2015==3 & drop_es_2016==3 & iso=="ES"
replace zombie_es_2017_2015="Medium Risk" if cat_es_2015==1 & cat_es_2016==1 & cat_es_2017==2 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_es_2015==3 & drop_es_2016==3 & iso=="ES"
replace zombie_es_2017_2015="Medium-Low Risk" if cat_es_2015==1 & cat_es_2016==2 & cat_es_2017==2 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_es_2015==3 & drop_es_2016==3 & iso=="ES"
replace zombie_es_2017_2015="Medium-Low Risk" if cat_es_2015==2 & cat_es_2016==1 & cat_es_2017==2 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_es_2015==3 & drop_es_2016==3 & iso=="ES"
replace zombie_es_2017_2015="Low Risk" if cat_es_2015==2 & cat_es_2016==2 & cat_es_2017==2 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_es_2015==3 & drop_es_2016==3 & iso=="ES"
tab zombie_es_2017_2015 if drop_es_2015==3 & drop_es_2016==3 


gen zombie_es_2016_2014="."
replace zombie_es_2016_2014="High Risk" if cat_es_2014==1 & cat_es_2015==1 & cat_es_2016==1 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_es_2014==3 & drop_es_2015==3 & iso=="ES"
replace zombie_es_2016_2014="Medium-High Risk" if cat_es_2014==2 & cat_es_2015==1 & cat_es_2016==1 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_es_2014==3 & drop_es_2015==3 & iso=="ES"
replace zombie_es_2016_2014="Medium-High Risk" if cat_es_2014==1 & cat_es_2015==2 & cat_es_2016==1 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_es_2014==3 & drop_es_2015==3 & iso=="ES"
replace zombie_es_2016_2014="Medium Risk" if cat_es_2014==2 & cat_es_2015==2 & cat_es_2016==1 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_es_2014==3 & drop_es_2015==3 & iso=="ES"
replace zombie_es_2016_2014="Medium Risk" if cat_es_2014==1 & cat_es_2015==1 & cat_es_2016==2 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_es_2014==3 & drop_es_2015==3 & iso=="ES"
replace zombie_es_2016_2014="Medium-Low Risk" if cat_es_2014==1 & cat_es_2015==2 & cat_es_2016==2 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_es_2014==3 & drop_es_2015==3 & iso=="ES"
replace zombie_es_2016_2014="Medium-Low Risk" if cat_es_2014==2 & cat_es_2015==1 & cat_es_2016==2 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_es_2014==3 & drop_es_2015==3 & iso=="ES"
replace zombie_es_2016_2014="Low Risk" if cat_es_2014==2 & cat_es_2015==2 & cat_es_2016==2 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_es_2014==3 & drop_es_2015==3 & iso=="ES"
tab zombie_es_2016_2014 if drop_es_2014==3 & drop_es_2015==3 


* FRANCE

merge 1:1 id using dati_fr_2016.dta
rename _merge drop_fr_2016

merge 1:1 id using dati_fr_2015.dta
rename _merge drop_fr_2015

merge 1:1 id using dati_fr_2014.dta
rename _merge drop_fr_2014

merge 1:1 id using dati_fr_2013.dta
rename _merge drop_fr_2013


gen zombie_fr_2017_2015="."
replace zombie_fr_2017_2015="High Risk" if cat_fr_2015==1 & cat_fr_2016==1 & cat_fr_2017==1 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_fr_2015==3 & drop_fr_2016==3 & iso=="FR"
replace zombie_fr_2017_2015="Medium-High Risk" if cat_fr_2015==2 & cat_fr_2016==1 & cat_fr_2017==1 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_fr_2015==3 & drop_fr_2016==3 & iso=="FR"
replace zombie_fr_2017_2015="Medium-High Risk" if cat_fr_2015==1 & cat_fr_2016==2 & cat_fr_2017==1 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_fr_2015==3 & drop_fr_2016==3 & iso=="FR"
replace zombie_fr_2017_2015="Medium Risk" if cat_fr_2015==2 & cat_fr_2016==2 & cat_fr_2017==1 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_fr_2015==3 & drop_fr_2016==3 & iso=="FR"
replace zombie_fr_2017_2015="Medium Risk" if cat_fr_2015==1 & cat_fr_2016==1 & cat_fr_2017==2 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_fr_2015==3 & drop_fr_2016==3 & iso=="FR"
replace zombie_fr_2017_2015="Medium-Low Risk" if cat_fr_2015==1 & cat_fr_2016==2 & cat_fr_2017==2 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_fr_2015==3 & drop_fr_2016==3 & iso=="FR"
replace zombie_fr_2017_2015="Medium-Low Risk" if cat_fr_2015==2 & cat_fr_2016==1 & cat_fr_2017==2 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_fr_2015==3 & drop_fr_2016==3 & iso=="FR"
replace zombie_fr_2017_2015="Low Risk" if cat_fr_2015==2 & cat_fr_2016==2 & cat_fr_2017==2 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_fr_2015==3 & drop_fr_2016==3 & iso=="ES"
tab zombie_fr_2017_2015 if drop_fr_2015==3 & drop_fr_2016==3 

gen zombie_fr_2016_2014="."
replace zombie_fr_2016_2014="High Risk" if cat_fr_2014==1 & cat_fr_2015==1 & cat_fr_2016==1 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_fr_2014==3 & drop_fr_2015==3 & iso=="FR"
replace zombie_fr_2016_2014="Medium-High Risk" if cat_fr_2014==2 & cat_fr_2015==1 & cat_fr_2016==1 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_fr_2014==3 & drop_fr_2015==3 & iso=="FR"
replace zombie_fr_2016_2014="Medium-High Risk" if cat_fr_2014==1 & cat_fr_2015==2 & cat_fr_2016==1 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_fr_2014==3 & drop_fr_2015==3 & iso=="FR"
replace zombie_fr_2016_2014="Medium Risk" if cat_fr_2014==2 & cat_fr_2015==2 & cat_fr_2016==1 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_fr_2014==3 & drop_fr_2015==3 & iso=="FR"
replace zombie_fr_2016_2014="Medium Risk" if cat_fr_2014==1 & cat_fr_2015==1 & cat_fr_2016==2 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_fr_2014==3 & drop_fr_2015==3 & iso=="FR"
replace zombie_fr_2016_2014="Medium-Low Risk" if cat_fr_2014==1 & cat_fr_2015==2 & cat_fr_2016==2 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_fr_2014==3 & drop_fr_2015==3 & iso=="FR"
replace zombie_fr_2016_2014="Medium-Low Risk" if cat_fr_2014==2 & cat_fr_2015==1 & cat_fr_2016==2 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_fr_2014==3 & drop_fr_2015==3 & iso=="FR"
replace zombie_fr_2016_2014="Low Risk" if cat_fr_2014==2 & cat_fr_2015==2 & cat_fr_2016==2 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_fr_2014==3 & drop_fr_2015==3 & iso=="FR"
tab zombie_fr_2016_2014 if drop_fr_2014==3 & drop_fr_2015==3 

* PORTUGAL

merge 1:1 id using dati_pt_2016.dta
rename _merge drop_pt_2016

merge 1:1 id using dati_pt_2015.dta
rename _merge drop_pt_2015

merge 1:1 id using dati_pt_2014.dta
rename _merge drop_pt_2014

merge 1:1 id using dati_pt_2013.dta
rename _merge drop_pt_2013


gen zombie_pt_2017_2015="."
replace zombie_pt_2017_2015="High Risk" if cat_pt_2015==1 & cat_pt_2016==1 & cat_pt_2017==1 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_pt_2015==3 & drop_pt_2016==3 & iso=="PT"
replace zombie_pt_2017_2015="Medium-High Risk" if cat_pt_2015==2 & cat_pt_2016==1 & cat_pt_2017==1 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_pt_2015==3 & drop_pt_2016==3 & iso=="PT"
replace zombie_pt_2017_2015="Medium-High Risk" if cat_pt_2015==1 & cat_pt_2016==2 & cat_pt_2017==1 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_pt_2015==3 & drop_pt_2016==3 & iso=="PT"
replace zombie_pt_2017_2015="Medium Risk" if cat_pt_2015==2 & cat_pt_2016==2 & cat_pt_2017==1 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_pt_2015==3 & drop_pt_2016==3 & iso=="PT"
replace zombie_pt_2017_2015="Medium Risk" if cat_pt_2015==1 & cat_pt_2016==1 & cat_pt_2017==2 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_pt_2015==3 & drop_pt_2016==3 & iso=="PT"
replace zombie_pt_2017_2015="Medium-Low Risk" if cat_pt_2015==1 & cat_pt_2016==2 & cat_pt_2017==2 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_pt_2015==3 & drop_pt_2016==3 & iso=="PT"
replace zombie_pt_2017_2015="Medium-Low Risk" if cat_pt_2015==2 & cat_pt_2016==1 & cat_pt_2017==2 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_pt_2015==3 & drop_pt_2016==3 & iso=="PT"
replace zombie_pt_2017_2015="Low Risk" if cat_pt_2015==2 & cat_pt_2016==2 & cat_pt_2017==2 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_pt_2015==3 & drop_pt_2016==3 & iso=="PT"
tab zombie_pt_2017_2015 if drop_pt_2015==3 & drop_pt_2016==3 

gen zombie_pt_2016_2014="."
replace zombie_pt_2016_2014="High Risk" if cat_pt_2014==1 & cat_pt_2015==1 & cat_pt_2016==1 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_pt_2014==3 & drop_pt_2015==3 & iso=="PT"
replace zombie_pt_2016_2014="Medium-High Risk" if cat_pt_2014==2 & cat_pt_2015==1 & cat_pt_2016==1 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_pt_2014==3 & drop_pt_2015==3 & iso=="PT"
replace zombie_pt_2016_2014="Medium-High Risk" if cat_pt_2014==1 & cat_pt_2015==2 & cat_pt_2016==1 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_pt_2014==3 & drop_pt_2015==3 & iso=="PT"
replace zombie_pt_2016_2014="Medium Risk" if cat_pt_2014==2 & cat_pt_2015==2 & cat_pt_2016==1 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_pt_2014==3 & drop_pt_2015==3 & iso=="PT"
replace zombie_pt_2016_2014="Medium Risk" if cat_pt_2014==1 & cat_pt_2015==1 & cat_pt_2016==2 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_pt_2014==3 & drop_pt_2015==3 & iso=="PT"
replace zombie_pt_2016_2014="Medium-Low Risk" if cat_pt_2014==1 & cat_pt_2015==2 & cat_pt_2016==2 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_pt_2014==3 & drop_pt_2015==3 & iso=="PT"
replace zombie_pt_2016_2014="Medium-Low Risk" if cat_pt_2014==2 & cat_pt_2015==1 & cat_pt_2016==2 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_pt_2014==3 & drop_pt_2015==3 & iso=="PT"
replace zombie_pt_2016_2014="Low Risk" if cat_pt_2014==2 & cat_pt_2015==2 & cat_pt_2016==2 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_pt_2014==3 & drop_pt_2015==3 & iso=="PT"
tab zombie_pt_2016_2014 if drop_pt_2014==3 & drop_pt_2015==3 

* ITALY 

merge 1:1 id using dati_it_2016.dta
rename _merge drop_it_2016

merge 1:1 id using dati_it_2015.dta
rename _merge drop_it_2015

merge 1:1 id using dati_it_2014.dta
rename _merge drop_it_2014

merge 1:1 id using dati_it_2013.dta
rename _merge drop_it_2013

merge 1:1 id using dati_it_2012.dta
rename _merge drop_it_2012

merge 1:1 id using dati_it_2011.dta
rename _merge drop_it_2011

merge 1:1 id using dati_it_2010.dta
rename _merge drop_it_2010

merge 1:1 id using dati_it_2009.dta
rename _merge drop_it_2009

merge 1:1 id using dati_it_2008.dta
rename _merge drop_it_2008

gen zombie_it_2017_2015="."
replace zombie_it_2017_2015="High Risk" if cat_it_2015==1 & cat_it_2016==1 & cat_it_2017==1 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_it_2015==3 & drop_it_2016==3 & iso=="IT"
replace zombie_it_2017_2015="Medium-High Risk" if cat_it_2015==2 & cat_it_2016==1 & cat_it_2017==1 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_it_2015==3 & drop_it_2016==3 & iso=="IT"
replace zombie_it_2017_2015="Medium-High Risk" if cat_it_2015==1 & cat_it_2016==2 & cat_it_2017==1 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_it_2015==3 & drop_it_2016==3 & iso=="IT"
replace zombie_it_2017_2015="Medium Risk" if cat_it_2015==2 & cat_it_2016==2 & cat_it_2017==1 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_it_2015==3 & drop_it_2016==3 & iso=="IT"
replace zombie_it_2017_2015="Medium Risk" if cat_it_2015==1 & cat_it_2016==1 & cat_it_2017==2 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_it_2015==3 & drop_it_2016==3 & iso=="IT"
replace zombie_it_2017_2015="Medium-Low Risk" if cat_it_2015==1 & cat_it_2016==2 & cat_it_2017==2 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_it_2015==3 & drop_it_2016==3 & iso=="IT"
replace zombie_it_2017_2015="Medium-Low Risk" if cat_it_2015==2 & cat_it_2016==1 & cat_it_2017==2 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_it_2015==3 & drop_it_2016==3 & iso=="IT"
replace zombie_it_2017_2015="Low Risk" if cat_it_2015==2 & cat_it_2016==2 & cat_it_2017==2 & failure_2017!=1 & failure_2016!=1 & failure_2015!=1 & year_of_incorporation<2015 & drop_it_2015==3 & drop_it_2016==3 & iso=="IT"
tab zombie_it_2017_2015 if drop_it_2015==3 & drop_it_2016==3 

gen zombie_it_2016_2014="."
replace zombie_it_2016_2014="High Risk" if cat_it_2014==1 & cat_it_2015==1 & cat_it_2016==1 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_it_2014==3 & drop_it_2015==3 & iso=="IT"
replace zombie_it_2016_2014="Medium-High Risk" if cat_it_2014==2 & cat_it_2015==1 & cat_it_2016==1 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_it_2014==3 & drop_it_2015==3 & iso=="IT"
replace zombie_it_2016_2014="Medium-High Risk" if cat_it_2014==1 & cat_it_2015==2 & cat_it_2016==1 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_it_2014==3 & drop_it_2015==3 & iso=="IT"
replace zombie_it_2016_2014="Medium Risk" if cat_it_2014==2 & cat_it_2015==2 & cat_it_2016==1 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_it_2014==3 & drop_it_2015==3 & iso=="IT"
replace zombie_it_2016_2014="Medium Risk" if cat_it_2014==1 & cat_it_2015==1 & cat_it_2016==2 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_it_2014==3 & drop_it_2015==3 & iso=="IT"
replace zombie_it_2016_2014="Medium-Low Risk" if cat_it_2014==1 & cat_it_2015==2 & cat_it_2016==2 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_it_2014==3 & drop_it_2015==3 & iso=="IT"
replace zombie_it_2016_2014="Medium-Low Risk" if cat_it_2014==2 & cat_it_2015==1 & cat_it_2016==2 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_it_2014==3 & drop_it_2015==3 & iso=="IT"
replace zombie_it_2016_2014="Low Risk" if cat_it_2014==2 & cat_it_2015==2 & cat_it_2016==2 & failure_2016!=1 & failure_2015!=1 & failure_2014!=1 & year_of_incorporation<2014 & drop_it_2014==3 & drop_it_2015==3 & iso=="IT"
tab zombie_it_2016_2014 if drop_it_2014==3 & drop_it_2015==3 

gen zombie_it_2015_2013="."
replace zombie_it_2015_2013="High Risk" if cat_it_2013==1 & cat_it_2014==1 & cat_it_2015==1 & failure_2015!=1 & failure_2014!=1 & failure_2013!=1 & year_of_incorporation<2013 & drop_it_2013==3 & drop_it_2014==3 & iso=="IT"
replace zombie_it_2015_2013="Medium-High Risk" if cat_it_2013==2 & cat_it_2014==1 & cat_it_2015==1 & failure_2015!=1 & failure_2014!=1 & failure_2013!=1 & year_of_incorporation<2013 & drop_it_2013==3 & drop_it_2014==3 & iso=="IT"
replace zombie_it_2015_2013="Medium-High Risk" if cat_it_2013==1 & cat_it_2014==2 & cat_it_2015==1 & failure_2015!=1 & failure_2014!=1 & failure_2013!=1 & year_of_incorporation<2013 & drop_it_2013==3 & drop_it_2014==3 & iso=="IT"
replace zombie_it_2015_2013="Medium Risk" if cat_it_2013==2 & cat_it_2014==2 & cat_it_2015==1 & failure_2015!=1 & failure_2014!=1 & failure_2013!=1 & year_of_incorporation<2013 & drop_it_2013==3 & drop_it_2014==3 & iso=="IT"
replace zombie_it_2015_2013="Medium Risk" if cat_it_2013==1 & cat_it_2014==1 & cat_it_2015==2 & failure_2015!=1 & failure_2014!=1 & failure_2013!=1 & year_of_incorporation<2013 & drop_it_2013==3 & drop_it_2014==3 & iso=="IT"
replace zombie_it_2015_2013="Medium-Low Risk" if cat_it_2013==1 & cat_it_2014==2 & cat_it_2015==2 & failure_2015!=1 & failure_2014!=1 & failure_2013!=1 & year_of_incorporation<2013 & drop_it_2013==3 & drop_it_2014==3 & iso=="IT"
replace zombie_it_2015_2013="Medium-Low Risk" if cat_it_2013==2 & cat_it_2014==1 & cat_it_2015==2 & failure_2015!=1 & failure_2014!=1 & failure_2013!=1 & year_of_incorporation<2013 & drop_it_2013==3 & drop_it_2014==3 & iso=="IT"
replace zombie_it_2015_2013="Low Risk" if cat_it_2013==2 & cat_it_2014==2 & cat_it_2015==2 & failure_2015!=1 & failure_2014!=1 & failure_2013!=1 & year_of_incorporation<2013 & drop_it_2013==3 & drop_it_2014==3 & iso=="IT"
tab zombie_it_2015_2013 if drop_it_2013==3 & drop_it_2014==3 

gen zombie_it_2014_2012="."
replace zombie_it_2014_2012="High Risk" if cat_it_2012==1 & cat_it_2013==1 & cat_it_2014==1 & failure_2014!=1 & failure_2013!=1 & failure_2012!=1 & year_of_incorporation<2012 & drop_it_2012==3 & drop_it_2013==3 & iso=="IT"
replace zombie_it_2014_2012="Medium-High Risk" if cat_it_2012==2 & cat_it_2013==1 & cat_it_2014==1 & failure_2014!=1 & failure_2013!=1 & failure_2012!=1 & year_of_incorporation<2012 & drop_it_2012==3 & drop_it_2013==3 & iso=="IT"
replace zombie_it_2014_2012="Medium-High Risk" if cat_it_2012==1 & cat_it_2013==2 & cat_it_2014==1 & failure_2014!=1 & failure_2013!=1 & failure_2012!=1 & year_of_incorporation<2012 & drop_it_2012==3 & drop_it_2013==3 & iso=="IT"
replace zombie_it_2014_2012="Medium Risk" if cat_it_2012==2 & cat_it_2013==2 & cat_it_2014==1 & failure_2014!=1 & failure_2013!=1 & failure_2012!=1 & year_of_incorporation<2012 & drop_it_2012==3 & drop_it_2013==3 & iso=="IT"
replace zombie_it_2014_2012="Medium Risk" if cat_it_2012==1 & cat_it_2013==1 & cat_it_2014==2 & failure_2014!=1 & failure_2013!=1 & failure_2012!=1 & year_of_incorporation<2012 & drop_it_2012==3 & drop_it_2013==3 & iso=="IT"
replace zombie_it_2014_2012="Medium-Low Risk" if cat_it_2012==1 & cat_it_2013==2 & cat_it_2014==2 & failure_2014!=1 & failure_2013!=1 & failure_2012!=1 & year_of_incorporation<2012 & drop_it_2012==3 & drop_it_2013==3 & iso=="IT"
replace zombie_it_2014_2012="Medium-Low Risk" if cat_it_2012==2 & cat_it_2013==1 & cat_it_2014==2 & failure_2014!=1 & failure_2013!=1 & failure_2012!=1 & year_of_incorporation<2012 & drop_it_2012==3 & drop_it_2013==3 & iso=="IT"
replace zombie_it_2014_2012="Low Risk" if cat_it_2012==2 & cat_it_2013==2 & cat_it_2014==2 & failure_2014!=1 & failure_2013!=1 & failure_2012!=1 & year_of_incorporation<2012 & drop_it_2012==3 & drop_it_2013==3 & iso=="IT"
tab zombie_it_2014_2012 if drop_it_2012==3 & drop_it_2013==3 

gen zombie_it_2013_2011="."
replace zombie_it_2013_2011="High Risk" if cat_it_2011==1 & cat_it_2012==1 & cat_it_2013==1 & failure_2013!=1 & failure_2012!=1 & failure_2011!=1 & year_of_incorporation<2011 & drop_it_2011==3 & drop_it_2012==3 & iso=="IT"
replace zombie_it_2013_2011="Medium-High Risk" if cat_it_2011==2 & cat_it_2012==1 & cat_it_2013==1 & failure_2013!=1 & failure_2012!=1 & failure_2011!=1 & year_of_incorporation<2011 & drop_it_2011==3 & drop_it_2012==3 & iso=="IT"
replace zombie_it_2013_2011="Medium-High Risk" if cat_it_2011==1 & cat_it_2012==2 & cat_it_2013==1 & failure_2013!=1 & failure_2012!=1 & failure_2011!=1 & year_of_incorporation<2011 & drop_it_2011==3 & drop_it_2012==3 & iso=="IT"
replace zombie_it_2013_2011="Medium Risk" if cat_it_2011==2 & cat_it_2012==2 & cat_it_2013==1 & failure_2013!=1 & failure_2012!=1 & failure_2011!=1 & year_of_incorporation<2011 & drop_it_2011==3 & drop_it_2012==3 & iso=="IT"
replace zombie_it_2013_2011="Medium Risk" if cat_it_2011==1 & cat_it_2012==1 & cat_it_2013==2 & failure_2013!=1 & failure_2012!=1 & failure_2011!=1 & year_of_incorporation<2011 & drop_it_2011==3 & drop_it_2012==3 & iso=="IT"
replace zombie_it_2013_2011="Medium-Low Risk" if cat_it_2011==1 & cat_it_2012==2 & cat_it_2013==2 & failure_2013!=1 & failure_2012!=1 & failure_2011!=1 & year_of_incorporation<2011 & drop_it_2011==3 & drop_it_2012==3 & iso=="IT"
replace zombie_it_2013_2011="Medium-Low Risk" if cat_it_2011==2 & cat_it_2012==1 & cat_it_2013==2 & failure_2013!=1 & failure_2012!=1 & failure_2011!=1 & year_of_incorporation<2011 & drop_it_2011==3 & drop_it_2012==3 & iso=="IT"
replace zombie_it_2013_2011="Low Risk" if cat_it_2011==2 & cat_it_2012==2 & cat_it_2013==2 & failure_2013!=1 & failure_2012!=1 & failure_2011!=1 & year_of_incorporation<2011 & drop_it_2011==3 & drop_it_2012==3 & iso=="IT"
tab zombie_it_2013_2011 if drop_it_2011==3 & drop_it_2012==3 

gen zombie_it_2012_2010="."
replace zombie_it_2012_2010="High Risk" if cat_it_2010==1 & cat_it_2011==1 & cat_it_2012==1 & failure_2012!=1 & failure_2011!=1 & failure_2010!=1 & year_of_incorporation<2010 & drop_it_2010==3 & drop_it_2011==3 & iso=="IT"
replace zombie_it_2012_2010="Medium-High Risk" if cat_it_2010==2 & cat_it_2011==1 & cat_it_2012==1 & failure_2012!=1 & failure_2011!=1 & failure_2010!=1 & year_of_incorporation<2010 & drop_it_2010==3 & drop_it_2011==3 & iso=="IT"
replace zombie_it_2012_2010="Medium-High Risk" if cat_it_2010==1 & cat_it_2011==2 & cat_it_2012==1 & failure_2012!=1 & failure_2011!=1 & failure_2010!=1 & year_of_incorporation<2010 & drop_it_2010==3 & drop_it_2011==3 & iso=="IT"
replace zombie_it_2012_2010="Medium Risk" if cat_it_2010==2 & cat_it_2011==2 & cat_it_2012==1 & failure_2012!=1 & failure_2011!=1 & failure_2010!=1 & year_of_incorporation<2010 & drop_it_2010==3 & drop_it_2011==3 & iso=="IT"
replace zombie_it_2012_2010="Medium Risk" if cat_it_2010==1 & cat_it_2011==1 & cat_it_2012==2 & failure_2012!=1 & failure_2011!=1 & failure_2010!=1 & year_of_incorporation<2010 & drop_it_2010==3 & drop_it_2011==3 & iso=="IT"
replace zombie_it_2012_2010="Medium-Low Risk" if cat_it_2010==1 & cat_it_2011==2 & cat_it_2012==2 & failure_2012!=1 & failure_2011!=1 & failure_2010!=1 & year_of_incorporation<2010 & drop_it_2010==3 & drop_it_2011==3 & iso=="IT"
replace zombie_it_2012_2010="Medium-Low Risk" if cat_it_2010==2 & cat_it_2011==1 & cat_it_2012==2 & failure_2012!=1 & failure_2011!=1 & failure_2010!=1 & year_of_incorporation<2010 & drop_it_2010==3 & drop_it_2011==3 & iso=="IT"
replace zombie_it_2012_2010="Low Risk" if cat_it_2010==2 & cat_it_2011==2 & cat_it_2012==2 & failure_2012!=1 & failure_2011!=1 & failure_2010!=1 & year_of_incorporation<2010 & drop_it_2010==3 & drop_it_2011==3 & iso=="IT"
tab zombie_it_2012_2010 if drop_it_2010==3 & drop_it_2011==3 

gen zombie_it_2011_2009="."
replace zombie_it_2011_2009="High Risk" if cat_it_2009==1 & cat_it_2010==1 & cat_it_2011==1 & failure_2011!=1 & failure_2010!=1 & failure_2009!=1 & year_of_incorporation<2009 & drop_it_2009==3 & drop_it_2010==3 & iso=="IT"
replace zombie_it_2011_2009="Medium-High Risk" if cat_it_2009==2 & cat_it_2010==1 & cat_it_2011==1 & failure_2011!=1 & failure_2010!=1 & failure_2009!=1 & year_of_incorporation<2009 & drop_it_2009==3 & drop_it_2010==3 & iso=="IT"
replace zombie_it_2011_2009="Medium-High Risk" if cat_it_2009==1 & cat_it_2010==2 & cat_it_2011==1 & failure_2011!=1 & failure_2010!=1 & failure_2009!=1 & year_of_incorporation<2009 & drop_it_2009==3 & drop_it_2010==3 & iso=="IT"
replace zombie_it_2011_2009="Medium Risk" if cat_it_2009==2 & cat_it_2010==2 & cat_it_2011==1 & failure_2011!=1 & failure_2010!=1 & failure_2009!=1 & year_of_incorporation<2009 & drop_it_2009==3 & drop_it_2010==3 & iso=="IT"
replace zombie_it_2011_2009="Medium Risk" if cat_it_2009==1 & cat_it_2010==1 & cat_it_2011==2 & failure_2011!=1 & failure_2010!=1 & failure_2009!=1 & year_of_incorporation<2009 & drop_it_2009==3 & drop_it_2010==3 & iso=="IT"
replace zombie_it_2011_2009="Medium-Low Risk" if cat_it_2009==1 & cat_it_2010==2 & cat_it_2011==2 & failure_2011!=1 & failure_2010!=1 & failure_2009!=1 & year_of_incorporation<2009 & drop_it_2009==3 & drop_it_2010==3 & iso=="IT"
replace zombie_it_2011_2009="Medium-Low Risk" if cat_it_2009==2 & cat_it_2010==1 & cat_it_2011==2 & failure_2011!=1 & failure_2010!=1 & failure_2009!=1 & year_of_incorporation<2009 & drop_it_2009==3 & drop_it_2010==3 & iso=="IT"
replace zombie_it_2011_2009="Low Risk" if cat_it_2009==2 & cat_it_2010==2 & cat_it_2011==2 & failure_2011!=1 & failure_2010!=1 & failure_2009!=1 & year_of_incorporation<2009 & drop_it_2009==3 & drop_it_2010==3 & iso=="IT"
tab zombie_it_2011_2009 if drop_it_2009==3 & drop_it_2010==3 

save zombie_indicator_by_country.dta, replace

*Density of Zombies in Italy (2014)
tab  if zombie_it_2014_2012 != "."
tab region if iso=="IT" &  year_of_incorporation<2014 & failure_2014!=. & failure_2013!=. & failure_2012!=. & failure_2011!=. & failure_2010!=. & failure_2009!=. 
tab region if iso=="IT" & zombie_it_2014_2012!="."  & (failure_2015==1 | failure_2016==1 | failure_2017==1) 

tab nace_2 if iso=="IT"
tab nace_2 if region=="Valle D'Aosta" 
tab nace_2 if zombie_it_2014_2012!="."
tab nace_2 if zombie_it_2014_2012!="." & region=="Valle D'Aosta" 
tab employees_2014 if iso=="IT"
tab employees_2014 if region=="Valle D'Aosta" 
tab employees_2014 if zombie_it_2014_2012!="." & region=="Valle D'Aosta"
tab employees_2014 if zombie_it_2014_2012!="."

/* Mainly Agricolture (10-18) and Printing sector (within zombie: 46% vs 13% 
 within population: 22% vs 15%) : highly subsidized by state (Programmi sviluppo rurale)
 and very small firms: 1-3 employees (within zombie: 83% vs 64% 
 within population: 67% vs 57%)*/




