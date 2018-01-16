data Fim1.EAD1 ;
    set Fim1.Combine_2009q1(where =(x_period='12/01/2015') keep= x_period loan_id x_adj_rem_months y_rem_mths y_curr_rte y_act_upb);

    if x_adj_rem_months=0 or x_adj_rem_months=. 
    then monthly_pmt = (y_act_upb*y_curr_rte/1200)/(1-(1+(y_curr_rte/1200))**(-(y_rem_mths))); 
    else monthly_pmt = (y_act_upb*y_curr_rte/1200)/(1-(1+(y_curr_rte/1200))**(-(x_adj_rem_months))); 

   array UPB(27)  ;
   array EAD(27) ; 

   UPB(1) = y_act_upb;
   EAD(1) = 0;
   EAD(1) = EAD(1) + UPB(1) ;

   do i = 1 to 26;	
        UPB(i+1) = (UPB(i) - monthly_pmt)*(1+y_curr_rte/1200);
		EAD(i+1) +UPB(i+1);
       *output;
   end;

run;
