create sequence tsm_stage.dedphwsw_seq;
alter table tsm_stage.dedphwsw add(CRO_COMPANY_ID number(10),
	CRO_HW_SW_CODE_ID number(10));

update tsm_stage.dedphwsw a set a.cro_company_id=(select b.id from 
	tc10.cro_company b where a.dh_id=b.de_id);

update tsm_stage.dedphwsw a set a.CRO_HW_SW_CODE_ID=(select b.id from 
tc10.cro_hw_sw_code b where b.crocas_key=a.dh_type);

insert into tc10.cro_hw_sw_used(ID,CRO_COMPANY_ID,
        CRO_HW_SW_CODE_ID      )
        select tsm_stage.dedphwsw_seq.nextval,
        CRO_COMPANY_ID,CRO_HW_SW_CODE_ID       
	from tsm_stage.dedphwsw where
        cro_company_id is not null;
commit;

drop sequence tsm_stage.dedphwsw_seq;