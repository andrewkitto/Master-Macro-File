

DM 'CLEAR LOG' continue;
DM 'CLEAR OUTPUT' continue;

/****************************************************************************************************************************/
/*  NOTE: This file contains all of my frequently used macros.  Most of these Macros are written by other authors.			*/
/*  I have done my best to provide links to source material.																*/
/*  Please aknowledge these authors if you use this code.																	*/
/*  Last modified:  April 2017																								*/
/****************************************************************************************************************************/


/****************************************************************************************************************************

List of macros contained in this file:

	FF48
		- Author: Ed DeHan
		- http://faculty.washington.edu/edehaan/pages/Programming/industries_ff48

	FF12
		- Author: Ed DeHan
		- http://faculty.washington.edu/edehaan/pages/Programming/industries_ff12

	Runquit
		- Author: Joost Impink

	ARRAY
	DO_OVER
	NUMLIST
		-Copyright Ted Clay, David Katz (see below)

	RM (remove datasets)

	Winsor
		- Author: Joost Impink
		- http://www.wrds.us/index.php/repository/view/1

	Lag/Lead macros:
		- Original Author: Richard Price
		- Modified by Andrew Kitto to create lead/lag variables in Audit Analytics (unique identifier = company_fkey)

		1)lag3_yr_gvkey
			- Unique Identifier = gvkey (for Compustat)
			- Original code from Richard Price
		2)lag3_yr_company_fkey
			- Unique Identifier = company_fkey (for audit analytics)
			- Modified by Andrew Kitto
	
*****************************************************************************************************************************/


/* FF48 Macro */

*option errorabend;
*option merror mlogic mprint symbolgen;
*option nonotes nosource nosource2;
*option notes source source2;
*option logic print symbolgen;

/********************************************************************************
	Author: 	Ed deHaan, derived from work of unknown authors
	
	Macro: 		ind_ff48
	
	Purpose: 	to assign Fama French industry codes

	Versions:	1.0 - 	7/21/10	  - original version	
				1.1	-	11/19/10  - redid all codes based on updated FF classification
				
	
	Notes:		48 Industry classification codes obtained from French's website in Nov. 2010
				http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/data_library.html


--------------------------------------------

Generates Fama-French industry codes based on four-digit SIC codes.  


Outputs the original dataset with appended industry code information:

	'&ind_code' 	= count variable of industry codes from 1 through 48
	'FF_IND'		= text variable with name of the fama-french industry
	'&bin_var.#'	= 48 individual binary variables, one for each industry
	'_&global'		= global macro variable to include call 48 industry dummies

--------------------------------------------


	Required INPUT parameters:
		dset			-	input dataset name
		sic				-	four-digit sic code variable name
		outp			-	output dataset
		bin_var			-	prefix for industry binary variables
		ind_code		-	name of count variable for industry codes 1 through 48
		global			-	name of global macro variable to call all 48 industry dummies
	
	Optional INPUT parameters


	


********************************************************************************/


%let _industry_fe= 	i1 i2 i3 i4 i5 i6 i7 i8 i9
					i10 i11 i12 i13 i14 i15 i16 i17 i18 i19
					i20 i21 i22 i23 i24 i25 i26 i27 i28 i29
					i30 i31 i32 i33 i34 i35 i36 i37 i38 i39
					i40 i41 i42 i43 i44 i45 i46 i47 i48;

%macro ind_ff48 (dset, outp, sic, bin_var, ind_code );

********** FF Ind Codes Macro **********;



data &outp;
        set &dset;

        indus2=int(&sic/100);
        indus3=int(&sic/10);

* 1 Agric  Agriculture;
          if &sic ge 0100 and &sic le 0199  then FF_IND='AGRIC';
          if &sic ge 0200 and &sic le 0299  then FF_IND='AGRIC';
          if &sic ge 0700 and &sic le 0799  then FF_IND='AGRIC';
          if &sic ge 0910 and &sic le 0919  then FF_IND='AGRIC';
          if &sic ge 2048 and &sic le 2048  then FF_IND='AGRIC';
	if FF_IND='AGRIC' then &ind_code=1;

* 2 Food   Food Products;
          if &sic ge 2000 and &sic le 2009  then FF_IND='FOOD';
          if &sic ge 2010 and &sic le 2019  then FF_IND='FOOD';
          if &sic ge 2020 and &sic le 2029  then FF_IND='FOOD';
          if &sic ge 2030 and &sic le 2039  then FF_IND='FOOD';
          if &sic ge 2040 and &sic le 2046  then FF_IND='FOOD';
          if &sic ge 2050 and &sic le 2059  then FF_IND='FOOD';
          if &sic ge 2060 and &sic le 2063  then FF_IND='FOOD';
          if &sic ge 2070 and &sic le 2079  then FF_IND='FOOD';
          if &sic ge 2090 and &sic le 2092  then FF_IND='FOOD';
          if &sic ge 2095 and &sic le 2095  then FF_IND='FOOD';
          if &sic ge 2098 and &sic le 2099  then FF_IND='FOOD';
	if FF_IND='FOOD' then &ind_code=2;

* 3 Soda   Candy & Soda;
          if &sic ge 2064 and &sic le 2068  then FF_IND='SODA';
          if &sic ge 2086 and &sic le 2086  then FF_IND='SODA';
          if &sic ge 2087 and &sic le 2087  then FF_IND='SODA';
          if &sic ge 2096 and &sic le 2096  then FF_IND='SODA';
          if &sic ge 2097 and &sic le 2097  then FF_IND='SODA';
	if FF_IND='SODA' then &ind_code=3;

* 4 Beer   Beer & Liquor;
          if &sic ge 2080 and &sic le 2080  then FF_IND='BEER';
          if &sic ge 2082 and &sic le 2082  then FF_IND='BEER';
          if &sic ge 2083 and &sic le 2083  then FF_IND='BEER';
          if &sic ge 2084 and &sic le 2084  then FF_IND='BEER';
          if &sic ge 2085 and &sic le 2085  then FF_IND='BEER'; 
	if FF_IND='BEER' then &ind_code=4;

* 5 Smoke  Tobacco Products;
          if &sic ge 2100 and &sic le 2199  then FF_IND='SMOKE'; 
	if FF_IND='SMOKE' then &ind_code=5;

* 6 Toys   Recreation;
          if &sic ge 0920 and &sic le 0999  then FF_IND='TOYS'; 
          if &sic ge 3650 and &sic le 3651  then FF_IND='TOYS'; 
          if &sic ge 3652 and &sic le 3652  then FF_IND='TOYS';
          if &sic ge 3732 and &sic le 3732   then FF_IND='TOYS';
          if &sic ge 3930 and &sic le 3931   then FF_IND='TOYS';
          if &sic ge 3940 and &sic le 3949   then FF_IND='TOYS';
	if FF_IND='TOYS' then &ind_code=6;

* 7 Fun    Entertainment;
          if &sic ge 7800 and &sic le 7829   then FF_IND='FUN';
          if &sic ge  7830 and &sic le 7833   then FF_IND='FUN';
          if &sic ge 7840 and &sic le 7841   then FF_IND='FUN';
          if &sic ge 7900 and &sic le 7900   then FF_IND='FUN';
          if &sic ge 7910 and &sic le 7911   then FF_IND='FUN';
          if &sic ge 7920 and &sic le 7929   then FF_IND='FUN';
          if &sic ge 7930 and &sic le 7933   then FF_IND='FUN';
          if &sic ge 7940 and &sic le 7949   then FF_IND='FUN';
          if &sic ge 7980 and &sic le 7980   then FF_IND='FUN';
          if &sic ge 7990 and &sic le 7999   then FF_IND='FUN';
	if FF_IND='FUN' then &ind_code=7;

* 8 Books  Printing and Publishing;
          if &sic ge 2700 and &sic le 2709   then FF_IND='BOOKS';
          if &sic ge 2710 and &sic le 2719   then FF_IND='BOOKS';
          if &sic ge 2720 and &sic le 2729   then FF_IND='BOOKS';
          if &sic ge 2730 and &sic le 2739   then FF_IND='BOOKS';
          if &sic ge 2740 and &sic le 2749   then FF_IND='BOOKS';
          if &sic ge 2770 and &sic le 2771   then FF_IND='BOOKS';
          if &sic ge 2780 and &sic le 2789   then FF_IND='BOOKS';
          if &sic ge 2790 and &sic le 2799   then FF_IND='BOOKS';
	if FF_IND='BOOKS' then &ind_code=8;

* 9 Hshld  Consumer Goods;
          if &sic ge 2047 and &sic le 2047   then FF_IND='HSHLD';
          if &sic ge 2391 and &sic le 2392   then FF_IND='HSHLD';
          if &sic ge 2510 and &sic le 2519   then FF_IND='HSHLD';
          if &sic ge 2590 and &sic le 2599   then FF_IND='HSHLD';
          if &sic ge 2840 and &sic le 2843   then FF_IND='HSHLD';
          if &sic ge 2844 and &sic le 2844   then FF_IND='HSHLD';
          if &sic ge 3160 and &sic le 3161   then FF_IND='HSHLD';
          if &sic ge 3170 and &sic le 3171   then FF_IND='HSHLD';
          if &sic ge 3172 and &sic le 3172   then FF_IND='HSHLD';
          if &sic ge 3190 and &sic le 3199   then FF_IND='HSHLD';
          if &sic ge 3229 and &sic le 3229   then FF_IND='HSHLD';
          if &sic ge 3260 and &sic le 3260   then FF_IND='HSHLD';
          if &sic ge 3262 and &sic le 3263   then FF_IND='HSHLD';
          if &sic ge 3269 and &sic le 3269   then FF_IND='HSHLD';
          if &sic ge 3230 and &sic le 3231   then FF_IND='HSHLD';
          if &sic ge 3630 and &sic le 3639   then FF_IND='HSHLD';
          if &sic ge 3750 and &sic le 3751   then FF_IND='HSHLD';
          if &sic ge 3800 and &sic le 3800   then FF_IND='HSHLD';
          if &sic ge 3860 and &sic le 3861   then FF_IND='HSHLD';
          if &sic ge 3870 and &sic le 3873   then FF_IND='HSHLD';
          if &sic ge 3910 and &sic le 3911   then FF_IND='HSHLD';
          if &sic ge 3914 and &sic le 3914   then FF_IND='HSHLD';
          if &sic ge 3915 and &sic le 3915   then FF_IND='HSHLD';
          if &sic ge 3960 and &sic le 3962   then FF_IND='HSHLD';
          if &sic ge 3991 and &sic le 3991   then FF_IND='HSHLD';
          if &sic ge 3995 and &sic le 3995   then FF_IND='HSHLD';
	if FF_IND='HSHLD' then &ind_code=9;

*10 Clths  Apparel;
          if &sic ge 2300 and &sic le 2390   then FF_IND='CLTHS';
          if &sic ge 3020 and &sic le 3021   then FF_IND='CLTHS';
          if &sic ge 3100 and &sic le 3111   then FF_IND='CLTHS';
          if &sic ge 3130 and &sic le 3131   then FF_IND='CLTHS';
          if &sic ge 3140 and &sic le 3149   then FF_IND='CLTHS';
          if &sic ge 3150 and &sic le 3151   then FF_IND='CLTHS';
          if &sic ge 3963 and &sic le 3965   then FF_IND='CLTHS';
	if FF_IND='CLTHS' then &ind_code=10;

*11 Hlth   Healthcare;
          if &sic ge 8000 and &sic le 8099   then FF_IND='HLTH';
	if FF_IND='HLTH' then &ind_code=11;

*12 MedEq  Medical Equipment;
          if &sic ge 3693 and &sic le 3693   then FF_IND='MEDEQ';
          if &sic ge 3840 and &sic le 3849   then FF_IND='MEDEQ';
          if &sic ge 3850 and &sic le 3851   then FF_IND='MEDEQ';
	if FF_IND='MEDEQ' then &ind_code=12;

*13 Drugs  Pharmaceutical Products;
          if &sic ge 2830 and &sic le 2830   then FF_IND='DRUGS';
          if &sic ge 2831 and &sic le 2831   then FF_IND='DRUGS';
          if &sic ge 2833 and &sic le 2833   then FF_IND='DRUGS';
          if &sic ge 2834 and &sic le 2834   then FF_IND='DRUGS';
          if &sic ge 2835 and &sic le 2835   then FF_IND='DRUGS';
          if &sic ge 2836 and &sic le 2836   then FF_IND='DRUGS';
	if FF_IND='DRUGS' then &ind_code=13;

*14 Chems  Chemicals;
          if &sic ge 2800 and &sic le 2809   then FF_IND='CHEM';
          if &sic ge 2810 and &sic le 2819   then FF_IND='CHEM';
          if &sic ge 2820 and &sic le 2829   then FF_IND='CHEM';
          if &sic ge 2850 and &sic le 2859   then FF_IND='CHEM';
          if &sic ge 2860 and &sic le 2869   then FF_IND='CHEM';
          if &sic ge 2870 and &sic le 2879   then FF_IND='CHEM';
          if &sic ge 2890 and &sic le 2899   then FF_IND='CHEM';
	if FF_IND='CHEM' then &ind_code=14;

*15 Rubbr  Rubber and Plastic Products;
          if &sic ge 3031 and &sic le 3031   then FF_IND='RUBBR';
          if &sic ge 3041 and &sic le 3041   then FF_IND='RUBBR';
          if &sic ge 3050 and &sic le 3053   then FF_IND='RUBBR';
          if &sic ge 3060 and &sic le 3069   then FF_IND='RUBBR';
          if &sic ge 3070 and &sic le 3079   then FF_IND='RUBBR';
          if &sic ge 3080 and &sic le 3089   then FF_IND='RUBBR';
          if &sic ge 3090 and &sic le 3099   then FF_IND='RUBBR';
	if FF_IND='RUBBR' then &ind_code=15;

