
***********************************************************************
*                   DATA PREPARATION                            * 
************************************************************************

*This Project was done in STATA 13.0/ MP*

*Cleaning up past records* 
clear all 

*converting totformalborrow_24, totinformalborrow_24 and hhinc from string type to numeric type* 

destring hhinc totinformalborrow_24 totformalborrow_24, generate(num_hhinc num_totinformalborrow num_totformalborrow) force

* Then we replace "None" options in new variables num_ hhinc, num_totalformalborrow and num_totalinformalborrow with 0*
 sort num_hhinc            
 *arranging data in ascending order, "NONE" opions begins at 3913*
 replace num_hhinc = 0 if _n>= 3913  
 
 * We do same with num_totalformalborrow and num_totalinformalborrow
 sort num_totinformalborrow
 replace num_totinformalborrow = 0 if _n>= 2618
 
 sort num_totformalborrow
 replace num_totformalborrow = 0 if _n >= 2940
 
 *dropping string variables totformalborrow_24, totinformalborrow_24 and hhinc*
 
 drop hhinc totinformalborrow_24 totformalborrow_24
 
 * Analyzing Data*
 
graph bar (mean) num_hhinc (mean) num_totformalborrow (mean) num_totinformalborrow, over(survey_round) bar(1, fcolor(cranberry) 
fintensity(inten80) lcolor(black) lwidth(medthick)) bar(2, fcolor(yellow) fintensity(inten70) lcolor(black) lwidth(medthick)) ytitle(Avg amount of money)
 
 
 *Top Coding num_ hhinc, num_totalformalborrow and num_totalinformalborrow*
 
 summarize num_hhinc num_totinformalborrow num_totformalborrow
 
 *Using Hand Calculator to create reach the value which is 3 std deviations above mean for each of the variables starting num_hhinc*
 
 display 11798.03 + 3* 67428.83
                            // 11798.03 is men and 67428.83 is std dev//

replace num_hhinc = 214084.52 if num_hhinc >= 214084.52

*for num_totalinformalborrow*

display 40881.72 + 3*84778.38

replace num_totinformalborrow = 295216.86 if  num_totinformalborrow >= 295216.86 // 40881.72 is mean and 84778.38 is std deviation

*for num_totalformalborrow

display 64382.05 + 3*127493                   			// 64382.05 is mean and 127493 is std dev //

replace num_totformalborrow = 446861.05 if num_totformalborrow>= 446861.05 



* Creating a variable called num_totalborrowed*
sort hhid
gen num_totalborrowed = num_totinformalborrow + num_totformalborrow

*Merging the Endline File with Treatment File* 

merge m:1 group_id using "C:\Users\Shaurya\Downloads\Stata_Test_2020 (2)\treatment.dta"

*Creating A Poverty Line Dummy named bpline

gen bpline = 26.995
gen hhinc_percapita = num_hhinc/ hhnomembers
replace bpline = 1 if hhinc_percapita <= bpline
replace bpline = 0 if hhinc_percapita > bpline


*Merge 
merge m:1 group_id using "C:\Users\Shaurya\Downloads\Stata_Test_2020 (2)\baseline_controls.dta"

compress 

save 









 
 
 

 




