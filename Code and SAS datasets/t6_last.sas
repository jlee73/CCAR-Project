data FIM1.Pd_sample_catg_R;
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


nd_prob= exp(-7.3192-1.3066*interest_rate+0.0829*house_price_index+1.0161*Unemployment_rate+0.6333*Mortgage_rate-0.2915*
Purpose_Purchase_R+0.22*prop_typ_Condo_R-0.2333*fico_685_730_R-0.4007*fico_730_765_R-0.5407*fico_765_790_R-0.7873*
fico_790_850_R-0.6938*dti_00_21_R-0.4983*dti_21_27_R-0.2380*dti_27_34_R-0.1739*dti_34_41_R-0.6050*ltv_00_90_R-7.0297*ltv_97_103_R)/
(1+exp(-7.3192-1.3066*interest_rate+0.0829*house_price_index+1.0161*Unemployment_rate+0.6333*Mortgage_rate-0.2915*Purpose_Purchase_R+
0.22*prop_typ_Condo_R-0.2333*fico_685_730_R-0.4007*fico_730_765_R-0.5407*fico_765_790_R-0.7873*fico_790_850_R-0.6938*dti_00_21_R
-0.4983*dti_21_27_R-0.2380*dti_27_34_R-0.1739*dti_34_41_R-0.6050*ltv_00_90_R-7.0297*ltv_97_103_R));

d_prob=1-nd_prob;
output;
run;

data FIM1.Pd_sample_catg_base_R;
set FIM1.Pd_sample_catg_base;
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


nd_prob= exp(-7.3192-1.3066*interest_rate+0.0829*house_price_index+1.0161*Unemployment_rate+0.6333*Mortgage_rate-0.2915*
Purpose_Purchase_R+0.22*prop_typ_Condo_R-0.2333*fico_685_730_R-0.4007*fico_730_765_R-0.5407*fico_765_790_R-0.7873*
fico_790_850_R-0.6938*dti_00_21_R-0.4983*dti_21_27_R-0.2380*dti_27_34_R-0.1739*dti_34_41_R-0.6050*ltv_00_90_R-7.0297*ltv_97_103_R)/
(1+exp(-7.3192-1.3066*interest_rate+0.0829*house_price_index+1.0161*Unemployment_rate+0.6333*Mortgage_rate-0.2915*Purpose_Purchase_R+
0.22*prop_typ_Condo_R-0.2333*fico_685_730_R-0.4007*fico_730_765_R-0.5407*fico_765_790_R-0.7873*fico_790_850_R-0.6938*dti_00_21_R
-0.4983*dti_21_27_R-0.2380*dti_27_34_R-0.1739*dti_34_41_R-0.6050*ltv_00_90_R-7.0297*ltv_97_103_R));

d_prob=1-nd_prob;
output;
run;

data FIM1.Pd_sample_catg_adverse_R;
set FIM1.Pd_sample_catg_adverse;
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


nd_prob= exp(-7.3192-1.3066*interest_rate+0.0829*house_price_index+1.0161*Unemployment_rate+0.6333*Mortgage_rate-0.2915*
Purpose_Purchase_R+0.22*prop_typ_Condo_R-0.2333*fico_685_730_R-0.4007*fico_730_765_R-0.5407*fico_765_790_R-0.7873*
fico_790_850_R-0.6938*dti_00_21_R-0.4983*dti_21_27_R-0.2380*dti_27_34_R-0.1739*dti_34_41_R-0.6050*ltv_00_90_R-7.0297*ltv_97_103_R)/
(1+exp(-7.3192-1.3066*interest_rate+0.0829*house_price_index+1.0161*Unemployment_rate+0.6333*Mortgage_rate-0.2915*Purpose_Purchase_R+
0.22*prop_typ_Condo_R-0.2333*fico_685_730_R-0.4007*fico_730_765_R-0.5407*fico_765_790_R-0.7873*fico_790_850_R-0.6938*dti_00_21_R
-0.4983*dti_21_27_R-0.2380*dti_27_34_R-0.1739*dti_34_41_R-0.6050*ltv_00_90_R-7.0297*ltv_97_103_R));

