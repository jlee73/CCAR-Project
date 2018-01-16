/**************************************************
Purpose: Import Accquisition_2009Q1.txt data to SAS
Group  : #4
Date   : 10/12/2017
**************************************************/

*Create the library to store the datasets;
libname Fim1 "D:\CCAR\";

/*Specify the filepath*/
%let path = D:\CCAR\;

data Fim1.Acq2009Q1;
/* Length adjusted to incorporate larger data */
	length loan_id $ 20
		   orig_chn $ 1
		   seller $ 140;

/* Specify the file and delimiter types*/
	infile "&path.Acquisition_2009Q1.txt" dlm ='|' dsd ;

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
data Fim1.Acq2009q1n;
set Fim1.Acq2009q1;
where put(orig_dte,YYMMN6.)='200901';
format orig_dte MONYY7.;
run;

*-----------------------------------------------------------------------------------------------------*;
options errors= 1;
options nocenter ps=52 errors=1 compress=yes obs=max;

%let fn_start = 01FEB2009;

%let fn_end = 31DEC2016;   **Set To Final Activity Month of LPPUB     **;

%let perf_head = 
loan_id :$12. 
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
X_LPI_dte :$10.
X_fcc_dte :$10.
X_disp_dte :$10.
fcc_cost
pp_cost
ar_cost
ie_cost
tax_cost
ns_procs
ce_procs
rmw_procs
o_procs
y_non_int_upb
y_prin_forg_upb_fhfa
repch_flg: $1.
y_prin_forg_upb_o
transfer_flg :$1.
;

%macro lppub (quarter);
*****************************************;
** upload and format acquisition files **;
*****************************************;
data Fim1.temp (drop =x_period x_zb_date x_loan_age x_maturity_date x_adj_rem_months 
                  x_dlq_status x_lpi_dte x_fcc_dte x_disp_dte);
  infile "&path.Performance_&quarter..txt" delimiter = '|' MISSOVER DSD lrecl=32767;
  input &perf_head;
    
   *Converting dates from mm/yyyy to SAS Date;
   format y_act_date z_zb_date lpi_dte fcc_dte disp_dte y_maturity_date mmddyy8.;
   z_zb_date = mdy(input(substr(x_zb_date,1,2),2.),1,input(substr(x_zb_date,4,4),4.));
   
   *Converting dates from MM/DD/YYYY to SAS Date;
   y_act_date = mdy(input(substr(x_period,1,2),2.),1,input(substr(x_period,7,4),4.));
   lpi_dte = mdy(input(substr(x_lpi_dte,1,2),2.),1,input(substr(x_lpi_dte,7,4),4.));
   fcc_dte = mdy(input(substr(x_fcc_dte,1,2),2.),1,input(substr(x_fcc_dte,7,4),4.));
   disp_dte = mdy(input(substr(x_disp_dte,1,2),2.),1,input(substr(x_disp_dte,7,4),4.));
   y_maturity_date = mdy(input(substr(x_maturity_date,1,2),2.),1,input(substr(x_maturity_date,4,4),4.)); 
   
   *To convert delinquency status to numeric, we set 'X' values to '999';
   if x_dlq_status = 'X' then delinquency_status = 999;
   else delinquency_status = x_dlq_status*1;

run;

*sorting loans by activity date to keep in chronological order;
proc sort data = Fim1.temp; by loan_id y_act_date; run;

data Fim1.Per2009Q1 ;
set Fim1.temp (where = ("&fn_start."d<=y_act_date && y_act_date<= "&fn_end."d));
by loan_id y_act_date;
run;

%mend;
%LPPUB(2009Q1);
/*************************************************************
Purpose : Import the CSV files into SAS using PROC IMPORT
Authors: James, Soumya, Danjun
Group : 4
Date : October 12, 2017
**************************************************************/
*Importing the base scenario data;
PROC IMPORT datafile = "&path.Table 1A Supervisory baseline scenario Domestic.csv"
        out = Fim1.MEV_Base
        dbms = CSV
        replace;
		
run;

*Importing the adverse scenario data;
PROC IMPORT datafile = "&path.Table 2A Supervisory adverse scenario Domestic.csv"
        out = Fim1.MEV_Adverse
        dbms = CSV
        replace;
		
run;

*Importing severely adverse data;
PROC IMPORT datafile = "&path.Table 3A Supervisory severely adverse scenario Domestic.csv"
        out = Fim1.MEV_Severe
        dbms = CSV
        replace;
		
run;

*Importing historical data;
PROC IMPORT datafile = "&path.Historic_Domestic.csv"
        out = Fim1.MEV_Historical
        dbms = CSV
        replace;
