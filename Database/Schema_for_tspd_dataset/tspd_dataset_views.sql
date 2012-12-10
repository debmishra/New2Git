create or replace view v_tspd_proc_pricing as select 
e.short_desc phase, d.code indication, b.cpt_code proc_code, a.pct50, a.cnt, a.years_back
from tspd_proc_pricing a, procedure_def b, mapper c, indmap d, phase e
where a.phase_id=e.id(+)
and a.indmap_id=d.id(+) 
and a.mapper_id=c.id(+)
and c.procedure_def_id=b.id;

create or replace view v_tspd_proc_freq as select
e.short_desc phase, d.code indication, b.cpt_code proc_code, 
a.proc_cnt, a.trial_cnt, a.years_back, a.usage_cnt, a.usage_proc
from tspd_proc_freq a, procedure_def b, mapper c, indmap d, phase e
where a.phase_id=e.id 
and a.indmap_id=d.id  
and a.mapper_id=c.id 
and c.procedure_def_id=b.id;


create or replace view v_tspd_trial_freq as select 
e.short_desc phase, d.code indication, a.trial_cnt, a.total_cnt, a.years_back
from tspd_trial_freq a, indmap d, phase e
where a.phase_id=e.id 
and a.indmap_id=d.id ;