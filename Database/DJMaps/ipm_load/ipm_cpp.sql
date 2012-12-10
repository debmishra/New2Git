alter table tsm_stage.ipm_cpp add (indmap_id number(10));

update tsm_stage.ipm_cpp a set a.indmap_id=
(select b.id from "&1".indmap b where b.code=a.indication
 and b.parent_indmap_id is not null);

commit;

truncate table "&1".ipm_cpp;

create sequence tsm_stage.ipm_cpp_seq;

Insert into "&1".ipm_cpp
select tsm_stage.ipm_cpp_seq.nextval,       
PHASE_ID,INDMAP_ID,LOW,MID,HIGH,CLOW,          
CMID,CHIGH,OLOW,OMID,OHIGH,CPV,            
PATIENT_STATUS from 
tsm_stage.ipm_cpp ;
commit;

drop sequence tsm_stage.ipm_cpp_seq;
