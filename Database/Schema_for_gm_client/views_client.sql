create or replace view v_gm_trial_freq as select 
e.short_desc phase, d.code indication, a.trial_cnt, a.total_cnt, a.years_back
from gm_trial_freq a, indmap d, phase e
where a.phase_id=e.id 
and a.indmap_id=d.id ;

create or replace view v_gm_proc_freq as select
e.short_desc phase, d.code indication, b.cpt_code proc_code, 
a.proc_cnt, a.trial_cnt, a.years_back, a.usage_cnt, a.usage_proc
from gm_proc_freq a, procedure_def b, mapper c, indmap d, phase e
where a.phase_id=e.id 
and a.indmap_id=d.id  
and a.mapper_id=c.id 
and c.procedure_def_id=b.id;
                                                                             
create or replace view V_COMPANY_PAP_ODC_COST                                   
as select                                                                          
b.abbreviation COUNTRY,d.code indication,c.short_desc PHASE, f.id odc_def_id, f.picas_code PICAs_CODE,         
a.PRICE_TYPE,a.PRICE_P25,a.PRICE_P50,a.PRICE_P75,                               
a.SPECIFICITY,a.YEAR,a.USED_CNT,a.UNUSED_CNT,a.pct_ids                                    
from company_pap_odc_cost a, country b, phase c, indmap d, mapper e, odc_def f  
where a.country_id=b.id(+)                                                      
and a.phase_id=c.id(+)                                                          
and a.indmap_id=d.id(+)                                                         
and a.mapper_id=e.id(+)                                                         
and e.odc_def_id=f.id;  

create or replace view V_G50_COMPANY_PAP_ODC_COST                                   
as select                                                                          
b.abbreviation COUNTRY,d.code indication,c.short_desc PHASE, f.id odc_def_id,f.picas_code PICAs_CODE,         
a.PRICE_TYPE,a.PRICE_P25,a.PRICE_P50,a.PRICE_P75,                               
a.SPECIFICITY,a.YEAR,a.USED_CNT,a.UNUSED_CNT,a.pct_ids                                     
from g50_company_pap_odc_cost a, country b, phase c, indmap d, mapper e, odc_def f  
where a.country_id=b.id(+)                                                      
and a.phase_id=c.id(+)                                                          
and a.indmap_id=d.id(+)                                                         
and a.mapper_id=e.id(+)                                                         
and e.odc_def_id=f.id;                                                         
                                                                                
create or replace view V_INDUSTRY_PAP_ODC_COST                                  
as select                                                                          
b.abbreviation COUNTRY,d.code indication,c.short_desc PHASE,f.id odc_def_id,f.picas_code,      
a.PRICE_TYPE,a.PRICE_P25,a.PRICE_P50,a.PRICE_P75,                               
a.SPECIFICITY,a.YEAR,a.USED_CNT,a.UNUSED_CNT,                                   
a.NUM_COMPANIES,a.ENTRY_YEAR,a.pct_ids                                                    
from industry_pap_odc_cost a, country b, phase c, indmap d, mapper e, odc_def f 
where a.country_id=b.id(+)                                                      
and a.phase_id=c.id(+)                                                          
and a.indmap_id=d.id(+)                                                         
and a.mapper_id=e.id(+)                                                         
and e.odc_def_id=f.id ;                                                          
                                                                                
create or replace view V_INSTITUTION_OVERHEAD                                   
as select                                                                          
b.name institution, b.abbreviation Inst_abv,A.OFC_OVRHD_P25,A.OFC_OVRHD_P50,    
A.OFC_OVRHD_P75,A.ADJ_OVRHD_P25,A.ADJ_OVRHD_P50,A.ADJ_OVRHD_P75,
A.OVRHD_BASE_PCT,                                                                               
A.EXPERIENCE_COUNT,A.PCT_PAID_P50,A.OVRHD_18MO_P50,
a.ofc_ovrhd_pct_ids,a.adj_ovrhd_pct_ids,a.ovrhd_base_pct_ids,
a.pct_paid_pct_ids,a.ovrhd_18mo_pct_ids                             
from INSTITUTION_OVERHEAD a, institution b                                      
where a.institution_id=b.id(+);                                                  
                                                                                