*16 Txtls  Textiles;
          if &sic ge 2200 and &sic le 2269   then FF_IND='TXTLS';
          if &sic ge 2270 and &sic le 2279   then FF_IND='TXTLS';
          if &sic ge 2280 and &sic le 2284   then FF_IND='TXTLS';
          if &sic ge 2290 and &sic le 2295   then FF_IND='TXTLS';
          if &sic ge 2297 and &sic le 2297   then FF_IND='TXTLS';
          if &sic ge 2298 and &sic le 2298   then FF_IND='TXTLS';
          if &sic ge 2299 and &sic le 2299   then FF_IND='TXTLS';
          if &sic ge 2393 and &sic le 2395   then FF_IND='TXTLS';
          if &sic ge 2397 and &sic le 2399   then FF_IND='TXTLS';
	if FF_IND='TXTLS' then &ind_code=16;

*17 BldMt  Construction Materials;
          if &sic ge 0800 and &sic le 0899   then FF_IND='BLDMT';
          if &sic ge 2400 and &sic le 2439   then FF_IND='BLDMT';
          if &sic ge 2450 and &sic le 2459   then FF_IND='BLDMT';
          if &sic ge 2490 and &sic le 2499   then FF_IND='BLDMT';
          if &sic ge 2660 and &sic le 2661   then FF_IND='BLDMT';
          if &sic ge 2950 and &sic le 2952   then FF_IND='BLDMT';
          if &sic ge 3200 and &sic le 3200   then FF_IND='BLDMT';
          if &sic ge 3210 and &sic le 3211   then FF_IND='BLDMT';
          if &sic ge 3240 and &sic le 3241   then FF_IND='BLDMT';
          if &sic ge 3250 and &sic le 3259   then FF_IND='BLDMT';
          if &sic ge 3261 and &sic le 3261   then FF_IND='BLDMT';
          if &sic ge 3264 and &sic le 3264   then FF_IND='BLDMT';
          if &sic ge 3270 and &sic le 3275   then FF_IND='BLDMT';
          if &sic ge 3280 and &sic le 3281   then FF_IND='BLDMT';
          if &sic ge 3290 and &sic le 3293   then FF_IND='BLDMT';
          if &sic ge 3295 and &sic le 3299   then FF_IND='BLDMT';
          if &sic ge 3420 and &sic le 3429   then FF_IND='BLDMT';
          if &sic ge 3430 and &sic le 3433   then FF_IND='BLDMT';
          if &sic ge 3440 and &sic le 3441   then FF_IND='BLDMT';
          if &sic ge 3442 and &sic le 3442   then FF_IND='BLDMT';
          if &sic ge 3446 and &sic le 3446   then FF_IND='BLDMT';
          if &sic ge 3448 and &sic le 3448   then FF_IND='BLDMT';
          if &sic ge 3449 and &sic le 3449   then FF_IND='BLDMT';
          if &sic ge 3450 and &sic le 3451   then FF_IND='BLDMT';
          if &sic ge 3452 and &sic le 3452   then FF_IND='BLDMT';
          if &sic ge 3490 and &sic le 3499   then FF_IND='BLDMT';
          if &sic ge 3996 and &sic le 3996   then FF_IND='BLDMT';
	if FF_IND='BLDMT' then &ind_code=17;

*18 Cnstr  Construction;
          if &sic ge 1500 and &sic le 1511   then FF_IND='CNSTR';
          if &sic ge 1520 and &sic le 1529   then FF_IND='CNSTR';
          if &sic ge 1530 and &sic le 1539   then FF_IND='CNSTR';
          if &sic ge 1540 and &sic le 1549   then FF_IND='CNSTR';
          if &sic ge 1600 and &sic le 1699   then FF_IND='CNSTR';
          if &sic ge 1700 and &sic le 1799   then FF_IND='CNSTR';
	if FF_IND='CNSTR' then &ind_code=18;

*19 Steel  Steel Works Etc;
          if &sic ge 3300 and &sic le 3300   then FF_IND='STEEL';
          if &sic ge 3310 and &sic le 3317   then FF_IND='STEEL';
          if &sic ge 3320 and &sic le 3325   then FF_IND='STEEL';
          if &sic ge 3330 and &sic le 3339   then FF_IND='STEEL';
          if &sic ge 3340 and &sic le 3341   then FF_IND='STEEL';
          if &sic ge 3350 and &sic le 3357   then FF_IND='STEEL';
          if &sic ge 3360 and &sic le 3369   then FF_IND='STEEL';
          if &sic ge 3370 and &sic le 3379   then FF_IND='STEEL';
          if &sic ge 3390 and &sic le 3399   then FF_IND='STEEL';
	if FF_IND='STEEL' then &ind_code=19;

*20 FabPr  Fabricated Products;
          if &sic ge 3400 and &sic le 3400   then FF_IND='FABPR';
          if &sic ge 3443 and &sic le 3443   then FF_IND='FABPR';
          if &sic ge 3444 and &sic le 3444   then FF_IND='FABPR';
          if &sic ge 3460 and &sic le 3469   then FF_IND='FABPR';
          if &sic ge 3470 and &sic le 3479   then FF_IND='FABPR';
	if FF_IND='FABPR' then &ind_code=20;

*21 Mach   Machinery;
          if &sic ge 3510 and &sic le 3519   then FF_IND='MACH';
          if &sic ge 3520 and &sic le 3529   then FF_IND='MACH';
          if &sic ge 3530 and &sic le 3530   then FF_IND='MACH';
          if &sic ge 3531 and &sic le 3531   then FF_IND='MACH';
          if &sic ge 3532 and &sic le 3532   then FF_IND='MACH';
          if &sic ge 3533 and &sic le 3533   then FF_IND='MACH';
          if &sic ge 3534 and &sic le 3534   then FF_IND='MACH';
          if &sic ge 3535 and &sic le 3535   then FF_IND='MACH';
          if &sic ge 3536 and &sic le 3536   then FF_IND='MACH';
          if &sic ge 3538 and &sic le 3538   then FF_IND='MACH';
          if &sic ge 3540 and &sic le 3549   then FF_IND='MACH';
          if &sic ge 3550 and &sic le 3559   then FF_IND='MACH';
          if &sic ge 3560 and &sic le 3569   then FF_IND='MACH';
          if &sic ge 3580 and &sic le 3580   then FF_IND='MACH';
          if &sic ge 3581 and &sic le 3581   then FF_IND='MACH';
          if &sic ge 3582 and &sic le 3582   then FF_IND='MACH';
          if &sic ge 3585 and &sic le 3585   then FF_IND='MACH';
          if &sic ge 3586 and &sic le 3586   then FF_IND='MACH';
          if &sic ge 3589 and &sic le 3589   then FF_IND='MACH';
          if &sic ge 3590 and &sic le 3599   then FF_IND='MACH';
	if FF_IND='MACH' then &ind_code=21;

*22 ElcEq  Electrical Equipment;
          if &sic ge 3600 and &sic le 3600   then FF_IND='ELCEQ';
          if &sic ge 3610 and &sic le 3613   then FF_IND='ELCEQ';
          if &sic ge 3620 and &sic le 3621   then FF_IND='ELCEQ';
          if &sic ge 3623 and &sic le 3629   then FF_IND='ELCEQ';
          if &sic ge 3640 and &sic le 3644   then FF_IND='ELCEQ';
          if &sic ge 3645 and &sic le 3645   then FF_IND='ELCEQ'; 
          if &sic ge 3646 and &sic le 3646   then FF_IND='ELCEQ';
          if &sic ge 3648 and &sic le 3649   then FF_IND='ELCEQ';
          if &sic ge 3660 and &sic le 3660   then FF_IND='ELCEQ';
          if &sic ge 3690 and &sic le 3690   then FF_IND='ELCEQ';
          if &sic ge 3691 and &sic le 3692   then FF_IND='ELCEQ';
          if &sic ge 3699 and &sic le 3699   then FF_IND='ELCEQ';
	if FF_IND='ELCEQ' then &ind_code=22;

*23 Autos  Automobiles and Trucks;
          if &sic ge 2296 and &sic le 2296   then FF_IND='AUTOS';
          if &sic ge 2396 and &sic le 2396   then FF_IND='AUTOS';
          if &sic ge 3010 and &sic le 3011   then FF_IND='AUTOS';
          if &sic ge 3537 and &sic le 3537   then FF_IND='AUTOS';
          if &sic ge 3647 and &sic le 3647   then FF_IND='AUTOS';
          if &sic ge 3694 and &sic le 3694   then FF_IND='AUTOS';
          if &sic ge 3700 and &sic le 3700   then FF_IND='AUTOS';
          if &sic ge 3710 and &sic le 3710   then FF_IND='AUTOS';
          if &sic ge 3711 and &sic le 3711   then FF_IND='AUTOS';
          if &sic ge 3713 and &sic le 3713   then FF_IND='AUTOS';
          if &sic ge 3714 and &sic le 3714   then FF_IND='AUTOS';
          if &sic ge 3715 and &sic le 3715   then FF_IND='AUTOS';
          if &sic ge 3716 and &sic le 3716   then FF_IND='AUTOS';
          if &sic ge 3792 and &sic le 3792   then FF_IND='AUTOS';
          if &sic ge 3790 and &sic le 3791   then FF_IND='AUTOS';
          if &sic ge 3799 and &sic le 3799   then FF_IND='AUTOS';
	if FF_IND='AUTOS' then &ind_code=23;

*24 Aero   Aircraft;
          if &sic ge 3720 and &sic le 3720   then FF_IND='AERO';
          if &sic ge 3721 and &sic le 3721   then FF_IND='AERO';
          if &sic ge 3723 and &sic le 3724   then FF_IND='AERO';
          if &sic ge 3725 and &sic le 3725   then FF_IND='AERO';
          if &sic ge 3728 and &sic le 3729   then FF_IND='AERO';
	if FF_IND='AERO' then &ind_code=24;

*25 Ships  Shipbuilding, Railroad Equipment;
          if &sic ge 3730 and &sic le 3731   then FF_IND='SHIPS';
          if &sic ge 3740 and &sic le 3743   then FF_IND='SHIPS';
	if FF_IND='SHIPS' then &ind_code=25;

*26 Guns   Defense;
          if &sic ge 3760 and &sic le 3769   then FF_IND='GUNS';
          if &sic ge 3795 and &sic le 3795   then FF_IND='GUNS';
          if &sic ge 3480 and &sic le 3489   then FF_IND='GUNS';
	if FF_IND='GUNS' then &ind_code=26;

*27 Gold   Precious Metals;
          if &sic ge 1040 and &sic le 1049   then FF_IND='GOLD';
	if FF_IND='GOLD' then &ind_code=27;

*28 Mines  Non and &sic le Metallic and Industrial Metal Mining;;
          if &sic ge 1000 and &sic le 1009   then FF_IND='MINES';
          if &sic ge 1010 and &sic le 1019   then FF_IND='MINES';
          if &sic ge 1020 and &sic le 1029   then FF_IND='MINES';
          if &sic ge 1030 and &sic le 1039   then FF_IND='MINES';
          if &sic ge 1050 and &sic le 1059   then FF_IND='MINES';
          if &sic ge 1060 and &sic le 1069   then FF_IND='MINES';
          if &sic ge 1070 and &sic le 1079   then FF_IND='MINES';
          if &sic ge 1080 and &sic le 1089   then FF_IND='MINES';
          if &sic ge 1090 and &sic le 1099   then FF_IND='MINES';
          if &sic ge 1100 and &sic le 1119   then FF_IND='MINES';
          if &sic ge 1400 and &sic le 1499   then FF_IND='MINES';
	if FF_IND='MINES' then &ind_code=28;

*29 Coal   Coal;
          if &sic ge 1200 and &sic le 1299   then FF_IND='COAL';
	if FF_IND='COAL' then &ind_code=29;

*30 Oil    Petroleum and Natural Gas;
          if &sic ge 1300 and &sic le 1300   then FF_IND='OIL';
          if &sic ge 1310 and &sic le 1319   then FF_IND='OIL';
          if &sic ge 1320 and &sic le 1329   then FF_IND='OIL';
          if &sic ge 1330 and &sic le 1339   then FF_IND='OIL';
          if &sic ge 1370 and &sic le 1379   then FF_IND='OIL';
          if &sic ge 1380 and &sic le 1380   then FF_IND='OIL';
          if &sic ge 1381 and &sic le 1381   then FF_IND='OIL';
          if &sic ge 1382 and &sic le 1382   then FF_IND='OIL';
          if &sic ge 1389 and &sic le 1389   then FF_IND='OIL';
          if &sic ge 2900 and &sic le 2912   then FF_IND='OIL';
          if &sic ge 2990 and &sic le 2999   then FF_IND='OIL';
	if FF_IND='OIL' then &ind_code=30;

*31 Util   Utilities;
          if &sic ge 4900 and &sic le 4900   then FF_IND='UTIL';
          if &sic ge 4910 and &sic le 4911   then FF_IND='UTIL';
          if &sic ge 4920 and &sic le 4922   then FF_IND='UTIL';
          if &sic ge 4923 and &sic le 4923   then FF_IND='UTIL';
          if &sic ge 4924 and &sic le 4925   then FF_IND='UTIL';
          if &sic ge 4930 and &sic le 4931   then FF_IND='UTIL';
          if &sic ge 4932 and &sic le 4932   then FF_IND='UTIL';
          if &sic ge 4939 and &sic le 4939   then FF_IND='UTIL';
          if &sic ge 4940 and &sic le 4942   then FF_IND='UTIL';
	if FF_IND='UTIL' then &ind_code=31;

