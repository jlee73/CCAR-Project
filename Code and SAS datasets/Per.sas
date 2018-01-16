libname myfolder 'D:\CCAR\';

options errors= 1;
options nocenter ps=52 errors=1 compress=yes obs=max;

** directory with performance and acquisition .txt files **;
%let directory = D:\CCAR\;

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
data temp (drop = x_zb_date x_period x_loan_age x_maturity_date x_adj_rem_months 
                  x_dlq_status x_lpi_dte x_fcc_dte x_disp_dte);
  infile "&directory.Performance_&quarter..txt" delimiter = '|' MISSOVER DSD lrecl=32767;
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
proc sort data = temp; by loan_id y_act_date; run;

data act ;
set temp (where = ("&fn_start."d<=y_act_date && y_act_date<= "&fn_end."d));
by loan_id y_act_date;
run;

%mend;
%LPPUB(2009Q1);