d_prob=1-nd_prob;
output;
run;
data FIM1.Pd_sample_catg_severe_R;
set FIM1.Pd_sample_catg_severe;
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


nd_prob= exp(-7.3192-1.3066*interest_rate+0.0829*house_price_index+1.0161*Unemployment_rate+0.6333*Mortgage_rate-0.2915*
Purpose_Purchase_R+0.22*prop_typ_Condo_R-0.2333*fico_685_730_R-0.4007*fico_730_765_R-0.5407*fico_765_790_R-0.7873*
fico_790_850_R-0.6938*dti_00_21_R-0.4983*dti_21_27_R-0.2380*dti_27_34_R-0.1739*dti_34_41_R-0.6050*ltv_00_90_R-7.0297*ltv_97_103_R)/
(1+exp(-7.3192-1.3066*interest_rate+0.0829*house_price_index+1.0161*Unemployment_rate+0.6333*Mortgage_rate-0.2915*Purpose_Purchase_R+
0.22*prop_typ_Condo_R-0.2333*fico_685_730_R-0.4007*fico_730_765_R-0.5407*fico_765_790_R-0.7873*fico_790_850_R-0.6938*dti_00_21_R
-0.4983*dti_21_27_R-0.2380*dti_27_34_R-0.1739*dti_34_41_R-0.6050*ltv_00_90_R-7.0297*ltv_97_103_R));

d_prob=1-nd_prob;
output;
run;
/*data FIM1.Pd_sample_catg_R;*/
/*set FIM1.Pd_sample_catg;*/
/*d_prob= exp(-7.3192-1.3066*interest_rate+0.0829*house_price_index+1.0161*Unemployment_rate+0.6333*Mortgage_rate-0.2915*Purpose_Purchase+0.22*prop_typ_Condo-0.2333*fico_685_730-0.4007*fico_730_765-0.5407*fico_765_790-0.7873*fico_790_850-0.6938*dti_00_21-0.4983*dti_21_27-0.2380*dti_27_34-0.1739*dti_34_41-0.6050*ltv_00_90-7.0297*ltv_97_103)/(1+exp(-7.3192-1.3066*interest_rate+0.0829*house_price_index+1.0161*Unemployment_rate+0.6333*Mortgage_rate-0.2915*Purpose_Purchase+0.22*prop_typ_Condo-0.2333*fico_685_730-0.4007*fico_730_765-0.5407*fico_765_790-0.7873*fico_790_850-0.6938*dti_00_21-0.4983*dti_21_27-0.2380*dti_27_34-0.1739*dti_34_41-0.6050*ltv_00_90-7.0297*ltv_97_103));*/
/*d_prob_2=-7.3192-1.3066*interest_rate+0.0829*house_price_index+1.0161*Unemployment_rate+0.6333*Mortgage_rate-0.2915*Purpose_Purchase+0.22*prop_typ_Condo-0.2333*fico_685_730-0.4007*fico_730_765-0.5407*fico_765_790-0.7873*fico_790_850-0.6938*dti_00_21-0.4983*dti_21_27-0.2380*dti_27_34-0.1739*dti_34_41-0.6050*ltv_00_90-7.0297*ltv_97_103;*/
/*d_prob_3= exp(0.271*interest_rate+1.086*house_price_index+2.762*Unemployment_rate+1.884*Mortgage_rate+0.558*Purpose_Purchase+1.553*prop_typ_Condo+0.627*fico_685_730+0.449*fico_730_765+0.339*fico_765_790+0.207*fico_790_850+0.250*dti_00_21+0.369*dti_21_27+0.621*dti_27_34+0.706*dti_34_41+0.298*ltv_00_90-0.001*ltv_97_103)/(1+exp(0.271*interest_rate+1.086*house_price_index+2.762*Unemployment_rate+1.884*Mortgage_rate+0.558*Purpose_Purchase+1.553*prop_typ_Condo+0.627*fico_685_730+0.449*fico_730_765+0.339*fico_765_790+0.207*fico_790_850+0.250*dti_00_21+0.369*dti_21_27+0.621*dti_27_34+0.706*dti_34_41+0.298*ltv_00_90-0.001*ltv_97_103));*/
/*output;*/
/*run;*/
