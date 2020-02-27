********************************************************************************
*Zombie prediction with LASSO

*Missing data
misstable summarize
misstable patterns


*Zombies 2014/2016
*LASSO REGRESSION
encode nuts3, gen(NUTS3)
lars dummy_2016_2014 NAICS3digits  fn_rvn2013 solvency2013 employees2013 fin_cons2013 fn_exp2013 inv2013 WE2013 interest_DIFF2013 NEG_VA2013 ICR_failure2013 zone  real_SA2013 rvn2013 , a(lasso) cluster(NAICS3digits NUTS3) vce(robust)
*FE LINEAR PROBABILITY MODEL
reghdfe dummy_2016_2014 fn_rvn2013 solvency2013 employees2013 fin_cons2013 fn_exp2013 inv2013 WE2013 interest_DIFF2013 NEG_VA2013 ICR_failure2013 real_SA2013 rvn2013, absorb(NUTS3 NAICS3digits) vce(cluster NUTS3 NAICS3digits)
reghdfe dummy_2016_2014 fn_rvn2013 solvency2013 employees2013 fin_cons2013 fn_exp2013 inv2013 WE2013 interest_DIFF2013 NEG_VA2013 ICR_failure2013 real_SA2013 rvn2013, absorb(NUTS3 NAICS3digits) vce(robust)

*Double check just variable selected by LASSO
reghdfe dummy_2016_2014 fn_exp2013 solvency2013 inv2013 interest_DIFF2013 NEG_VA2013 ICR_failure2013 real_SA2013 rvn2013,absorb(NUTS3 NAICS3digits) vce(cluster NUTS3 NAICS3digits)
reghdfe dummy_2016_2014 fn_exp2013 solvency2013 inv2013 interest_DIFF2013 NEG_VA2013 ICR_failure2013 real_SA2013 rvn2013,absorb(NUTS3 NAICS3digits) vce(robust)

*LOGISTIC REGRESSION & MULTINOMIAL LOGIT
logit dummy_2016_2014 i.NAICS3digits fn_rvn2013 solvency2013 employees2013 fin_cons2013 fn_exp2013 inv2013 WE2013 interest_DIFF2013 NEG_VA2013 ICR_failure2013 real_SA2013 rvn2013 i.zone, cluster(NUTS3) robust
encode zombie_2016_2014, gen(Zombie_2016_2014)
mlogit Zombie_2016_2014 i.NAICS3digits fn_rvn2013 solvency2013 employees2013 fin_cons2013 fn_exp2013 inv2013 WE2013 interest_DIFF2013 NEG_VA2013 ICR_failure2013 real_SA2013 rvn2013 i.zone, rrr cluster(NUTS3) robust


*Zombies 2013/2015
*LASSO REGRESSION
lars dummy_2015_2013 NAICS3digits  fn_rvn2012 solvency2012 employees2012 fin_cons2012 fn_exp2012 inv2012 WE2012 interest_DIFF2012 NEG_VA2012 ICR_failure2012 zone  real_SA2012 rvn2012 , a(lasso) cluster(NAICS3digits NUTS3) vce(robust)

*FE LINEAR PROBABILITY MODEL
reghdfe dummy_2015_2013 fn_rvn2012 solvency2012 employees2012 fin_cons2012 fn_exp2012 inv2012 WE2012 interest_DIFF2012 NEG_VA2012 ICR_failure2012 real_SA2012 rvn2012, absorb(NUTS3 NAICS3digits) vce(cluster NUTS3 NAICS3digits)
reghdfe dummy_2015_2013 fn_rvn2012 solvency2012 employees2012 fin_cons2012 fn_exp2012 inv2012 WE2012 interest_DIFF2012 NEG_VA2012 ICR_failure2012 real_SA2012 rvn2012, absorb(NUTS3 NAICS3digits) vce(robust)

reghdfe dummy_2015_2013 NEG_VA2012 ICR_failure2012 real_SA2012 solvency2012 fin_cons2012 fn_rvn2012 rvn2012,absorb(NUTS3 NAICS3digits) vce(cluster NUTS3 NAICS3digits)
reghdfe dummy_2015_2013 NEG_VA2012 ICR_failure2012 real_SA2012 solvency2012 fin_cons2012 fn_rvn2012 rvn2012,absorb(NUTS3 NAICS3digits) vce(robust)
*LOGISTIC REGRESSION & MULTINOMIAL LOGIT
logit dummy_2015_2013 i.NAICS3digits fn_rvn2012 solvency2012 employees2012 fin_cons2012 fn_exp2012 inv2012 WE2012 interest_DIFF2012 NEG_VA2012 ICR_failure2012 real_SA2012 rvn2012 i.zone, cluster(NUTS3) robust
encode zombie_2015_2013, gen(Zombie_2014_2012)
mlogit Zombie_2015_2013i.NAICS3digits fn_rvn2012 solvency2012 employees2012 fin_cons2012 fn_exp2012 inv2012 WE2012 interest_DIFF2012 NEG_VA2012 ICR_failure2012 real_SA2012 rvn2012 i.zone, rrr cluster(NUTS3) robust


