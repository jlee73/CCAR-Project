
PROC SQL;
	CREATE TABLE  FIM1.LGD_FF0 as
	SELECT A.*, B.y_rem_mths
	FROM Fim1.LGD_forecastdata6 A LEFT JOIN Fim1.EAD1 B
	ON A.loan_id = B.loan_id
	ORDER BY A.loan_id;
QUIT;

proc sort data=FIM1.LGD_FF0;
by loan_id date;
run;

data FIM1.LGD_FF0;
set FIM1.LGD_FF0;
by loan_id date;
if first.loan_id then
do;
do i = 1 to 27;	
        remain_mth=y_rem_mths - i ;
output;
end;
end;
run;
