--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_afterGM1dot3_4_GSK.sql$ 
--
-- $Revision: 17$        $Date: 2/22/2008 11:56:01 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

-- This is as per the request of Kelly on 10-11-2004 at 9am

Alter table procedure_def add(usage_rank number(5));

create table client_div_to_top_proc(
ID                      NUMBER(10),
CLIENT_DIV_ID		NUMBER(10) not null,
PROCEDURE_DEF_ID        NUMBER(10) not null,
RANK                    NUMBER(10) not null,
CPT_CODE                VARCHAR2(100))
Tablespace tsmsmall pctfree 30;

Alter table client_div_to_top_proc add constraint client_div_to_top_proc_pk
primary key(id) using index tablespace tsmsmall_indx pctfree 30;
 
--Following changes are as per the request of Kelly on 10-14-2004at 7 am

alter table cost_item add(LONG_DESC VARCHAR2(256));

-- Following changes are as per the request of Phil on 10-14-2004 at 7:18 am

alter table client_div add(alt_plan_currency_id number(10));

alter table  client_div add constraint CLIENT_DIV_FK8
foreign key (alt_plan_currency_id) references currency(id);

-- Following changes are as per the request of Phil on 10-15-2004 at 4:40pm

--****************************************************
--FOLLOWING MUST BE DONE CAREFULLY AND ft15xxxx MUST BE
--REPLACED WITH ACTUAL FT15?

grant select,references on currency to ft15xxxx;

