1.

select b.code,d.cpt_code "Procedure",d.long_desc,
decode(a.pct50,null,'n/a',a.pct50) "Industry 50th",
decode(a.company_pct50,null,'n/a',a.company_pct50) "Co. 50th" , 
decode(a.other_exp_cnt,0,'n/a',(decode(least(a.other_exp_cnt,4),a.other_exp_cnt,'<5',a.other_exp_cnt))) "Industry N",
decode(a.co_exp_cnt,0,'n/a',(decode(least(a.co_exp_cnt,4),a.co_exp_cnt,'<5',a.co_exp_cnt)))  "Company N"
from pap_clinical_proc_cost a, indmap b, mapper c, procedure_def d
where a.indmap_id = b.id and
a.mapper_id=c.id and
c.procedure_def_id=d.id and
to_char(a.country_id)= :countryid and
a.phase_id=0 and
b.parent_indmap_id is null and
a.indmap_id <> 0 and
a.company_pct50 is not null
order by b.code,d.cpt_code;

2.

select c.code indication,c.short_desc ind_desc,
decode(a.company_pct50,null,'n/a',a.company_pct50) "CPP Co. 50th",
decode(b.company_pct50,null,'n/a',b.company_pct50) "CPV Co. 50th", 
decode(a.CO_CPP_EXP_CNT,null,'n/a', decode(least(a.CO_CPP_EXP_CNT,5),a.CO_CPP_EXP_CNT,'<5',a.CO_CPP_EXP_CNT)) "CPP Comapny N",
decode(b.CO_CPP_EXP_CNT,null,'n/a',decode(least(b.CO_CPP_EXP_CNT,5),b.CO_CPP_EXP_CNT,'<5',b.CO_CPP_EXP_CNT)) "CPV Comapny N" 
from (select indmap_id,COMPANY_PCT50,
CO_CPP_EXP_CNT from ip_study_price
where country_id=:countryid and phase_id=0 and cpp_flg=1 and company_pct50 is not null) a, 
(select indmap_id,COMPANY_PCT50,CO_CPP_EXP_CNT
from ip_study_price where country_id=:countryid and 
phase_id=0 and cpp_flg=0 and company_pct50 is not null) b, indmap c
where a.indmap_id = b.indmap_id(+) and 
a.indmap_id = c.id and c.type='Indication' order by 1;