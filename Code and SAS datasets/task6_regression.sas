/*proc logistic data=FIM1.P_sample_catg outest=betas covout;*/
/*	  class loan_to_value_ratio deb_to_income_ratio */
/*      model Default(event='1')=interest_rate y_rem_mths house_price_index Unemployment_rate Mortgage_rate */
/*                   / selection=stepwise*/
/*                     slentry=0.3*/
/*                     slstay=0.35*/
/*                     details*/
/*                     lackfit;*/
/*      output out=pred p=phat lower=lcl upper=ucl*/
/*             predprob=(individual crossvalidate);*/
/*   run;*/
/*   proc print data=betas;*/
/*      title2 'Parameter Estimates and Covariance Matrix';*/
/*   run;*/
/*   proc print data=pred;*/
/*      title2 'Predicted Probabilities and 95% Confidence Limits';*/
/*   run;*/

ODS GRAPHICS ON;

%_eg_conditional_dropds(FIM1.PREDLogRegPredictions,
		FIM1.SORTTempTableSorted);
/* -------------------------------------------------------------------
  D:\CCAR\pd_sample_catg.sas7bdat
   ------------------------------------------------------------------- */

PROC SQL;
	CREATE VIEW FIM1.SORTTempTableSorted AS
		SELECT *
	FROM FIM1.pd_sample_catg
;
QUIT;

   PROC LOGISTIC DATA=FIM1.SORTTempTableSorted outest=FIM1.logisticout 
		PLOTS(ONLY)=ALL
	;
	CLASS Purpose_Purchase 	(PARAM=EFFECT) Purpose_Refinance 	(PARAM=EFFECT) Purpose_Cashout 	(PARAM=EFFECT) Purpose_Unidentify 	(PARAM=EFFECT) prop_typ_SingleF 	(PARAM=EFFECT) prop_typ_Condo 	(PARAM=EFFECT) prop_typ_Coop 	(PARAM=EFFECT)
	  prop_typ_Manifacture 	(PARAM=EFFECT) prop_typ_Planned 	(PARAM=EFFECT) occ_stat_principal 	(PARAM=EFFECT) occ_stat_second 	(PARAM=EFFECT) occ_stat_investor 	(PARAM=EFFECT) occ_stat_unknown 	(PARAM=EFFECT) fico_300_645 	(PARAM=EFFECT) fico_645_685 	(PARAM=EFFECT)
	  fico_685_730 	(PARAM=EFFECT) fico_730_765 	(PARAM=EFFECT) fico_765_790 	(PARAM=EFFECT) fico_790_850 	(PARAM=EFFECT) dti_00_21 	(PARAM=EFFECT) dti_21_27 	(PARAM=EFFECT) dti_27_34 	(PARAM=EFFECT) dti_34_41 	(PARAM=EFFECT) dti_41_47 	(PARAM=EFFECT)
	  dti_47_100 	(PARAM=EFFECT) ltv_00_90 	(PARAM=EFFECT) ltv_90_95 	(PARAM=EFFECT) ltv_95_97 	(PARAM=EFFECT) ltv_97_103 	(PARAM=EFFECT) ltv_103_120 	(PARAM=EFFECT) ltv_120_150 	(PARAM=EFFECT);
	MODEL Default (Event = '0')=interest_rate y_rem_mths Unemployment_rate Mortgage_rate house_price_index Purpose_Purchase Purpose_Refinance Purpose_Cashout Purpose_Unidentify prop_typ_SingleF prop_typ_Condo prop_typ_Coop prop_typ_Manifacture prop_typ_Planned occ_stat_principal occ_stat_second occ_stat_investor occ_stat_unknown fico_300_645 fico_645_685 fico_685_730 fico_730_765 fico_765_790 fico_790_850 dti_00_21 dti_21_27 dti_27_34 dti_34_41 dti_41_47 dti_47_100 ltv_00_90 ltv_90_95 ltv_95_97 ltv_97_103 ltv_103_120 ltv_120_150		/
		SELECTION=FORWARD
		SLE=0.05
		INCLUDE=0
		CORRB
		COVB
		INFLUENCE
		LACKFIT
		AGGREGATE SCALE=NONE
		RSQUARE
		CTABLE
		PPROB=(0.5)
		LINK=LOGIT
		CLPARM=BOTH
		CLODDS=BOTH
		ALPHA=0.05
	;

	OUTPUT OUT=FIM1.PREDLogRegPredictions(LABEL="Prediction")
		PREDPROBS=INDIVIDUAL
		RESCHI=reschi_Default 
		RESDEV=resdev_Default 
		DIFCHISQ=difchisq_Default 
		DIFDEV=difdev_Default 
		UPPER=upper_Default 
		LOWER=lower_Default ;
RUN;
QUIT;

TITLE;
TITLE1 "PD In-Model Prediction";
PROC PRINT NOOBS DATA=FIM1.PREDLogRegPredictions
;
RUN;

RUN; QUIT;
%_eg_conditional_dropds(FIM1.SORTTempTableSorted);
TITLE; FOOTNOTE;
ODS GRAPHICS OFF;

