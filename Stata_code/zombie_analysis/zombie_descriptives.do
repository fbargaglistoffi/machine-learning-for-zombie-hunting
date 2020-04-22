* Zombie descriptives

* 2011
tab dummy_hrz_2011
count if dummy_hrz_2011==1 & (failure_2012==1 | failure_2013==1 | failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
count if dummy_hrz_2011==1 & (dummy_hrz_2012==1 | dummy_hrz_2013==1 | dummy_hrz_2014==1 | dummy_hrz_2015==1 | dummy_hrz_2016==1 | dummy_hrz_2017==1) & (failure_2012!=1 & failure_2013!=1 & failure_2014!=1 & failure_2015!=1 & failure_2016!=1 & failure_2017!=1)
count if dummy_hrz_2011==1 & (cat_2012!=0 | cat_2013!=0 | cat_2014!=0 | cat_2015!=0 | cat_2016!=0 | cat_2017!=0) & (failure_2012!=1 & failure_2013!=1 & failure_2014!=1 & failure_2015!=1 & failure_2016!=1 & failure_2017!=1) & (dummy_hrz_2012!=1 & dummy_hrz_2013!=1 & dummy_hrz_2014!=1 & dummy_hrz_2015!=1 & dummy_hrz_2016!=1 & dummy_hrz_2017!=1)

* 2012
tab dummy_hrz_2012
count if dummy_hrz_2012==1 & (failure_2013==1 | failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
count if dummy_hrz_2012==1 & (dummy_hrz_2013==1 | dummy_hrz_2014==1 | dummy_hrz_2015==1 | dummy_hrz_2016==1 | dummy_hrz_2017==1) & (failure_2013!=1 & failure_2014!=1 & failure_2015!=1 & failure_2016!=1 & failure_2017!=1)
count if dummy_hrz_2012==1 & (cat_2013!=0 | cat_2014!=0 | cat_2015!=0 | cat_2016!=0 | cat_2017!=0) & (failure_2013!=1 & failure_2014!=1 & failure_2015!=1 & failure_2016!=1 & failure_2017!=1) & (dummy_hrz_2013!=1 & dummy_hrz_2014!=1 & dummy_hrz_2015!=1 & dummy_hrz_2016!=1 & dummy_hrz_2017!=1)

* 2013 
tab dummy_hrz_2013
count if dummy_hrz_2013==1 & (failure_2014==1 | failure_2015==1 | failure_2016==1 | failure_2017==1)
count if dummy_hrz_2013==1 & (dummy_hrz_2014==1 | dummy_hrz_2015==1 | dummy_hrz_2016==1 | dummy_hrz_2017==1) & (failure_2014!=1 & failure_2015!=1 & failure_2016!=1 & failure_2017!=1)
count if dummy_hrz_2013==1 & (cat_2014!=0 | cat_2015!=0 | cat_2016!=0 | cat_2017!=0) & (failure_2014!=1 & failure_2015!=1 & failure_2016!=1 & failure_2017!=1) & (dummy_hrz_2014!=1 & dummy_hrz_2015!=1 & dummy_hrz_2016!=1 & dummy_hrz_2017!=1)

* 2014
tab dummy_hrz_2014
count if dummy_hrz_2014==1 & (failure_2015==1 | failure_2016==1 | failure_2017==1)
count if dummy_hrz_2014==1 & (dummy_hrz_2015==1 | dummy_hrz_2016==1 | dummy_hrz_2017==1) & (failure_2015!=1 & failure_2016!=1 & failure_2017!=1)
count if dummy_hrz_2014==1 & (cat_2015!=0 | cat_2016!=0 | cat_2017!=0) & (failure_2015!=1 & failure_2016!=1 & failure_2017!=1) & (dummy_hrz_2015!=1 & dummy_hrz_2016!=1 & dummy_hrz_2017!=1)

* 2015
tab dummy_hrz_2015
count if dummy_hrz_2015==1 & (failure_2016==1 | failure_2017==1)
count if dummy_hrz_2015==1 & (dummy_hrz_2016==1 | dummy_hrz_2017==1) & (failure_2016!=1 & failure_2017!=1)
count if dummy_hrz_2015==1 & (cat_2016!=0 | cat_2017!=0) & (failure_2016!=1 & failure_2017!=1) & (dummy_hrz_2016!=1 & dummy_hrz_2017!=1)

* 2016
tab dummy_hrz_2016
count if dummy_hrz_2016==1 & (failure_2017==1)
count if dummy_hrz_2016==1 & (dummy_hrz_2017==1) & (failure_2017!=1)
count if dummy_hrz_2016==1 & (cat_2017!=0) & (failure_2017!=1) & (dummy_hrz_2017!=1)