*32 Telcm  Communication;
          if &sic ge 4800 and &sic le 4800   then FF_IND='TELCM';
          if &sic ge 4810 and &sic le 4813   then FF_IND='TELCM';
          if &sic ge 4820 and &sic le 4822   then FF_IND='TELCM';
          if &sic ge 4830 and &sic le 4839   then FF_IND='TELCM';
          if &sic ge 4840 and &sic le 4841   then FF_IND='TELCM';
          if &sic ge 4880 and &sic le 4889   then FF_IND='TELCM';
          if &sic ge 4890 and &sic le 4890   then FF_IND='TELCM';
          if &sic ge 4891 and &sic le 4891   then FF_IND='TELCM';
          if &sic ge 4892 and &sic le 4892   then FF_IND='TELCM';
          if &sic ge 4899 and &sic le 4899   then FF_IND='TELCM';
	if FF_IND='TELCM' then &ind_code=32;

*33 PerSv  Personal Services;
          if &sic ge 7020 and &sic le 7021   then FF_IND='PERSV';
          if &sic ge 7030 and &sic le 7033   then FF_IND='PERSV';
          if &sic ge 7200 and &sic le 7200   then FF_IND='PERSV';
          if &sic ge 7210 and &sic le 7212   then FF_IND='PERSV';
          if &sic ge 7214 and &sic le 7214   then FF_IND='PERSV';
          if &sic ge 7215 and &sic le 7216   then FF_IND='PERSV';
          if &sic ge 7217 and &sic le 7217   then FF_IND='PERSV';
          if &sic ge 7219 and &sic le 7219   then FF_IND='PERSV';
          if &sic ge 7220 and &sic le 7221   then FF_IND='PERSV';
          if &sic ge 7230 and &sic le 7231   then FF_IND='PERSV';
          if &sic ge 7240 and &sic le 7241   then FF_IND='PERSV';
          if &sic ge 7250 and &sic le 7251   then FF_IND='PERSV';
          if &sic ge 7260 and &sic le 7269   then FF_IND='PERSV';
          if &sic ge 7270 and &sic le 7290   then FF_IND='PERSV';
          if &sic ge 7291 and &sic le 7291   then FF_IND='PERSV';
          if &sic ge 7292 and &sic le 7299   then FF_IND='PERSV';
          if &sic ge 7395 and &sic le 7395   then FF_IND='PERSV';
          if &sic ge 7500 and &sic le 7500   then FF_IND='PERSV';
          if &sic ge 7520 and &sic le 7529   then FF_IND='PERSV';
          if &sic ge 7530 and &sic le 7539   then FF_IND='PERSV';
          if &sic ge 7540 and &sic le 7549   then FF_IND='PERSV';
          if &sic ge 7600 and &sic le 7600   then FF_IND='PERSV';
          if &sic ge 7620 and &sic le 7620   then FF_IND='PERSV';
          if &sic ge 7622 and &sic le 7622   then FF_IND='PERSV';
          if &sic ge 7623 and &sic le 7623   then FF_IND='PERSV';
          if &sic ge 7629 and &sic le 7629   then FF_IND='PERSV';
          if &sic ge 7630 and &sic le 7631   then FF_IND='PERSV';
          if &sic ge 7640 and &sic le 7641   then FF_IND='PERSV';
          if &sic ge 7690 and &sic le 7699   then FF_IND='PERSV';
          if &sic ge 8100 and &sic le 8199   then FF_IND='PERSV';
          if &sic ge 8200 and &sic le 8299   then FF_IND='PERSV';
          if &sic ge 8300 and &sic le 8399   then FF_IND='PERSV';
          if &sic ge 8400 and &sic le 8499   then FF_IND='PERSV';
          if &sic ge 8600 and &sic le 8699   then FF_IND='PERSV';
          if &sic ge 8800 and &sic le 8899   then FF_IND='PERSV';
          if &sic ge 7510 and &sic le 7515   then FF_IND='PERSV';
	if FF_IND='PERSV' then &ind_code=33;

*34 BusSv  Business Services;
          if &sic ge 2750 and &sic le 2759   then FF_IND='BUSSV';
          if &sic ge 3993 and &sic le 3993   then FF_IND='BUSSV';
          if &sic ge 7218 and &sic le 7218   then FF_IND='BUSSV';
          if &sic ge 7300 and &sic le 7300   then FF_IND='BUSSV';
          if &sic ge 7310 and &sic le 7319   then FF_IND='BUSSV';
          if &sic ge 7320 and &sic le 7329   then FF_IND='BUSSV';
          if &sic ge 7330 and &sic le 7339   then FF_IND='BUSSV';
          if &sic ge 7340 and &sic le 7342   then FF_IND='BUSSV';
          if &sic ge 7349 and &sic le 7349   then FF_IND='BUSSV';
          if &sic ge 7350 and &sic le 7351   then FF_IND='BUSSV';
          if &sic ge 7352 and &sic le 7352   then FF_IND='BUSSV';
          if &sic ge 7353 and &sic le 7353   then FF_IND='BUSSV';
          if &sic ge 7359 and &sic le 7359   then FF_IND='BUSSV';
          if &sic ge 7360 and &sic le 7369   then FF_IND='BUSSV';
          if &sic ge 7370 and &sic le 7372   then FF_IND='BUSSV';
          if &sic ge 7374 and &sic le 7374   then FF_IND='BUSSV';
          if &sic ge 7375 and &sic le 7375   then FF_IND='BUSSV';
          if &sic ge 7376 and &sic le 7376   then FF_IND='BUSSV';
          if &sic ge 7377 and &sic le 7377   then FF_IND='BUSSV';
          if &sic ge 7378 and &sic le 7378   then FF_IND='BUSSV';
          if &sic ge 7379 and &sic le 7379   then FF_IND='BUSSV';
          if &sic ge 7380 and &sic le 7380   then FF_IND='BUSSV';
          if &sic ge 7381 and &sic le 7382   then FF_IND='BUSSV';
          if &sic ge 7383 and &sic le 7383   then FF_IND='BUSSV';
          if &sic ge 7384 and &sic le 7384   then FF_IND='BUSSV';
          if &sic ge 7385 and &sic le 7385   then FF_IND='BUSSV';
          if &sic ge 7389 and &sic le 7390   then FF_IND='BUSSV';
          if &sic ge 7391 and &sic le 7391   then FF_IND='BUSSV';
          if &sic ge 7392 and &sic le 7392   then FF_IND='BUSSV';
          if &sic ge 7393 and &sic le 7393   then FF_IND='BUSSV';
          if &sic ge 7394 and &sic le 7394   then FF_IND='BUSSV';
          if &sic ge 7396 and &sic le 7396   then FF_IND='BUSSV';
          if &sic ge 7397 and &sic le 7397   then FF_IND='BUSSV';
          if &sic ge 7399 and &sic le 7399   then FF_IND='BUSSV';
          if &sic ge 7519 and &sic le 7519   then FF_IND='BUSSV';
          if &sic ge 8700 and &sic le 8700   then FF_IND='BUSSV';
          if &sic ge 8710 and &sic le 8713   then FF_IND='BUSSV';
          if &sic ge 8720 and &sic le 8721   then FF_IND='BUSSV';
          if &sic ge 8730 and &sic le 8734   then FF_IND='BUSSV';
          if &sic ge 8740 and &sic le 8748   then FF_IND='BUSSV';
          if &sic ge 8900 and &sic le 8910   then FF_IND='BUSSV';
          if &sic ge 8911 and &sic le 8911   then FF_IND='BUSSV';
          if &sic ge 8920 and &sic le 8999   then FF_IND='BUSSV';
          if &sic ge 4220 and &sic le 4229  then FF_IND='BUSSV';
	if FF_IND='BUSSV' then &ind_code=34;

*35 Comps  Computers;
          if &sic ge 3570 and &sic le 3579   then FF_IND='COMPS';
          if &sic ge 3680 and &sic le 3680   then FF_IND='COMPS';
          if &sic ge 3681 and &sic le 3681   then FF_IND='COMPS';
          if &sic ge 3682 and &sic le 3682   then FF_IND='COMPS';
          if &sic ge 3683 and &sic le 3683   then FF_IND='COMPS';
          if &sic ge 3684 and &sic le 3684   then FF_IND='COMPS';
          if &sic ge 3685 and &sic le 3685   then FF_IND='COMPS';
          if &sic ge 3686 and &sic le 3686   then FF_IND='COMPS';
          if &sic ge 3687 and &sic le 3687   then FF_IND='COMPS';
          if &sic ge 3688 and &sic le 3688   then FF_IND='COMPS';
          if &sic ge 3689 and &sic le 3689   then FF_IND='COMPS';
          if &sic ge 3695 and &sic le 3695   then FF_IND='COMPS';
          if &sic ge 7373 and &sic le 7373   then FF_IND='COMPS';
	if FF_IND='COMPS' then &ind_code=35;

*36 Chips  Electronic Equipment;
          if &sic ge 3622 and &sic le 3622   then FF_IND='CHIPS';
          if &sic ge 3661 and &sic le 3661   then FF_IND='CHIPS';
          if &sic ge 3662 and &sic le 3662   then FF_IND='CHIPS';
          if &sic ge 3663 and &sic le 3663   then FF_IND='CHIPS';
          if &sic ge 3664 and &sic le 3664   then FF_IND='CHIPS';
          if &sic ge 3665 and &sic le 3665   then FF_IND='CHIPS';
          if &sic ge 3666 and &sic le 3666   then FF_IND='CHIPS';
          if &sic ge 3669 and &sic le 3669   then FF_IND='CHIPS';
          if &sic ge 3670 and &sic le 3679   then FF_IND='CHIPS';
          if &sic ge 3810 and &sic le 3810   then FF_IND='CHIPS';
          if &sic ge 3812 and &sic le 3812   then FF_IND='CHIPS';
	if FF_IND='CHIPS' then &ind_code=36;

*37 LabEq  Measuring and Control Equipment;
          if &sic ge 3811 and &sic le 3811   then FF_IND='LABEQ';
          if &sic ge 3820 and &sic le 3820   then FF_IND='LABEQ';
          if &sic ge 3821 and &sic le 3821   then FF_IND='LABEQ';
          if &sic ge 3822 and &sic le 3822   then FF_IND='LABEQ';
          if &sic ge 3823 and &sic le 3823   then FF_IND='LABEQ';
          if &sic ge 3824 and &sic le 3824   then FF_IND='LABEQ';
          if &sic ge 3825 and &sic le 3825   then FF_IND='LABEQ';
          if &sic ge 3826 and &sic le 3826   then FF_IND='LABEQ';
          if &sic ge 3827 and &sic le 3827   then FF_IND='LABEQ';
          if &sic ge 3829 and &sic le 3829   then FF_IND='LABEQ';
          if &sic ge 3830 and &sic le 3839   then FF_IND='LABEQ';
	if FF_IND='LABEQ' then &ind_code=37;

*38 Paper  Business Supplies;
          if &sic ge 2520 and &sic le 2549   then FF_IND='PAPER';
          if &sic ge 2600 and &sic le 2639   then FF_IND='PAPER';
          if &sic ge 2670 and &sic le 2699   then FF_IND='PAPER';
          if &sic ge 2760 and &sic le 2761   then FF_IND='PAPER';
          if &sic ge 3950 and &sic le 3955   then FF_IND='PAPER';
	if FF_IND='PAPER' then &ind_code=38;

*39 Boxes  Shipping Containers;
          if &sic ge 2440 and &sic le 2449   then FF_IND='BOXES';
          if &sic ge 2640 and &sic le 2659   then FF_IND='BOXES';
          if &sic ge 3220 and &sic le 3221   then FF_IND='BOXES';
          if &sic ge 3410 and &sic le 3412   then FF_IND='BOXES';
	if FF_IND='BOXES' then &ind_code=39;

*40 Trans  Transportation;
          if &sic ge 4000 and &sic le 4013   then FF_IND='TRANS';
          if &sic ge 4040 and &sic le 4049   then FF_IND='TRANS';
          if &sic ge 4100 and &sic le 4100   then FF_IND='TRANS';
          if &sic ge 4110 and &sic le 4119   then FF_IND='TRANS';
          if &sic ge 4120 and &sic le 4121   then FF_IND='TRANS';
          if &sic ge 4130 and &sic le 4131   then FF_IND='TRANS';
          if &sic ge 4140 and &sic le 4142   then FF_IND='TRANS';
          if &sic ge 4150 and &sic le 4151   then FF_IND='TRANS';
          if &sic ge 4170 and &sic le 4173   then FF_IND='TRANS';
          if &sic ge 4190 and &sic le 4199   then FF_IND='TRANS';
          if &sic ge 4200 and &sic le 4200   then FF_IND='TRANS';
          if &sic ge 4210 and &sic le 4219   then FF_IND='TRANS';
          if &sic ge 4230 and &sic le 4231   then FF_IND='TRANS';
          if &sic ge 4240 and &sic le 4249   then FF_IND='TRANS';
          if &sic ge 4400 and &sic le 4499   then FF_IND='TRANS';
          if &sic ge 4500 and &sic le 4599   then FF_IND='TRANS';
          if &sic ge 4600 and &sic le 4699   then FF_IND='TRANS';
          if &sic ge 4700 and &sic le 4700   then FF_IND='TRANS';
          if &sic ge 4710 and &sic le 4712   then FF_IND='TRANS';
          if &sic ge 4720 and &sic le 4729   then FF_IND='TRANS';
          if &sic ge 4730 and &sic le 4739   then FF_IND='TRANS';
          if &sic ge 4740 and &sic le 4749   then FF_IND='TRANS';
          if &sic ge 4780 and &sic le 4780   then FF_IND='TRANS';
          if &sic ge 4782 and &sic le 4782   then FF_IND='TRANS';
          if &sic ge 4783 and &sic le 4783   then FF_IND='TRANS';
          if &sic ge 4784 and &sic le 4784   then FF_IND='TRANS';
          if &sic ge 4785 and &sic le 4785   then FF_IND='TRANS';
          if &sic ge 4789 and &sic le 4789   then FF_IND='TRANS';
	if FF_IND='TRANS' then &ind_code=40;