create or replace view V_IP_STUDY_PRICE                                         
as select                                                                          
COUNTRY_ID,INDMAP_ID,PHASE_ID,PCT25,PCT50,PCT75,                                
COMPANY_PCT50,DE_PRICE,CPP_FLG,CO_CPP_EXP_CNT,OTHER_CPP_EXP_CNT,
a.industry_pct_ids,a.co_pct_ids                
from IP_STUDY_PRICE a, country b, indmap c, phase d                             
where a.country_id=b.id (+)                                                     
and a.indmap_id=c.id(+)                                                         
and a.phase_id=d.id(+); 

create or replace view V_G50_IP_STUDY_PRICE                                         
as select                                                                          
COUNTRY_ID,INDMAP_ID,PHASE_ID,PCT25,PCT50,PCT75,                                
COMPANY_PCT50,DE_PRICE,CPP_FLG,CO_CPP_EXP_CNT,OTHER_CPP_EXP_CNT,
a.industry_pct_ids,a.co_pct_ids                 
from G50_IP_STUDY_PRICE a, country b, indmap c, phase d                             
where a.country_id=b.id (+)                                                     
and a.indmap_id=c.id(+)                                                         
and a.phase_id=d.id(+);                                                          
                                                                                
create or replace view V_PAP_CLINICAL_PROC_COST                                 
as select                                                                          
b.abbreviation COUNTRY,d.code indication,c.short_desc PHASE,f.id procedure_def_id, f.cpt_code,        
a.PCT25,a.PCT50,a.PCT75,a.COMPANY_PCT25,a.COMPANY_PCT50,a.COMPANY_PCT75,        
a.DE_PRICE,a.CO_EXP_CNT,a.OTHER_EXP_CNT,a.SPECIFICITY,a.IND_YEAR,
a.IND_UNUSED_CNT,                                                                              
a.CO_YEAR,a.CO_UNUSED_CNT,a.LEVEL2_SKIP_FLG,a.IND_ENTRY_YEAR,a.NUM_COMPANIES,
a.industry_pct_ids,a.company_pct_ids    
from PAP_CLINICAL_PROC_COST a, country b, phase c,                              
indmap d, mapper e, procedure_def f                                             
where a.country_id=b.id(+)                                                      
and a.phase_id=c.id(+)                                                          
and a.indmap_id=d.id(+)                                                         
and a.mapper_id=e.id(+)                                                         
and e.procedure_def_id=f.id ;   

create or replace view V_G50_PAP_CLINICAL_PROC_COST                                 
as select                                                                          
b.abbreviation COUNTRY,d.code indication,c.short_desc PHASE, f.id procedure_def_id,f.cpt_code,        
a.PCT25,a.PCT50,a.PCT75,a.COMPANY_PCT25,a.COMPANY_PCT50,a.COMPANY_PCT75,        
a.DE_PRICE,a.CO_EXP_CNT,a.OTHER_EXP_CNT,a.SPECIFICITY,a.IND_YEAR,
a.IND_UNUSED_CNT,                                                                              
a.CO_YEAR,a.CO_UNUSED_CNT,a.LEVEL2_SKIP_FLG,a.IND_ENTRY_YEAR,a.NUM_COMPANIES,
a.industry_pct_ids,a.company_pct_ids    
from G50_PAP_CLINICAL_PROC_COST a, country b, phase c,                              
indmap d, mapper e, procedure_def f                                             
where a.country_id=b.id(+)                                                      
and a.phase_id=c.id(+)                                                          
and a.indmap_id=d.id(+)                                                         
and a.mapper_id=e.id(+)                                                         
and e.procedure_def_id=f.id ;
                                                 
                                                                                
create or replace view V_PAP_INSTITUTION_ODC_COST                               
as select                                                                          
b.name institution, b.abbreviation Inst_abv,d.id odc_def_id,d.picas_code,a.PCT50,a.PRICE_TYPE,a.pct_ids        
from PAP_INSTITUTION_ODC_COST a, institution b, mapper c, odc_def d             
where a.institution_id=b.id (+)                                                 
and a.mapper_id=c.id (+)                                                        
and c.odc_def_id=d.id;                                                           
                                                                                
create or replace view V_PAP_INSTITUTION_PROC_COST                              
as select                                                                          
b.name institution, b.abbreviation Inst_abv,d.id procedure_def_id,d.cpt_code,a.PCT50,a.pct_ids                       
from PAP_INSTITUTION_PROC_COST a,institution b, mapper c, procedure_def d       
where a.institution_id=b.id (+)                                                 
and a.mapper_id=c.id (+)                                                        
and c.procedure_def_id=d.id ;                                                    
                                                                                
