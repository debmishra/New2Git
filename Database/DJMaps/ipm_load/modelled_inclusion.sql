alter table tsm_stage.modelled_inclusion add (coeff_id varchar2(20), ta_code varchar2(128));

update tsm_stage.modelled_inclusion a set a.coeff_id=
(select b.id from "&1".build_code b where b.code=a.coeff_value)
where a.coeff_type='COMPANY';


update tsm_stage.modelled_inclusion a set a.coeff_id=
(select b.id from "&1".procedure_def b where b.cpt_code=a.coeff_value)
where a.coeff_type='PROC';

update tsm_stage.modelled_inclusion a set a.coeff_id=
(select b.id from "&1".indmap b where b.code=a.coeff_value
and b.type='Indication Group') where a.coeff_type='INDGRP';


update tsm_stage.modelled_inclusion set ta_code = 'CARDIOVASCULAR' where coeff_value = 'A' and coeff_type='TA';
update tsm_stage.modelled_inclusion set ta_code = 'GASTROINTESTINAL' where coeff_value = 'B' and coeff_type='TA';
update tsm_stage.modelled_inclusion set ta_code = 'CENTRAL NERVOUS SYSTEM' where coeff_value = 'C' and coeff_type='TA';
update tsm_stage.modelled_inclusion set ta_code = 'ANTI-INFECTIVE' where coeff_value = 'D' and coeff_type='TA';
update tsm_stage.modelled_inclusion set ta_code = 'ONCOLOGY' where coeff_value = 'E' and coeff_type='TA';
update tsm_stage.modelled_inclusion set ta_code = 'IMMUNOMODULATION' where coeff_value = 'F' and coeff_type='TA';
update tsm_stage.modelled_inclusion set ta_code = 'DERMATOLOGY' where coeff_value = 'H' and coeff_type='TA';
update tsm_stage.modelled_inclusion set ta_code = 'ENDOCRINE' where coeff_value = 'I' and coeff_type='TA';
update tsm_stage.modelled_inclusion set ta_code = 'PHARMACOKINETIC' where coeff_value = 'K' and coeff_type='TA';
update tsm_stage.modelled_inclusion set ta_code = 'HEMATOLOGY' where coeff_value = 'L' and coeff_type='TA';
update tsm_stage.modelled_inclusion set ta_code = 'OPHTHALMOLOGY' where coeff_value = 'M' and coeff_type='TA';
update tsm_stage.modelled_inclusion set ta_code = 'GENITOURINARY SYSTEM' where coeff_value = 'N' and coeff_type='TA';
update tsm_stage.modelled_inclusion set ta_code = 'RESPIRATORY SYSTEM' where coeff_value = 'O' and coeff_type='TA';
update tsm_stage.modelled_inclusion set ta_code = 'PAIN AND ANESTHESIA' where coeff_value = 'P' and coeff_type='TA';
update tsm_stage.modelled_inclusion set ta_code = 'DEVICES AND DIAGNOSTICS' where coeff_value = 'Q' and coeff_type='TA';
update tsm_stage.modelled_inclusion set ta_code = 'UNKNOWN THERAPEUTIC AREA' where coeff_value = 'Z' and coeff_type='TA';

update tsm_stage.modelled_inclusion a set a.coeff_id=
(select b.id from "&1".indmap b where b.code=a.ta_code
and b.type='Therapeutic Area') where a.coeff_type='TA';

update tsm_stage.modelled_inclusion a set a.coeff_id=
(select b.id from "&1".country b where b.abbreviation=a.coeff_value) 
where a.coeff_type='COUNTRY';

commit;

truncate table "&1".modelled_inclusion;
create sequence tsm_stage.modelled_inclusion_seq;
Insert into "&1".modelled_inclusion(id, coeff_type, coeff_value) 
select tsm_stage.modelled_inclusion_seq.nextval, coeff_type, coeff_id from 
tsm_stage.modelled_inclusion where coeff_id is not null;
commit;

drop sequence tsm_stage.modelled_inclusion_seq;
