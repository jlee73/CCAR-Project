libname FIM1 'D:\CCAR';
data FIM1.step1;
set FIM1.Combine_2009q1; /*merged dataset*/
select (z_zb_code);
when ('03') output;
when ('09') output;
otherwise;
end;
run;

data FIM1.step2; /*step2 calculate costs and proceeds*/
set FIM1.step1;
ie_cost1=abs(ie_cost);
costs = sum(fcc_cost,pp_cost,ar_cost,ie_cost1,tax_cost);
proceeds = sum(ns_procs,ce_procs,rmw_procs,o_procs);
run;

PROC SQL;
	CREATE TABLE  FIM1.LGD_unsort as
	SELECT A.*, B.*
	FROM FIM1.step2 A LEFT JOIN FIM1.Ead3 B
	ON A.loan_id = B.loan_id
	ORDER BY A.loan_id;
QUIT;

data FIM1.LGD_unsort2(keep=loan_id orig_rt ocltv dti cscore_b purpose prop_typ num_unit occ_stat cscore_c y_act_date y_act_upb y_rem_mths z_zb_code fcc_cost pp_cost ar_cost ie_cost1 tax_cost ns_procs ce_procs rmw_procs o_procs House_Price_Index__Level_ Unemployment_rate Mortgage_rate costs proceeds _LABEL_ EAD1);
retain loan_id _LABEL_ orig_rt ocltv dti cscore_b cscore_c purpose prop_typ num_unit occ_stat House_Price_Index__Level_ Unemployment_rate Mortgage_rate y_act_upb y_rem_mths z_zb_code fcc_cost pp_cost ar_cost ie_cost1 tax_cost ns_procs ce_procs rmw_procs o_procs costs proceeds EAD1;
set FIM1.LGD_unsort(where=(EAD1 ne .));
run;


data FIM1.LGD (rename= (orig_rt=interest_rate ocltv=loan_to_value_ratio dti=deb_to_income_ratio cscore_b=borrower_FICO cscore_c=coborrower_FICO House_Price_Index__Level_=house_price_index _LABEL_=month));
set FIM1.LGD_unsort2;
run;
