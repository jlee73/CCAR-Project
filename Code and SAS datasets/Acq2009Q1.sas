/**************************************************
Purpose: Import Accquisition_2009Q1.txt data to SAS
Group  : #4
Date   : 10/12/2017
**************************************************/

*Create the library to store the datasets;
libname FIM1 "C:\Users\Soumya\Desktop\FIM500\CCAR_Project\Task 2";

/*Specify the filepath*/
%let path = C:\Users\&SYSUSERID\Desktop\FIM500\CCAR_Project\Task 2;

data FIM1.Acq2009Q1;
/* Length adjusted to incorporate larger data */
	length loan_id $ 20
		   orig_chn $ 1
		   seller $ 140;

/* Specify the file and delimiter types*/
	infile "&path\Acquisition_2009Q1.txt" dlm ='|' dsd;

/* Specify the variables to be input in order*/
	input   loan_id $
			orig_chn $ 
			seller $ 
			orig_rt
			orig_amt
			orig_trm
			x_orig_date $ 
			x_first_pay $ 
			oltv
			ocltv
			num_bo
			dti
			cscore_b
			fthb_flg $ 
			purpose $ 
			prop_typ $
			num_unit
			occ_stat $ 
			state $ 
			zip_3 $ 
			mi_pct
			x_prod_type $
			cscore_c
			mi_type
			relo_flg $;

* Format the Original date and firstpay date values to mmddyy8. and convert them to numeric;
  format orig_dte mmddyy8.;
  orig_dte = mdy(input(substr(x_orig_date,1,2),2.),1,input(substr(x_orig_date,4,4),4.));

  format firstpay_dte mmddyy8.;
  firstpay_dte = mdy(input(substr(x_first_pay,1,2),2.),1,input(substr(x_first_pay,4,4),4.));
  
run;
*Close all open ODS;
ods _all_ close;
ods pdf file = "C:\Users\Soumya\Desktop\FIM500\CCAR_Project\Task 2\Acq2009Q1_Task2";


*Create histogram of the numeric variables;
proc univariate data = FIM1.Acq2009Q1 noprint;* to suppress summary statistics;
histogram dti oltv cscore_b orig_amt;
label dti = 'Debt to Income(DTI)'
      oltv = ' Loan to value(LTV)'
	  cscore_b = 'FICO score'
	  orig_amt = 'Original Unpaid Balance'
	 ;
run;

*Create the frequency table of the following categorical variables;
 proc freq data = FIM1.Acq2009Q1;
    tables prop_typ occ_stat purpose num_unit orig_chn fthb_flg orig_dte firstpay_dte;
	run;

 ods pdf close;
  
