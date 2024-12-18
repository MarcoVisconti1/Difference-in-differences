clear all
set more off

import excel "C:\Users\Utente\Desktop\New folder\Overall Wages.xlsx", firstrow

browse
codebook region

*region==1 for mazo
encode region,gen(region1)
recode region1 (1=0)(2=1),gen(region2)

*After = 1 for periods after treatment occurs in Febraury 2022
gen After=0
replace After=1 if timeperiod>=39 

gen DiD = After*region2

didregress (wages) (DiD), group(region2) time(timeperiod) vce(r) aequations

estat ptrends
estat trendplots