create or replace view V_PAP_OVERHEAD                                           
as select                                                                         
b.abbreviation COUNTRY,c.code indication,d.short_desc PHASE,                    
a.COMPANY_OVRHD_P50,a.COMPANY_ODC_P50,a.OFC_OVRHD_P25,                          
a.OFC_OVRHD_P50,a.OFC_OVRHD_P75,a.ADJ_OVRHD_P25,                                
a.ADJ_OVRHD_P50,a.ADJ_OVRHD_P75,a.AFFILIATION,a.ODC_P50,                        
a.COMPANY_PCT_PAID_P50,a.PCT_PAID_P50,a.SPECIFICITY,
a.adj_ovrhd_pct_ids,a.ofc_ovrhd_pct_ids,a.pct_paid_pct_ids,
a.odc_pct_ids,a.company_ovrhd_pct_ids,a.company_odc_pct_ids,
a.company_pct_paid_pct_ids                             
from PAP_OVERHEAD a,country b, indmap c, phase d                                
where a.country_id=b.id(+)                                                      
and a.indmap_id=c.id(+)                                                         
and a.phase_id=d.id(+) ;     

create or replace view V_G50_PAP_OVERHEAD                                           
as select                                                                         
b.abbreviation COUNTRY,c.code indication,d.short_desc PHASE,                    
a.COMPANY_OVRHD_P50,a.COMPANY_ODC_P50,a.OFC_OVRHD_P25,                          
a.OFC_OVRHD_P50,a.OFC_OVRHD_P75,a.ADJ_OVRHD_P25,                                
a.ADJ_OVRHD_P50,a.ADJ_OVRHD_P75,a.AFFILIATION,a.ODC_P50,                        
a.COMPANY_PCT_PAID_P50,a.PCT_PAID_P50,a.SPECIFICITY,
a.adj_ovrhd_pct_ids,a.ofc_ovrhd_pct_ids,a.pct_paid_pct_ids,
a.odc_pct_ids,a.company_ovrhd_pct_ids,a.company_odc_pct_ids,
a.company_pct_paid_ids                             
from G50_PAP_OVERHEAD a,country b, indmap c, phase d                                
where a.country_id=b.id(+)                                                      
and a.indmap_id=c.id(+)                                                         
and a.phase_id=d.id(+) ;                                                        
                                                                                
create or replace view V_PAP_OVERHEAD_ODC                                       
as select                                                                          
b.abbreviation COUNTRY,c.code indication,d.short_desc PHASE,                    
a.COMPANY_ODC_P50,a.ODC_P50                                                     
from PAP_OVERHEAD_ODC a,country b, indmap c, phase d                            
where a.country_id=b.id(+)                                                      
and a.indmap_id=c.id(+)                                                         
and a.phase_id=d.id(+) ;                                                         
                                                                                
create or replace view V_PAP_OVERHEAD_OVERHEAD                                  
as select                                                                          
b.abbreviation COUNTRY,c.code indication,d.short_desc PHASE,                    
a.COMPANY_OVRHD_P50,a.OFC_OVRHD_P25,a.OFC_OVRHD_P50,a.OFC_OVRHD_P75,            
a.ADJ_OVRHD_P25,a.ADJ_OVRHD_P50,a.ADJ_OVRHD_P75,a.SPECIFICITY                   
from PAP_OVERHEAD_OVERHEAD a,country b, indmap c, phase d                       
where a.country_id=b.id(+)                                                      
and a.indmap_id=c.id(+)                                                         
and a.phase_id=d.id(+) ;                                                         
                                                                                
create or replace view V_PAP_OVERHEAD_PCT_PAID                                  
as select                                                                          
b.abbreviation COUNTRY,c.code indication,d.short_desc PHASE,                    
a.COMPANY_PCT_PAID_P50,a.PCT_PAID_P50                                           
from PAP_OVERHEAD_PCT_PAID a,country b, indmap c, phase d                       
where a.country_id=b.id(+)                                                      
and a.indmap_id=c.id(+)                                                         
and a.phase_id=d.id(+) ;     
                                                                               
