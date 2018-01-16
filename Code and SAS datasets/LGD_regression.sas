libname FIM1 'D:\CCAR';

ods graphics on;
   
   proc reg data=FIM1.LGD;
      model costs = interest_rate loan_to_value_ratio borrower_FICO coborrower_FICO purpose prop_typ num_unit occ_stat house_price_index Unemployment_rate Mortgage_rate y_act_upb*interest_rate;
   run;
   
   ods graphics off;
