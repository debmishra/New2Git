drop sequence tsm_stage.deity_seq;
create sequence tsm_stage.deity_seq;

alter table tsm_stage.deity add(cro_service_type_id number(10), 
cro_exp_Area_id number(10), cro_company_id number(10), cro_study_id number(10));

update tsm_stage.deity a set (a.it_stdyid,a.it_area,a.it_id,a.it_tsid)=
(select trim(b.it_stdyid),trim(b.it_area),trim(b.it_id),trim(b.it_tsid)
from tsm_stage.deity b where b.rowid=a.rowid);

update tc10.cro_study set de_id=trim(de_id);
commit;

update tc10.cro_company set de_id=trim(de_id);
commit;

update tc10.cro_service_type set crocas_key=trim(crocas_key);
commit;

create index tc10.t_cro_study_index1 on tc10.cro_study(de_id,de_studyid) tablespace tcsmall_indx;
create index tsm_stage.t_deity_index1 on tsm_stage.deity(it_id,it_stdyid) tablespace tcsmall_indx;

update tsm_stage.deity a set a.cro_study_id=(select min(b.id) from tc10.cro_study b 
where b.de_id=a.it_id and b.de_studyid=a.it_stdyid);
commit;

drop index tc10.t_cro_study_index1;
drop index tsm_stage.t_deity_index1;

update tsm_stage.deity a set a.cro_exp_Area_id=
decode(it_area,'CL',1,'DP',2,'AN',3,'MW',4,'QA',5,'RG',6,'DP',8,'OT',9);
commit;

create index tc10.t_cro_company_index1 on tc10.cro_company(de_id) tablespace tcsmall_indx;
create index tsm_stage.t_deity_index1 on tsm_stage.deity(it_id) tablespace tcsmall_indx;

update tsm_stage.deity a set a.cro_company_id=(select b.id from tc10.cro_company b 
where b.de_id=a.it_id);
commit;

drop index tc10.t_cro_company_index1;
drop index tsm_stage.t_deity_index1;

create index tc10.t_cro_service_type_index1 on 
tc10.cro_service_type(crocas_key) tablespace tcsmall_indx;
create index tsm_stage.t_deity_index1 on 
tsm_stage.deity(it_tsid) tablespace tcsmall_indx;

update tsm_stage.deity a set a.cro_service_type_id=(select min(b.id) from 
tc10.cro_service_type b where b.crocas_key=a.it_tsid);
commit;

drop index tc10.t_cro_service_type_index1;
drop index tsm_stage.t_deity_index1;

delete from tc10.cro_study_service;

insert into tc10.cro_study_service(ID,CRO_COMPANY_ID,CRO_EXP_AREA_ID,
CRO_SERVICE_TYPE_ID,CRO_STUDY_ID)         
select tsm_stage.deity_seq.nextval,CRO_COMPANY_ID,CRO_EXP_AREA_ID,
CRO_SERVICE_TYPE_ID,CRO_STUDY_ID from tsm_stage.deity
where cro_company_id is not null;
commit; 

drop sequence tsm_stage.deity_seq;