*41 Whlsl  Wholesale;
          if &sic ge 5000 and &sic le 5000   then FF_IND='WHLSL';
          if &sic ge 5010 and &sic le 5015   then FF_IND='WHLSL';
          if &sic ge 5020 and &sic le 5023   then FF_IND='WHLSL';
          if &sic ge 5030 and &sic le 5039   then FF_IND='WHLSL';
          if &sic ge 5040 and &sic le 5042   then FF_IND='WHLSL';
          if &sic ge 5043 and &sic le 5043   then FF_IND='WHLSL';
          if &sic ge 5044 and &sic le 5044   then FF_IND='WHLSL';
          if &sic ge 5045 and &sic le 5045   then FF_IND='WHLSL';
          if &sic ge 5046 and &sic le 5046   then FF_IND='WHLSL';
          if &sic ge 5047 and &sic le 5047   then FF_IND='WHLSL';
          if &sic ge 5048 and &sic le 5048   then FF_IND='WHLSL';
          if &sic ge 5049 and &sic le 5049   then FF_IND='WHLSL';
          if &sic ge 5050 and &sic le 5059   then FF_IND='WHLSL';
          if &sic ge 5060 and &sic le 5060   then FF_IND='WHLSL';
          if &sic ge 5063 and &sic le 5063   then FF_IND='WHLSL';
          if &sic ge 5064 and &sic le 5064   then FF_IND='WHLSL';
          if &sic ge 5065 and &sic le 5065   then FF_IND='WHLSL';
          if &sic ge 5070 and &sic le 5078   then FF_IND='WHLSL';
          if &sic ge 5080 and &sic le 5080   then FF_IND='WHLSL';
          if &sic ge 5081 and &sic le 5081   then FF_IND='WHLSL';
          if &sic ge 5082 and &sic le 5082   then FF_IND='WHLSL';
          if &sic ge 5083 and &sic le 5083   then FF_IND='WHLSL';
          if &sic ge 5084 and &sic le 5084   then FF_IND='WHLSL';
          if &sic ge 5085 and &sic le 5085   then FF_IND='WHLSL';
          if &sic ge 5086 and &sic le 5087   then FF_IND='WHLSL';
          if &sic ge 5088 and &sic le 5088   then FF_IND='WHLSL';
          if &sic ge 5090 and &sic le 5090   then FF_IND='WHLSL';
          if &sic ge 5091 and &sic le 5092   then FF_IND='WHLSL';
          if &sic ge 5093 and &sic le 5093   then FF_IND='WHLSL';
          if &sic ge 5094 and &sic le 5094   then FF_IND='WHLSL';
          if &sic ge 5099 and &sic le 5099   then FF_IND='WHLSL';
          if &sic ge 5100 and &sic le 5100   then FF_IND='WHLSL';
          if &sic ge 5110 and &sic le 5113   then FF_IND='WHLSL';
          if &sic ge 5120 and &sic le 5122   then FF_IND='WHLSL';
          if &sic ge 5130 and &sic le 5139   then FF_IND='WHLSL';
          if &sic ge 5140 and &sic le 5149   then FF_IND='WHLSL';
          if &sic ge 5150 and &sic le 5159   then FF_IND='WHLSL';
          if &sic ge 5160 and &sic le 5169   then FF_IND='WHLSL';
          if &sic ge 5170 and &sic le 5172   then FF_IND='WHLSL';
          if &sic ge 5180 and &sic le 5182   then FF_IND='WHLSL';
          if &sic ge 5190 and &sic le 5199   then FF_IND='WHLSL';
	if FF_IND='WHLSL' then &ind_code=41;

*42 Rtail  Retail ;
          if &sic ge 5200 and &sic le 5200   then FF_IND='RTAIL';
          if &sic ge 5210 and &sic le 5219   then FF_IND='RTAIL';
          if &sic ge 5220 and &sic le 5229   then FF_IND='RTAIL';
          if &sic ge 5230 and &sic le 5231   then FF_IND='RTAIL';
          if &sic ge 5250 and &sic le 5251   then FF_IND='RTAIL';
          if &sic ge 5260 and &sic le 5261   then FF_IND='RTAIL';
          if &sic ge 5270 and &sic le 5271   then FF_IND='RTAIL';
          if &sic ge 5300 and &sic le 5300   then FF_IND='RTAIL';
          if &sic ge 5310 and &sic le 5311   then FF_IND='RTAIL';
          if &sic ge 5320 and &sic le 5320   then FF_IND='RTAIL';
          if &sic ge 5330 and &sic le 5331   then FF_IND='RTAIL';
          if &sic ge 5334 and &sic le 5334   then FF_IND='RTAIL';
          if &sic ge 5340 and &sic le 5349   then FF_IND='RTAIL';
          if &sic ge 5390 and &sic le 5399   then FF_IND='RTAIL';
          if &sic ge 5400 and &sic le 5400   then FF_IND='RTAIL';
          if &sic ge 5410 and &sic le 5411   then FF_IND='RTAIL';
          if &sic ge 5412 and &sic le 5412   then FF_IND='RTAIL';
          if &sic ge 5420 and &sic le 5429   then FF_IND='RTAIL';
          if &sic ge 5430 and &sic le 5439   then FF_IND='RTAIL';
          if &sic ge 5440 and &sic le 5449   then FF_IND='RTAIL';
          if &sic ge 5450 and &sic le 5459   then FF_IND='RTAIL';
          if &sic ge 5460 and &sic le 5469   then FF_IND='RTAIL';
          if &sic ge 5490 and &sic le 5499   then FF_IND='RTAIL';
          if &sic ge 5500 and &sic le 5500   then FF_IND='RTAIL';
          if &sic ge 5510 and &sic le 5529   then FF_IND='RTAIL';
          if &sic ge 5530 and &sic le 5539   then FF_IND='RTAIL';
          if &sic ge 5540 and &sic le 5549   then FF_IND='RTAIL';
          if &sic ge 5550 and &sic le 5559   then FF_IND='RTAIL';
          if &sic ge 5560 and &sic le 5569   then FF_IND='RTAIL';
          if &sic ge 5570 and &sic le 5579   then FF_IND='RTAIL';
          if &sic ge 5590 and &sic le 5599   then FF_IND='RTAIL';
          if &sic ge 5600 and &sic le 5699   then FF_IND='RTAIL';
          if &sic ge 5700 and &sic le 5700   then FF_IND='RTAIL';
          if &sic ge 5710 and &sic le 5719   then FF_IND='RTAIL';
          if &sic ge 5720 and &sic le 5722   then FF_IND='RTAIL';
          if &sic ge 5730 and &sic le 5733   then FF_IND='RTAIL';
          if &sic ge 5734 and &sic le 5734   then FF_IND='RTAIL';
          if &sic ge 5735 and &sic le 5735   then FF_IND='RTAIL';
          if &sic ge 5736 and &sic le 5736   then FF_IND='RTAIL';
          if &sic ge 5750 and &sic le 5799   then FF_IND='RTAIL';
          if &sic ge 5900 and &sic le 5900   then FF_IND='RTAIL';
          if &sic ge 5910 and &sic le 5912   then FF_IND='RTAIL';
          if &sic ge 5920 and &sic le 5929   then FF_IND='RTAIL';
          if &sic ge 5930 and &sic le 5932   then FF_IND='RTAIL';
          if &sic ge 5940 and &sic le 5940   then FF_IND='RTAIL';
          if &sic ge 5941 and &sic le 5941   then FF_IND='RTAIL';
          if &sic ge 5942 and &sic le 5942   then FF_IND='RTAIL';
          if &sic ge 5943 and &sic le 5943   then FF_IND='RTAIL';
          if &sic ge 5944 and &sic le 5944   then FF_IND='RTAIL';
          if &sic ge 5945 and &sic le 5945   then FF_IND='RTAIL';
          if &sic ge 5946 and &sic le 5946   then FF_IND='RTAIL';
          if &sic ge 5947 and &sic le 5947   then FF_IND='RTAIL';
          if &sic ge 5948 and &sic le 5948   then FF_IND='RTAIL';
          if &sic ge 5949 and &sic le 5949   then FF_IND='RTAIL';
          if &sic ge 5950 and &sic le 5959   then FF_IND='RTAIL';
          if &sic ge 5960 and &sic le 5969   then FF_IND='RTAIL';
          if &sic ge 5970 and &sic le 5979   then FF_IND='RTAIL';
          if &sic ge 5980 and &sic le 5989   then FF_IND='RTAIL';
          if &sic ge 5990 and &sic le 5990   then FF_IND='RTAIL';
          if &sic ge 5992 and &sic le 5992   then FF_IND='RTAIL';
          if &sic ge 5993 and &sic le 5993   then FF_IND='RTAIL';
          if &sic ge 5994 and &sic le 5994   then FF_IND='RTAIL';
          if &sic ge 5995 and &sic le 5995   then FF_IND='RTAIL';
          if &sic ge 5999 and &sic le 5999   then FF_IND='RTAIL';
	if FF_IND='RTAIL' then &ind_code=42;

*43 Meals  Restaraunts, Hotels, Motels;
          if &sic ge 5800 and &sic le 5819   then FF_IND='MEALS';
          if &sic ge 5820 and &sic le 5829   then FF_IND='MEALS';
          if &sic ge 5890 and &sic le 5899   then FF_IND='MEALS';
          if &sic ge 7000 and &sic le 7000   then FF_IND='MEALS';
          if &sic ge 7010 and &sic le 7019   then FF_IND='MEALS';
          if &sic ge 7040 and &sic le 7049   then FF_IND='MEALS';
          if &sic ge 7213 and &sic le 7213   then FF_IND='MEALS';
	if FF_IND='MEALS' then &ind_code=43;

*44 Banks  Banking;
          if &sic ge 6000 and &sic le 6000   then FF_IND='BANKS';
          if &sic ge 6010 and &sic le 6019   then FF_IND='BANKS';
          if &sic ge 6020 and &sic le 6020   then FF_IND='BANKS';
          if &sic ge 6021 and &sic le 6021   then FF_IND='BANKS';
          if &sic ge 6022 and &sic le 6022   then FF_IND='BANKS';
          if &sic ge 6023 and &sic le 6024   then FF_IND='BANKS';
          if &sic ge 6025 and &sic le 6025   then FF_IND='BANKS';
          if &sic ge 6026 and &sic le 6026   then FF_IND='BANKS';
          if &sic ge 6027 and &sic le 6027   then FF_IND='BANKS';
          if &sic ge 6028 and &sic le 6029   then FF_IND='BANKS';
          if &sic ge 6030 and &sic le 6036   then FF_IND='BANKS';
          if &sic ge 6040 and &sic le 6059   then FF_IND='BANKS';
          if &sic ge 6060 and &sic le 6062   then FF_IND='BANKS';
          if &sic ge 6080 and &sic le 6082   then FF_IND='BANKS';
          if &sic ge 6090 and &sic le 6099   then FF_IND='BANKS';
          if &sic ge 6100 and &sic le 6100   then FF_IND='BANKS';
          if &sic ge 6110 and &sic le 6111   then FF_IND='BANKS';
          if &sic ge 6112 and &sic le 6113   then FF_IND='BANKS';
          if &sic ge 6120 and &sic le 6129   then FF_IND='BANKS';
          if &sic ge 6130 and &sic le 6139   then FF_IND='BANKS';
          if &sic ge 6140 and &sic le 6149   then FF_IND='BANKS';
          if &sic ge 6150 and &sic le 6159   then FF_IND='BANKS';
          if &sic ge 6160 and &sic le 6169   then FF_IND='BANKS';
          if &sic ge 6170 and &sic le 6179   then FF_IND='BANKS';
          if &sic ge 6190 and &sic le 6199   then FF_IND='BANKS';
	if FF_IND='BANKS' then &ind_code=44;

*45 Insur  Insurance;
          if &sic ge 6300 and &sic le 6300   then FF_IND='INSUR';
          if &sic ge 6310 and &sic le 6319   then FF_IND='INSUR';
          if &sic ge 6320 and &sic le 6329   then FF_IND='INSUR';
          if &sic ge 6330 and &sic le 6331   then FF_IND='INSUR';
          if &sic ge 6350 and &sic le 6351   then FF_IND='INSUR';
          if &sic ge 6360 and &sic le 6361   then FF_IND='INSUR';
          if &sic ge 6370 and &sic le 6379   then FF_IND='INSUR';
          if &sic ge 6390 and &sic le 6399   then FF_IND='INSUR';
          if &sic ge 6400 and &sic le 6411   then FF_IND='INSUR';
	if FF_IND='INSUR' then &ind_code=45;

*46 RlEst  Real Estate;
          if &sic ge 6500 and &sic le 6500   then FF_IND='RLEST';
          if &sic ge 6510 and &sic le 6510   then FF_IND='RLEST';
          if &sic ge 6512 and &sic le 6512   then FF_IND='RLEST';
          if &sic ge 6513 and &sic le 6513   then FF_IND='RLEST';
          if &sic ge 6514 and &sic le 6514   then FF_IND='RLEST';
          if &sic ge 6515 and &sic le 6515   then FF_IND='RLEST';
          if &sic ge 6517 and &sic le 6519   then FF_IND='RLEST';
          if &sic ge 6520 and &sic le 6529   then FF_IND='RLEST';
          if &sic ge 6530 and &sic le 6531   then FF_IND='RLEST';
          if &sic ge 6532 and &sic le 6532   then FF_IND='RLEST';
          if &sic ge 6540 and &sic le 6541   then FF_IND='RLEST';
          if &sic ge 6550 and &sic le 6553   then FF_IND='RLEST';
          if &sic ge 6590 and &sic le 6599   then FF_IND='RLEST';
          if &sic ge 6610 and &sic le 6611   then FF_IND='RLEST';
	if FF_IND='RLEST' then &ind_code=46;

