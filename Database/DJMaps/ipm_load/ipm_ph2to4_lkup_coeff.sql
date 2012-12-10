alter table tsm_stage.ipm_ph2to4_lkup_coeff add (country_id number(10), indmap_id number(10));

update tsm_stage.ipm_ph2to4_lkup_coeff a set a.country_id=
(select b.id from "&1".country b where b.abbreviation=a.country);


update tsm_stage.ipm_ph2to4_lkup_coeff a set a.indmap_id=
(select b.id from "&1".indmap b where b.code=a.indication);

commit;

truncate table "&1".ipm_ph2to4_lkup_coeff;

create sequence tsm_stage.ipm_lkup_coeff_seq;

Insert into "&1".ipm_ph2to4_lkup_coeff
select tsm_stage.ipm_lkup_coeff_seq.nextval,                                        
COUNTRY_ID,PHASE_ID,INDMAP_ID,PCT25,PCT50,
PCT75,DURATION,CPP_CPV from 
tsm_stage.ipm_ph2to4_lkup_coeff;
commit;

drop sequence tsm_stage.ipm_lkup_coeff_seq;
