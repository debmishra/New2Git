create sequence tsm_stage.detransl_seq;
alter table tsm_stage.detransl add(CRO_COMPANY_ID number(10),
	FROM_CRO_LANGUAGE_ID number(10),TO_CRO_LANGUAGE_ID number(10));

update tsm_stage.detransl a set a.cro_company_id=(select b.id from 
	tc10.cro_company b where a.tr_id=b.de_id);

update tsm_stage.detransl a set a.FROM_CRO_LANGUAGE_ID=(select b.id from 
tc10.cro_language b where b.language_code=a.TR_FROM);

update tsm_stage.detransl a set a.TO_CRO_LANGUAGE_ID=(select b.id from 
tc10.cro_language b where b.language_code=a.TR_TO);

delete from tsm_stage.detransl where rowid not in 
(select min(rowid) from tsm_stage.detransl
group by CRO_COMPANY_ID,TO_CRO_LANGUAGE_ID);
commit;


delete from tc10.cro_med_writing_trans;
insert into tc10.cro_med_writing_trans(ID,CRO_COMPANY_ID,
        CRO_LANGUAGE_ID)
        select tsm_stage.detransl_seq.nextval,
        CRO_COMPANY_ID,TO_CRO_LANGUAGE_ID 
	from tsm_stage.detransl where
        cro_company_id is not null and to_CRO_LANGUAGE_ID is not null;
commit;

drop sequence tsm_stage.detransl_seq;