*47 Fin    Trading;
          if &sic ge 6200 and &sic le 6299   then FF_IND='FIN';
          if &sic ge 6700 and &sic le 6700   then FF_IND='FIN';
          if &sic ge 6710 and &sic le 6719   then FF_IND='FIN';
          if &sic ge 6720 and &sic le 6722   then FF_IND='FIN';
          if &sic ge 6723 and &sic le 6723   then FF_IND='FIN';
          if &sic ge 6724 and &sic le 6724   then FF_IND='FIN';
          if &sic ge 6725 and &sic le 6725   then FF_IND='FIN';
          if &sic ge 6726 and &sic le 6726   then FF_IND='FIN';
          if &sic ge 6730 and &sic le 6733   then FF_IND='FIN';
          if &sic ge 6740 and &sic le 6779   then FF_IND='FIN';
          if &sic ge 6790 and &sic le 6791   then FF_IND='FIN';
          if &sic ge 6792 and &sic le 6792   then FF_IND='FIN';
          if &sic ge 6793 and &sic le 6793   then FF_IND='FIN';
          if &sic ge 6794 and &sic le 6794   then FF_IND='FIN';
          if &sic ge 6795 and &sic le 6795   then FF_IND='FIN';
          if &sic ge 6798 and &sic le 6798   then FF_IND='FIN';
          if &sic ge 6799 and &sic le 6799   then FF_IND='FIN';
	if FF_IND='FIN' then &ind_code=47;

*48 Other  Almost Nothing;
          if &sic ge 4950 and &sic le 4959   then FF_IND='OTHER';
          if &sic ge 4960 and &sic le 4961   then FF_IND='OTHER';
          if &sic ge 4970 and &sic le 4971   then FF_IND='OTHER';
          if &sic ge 4990 and &sic le 4991   then FF_IND='OTHER'; 
          if &sic ge 9990 and &sic le 9999   then FF_IND='OTHER'; 
  	if FF_IND='OTHER' then &ind_code=48;

        



	if(&ind_code=1) then &bin_var.1=1;		else &bin_var.1=0;
	if(&ind_code=2) then &bin_var.2=1;		else &bin_var.2=0;
	if(&ind_code=3) then &bin_var.3=1;		else &bin_var.3=0;
	if(&ind_code=4) then &bin_var.4=1;		else &bin_var.4=0;
	if(&ind_code=5) then &bin_var.5=1;		else &bin_var.5=0;
	if(&ind_code=6) then &bin_var.6=1;		else &bin_var.6=0;
	if(&ind_code=7) then &bin_var.7=1;		else &bin_var.7=0;
	if(&ind_code=8) then &bin_var.8=1;		else &bin_var.8=0;
	if(&ind_code=9) then &bin_var.9=1;		else &bin_var.9=0;
	if(&ind_code=10) then &bin_var.10=1;		else &bin_var.10=0;
	if(&ind_code=11) then &bin_var.11=1;		else &bin_var.11=0;
	if(&ind_code=12) then &bin_var.12=1;		else &bin_var.12=0;
	if(&ind_code=13) then &bin_var.13=1;		else &bin_var.13=0;
	if(&ind_code=14) then &bin_var.14=1;		else &bin_var.14=0;
	if(&ind_code=15) then &bin_var.15=1;		else &bin_var.15=0;
	if(&ind_code=16) then &bin_var.16=1;		else &bin_var.16=0;
	if(&ind_code=17) then &bin_var.17=1;		else &bin_var.17=0;
	if(&ind_code=18) then &bin_var.18=1;		else &bin_var.18=0;
	if(&ind_code=19) then &bin_var.19=1;		else &bin_var.19=0;
	if(&ind_code=20) then &bin_var.20=1;		else &bin_var.20=0;
	if(&ind_code=21) then &bin_var.21=1;		else &bin_var.21=0;
	if(&ind_code=22) then &bin_var.22=1;		else &bin_var.22=0;
	if(&ind_code=23) then &bin_var.23=1;		else &bin_var.23=0;
	if(&ind_code=24) then &bin_var.24=1;		else &bin_var.24=0;
	if(&ind_code=25) then &bin_var.25=1;		else &bin_var.25=0;
	if(&ind_code=26) then &bin_var.26=1;		else &bin_var.26=0;
	if(&ind_code=27) then &bin_var.27=1;		else &bin_var.27=0;
	if(&ind_code=28) then &bin_var.28=1;		else &bin_var.28=0;
	if(&ind_code=29) then &bin_var.29=1;		else &bin_var.29=0;
	if(&ind_code=30) then &bin_var.30=1;		else &bin_var.30=0;
	if(&ind_code=31) then &bin_var.31=1;		else &bin_var.31=0;
	if(&ind_code=32) then &bin_var.32=1;		else &bin_var.32=0;
	if(&ind_code=33) then &bin_var.33=1;		else &bin_var.33=0;
	if(&ind_code=34) then &bin_var.34=1;		else &bin_var.34=0;
	if(&ind_code=35) then &bin_var.35=1;		else &bin_var.35=0;
	if(&ind_code=36) then &bin_var.36=1;		else &bin_var.36=0;
	if(&ind_code=37) then &bin_var.37=1;		else &bin_var.37=0;
	if(&ind_code=38) then &bin_var.38=1;		else &bin_var.38=0;
	if(&ind_code=39) then &bin_var.39=1;		else &bin_var.39=0;
	if(&ind_code=40) then &bin_var.40=1;		else &bin_var.40=0;
	if(&ind_code=41) then &bin_var.41=1;		else &bin_var.41=0;
	if(&ind_code=42) then &bin_var.42=1;		else &bin_var.42=0;
	if(&ind_code=43) then &bin_var.43=1;		else &bin_var.43=0;
	if(&ind_code=44) then &bin_var.44=1;		else &bin_var.44=0;
	if(&ind_code=45) then &bin_var.45=1;		else &bin_var.45=0;
	if(&ind_code=46) then &bin_var.46=1;		else &bin_var.46=0;
	if(&ind_code=47) then &bin_var.47=1;		else &bin_var.47=0;
	if(&ind_code=48) then &bin_var.48=1;		else &bin_var.48=0;
	
run;	


%mend;

*option notes source source2;



*option errorabend;
*option merror mlogic mprint symbolgen;
*option nonotes nosource nosource2;
*option notes source source2;

/********************************************************************************
	Author: 	Ed deHaan		staff.washington.edu/edehaan
	
	Macro: 		ind_ff12
	
	Purpose: 	to assign Fama 12 French industry codes

	Versions:	1.0 - 	2/5/11
				1.1 - 	2/17/11 - fixed a few typos in description, etc.
				
	
	Notes:		12 Industry classification codes obtained from French's website in Nov. 2010
				http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/data_library.html


--------------------------------------------

Generates Fama-French industry codes based on four-digit SIC codes.  


Outputs the original dataset with appended industry code information:

	'&ind_code' 	= count variable of industry codes from 1 through 12
	'FF_IND'		= text variable with name of the fama-french industry
	'&bin_var.#'	= 12 individual binary variables, one for each industry
	'_&global'		= global macro variable to include call 12 industry dummies

--------------------------------------------


	Required INPUT parameters:
		dset			-	input dataset name
		sic				-	four-digit sic code variable name
		outp			-	output dataset
		bin_var			-	prefix for industry binary variables
		ind_code		-	name of count variable for industry codes 1 through 12
		global			-	name of global macro variable to call all 12 industry dummies
	
	Optional INPUT parameters
;

	


********************************************************************************/


%let _industry_fe= 	i1 i2 i3 i4 i5 i6 i7 i8 i9 i10 i11 i12 ;

%macro ind_ff12 (dset, outp, sic, bin_var, ind_code );

********** FF Ind Codes Macro **********;



data &outp;
        set &dset;

        indus2=int(&sic/100);
        indus3=int(&sic/10);

*1 NoDur  Consumer NonDurables -- Food, Tobacco, Textiles, Apparel, Leather, Toys;
         if &sic ge   0100 and &sic le  0999 	then &ind_code=1;
         if &sic ge   2000 and &sic le 	2399 	then &ind_code=1;
         if &sic ge   2700 and &sic le 	2749 	then &ind_code=1;
         if &sic ge   2770 and &sic le 	2799 	then &ind_code=1;
         if &sic ge   3100 and &sic le 	3199 	then &ind_code=1;
         if &sic ge   3940 and &sic le 	3989 	then &ind_code=1;

 *2 Durbl  Consumer Durables -- Cars, TVs, Furniture, Household Appliances;
        if &sic ge   2500 and &sic le   2519 	then &ind_code=2;
        if &sic ge   2590 and &sic le 	2599 	then &ind_code=2;
        if &sic ge   3630 and &sic le 	3659 	then &ind_code=2;
        if &sic ge   3710 and &sic le 	3711 	then &ind_code=2;
        if &sic ge   3714 and &sic le 	3714 	then &ind_code=2;
        if &sic ge   3716 and &sic le 	3716 	then &ind_code=2;
        if &sic ge   3750 and &sic le 	3751 	then &ind_code=2;
        if &sic ge   3792 and &sic le 	3792 	then &ind_code=2;
        if &sic ge   3900 and &sic le 	3939 	then &ind_code=2;
        if &sic ge   3990 and &sic le 	3999 	then &ind_code=2;

* 3 Manuf  Manufacturing -- Machinery, Trucks, Planes, Off Furn, Paper, Com Printing;
        if &sic ge    2520 and &sic le  2589 	then &ind_code=3;
        if &sic ge    2600 and &sic le 	2699 	then &ind_code=3;
        if &sic ge    2750 and &sic le 	2769 	then &ind_code=3;
        if &sic ge    3000 and &sic le 	3099 	then &ind_code=3;
        if &sic ge    3200 and &sic le 	3569 	then &ind_code=3;
        if &sic ge    3580 and &sic le 	3629 	then &ind_code=3;
        if &sic ge    3700 and &sic le 	3709 	then &ind_code=3;
        if &sic ge    3712 and &sic le 	3713 	then &ind_code=3;
        if &sic ge    3715 and &sic le 	3715 	then &ind_code=3;
        if &sic ge    3717 and &sic le 	3749 	then &ind_code=3;
        if &sic ge    3752 and &sic le 	3791 	then &ind_code=3;
        if &sic ge    3793 and &sic le 	3799 	then &ind_code=3;
        if &sic ge    3830 and &sic le 	3839 	then &ind_code=3;
        if &sic ge    3860 and &sic le 	3899 	then &ind_code=3;

* 4 Enrgy  Oil, Gas, and Coal Extraction and Products;
        if &sic ge     1200 and &sic le 	1399 	then &ind_code=4;
        if &sic ge     2900 and &sic le 	2999 	then &ind_code=4;

* 5 Chems  Chemicals and Allied Products;
        if &sic ge     2800 and &sic le 	2829 	then &ind_code=5;
        if &sic ge     2840 and &sic le 	2899 	then &ind_code=5;

* 6 BusEq  Business Equipment -- Computers, Software, and Electronic Equipment;
        if &sic ge    3570 and &sic le 	3579 	then &ind_code=6;
        if &sic ge    3660 and &sic le 	3692 	then &ind_code=6;
        if &sic ge    3694 and &sic le 	3699 	then &ind_code=6;
        if &sic ge    3810 and &sic le 	3829 	then &ind_code=6;
        if &sic ge    7370 and &sic le 	7379 	then &ind_code=6;

* 7 Telcm  Telephone and Television Transmission;
         if &sic ge    4800 and &sic le 	4899 	then &ind_code=7;

* 8 Utils  Utilities;
         if &sic ge    4900 and &sic le 	4949 	then &ind_code=8;

* 9 Shops  Wholesale, Retail, and Some Services (Laundries, Repair Shops);
        if &sic ge    5000 and &sic le 	5999 	then &ind_code=9;
        if &sic ge    7200 and &sic le 	7299 	then &ind_code=9;
        if &sic ge    7600 and &sic le 	7699 	then &ind_code=9;

*10 Hlth   Healthcare, Medical Equipment, and Drugs;
         if &sic ge   2830 and &sic le 	2839 	then &ind_code=10;
         if &sic ge   3693 and &sic le 	3693 	then &ind_code=10;
         if &sic ge   3840 and &sic le 	3859 	then &ind_code=10;
         if &sic ge   8000 and &sic le 	8099 	then &ind_code=10;

*11 Money  Finance;
         if &sic ge   6000 and &sic le 	6999 	then &ind_code=11;

*12 Other  Other -- Mines, Constr, BldMt, Trans, Hotels, Bus Serv, Entertainment;
		 if &sic > .		and &ind_code = .	then &ind_code=12;


	if(&ind_code=1) then &bin_var.1=1;			else &bin_var.1=0;
	if(&ind_code=2) then &bin_var.2=1;			else &bin_var.2=0;
	if(&ind_code=3) then &bin_var.3=1;			else &bin_var.3=0;
	if(&ind_code=4) then &bin_var.4=1;			else &bin_var.4=0;
	if(&ind_code=5) then &bin_var.5=1;			else &bin_var.5=0;
	if(&ind_code=6) then &bin_var.6=1;			else &bin_var.6=0;
	if(&ind_code=7) then &bin_var.7=1;			else &bin_var.7=0;
	if(&ind_code=8) then &bin_var.8=1;			else &bin_var.8=0;
	if(&ind_code=9) then &bin_var.9=1;			else &bin_var.9=0;
	if(&ind_code=10) then &bin_var.10=1;		else &bin_var.10=0;
	if(&ind_code=11) then &bin_var.11=1;		else &bin_var.11=0;
	if(&ind_code=12) then &bin_var.12=1;		else &bin_var.12=0;

	
