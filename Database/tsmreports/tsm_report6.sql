SELECT c.cpt_code CPT_CODE,c.long_desc,g.short_desc Phase,
e.short_desc INDGRP,f.code TA, a.company_pct25, a.company_pct50, a.company_pct75
FROM pap_clinical_proc_cost a,mapper b, procedure_def c, indmap e, indmap f, phase g
WHERE 
a.mapper_id=b.id AND
b.procedure_def_id=c.id AND
a.indmap_id=e.id AND
e.parent_indmap_id=f.id AND
a.phase_id=g.id AND
a.country_id=23 and 
(a.company_pct25 IS NOT NULL OR a.company_pct50 IS NOT NULL OR a.company_pct75 IS NOT NULL) AND
e.type='Indication Group'
union ALL
SELECT c.cpt_code,c.long_desc,g.short_desc,null,e.code, 
a.company_pct25, a.company_pct50, a.company_pct75
FROM pap_clinical_proc_cost a,mapper b, procedure_def c, indmap e, phase g
WHERE 
a.mapper_id=b.id AND
b.procedure_def_id=c.id AND
a.indmap_id=e.id AND
e.parent_indmap_id IS null AND
a.phase_id=g.id AND
a.country_id=23 and 
(a.company_pct25 IS NOT NULL OR a.company_pct50 IS NOT NULL OR a.company_pct75 IS NOT NULL) 
ORDER BY cpt_code, Phase, TA, INDGRP;

SELECT c.picas_code CPT_CODE,c.long_desc,g.short_desc Phase,
e.code INDGRP,f.code TA, a.price_p25, a.price_p50, a.price_p75
FROM company_pap_odc_cost a,mapper b, odc_def c, indmap e, indmap f, phase g
WHERE 
a.mapper_id=b.id AND
b.odc_def_id=c.id AND
a.indmap_id=e.id AND
e.parent_indmap_id=f.id AND
a.phase_id=g.id AND
a.country_id=23 and 
(a.price_p25 IS NOT NULL OR a.price_p50 IS NOT NULL OR a.price_p75 IS NOT NULL) AND
e.type='Indication Group'
union ALL
SELECT c.picas_code,c.long_desc,g.short_desc,null,e.code, 
a.price_p25, a.price_p50, a.price_p75
FROM company_pap_odc_cost a,mapper b, odc_def c, indmap e, phase g
WHERE 
a.mapper_id=b.id AND
b.odc_def_id=c.id AND
a.indmap_id=e.id AND
e.parent_indmap_id IS null AND
a.phase_id=g.id AND
a.country_id=23 and 
(a.price_p25 IS NOT NULL OR a.price_p50 IS NOT NULL OR a.price_p75 IS NOT NULL) 
ORDER BY cpt_code, Phase, TA, INDGRP;