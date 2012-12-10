drop sequence tsm_stage.destdycn_seq;
create sequence tsm_stage.destdycn_seq;

alter table tsm_stage.destdycn add(country_id number(10), 
cro_study_id number(10),cro_exp_Area_id number(10), cro_company_id number(10));

update tsm_stage.destdycn a set a.country_id=(select b.id from tc10.country b where
b.abbreviation=trim(a.sc_cntry));

update tsm_stage.destdycn a set a.cro_study_id=(select min(b.id) from tc10.cro_study b 
where trim(b.de_id)=trim(a.sc_id) and
      trim(b.de_studyid)=trim(a.sc_stdyid)) ;
commit;
update tsm_stage.destdycn a set a.cro_exp_Area_id=
decode(sc_area,'CL',1,'DP',2,'AN',3,'MW',4,'QA',5,'RG',6,'DP',8,'OT',9);
commit;
update tsm_stage.destdycn a set a.cro_company_id=(select b.id from tc10.cro_company b 
where b.de_id=a.sc_id);
commit;
delete from tc10.cro_study_country;
commit;
insert into tc10.cro_study_country(ID,CRO_COMPANY_ID,CRO_STUDY_ID,
CRO_EXP_AREA_ID,COUNTRY_ID)         
select tsm_stage.destdycn_seq.nextval,CRO_COMPANY_ID,CRO_STUDY_ID,
CRO_EXP_AREA_ID,COUNTRY_ID from tsm_stage.destdycn
where cro_company_id is not null and cro_study_id is not null;
commit; 

drop sequence tsm_stage.destdycn_seq;