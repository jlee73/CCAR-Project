data Tmp1.Ead4;
set Tmp1.Ead3;
date=input(_LABEL_,Monyy7.);
format date monyy7.;
drop _LABEL_;
run;

/* merge acquisition */
PROC SQL;
	CREATE TABLE  Tmp1.LGD_forecastdata0 as
	SELECT A.*, B.*
	FROM Tmp1.Ead4 A LEFT JOIN Tmp1.Acq2009q1 B
	ON A.loan_id = B.loan_id
	ORDER BY A.loan_id, A.date; 
QUIT;

/* merge MEV_base */
PROC SQL;
	CREATE TABLE  Tmp1.LGD_forecastdata1 as
	SELECT A.*, B.*
	FROM Tmp1.LGD_forecastdata0 A LEFT JOIN Tmp1.Mev_base2 B
	ON A.date = B.Date_quar
	ORDER BY A.loan_id, A.date; 
QUIT;

data Tmp1.LGD_forecastdata2;
set Tmp1.LGD_forecastdata1;
rename House_Price_Index__Level_=base_HPI
		Unemployment_rate=base_unemployment_rate
		Mortgage_rate=base_Mortgage_rate;
run;

/*merge Mev_severe */
PROC SQL;
	CREATE TABLE  Tmp1.LGD_forecastdata3 as
	SELECT A.*, B.*
	FROM Tmp1.LGD_forecastdata2 A LEFT JOIN Tmp1.Mev_severe2 B
	ON A.date = B.Date_quar
	ORDER BY A.loan_id, A.date; 
QUIT;

data Tmp1.LGD_forecastdata4;
set Tmp1.LGD_forecastdata3;
rename House_Price_Index__Level_=severe_HPI
		Unemployment_rate=severe_unemployment_rate
		Mortgage_rate=severe_Mortgage_rate;
run;

/*merge Mev_adverse */
PROC SQL;
	CREATE TABLE  Tmp1.LGD_forecastdata5 as
	SELECT A.*, B.*
	FROM Tmp1.LGD_forecastdata4 A LEFT JOIN Tmp1.Mev_adverse2 B
	ON A.date = B.Date_quar
	ORDER BY A.loan_id, A.date; 
QUIT;

data Tmp1.LGD_forecastdata6;
set Tmp1.LGD_forecastdata5;
rename House_Price_Index__Level_=adverse_HPI
		Unemployment_rate=adverse_unemployment_rate
		Mortgage_rate=adverse_Mortgage_rate;
run;


/*merge remaining month */
data Tmp1.LGD_forecastdata;
   merge Tmp1.LGD_forecastdata6 Tmp1.Ead5(drop=loan_id EAD1 date y_rem_mths i);
run;


/*replace the missing value with means.  */
proc standard data=Tmp1.LGD_forecastdata out=Tmp1.forecastreplace replace print; 
run;


data Tmp1.lgd_fore_final;
set Tmp1.forecastreplace; /*merged dataset*/
cluster1=0;
cluster2=0;
select (state);
when ('IL') 
	cluster1 = 1;

when ('CA','FL', 'GA', 'MI', 'NC', 'NJ', 'TX', 'WA', 'WI') 
	cluster2=1 ;
otherwise;
end;

If purpose="P" then Purpose_Purchase = 1 ;else Purpose_Purchase = 0;
If purpose="R" then Purpose_Refinance = 1; else Purpose_Refinance = 0;
If purpose="C" then Purpose_Cashout = 1 ;else Purpose_Cashout = 0;
If purpose="U" then Purpose_Unidentify = 1 ;else Purpose_Unidentify = 0;

If prop_typ="SF" then prop_typ_SingleF = 1 ;else prop_typ_SingleF = 0;
If prop_typ="CO" then prop_typ_Condo = 1 ;else prop_typ_Condo = 0;
If prop_typ="CP" then prop_typ_Coop = 1 ;else prop_typ_Coop = 0;
If prop_typ="MH" then prop_typ_Manifacture = 1 ;else prop_typ_Manifacture = 0;
If prop_typ="PU" then prop_typ_Planned = 1 ;else prop_typ_Planned = 0;

If occ_stat="P" then occ_stat_principal = 1 ;else occ_stat_principal = 0;
If occ_stat="S" then occ_stat_second = 1 ;else occ_stat_second = 0;
If occ_stat="I" then occ_stat_investor = 1 ;else occ_stat_investor = 0;
If occ_stat="U" then occ_stat_unknown = 1; else occ_stat_unknown = 0;
run;

data Tmp1.LGD_fore_base;
set Tmp1.lgd_fore_final;
rename base_HPI=House_Price_Index__Level_
		base_Mortgage_rate=Mortgage_rate
		base_Unemployment_rate=Unemployment_rate
		EAD1=y_act_upb
		remain_mth=y_rem_mths;
run;

data Tmp1.LGD_fore_severe;
set Tmp1.lgd_fore_final;
rename severe_HPI=House_Price_Index__Level_
		severe_Mortgage_rate=Mortgage_rate
		severe_Unemployment_rate=Unemployment_rate
		EAD1=y_act_upb
		remain_mth=y_rem_mths;
run;


data Tmp1.LGD_fore_adverse;
set Tmp1.lgd_fore_final;
rename adverse_HPI=House_Price_Index__Level_
		adverse_Mortgage_rate=Mortgage_rate
		adverse_Unemployment_rate=Unemployment_rate
		EAD1=y_act_upb
		remain_mth=y_rem_mths;
run;


/*
data Tmp1.LGD_unsort2;
retain loan_id _LABEL_ orig_rt ocltv dti cscore_b cscore_c purpose prop_typ num_unit occ_stat House_Price_Index__Level_ Unemployment_rate Mortgage_rate y_act_upb y_rem_mths z_zb_code fcc_cost pp_cost ar_cost ie_cost1 tax_cost ns_procs ce_procs rmw_procs o_procs costs proceeds EAD1;
set Tmp1.LGD_unsort(where=(EAD1 ne .));
run;


data Tmp1.LGDnew;
set Tmp1.LGD_unsort2;
run;

*/
