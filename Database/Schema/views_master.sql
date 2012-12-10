                                                                                                                                                             
create or replace view V_DERIVED_PRICES                                         
as select                                                                          
d.abbreviation country,                                                         
b.cpt_code proc_code,                                                           
c.picas_code odc,                                                               
a.LOW_PRICE,                                                                    
a.MED_PRICE,                                                                    
a.HIGH_PRICE,                                                                   
a.TYPE                                                                          
from derived_prices a, procedure_def b, odc_def c, country d                    
where a.procedure_def_id=b.id(+) and                                            
a.odc_def_id=c.id(+) and                                                        
a.country_id=d.id  ;                                                             
                                                                                
create or replace view V_TEMP_INST_TO_COMPANY                                   
as select b.name institution, b.abbreviation Inst_abv,                             
c.code company, d.short_desc phase, e.code TA, f.abbreviation                   
from temp_inst_to_company a, institution b,                                     
build_code c, phase d, indmap e, country f                                      
where a.institution_id=b.id(+)                                                  
and a.build_code_id=c.id(+)                                                     
and a.phase_id=d.id(+)                                                          
and a.ta_indmap_id=e.id(+)                                                      
and a.country_id=f.id(+) ;                                                       
                                                                                
create or replace view V_TEMP_IP_STUDY_PRICE                                    
as select e.abbreviation country, b.code indication,                               
c.code indgrp, d.code TA, f.short_desc phase,                                   
g.short_desc phase1type, h.code company,                                        
a.cpp, a.cpv, a.active_flg, a.primary_indication_flg                            
from temp_ip_study_price a, indmap b, indmap c, indmap d,                       
country e, phase f, phase g, build_code h                                       
where a.indmap_id=b.id(+)                                                       
and a.ta_indmap_id=c.id(+)                                                      
and a.indgroup_indmap_id=d.id(+)                                                
and a.country_id=e.id(+)                                                        
and a.build_code_id=h.id(+)                                                     
and a.phase_id=f.id(+)                                                          
and a.phase1type_id=g.id(+);                                                     
                                                                                
create or replace view V_TEMP_ODC                                               
as select                                                                          
e.abbreviation country,                                                         
b.picas_protocol protocol,                                                      
c.code indgrp,                                                                  
d.code TA,                                                                      
h.picas_code odc,                                                               
k.short_desc phase,                                                             
j.code company,                                                                 
a.GRANT_DATE ,                                                                  
a.PAYMENT,                                                                      
a.cpp,                                                                          
a.cpv,                                                                          
a.cpgv,                                                                         
a.ENTRY_DATE,                                                                   
a.PRIMARY_INDICATION_FLG ,                                                      
a.ACTIVE_FLG,                                                                   
a.PAYMENTS_ID FoxPro_payments_rownum,                                           
i.name institution                                                              
from temp_odc a, protocol b, indmap c, indmap d,                                
country e, mapper g, odc_def h,                                                 
institution i, build_code j,phase k                                             
where a.protocol_id=b.id(+) and                                                 
a.indgroup_indmap_id=c.id(+) and                                                
a.ta_indmap_id=d.id(+) and                                                      
a.country_id=e.id(+) and                                                        
a.mapper_id=g.id(+) and                                                         
g.odc_def_id=h.id and                                                           
a.institution_id=i.id(+) and                                                    
a.build_code_id=j.id(+) and                                                     
a.phase_id=k.id(+)  ;                                                            
                                                                                
create or replace view V_TEMP_OVERHEAD                                          
as select i.picas_protocol, e.abbreviation country, f.short_desc phase,            
b.code indication, c.code indgrp, d.code TA,                                    
j.name institution, j.abbreviation Inst_abv,                                    
a.ADJ_OTHER_PCT,a.ADJ_OVRHD_PCT,a.AFFILIATION,a.GRANT_DATE,                     
a.OVRHD_BASIS,a.OVRHD_PCT,a.PCT_PAID,a.ACTIVE_FLG,                              
a.PRIMARY_INDICATION_FLG                                                        
from temp_overhead a, protocol i, institution j,                                
indmap b, indmap c, indmap d,                                                   
country e, phase f, build_code h                                                
where a.protocol_id=i.id(+)                                                     
and a.institution_id=j.id(+)                                                    
and a.indmap_id=b.id(+)                                                         
and a.indgroup_indmap_id=c.id(+)                                                
and a.ta_indmap_id=d.id(+)                                                      
and a.country_id=e.id(+)                                                        
and a.phase_id=f.id(+)                                                          
and a.build_code_id=h.id(+) ;                                                    
                                                                                
create or replace view V_TEMP_PROCEDURE                                         
as select                                                                          
e.abbreviation country,                                                         
b.code indication,                                                              
c.code indgrp,                                                                  
d.code TA,                                                                      
h.cpt_code proc_code,                                                           
k.short_desc phase,                                                             
j.code company,                                                                 
a.GRANT_DATE ,                                                                  
a.PAYMENT,                                                                      
a.PRIMARY_FLG,                                                                  
a.ENTRY_DATE,                                                                   
a.PRIMARY_INDICATION_FLG ,                                                      
a.ACTIVE_FLG,                                                                   
a.PAYMENTS_ID FoxPro_payments_rownum,                                           
i.name institution                                                              
from temp_procedure a, indmap b, indmap c, indmap d,                            
country e, mapper g, procedure_def h,                                           
institution i, build_code j,phase k                                             
where a.indmap_id=b.id(+) and                                                   
a.indgroup_indmap_id=c.id(+) and                                                
a.ta_indmap_id=d.id(+) and                                                      
a.country_id=e.id(+) and                                                        
a.mapper_id=g.id(+) and                                                         
g.procedure_def_id=h.id(+) and                                                  
a.institution_id=i.id(+) and                                                    
a.build_code_id=j.id(+) and                                                     
a.phase_id=k.id(+) ;                                                             
                                                                                