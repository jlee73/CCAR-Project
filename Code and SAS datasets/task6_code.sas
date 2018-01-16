libname FIM1 'D:\CCAR';
data FIM1.PD_unsort1;
set FIM1.Combine_2009q1; /*merged dataset*/
Default=(z_zb_code in('03','09'));
run;
data FIM1.PD_unsort2(keep=loan_id orig_rt ocltv dti cscore_b purpose prop_typ num_unit occ_stat cscore_c House_Price_Index__Level_ Unemployment_rate Mortgage_rate costs Default);
set FIM1.PD_unsort1;
retain loan_id orig_rt ocltv dti cscore_b cscore_c purpose prop_typ num_unit occ_stat House_Price_Index__Level_ Unemployment_rate Mortgage_rate Default;
run;


data FIM1.PD (rename= (orig_rt=interest_rate ocltv=loan_to_value_ratio dti=deb_to_income_ratio cscore_b=borrower_FICO cscore_c=coborrower_FICO House_Price_Index__Level_=house_price_index));
set FIM1.PD_unsort2;
run;

proc corr data=FIM1.PD plots(maxpoints=50000)=matrix(histogram);
var interest_rate loan_to_value_ratio deb_to_income_ratio borrower_FICO house_price_index;
with Default;
run;

/* 666666666666666666666666666666666666666666666666666 */

data FIM1.PD_unsort1_base;
set FIM1.Combine_2009q1_base; /*merged dataset*/
Default=(z_zb_code in('03','09'));
run;
data FIM1.PD_unsort2_base(keep=loan_id orig_rt ocltv dti cscore_b purpose prop_typ num_unit occ_stat cscore_c House_Price_Index__Level_ Unemployment_rate Mortgage_rate costs Default);
set FIM1.PD_unsort1_base;
retain loan_id orig_rt ocltv dti cscore_b cscore_c purpose prop_typ num_unit occ_stat House_Price_Index__Level_ Unemployment_rate Mortgage_rate Default;
run;


data FIM1.PD_base (rename= (orig_rt=interest_rate ocltv=loan_to_value_ratio dti=deb_to_income_ratio cscore_b=borrower_FICO cscore_c=coborrower_FICO House_Price_Index__Level_=house_price_index));
set FIM1.PD_unsort2_base;
run;


/*66666666666666666666666666666666666666666666666666666666666666*/

data FIM1.PD_unsort1_adverse;
set FIM1.Combine_2009q1_adverse; /*merged dataset*/
Default=(z_zb_code in('03','09'));
run;
data FIM1.PD_unsort2_adverse(keep=loan_id orig_rt ocltv dti cscore_b purpose prop_typ num_unit occ_stat cscore_c House_Price_Index__Level_ Unemployment_rate Mortgage_rate costs Default);
set FIM1.PD_unsort1_adverse;
retain loan_id orig_rt ocltv dti cscore_b cscore_c purpose prop_typ num_unit occ_stat House_Price_Index__Level_ Unemployment_rate Mortgage_rate Default;
run;


data FIM1.PD_adverse (rename= (orig_rt=interest_rate ocltv=loan_to_value_ratio dti=deb_to_income_ratio cscore_b=borrower_FICO cscore_c=coborrower_FICO House_Price_Index__Level_=house_price_index));
set FIM1.PD_unsort2_adverse;
run;

/*6666666666666666666666666666666666666666666666666666666666666666*/

data FIM1.PD_unsort1_severe;
set FIM1.Combine_2009q1_servere; /*merged dataset*/
Default=(z_zb_code in('03','09'));
run;
data FIM1.PD_unsort2_severe(keep=loan_id orig_rt ocltv dti cscore_b purpose prop_typ num_unit occ_stat cscore_c House_Price_Index__Level_ Unemployment_rate Mortgage_rate costs Default);
set FIM1.PD_unsort1_severe;
retain loan_id orig_rt ocltv dti cscore_b cscore_c purpose prop_typ num_unit occ_stat House_Price_Index__Level_ Unemployment_rate Mortgage_rate Default;
run;


data FIM1.PD_severe (rename= (orig_rt=interest_rate ocltv=loan_to_value_ratio dti=deb_to_income_ratio cscore_b=borrower_FICO cscore_c=coborrower_FICO House_Price_Index__Level_=house_price_index));
set FIM1.PD_unsort2_severe;
run;