run;	


%mend ind_ff12;

option notes source source2;




/* Runquit */

   %macro runquit;
     ; run; quit;
     %if &syserr. ne 0 %then %do;
        %abort cancel;
     %end;
   %mend runquit;




%MACRO ARRAY(arraypos, array=, data=, var=, values=,
                       delim=%STR( ), debug=N, numlist=Y);

 /* last modified 8/4/2006                    a.k.a. MACARRAY( ).  
                                                           72nd col -->|
 Function: Define one or more Macro Arrays
     This macro creates one or more macro arrays, and stores in them 
     character values from a SAS dataset or view, or an explicit list 
     of values.

     A macro array is a list of macro variables sharing the same prefix
     and a numerical suffix.  The suffix numbers run from 1 up to a 
     highest number.  The value of this highest number, or the length 
     of the array, is stored in an additional macro variable with the 
     same prefix, plus the letter “NE  The prefix is also referred to
     as the name of the macro array. For example, "AA1", "AA2", "AA3", 
     etc., plus "AAN".  All such variables are declared GLOBAL.

 Authors: Ted Clay, M.S.   tclay@ashlandhome.net  (541) 482-6435
          David Katz, M.S. www.davidkatzconsulting.com
      "Please keep, use and pass on the ARRAY and DO_OVER macros with
          this authorship note.  -Thanks "

 Full documentation with examples appears in SUGI Proceedings, 2006, 
     "Tight Looping With Macro Arrays" by Ted Clay
 Please send improvements, fixes or comments to Ted Clay.

 Parameters: 
    ARRAYPOS and 
    ARRAY are equivalent parameters.  One or the other, but not both, 
             is required.  ARRAYPOS is the only position parameter. 
           = Identifier(s) for the macro array(s) to be defined. 
    DATA = Dataset containing values to load into the array(s).  Can be
              a view, and dataset options such as WHERE= are OK.
    VAR  = Variable(s) containing values to put in list. If multiple 
              array names are specified in ARRAYPOS or ARRAY then the 
              same number of variables must be listed.  
    VALUES  = An explicit list of character strings to put in the list 
              or lists.  If present, VALUES are used rather than DATA 
              and VAR.  VALUES can be a numbered list, eg 1-10, a01-A20, 
              a feature which can be turned of with NUMLIST=N.
              The VALUES can be used with one or more array names 
              specified in the ARRAYPOS or ARRAY parameters.  If more 
              than one array name is given, the values are assigned to
              each array in turn.  For example, if arrays AA and BB 
              are being assigned values, the values are assigned to 
              AA1, BB1, AA2, BB2, AA3, BB3, etc.  Therefore the number
              of values must be a multiple of the number of arrays. 

    DELIM = Character used to separate values in VALUES parameter.  
              Blank is default.

    DEBUG = N/Y. Default=N.  If Y, debugging statements are activated.

    NUMLIST = Y/N.  Default=Y.  If Y, VALUES may be a number list.

 REQUIRED OTHER MACRO: Requires NUMLIST if using numbered lists are used
              in the VALUES parameter.

 How the program works.
    When the VALUES parameter is used, it is parsed into individual 
    words using the scan function. With the DATA parameter, each 
    observation of data to be loaded into one or more macro
    arrays, _n_ determines the numeric suffix.  Each one is declared
    GLOBAL using "call execute" which is acted upon by the SAS macro 
    processor immediately. (Without this "global" setting, "Call symput" 
    would by default put the new macro variables in the local symbol 
    table, which would not be accessible outside this macro.)  Because 
    "call execute" only is handling macro statements, the following 
    statement will normally appear on the SAS log: "NOTE: CALL EXECUTE 
    routine executed successfully, but no SAS statements were generated."

 History
  7/14/05 handle char variable value containing single quote
  1/19/06 VALUES can be a a numbered list with dash, e.g. AA1-AA20 
  4/1/06 simplified process of making variables global.
  4/12/06 allow VALUES= when creating more than one macro array.

    */

%LOCAL prefixes PREFIXN manum _VAR_N iter i J val VAR WHICH MINLENG
   PREFIX1 PREFIX2 PREFIX3 PREFIX4 PREFIX5 PREFIX6 PREFIX7 PREFIX8 
   PREFIX9 PREFIX10 PREFIX11
   var1 var2 var3 var4 var5 var6 var7 var8 var9 var10 var11 ;

%* Get array names from either the keyword or positional parameter;
%if &ARRAY= %then %let PREFIXES=&ARRAYPOS;
%else %let PREFIXES=&ARRAY;

%* Parse the list of macro array names;
%do MANUM = 1 %to 999; 
 %let prefix&MANUM=%scan(&prefixes,&MAnum,' ');
 %if &&prefix&MANUM ne %then 
   %DO;
    %let PREFIXN=&MAnum;
    %global &&prefix&MANUM..N;
    %* initialize length to zero;
    %let &&prefix&MANUM..N=0;
   %END;
  %else %goto out1;
%end; 
%out1:

%if &DEBUG=Y %then %put PREFIXN is &PREFIXN;

%* Parse the VAR parameter;
%let _VAR_N=0;
%do MANUM = 1 %to 999; 
 %let _var_&MANUM=%scan(&VAR,&MAnum,' ');
 %if %str(&&_var_&MANUM) ne %then %let _VAR_N=&MAnum;
 %else %goto out2;
%end; 
%out2:

%IF &PREFIXN=0 %THEN 
    %PUT ERROR: No macro array names are given;
%ELSE %IF %LENGTH(%STR(&DATA)) >0 and &_VAR_N=0 %THEN
    %PUT ERROR: DATA parameter is used but VAR parameter is blank;
%ELSE %IF %LENGTH(%STR(&DATA)) >0 and &_VAR_N ne &PREFIXN %THEN
    %PUT ERROR: The number of variables in the VAR parameter is not 
 equal to the number of arrays;
%ELSE %DO;

%*------------------------------------------------------;
%*  CASE 1: VALUES parameter is used
%*------------------------------------------------------;

%IF %LENGTH(%STR(&VALUES)) >0 %THEN 
%DO;
     %IF &NUMLIST=Y %then
     %DO;
         %* Check for numbered list of form xxx-xxx and expand it using
             the NUMLIST macro.;
         %IF (%INDEX(%quote(&VALUES),-) GT 0) and 
             (%length(%SCAN(%quote(&VALUES),1,-))>0) and 
             (%length(%SCAN(%quote(&VALUES),2,-))>0) and 
             (%length(%SCAN(%quote(&VALUES),3,-))=0) 
           %THEN %LET VALUES=%NUMLIST(&VALUES);
     %END;

%LET MINLENG=99999;
%DO J=1 %TO &PREFIXN;
%DO ITER=1 %TO 9999;  
  %LET WHICH=%EVAL((&ITER-1)*&PREFIXN +&J); 
  %LET VAL=%SCAN(%STR(&VALUES),&WHICH,%STR(&DELIM));
  %IF %QUOTE(&VAL) NE %THEN
    %DO;
      %GLOBAL &&&&PREFIX&J..&ITER;
      %LET &&&&PREFIX&J..&ITER=&VAL;
      %LET &&&&PREFIX&J..N=&ITER;
    %END;
  %ELSE %goto out3;
%END; 
%out3: %IF &&&&&&PREFIX&J..N LT &MINLENG
          %THEN %LET MINLENG=&&&&&&PREFIX&J..N;
%END;

%if &PREFIXN >1 %THEN 
%DO J=1 %TO &PREFIXN;
    %IF &&&&&&PREFIX&J..N NE &MINLENG %THEN 
%PUT ERROR: Number of values must be a multiple of the number of arrays;
%END;

%END;
%ELSE %DO;

%*------------------------------------------------------;
%*  CASE 2: DATA and VAR parameters used
%*------------------------------------------------------;

%* Get values from one or more variables in a dataset or view;
  data _null_;
  set &DATA end = lastobs;
%DO J=1 %to &PREFIXN; 
  call execute('%GLOBAL '||"&&PREFIX&J.."||left(put(_n_,5.)) );
  call symput(compress("&&prefix&J"||left(put(_n_,5.))), 
              trim(left(&&_VAR_&J)));
  if lastobs then 
   call symput(compress("&&prefix&J"||"N"), trim(left(put(_n_,5.))));
%END;
  run ;

%* Write message to the log;
%IF &DEBUG=Y %then
%DO J=1 %to &PREFIXN;
 %PUT &&&&PREFIX&J..N is &&&&&&PREFIX&J..N;
%END;

%END;
%END;

%MEND;


%MACRO NUMLIST(listwithdash); 
  /* 
                                                           72nd col -->|
    Function: Generate the elements of a numbered list.

              For example, AA1-AA3 generates AA1 AA2 AA3
              No prefix is necessary -- 1-3 generates 1 2 3.

      Author: Ted Clay, M.S.
            Clay Software & Statistics
            tclay@ashlandhome.net  (541) 482-6435
      "Please keep, use and share this macro with this authorship note."

   Parameter: 
       ListWithDash -- text string containing a dash.  
           The text before the dash, and the text after the dash, 
           usually begin with a the same character string, called the
           stem.  (The stem could be blank or null, as is the case of 
           number-dash-number.) After the common stem must be two 
           numbers.  The first number must be less than the second 
           number.  Leading zeroes on the numbers are preserved.

  How it works: The listwithdash is parsed into _before and _after.
         _before and _after are compared equal up to the length of the
         "stem".  What is after the "stem" is assigned to _From and _to,
         which must convert to numerics. Finally, the macro generates 
         stem followed by all the numbers from _from through _to

  Examples:
     %numlist(3-6) generates 3 4 5 6.
     %numlist(1993-2004) generates 1993 1994 1995 1996 1997 1998 1999
                                   2000 2001 2002 2003 2004.
     %numlist(var8-var12) generates var8 var9 var10 var11 var12.
     %numlist(var08-var12) generates var08 var09 var10 var11 var12.

  */

%local _before _after _length1 _length2 minlength samepos _pos 
       _from _to i;

  %let _before = %scan(%quote(&listwithdash),1,-);
  %let _after  = %scan(%quote(&listwithdash),2,-);
  %let _length1 = %length(%quote(&_before));
  %let _length2 = %length(%quote(&_after));
  %let minlength=&_length1;
  %if &_length2 < &minlength %then %let minlength=&_length2;

%*put before is &_before;
%*put after is &_after;
%*put minlength is &minlength;
  %* Stemlength should be just before the first number or the first 
      unequal character;
  %let stemlength=0;
  %let foundit=0;
  %do _pos = 1 %to &minlength;
    %LET CHAR1=%upcase(%substr(%quote(&_before),&_pos,1));
    %LET CHAR2=%upcase(%substr(%quote(&_after ),&_pos,1));
    %if %index(1234567890,%QUOTE(&CHAR1)) GE 1 %then %let ISANUMBER=Y;
    %else %let isanumber=N;

    %if &foundit=0 and 
         ( &isanumber=Y OR %quote(&CHAR1) NE %QUOTE(&CHAR2) )
         %then %do;
             %let stemlength=%EVAL(&_pos-1);
             %*put   after assignment stemlength is &stemlength;
             %let foundit=1;
          %end;
  %end; 

  %if &stemlength=0 %then %let stem=;
  %else %let stem = %substr(&_before,1,&stemlength);

  %let _from=%substr(&_before,%eval(&stemlength+1));
  %let _to  =%substr(&_after, %eval(&stemlength+1));

%IF %verify(&_FROM,1234567890)>0 or
    %verify(&_TO  ,1234567890)>0 %then 
  %PUT ERROR in NUMLIST macro: Alphabetic prefixes are different;
 
%else %if &_from <= &_to %then
%do _III_=&_from %to &_to;
    %LET _XXX_=&_iii_;
    %do _JJJ_=%length(&_iii_) %to %eval(%length(&_from)-1);
        %let _XXX_=0&_XXX_;
    %end;
%TRIM(&stem&_XXX_)
%end; 
%else %PUT ERROR in NUMLIST macro: From "&_from" not <= To "&_to";

%MEND; 


