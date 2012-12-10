
update tsm_stage.ipm_ph2to4_adj_coeff set coeff_value = decode(coeff_value,'A',1,'B',2,'C',19,'D',4,'E',5)
where coeff_type='PHASE';
update tsm_stage.ipm_ph2to4_adj_coeff set cpp_cpv = lower(cpp_cpv);
update tsm_stage.ipm_ph2to4_adj_coeff set inpatient_status = initcap(inpatient_status);

update tsm_stage.ipm_ph2to4_adj_coeff a set a.coeff_value=
(select b.id from "&1".indmap b where b.code=a.coeff_value
and b.type='Indication Group') where a.coeff_type='INDGRP'
and upper(a.coeff_value) <> 'OTHER';

commit;

truncate table "&1".ipm_ph2to4_adj_coeff;

create sequence tsm_stage.ipm_adj_coeff_seq;

Insert into "&1".ipm_ph2to4_adj_coeff
select tsm_stage.ipm_adj_coeff_seq.nextval,                                        
GEOGRAPHICAL_LOCATION,INPATIENT_STATUS,CPP_CPV,
COEFF_TYPE,COEFF_VALUE,COEFF from 
tsm_stage.ipm_ph2to4_adj_coeff;
commit;

drop sequence tsm_stage.ipm_adj_coeff_seq;

