--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_for_cro_pbt.sql$ 
--
-- $Revision: 28$        $Date: 2/22/2008 11:56:03 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
conn ftcommon/***@???? 

alter table APPLICATION drop constraint APPLICATION_APP_NAME_CHECK;

alter table APPLICATION add constraint APPLICATION_APP_NAME_CHECK
check( app_name in ('PICASE', 'TRACE','TSPD','FTADMIN','CROCAS PBT'));

insert into ftcommon.application values(5,'CROCAS PBT','CROCAS PBT',null);
commit;

conn ft15/***@???

Alter table ftuser add active_crocas_user number(1) default 0 not null;
ALTER TABLE ftuser ADD CONSTRAINT ftusr_active_crocas_user_check 
	CHECK (active_crocas_user in (0,1));

ALTER TABLE trial DROP CONSTRAINT trial_created_by_check;

ALTER TABLE trial ADD CONSTRAINT trial_created_by_check CHECK (
  created_by in ('DASHBOARD','PICASE','TRACE','TSPD','CROCAS'));

CREATE OR REPLACE TRIGGER trial_trg1
before insert or update of created_by
ON trial
referencing new as n old as o
for each row

begin

 If :n.created_by = 'PICAS-E' or :n.created_by = 'Trace' or
    :n.created_by = 'PICASE' or :n.created_by = 'TRACE' or
    :n.created_by = 'Crocas' or :n.created_by = 'CROCAS' or
    :n.created_by = 'TSPD' then

  :n.guid := 'TSM_'||:n.id;

 end if;

end;
/
sho err

conn tsm10/****@????


Alter table client_div add(def_cro_price_range number(1) default 2);

alter table client_div add(allow_cro_create_odcs NUMBER(1,0) DEFAULT 0 NOT NULL);

Alter table client_div add constraint 
  cd_def_cro_price_range_check check(
   def_cro_price_range between 1 and 4);

alter table user_pref drop constraints UP_APP_TYPE_CHECK;

Alter table client_div add constraint cd_ALLOW_CRO_CREATE_ODCS_check
	check (ALLOW_CRO_CREATE_ODCS in (0,1));

alter table user_pref add constraints UP_APP_TYPE_CHECK
 check (app_type in ('DASHBOARD','PICASE','TRACE','TSPD','FTADMIN','CROCAS'));

alter table client_div_to_lic_app drop constraint cdtla_app_name_check;

alter table client_div_to_lic_app add constraint cdtla_app_name_check
 check( app_name in ('DASHBOARD','PICASE','TRACE','TSPD','CROCAS'));

alter table audit_hist drop constraint audit_hist_app_type_check;

alter table audit_hist add constraint audit_hist_app_type_check
 check(app_type in('DASHBOARD','PICASE','TRACE','TSPD','FTADMIN','CROCAS'));

alter table tsm_message add(app_type varchar2(50));

alter table tsm_message add constraint tm_app_type_check
check(app_type in ('PICASE','TRACE','TSPD','FTADMIN','CROCAS'));

create table cro_trial(
trial_id  		NUMBER(10),
archived_date 		DATE,          
archived_by_id  	NUMBER(10),
archived_flg  		NUMBER(1) DEFAULT 0 NOT NULL,
creator_ftuser_id  	NUMBER(10), 
create_date 		DATE,
publish_date  		DATE,
publish_ftgroup_id 	NUMBER(10),
comments 		VARCHAR2(4000),
Total_price 		NUMBER(10,2),
alt_currency_id 	number(10),
alt_total_price 	number(10,2))
tablespace cropbt_data pctfree 20;

Alter table cro_trial add constraint cro_trial_pk 
	primary key (trial_id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table cro_trial add constraint cro_trial_fk1
	foreign key (trial_id) references 
	trial(id);

Alter table cro_trial add constraint cro_trial_fk2
	foreign key (archived_by_id) references 
	ftuser(id);

Alter table cro_trial add constraint cro_trial_fk3
	foreign key (creator_ftuser_id) references 
	ftuser(id);

Alter table cro_trial add constraint cro_trial_fk4
	foreign key (publish_ftgroup_id) references 
	ftgroup(id);

alter table cro_trial add constraint CRO_TRIAL_FK5
	foreign key(alt_currency_id) references 
	currency(id);

ALTER TABLE cro_trial ADD CONSTRAINT cpt_archived_flg_check 
 CHECK (archived_flg in (0,1));


insert into id_control values('tsm10','cro_trial',1);
commit; 


create table cro_category(
id 			NUMBER(10),
short_desc	 	VARCHAR2(256) NOT NULL,   
parent_category_id 	NUMBER(10),
long_desc 		VARCHAR2(4000),
unit_name 		VARCHAR2(256),        
category_account 	VARCHAR2(32),
is_viewable 		NUMBER(1) default 1 NOT NULL)
tablespace cropbt_data pctfree 20;

Alter table cro_category add constraint cro_category_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table cro_category add constraint cro_category_fk1
	foreign key (parent_category_id) references 
	cro_category(id);

ALTER TABLE cro_category ADD CONSTRAINT cpc_is_viewable_check 
 CHECK (is_viewable in (0,1));


insert into id_control values('tsm10','cro_category',1);
commit; 
 

create table cro_component(
id 			NUMBER(10),
cro_category_id 	NUMBER(10)  NOT NULL,
component_type 		NUMBER(1)  NOT NULL,
component_label  	VARCHAR2(256),        
component_Seq 		NUMBER(10)  NOT NULL,
label_col 		NUMBER(10),
value_col 		NUMBER(10),
parent_component_id  	NUMBER(10),
weight			number(10,2),
short_desc		varchar2(256) not null)
tablespace cropbt_data pctfree 20;
 
Alter table cro_component add constraint cro_component_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table cro_component add constraint cro_component_fk1
	foreign key (cro_category_id) references 
	cro_category(id);

Alter table cro_component add constraint cro_component_fk2
	foreign key (parent_component_id) references 
	cro_component(id);

ALTER TABLE cro_component ADD CONSTRAINT cc_component_type_check 
 CHECK (component_type between 1 and 7);


insert into id_control values('tsm10','cro_component',1);
commit; 

create table cro_choice(
Id 			NUMBER(10),
cro_component_id 	NUMBER(10)  NOT NULL,
choice_label		varchar2(256),
sequence 		NUMBER(1),
low_range 		number(10,2), 
high_range 		number(10,2),
short_desc		varchar2(256) not null)
tablespace cropbt_data pctfree 20; 

Alter table cro_choice add constraint cro_choice_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table cro_choice add constraint cro_choice_fk1
	foreign key (cro_component_id) references 
	cro_component(id);

insert into id_control values('tsm10','cro_choice',1);
commit; 

create table cro_choice_factor(
id 			NUMBER(10),
country_id		NUMBER(10)  NOT NULL,
cro_type   		NUMBER(1) NOT NULL,
factor 			NUMBER(12,6) NOT NULL,
cro_choice_id 		NUMBER(10)  NOT NULL)
tablespace cropbt_data pctfree 20; 

Alter table cro_choice_factor add constraint cro_choice_factor_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table cro_choice_factor add constraint cro_choice_factor_fk1
	foreign key (country_id) references 
	country(id);

Alter table cro_choice_factor add constraint cro_choice_factor_fk2
	foreign key (cro_choice_id) references 
	cro_choice(id);

insert into id_control values('tsm10','cro_choice_factor',1);
commit; 

create table cro_category_factor(
Id 			NUMBER(10),
country_id 		NUMBER(10)  NOT NULL,
cro_category_id 	NUMBER(10)  NOT NULL,
cro_type 		NUMBER(1) NOT NULL,
low_price 		NUMBER(10,4)  NOT NULL,
med_price 		NUMBER(10,4)  NOT NULL,
high_price 		NUMBER(10,4)  NOT NULL,
mean_price		NUMBER(10,4)  NOT NULL)
tablespace cropbt_data pctfree 20; 

Alter table cro_category_factor add constraint cro_category_factor_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table cro_category_factor add constraint cro_category_factor_fk1
	foreign key (country_id) references 
	country(id);

Alter table cro_category_factor add constraint cro_category_factor_fk2
	foreign key (cro_category_id) references 
	cro_category(id);

insert into id_control values('tsm10','cro_category_factor',1);
commit; 

create table cro_budget(
id	 		NUMBER(10),
country_id 		NUMBER(10) NOT NULL,
short_desc		VARCHAR(256) NOT NULL,
cro_trial_id  	NUMBER(10) NOT NULL,
creator_ftuser_id 	NUMBER(10) NOT NULL,
ftgroup_id 		NUMBER(10),
locking_ftuser_id 	NUMBER(10),
num_local_sites 	NUMBER(4),
num_regional_sites 	NUMBER(4),
num_central_sites 	NUMBER(4),
num_compl_patients 	NUMBER(6),
cro_type 		NUMBER(1)  NOT NULL,
create_date   		DATE NOT NULL,
sequence  		NUMBER(4),
currency_id 		NUMBER(10),
local_currency_id 	NUMBER(10),
lock_date 		DATE,
build_tag_id 		NUMBER(10),
total_cost 		NUMBER(15),
total_cost_local 	NUMBER(15),
is_published 		NUMBER(1) DEFAULT 0 NOT NULL,
delete_flg 		NUMBER(1) DEFAULT 0 NOT NULL,
cro_company_id 		NUMBER(10),
num_pats_monitored	NUMBER(10),
num_proj_months		NUMBER(10),
publish_date 		date,
alt_total_cost 		number(15))
tablespace cropbt_data pctfree 20;
 
Alter table cro_budget add constraint cro_budget_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table cro_budget add constraint cro_budget_fk1
	foreign key (Country_id) references 
	Country(id);

Alter table cro_budget add constraint cro_budget_fk2
	foreign key (cro_trial_id) references 
	cro_trial(trial_id);

Alter table cro_budget add constraint cro_budget_fk3
	foreign key (creator_ftuser_id) references 
	ftuser(id);

Alter table cro_budget add constraint cro_budget_fk4
	foreign key (ftgroup_id) references 
	ftgroup(id);

Alter table cro_budget add constraint cro_budget_fk5
	foreign key (locking_ftuser_id) references 
	ftuser(id);

Alter table cro_budget add constraint cro_budget_fk6
	foreign key (currency_id) references 
	currency(id);

Alter table cro_budget add constraint cro_budget_fk7
	foreign key (local_currency_id) references 
	currency(id);

Alter table cro_budget add constraint cro_budget_fk8
	foreign key (build_tag_id) references 
	build_tag(id);

ALTER TABLE cro_budget ADD CONSTRAINT cpb_is_published_check 
 CHECK (is_published in (0,1));

ALTER TABLE cro_budget ADD CONSTRAINT cpb_delete_flg_check 
 CHECK (delete_flg in (0,1));

insert into id_control values('tsm10','cro_budget',1);
commit; 

create table cro_budget_input(
id 			NUMBER(10),
cro_budget_id 		NUMBER(10) NOT NULL,
budget_Value 		NUMBER(10,2),
zeroed 			NUMBER(10) DEFAULT 0 NOT NULL,
cro_choice_id 		NUMBER(10) NOT NULL,
cro_category_id 	number(10), 
cro_component_id 	number(10))
tablespace cropbt_data pctfree 20; 

Alter table cro_budget_input add constraint cro_budget_input_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table cro_budget_input add constraint cro_budget_input_fk1
	foreign key (cro_budget_id) references 
	cro_budget(id);

Alter table cro_budget_input add constraint cro_budget_input_fk2
	foreign key (cro_choice_id) references 
	cro_choice(id);

alter table CRO_BUDGET_INPUT add constraint CRO_BUDGET_INPUT_FK3 
	foreign key(cro_category_id) references 
	cro_category(id);

alter table CRO_BUDGET_INPUT add constraint CRO_BUDGET_INPUT_FK4 
	foreign key(cro_component_id) references 
	cro_component(id);

ALTER TABLE cro_budget_input ADD CONSTRAINT cpbi_zeroed_check 
 CHECK (zeroed in (0,1));

insert into id_control values('tsm10','cro_budget_input',1);
commit; 

create table cro_category_rollup(
id 			NUMBER(10),
cro_category_id 	NUMBER(10) NOT NULL,
quantity 		NUMBER(10,2) NOT NULL,
low_price 		NUMBER(10,2) NOT NULL,
medium_price 		NUMBER(10,2) NOT NULL,
high_price 		NUMBER(10,2) NOT NULL,
selected_price 		NUMBER(10,2) NOT NULL,
total_price 		NUMBER(10,2) NOT NULL,
cro_budget_id 		number(10) NOT NULL,
price_range 		number(1),
apply_to_budget		number(1) default 0 not null,
parent_category_id 	number(10), 
short_desc 		varchar2(256))
tablespace cropbt_data pctfree 20;  

Alter table cro_category_rollup add constraint cro_category_rollup_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table cro_category_rollup add constraint cro_category_rollup_fk1
	foreign key (cro_category_id) references 
	cro_category(id);

alter table cro_category_rollup add constraint cro_category_rollup_fk2
	foreign key(cro_budget_id) references 
	cro_budget(id);

Alter table cro_category_rollup add constraint cro_category_rollup_fk3
	foreign key (parent_category_id) references 
	cro_category(id);

 alter table cro_category_rollup add constraint  ccr_price_range_check 
	check (price_range between 0 and 3);

Alter table cro_category_rollup add constraint   ccr_apply_to_budget_check 
	check(apply_to_budget in (0,1));


insert into id_control values('tsm10','cro_category_rollup',1);
commit; 

create table cro_odc_def(
id 		NUMBER(10),
short_desc 	VARCHAR(256) NOT NULL,
unit_name 	VARCHAR(256) NOT NULL,
odc_def_type 		NUMBER(1,0) NOT NULL,
low_price 	NUMBER(10,2),
med_price 	NUMBER(10,2),
high_price 	NUMBER(10,2),
applies_to 	NUMBER(1) NOT NULL,
permanent_flg 	NUMBER(1) NOT NULL)
tablespace cropbt_data pctfree 20;   

Alter table cro_odc_def add constraint cro_odc_def_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

ALTER TABLE cro_odc_def ADD CONSTRAINT cpod_odc_def_type_check 
 CHECK (odc_def_type between 1 and 3);

ALTER TABLE cro_odc_def ADD CONSTRAINT cpod_applies_to_check 
 CHECK (applies_to in (0,1));

ALTER TABLE cro_odc_def ADD CONSTRAINT cpod_permanent_flg_check 
 CHECK (permanent_flg in (0,1));

insert into id_control values('tsm10','cro_odc_def',1);
commit; 

create table cro_ta_factor(
id 		NUMBER(10,0)  NOT NULL,
indmap_id 	NUMBER(10,0)  NOT NULL,
ta_factor 		NUMBER(5,2)  NOT NULL,
cro_category_id		number(10))
tablespace cropbt_data pctfree 20;  

Alter table cro_ta_factor add constraint cro_ta_factor_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table cro_ta_factor add constraint cro_ta_factor_fk1
	foreign key (indmap_id) references 
	indmap(id);

Alter table cro_ta_factor add constraint cro_ta_factor_fk2
	foreign key (cro_category_id) references 
	cro_category(id);

insert into id_control values('tsm10','cro_ta_factor',1);
commit; 

create table cro_phase_factor(
id 		NUMBER(10,0)  NOT NULL,
phase_id 	NUMBER(10,0)  NOT NULL,
factor 		NUMBER(5,2)  NOT NULL,
cro_category_id		number(10))
tablespace cropbt_data pctfree 20;  

Alter table cro_phase_factor add constraint cro_phase_factor_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table cro_phase_factor add constraint cro_phasefactor_fk1
	foreign key (phase_id) references 
	phase(id);

Alter table cro_phase_factor add constraint cro_phase_factor_fk2
	foreign key (cro_category_id) references 
	cro_category(id);

insert into id_control values('tsm10','cro_phase_factor',1);
commit; 

create table cro_odc_item(
id 			NUMBER(10),
cro_budget_id 	        NUMBER(10),
cro_trial_id 	        NUMBER(10) NULL,
cro_odc_def_id 	        NUMBER(10) NOT NULL,
low_price 		NUMBER(6,2),
med_price 		NUMBER(6,2),
high_price 		NUMBER(6,2),
selected_price 		number(10,2) NOT NULL,
display_order 		NUMBER(5) NOT NULL,
price_range 		number(1) default 2 not null,
quantity 		number(10,2) not null,
total_price 		number(10,2),
applies_to 		number(1) not null,
alt_total_price 	number(10,2),
currency_id 		number(10) not null)
tablespace cropbt_data pctfree 20;   

Alter table cro_odc_item add constraint cro_odc_item_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table cro_odc_item add constraint cro_odc_item_fk1
	foreign key (cro_budget_id) references 
	cro_budget(id);

Alter table cro_odc_item add constraint cro_odc_item_fk2
	foreign key (cro_trial_id) references 
	cro_trial(trial_id);

Alter table cro_odc_item add constraint cro_odc_item_fk3
	foreign key (cro_odc_def_id) references 
	cro_odc_def(id);

alter table cro_odc_item add constraint cro_odc_item_fk4
	foreign key(currency_id) references 
	currency(id);

insert into id_control values('tsm10','cro_odc_item',1);
commit;

create table cro_custom_set_item(
id 			NUMBER(10),
custom_set_id 		NUMBER(10) NOT NULL,
cro_odc_def_id 	NUMBER(10) NOT NULL)
tablespace cropbt_data pctfree 20;  

Alter table cro_custom_set_item add constraint cro_custom_set_item_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table cro_custom_set_item add constraint cro_custom_set_item_fk1
	foreign key (custom_set_id) references 
	custom_set(id);

Alter table cro_custom_set_item add constraint cro_custom_set_item_fk2
	foreign key (cro_odc_def_id) references 
	cro_odc_def(id);
 
insert into id_control values('tsm10','cro_custom_set_item',1);
commit;

-- Following changes are as per request of Phil on  09/27 at 10am

alter table country add (is_pbt_viewable number(1) default 1 not null);

alter table country add constraint  country_IS_PBT_VIEWABLE_check 
	check(IS_PBT_VIEWABLE in (0,1));

-- Following changes are as per request of Phil on  09/28/2005 at 10am

alter table cro_budget add(
	wizard_page_number number(2),
	wizard_page_flg number(1) default 0 not null);

alter table cro_budget add constraint cb_wizard_page_flg_check 
	check(wizard_page_flg in (1,0));

-- Following changes are as per request of Tonya at 2pm

alter table cro_odc_def add(client_id number(10), 
currency_id number(10));

alter table cro_odc_def add constraint cro_odc_def_fk1
foreign key (client_id) references client(id);

alter table cro_odc_def add constraint cro_odc_def_fk2
foreign key (currency_id) references currency(id);

--alter table cro_odc_item drop column APPLIED_TO;

-- Following changes are as per request of Phil on  10/24/2005 at 5pm

create table cro_job_type(
Id 			NUMBER(10),
short_desc	 	varchar2(256)  NOT NULL)
tablespace cropbt_data pctfree 20; 

Alter table cro_job_type add constraint cro_job_type_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

insert into id_control values('tsm10','cro_job_type',1);
commit; 

create table cro_adjusted_salary(
id 			NUMBER(10),
country_id		NUMBER(10)  NOT NULL,
indmap_id		NUMBER(10)  NOT NULL,
phase_id		NUMBER(10),
cro_job_type_id 	NUMBER(10)  NOT NULL,
low_salary 		NUMBER(10),
med_salary 		NUMBER(10),
high_salary 		NUMBER(10))
tablespace cropbt_data pctfree 20; 

Alter table cro_adjusted_salary add constraint cro_adjusted_salary_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table cro_adjusted_salary add constraint cro_adjusted_salary_fk1
	foreign key (indmap_id) references 
	indmap(id);

Alter table cro_adjusted_salary add constraint cro_adjusted_salary_fk2
	foreign key (cro_job_type_id) references 
	cro_job_type(id);

Alter table cro_adjusted_salary add constraint cro_adjusted_salary_fk3
	foreign key (country_id) references 
	country(id);

Alter table cro_adjusted_salary add constraint cro_adjusted_salary_fk4
	foreign key (phase_id) references 
	phase(id);

insert into id_control values('tsm10','cro_adjusted_salary',1);
commit; 

create table cro_salaries(
id 			NUMBER(10),
cro_job_type_id 	NUMBER(10)  NOT NULL,
low_salary 		NUMBER(10,2),
med_salary 		NUMBER(10,2),
high_salary 		NUMBER(10,2))
tablespace cropbt_data pctfree 20; 

Alter table cro_salaries add constraint cro_salaries_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table cro_salaries add constraint cro_salaries_fk1
	foreign key (cro_job_type_id) references 
	cro_job_type(id);

insert into id_control values('tsm10','cro_salaries',1);
commit; 

create table CRO_BUDGET_GROUP_PERMISSION(
ID                     NUMBER(10),
CRO_BUDGET_ID        NUMBER(10) not null,
CLIENT_GROUP_ID        NUMBER(10) not null,
RW_FLG                 NUMBER(1) not null)
tablespace cropbt_data pctfree 20;  

Alter table CRO_BUDGET_GROUP_PERMISSION add constraint CRO_BUDGET_GROUP_PERMISSION_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table CRO_BUDGET_GROUP_PERMISSION add constraint CRO_BUDGET_GRP_PERMISSION_fk1
	foreign key (cro_budget_id) references 
	cro_budget(id);

Alter table CRO_BUDGET_GROUP_PERMISSION add constraint CRO_BUDGET_GRP_PERMISSION_fk2
	foreign key (client_group_id) references 
	client_group(id);

Alter table cro_budget_group_permission add constraint cbgp_rw_flg_check check(
	rw_flg in (0,1));

insert into id_control values('tsm10','cro_budget_group_permission',1);
commit; 

/* create or replace view cro_bgmaster as
select
q.cro_type, y.name country, m.short_desc category,
m.category_account fp_account, o.component_label,
o.component_type, o.weight component_weight,
p.choice_label, n.low_price low_cost,
n.med_price  med_cost, n.high_price  high_cost,
q.factor  choice_factor, n.mean_price  mean
from 
cro_category m,cro_category_factor n,Cro_component o, cro_choice p,
cro_choice_factor q, country x,country y
where
m.id=n.cro_category_id AND m.id=o.cro_category_id and
o.id=p.cro_component_id AND p.id=q.cro_choice_id and
n.country_id=q.country_id AND n.cro_type=q.cro_type and
n.country_id=x.id and  q.country_id=y.id;

create or replace view cro_bgmaster1 as
SELECT c.cro_type, c.country, d.category,
d.fp_account, c.component_label,
c.component_type, c.component_weight,
c.choice_label, d.low_cost,
d.med_cost, d.high_cost,
c.choice_factor, d.mean FROM 
(SELECT b.cro_category_id, b.component_label, b.component_type, b.weight component_weight,
a.cro_type, a.country_id, a.choice_label, a.choice_factor, a.country  
FROM 
(select p.cro_component_id, q.cro_type, q.country_id,
p.choice_label, q.factor  choice_factor, r.name country 
from cro_choice p, cro_choice_factor q, country r
where p.id=q.cro_choice_id(+)
and q.country_id=r.id ) a,
cro_component b 
WHERE a.cro_component_id(+)=b.id) c,
(SELECT n.country_id, n.cro_category_id, n.cro_type,m.short_desc category, 
m.category_account fp_account,n.low_price low_cost,
n.med_price  med_cost, n.high_price  high_cost,n.mean_price  mean
from cro_category m,cro_category_factor n
WHERE m.id=n.cro_category_id(+)) d
WHERE c.country_id=d.country_id(+) 
AND c.cro_category_id=d.cro_category_id(+) 
AND c.cro_type=d.cro_type(+);*/