%MACRO DO_OVER(arraypos, array=, 
               values=, delim=%STR( ),
               phrase=?, escape=?, between=, 
               macro=, keyword=);

 /*  Last modified: 8/4/2006
                                                           72nd col -->|
  Function: Loop over one or more arrays of macro variables 
           substituting values into a phrase or macro.

  Authors: Ted Clay, M.S.  
              Clay Software & Statistics
              tclay@ashlandhome.net  (541) 482-6435
           David Katz, M.S. www.davidkatzconsulting.com
         "Please keep, use and pass on the ARRAY and DO_OVER macros with
               this authorship note.  -Thanks "
          Send any improvements, fixes or comments to Ted Clay.

  Full documentation with examples appears in 
     "Tight Looping with Macro Arrays".SUGI Proceedings 2006, 
       The keyword parameter was added after the SUGI article was written.

  REQUIRED OTHER MACROS:
        NUMLIST -- if using numbered lists in VALUES parameter.
        ARRAY   -- if using macro arrays.

  Parameters:

     ARRAYPOS and 
     ARRAY are equivalent parameters.  One or the other, but not both, 
             is required.  ARRAYPOS is the only position parameter. 
           = Identifier(s) for the macro array(s) to iterate over. 
             Up to 9 array names are allowed. If multiple macro arrays
             are given, they must have the same length, that is, 
             contain the same number of macro variables.

     VALUES = An explicit list of character strings to put in an 
             internal macro array, VALUES may be a numbered lists of 
             the form 3-15, 03-15, xx3-xx15, etc.

     DELIM = Character used to separate values in VALUES parameter.  
             Blank is default.

     PHRASE = SAS code into which to substitute the values of the 
             macro variable array, replacing the ESCAPE
             character with each value in turn.  The default
             value of PHRASE is a single <?> which is equivalent to
             simply the values of the macro variable array.
             The PHRASE parameter may contain semicolons and extend to
             multiple lines.
             NOTE: The text "?_I_", where ? is the ESCAPE character, 
                   will be replaced with the value of the index variable
                   values, e.g. 1, 2, 3, etc. 
             Note: Any portion of the PHRASE parameter enclosed in 
               single quotes will not be scanned for the ESCAPE.
               So, use double quotes within the PHRASE parameter. 

             If more than one array name is given in the ARRAY= or 
             ARRAYPOS parameter, in the PHRASE parameter the ESCAPE 
             character must be immediately followed by the name of one 
             of the macro arrays, using the same case.

     ESCAPE = A single character to be replaced by macro array values.
             Default is "?".  

     BETWEEN = code to generate between iterations of the main 
             phrase or macro.  The most frequent need for this is to
             place a comma between elements of an array, so the special
             argument COMMA is provided for programming convenience.
             BETWEEN=COMMA is equivalent to BETWEEN=%STR(,).

     MACRO = Name of an externally-defined macro to execute on each 
             value of the array. It overrides the PHRASE parameter.  
             The parameters of this macro may be a combination of 
             positional or keyword parameters, but keyword parameters
             on the external macro require the use of the KEYWORD=
             parameter in DO_OVER.  Normally, the macro would have 
             only positional parameters and these would be defined in
             in the same order and meaning as the macro arrays specified
             in the ARRAY or ARRAYPOS parameter. 
             For example, to execute the macro DOIT with one positional
             parameter, separately define
                      %MACRO DOIT(STRING1); 
                          <statements>
                      %MEND;
             and give the parameter MACRO=DOIT.  The values of AAA1, 
             AAA2, etc. would be substituted for STRING.
             MACRO=DOIT is equivalent to PHRASE=%NRQUOTE(%DOIT(?)).
             Note: Within an externally defined macro, the value of the 
             macro index variable would be coded as "&I".  This is 
             comparable to "?_I_" within the PHRASE parameter.

    KEYWORD = Name(s) of keyword parameters used in the definition of 
             the macro refered to in the MACRO= parameter. Optional.  
             This parameter controls how DO_OVER passes macro array 
             values to specific keyword parameters on the macro.
             This allows DO_OVER to execute a legacy or standard macro.
             The number of keywords listed in the KEYWORD= parameter
             must be less than or equal to the number of macro arrays 
             listed in the ARRAYPOS or ARRAY parameter.  Macro array 
             names are matched with keywords proceeding from right 
             to left.  If there are fewer keywords than macro array 
             names, the remaining array names are passed as positional 
             parameters to the external macro.  See Example 6.

  Rules:
      Exactly one of ARRAYPOS or ARRAY or VALUES is required.
      PHRASE or MACRO is required.  MACRO overrides PHRASE.
      ESCAPE is used when PHRASE is used, but is ignored with MACRO.
      If ARRAY or ARRAYPOS have multiple array names, these must exist 
          and have the same length.  If used with externally defined 
          MACRO, the macro must have positional parameters that 
          correspond 1-for-1 with the array names.  Alternatively, one 
          can specify keywords which tell DO_OVER the names of keyword 
          parameters of the external macro.
 
  Examples:
     Assume macro array AAA has been created with 
             %ARRAY(AAA,VALUES=x y z)
      (1) %DO_OVER(AAA) generates: x y z;
      (2) %DO_OVER(AAA,phrase="?",between=comma) generates: "x","y","z"
      (3) %DO_OVER(AAA,phrase=if L="?" then ?=1;,between=else) generates:
                    if L="x" then x=1;
               else if L="y" then y=1;
               else if L="z" then z=1;
 
      (4) %DO_OVER(AAA,macro=DOIT) generates:
                %DOIT(x) 
                %DOIT(y)
                %DOIT(z)
          which assumes %DOIT has a single positional parameter.
          It is equivalent to:
          %DO_OVER(AAA,PHRASE=%NRSTR(%DOIT(?)))

      (5) %DO_OVER(AAA,phrase=?pct=?/tot*100; format ?pct 4.1;) 
            generates: 
                xpct=x/tot*100; format xpct 4.1;
                ypct=y/tot*100; format ypct 4.1;
                zpct=z/tot*100; format zpct 4.1;
      (6) %DO_OVER(aa bb cc,MACRO=doit,KEYWORD=borders columns)
         is equivalent to %DO_OVER(aa,bb,cc,
                  PHRASE=%NRSTR(%doit(?aa,borders=?bb,columns=?cc)))
         Either example would generate the following internal do-loop:
         %DO I=1 %to &AAN;
           %doit(&&aa&I,borders=&&bb&I,columns=&&cc&I)
         %END;
         Because we are giving three macro array names, the macro DOIT 
         must have three parameters.  Since there are only two keyword
         parameters listed, the third parameter is assumed to be 
         positional.  Positional parameters always preceed keyword
         parameters in SAS macro definitions, so the first parameter
         a positional parameter, which is given the values of first 
         macro array "aa".  The second is keyword parameter "borders=" 
         which is fed the values of the second array "bb".  The third 
         is a keyword parameter "columns=" which is fed the values of
         the third array "cc".  

  History
    7/15/05 changed %str(&VAL) to %quote(&VAL).          
    4/1/06 added KEYWORD parameter
    4/9/06 declared "_Intrnl" array variables local to remove problems
            with nesting with VALUES=.
    8/4/06 made lines 72 characters or less to be mainframe compatible
*/

%LOCAL 
  _IntrnlN
  _Intrnl1  _Intrnl2  _Intrnl3  _Intrnl4  _Intrnl5  
  _Intrnl6  _Intrnl7  _Intrnl8  _Intrnl9  _Intrnl10
  _Intrnl11 _Intrnl12 _Intrnl13 _Intrnl14 _Intrnl15 
  _Intrnl16 _Intrnl17 _Intrnl18 _Intrnl19 _Intrnl20
  _Intrnl21 _Intrnl22 _Intrnl23 _Intrnl24 _Intrnl25
  _Intrnl26 _Intrnl27 _Intrnl28 _Intrnl29 _Intrnl30
  _Intrnl31 _Intrnl32 _Intrnl33 _Intrnl34 _Intrnl35
  _Intrnl36 _Intrnl37 _Intrnl38 _Intrnl39 _Intrnl40
  _Intrnl41 _Intrnl42 _Intrnl43 _Intrnl44 _Intrnl45
  _Intrnl46 _Intrnl47 _Intrnl48 _Intrnl49 _Intrnl50
  _Intrnl51 _Intrnl52 _Intrnl53 _Intrnl54 _Intrnl55
  _Intrnl56 _Intrnl57 _Intrnl58 _Intrnl59 _Intrnl60
  _Intrnl61 _Intrnl62 _Intrnl63 _Intrnl64 _Intrnl65
  _Intrnl66 _Intrnl67 _Intrnl68 _Intrnl69 _Intrnl70
  _Intrnl71 _Intrnl72 _Intrnl73 _Intrnl74 _Intrnl75
  _Intrnl76 _Intrnl77 _Intrnl78 _Intrnl79 _Intrnl80
  _Intrnl81 _Intrnl82 _Intrnl83 _Intrnl84 _Intrnl85
  _Intrnl86 _Intrnl87 _Intrnl88 _Intrnl89 _Intrnl90
  _Intrnl91 _Intrnl92 _Intrnl93 _Intrnl94 _Intrnl95
  _Intrnl96 _Intrnl97 _Intrnl98 _Intrnl99 _Intrnl100
 _KEYWRDN _KEYWRD1 _KEYWRD2 _KEYWRD3 _KEYWRD4 _KEYWRD5 
 _KEYWRD6 _KEYWRD7 _KEYWRD8 _KEYWRD9
 _KWRDI
 ARRAYNOTFOUND CRC CURRPREFIX DELIMI DID FRC I ITER J KWRDINDEX MANUM
 PREFIXES PREFIXN PREFIX1 PREFIX2 PREFIX3 PREFIX4 PREFIX5 
 PREFIX6 PREFIX7 PREFIX8 PREFIX9
 SOMETHINGTODO TP VAL VALUESGIVEN
 ;

%let somethingtodo=Y;

%* Get macro array name(s) from either keyword or positional parameter;
%if       %str(&arraypos) ne %then %let prefixes=&arraypos;
%else %if %str(&array)    ne %then %let prefixes=&array;
%else %if %quote(&values) ne %then %let prefixes=_Intrnl;
%else %let Somethingtodo=N;

%if &somethingtodo=Y %then
%do;

%* Parse the macro array names;
%let PREFIXN=0;
%do MAnum = 1 %to 999; 
 %let prefix&MANUM=%scan(&prefixes,&MAnum,' ');
 %if &&prefix&MAnum ne %then %let PREFIXN=&MAnum;
 %else %goto out1;
%end; 
%out1:

%* Parse the keywords;
%let _KEYWRDN=0;
%do _KWRDI = 1 %to 999; 
 %let _KEYWRD&_KWRDI=%scan(&KEYWORD,&_KWRDI,' ');
 %if &&_KEYWRD&_KWRDI ne %then %let _KEYWRDN=&_KWRDI;
 %else %goto out2;
%end; 
%out2:

%* Load the VALUES into macro array 1 (only one is permitted);
%if %length(%str(&VALUES)) >0 %then %let VALUESGIVEN=1;
%else %let VALUESGIVEN=0;
%if &VALUESGIVEN=1 %THEN 
%do;
         %* Check for numbered list of form xxx-xxx and expand it 
            using NUMLIST macro.;
         %IF (%INDEX(%STR(&VALUES),-) GT 0) and 
             (%SCAN(%str(&VALUES),2,-) NE ) and 
             (%SCAN(%str(&VALUES),3,-) EQ ) 
           %THEN %LET VALUES=%NUMLIST(&VALUES);

%do iter=1 %TO 9999;  
  %let val=%scan(%str(&VALUES),&iter,%str(&DELIM));
  %if %quote(&VAL) ne %then
    %do;
      %let &PREFIX1&ITER=&VAL;
      %let &PREFIX1.N=&ITER;
    %end;
  %else %goto out3;
%end; 
%out3:
%end;

%let ArrayNotFound=0;
%do j=1 %to &PREFIXN;
  %*put prefix &j is &&prefix&j;
  %LET did=%sysfunc(open(sashelp.vmacro 
                    (where=(name eq "%upcase(&&PREFIX&J..N)")) ));
  %LET frc=%sysfunc(fetchobs(&did,1));
  %LET crc=%sysfunc(close(&did));
  %IF &FRC ne 0 %then 
    %do;
       %PUT Macro Array with Prefix &&PREFIX&J does not exist;
       %let ArrayNotFound=1;
    %end;
%end; 

%if &ArrayNotFound=0 %then %do;

%if %quote(%upcase(&BETWEEN))=COMMA %then %let BETWEEN=%str(,);

%if %length(%str(&MACRO)) ne 0 %then 
  %do;
     %let TP = %nrstr(%&MACRO)(;
     %do J=1 %to &PREFIXN;
         %let currprefix=&&prefix&J;
         %IF &J>1 %then %let TP=&TP%str(,);
            %* Write out macro keywords followed by equals. 
               If fewer keywords than macro arrays, assume parameter 
               is positional and do not write keyword=;
            %let kwrdindex=%eval(&_KEYWRDN-&PREFIXN+&J);
            %IF &KWRDINDEX>0 %then %let TP=&TP&&_KEYWRD&KWRDINDEX=;
         %LET TP=&TP%nrstr(&&)&currprefix%nrstr(&I);
     %END;
     %let TP=&TP);  %* close parenthesis on external macro call;
  %end; 
%else
  %do;
     %let TP=&PHRASE;
     %let TP = %qsysfunc(tranwrd(&TP,&ESCAPE._I_,%nrstr(&I.)));
     %let TP = %qsysfunc(tranwrd(&TP,&ESCAPE._i_,%nrstr(&I.)));
     %do J=1 %to &PREFIXN;
         %let currprefix=&&prefix&J;
         %LET TP = %qsysfunc(tranwrd(&TP,&ESCAPE&currprefix,
                                 %nrstr(&&)&currprefix%nrstr(&I..))); 
         %if &PREFIXN=1 %then %let TP = %qsysfunc(tranwrd(&TP,&ESCAPE,
                                 %nrstr(&&)&currprefix%nrstr(&I..)));
     %end;
  %end;

%* resolve TP (the translated phrase) and perform the looping;
%do I=1 %to &&&prefix1.n;
%if &I>1 and %length(%str(&between))>0 %then &BETWEEN;
%unquote(&TP)
%end;  

%end;
%end;

%MEND;




/* 

RM (Remove Datasets) - an easy way to delete datafiles
	Author: Joost Impink:  

*/
%macro rm(dsets, lib=work);
/*
	rm: removes datasets 
	rm (dsets=, lib=) -- removes dsets in library lib
	dsets: datasets to remove
	lib: library, default is work
	sample usage: %rm(attr eng); * deletes attr and eng from lib work
*/
	proc datasets library=&lib noprint;
	   delete &dsets;
	quit;run;
%mend;


/*

Winsorize Macro
	Author: Joost Impink:  

*/
 
%macro winsor(dsetin=, dsetout=, byvar=none, vars=, type=winsor, pctl=1 99);
  
%if &dsetout = %then %let dsetout = &dsetin;
     
%let varL=;
%let varH=;
%let xn=1;
  
%do %until ( %scan(&vars,&xn)= );
    %let token = %scan(&vars,&xn);
    %let varL = &varL &token.L;
    %let varH = &varH &token.H;
    %let xn=%EVAL(&xn + 1);
