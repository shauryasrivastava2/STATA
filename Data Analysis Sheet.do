********************************************************************
* DATA ANALYSIS * 

********************************************************************


* Null Hypothesis  : There is no difference in Household Income, Formal Borrowing, Informal Borrowing, Total Borrowing between Treatment Group and Control Group at baseline indicators
*Conducting ttests on age_hoh, gender_hoh, readwrite_hoh, higheduc_hoh, hhreg_muslim, hhreg_christian ,hhcaste_fc hhcaste_bc ,hhcaste_mbc .hhcaste_sc_st



*****Conducting Ttests on Baseline indicators******
ttest age_hoh, by (treated)


destring gender_hoh, generate (binary_gender) force
replace binary_gender = 1 if gender_hoh == "Male (1)"
replace binary_gender = 0 if gender_hoh == "Female (0)"
ttest binary_gender, by(treated)

ttest readwrite_hoh, by (treated)

ttest higheduc_hoh, by (treated)

*Looking at Composition of the population*
ttest  hhreg_muslim, by (treated)
ttest hhreg_christian, by(treated)
ttest hhcaste_fc, by(treated)
ttest hhcaste_bc, by(treated)
ttest hhcaste_mbc, by(treated)
ttest hhcaste_sc_st, by (treated)

**Results show that for some variables namely, higheduc_hoh,  hhreg_muslim, hhreg_christian,  ttest hhcaste_bc, hhcaste_mbc  
*Ttest Tables are in Ttest.txt

***Regress (with OLS) the household income on the treatment dummy and including pair fixed effects
reg num_hhinc treated i.pair_id

***Generating variable that contain log values of household income 

gen log_hhinc = log( num_hhinc )

*Regress (with OLS) the logarthmic household income on the treatment dummy and including pair fixed effects
reg log_hhinc treated i.pair_id

*The new regression shows a slightly higher value of R-squre at  0.0504 as compared to 0.0356 in prior case

*Re-running the previous regression including binary_gender readwrite_hoh hhinc_percapita hhnomembers  hhcaste_fc hhreg_muslim hhreg_christian hhcaste_sc_st hhcaste_mbc higheduc_hoh*

reg log_hhinc treated binary_gender readwrite_hoh hhinc_percapita hhnomembers hhcaste_fc hhreg_muslim hhreg_christian hhcaste_sc_st hhcaste_mbc higheduc_hoh

*Copy Pasted the regression results table on Regression-Results Excel Sheet.
 
 *generating a variable to that assigns each household to quartiles
 
  xtile num_hhinc_quartiles = num_hhinc, nq(4)
  
  * looking at mean of the variables
  
  tabstat num_hhinc, stat(n mean) by( num_hhinc_quartiles )
 
 graph bar (mean) num_hhinc if treated == 1, over(num_hhinc_quartiles) bar(1, fcolor(cranberry) fintensity(inten80) lcolor(black) lwidth(medthick)) ytitle(Mean of Each Income Quartile for Treatment Group)

 

*Saved as PNG File For Publication


***************************************************************************************************************
							* END *
*************************************************************************************************************** 
 
 
 