-- deployed in tsm10e@TEST upto this on 11-24-2005 at 10:15am

-- Following changes are as per the request of Phil on 11-24 at 6 pm

alter table cro_odc_def drop constraint cpod_permanent_flg_check ;
ALTER TABLE cro_odc_def ADD CONSTRAINT cpod_permanent_flg_check 
	CHECK (permanent_flg in (0,1,2));

-- Following changes are as per the request of Phil on 11-29-2005 at 6:43 pm

alter table CUSTOM_SET drop constraint CUSTOM_SET_TYPE_CHECK;

alter table CUSTOM_SET add constraint CUSTOM_SET_TYPE_CHECK
check (type in ('ODC','CLIN','TSPD_TASK','CROCAS'));

-- Following changes are as per the request of Tonya on 12-1-2005 at 10:45am

Alter table client_div drop constraint 
  cd_def_cro_price_range_check;

Alter table client_div add constraint 
  cd_def_cro_price_range_check check(
   def_cro_price_range between 0 and 3);

-- Following changes are as per request of Tonya on 12/2/2005 at 11am

alter table client_div add(def_cro_odc_save_flg number(1) default 1,
def_cro_type number(1) default 1);

alter table client_div add constraint cd_def_cro_odc_save_flg_check
check(def_cro_odc_save_flg in (0,1,2));

