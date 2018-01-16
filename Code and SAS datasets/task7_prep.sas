libname FIM1 'D:\CCAR';
data FIM1.PD_unsort2_2(keep=loan_id orig_rt ocltv dti cscore_b purpose prop_typ num_unit occ_stat cscore_c House_Price_Index__Level_ Unemployment_rate Mortgage_rate costs Default);
set FIM1.LGD_forecastdata;
retain loan_id orig_rt ocltv dti cscore_b cscore_c purpose prop_typ num_unit occ_stat House_Price_Index__Level_ Unemployment_rate Mortgage_rate Default;
run;


data FIM1.PD_2 (rename= (orig_rt=interest_rate ocltv=loan_to_value_ratio dti=deb_to_income_ratio cscore_b=borrower_FICO cscore_c=coborrower_FICO House_Price_Index__Level_=house_price_index));
set FIM1.PD_unsort2_2;
run;

/* 666666666666666666666666666666666666666666666666666666666666 */

data FIM1.PD_unsort2_base(keep=loan_id orig_rt ocltv dti cscore_b purpose prop_typ num_unit occ_stat cscore_c base_HPI base_unemploment_rate base_Mortgage_rate remain_mth);
set FIM1.LGD_forecastdata;
retain loan_id orig_rt ocltv dti cscore_b cscore_c purpose prop_typ num_unit occ_stat base_HPI base_unemploment_rate base_Mortgage_rate;
run;


data FIM1.PD_base (rename= (orig_rt=interest_rate ocltv=loan_to_value_ratio dti=deb_to_income_ratio cscore_b=borrower_FICO cscore_c=coborrower_FICO base_HPI=house_price_index base_unemploment_rate=Unemployment_rate base_Mortgage_rate=Mortgage_rate));
set FIM1.PD_unsort2_base;
run;


/*66666666666666666666666666666666666666666666666666666666666666*/

data FIM1.PD_unsort2_adverse(keep=loan_id orig_rt ocltv dti cscore_b purpose prop_typ num_unit occ_stat cscore_c adverse_HPI adverse_unemploment_rate adverse_Mortgage_rate remain_mth);
set FIM1.LGD_forecastdata;
retain loan_id orig_rt ocltv dti cscore_b cscore_c purpose prop_typ num_unit occ_stat adverse_HPI adverse_unemploment_rate adverse_Mortgage_rate;
run;


data FIM1.PD_adverse (rename= (orig_rt=interest_rate ocltv=loan_to_value_ratio dti=deb_to_income_ratio cscore_b=borrower_FICO cscore_c=coborrower_FICO adverse_HPI=house_price_index adverse_unemploment_rate=Unemployment_rate adverse_Mortgage_rate=Mortgage_rate));
set FIM1.PD_unsort2_adverse;
run;

/*66666666666666666666666666666666666666666666666666666666666666666666666666666666*/

data FIM1.PD_unsort2_severe(keep=loan_id orig_rt ocltv dti cscore_b purpose prop_typ num_unit occ_stat cscore_c severe_HPI severe_unemploment_rate severe_Mortgage_rate remain_mth);
set FIM1.LGD_forecastdata;
retain loan_id orig_rt ocltv dti cscore_b cscore_c purpose prop_typ num_unit occ_stat severe_HPI severe_unemploment_rate severe_Mortgage_rate remain_mth;
run;


data FIM1.PD_severe (rename= (orig_rt=interest_rate ocltv=loan_to_value_ratio dti=deb_to_income_ratio cscore_b=borrower_FICO cscore_c=coborrower_FICO severe_HPI=house_price_index severe_unemploment_rate=Unemployment_rate severe_Mortgage_rate=Mortgage_rate));
set FIM1.PD_unsort2_severe;
run;

/*7777777777777777777777777777777777777777777777777777777777777777777777777777777777777*/

data FIM1.PD_sample_catg_base;
set FIM1.PD_base;
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

If borrower_FICO<=645 	       then fico_300_645=1;else fico_300_645=0;
If 645<borrower_FICO<=685 then fico_645_685=1;else fico_645_685=0;
If 685<borrower_FICO<=730 then fico_685_730=1;else fico_685_730=0;
If 730<borrower_FICO<=765 then fico_730_765=1;else fico_730_765=0;
If 765<borrower_FICO<=790 then fico_765_790=1;else fico_765_790=0;
If 790<borrower_FICO              then fico_790_850=1;else fico_790_850=0;

If 0<deb_to_income_ratio<=21   then dti_00_21=1;    else dti_00_21=0;
If 21<deb_to_income_ratio<=27   then dti_21_27=1;    else dti_21_27=0;
If 27<deb_to_income_ratio<=34   then dti_27_34=1;    else dti_27_34=0;
If 34<deb_to_income_ratio<=41   then dti_34_41=1;    else dti_34_41=0;
If 41<deb_to_income_ratio<=47   then dti_41_47=1;    else dti_41_47=0;
If 47<deb_to_income_ratio<=100 then dti_47_100=1; else dti_47_100=0;

