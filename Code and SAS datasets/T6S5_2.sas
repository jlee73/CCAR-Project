proc sort DATA=FIM1.PD;
   by loan_id decending y_rem_mths;
RUN;
DATA FIM1.PD_def;
    SET FIM1.Pd;
    IF (Default eq 1) THEN OUTPUT;
RUN;
DATA FIM1.PD_nondef(rename=(y_rem_mths=Remain_months house_price_index=HPI Unemployment_rate=Unemploy_rate Mortgage_rate=Mort_rate Default=Def));
    SET FIM1.Pd;
    IF (Default eq 1) THEN DELETE;
RUN;
PROC SQL;
	CREATE TABLE  Fim1.PD_def_all as
	SELECT A.*, B.*
	FROM Fim1.PD_def A INNER JOIN Fim1.PD_nondef B
	ON A.loan_id = B.loan_id
	ORDER BY A.loan_id;
QUIT;
proc sort DATA=FIM1.PD_def_all;
   by loan_id decending Remain_months;
RUN;
DATA FIM1.PD_def_all_1 (drop=y_rem_mths Default house_price_index Unemployment_rate Mortgage_rate);
set FIM1.PD_def_all;
by loan_id descending Remain_months;
run;


PROC SURVEYSELECT DATA=FIM1.PD_nondef OUT=FIM1.PD_ndsample METHOD=SRS
  SAMPSIZE=2033 SEED=1;
  RUN;
