/**************************************************
Purpose: Import Performance_2009Q1.txt data to SAS
Group  : #4
Date   : 10/12/2017
**************************************************/


/* Specify the filepath*/
%let path = D:\CECL;
%let obs =max;

*Create the library to store the datasets;
libname FIM1 "D:\CECL";

data FIM1.Per2009Q1;
/* Specify the file and delimiter types*/
	infile "&path\Performance_2009Q1.txt" dlm ='|' dsd missover obs=10;

/* Specify the variables to be input in order*/
	input   loan_id :$12. 
				x_period :$10.
				y_servicer :$80.
				y_curr_rte 
				y_act_upb
				x_loan_age 
				y_rem_mths
				x_adj_rem_months
				x_maturity_date :$7.
				msa :$5.
				x_dlq_status :$3.
				y_mod_ind :$1.
				z_zb_code :$2.
				x_zb_date :$7.
				x_lpi_dte :$10.
				x_fcc_dte :$10.
				x_disp_dte :$10.
				fcc_cost 
				pp_cost 
				ar_cost 
				ie_cost 
				tax_cost 
				ns_procs 
				ce_procs 
				rmw_procs 
				o_procs
				non_int_upb
				prin_forg_upb_fhfa
				repch_flag  :$1.
				prin_forg_upb_o
				serv_transfer :$1.
				;


  format zb_dte mmddyy8.;
  zb_dte = mdy(input(substr(x_zb_date,1,2),2.),1,input(substr(x_zb_date,4,4),4.));

  format maturity_dte mmddyy8.;
  maturity_dte = mdy(input(substr(x_maturity_date,1,2),2.),1,input(substr(x_maturity_date,4,4),4.));

  format period mmddyy8.;
  period = mdy(input(substr(x_period,1,2),2.),1,input(substr(x_maturity_date,7,10),4.));

  format lpi_dte mmddyy8.;
  lpi_dte = mdy(input(substr(x_lpi_dte,1,2),2.),1,input(substr(x_lpi_dte,4,4),4.));

  format fcc_dte mmddyy8.;
  fcc_dte = mdy(input(substr(x_fcc_dte,1,2),2.),1,input(substr(x_fcc_dte,4,4),4.));

  format disp_dte mmddyy8.;
  disp_dte = mdy(input(substr(x_disp_dte,1,2),2.),1,input(substr(x_disp_dte,4,4),4.));

run;
/**Close all open ODS;
ods _all_ close;
ods pdf file = "D:\CECL\Per2009Q1_Task2.pdf";

*Create histogram of the numeric variables;
proc univariate data = FIM1.Per2009Q1 noprint;* to suppress summary statistics;
histogram fcc_cost ns_procs;
label fcc_cost = 'Forclosure Cost'
         ns_procs = ' Net Sales Proceed'
	 ;
run;

*Create the frequency table of the following categorical variables;
 proc freq data = FIM1.Per2009Q1;
    tables x_dlq_status z_zb_code;
	run;

 ods pdf close;
  
*/
