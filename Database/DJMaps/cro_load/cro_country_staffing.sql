create sequence tsm_stage.cntystaf_seq;
alter table tsm_stage.cntystaf add(country_id number(10), cro_company_id number(10));

update tsm_stage.cntystaf set cntry_code='PHC' where cntry_code='CZS';
update tsm_stage.cntystaf set cntry_code='UGY' where cntry_code='URG';
update tsm_stage.cntystaf set cntry_code='RBL' where cntry_code='BLS';
update tsm_stage.cntystaf set cntry_code='IRL' where cntry_code='IRN';
update tsm_stage.cntystaf set cntry_code='KOR' where cntry_code='ROS';


update tsm_stage.cntystaf a set a.country_id=(select b.id from tc10.country b
	where b.abbreviation=a.cntry_code);

update tsm_stage.cntystaf a set a.cro_company_id=(select b.id from tc10.cro_company b
	where b.de_id=a.id);

truncate table tc10.cro_country_staffing;

insert into tc10.cro_country_staffing(id,cro_company_id,country_id,staff_count,last_updated)
        select tsm_stage.cntystaf_seq.nextval,
        cro_company_id,country_id,nvl(tot_staf,0),sysdate from tsm_stage.cntystaf where
        cro_company_id is not null;

commit;

update tc10.cro_country_staffing set CRO_EXP_AREA_ID =
(select id from tc10.cro_exp_area where upper(name)='OTHER')
where CRO_EXP_AREA_ID is null;
commit;

drop sequence tsm_stage.cntystaf_seq;