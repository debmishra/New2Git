alter table tsm_stage.ipm_ph2to4_coeff add coeff_code varchar2(40);

update tsm_stage.ipm_ph2to4_coeff set coeff_value = 'CARDIOVASCULAR' where coeff_value = 'A' and coeff_type='TA';
update tsm_stage.ipm_ph2to4_coeff set coeff_value = 'GASTROINTESTINAL' where coeff_value = 'B' and coeff_type='TA';
update tsm_stage.ipm_ph2to4_coeff set coeff_value = 'CENTRAL NERVOUS SYSTEM' where coeff_value = 'C' and coeff_type='TA';
update tsm_stage.ipm_ph2to4_coeff set coeff_value = 'ANTI-INFECTIVE' where coeff_value = 'D' and coeff_type='TA';
update tsm_stage.ipm_ph2to4_coeff set coeff_value = 'ONCOLOGY' where coeff_value = 'E' and coeff_type='TA';
update tsm_stage.ipm_ph2to4_coeff set coeff_value = 'IMMUNOMODULATION' where coeff_value = 'F' and coeff_type='TA';
update tsm_stage.ipm_ph2to4_coeff set coeff_value = 'DERMATOLOGY' where coeff_value = 'H' and coeff_type='TA';
update tsm_stage.ipm_ph2to4_coeff set coeff_value = 'ENDOCRINE' where coeff_value = 'I' and coeff_type='TA';
update tsm_stage.ipm_ph2to4_coeff set coeff_value = 'PHARMACOKINETIC' where coeff_value = 'K' and coeff_type='TA';
update tsm_stage.ipm_ph2to4_coeff set coeff_value = 'HEMATOLOGY' where coeff_value = 'L' and coeff_type='TA';
update tsm_stage.ipm_ph2to4_coeff set coeff_value = 'OPHTHALMOLOGY' where coeff_value = 'M' and coeff_type='TA';
update tsm_stage.ipm_ph2to4_coeff set coeff_value = 'GENITOURINARY SYSTEM' where coeff_value = 'N' and coeff_type='TA';
update tsm_stage.ipm_ph2to4_coeff set coeff_value = 'RESPIRATORY SYSTEM' where coeff_value = 'O' and coeff_type='TA';
update tsm_stage.ipm_ph2to4_coeff set coeff_value = 'PAIN AND ANESTHESIA' where coeff_value = 'P' and coeff_type='TA';
update tsm_stage.ipm_ph2to4_coeff set coeff_value = 'DEVICES AND DIAGNOSTICS' where coeff_value = 'Q' and coeff_type='TA';
update tsm_stage.ipm_ph2to4_coeff set coeff_value = 'UNKNOWN THERAPEUTIC AREA' where coeff_value = 'Z' and coeff_type='TA';


update tsm_stage.ipm_ph2to4_coeff set coeff_code = decode(coeff_value,'A',1,'B',2,'C',19,'D',4,'E',5)
where coeff_type='PHASE';
update tsm_stage.ipm_ph2to4_coeff set cpp_cpv = lower(cpp_cpv);
update tsm_stage.ipm_ph2to4_coeff set inpatient_status = initcap(inpatient_status);

update tsm_stage.ipm_ph2to4_coeff a set a.coeff_code=
(select b.id from "&1".indmap b where b.code=a.coeff_value
and b.type='Indication Group') where a.coeff_type='INDGRP';

update tsm_stage.ipm_ph2to4_coeff a set a.coeff_code=
(select b.id from "&1".indmap b where b.code=a.coeff_value
and b.type='Therapeutic Area') where a.coeff_type='TA';

update tsm_stage.ipm_ph2to4_coeff set coeff_code =  coeff_value 
where coeff_type='AFFILIATION';

update tsm_stage.ipm_ph2to4_coeff set coeff_code = coeff_value 
where coeff_type in ('IPT COMPLEX', 'COUNTRY GROUP');

--update tsm_stage.ipm_ph2to4_coeff set cross_coeff_type='AFFILIATION' where cross_coeff_type='AFFILIATED';
--update tsm_stage.ipm_ph2to4_coeff set cross_coeff_value = decode(cross_coeff_value,'A','Affiliated','U','Unaffiliated')
--where cross_coeff_type='AFFILIATION';

delete from tsm_stage.ipm_ph2to4_coeff where coeff_type='INDGRP' and coeff_code is null;

commit;

truncate table "&1".ipm_ph2to4_coeff;

create sequence tsm_stage.ipm_coeff_seq;

Insert into "&1".ipm_ph2to4_coeff
select tsm_stage.ipm_coeff_seq.nextval,                                        
GEOGRAPHICAL_LOCATION,INPATIENT_STATUS,CPP_CPV,
COEFF_TYPE,COEFF_code,CROSS_COEFF_TYPE,
CROSS_COEFF_VALUE,COEFF from 
tsm_stage.ipm_ph2to4_coeff;
commit;

drop sequence tsm_stage.ipm_coeff_seq;

