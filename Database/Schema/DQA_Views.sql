create or replace view v_temp_procedure as select 
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
where a.indmap_id=b.id and a.indgroup_indmap_id=c.id and a.ta_indmap_id=d.id
and a.country_id=e.id and a.mapper_id=g.id and
g.procedure_def_id=h.id and a.institution_id=i.id and a.build_code_id=j.id 
and a.phase_id=k.id;

create or replace view v_derived_prices as select                      
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
a.country_id=d.id;