If 0<loan_to_value_ratio<=90   then ltv_00_90=1;    else ltv_00_90=0;
If 90<loan_to_value_ratio<=95   then ltv_90_95=1;    else ltv_90_95=0;
If 95<loan_to_value_ratio<=97   then ltv_95_97=1;    else ltv_95_97=0;
If 97<loan_to_value_ratio<=103   then ltv_97_103=1;    else ltv_97_103=0;
If 103<loan_to_value_ratio<=120   then ltv_103_120=1;    else ltv_103_120=0;
If 120<loan_to_value_ratio<=150 then ltv_120_150=1; else ltv_120_150=0;
run;

/*7777777777777777777777777777777777777777777777777777777777777777777777777777777777777*/

data FIM1.PD_sample_catg_adverse;
set FIM1.PD_adverse;
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

If borrower_FICO<=645 	       then fico_300_645=1;else fico_300_645=0;
If 645<borrower_FICO<=685 then fico_645_685=1;else fico_645_685=0;
If 685<borrower_FICO<=730 then fico_685_730=1;else fico_685_730=0;
If 730<borrower_FICO<=765 then fico_730_765=1;else fico_730_765=0;
If 765<borrower_FICO<=790 then fico_765_790=1;else fico_765_790=0;
If 790<borrower_FICO              then fico_790_850=1;else fico_790_850=0;

If 0<deb_to_income_ratio<=21   then dti_00_21=1;    else dti_00_21=0;
If 21<deb_to_income_ratio<=27   then dti_21_27=1;    else dti_21_27=0;
If 27<deb_to_income_ratio<=34   then dti_27_34=1;    else dti_27_34=0;
If 34<deb_to_income_ratio<=41   then dti_34_41=1;    else dti_34_41=0;
If 41<deb_to_income_ratio<=47   then dti_41_47=1;    else dti_41_47=0;
If 47<deb_to_income_ratio<=100 then dti_47_100=1; else dti_47_100=0;

If 0<loan_to_value_ratio<=90   then ltv_00_90=1;    else ltv_00_90=0;
If 90<loan_to_value_ratio<=95   then ltv_90_95=1;    else ltv_90_95=0;
If 95<loan_to_value_ratio<=97   then ltv_95_97=1;    else ltv_95_97=0;
If 97<loan_to_value_ratio<=103   then ltv_97_103=1;    else ltv_97_103=0;
If 103<loan_to_value_ratio<=120   then ltv_103_120=1;    else ltv_103_120=0;
If 120<loan_to_value_ratio<=150 then ltv_120_150=1; else ltv_120_150=0;
run;

/*7777777777777777777777777777777777777777777777777777777777777777777777777777777777777*/

data FIM1.PD_sample_catg_severe;
set FIM1.PD_severe;
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

If borrower_FICO<=645 	       then fico_300_645=1;else fico_300_645=0;
If 645<borrower_FICO<=685 then fico_645_685=1;else fico_645_685=0;
If 685<borrower_FICO<=730 then fico_685_730=1;else fico_685_730=0;
If 730<borrower_FICO<=765 then fico_730_765=1;else fico_730_765=0;
If 765<borrower_FICO<=790 then fico_765_790=1;else fico_765_790=0;
If 790<borrower_FICO              then fico_790_850=1;else fico_790_850=0;

If 0<deb_to_income_ratio<=21   then dti_00_21=1;    else dti_00_21=0;
If 21<deb_to_income_ratio<=27   then dti_21_27=1;    else dti_21_27=0;
If 27<deb_to_income_ratio<=34   then dti_27_34=1;    else dti_27_34=0;
If 34<deb_to_income_ratio<=41   then dti_34_41=1;    else dti_34_41=0;
If 41<deb_to_income_ratio<=47   then dti_41_47=1;    else dti_41_47=0;
If 47<deb_to_income_ratio<=100 then dti_47_100=1; else dti_47_100=0;

If 0<loan_to_value_ratio<=90   then ltv_00_90=1;    else ltv_00_90=0;
If 90<loan_to_value_ratio<=95   then ltv_90_95=1;    else ltv_90_95=0;
If 95<loan_to_value_ratio<=97   then ltv_95_97=1;    else ltv_95_97=0;
If 97<loan_to_value_ratio<=103   then ltv_97_103=1;    else ltv_97_103=0;
If 103<loan_to_value_ratio<=120   then ltv_103_120=1;    else ltv_103_120=0;
If 120<loan_to_value_ratio<=150 then ltv_120_150=1; else ltv_120_150=0;
run;

