select f.abbreviation country,e.code indication,g.short_desc phase,d.cpt_code,
a.PCT25,b.PCT25 prior_pct25,round(((a.pct25-b.pct25)/b.pct25)*100,2) pct25_chnaged,
a.PCT50 prior_pct50,b.PCT50,round(((a.pct50-b.pct50)/b.pct50)*100,2) pct50_chnaged,
a.PCT75,b.PCT75 prior_pct75,round(((a.pct75-b.pct75)/b.pct75)*100,2) pct75_chnaged,
a.COMPANY_PCT25,b.COMPANY_PCT25,round(((a.COMPANY_pct25-b.COMPANY_pct25/b.COMPANY_pct25))*100,2) Co_pct25_chnaged,
a.COMPANY_PCT50,b.COMPANY_PCT50,round(((a.COMPANY_pct50-b.COMPANY_pct50/b.COMPANY_pct50))*100,2) Co_pct50_chnaged,
a.COMPANY_PCT75,b.COMPANY_PCT75,round(((a.COMPANY_pct75-b.COMPANY_pct75/b.COMPANY_pct75))*100,2) Co_pct75_chnaged,
a.DE_PRICE,b.de_price prior_de_price, a.ind_year variegated_age, b.ind_year prior_variegated_age  
from tsm10e_fts_18.pap_clinical_proc_cost a, tsm10e_fts_17.pap_clinical_proc_cost b,
mapper c, procedure_def d, indmap e, country f, phase g
where a.country_id=b.country_id(+)
and a.indmap_id=b.indmap_id(+)
and a.phase_id=b.phase_id(+)
and a.mapper_id=b.mapper_id(+)
and a.mapper_id=c.id 
and c.procedure_def_id=d.id
and a.indmap_id=e.id
and a.country_id=f.id
and a.phase_id=g.id
and (a.pct25 <> b.pct25 or a.pct50 <> b.pct50 or a.pct75<>b.pct75
or a.company_pct25 <> b.company_pct25 or a.company_pct50 <> b.company_pct50 or
a.company_pct75 <> b.company_pct75);          
          
       

select f.abbreviation country,e.code indication,g.short_desc phase,d.picase_code odc,
a.PRICE_P25,b.PRICE_P25 prior_pct25,round(((a.PRICE_P25-b.PRICE_P25)/b.PRICE_P25)*100,2) pct25_chnaged,
a.PRICE_P50,b.PRICE_P50 prior_pct50,round(((a.PRICE_P50-b.PRICE_P50)/b.PRICE_P50)*100,2) pct50_chnaged,
a.PRICE_P75,b.PRICE_P75 prior_pct75,round(((a.PRICE_P75-b.PRICE_P75)/b.PRICE_P75)*100,2) pct75_chnaged,
a.PRICE_TYPE,b.PRICE_TYPE prior_PRICE_TYPE, a.year variegated_age, b.year prior_variegated_age 
from tsm10e_fts_18.industry_pap_odc_cost a, tsm10e_fts_17.industry_pap_odc_cost b,
mapper c, odc_def d, indmap e, country f, phase g
where a.country_id=b.country_id(+)
and a.indmap_id=b.indmap_id(+)
and a.phase_id=b.phase_id(+)
and a.mapper_id=b.mapper_id(+)
and a.PRICE_TYPE=b.PRICE_TYPE(+)
and a.mapper_id=c.id 
and c.odc_def_id=d.id
and a.indmap_id=e.id
and a.country_id=f.id
and a.phase_id=g.id
and (a.PRICE_P25 <> b.PRICE_P25 or a.PRICE_P50 <> b.PRICE_P50 or a.PRICE_P75<>b.PRICE_P75);
