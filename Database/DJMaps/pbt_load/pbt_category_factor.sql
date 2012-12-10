create sequence tsm_stage.pbt_category_factor_seq;
delete from "&1".cro_category_factor;

alter table tsm_stage.bgmaster modify account varchar2(3);
update tsm_stage.bgmaster set account='Q/R' where account in ('Q','R');

alter table tsm_stage.bgmaster add(country_id number(10), category_id number(10));

update tsm_stage.bgmaster a set a.country_id = (select b.id from "&1".country b
where upper(a.country)=upper(b.name));

update tsm_stage.bgmaster a set a.category_id = (select b.id from "&1".cro_category b
where upper(a.account)=upper(b.category_account));

insert into "&1".cro_category_factor
select tsm_stage.pbt_category_factor_seq.nextval,a.* from
(select distinct COUNTRY_ID,CATEGORY_ID,SIZE_CRO,COSTLOW,COSTMID,
COSTHIGH,MEAN from tsm_stage.bgmaster where
account <> 'X' and country_id is not null and mean <>0) a;
commit;

drop sequence tsm_stage.pbt_category_factor_seq;