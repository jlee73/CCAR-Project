data Acq2009q1n;
set Fim1.Acq2009q1;
where put(orig_dte,YYMMN6.)='200901';

run;