%end;
  
%let xn=%eval(&xn-1);
  
data xtemp;
    set &dsetin;
    run;
  
%if &byvar = none %then %do;
  
    data xtemp;
        set xtemp;
        xbyvar = 1;
        run;
  
    %let byvar = xbyvar;
  
%end;
  
proc sort data = xtemp;
    by &byvar;
    run;
  
proc univariate data = xtemp noprint;
    by &byvar;
    var &vars;
    output out = xtemp_pctl PCTLPTS = &pctl PCTLPRE = &vars PCTLNAME = L H;
    run;
  
data &dsetout;
    merge xtemp xtemp_pctl;
    by &byvar;
    array trimvars{&xn} &vars;
    array trimvarl{&xn} &varL;
    array trimvarh{&xn} &varH;
  
    do xi = 1 to dim(trimvars);
  
        %if &type = winsor %then %do;
            if not missing(trimvars{xi}) then do;
              if (trimvars{xi} < trimvarl{xi}) then trimvars{xi} = trimvarl{xi};
              if (trimvars{xi} > trimvarh{xi}) then trimvars{xi} = trimvarh{xi};
            end;
        %end;
  
        %else %do;
            if not missing(trimvars{xi}) then do;
              if (trimvars{xi} < trimvarl{xi}) then delete;
              if (trimvars{xi} > trimvarh{xi}) then delete;
            end;
        %end;
  
    end;
    drop &varL &varH xbyvar xi;
    run;
  
%mend winsor;




/* this creates lagged values, ensuring no change in fiscal year occurs; %lag3_yr(in=test, lagn=1 2 3 4, var=ca cl asset rev oibd dep, chfyr=1); ----------------------------------------------------------------*/


%macro lag3_yr_gvkey(in=, out=, lagn=, id=GVKEY, yr=fyear, var=, sorted=0,
              chfyr=0, charid=0);

%* ----------------------------------------------------------------;
%* if output dataset is specified, set variable ds to this value;
    %if &out ne %then %do;
     %let ds=&out;
     data &ds; set &in; run;
    %end;
    %else %do;
     %let ds=&in;
    %end;
%* ----------------------------------------------------------------;

%* ----------------------------------------------------------------;
%* generate numeric id if necessary;
    %if &charid=1 %then %do;
     proc sql;
         create table tmpid as
         select count(&id) as ct, &id
           from &ds
           group by &id
           order by &id;

     data tmpid;
         set tmpid;
         tempid=_N_;
     run;

     proc sql;
         create table &ds as
         select d.*, t.tempid
           from &ds as d left join tempid as t
           on d.&id = t.&id;

     %let id=tempid;    
    %end;
%* ----------------------------------------------------------------;

%* ----------------------------------------------------------------;
%* Generate the strings containing lagged variable names;

    %* determine the number of lags to do;
    %* z is the total number of lags;
    %* z1... zn contain the actual values of the lag;
    %* e.g. z1=1 z2=2... or z1=-1 z2=-2;

    %let z=1;

    %* Note with the scan function there are three arguments;
    %* the third is the delimeter which can be:   ;
    %* blank . < ( + & ! $ * ) semicolon ^ - / , % |  ;
    %* and so negative numbers will not be scanned unless;
    %* a delimiter is specified.  I specify the blank;
    %* which is %STR( ), this frees up the other default delimiters;
    %* and they can then be scanned;
    %do %until ( %scan(&lagn,&z,%STR( ))= );
     %let token = %scan(&lagn,&z,%STR( ));
     %let z&z = &token;
     %let z=%EVAL(&z + 1);
    %end;
    %let z=%EVAL(&z - 1);

    %* there can be an arbitrary number of arrays if lagging n variables;
    %* so the following loop creates an arbitrary number of them;
    %let printarrays=;    

%do y=1 %to &z; 

    %* first the suffix, p1 for lead, m1 for lag;
    %* the desc variable is for sorting;
    %put &&z&y;
    %if &&z&y < 0 %then %do;
     %let k&y = %EVAL(&&z&y * -1);
     %let suf = p&&k&y;
     %let desc = descending;
    %end;
    %else %do;
     %let k&y = &&z&y;
     %let suf = m&&z&y;
     %let desc=;
    %end;

    %* now generate the variable lists for arrays with the lag suffix;
    %let varlag&y=;
    %let n=1;

    %do %until ( %scan(&var,&n)= );
     %let token = %scan(&var,&n);
     %let varlag&y = &&varlag&y &token&suf;
     %let n=%EVAL(&n + 1);
    %end;

    %* The final value is one too high, e.g. if there is only;
    %* token in the list, it is initialized to 1, is incremented to 2;
    %* and the loop stops;

    %let n=%eval(&n-1);

    %* generate the array statements for an arbitrary number of arrays;
    %let printarrays=%STR(&printarrays array varlist_lag&y{&n} &&varlag&y;);
    
%end;
%* ----------------------------------------------------------------;

%* ----------------------------------------------------------------;
%* Sort the data if necessary;
    %if &sorted = 0 %then %do;
        proc sort data = &ds;
         by &id &desc &yr;
        run;
    %end;
%* ----------------------------------------------------------------;

%* ----------------------------------------------------------------;
%* create code for the body of the data step: an arbitrary # of loops;

%let printloops=;

%do p=1 %to &z;

%let printloops=

%STR(
&printloops *CODE BLOCK &p;

     do i = 1 to &n;
         varlist_lag&p{i} = lag&&k&p(varlist{i});
     end;

        &id.L = lag&&k&p(&id);
        &yr.L = lag&&k&p(&yr) + &&z&p;

        make_missing&p = 0;

    if &chfyr=0 then do;
        if ( &id.L ne &id ) or ( &yr.L ne &yr ) then make_missing&p = 1;
    end;
    else if &chfyr=1 then do;
     fyrL = lag&&k&p(fyr);
        if ( &id.L ne &id ) or ( &yr.L ne &yr ) or ( fyrL ne fyr ) then make_missing&p = 1;
    end;

     if make_missing&p = 1 then do;
        do l = 1 to &n;
            varlist_lag&p{l} = .;
        end;
        end;

);

%end;
%* ----------------------------------------------------------------;

%* ----------------------------------------------------------------;
%* Finally the code that actually creates lags;
    data &ds;
     set &ds;
     array varlist{&n} &var;
     &printarrays;
     &printloops;
        drop i l &id.L &yr.L make_missing: fyrL tempid;
    run;
%* ----------------------------------------------------------------;

%mend lag3_yr;  



/*----------------------------------------------------------------
* Macro Name: lag2
* Created by Richard Price
* This macro creates lag values of the variables specified

* This is version 2: and is named lag2 for that reason.
* The previous version was awkward to use. I wrote it before I
* knew how to use the scan macro function in sas;
*
* There are some assumptions in this macro
* It assumes that you want to lag values where there is one unique
* identifier for each firm, e.g. GVKEY.

* And it assumes the time period is annual
* I will work on versions for quarterly and monthly data;

* input parameters
* ---------------------------------------------------------------
*   in:     input dataset
*   out:    output dataset, if you want, can be null
*   lagn:   the number of periods being lagged: positive for lags
*           negative for leads
*           THIS CAN BE A SEVERAL LAGS AS LONG AS THEY ARE ALL OF THE
*           SAME SIGN e.g.  lagn = 1 2 3 4 5 or lagn = -1 -2 -3 -4 -5
*   id:     the identifier for each firm, GVKEY, or CUSIP, or PERMNO
*   var:    the variable list to be lagged
*   sorted: 0 if unsorted (default value) anything else if already
*           sorted -- if doing multiple lags, it is more efficient
*           to sort outside of this macro
*   chfyr:  Checking changes in fiscal year.  If change in fiscal
*           year occurs, then first differences may not be meaningful.
*           If chfyr=0 then change in fiscal year is ignored, and lags
*           are created anyway.  If chfyr=1 then when the fiscal year
*           changes the lagged value is set to missing.
*           THIS ASSUMES THE FISCAL YEAR VARIABLE IS NAMED FYR, AS IS
*           THE DEFAULT IN WRDS COMPUSTAT.
*   charid: If the identifier for each firm is character data type
*           e.g. CUSIP, set this equal to 1.  The code will then
*           generate a numeric unique id.
*           Default value charid=0 (e.g. GVKEY or PERMNO)

* example: assumes an unsorted dataset named test exists with the
* following variables: GVKEY fyear (JHW changed from yeara here and below)
* FYR ca cl asset rev oibd dep

* this creates lagged values (suffix is m1 for minus 1); %lag3_yr(in=test, lagn=1 2 3 4, var=ca cl asset rev oibd dep);

* this creates lead values (suffix is p1 for plus 1); %lag3_yr(in=test, lagn=-1 -2 -3 -4, var=ca cl asset rev oibd dep);

* this creates lagged values, ensuring no change in fiscal year occurs; %lag3_yr(in=test, lagn=1 2 3 4, var=ca cl asset rev oibd dep, chfyr=1); ----------------------------------------------------------------*/


%macro lag3_yr_company_fkey(in=, out=, lagn=, id=company_fkey, yr=fyear, var=, sorted=0,
              chfyr=0, charid=0);

%* ----------------------------------------------------------------;
%* if output dataset is specified, set variable ds to this value;
    %if &out ne %then %do;
     %let ds=&out;
     data &ds; set &in; run;
    %end;
    %else %do;
     %let ds=&in;
    %end;
%* ----------------------------------------------------------------;

%* ----------------------------------------------------------------;
%* generate numeric id if necessary;
    %if &charid=1 %then %do;
     proc sql;
         create table tmpid as
         select count(&id) as ct, &id
           from &ds
           group by &id
           order by &id;

     data tmpid;
         set tmpid;
         tempid=_N_;
     run;

     proc sql;
         create table &ds as
         select d.*, t.tempid
           from &ds as d left join tempid as t
           on d.&id = t.&id;

     %let id=tempid;    
    %end;
%* ----------------------------------------------------------------;

%* ----------------------------------------------------------------;
%* Generate the strings containing lagged variable names;

    %* determine the number of lags to do;
    %* z is the total number of lags;
    %* z1... zn contain the actual values of the lag;
    %* e.g. z1=1 z2=2... or z1=-1 z2=-2;

    %let z=1;

    %* Note with the scan function there are three arguments;
    %* the third is the delimeter which can be:   ;
    %* blank . < ( + & ! $ * ) semicolon ^ - / , % |  ;
    %* and so negative numbers will not be scanned unless;
    %* a delimiter is specified.  I specify the blank;
    %* which is %STR( ), this frees up the other default delimiters;
    %* and they can then be scanned;
    %do %until ( %scan(&lagn,&z,%STR( ))= );
     %let token = %scan(&lagn,&z,%STR( ));
     %let z&z = &token;
     %let z=%EVAL(&z + 1);
    %end;
    %let z=%EVAL(&z - 1);

    %* there can be an arbitrary number of arrays if lagging n variables;
    %* so the following loop creates an arbitrary number of them;
    %let printarrays=;    

%do y=1 %to &z; 

    %* first the suffix, p1 for lead, m1 for lag;
    %* the desc variable is for sorting;
    %put &&z&y;
    %if &&z&y < 0 %then %do;
     %let k&y = %EVAL(&&z&y * -1);
     %let suf = p&&k&y;
     %let desc = descending;
    %end;
    %else %do;
     %let k&y = &&z&y;
     %let suf = m&&z&y;
     %let desc=;
    %end;

    %* now generate the variable lists for arrays with the lag suffix;
    %let varlag&y=;
    %let n=1;

    %do %until ( %scan(&var,&n)= );
     %let token = %scan(&var,&n);
     %let varlag&y = &&varlag&y &token&suf;
     %let n=%EVAL(&n + 1);
    %end;

    %* The final value is one too high, e.g. if there is only;
    %* token in the list, it is initialized to 1, is incremented to 2;
    %* and the loop stops;

    %let n=%eval(&n-1);

    %* generate the array statements for an arbitrary number of arrays;
    %let printarrays=%STR(&printarrays array varlist_lag&y{&n} &&varlag&y;);
    
%end;
%* ----------------------------------------------------------------;

%* ----------------------------------------------------------------;
%* Sort the data if necessary;
    %if &sorted = 0 %then %do;
        proc sort data = &ds;
         by &id &desc &yr;
        run;
    %end;
%* ----------------------------------------------------------------;

%* ----------------------------------------------------------------;
%* create code for the body of the data step: an arbitrary # of loops;

%let printloops=;

%do p=1 %to &z;

%let printloops=

%STR(
&printloops *CODE BLOCK &p;

     do i = 1 to &n;
         varlist_lag&p{i} = lag&&k&p(varlist{i});
     end;

        &id.L = lag&&k&p(&id);
        &yr.L = lag&&k&p(&yr) + &&z&p;

        make_missing&p = 0;

    if &chfyr=0 then do;
        if ( &id.L ne &id ) or ( &yr.L ne &yr ) then make_missing&p = 1;
    end;
    else if &chfyr=1 then do;
     fyrL = lag&&k&p(fyr);
        if ( &id.L ne &id ) or ( &yr.L ne &yr ) or ( fyrL ne fyr ) then make_missing&p = 1;
    end;

     if make_missing&p = 1 then do;
        do l = 1 to &n;
            varlist_lag&p{l} = .;
        end;
        end;

);

%end;
%* ----------------------------------------------------------------;

%* ----------------------------------------------------------------;
%* Finally the code that actually creates lags;
    data &ds;
     set &ds;
     array varlist{&n} &var;
     &printarrays;
     &printloops;
        drop i l &id.L &yr.L make_missing: fyrL tempid;
    run;
%* ----------------------------------------------------------------;

%mend lag3_yr;  

/* Clear log */

DM 'CLEAR LOG' continue;
DM 'CLEAR OUTPUT' continue;



