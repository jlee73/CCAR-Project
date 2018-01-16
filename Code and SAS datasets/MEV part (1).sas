/*************************************************************
Purpose : Import the CSV files into SAS using PROC IMPORT
Authors: James, Soumya, Danjun
Group : 4
Date : October 12, 2017
**************************************************************/

*Create the library to store the datasets;
libname FIM1 "C:\Users\Soumya\Desktop\FIM500\CCAR_Project\Task 2";

/*Specify the filepath*/
%let path = C:\Users\&SYSUSERID\Desktop\FIM500\CCAR_Project\Task 2\MEV;

*Importing the base scenario data;
PROC IMPORT datafile = "&path\Table 1A Supervisory baseline scenario Domestic.csv"
        out = Fim1.MEV_Base
        dbms = CSV
        replace;
		
run;

*Importing the adverse scenario data;
PROC IMPORT datafile = "&path\Table 2A Supervisory adverse scenario Domestic.csv"
        out = Fim1.MEV_Adverse
        dbms = CSV
        replace;
		
run;

*Importing severely adverse data;
PROC IMPORT datafile = "&path\Table 3A Supervisory severely adverse scenario Domestic.csv"
        out = Fim1.MEV_Severe
        dbms = CSV
        replace;
		
run;

*Importing historical data;
PROC IMPORT datafile = "&path\Supervisory historical Domestic.csv"
        out = Fim1.MEV_Historical
        dbms = CSV
        replace;
run;

* Create a new datset- Mev.Base1 with only 3 variables and the formatted date values;
data Fim1.MEV_Base1(keep = House_Price_Index__Level_ Unemployment_rate Mortgage_rate);
 set Fim1.MEV_Base;
 Date_quar = YYQ(input(substr(Date,4,4),4.),input(substr(Date,2,1),1.));
run;

* Create a new datset- Mev.Adverse1 with only 3 variables and the formatted date values;
data Fim1.MEV_Adverse1(keep = House_Price_Index__Level_ Unemployment_rate Mortgage_rate);
 set Fim1.MEV_Adverse;
 Date_quar = YYQ(input(substr(Date,4,4),4.),input(substr(Date,2,1),1.));
run;

* Create a new datset- Mev.Severe1 with only 3 variables and the formatted date values;
data Fim1.MEV_Severe1(keep = House_Price_Index__Level_ Unemployment_rate Mortgage_rate);
 set Fim1.MEV_Severe;
 Date_quar = YYQ(input(substr(Date,4,4),4.),input(substr(Date,2,1),1.));
run;

* Create a new datset- Mev.Historical1 with only 3 variables and the formatted date values;
data Fim1.MEV_Historical1(keep = House_Price_Index__Level_ Unemployment_rate Mortgage_rate Date_Quar);
 set Fim1.MEV_Historical;
 Date_quar = YYQ(input(substr(Date,4,4),4.),input(substr(Date,2,1),1.));
run;

* Create a new dataset- MEv_Historical_monthly by interpolating the variable values;
proc expand data = Fim1.MEV_Historical1 out= Fim1.Historical_monthly from=qtr to=month;
   convert House_Price_Index__Level_ Unemployment_rate Mortgage_rate /observed=average;
   id Date_quar;
run;