alter table client_div add constraint cd_def_cro_type_check
check(def_cro_type in (1,2));

conn ft15/****@????

alter table ftuser add(def_cro_odc_save_flg number(1),
def_cro_type number(1));

alter table ftuser add constraint ftuser_cro_odc_save_flg_check
check(def_cro_odc_save_flg in (0,1,2));

alter table ftuser add constraint ftuser_def_cro_type_check
check(def_cro_type in (1,2));

-- Following changes are as per the request of Tonya on 12-6-2005 at 11:43am

insert into ftgroup (id,name) values (25,'CROCAS View');
insert into ftgroup (id,name) values (26,'CROCAS Author');
insert into ftgroup (id,name) values (27,'CROCAS Admin');
insert into ftgroup (id,name) values (28,'CROCAS Client Data Admin');
commit;

conn tsm10/*****@????

-- deployed in tsm10e@TEST upto this on 12-12-2005 at 6:43am

-- Followig changes are as per the request of Tonya on 12-14-2005 at 3:32 pm

alter table cro_odc_def add(OBSOLETE_FLG number(1) default 0 not null,
OBSOLETE_DATE date);

alter table cro_odc_def add constraint cod_OBSOLETE_FLG_check
check (OBSOLETE_FLG in (0,1));

-- Following changes are as per the request of Tonya on 12-16-2005 at 1:30pm

alter table client_div add(crocas_build_tag_id number(10));

-- Following changes are as per the request of Tonya on 12-20-2005 at 9am

ALTER table cro_trial drop constraint CRO_TRIAL_FK4;

ALTER table cro_trial add constraint CRO_TRIAL_FK4 foreign key(PUBLISH_FTGROUP_ID)
references client_group(id);

conn ft15/***@???

alter table trial drop constraint TRIAL_STATUS_CHECK;

alter table trial add constraint TRIAL_STATUS_CHECK check(
trial_status in ('CREATION', 'ACTIVE', 'CLOSED','TSM_PUB','DELETED','CROCAS_PUB'));

conn tsm10/*****@???

-- Following changes are as per request of Tonya on 12-22-2005

alter table cro_odc_item modify (selected_price null);

-- Following chnages are as per the requet of Phil on 12-23-2005

alter table add_study add( specificity number(10));

-- Folowing chnages are as per the request of Phil on 12-29-2005

alter table cro_budget_input modify CRO_CHOICE_ID null;


-- deployed in tsm10e@TEST upto this on 1-3-2006 at 2:32pm

-- Following changes are as per the request of Tonya on 12-31-2006 at 10am

alter table cro_component add(
sub_category_id number(10));

alter table cro_component add constraint cro_component_fk3
foreign key(sub_category_id) references CRO_CATEGORY(id);

-- deployed in tsm10e@TEST upto this on 2-3-2006 at 2:32pm


update country set is_pbt_viewable=1 where abbreviation='EAE';
update country set currency_id=10 where abbreviation='EAE';


insert into country (id,name,abbreviation,currency_id,is_viewable,
is_cro_viewable, is_pbt_viewable) values (115,'North America',
'NA',1,0,0,1);

insert into country (id,name,abbreviation,currency_id,is_viewable,
is_cro_viewable, is_pbt_viewable) values (116,'Europe',
'EU',10,0,0,1);

insert into country (id,name,abbreviation,currency_id,is_viewable,
is_cro_viewable, is_pbt_viewable) values (117,'Scandinavia',
'SC',10,0,0,1);

insert into country (id,name,abbreviation,currency_id,is_viewable,
is_cro_viewable, is_pbt_viewable) values (118,'Latin America',
'LA',1,0,0,1);

insert into country (id,name,abbreviation,currency_id,is_viewable,
is_cro_viewable, is_pbt_viewable) values (119,'Western Europe',
'WE',10,0,0,1);

insert into country (id,name,abbreviation,currency_id,is_viewable,
is_cro_viewable, is_pbt_viewable) values (120,'Pacific Asia',
'PA',1,0,0,1);

insert into country (id,name,abbreviation,currency_id,is_viewable,
is_cro_viewable, is_pbt_viewable) values (121,'Middle East/Africa',
'MA',1,0,0,1);

commit;

-- Followwing chnages are as per the request of Phil on 02/13/2006 at 10:38pm

update cro_category set unit_name='Country'  where category_account='A';
update cro_category set unit_name='Study Docs'  where category_account='C';
update cro_category set unit_name='Patient Docs'  where category_account='D';
update cro_category set unit_name='Study Prep'  where category_account='E';
update cro_category set unit_name='Inv Meetings'  where category_account='F';
update cro_category set unit_name='Initiation Days'  where category_account='G';
update cro_category set unit_name='Monitor Days'  where category_account='H';
update cro_category set unit_name='Close-out Days'  where category_account='I';
update cro_category set unit_name='Site Months'  where category_account='J';
update cro_category set unit_name='Project Months'  where category_account='K';
update cro_category set unit_name='CRF Pages'  where category_account='L';
update cro_category set unit_name='CRF Pages'  where category_account='M';
update cro_category set unit_name='Databases'  where category_account='N';
update cro_category set unit_name='Tables'  where category_account='O';
update cro_category set unit_name='Statistics'  where category_account='P';
update cro_category set unit_name='Reports'  where category_account='Q/R';
update cro_category set unit_name='Manuscripts'  where category_account='S';
update cro_category set unit_name='Reg Audits'  where category_account='T';
update cro_category set unit_name='Completed Pts'  where category_account='U';
update cro_category set unit_name='Study Months'  where category_account='B';
update cro_category set unit_name='Trainings'  where category_account='W';
commit;

-- Following changes are as per the request of Phil on 01/21/2006 at 8am

alter table cro_budget add(
Super_wiz_group_name varchar2(256),
Super_wiz_screen_name varchar2(256));

-- deployed in tsm10e@TEST upto this on 2-28-2006 at 10am
-- deployed in tsm10t@prev upto this on 02-28-2006 at 1:30 pm

-- Following changes are as per request of Phil on 03-01-2006 at 7:30am

alter table cro_component add (default_val number(10,2));

alter table cro_component drop constraint CC_COMPONENT_TYPE_CHECK;

alter table cro_component add constraint CC_COMPONENT_TYPE_CHECK
check (component_type between 1 and 9);

-- Following chnages are as per request of Tonya on 03-02-2006 at 5:45pm

alter table cro_category_rollup modify
(QUANTITY null, LOW_PRICE null, MEDIUM_PRICE null,
HIGH_PRICE null,SELECTED_PRICE null, TOTAL_PRICE null);

-- deployed in tsm10e@TEST upto this on 3-7-2006 at 10am
-- deployed in tsm10t@prev upto this on 3-7-2006 at 10 am

alter table cro_category add category_seq number(2);

update  cro_category set category_seq =1 where category_account='A';
update  cro_category set category_seq =2 where category_account='C';
update  cro_category set category_seq =3 where category_account='D';
update  cro_category set category_seq =4 where category_account='E';
update  cro_category set category_seq =5 where category_account='F';
update  cro_category set category_seq =6 where category_account='W';
update  cro_category set category_seq =7 where category_account='G';
update  cro_category set category_seq =8 where category_account='H';
update  cro_category set category_seq =9 where category_account='I';
update  cro_category set category_seq =10 where category_account='J';
update  cro_category set category_seq =11 where category_account='B';
update  cro_category set category_seq =12 where category_account='K';
update  cro_category set category_seq =13 where category_account='L';
update  cro_category set category_seq =14 where category_account='M';
update  cro_category set category_seq =15 where category_account='N';
update  cro_category set category_seq =16 where category_account='O';
update  cro_category set category_seq =17 where category_account='P';
update  cro_category set category_seq =18 where category_account='Q/R';
update  cro_category set category_seq =19 where category_account='S';
update  cro_category set category_seq =20 where category_account='T';
update  cro_category set category_seq =21 where category_account='U';
COMMIT;

-- Following changes are as per the request of Tonya on 03/21/2006 at 2:30 pm

alter table cro_budget add(
	Sub_total_low 	 Number(15),
	Sub_total_med   Number(15),  
	Sub_total_high   Number(15),  
	Sub_total_sel  	Number(15),
	Sub_total  	Number(15));

--Following changes are as per the request of Phil on 03/24/2006 at 8:15 am

alter table cro_category add (is_loadable number(1) default 1 not null);
update cro_category set is_loadable=is_viewable;
update cro_category set is_loadable=0 where category_account in ('X','Y','Z');
commit;

--Following changes are as per the request of Tonya on 03/24/2006 at 8:15 am
update id_control set next_id=(select nvl(max(id),0)+1 from cro_odc_def) where table_name='cro_odc_def';
commit;
insert into  cro_odc_def (id,short_desc,Unit_name,Odc_def_type,Client_id,Applies_to,Permanent_flg,Obsolete_flg)
select increment_sequence('cro_odc_def_seq'),'Central Travel', 'Site Trip',2,null,1,2,0 from dual;
insert into  cro_odc_def (id,short_desc,Unit_name,Odc_def_type,Client_id,Applies_to,Permanent_flg,Obsolete_flg)
select increment_sequence('cro_odc_def_seq'),'Regional Travel', 'Site Trip',2,null,1,2,0 from dual;
insert into  cro_odc_def (id,short_desc,Unit_name,Odc_def_type,Client_id,Applies_to,Permanent_flg,Obsolete_flg)
select increment_sequence('cro_odc_def_seq'),'Local Travel', 'Site Trip',2,null,1,2,0 from dual;

commit;

update cro_category set short_desc='Central Travel',Unit_name='Site Trip',
            Is_viewable=0 where category_account='X';

update cro_category set short_desc='Regional Travel',Unit_name='Site Trip',
            Is_viewable=0 where category_account='Y';

declare
maxid  number(10);
rowexists number(2);
begin

select count(*) into rowexists from cro_category where category_account='Z';

if rowexists=0
 then

   select nvl(max(id),0)+1 into maxid from cro_category;
   insert into cro_category (ID,SHORT_DESC,UNIT_NAME,CATEGORY_ACCOUNT,IS_VIEWABLE)
            values (maxid,'Local Travel','Site Trip','Z',0);
   update id_control set next_id=maxid+1 where table_name='cro_category';
else
   update cro_category set short_desc='Local Travel',Unit_name='Site Trip',
            Is_viewable=0 where category_account='Z'; 
end if;
end;

/

commit;

-- Following changes are as per the request of Tonya on 03-24-06 at 1pm

alter table cro_odc_item add (is_deletable number(1) default 1 not null);

-- deployed in tsm10e@TEST upto this on 3-26-2006 at 5pm
-- deployed in tsm10t@prev upto this on 3-26-2006 at 5pm

-Following changes are as per request of Tonya on 03-28-2006 at 8:20am

update cro_category set is_loadable=1
where category_account in ('X','Y','Z');

commit;

--Following changes are as per request of Tonya on 03-29-2006 at 6:02 am

alter table client_group add (is_crocas_group number(1) default 0 not null);


-- Following changes are as per request of Tonya on 03-29-2006 at 11am

 alter table cro_adjusted_salary modify (
 LOW_SALARY number(10,2),MED_SALARY number(10,2),
 HIGH_SALARY number(10,2));

-- Following changes are as per request of Lori on 03-31-2006 at 8:21am

update country set name='Eastern Europe' where abbreviation='EAE';
commit;

-- Following changes are as per request of Tonya on 04-02-2006 at 8pm

alter table cro_budget add(
	CRF_PAGES    number(10),
	COMPLETED_PATIENTS number(10),
	EXTRA_PAGES number(10));

-- Following changes are as per request of Allen on 04/07/2006 at 4 pm

Alter table cro_budget add(
cal_central_unit number(1), 
cal_regional_unit number(1),
cal_local_unit number(1));

Alter table cro_budget add constraint cb_cal_central_unit 
check(cal_central_unit in (0,1));

Alter table cro_budget add constraint cb_cal_regional_unit 
check(cal_regional_unit in (0,1));

Alter table cro_budget add constraint cb_cal_local_unit 
check(cal_local_unit in (0,1));

-- deployed in tsm10e@TEST upto this on 4-9-2006 at 1pm
-- deployed in tsm10t@prev upto this on 4-9-2006 at 1pm

-- Following changes are as per the request of Phil on 04/10/2006 at 2:45pm

update cro_component set component_label='Protocol versions' where id=12;
delete from cro_choice_factor where cro_choice_id in (select id from cro_choice
where cro_component_id=13);
delete from cro_choice where cro_component_id=13;
delete from CRO_BUDGET_INPUT where cro_component_id=13;
delete from cro_component where id=13;

delete from cro_choice_factor where cro_choice_id in (247,178);
delete from cro_choice where id in (247,178);

update cro_component set component_label='Informed consent/assent form (ICF)' where id=24;
update cro_component set component_label='Site contact reports to sponsor' where id=90;
update cro_component set component_label='Number of on-site meetings' where id=98;
commit;

-- Following changes are as per request of Tonya on 04-12-2006 at 1pm

alter table cro_budget modify  NUM_PROJ_MONTHS number(10,1);

-- Following changes are as per request of Tonya on 04-12-2006 at 5pm

--alter table cro_plan_estimate add(
--client_id number(10),
--client_div_id number(10));

--alter table cro_plan_estimate add constraint CRO_PLAN_ESTIMATE_FK9
--foreign key (client_id) references client(id);

--alter table cro_plan_estimate add constraint CRO_PLAN_ESTIMATE_FK10
--foreign key (client_div_id) references client_div(id);

-- Following changes are as per request of Tonya on 04-13-2006 at 11:50 am

alter table cro_trial modify(TOTAL_PRICE NUMBER(18,2),
ALT_TOTAL_PRICE NUMBER(18,2));


-- Following changes are as per request of Phil on 04-13-2006 at 6:45pm

create table cro_client_div_to_lic_country(
Id 			NUMBER(10),
client_div_id 		NUMBER(10) NOT NULL,
country_id 		NUMBER(10)  NOT NULL)
tablespace cropbt_data pctfree 20; 

Alter table cro_client_div_to_lic_country add constraint cro_client_div_to_lic_ctry_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table cro_client_div_to_lic_country add constraint cro_client_div_to_lic_ctry_fk1
	foreign key (client_div_id) references 
	client_div(id);

Alter table cro_client_div_to_lic_country add constraint cro_client_div_to_lic_ctry_fk2
	foreign key (country_id) references 
	country(id);


insert into id_control values('tsm10','cro_client_div_to_lic_country',1);
commit; 

-- deployed in tsm10e@TEST upto this on 4-16-2006 at 12:20pm
-- deployed in tsm10t@prev upto this on 4-16-2006 at 12:20pm

-- Following chnages are as per request of Tonya on 04/19/2006 at 12:35 pm

update cro_category set long_desc=replace(long_desc,chr(13));
commit;

-- Following changes are as per the request of Lori on 04/21/2006 at 9:36 am

update country set is_pbt_viewable=1 where
abbreviation='ISR';

commit;

-- deployed in tsm10e@TEST upto this on 4-27-2006 at 7:30am
-- deployed in tsm10t@prev upto this on 4-27-2006 at 7:30am

create table cro_country_factor(
id 		NUMBER(10,0)  NOT NULL,
country_id 	NUMBER(10,0)  NOT NULL,
factor 		NUMBER(12,6)  NOT NULL)
tablespace cropbt_data pctfree 20;  

Alter table cro_country_factor add constraint cro_country_factor_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table cro_country_factor add constraint cro_country_factor_fk1
	foreign key (country_id) references 
	country(id);

insert into id_control values('tsm10','cro_country_factor',1);
commit; 

truncate table cro_choice_factor;
Alter table cro_choice_factor drop column country_id;


update id_control set next_id=(select
nvl(max(id),0)+1 from cro_choice_factor)
where table_name='cro_choice_factor';
commit;

declare

row_exists  number(1);
cursor c2 is select id from cro_choice;
cursor c3 is select distinct cro_type from cro_category_factor;

begin

   for ix2 in c2 loop
    for ix3 in c3 loop

      select count(*) into row_exists from cro_choice_factor where 
       cro_choice_id=ix2.id and cro_type=ix3.cro_type ;
 
       if row_exists=1 then
          update cro_choice_factor set factor=1 where 
           cro_choice_id=ix2.id and cro_type=ix3.cro_type and
          factor is null;
       else
          insert into cro_choice_factor(ID,cro_type, factor, cro_choice_id) 
          select increment_sequence('cro_choice_factor_seq'),ix3.cro_type,1,ix2.id from dual;
       end if;
    end loop;
   end loop;
end;
/
sho err

commit;

-- deployed in tsm10e@TEST upto this on 4-30-2006 at 1am
-- deployed in tsm10t@prev upto this on 4-30-2006 at 1am


-- Following changes are after receivign data frm Lori on 05/01/2006

update cro_country_factor set factor=0.7323 where country_id in (select id from country where abbreviation='ARI');
update cro_country_factor set factor=0.6143 where country_id in (select id from country where abbreviation='BEL');
update cro_country_factor set factor=0.8015 where country_id in (select id from country where abbreviation='CAN');
update cro_country_factor set factor=0.6773 where country_id in (select id from country where abbreviation='DEU');
update cro_country_factor set factor=0.6131 where country_id in (select id from country where abbreviation='EAE');
update cro_country_factor set factor=0.5831 where country_id in (select id from country where abbreviation='ESP');
update cro_country_factor set factor=0.6989 where country_id in (select id from country where abbreviation='EU');
update cro_country_factor set factor=0.5589 where country_id in (select id from country where abbreviation='FRA');
update cro_country_factor set factor=0.6946 where country_id in (select id from country where abbreviation='IRL');
update cro_country_factor set factor=0.6379 where country_id in (select id from country where abbreviation='ITA');
update cro_country_factor set factor=0.624 where country_id in (select id from country where abbreviation='LA');
update cro_country_factor set factor=0.7723 where country_id in (select id from country where abbreviation='ISR');
update cro_country_factor set factor=0.9075 where country_id in (select id from country where abbreviation='NA');
update cro_country_factor set factor=0.7223 where country_id in (select id from country where abbreviation='NET');
update cro_country_factor set factor=0.8288 where country_id in (select id from country where abbreviation='PA');
update cro_country_factor set factor=0.402 where country_id in (select id from country where abbreviation='SAF');
update cro_country_factor set factor=0.7231 where country_id in (select id from country where abbreviation='SC');
update cro_country_factor set factor=0.6364 where country_id in (select id from country where abbreviation='SWE');
update cro_country_factor set factor=0.8474 where country_id in (select id from country where abbreviation='SWI');
update cro_country_factor set factor=0.8144 where country_id in (select id from country where abbreviation='UK');
update cro_country_factor set factor=1 where country_id in (select id from country where abbreviation='USA');
update cro_country_factor set factor=0.8236 where country_id in (select id from country where abbreviation='WE');
update cro_country_factor set factor=0.4015 where country_id in (select id from country where abbreviation='MA');
commit;


update country set abbreviation='EEU' where abbreviation='EAE';
update country set abbreviation='WEU' where abbreviation='WE';
commit;

-- deployed in tsm10e@TEST upto this on 5-8-2006 at 1am
-- deployed in tsm10t@prev upto this on 5-8-2006 at 1am

-- Following changes are as as per the request of Phil on 05/10/2006 at 1pm

update cro_component set component_type=8 where id in (99,104);
commit;

UPDATE cro_component SET component_type=1 WHERE id IN (167, 1001);
UPDATE cro_component SET component_type=2 WHERE id=144;
commit;

-- Following changes are as per the problems found by Anita and emails from Nadine on 05-23-2006

alter table cro_budget modify TOTAL_COST	NUMBER(18,2);
alter table cro_budget modify TOTAL_COST_LOCAL	NUMBER(18,2);
alter table cro_budget modify ALT_TOTAL_COST	NUMBER(18,2);

alter table cro_budget_input modify BUDGET_VALUE	NUMBER(18,2);

alter table cro_category_rollup modify LOW_PRICE	NUMBER(18,2);
alter table cro_category_rollup modify  MEDIUM_PRICE	NUMBER(18,2);
alter table cro_category_rollup modify  HIGH_PRICE	NUMBER(18,2);
alter table cro_category_rollup modify  SELECTED_PRICE	NUMBER(18,2);
alter table cro_category_rollup modify TOTAL_PRICE	NUMBER(18,2);
 
alter table cro_odc_item modify LOW_PRICE	NUMBER(18,2);
alter table cro_odc_item modify  MED_PRICE	NUMBER(18,2);
alter table cro_odc_item modify  HIGH_PRICE	NUMBER(18,2);
alter table cro_odc_item modify  SELECTED_PRICE	NUMBER(18,2);
alter table cro_odc_item modify  TOTAL_PRICE	NUMBER(18,2);
alter table cro_odc_item modify  ALT_TOTAL_PRICE 	NUMBER(18,2);


-- deployed in tsm10e@TEST upto this on 5-12-2006 at 5pm
-- deployed in tsm10t@prev upto this on 5-12-2006 at 5pm
-- deployed in tsm10e@prev upto this on 6-11-2006 at 6:30pm

-- Following changes are as per the request of Tonya on 6/22 at 8 am


delete from cro_choice_factor where cro_choice_id in (select id from cro_choice where cro_component_id=122);
delete from cro_choice where cro_component_id=122;

insert into cro_choice(ID,cro_component_id,low_range,high_range,short_desc) values
(336,122,1,3,'1-3');
insert into cro_choice(ID,cro_component_id,low_range,high_range,short_desc) values
(337,122,4,10,'4-10');
insert into cro_choice(ID,cro_component_id,low_range,high_range,short_desc) values
(338,122,11,20,'11-20');
insert into cro_choice(ID,cro_component_id,low_range,high_range,short_desc) values
(339,122,21,1000000,'21+');
commit;

delete from cro_choice_factor where id between 665 and 672;
insert into cro_choice_factor(ID,cro_type,cro_choice_id,factor) values (665,1,336,1);
insert into cro_choice_factor(ID,cro_type,cro_choice_id,factor) values (666,2,336,1);
insert into cro_choice_factor(ID,cro_type,cro_choice_id,factor) values (667,1,337,0.8);
insert into cro_choice_factor(ID,cro_type,cro_choice_id,factor) values (668,2,337,0.8);
insert into cro_choice_factor(ID,cro_type,cro_choice_id,factor) values (669,1,338,0.75);
insert into cro_choice_factor(ID,cro_type,cro_choice_id,factor) values (670,2,338,0.75);
insert into cro_choice_factor(ID,cro_type,cro_choice_id,factor) values (671,1,339,0.7);
insert into cro_choice_factor(ID,cro_type,cro_choice_id,factor) values (672,2,339,0.7);
commit;

-- deployed in tsm10e@TEST upto this on 6-22-2006 at 9:30am

-- deployed in tsm10t@prev upto this on 6-22-2006 at 9:30am
-- deployed in tsm10e@prev upto this on 6-22-2006 at 9:30am
-- deployed in tsm10g@prod upto this on 7-8-2006 at 5:30pm
-- deployed in tsm10@prod upto this on 7-16-2006 at 10:30am
-- deployed in tsm10e@prod upto this on 7-16-2006 at 10:30am

update cro_role_inst a set a.CRO_RATE=(select b.cro_rate from
role_inst b where b.ROLE_TEMPLATE_ID=a.ROLE_TEMPLATE_ID
and b.rate_set_id=2) where a.cro_rate_set_id=1;

commit;

-- deployed in tsm10e@TEST upto this on 8-22-2006 at 3:12 pm
-- deployed in tsm10t@prev upto this on 8-25-2006 at 10:56am
-- deployed in tsm10e@prev upto this on 8-25-2006 at 10:56am
-- deployed in tsm10g@prod upto this on 8-25-2006 at 10:56am
-- deployed in tsm10@prod upto this on 8-25-2006 at 10:56am
-- deployed in tsm10e@prod upto this on 8-25-2006 at 10:56am

-- Following changes are as per the request of Lori on 09/15/2006 at 11:10am

update cro_role_inst set cro_rate=350 where id=1 and role_template_id=1and cro_rate_set_id=1;
update cro_role_inst set cro_rate=210 where id=2 and role_template_id=11and cro_rate_set_id=1;
update cro_role_inst set cro_rate=84 where id=3 and role_template_id=21and cro_rate_set_id=1;
update cro_role_inst set cro_rate=350 where id=4 and role_template_id=2and cro_rate_set_id=1;
update cro_role_inst set cro_rate=210 where id=5 and role_template_id=46and cro_rate_set_id=1;
update cro_role_inst set cro_rate=210 where id=6 and role_template_id=47and cro_rate_set_id=1;
update cro_role_inst set cro_rate=84 where id=7 and role_template_id=22and cro_rate_set_id=1;
update cro_role_inst set cro_rate=350 where id=8 and role_template_id=3and cro_rate_set_id=1;
update cro_role_inst set cro_rate=210 where id=9 and role_template_id=18and cro_rate_set_id=1;
update cro_role_inst set cro_rate=100 where id=10 and role_template_id=23and cro_rate_set_id=1;
update cro_role_inst set cro_rate=350 where id=11 and role_template_id=4and cro_rate_set_id=1;
update cro_role_inst set cro_rate=210 where id=12 and role_template_id=12and cro_rate_set_id=1;
update cro_role_inst set cro_rate=100 where id=13 and role_template_id=43and cro_rate_set_id=1;
update cro_role_inst set cro_rate=185 where id=14 and role_template_id=19and cro_rate_set_id=1;
update cro_role_inst set cro_rate=155 where id=15 and role_template_id=20and cro_rate_set_id=1;
update cro_role_inst set cro_rate=350 where id=16 and role_template_id=5and cro_rate_set_id=1;
update cro_role_inst set cro_rate=210 where id=17 and role_template_id=13and cro_rate_set_id=1;
update cro_role_inst set cro_rate=168 where id=18 and role_template_id=29and cro_rate_set_id=1;
update cro_role_inst set cro_rate=140 where id=19 and role_template_id=30and cro_rate_set_id=1;
update cro_role_inst set cro_rate=84 where id=20 and role_template_id=24and cro_rate_set_id=1;
update cro_role_inst set cro_rate=84 where id=21 and role_template_id=48and cro_rate_set_id=1;
update cro_role_inst set cro_rate=350 where id=22 and role_template_id=6and cro_rate_set_id=1;
update cro_role_inst set cro_rate=210 where id=23 and role_template_id=14and cro_rate_set_id=1;
update cro_role_inst set cro_rate=210 where id=24 and role_template_id=32and cro_rate_set_id=1;
update cro_role_inst set cro_rate=140 where id=25 and role_template_id=33and cro_rate_set_id=1;
update cro_role_inst set cro_rate=84 where id=26 and role_template_id=44and cro_rate_set_id=1;
update cro_role_inst set cro_rate=350 where id=27 and role_template_id=7and cro_rate_set_id=1;
update cro_role_inst set cro_rate=210 where id=28 and role_template_id=15and cro_rate_set_id=1;
update cro_role_inst set cro_rate=210 where id=29 and role_template_id=34and cro_rate_set_id=1;
update cro_role_inst set cro_rate=210 where id=30 and role_template_id=35and cro_rate_set_id=1;
update cro_role_inst set cro_rate=84 where id=31 and role_template_id=25and cro_rate_set_id=1;
update cro_role_inst set cro_rate=350 where id=32 and role_template_id=8and cro_rate_set_id=1;
update cro_role_inst set cro_rate=210 where id=33 and role_template_id=16and cro_rate_set_id=1;
update cro_role_inst set cro_rate=140 where id=34 and role_template_id=36and cro_rate_set_id=1;
update cro_role_inst set cro_rate=140 where id=35 and role_template_id=37and cro_rate_set_id=1;
update cro_role_inst set cro_rate=84 where id=36 and role_template_id=26and cro_rate_set_id=1;
update cro_role_inst set cro_rate=350 where id=37 and role_template_id=45and cro_rate_set_id=1;
update cro_role_inst set cro_rate=210 where id=38 and role_template_id=17and cro_rate_set_id=1;
update cro_role_inst set cro_rate=168 where id=39 and role_template_id=38and cro_rate_set_id=1;
update cro_role_inst set cro_rate=140 where id=40 and role_template_id=39and cro_rate_set_id=1;
update cro_role_inst set cro_rate=84 where id=41 and role_template_id=27and cro_rate_set_id=1;
update cro_role_inst set cro_rate=350 where id=42 and role_template_id=10and cro_rate_set_id=1;
update cro_role_inst set cro_rate=210 where id=43 and role_template_id=42and cro_rate_set_id=1;
update cro_role_inst set cro_rate=210 where id=44 and role_template_id=40and cro_rate_set_id=1;
update cro_role_inst set cro_rate=210 where id=45 and role_template_id=41and cro_rate_set_id=1;
update cro_role_inst set cro_rate=84 where id=46 and role_template_id=28and cro_rate_set_id=1;
commit;

--************************************************************
-- deployed in tsm10e@TEST upto this on 9-15-2006 at 11:55 am
-- deployed in tsm10t@prev upto this on 9-15-2006 at 1:10 pm
-- deployed in tsm10e@prev upto this on 9-15-2006 at 1:10 pm
-- deployed in tsm10g@prod upto this on 9-15-2006 at 1:10 pm
-- deployed in tsm10@prod upto this on 9-15-2006 at 1:10 pm
-- deployed in tsm10e@prod upto this on 9-15-2006 at 1:10 pm

--************************************************************
---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  28   DevTSM    1.27        2/22/2008 11:56:03 AMDebashish Mishra  
--  27   DevTSM    1.26        12/11/2006 12:00:58 AMDebashish Mishra  
--  26   DevTSM    1.25        9/19/2006 12:11:33 AMDebashish Mishra   
--  25   DevTSM    1.24        9/15/2006 12:01:16 PMDebashish Mishra  
--  24   DevTSM    1.23        9/4/2006 2:54:07 PM  Debashish Mishra  
--  23   DevTSM    1.22        8/16/2006 1:48:07 PM Debashish Mishra  
--  22   DevTSM    1.21        6/23/2006 7:57:55 AM Debashish Mishra  
--  21   DevTSM    1.20        5/23/2006 8:27:33 AM Debashish Mishra  
--  20   DevTSM    1.19        5/2/2006 7:36:50 AM  Debashish Mishra  
--  19   DevTSM    1.18        4/28/2006 6:21:23 AM Debashish Mishra  
--  18   DevTSM    1.17        4/9/2006 1:05:23 PM  Debashish Mishra  
--  17   DevTSM    1.16        3/30/2006 6:35:03 PM Debashish Mishra  
--  16   DevTSM    1.15        3/26/2006 10:38:13 AMDebashish Mishra  
--  15   DevTSM    1.14        3/12/2006 1:23:40 AM Debashish Mishra  
--  14   DevTSM    1.13        3/1/2006 8:32:26 AM  Debashish Mishra  
--  13   DevTSM    1.12        2/22/2006 7:56:52 AM Debashish Mishra  
--  12   DevTSM    1.11        2/13/2006 9:11:51 AM Debashish Mishra  
--  11   DevTSM    1.10        2/7/2006 11:35:27 AM Debashish Mishra  
--  10   DevTSM    1.9         2/2/2006 12:41:54 PM Debashish Mishra  
--  9    DevTSM    1.8         1/11/2006 12:15:42 PMDebashish Mishra  
--  8    DevTSM    1.7         12/21/2005 6:28:31 PMDebashish Mishra   
--  7    DevTSM    1.6         11/29/2005 5:15:27 AMDebashish Mishra  
--  6    DevTSM    1.5         11/21/2005 8:12:07 AMDebashish Mishra  
--  5    DevTSM    1.4         11/16/2005 2:05:09 PMDebashish Mishra  
--  4    DevTSM    1.3         11/4/2005 9:45:59 AM Debashish Mishra  
--  3    DevTSM    1.2         10/26/2005 3:43:41 PMDebashish Mishra  
--  2    DevTSM    1.1         10/17/2005 6:05:11 AMDebashish Mishra  
--  1    DevTSM    1.0         9/29/2005 11:17:47 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