conn ft15xxx/****@????????

create synonym currency for tsm10xxxx.currency

alter table ftuser add(alt_plan_currency_id number(10));

alter table  ftuser add constraint FTUSER_FK6
foreign key (alt_plan_currency_id) references currency(id);

conn tsm10xxx/****@??????

--********************************************************

-- Following changes are as per the request of Kelly on 10-19-2004

alter table payments add (checked varchar2(20));

-- Following chnages are as suggested by debashish on 10-20-2004

create table temp13_procedure(
	id number(10),
	indmap_id number(10),
	country_id number(10),
	currency_id number(10),
	grant_date date,
	payment number(16,2),
	phase_id number(10),
	mapper_id number(10),
	institution_id number(10),
	build_code_id number(10) not null,
	primary_flg number(1) default 0 not null,
	ta_indmap_id number(10),
	indgroup_indmap_id number(10),
	active_flg number(1) default 0 not null,
	payments_id number(10),
	ENTRY_DATE DATE,
	PRIMARY_INDICATION_FLG NUMBER(1) default 1 not null)
	tablespace tsmsmall
	pctused 60 pctfree 25;	


Create table temp13_odc(
	id number(10),
	active_flg number(1) default 0 not null,
	indmap_id number(10),
	country_id number(10),
	protocol_id number(10),
	currency_id number(10),
	cpp number(16,2),
	cpv number(16,2),
	cpgv number(16,2),
	institution_id number(10),
	payment number(16,2),
	phase_id number(10),
	mapper_id number(10),
	build_code_id number(10) not null,
	ta_indmap_id number(10),
	indgroup_indmap_id number(10),
	payments_id number(10),
        GRANT_DATE date,            
	ENTRY_DATE date,            
	PRIMARY_INDICATION_FLG number(1) default 1 not null)
	tablespace tsmsmall
	pctused 60 pctfree 25;	

	
Create table temp13_overhead(
	id number(10),
	adj_other_pct number(16,2),
	adj_ovrhd_pct number(16,2),
	affiliation varchar2(20),
	indmap_id number(10),
	country_id number(10),
	protocol_id number(10),
	grant_date date,
	institution_id number(10),
	ovrhd_basis varchar2(80),
	ovrhd_pct number(16,2),
	pct_paid number(16,2),
	phase_id number(10),
	zip_code varchar2(20),
	build_code_id number(10) not null,
	adj18mo_flg number(1) default 0 not null,
	primary_flg number(1) default 0 not null,
	ta_indmap_id number(10),
	indgroup_indmap_id number(10),
	active_flg number(1) default 0 not null,
	investig_id number(10))
	tablespace tsmsmall
	pctused 60 pctfree 25;	

Create table temp13_inst_to_company(
	id number(10),
	institution_id number(10),
	build_code_id number(10) not null,
	phase_id number(10),
	ta_indmap_id number(10), 
	country_id number(10))
	tablespace tsmsmall
	pctused 60 pctfree 25;	

create table temp13_ip_study_price (
	id number(10),
	indmap_id number(10),
	country_id number(10),
	cpp number(16,2),
	cpv number(16,2),
	phase_id number(10),
	build_code_id number(10) not null,
	ta_indmap_id number(10),
	indgroup_indmap_id number(10),
	investig_id number(10),
	active_flg number(1) default 0 not null,
	phase1type_ID number(10))
	tablespace tsmsmall
	pctused 60 pctfree 25;

Insert into id_control select 'tsm10', 'temp13_inst_to_company', nvl(max(id),0)+1 from TEMP13_INST_TO_COMPANY ;
Insert into id_control select 'tsm10', 'temp13_ip_study_price', nvl(max(id),0)+1 from TEMP13_IP_STUDY_PRICE ;
Insert into id_control select 'tsm10', 'temp13_odc', nvl(max(id),0)+1 from TEMP13_ODC ;
Insert into id_control select 'tsm10', 'temp13_overhead', nvl(max(id),0)+1 from TEMP13_OVERHEAD ;
Insert into id_control select 'tsm10', 'temp13_procedure', nvl(max(id),0)+1 from TEMP13_PROCEDURE ;

drop sequence temp13_procedure_seq;
drop sequence temp13_odc_seq;
drop sequence temp13_overhead_seq;
drop sequence temp13_inst_to_company_seq;
drop sequence temp13_ip_study_price_seq;

create sequence temp13_procedure_seq;
create sequence temp13_odc_seq;
create sequence temp13_overhead_seq;
create sequence temp13_inst_to_company_seq;
create sequence temp13_ip_study_price_seq;

Alter table temp13_procedure add constraint temp13_procedure_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table temp13_procedure add constraint tp13_primary_flg_check 
	check(primary_flg in (0,1));

alter table temp13_procedure add constraint tp13_active_flg_check
check(active_flg in (0,1));

Alter table temp13_odc add constraint temp13_odc_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table temp13_odc add constraint temp3_odc_active_check 
	check (active_flg in (0,1));

Alter table temp13_overhead add constraint temp13_overhead_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table temp13_overhead add constraint temp13_ovrhd_affiliation_check
	check( affiliation in ('Affiliated','Unaffiliated','Both'));

Alter table temp13_overhead add constraint 
	temp13_ovrhd_adj18mo_flg_check
	check (adj18mo_flg in (0,1));

Alter table temp13_overhead add constraint to13_primary_flg_check
	check( primary_flg in(0,1));

alter table temp13_overhead add constraint to13_active_flg_check
check(active_flg in (0,1));

Alter table temp13_inst_to_company add constraint 
	temp13_inst_to_company_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table temp13_ip_study_price add constraint 
	temp13_ip_study_price_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table temp13_ip_study_price add constraint 
	tisp13_active_flg_check
	check (active_flg in (0,1));

drop index TEMP13_IP_STUDY_PRICE_indx1;
drop index TEMP13_ODC_indx1;
drop index TEMP13_OVERHEAD_indx1;
drop index TEMP13_PROCEDURE_indx1;
drop index TEMP13_PROCEDURE_indx2;


create index TEMP13_IP_STUDY_PRICE_indx1 on 
	TEMP13_IP_STUDY_PRICE(country_id)
	tablespace tsmlarge_indx pctfree 25;

create index TEMP13_ODC_indx1 on 
	TEMP13_ODC(country_id)
	tablespace tsmlarge_indx pctfree 25;

create index TEMP13_OVERHEAD_indx1 on 
	TEMP13_OVERHEAD(country_id)
	tablespace tsmlarge_indx pctfree 25;

create index TEMP13_PROCEDURE_indx1 on 
	TEMP13_PROCEDURE(country_id)
	tablespace tsmlarge_indx pctfree 25;

create index TEMP13_PROCEDURE_indx2 on 
	TEMP13_PROCEDURE(mapper_id)
	tablespace tsmlarge_indx pctfree 25;

Alter table temp13_procedure add constraint temp13_procedure_fk1
	foreign key (indmap_id) references 
	indmap(id);

Alter table temp13_procedure add constraint temp13_procedure_fk2
	foreign key (country_id) references 
	country(id);

Alter table temp13_procedure add constraint temp13_procedure_fk3
	foreign key (build_code_id) references 
	build_code(id);

Alter table temp13_procedure add constraint temp13_procedure_fk4
	foreign key (currency_id) references 
	country(id);

Alter table temp13_procedure add constraint temp13_procedure_fk5
	foreign key (phase_id) references 
	phase(id);

Alter table temp13_procedure add constraint temp13_procedure_fk6
	foreign key (mapper_id) references 
	mapper(id);

Alter table temp13_procedure add constraint temp13_procedure_fk7
	foreign key (institution_ID) references 
	institution(id);

Alter table temp13_procedure add constraint temp13_procedure_fk8
	foreign key (ta_indmap_id) references 
	indmap(id);

Alter table temp13_procedure add constraint temp13_procedure_fk9
	foreign key (indgroup_indmap_id) references 
	indmap(id);

Alter table temp13_odc add constraint temp13_odc_fk1
	foreign key (indmap_id) references 
	indmap(id);

Alter table temp13_odc add constraint temp13_odc_fk2
	foreign key (country_id) references 
	country(id);

Alter table temp13_odc add constraint temp13_odc_fk3
	foreign key (build_code_id) references 
	build_code(id);

Alter table temp13_odc add constraint temp13_odc_fk4
	foreign key (currency_id) references 
	country(id);

Alter table temp13_odc add constraint temp13_odc_fk5
	foreign key (phase_id) references 
	phase(id);

Alter table temp13_odc add constraint temp13_odc_fk6
	foreign key (mapper_id) references 
	mapper(id);

Alter table temp13_odc add constraint temp13_odc_fk7
	foreign key (institution_ID) references 
	institution(id);

Alter table temp13_odc add constraint temp13_odc_fk8
	foreign key (protocol_ID) references 
	protocol(id);

Alter table temp13_odc add constraint temp13_odc_fk9
	foreign key (ta_indmap_id) references 
	indmap(id);

Alter table temp13_odc add constraint temp13_odc_fk10
	foreign key (indgroup_indmap_id) references 
	indmap(id);

Alter table temp13_overhead add constraint temp13_overhead_fk1
	foreign key (indmap_id) references 
	indmap(id);

Alter table temp13_overhead add constraint temp13_overhead_fk2
	foreign key (country_id) references 
	country(id);

Alter table temp13_overhead add constraint temp13_overhead_fk3
	foreign key (build_code_id) references 
	build_code(id);

Alter table temp13_overhead add constraint temp13_overhead_fk4
	foreign key (phase_id) references 
	phase(id);

Alter table temp13_overhead add constraint temp13_overhead_fk5
	foreign key (institution_ID) references 
	institution(id);

Alter table temp13_overhead add constraint temp13_overhead_fk6
	foreign key (protocol_ID) references 
	protocol(id);

Alter table temp13_overhead add constraint temp13_overhead_fk7
	foreign key (ta_indmap_id) references 
	indmap(id);

Alter table temp13_overhead add constraint temp13_overhead_fk8
	foreign key (indgroup_indmap_id) references 
	indmap(id);

Alter table temp13_inst_to_company add constraint 
	temp13_inst_to_company_fk1
	foreign key (institution_ID) references 
	institution(id);

Alter table temp13_inst_to_company add constraint 
	temp13_inst_to_company_fk2
	foreign key (build_code_ID) references 
	build_code(id);

Alter table temp13_inst_to_company add constraint 
	temp13_inst_to_company_fk3
	foreign key (phase_id) references 
	phase(id);

Alter table temp13_inst_to_company add constraint 
	temp13_inst_to_company_fk4
	foreign key (ta_indmap_id) references 
	indmap(id);

Alter table temp13_inst_to_company add constraint 
	temp13_inst_to_company_fk5
	foreign key (country_id) references 
	country(id);

Alter table temp13_ip_study_price add constraint temp13_ip_study_price_fk1
	foreign key (indmap_id) references 
	indmap(id);

Alter table temp13_ip_study_price add constraint temp13_ip_study_price_fk2
	foreign key (country_id) references 
	country(id);

Alter table temp13_ip_study_price add constraint temp13_ip_study_price_fk3
	foreign key (build_code_id) references 
	build_code(id);

Alter table temp13_ip_study_price add constraint temp13_ip_study_price_fk4
	foreign key (phase_id) references 
	phase(id);

Alter table temp13_ip_study_price add constraint temp13_ip_study_price_fk5
	foreign key (ta_indmap_id) references 
	indmap(id);

Alter table temp13_ip_study_price add constraint temp13_ip_study_price_fk6
	foreign key (indgroup_indmap_id) references 
	indmap(id);

Alter table temp13_ip_study_price add constraint temp13_ip_study_price_fk7
	foreign key (phase1type_id) references 
	phase(id);

-- Following changes are as per the request of Kelly on 10-26-2004 at 7pm

Alter table temp_ip_study_price add(PRIMARY_INDICATION_FLG number(1) default 1 not null);

Alter table temp_overhead add(PRIMARY_INDICATION_FLG number(1) default 1 not null);

-- Following chnages are as per the request of Kelly on 10-26-2004 at 10:38 pm

alter table temp_odc add(
	grant_date date,
	entry_date date,
	Primary_indication_flg number(1) default 1 not null);



--Applied schema chnages upto this in tsm10e@TEST on 11-08-2004
--Applied schema changes upto this in tsm10t@PREV on 01-13-2005

-- Following changes are as per the request of Phil on 01-23-2005

Create table derived_prices(
	ID			NUMBER(10),
	COUNTRY_ID		NUMBER(10),
	MAPPER_ID		NUMBER(10),
	LOW_PRICE		NUMBER(12,2),
	MED_PRICE		NUMBER(12,2),
	HIGH_PRICE		NUMBER(12,2),
	INDMAP_ID		NUMBER(10),
	PHASE_ID		NUMBER(10),
	SOURCE_COUNTRY_ID	NUMBER(10),
	TYPE			VARCHAR2(10))
	tablespace tsmsmall
	pctused 70 pctfree 15;


Alter table derived_prices add constraint derived_prices_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table derived_prices add constraint derived_prices_fk1
	foreign key (Country_id) references 
	Country(id);

Alter table derived_prices add constraint derived_prices_fk2
	foreign key (mapper_id) references 
	mapper(id);

Alter table derived_prices add constraint derived_prices_fk3
	foreign key (indmap_id) references 
	indmap(id);

Alter table derived_prices add constraint derived_prices_fk4
	foreign key (phase_id) references 
	phase(id);

Alter table derived_prices add constraint derived_prices_fk5
	foreign key (source_Country_id) references 
	Country(id);

insert into id_control values('tsm10','derived_prices',1);
commit;


--Applied schema changes upto this in tsm10e@TEST on 03-02-2005 at 9pm
--Applied schema changes upto this in tsm10t@PREV on 03-03-2005 at  5am

-- Following chnages are for ECR050 as per the request of Phil on 03-17

insert into currency values (76,'Vietnamese Dong','Dong',15795,1);
insert into country values (91,'Vietnam','VNM',2,76,null,0,1,160,'VN',null,null);

update id_control set next_id=77 where table_name='currency';
update id_control set next_id=92 where table_name='country';

commit;

update country set name='South Korea' 
where name='Korea';

Insert into currency values (
increment_sequence('currency_seq'),
'Vietnamese Dong','Dong',15795,1);

update country set currency_id=
(select id from currency where name='Vietnamese Dong')
where abbreviation='VNM';

Update Currency set symbol='PHP'
where id =(select currency_id from 
country where abbreviation='PHI');

Update Currency set name='Phillipino Peso'
where id =(select currency_id from 
country where abbreviation='PHI');

--update country set currency_id=
--(select id from currency where name='Phillipino Peso')
--where abbreviation='PHI';

update Country set name='India, Pakistan' 
where name='India';

update Country set name='Australia, New Zealand' 
where name='Australia';

update country set currency_id=(select 
id from currency where upper(name)='EURO')
where abbreviation='GCE';

Update country set is_viewable=1 where abbreviation in
('CHN','COL','CRA','EGY','GCE','HKG','IND',
'JAP','MIA','PER','PHI','POR','PRT','SIN',
'KOR','TAI','THA','TUR','VEN','VNM');

update currency set viewable_flg=1 where id in(
select currency_id from country where abbreviation in
('CHN','COL','CRA','EGY','GCE','HKG','IND',
'JAP','MIA','PER','PHI','POR','PRT','SIN',
'KOR','TAI','THA','TUR','VEN','VNM'));

commit;

-- Following chnages are as per the request of Tonya on 04-17-2005 at 9:25a

Alter table picase_trial add(comments varchar2(4000));

Alter table trial_budget drop constraint TB_OVERHEAD_TYPE_CHECK;


Alter table trial_budget add constraint TB_OVERHEAD_TYPE_CHECK check(
overhead_type in
('Clientdef','PicasOfficialDef','PicasAdjustedDef','Manual','G50','Clientent'));


-- Folloowing changes are as per request of Phil for derived_prices on 04-19 at 00:20am

Alter table derived_prices drop column mapper_id;
Alter table derived_prices add(procedure_def_id number(10), odc_def_id number(10));

Alter table derived_prices add constraint derived_prices_fk2
	foreign key (procedure_def_id) references 
	procedure_def(id);

Alter table derived_prices add constraint derived_prices_fk6
	foreign key (odc_def_id) references 
	odc_def(id);


Alter table derived_prices add constraint dp_proc_check check (
procedure_def_id is null or odc_def_id is null);

Alter table derived_prices modify(type not null);

Alter table derived_prices add constraint dp_type_check check (
type in ('ODC','PROC'));

Alter table derived_prices drop column INDMAP_ID;
Alter table derived_prices drop column PHASE_ID;
Alter table derived_prices drop column SOURCE_COUNTRY_ID;
Alter table derived_prices modify(country_id not null);

-- Following changes are as per request of Tonya on 04-27-2005 at 9:52pm

Alter table client_div add(ENTERED_OVERHEAD_PCT number(12,2)); 





--********************************************************
--**********************IMP*******************************
Then do not forget to load data into derived_prices table
--**********************IMP*******************************
--********************************************************

--b141 ... TSD 1.02 deployment
-- Implemented upto this in tsm10g@PROD on 05-08-2005 at 00:07am

--updated upto this in tsm10e@TEST schema on 04-29-2005 at 6:50am
-- Implemented upto this in tsm10t@PREV on 05-03-2005 at 8:40am


--Following chnages are as per the request of Phil on 05-09-2005 at 8:20pm

Create table QPL_QUERY_SET(
	ID				NUMBER(10),
	CLIENT_DIV_ID			NUMBER(10) NOT NULL,
	CREATOR_FTUSER_ID		NUMBER(10) NOT NULL,
	CREATE_DT			DATE NOT NULL,
	NAME				VARCHAR2(80) NOT NULL,
	PROCEDURE_DEF_ID		NUMBER(10),
	TRIAL_ID			NUMBER(10),
	CUSTOM_SET_ID			NUMBER(10),
	ODC_NAME			VARCHAR2(256),
	PROC_TYPE			NUMBER(1) NOT NULL,
	COUNTRY_ID			NUMBER(10) NOT NULL,
	REGION_ID			NUMBER(10),
	AFFILIATION_ID			NUMBER(10) NOT NULL,
	PHASE_ID			NUMBER(10) NOT NULL,
	TA_ID				NUMBER(10) NOT NULL)
	tablespace tsmsmall
	pctused 65 pctfree 30;


Alter table QPL_QUERY_SET add constraint QPL_QUERY_SET_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 30;

Alter table QPL_QUERY_SET add constraint QPL_QUERY_SET_fk1
	foreign key (CLIENT_DIV_id) references 
	CLIENT_DIV(id);

Alter table QPL_QUERY_SET add constraint QPL_QUERY_SET_fk2
	foreign key (CREATOR_ftuser_id) references 
	ftuser(id);

Alter table QPL_QUERY_SET add constraint QPL_QUERY_SET_fk3
	foreign key (PROCEDURE_DEF_id) references 
	PROCEDURE_DEF(id);

Alter table QPL_QUERY_SET add constraint QPL_QUERY_SET_fk4
	foreign key (TRIAL_id) references 
	TRIAL(id);

Alter table QPL_QUERY_SET add constraint QPL_QUERY_SET_fk5
	foreign key (CUSTOM_SET_id) references 
	CUSTOM_SET(id);

Alter table QPL_QUERY_SET add constraint QPL_QUERY_SET_fk6
	foreign key (COUNTRY_id) references 
	COUNTRY(id);

Alter table QPL_QUERY_SET add constraint QPL_QUERY_SET_fk7
	foreign key (REGION_ID) references 
	REGION(id);

Alter table QPL_QUERY_SET add constraint QPL_QUERY_SET_fk8
	foreign key (PHASE_id) references 
	PHASE(id);

Alter table QPL_QUERY_SET add constraint QPL_QUERY_SET_fk9
	foreign key (TA_id) references 
	INDMAP(id);

Alter table qpl_query_set add constraint qqs_proc_type_check
	check(proc_type between 0 and 4);

insert into id_control values('tsm10','qpl_query_set',1);
commit;

-- Following changes are as per the request of Phil on 05-10-2005 at 9:50pm

Create table QPL_QUERY_SET_ITEM(
	ID				NUMBER(10),
	QPL_QUERY_SET_ID		NUMBER(10) NOT NULL,
	PROCEDURE_DEF_ID		NUMBER(10),
	ODC_NAME			VARCHAR2(256),
	COUNTRY_ID			NUMBER(10))
	tablespace tsmsmall
	pctused 65 pctfree 30;


Alter table QPL_QUERY_SET_ITEM add constraint QPL_QUERY_SET_ITEM_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 30;

Alter table QPL_QUERY_SET_ITEM add constraint QPL_QUERY_SET_ITEM_fk1
	foreign key (QPL_QUERY_SET_id) references 
	QPL_QUERY_SET(id);

Alter table QPL_QUERY_SET_ITEM add constraint QPL_QUERY_SET_ITEM_fk2
	foreign key (PROCEDURE_DEF_id) references 
	PROCEDURE_DEF(id);

Alter table QPL_QUERY_SET_ITEM add constraint QPL_QUERY_SET_ITEM_fk3
	foreign key (COUNTRY_id) references 
	COUNTRY(id);

insert into id_control values('tsm10','qpl_query_set_item',1);
commit;

-- Following request is as per the request of Tonya on 05-17-2005 at 8:18pm

Alter table qpl_query_set add(
	odc_def_id number(10), 
	unlisted_procedure_id number(10));


Alter table QPL_QUERY_SET add constraint QPL_QUERY_SET_fk10
	foreign key (odc_def_id) references 
	odc_def(id);

Alter table QPL_QUERY_SET add constraint QPL_QUERY_SET_fk11
	foreign key (unlisted_procedure_id) references 
	unlisted_procedure(id);


Alter table qpl_query_set_item add(
	unlisted_procedure_id	number(10),
	odc_def_id		number(10),
	proc_type 		NUMBER(1));

Alter table QPL_QUERY_SET_item add constraint QPL_QUERY_SET_item_fk4
	foreign key (odc_def_id) references 
	odc_def(id);

Alter table QPL_QUERY_SET_item add constraint QPL_QUERY_SET_item_fk5
	foreign key (unlisted_procedure_id) references 
	unlisted_procedure(id);


Alter table qpl_query_set_item drop column odc_name;

Alter table qpl_query_set_item add constraint qqsi_proc_type_check
	check(proc_type between 0 and 4);

-- Implemented upto this in tsm10e@TEST on 05-24-2005 at 10:20pm

-- Implemented upto this in tsm10t@PREV on 05-24-2005 at 10:20pm

-- Following chnages are for new IPT on 07-18-2005 at 7:22pm

Insert into ipm_geographical_location select id,'ASP','CANX' from country where abbreviation = 'CHN';
Insert into ipm_geographical_location select id,'COL','EEUX' from country where abbreviation = 'COL';
Insert into ipm_geographical_location select id,'CRA','EEUX' from country where abbreviation = 'CRA';
Insert into ipm_geographical_location select id,'EGY','EEUX' from country where abbreviation = 'EGY';
Insert into ipm_geographical_location select id,'GCE','WEUX' from country where abbreviation = 'GCE';
Insert into ipm_geographical_location select id,'ASP','CANX' from country where abbreviation = 'HKG';
Insert into ipm_geographical_location select id,'IND','EEUX' from country where abbreviation = 'IND';
Insert into ipm_geographical_location select id,'ASP','CANX' from country where abbreviation = 'JAP';
Insert into ipm_geographical_location select id,'ASP','CANX' from country where abbreviation = 'KOR';
Insert into ipm_geographical_location select id,'ASP','CANX' from country where abbreviation = 'MIA';
Insert into ipm_geographical_location select id,'PER','EEUX' from country where abbreviation = 'PER';
Insert into ipm_geographical_location select id,'PHI','USAX' from country where abbreviation = 'PHI';
Insert into ipm_geographical_location select id,'POR','WEUX' from country where abbreviation = 'POR';
Insert into ipm_geographical_location select id,'PRT','USAX' from country where abbreviation = 'PRT';
Insert into ipm_geographical_location select id,'ASP','CANX' from country where abbreviation = 'SIN';
Insert into ipm_geographical_location select id,'ASP','CANX' from country where abbreviation = 'TAI';
Insert into ipm_geographical_location select id,'ASP','CANX' from country where abbreviation = 'THA';
Insert into ipm_geographical_location select id,'TUR','EEUX' from country where abbreviation = 'TUR';
Insert into ipm_geographical_location select id,'VEN','EEUX' from country where abbreviation = 'VEN';
Insert into ipm_geographical_location select id,'ASP','CANX' from country where abbreviation = 'VNM';
commit;

Alter table trial_budget modify (total_cost number(15));
alter table tsm_trial_rollup modify(TOTAL_COST number(17,2));
alter table tsm_trial_rollup modify(TOTAL_COST_PVB number(15));


-- Implemented upto this in tsm10e@TEST on 08-03-2005 at 9:20pm
-- Implemented upto this in tsm10t@PREV on 08-03-2005 at 9:20pm
-- Implemented upto this in tsm10e@PREV on 08-11-2005 at 0:26 am
-- Implemented upto this in tsm10e@PROD on 08-12-2005 at 10:26 pm
-- Implemented upto this in tsm10@PROD on 08-12-2005 at 10:26 pm

insert into local_to_euro select 
increment_sequence('local_to_euro_seq'), id, 340.75 from country where
abbreviation='GCE';

insert into local_to_euro select 
increment_sequence('local_to_euro_seq'), id, 200.482 from country where
abbreviation='POR';

insert into local_to_euro select 
increment_sequence('local_to_euro_seq'), id, 40.3399 from country where
abbreviation='LUX';

--*******************************************************
--IMP IMP IMP --- update data -- run eurto update script. 
--*******************************************************


update country set currency_id=(select currency_id from country 
where abbreviation = 'EUR') where abbreviation='POR';

commit;

--create sequence derived_prices_seq start with 67054;

--insert into derived_prices select derived_prices_seq.nextval,
--9,LOW_PRICE,MED_PRICE,HIGH_PRICE,TYPE,PROCEDURE_DEF_ID,
--ODC_DEF_ID from derived_prices where COUNTRY_ID=52;

--insert into derived_prices select derived_prices_seq.nextval,
--25,LOW_PRICE,MED_PRICE,HIGH_PRICE,TYPE,PROCEDURE_DEF_ID,
--ODC_DEF_ID from derived_prices where COUNTRY_ID=83;

--insert into derived_prices select derived_prices_seq.nextval,
--4,LOW_PRICE,MED_PRICE,HIGH_PRICE,TYPE,PROCEDURE_DEF_ID,
--ODC_DEF_ID from derived_prices where COUNTRY_ID=60;

--insert into derived_prices select derived_prices_seq.nextval,
--6,LOW_PRICE,MED_PRICE,HIGH_PRICE,TYPE,PROCEDURE_DEF_ID,
--ODC_DEF_ID from derived_prices where COUNTRY_ID=47;

--drop sequence derived_prices_seq;

update country set name = 'Australia, New Zealand' 
where abbreviation='AUS';
update country set name = 'India, Pakistan' 
where abbreviation='IND';
commit;

--****************************************************************
-- Implemented upto this in tsm10e@TEST on 09-14-2005 at 1:45pm
-- Implemented upto this in tsm10t@PREV on 09-14-2005 at 1:45pm
-- Implemented upto this in tsm10e@PREV on 09-14-2005 at 1:45pm
-- Implemented upto this in tsm10e@PROD on 09-15-2005 at 4:02 pm
-- Implemented upto this in tsm10@PROD on 09-15-2005 at 4:02 pm
-- Implemented upto this in tsm10g@DEVL on 09-21-2005 at 1:42 pm
-- Implemented upto this in tsm10g@PROD on 07-08-2006 at 5:03 pm for TSD 2.0 deployment
--***************************************************************

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  17   DevTSM    1.16        2/22/2008 11:56:01 AMDebashish Mishra  
--  16   DevTSM    1.15        9/19/2006 12:11:27 AMDebashish Mishra   
--  15   DevTSM    1.14        8/16/2006 1:48:05 PM Debashish Mishra  
--  14   DevTSM    1.13        9/29/2005 11:17:31 AMDebashish Mishra  
--  13   DevTSM    1.12        8/19/2005 6:23:09 AM Debashish Mishra  
--  12   DevTSM    1.11        8/3/2005 6:11:41 AM  Debashish Mishra  
--  11   DevTSM    1.10        5/25/2005 9:12:34 AM Debashish Mishra  
--  10   DevTSM    1.9         5/17/2005 8:23:23 PM Debashish Mishra modified qpl*
--       tables
--  9    DevTSM    1.8         5/10/2005 10:01:56 PMDebashish Mishra  
--  8    DevTSM    1.7         5/9/2005 1:00:52 AM  Debashish Mishra  
--  7    DevTSM    1.6         4/19/2005 1:52:11 AM Debashish Mishra  
--  6    DevTSM    1.5         4/17/2005 9:34:17 AM Debashish Mishra  
--  5    DevTSM    1.4         3/18/2005 8:48:19 AM Debashish Mishra  
--  4    DevTSM    1.3         3/2/2005 10:51:00 PM Debashish Mishra  
--  3    DevTSM    1.2         1/26/2005 7:00:39 AM Debashish Mishra  
--  2    DevTSM    1.1         11/16/2004 12:38:33 AMDebashish Mishra  
--  1    DevTSM    1.0         10/22/2004 6:06:35 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