*Zombies 2012/2014
*LASSO REGRESSION
lars dummy_2014_2012 NAICS3digits  fn_rvn2011 solvency2011 employees2011 fin_cons2011 fn_exp2011 inv2011 WE2011 interest_DIFF2011 NEG_VA2011 ICR_failure2011 zone  real_SA2011 rvn2011 , a(lasso) cluster(NAICS3digits NUTS3) vce(robust)

*FE LINEAR PROBABILITY MODEL
reghdfe dummy_2014_2012 fn_rvn2011 solvency2011 employees2011 fin_cons2011 fn_exp2011 inv2011 WE2011 interest_DIFF2011 NEG_VA2011 ICR_failure2011 real_SA2011 rvn2011, absorb(NUTS3 NAICS3digits) vce(cluster NUTS3 NAICS3digits)
reghdfe dummy_2014_2012 fn_rvn2011 solvency2011 employees2011 fin_cons2011 fn_exp2011 inv2011 WE2011 interest_DIFF2011 NEG_VA2011 ICR_failure2011 real_SA2011 rvn2011, absorb(NUTS3 NAICS3digits) vce(robust)

reghdfe dummy_2014_2012 ICR_failure2011 NEG_VA2011 real_SA2011 fin_cons2011 solvency2011 fn_rvn2011 fn_exp2011 rvn2011,absorb(NUTS3 NAICS3digits) vce(cluster NUTS3 NAICS3digits)
reghdfe dummy_2014_2012 ICR_failure2011 NEG_VA2011 real_SA2011 fin_cons2011 solvency2011 fn_rvn2011 fn_exp2011 rvn2011,absorb(NUTS3 NAICS3digits) vce(robust)
*LOGISTIC REGRESSION & MULTINOMIAL LOGIT
logit dummy_2014_2012 i.NAICS3digits fn_rvn2011 solvency2011 employees2011 fin_cons2011 fn_exp2011 inv2011 WE2011 interest_DIFF2011 NEG_VA2011 ICR_failure2011 real_SA2011 rvn2011 i.zone, cluster(NUTS3) robust
encode zombie_2014_2012, gen(Zombie_2014_2011)
mlogit Zombie_2014_2012 i.NAICS3digits fn_rvn2011 solvency2011 employees2011 fin_cons2011 fn_exp2011 inv2011 WE2011 interest_DIFF2011 NEG_VA2011 ICR_failure2011 real_SA2011 rvn2011 i.zone, rrr cluster(NUTS3) robust


*Zombies 2011/2013
*LASSO REGRESSION
lars dummy_2013_2011 NAICS3digits  fn_rvn2010 solvency2010 employees2010 fin_cons2010 fn_exp2010 inv2010 WE2010 interest_DIFF2010 NEG_VA2010 ICR_failure2010 zone  real_SA2010 rvn2010 , a(lasso) cluster(NAICS3digits NUTS3) vce(robust)

*FE LINEAR PROBABILITY MODEL
reghdfe dummy_2013_2011 fn_rvn2010 solvency2010 employees2010 fin_cons2010 fn_exp2010 inv2010 WE2010 interest_DIFF2010 NEG_VA2010 ICR_failure2010 real_SA2010 rvn2010, absorb(NUTS3 NAICS3digits) vce(cluster NUTS3 NAICS3digits)
reghdfe dummy_2013_2011 fn_rvn2010 solvency2010 employees2010 fin_cons2010 fn_exp2010 inv2010 WE2010 interest_DIFF2010 NEG_VA2010 ICR_failure2010 real_SA2010 rvn2010, absorb(NUTS3 NAICS3digits) vce(robust)

reghdfe dummy_2013_2011 solvency2010  fin_cons2010 fn_exp2010 interest_DIFF2010 NEG_VA2010 ICR_failure2010 real_SA2010,absorb(NUTS3 NAICS3digits) vce(cluster NUTS3 NAICS3digits)
reghdfe dummy_2013_2011 solvency2010  fin_cons2010 fn_exp2010 interest_DIFF2010 NEG_VA2010 ICR_failure2010 real_SA2010,absorb(NUTS3 NAICS3digits) vce(robust)
*LOGISTIC REGRESSION & MULTINOMIAL LOGIT
logit dummy_2013_2011 i.NAICS3digits fn_rvn2010 solvency2010 employees2010 fin_cons2010 fn_exp2010 inv2010 WE2010 interest_DIFF2010 NEG_VA2010 ICR_failure2010 real_SA2010 rvn2010 i.zone, cluster(NUTS3) robust
encode zombie_2013_2011, gen(Zombie_2013_2011)
mlogit Zombie_2013_2011 i.NAICS3digits fn_rvn2010 solvency2010 employees2010 fin_cons2010 fn_exp2010 inv2010 WE2010 interest_DIFF2010 NEG_VA2010 ICR_failure2010 real_SA2010 rvn2010 i.zone, rrr cluster(NUTS3) robust

