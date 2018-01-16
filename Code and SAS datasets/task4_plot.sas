data Fim1.plot;
 set Fim1.EAD1 (keep= loan_id EAD2-EAD27 firstobs=41494);
run;
proc transpose data=Fim1.plot out=Fim1.plot2 (drop=_NAME_ ) prefix=EAD;
label EAD2=01;
label EAD3=02;
label EAD4=03;
label EAD5=04;
label EAD6=05;
label EAD7=06;
label EAD8=07;
label EAD9=08;
label EAD10=09;
label EAD11=10;
label EAD12=11;
label EAD13=12;
label EAD14=13;
label EAD15=14;
label EAD16=15;
label EAD17=16;
label EAD18=17;
label EAD19=18;
label EAD20=19;
label EAD21=20;
label EAD22=21;
label EAD23=22;
label EAD24=23;
label EAD25=24;
label EAD26=25;
label EAD27=26;
label _LABEL_ = "Month";
run;
symbol1 interpol=join;
proc gplot data= Fim1.plot2;
   plot EAD1*_LABEL_;
   title'Total EAD by Time from Jan 2016-Mar2018';
 axis1 label=('Month')
          order=('01feb16'd to'01mar18'd by month);
 axis2 label=(angle=90 'Total EAD');
run;
quit;