run;

* Create a new datset- Mev.Base1 with only 3 variables and the formatted date values;
data Fim1.MEV_Base1(keep = House_Price_Index__Level_ Unemployment_rate Mortgage_rate Date_Quar);
 set Fim1.MEV_Base;
 Date_quar = YYQ(input(substr(Date,4,4),4.),input(substr(Date,2,1),1.));
run;

* Create a new datset- Mev.Adverse1 with only 3 variables and the formatted date values;
data Fim1.MEV_Adverse1(keep = House_Price_Index__Level_ Unemployment_rate Mortgage_rate Date_Quar);
 set Fim1.MEV_Adverse;
 Date_quar = YYQ(input(substr(Date,4,4),4.),input(substr(Date,2,1),1.));
run;

* Create a new datset- Mev.Severe1 with only 3 variables and the formatted date values;
data Fim1.MEV_Severe1(keep = House_Price_Index__Level_ Unemployment_rate Mortgage_rate Date_Quar);
 set Fim1.MEV_Severe;
 Date_quar = YYQ(input(substr(Date,4,4),4.),input(substr(Date,2,1),1.));
run;

* Create a new datset- Mev.Historical1 with only 3 variables and the formatted date values;
data Fim1.MEV_Historical1(keep = House_Price_Index__Level_ Unemployment_rate Mortgage_rate Date_Quar);
 set Fim1.MEV_Historical;
 Date_quar = YYQ(input(substr(Date,1,4),4.),input(substr(Date,7,1),1.));
run;

* Create a new dataset- MEv_Historical_monthly by interpolating the variable values;
proc expand data = Fim1.MEV_Historical1 out= Fim1.Historical_monthly from=qtr to=month;
   convert House_Price_Index__Level_ Unemployment_rate Mortgage_rate /observed=average;
   id Date_quar;
run;
* Create a new dataset- MEV_Severe2 by interpolating the variable values;
proc expand data = Fim1.MEV_Severe1 out= Fim1.MEV_Severe2 from=qtr to=month;
   convert House_Price_Index__Level_ Unemployment_rate Mortgage_rate /observed=average;
   id Date_quar;
run;
* Create a new dataset- MEV_Adverse2 by interpolating the variable values;
proc expand data = Fim1.MEV_Adverse1 out= Fim1.MEV_Adverse2 from=qtr to=month;
   convert House_Price_Index__Level_ Unemployment_rate Mortgage_rate /observed=average;
   id Date_quar;
run;
* Create a new dataset- MEV_Base2 by interpolating the variable values;
proc expand data = Fim1.MEV_Base1 out= Fim1.MEV_Base2 from=qtr to=month;
   convert House_Price_Index__Level_ Unemployment_rate Mortgage_rate /observed=average;
   id Date_quar;
run;

PROC SQL;
	CREATE TABLE  Fim1.Mortgage_2009Q1 as
	SELECT A.*, B.*
	FROM Fim1.Acq2009Q1n A LEFT JOIN Fim1.Per2009Q1 B
	ON A.loan_id = B.loan_id
	ORDER BY A.loan_id;
QUIT;


PROC SQL;
	CREATE TABLE  Fim1.Combine_2009Q1 as
	SELECT A.*, B.*
	FROM Fim1.Mortgage_2009Q1 A LEFT JOIN Fim1.Historical_monthly B
	ON A.y_act_date = B.Date_quar
	ORDER BY A.loan_id;
QUIT;

PROC SQL;
	CREATE TABLE  Fim1.Combine_2009Q1_servere as
	SELECT A.*, B.*
	FROM Fim1.Mortgage_2009Q1 A LEFT JOIN Fim1.MEV_Severe2 B
	ON A.y_act_date = B.Date_quar
	ORDER BY A.loan_id;
QUIT;
PROC SQL;
	CREATE TABLE  Fim1.Combine_2009Q1_adverse as
	SELECT A.*, B.*
	FROM Fim1.Mortgage_2009Q1 A LEFT JOIN Fim1.MEV_Adverse2 B
	ON A.y_act_date = B.Date_quar
	ORDER BY A.loan_id;
QUIT;
PROC SQL;
	CREATE TABLE  Fim1.Combine_2009Q1_base as
	SELECT A.*, B.*
	FROM Fim1.Mortgage_2009Q1 A LEFT JOIN Fim1.MEV_Base2 B
	ON A.y_act_date = B.Date_quar
	ORDER BY A.loan_id;
QUIT;
   proc sql;
		describe table Fim1.Combine_2009Q1; 
	   quit;
