/*************************************************************
Purpose : Import the CSV files into SAS using PROC IMPORT
Authors: James, Soumya, Danjun
Group : 4
Date : October 12, 2017
**************************************************************/

%let path = D:\CECL;

*Importing the base scenario data;
PROC IMPORT datafile = "&path\Table 1A Supervisory baseline scenario Domestic.csv"
        out = work.MEV_Base
        dbms = CSV
        replace;
run;

*Importing the adverse scenario data;
PROC IMPORT datafile = "&path\Table 2A Supervisory adverse scenario Domestic.csv"
        out = work.MEV_Adverse
        dbms = CSV
        replace;
run;

*Importing severely adverse data;
PROC IMPORT datafile = "&path\Table 3A Supervisory severely adverse scenario Domestic.csv"
        out = work.MEV_Severe
        dbms = CSV
        replace;
run;

*Importing historical data;
PROC IMPORT datafile = "&path\Supervisory historical Domestic.csv"
        out = work.MEV_Historical
        dbms = CSV
        replace;
run;

/*************************************************************
Purpose : Plot Macroeconomic Variable Datasets
Authors: James, Soumya, Danjun
Group : 4
Date : October 12, 2017
**************************************************************/

data base;
set work.MEV_Base;
group = "Base";
keep Date Unemployment_rate Mortgage_rate House_Price_Index__Level_ group;
run;
data adverse;
set work.MEV_Adverse;
group = "Adverse";
keep Date Unemployment_rate Mortgage_rate House_Price_Index__Level_ group;
run;
data severe;
set work.MEV_Severe;
group = "Severe";
keep Date Unemployment_rate Mortgage_rate House_Price_Index__Level_ group;
run;

data combine;
set base adverse severe;
run;

*Close all open ODS;
ods _all_ close;
ods pdf file = "D:\CECL\MEVplot";

PROC SGPLOT DATA = combine;
 SERIES X = Date Y = Unemployment_rate / group=group;
 TITLE 'Unemployment Rate Series Chart';
RUN;
PROC SGPLOT DATA = combine;
 SERIES X = Date Y = Mortgage_rate / group=group;
 TITLE 'Mortgage Rate Series Chart';
RUN;
PROC SGPLOT DATA = combine;
 SERIES X = Date Y =  House_Price_Index__Level_ / group=group;
 TITLE 'House Price Index Series Chart';
RUN;

ods pdf close;