*Zombies 2010/2012
*LASSO REGRESSION
lars dummy_2012_2010 NAICS3digits  fn_rvn2009 solvency2009 employees2009 fin_cons2009 fn_exp2009 inv2009 WE2009 interest_DIFF2009 NEG_VA2009 ICR_failure2009 zone  real_SA2009 rvn2009 , a(lasso) cluster(NAICS3digits NUTS3) vce(robust)

*FE LINEAR PROBABILITY MODEL
reghdfe dummy_2012_2010 fn_rvn2009 solvency2009 employees2009 fin_cons2009 fn_exp2009 inv2009 WE2009 interest_DIFF2009 NEG_VA2009 ICR_failure2009 real_SA2009 rvn2009, absorb(NUTS3 NAICS3digits) vce(cluster NUTS3 NAICS3digits)
reghdfe dummy_2012_2010 fn_rvn2009 solvency2009 employees2009 fin_cons2009 fn_exp2009 inv2009 WE2009 interest_DIFF2009 NEG_VA2009 ICR_failure2009 real_SA2009 rvn2009, absorb(NUTS3 NAICS3digits) vce(robust)

reghdfe dummy_2012_2010 NEG_VA2009 ICR_failure2009 real_SA2009 solvency2009 fin_cons2009 rvn2009 interest_DIFF2009 inv2009,absorb(NUTS3 NAICS3digits) vce(cluster NUTS3 NAICS3digits)
reghdfe dummy_2012_2010 NEG_VA2009 ICR_failure2009 real_SA2009 solvency2009 fin_cons2009 rvn2009 interest_DIFF2009 inv2009,absorb(NUTS3 NAICS3digits) vce(robust)
*LOGISTIC REGRESSION & MULTINOMIAL LOGIT
logit dummy_2012_2010 i.NAICS3digits fn_rvn2009 solvency2009 employees2009 fin_cons2009 fn_exp2009 inv2009 WE2009 interest_DIFF2009 NEG_VA2009 ICR_failure2009 real_SA2009 rvn2009 i.zone, cluster(NUTS3) robust
encode zombie_2012_2010, gen(Zombie_2014_2009)
mlogit Zombie_2012_2010 i.NAICS3digits fn_rvn2009 solvency2009 employees2009 fin_cons2009 fn_exp2009 inv2009 WE2009 interest_DIFF2009 NEG_VA2009 ICR_failure2009 real_SA2009 rvn2009 i.zone, rrr cluster(NUTS3) robust

*Zombies 2009/2011

*LASSO REGRESSION
lars dummy_2011_2009 NAICS3digits  fn_rvn2008 solvency2008 employees2008 fin_cons2008 fn_exp2008 inv2008 WE2008 NEG_VA2008 ICR_failure2008 zone  real_SA2008 rvn2008 , a(lasso) cluster(NAICS3digits NUTS3) vce(robust)

*FE LINEAR PROBABILITY MODEL
reghdfe dummy_2011_2009 fn_rvn2008 solvency2008 employees2008 fin_cons2008 fn_exp2008 inv2008 WE2008  NEG_VA2008 ICR_failure2008 real_SA2008 rvn2008, absorb(NUTS3 NAICS3digits) vce(cluster NUTS3 NAICS3digits)
reghdfe dummy_2011_2009 fn_rvn2008 solvency2008 employees2008 fin_cons2008 fn_exp2008 inv2008 WE2008  NEG_VA2008 ICR_failure2008 real_SA2008 rvn2008, absorb(NUTS3 NAICS3digits) vce(robust)

reghdfe dummy_2011_2009 ICR_failure2008 NEG_VA2008 real_SA2008 solvency2008 fin_cons2008 inv2008 WE2008 rvn2008 employees2008,absorb(NUTS3 NAICS3digits) vce(cluster NUTS3 NAICS3digits)
reghdfe dummy_2011_2009 ICR_failure2008 NEG_VA2008 real_SA2008 solvency2008 fin_cons2008 inv2008 WE2008 rvn2008 employees2008,absorb(NUTS3 NAICS3digits) vce(robust)
*LOGISTIC REGRESSION & MULTINOMIAL LOGIT
logit dummy_2011_2009 i.NAICS3digits fn_rvn2008 solvency2008 employees2008 fin_cons2008 fn_exp2008 inv2008 WE2008 NEG_VA2008 ICR_failure2008 real_SA2008 rvn2008 i.zone, cluster(NUTS3) robust
encode zombie_2011_2009, gen(Zombie_2014_2008)
mlogit Zombie_2011_2009 i.NAICS3digits fn_rvn2008 solvency2008 employees2008 fin_cons2008 fn_exp2008 inv2008 WE2008  NEG_VA2008 ICR_failure2008 real_SA2008 rvn2008 i.zone, rrr cluster(NUTS3) robust


