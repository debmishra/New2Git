--conn tsm10@prod

--update cost_item set price = price/239.64 where trial_budget_id in  
--(select id from trial_budget where country_id=54) and
--priced_specificity='D';

Conn TSM10_ALK_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_ALL_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_ALS_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_AMP_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_ARR_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_ASP_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_ATC_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_ATN_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_AVI_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_AZA_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_BAX_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_BCP_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_BIH_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_BIL_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_BMR_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_BMS_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_BSC_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_BTD_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_CGN_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_CSL_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_CVD_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_DSP_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_DVC_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_EDO_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_ERD_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_ESI_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_FHI_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_FTM_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_FTS_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_HGS_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_IKA_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_KPI_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_LILTR_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_LIL_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_MDT_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_MED_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_MGI_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_MPJ_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_NVI_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_ONX_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_OPD_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_OSI_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_PDU_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_PII_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_PRD_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_PSW_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_PTC_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_PWA_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_REG_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_SAL_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_SFL_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_SGI_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_SHI_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_SHR_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_SKO_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_SNI_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_SPI_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_VTX_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_WAT_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;
Conn TSM10_WMT_37/welcome@prod
update pap_clinical_proc_cost  set pct25=pct25/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct50=pct50/239.64 where country_id=54 and de_price=1;
update pap_clinical_proc_cost  set pct75=pct75/239.64 where country_id=54 and de_price=1;
update INDUSTRY_PAP_ODC_COST set price_p25=price_p25/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p50=price_p50/239.64 where country_id=54 and specificity=10;
update INDUSTRY_PAP_ODC_COST set price_p75=price_p75/239.64 where country_id=54 and specificity=10;
commit;