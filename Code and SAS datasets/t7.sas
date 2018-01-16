data FIM1.PD_answer(keep loan_id date d_prob_base d_prob_adverse d_prob_severe);
set FIM1.Pd_sample_catg;
if Purpose_Purchase=1 then Purpose_Purchase_R = -1; else Purpose_Purchase_R=1;
if prop_typ_Condo=1 then prop_typ_Condo_R = -1; else prop_typ_Condo_R=1;
if fico_685_730=1 then fico_685_730_R = -1; else fico_685_730_R=1;
if fico_730_765=1 then fico_730_765_R = -1; else fico_730_765_R=1;
if fico_765_790=1 then fico_765_790_R = -1; else fico_765_790_R=1;
if fico_790_850=1 then fico_790_850_R = -1; else fico_790_850_R=1;
if dti_00_21=1 then dti_00_21_R = -1; else dti_00_21_R=1;
if dti_21_27=1 then dti_21_27_R = -1; else dti_21_27_R=1;
if dti_27_34=1 then dti_27_34_R = -1; else dti_27_34_R=1;
if dti_34_41=1 then dti_34_41_R = -1; else dti_34_41_R=1;
if ltv_00_90=1 then ltv_00_90_R = -1; else ltv_00_90_R=1;
if ltv_97_103=1 then ltv_97_103_R = -1; else ltv_97_103_R=1;


nd_prob_base= exp(-7.3192-1.3066*interest_rate+0.0829*base_HPI+1.0161*base_unemploment_rate+0.6333*base_Mortgage_rate-0.2915*
Purpose_Purchase_R+0.22*prop_typ_Condo_R-0.2333*fico_685_730_R-0.4007*fico_730_765_R-0.5407*fico_765_790_R-0.7873*
fico_790_850_R-0.6938*dti_00_21_R-0.4983*dti_21_27_R-0.2380*dti_27_34_R-0.1739*dti_34_41_R-0.6050*ltv_00_90_R-7.0297*ltv_97_103_R)/
(1+exp(-7.3192-1.3066*interest_rate+0.0829*base_HPI+1.0161*base_unemploment_rate+0.6333*base_Mortgage_rate-0.2915*Purpose_Purchase_R+
0.22*prop_typ_Condo_R-0.2333*fico_685_730_R-0.4007*fico_730_765_R-0.5407*fico_765_790_R-0.7873*fico_790_850_R-0.6938*dti_00_21_R
-0.4983*dti_21_27_R-0.2380*dti_27_34_R-0.1739*dti_34_41_R-0.6050*ltv_00_90_R-7.0297*ltv_97_103_R));

d_prob_base=1-nd_prob;


nd_prob_adverse= exp(-7.3192-1.3066*interest_rate+0.0829*adverse_HPI+1.0161*adverse_unemploment_rate+0.6333*adverse_Mortgage_rate-0.2915*
Purpose_Purchase_R+0.22*prop_typ_Condo_R-0.2333*fico_685_730_R-0.4007*fico_730_765_R-0.5407*fico_765_790_R-0.7873*
fico_790_850_R-0.6938*dti_00_21_R-0.4983*dti_21_27_R-0.2380*dti_27_34_R-0.1739*dti_34_41_R-0.6050*ltv_00_90_R-7.0297*ltv_97_103_R)/
(1+exp(-7.3192-1.3066*interest_rate+0.0829*adverse_HPI+1.0161*adverse_unemploment_rate+0.6333*adverse_Mortgage_rate-0.2915*Purpose_Purchase_R+
0.22*prop_typ_Condo_R-0.2333*fico_685_730_R-0.4007*fico_730_765_R-0.5407*fico_765_790_R-0.7873*fico_790_850_R-0.6938*dti_00_21_R
-0.4983*dti_21_27_R-0.2380*dti_27_34_R-0.1739*dti_34_41_R-0.6050*ltv_00_90_R-7.0297*ltv_97_103_R));

d_prob_adverse=1-nd_prob;


nd_prob_severe= exp(-7.3192-1.3066*interest_rate+0.0829*severe_HPI+1.0161*severe_unemploment_rate+0.6333*severe_Mortgage_rate-0.2915*
Purpose_Purchase_R+0.22*prop_typ_Condo_R-0.2333*fico_685_730_R-0.4007*fico_730_765_R-0.5407*fico_765_790_R-0.7873*
fico_790_850_R-0.6938*dti_00_21_R-0.4983*dti_21_27_R-0.2380*dti_27_34_R-0.1739*dti_34_41_R-0.6050*ltv_00_90_R-7.0297*ltv_97_103_R)/
(1+exp(-7.3192-1.3066*interest_rate+0.0829*severe_HPI+1.0161*severe_unemploment_rate+0.6333*severe_Mortgage_rate-0.2915*Purpose_Purchase_R+
0.22*prop_typ_Condo_R-0.2333*fico_685_730_R-0.4007*fico_730_765_R-0.5407*fico_765_790_R-0.7873*fico_790_850_R-0.6938*dti_00_21_R
-0.4983*dti_21_27_R-0.2380*dti_27_34_R-0.1739*dti_34_41_R-0.6050*ltv_00_90_R-7.0297*ltv_97_103_R));

d_prob_severe=1-nd_prob;


output;
run;
