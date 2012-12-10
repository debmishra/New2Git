---Q003 database 
--=========== 


create table tsm10.currency_backup_2Bdeleted as select * from tsm10.currency;
create table tsm10.country_backup_2Bdeleted as select * from tsm10.country;

alter table tsm10.currency add (ISO_4217 varchar2(20));

update tsm10.currency a set (a.name,a.symbol,a.cnv_rate,a.viewable_flg,a.iso_4217)=
(select b.name,b.symbol,b.cnv_rate,b.viewable_flg,b.iso_4217 from tsm_stage.currency b
where b.id=a.id)
where exists (select 1 from tsm_stage.currency c where c.id=a.id);

insert into tsm10.currency a select * from tsm_stage.currency b where 
not exists (select 1 from tsm10.currency c where c.id=b.id) ;
update tsm10.id_control set next_id=230 where table_name='currency';
commit;

update tsm10.currency set symbol = 
(select symbol from tsm10.currency_backup_2bdeleted where id=10) 
where id=10;
commit;


update tsm10.country a set (currency_id, ISO_4217) = 
(select  currency_id, ISO_4217 from tsm_stage.country b where a.abbreviation=b.abbreviation)
where exists (select 1 from tsm_stage.country c where c.abbreviation=a.abbreviation)
and a.id <> 0;

select id from tsm10.country where
abbreviation in ('RSM','NEP');


delete from tsm10.country where id in (106,107);
commit;

delete from tsm10.currency a where not exists (
select 1 from tsm_stage.currency b where b.id=a.id);
commit;

-- new stuff

insert into tsm10.currency select * from tsm_stage.currency_new where id > 229;
update tsm10.id_control set next_id=235 where table_name='currency';

update tsm10.country set currency_id=233 where abbreviation='ALB';
update tsm10.country set currency_id=230 where abbreviation='DOM';
update tsm10.country set currency_id=231 where abbreviation='GEO';
update tsm10.country set currency_id=234 where abbreviation='MAC';
update tsm10.country set currency_id=232 where abbreviation='GHA';
update tsm10.country set currency_id=229  where abbreviation='CUB';
commit;

update tsm10.currency set name=trim(name);
update tsm10.currency set symbol=trim(symbol);
update tsm10.currency set cnv_rate=trim(cnv_rate);
update tsm10.currency set viewable_flg=trim(viewable_flg);
update tsm10.currency set iso_4217=trim(iso_4217);
commit;

--Devl database
--=============

create table tsm10.currency_backup_2Bdeleted as select * from tsm10.currency;
create table tsm10.country_backup_2Bdeleted as select * from tsm10.country;

alter table tsm10.currency add (ISO_4217 varchar2(20));

update tsm10.currency a set (a.name,a.symbol,a.cnv_rate,a.viewable_flg,a.iso_4217)=
(select b.name,b.symbol,b.cnv_rate,b.viewable_flg,b.iso_4217 from tsm_stage.currency b
where b.id=a.id)
where exists (select 1 from tsm_stage.currency c where c.id=a.id);


insert into tsm10.currency a select * from tsm_stage.currency b where 
not exists (select 1 from tsm10.currency c where c.id=b.id) ;
update tsm10.id_control set next_id=230 where table_name='currency';
commit;

update tsm10.country a set (currency_id, ISO_4217) = 
(select  currency_id, ISO_4217 from tsm_stage.country b where a.abbreviation=b.abbreviation)
where exists (select 1 from tsm_stage.country c where c.abbreviation=a.abbreviation)
and a.id <> 0;


select id,name from tsm10.country where
abbreviation in ('RSM','NEP');


delete from tsm10.country where id in (106,107) and abbreviation in ('RSM','NEP');
commit;

delete from tsm10.currency a where not exists (
select 1 from tsm_stage.currency b where b.id=a.id);
commit;

update currency set name=trim(name);
update currency set symbol=trim(symbol);
update currency set cnv_rate=trim(cnv_rate);
update currency set viewable_flg=trim(viewable_flg);
update currency set iso_4217=trim(iso_4217);
commit;

--D002 database
--===============

conn tsm_stage/welcome@d002

copy from tsm_stage/welcome@devl create country using select * from country
copy from tsm_stage/welcome@devl create currency using select * from currency

conn dmishra/d002@d002

create table tsm10.currency_backup_2Bdeleted as select * from tsm10.currency;
create table tsm10.country_backup_2Bdeleted as select * from tsm10.country;

alter table tsm10.currency add (ISO_4217 varchar2(20));

update tsm10.currency a set (a.name,a.symbol,a.cnv_rate,a.viewable_flg,a.iso_4217)=
(select b.name,b.symbol,b.cnv_rate,b.viewable_flg,b.iso_4217 from tsm_stage.currency b
where b.id=a.id)
where exists (select 1 from tsm_stage.currency c where c.id=a.id);

insert into tsm10.currency a select * from tsm_stage.currency b where 
not exists (select 1 from tsm10.currency c where c.id=b.id) ;
update tsm10.id_control set next_id=230 where table_name='currency';
commit;

alter table tsm10.country add iso_3166 varchar2(3);
alter table tsm10.country add iso_4217 varchar2(3);

update tsm10.country a set (currency_id, ISO_4217) = 
(select  currency_id, ISO_4217 from tsm_stage.country b where a.abbreviation=b.abbreviation)
where exists (select 1 from tsm_stage.country c where c.abbreviation=a.abbreviation)
and a.id <> 0;


select id,name from tsm10.country where
abbreviation in ('RSM','NEP');


delete from tsm10.country where id in (106,107) and abbreviation in ('RSM','NEP');
commit;

delete from tsm10.currency a where not exists (
select 1 from tsm_stage.currency b where b.id=a.id);
commit;



update currency set name=trim(name);
update currency set symbol=trim(symbol);
update currency set cnv_rate=trim(cnv_rate);
update currency set viewable_flg=trim(viewable_flg);
update currency set iso_4217=trim(iso_4217);
commit;

