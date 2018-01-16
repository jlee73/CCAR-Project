data Fim1.EAD2;
set Fim1.EAD1 (keep= loan_id UPB1-UPB27);
run;

data fim1.test;
	length period $ 10.;
   infile datalines delimiter=','; 
   input period $;
   datalines;                      
 12/01/2015
;

data fim1.test;
	set fim1.test;
   forecast_Month = mdy(input(substr(period,1,2),2.),1,input(substr(period,7,4),4.));
   format  forecast_Month date9.;
run;

data fim1.EAD_Summary;
	set fim1.test ;
	do i = 1 to 27;
	forecast_date=intnx('month',forecast_month,i);
	output;
	end;
	format forecast_date monyy.;
	keep forecast_date;
run;

proc sql noprint;
   	select distinct forecast_date
      into :macro_month separated by '-'
	from fim1.EAD_Summary;
quit;

%put &macro_month; 

%macro loop;
proc transpose data=Fim1.EAD2 out=Fim1.EAD4 (drop=_NAME_ ) prefix=EAD;
by loan_id;

%local i next_name;
%let i=1;
%do %while (%scan(&macro_month, &i) ne );
   %let month = %scan(&macro_month, &i);
   label UPB&i="&month";
   %let i = %eval(&i + 1);
%end;

label _LABEL_ = "Month";
run;
%mend;
%loop;

