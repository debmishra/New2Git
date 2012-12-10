--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: Schema_updatres_after_trace_beta.sql$ 
--
-- $Revision: 24$        $Date: 2/22/2008 11:55:21 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
-- Following changes are as per the request of Phil on 08/29/2002 at 17:45

Alter table "&1".trial_budget add(
	modeled_odc_pct number(12,2),
	modeled_oh_pct number(12,2),
	modeled_odc_pct_range varchar2(40),   
	modeled_oh_type varchar2(40));

Alter table "&1".trial_budget add constraint tb_modeled_odc_pct_range_check
check (modeled_odc_pct_range in ('Modelled', 'Manual'));

Alter table "&1".trial_budget add constraint tb_modeled_oh_type_check
check (modeled_oh_type in ('Modelled', 'Manual'));

-- Following chnages are as per the request of Colin on 09/03/2002 at 12:45

create table "&1".modelled_coeff (
	id number (10),
	country_id number (10) not null,
	coeff_type varchar2(7) not null,
	coeff_value varchar2(20),
	cross_coeff_type varchar2(7),
	cross_coeff_value varchar2(20),
	coeff number(20,12))
	tablespace tsmsmall 
	pctused 60 pctfree 20;

Alter table "&1".modelled_coeff add constraint modelled_coeff_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 20;

Alter table "&1".modelled_coeff add constraint modelled_coeff_FK1
	foreign key (COUNTRY_ID) references "&1".country(id);


create sequence "&1".modelled_coeff_seq;

-- Following chnages are as per the request of Colin on 09/04/2002 at 10:20 am

Create table "&1".md_odc_oh_pct
	(id number (10),
	country_id number (10) not null, 
	ta_id number(10) not null, 
	oh_pct number(7,2) ,
	odc_pct number(7,2))
	tablespace tsmsmall 
	pctused 60 pctfree 20;

Alter table "&1".MD_ODC_OH_PCT add constraint MD_ODC_OH_PCT_PK 
	primary key(ID) using index tablespace tsmsmall_indx 
	pctfree 20 ;

Alter table "&1".MD_ODC_OH_PCT add constraint MD_ODC_OH_PCT_FK1
	foreign key (COUNTRY_ID) references "&1".country(id);

Alter table "&1".MD_ODC_OH_PCT add constraint MD_ODC_OH_PCT_FK2
	foreign key (TA_ID) references "&1".indmap(id);

create sequence "&1".md_odc_oh_pct_seq;

-- Following chnages are as per the request of Colin on 09/11/2002 at 10am

Update "&1".ip_business_factors set num_days = 14 where type = 'Ph2+dur' and 
	short_desc like '%1-3 weeks%';
Update "&1".ip_business_factors set num_days = 39 where type = 'Ph2+dur' and 
	short_desc like '%4-7 weeks%';
Update "&1".ip_business_factors set num_days = 67 where type = 'Ph2+dur' and 
	short_desc like '%8-11 weeks%';
Update "&1".ip_business_factors set num_days = 112 where type = 'Ph2+dur' and 
	short_desc like '%12-20 weeks%';
Update "&1".ip_business_factors set num_days = 161 where type = 'Ph2+dur' and 
	short_desc like '%21-25 weeks%';
Update "&1".ip_business_factors set num_days = 203 where type = 'Ph2+dur' and 
	short_desc like '%26-32 weeks%';
Update "&1".ip_business_factors set num_days = 256 where type = 'Ph2+dur' and 
	short_desc like '%33-40 weeks%';
Update "&1".ip_business_factors set num_days = 298 where type = 'Ph2+dur' and 
	short_desc like '%41-44 weeks%';
Update "&1".ip_business_factors set num_days = 340 where type = 'Ph2+dur' and 
	short_desc like '%45-52 weeks%';
Update "&1".ip_business_factors set num_days = 389 where type = 'Ph2+dur' and 
	short_desc like '%53-58 weeks%';
Update "&1".ip_business_factors set num_days = 548 where type = 'Ph2+dur' and 
	short_desc like '%1-2 years%';
Update "&1".ip_business_factors set num_days = 913 where type = 'Ph2+dur' and 
	short_desc like '%2-3 years%';
Update "&1".ip_business_factors set num_days = 1095 where type = 'Ph2+dur' and 
	short_desc like '%>3 years%';
commit;


-- Following chnages are as per the request of Kelly on 09/13/2002 at 11am


Alter table "&1".client_div_to_lic_app add(version varchar2(30));
update "&1".client_div_to_lic_app set version = 'v1';
Alter table "&1".client_div_to_lic_app modify (version not null);



-- Following changes are for the ftcommon related chnages on 09/12/2002
-- and will fail if proper grants has not been given to ftcommon from ft15 and tsm10 schema's.

-- In case of problem run the following manually after loggin into tsm10 schema
--conn tsm10/***
--grant select on client_div to ftcommon;
--grant select on CLIENT_DIV_TO_LIC_APP to ftcommon;
--grant select on ftuser_to_client_group to ftcommon;

create or replace view ftcommon.client_div as select
ID,CLIENT_ID,NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,
STARTING_VIEW,COUNTRY_ID,BUILD_TAG_ID,USE_OWN_CNV_FLG,
DEF_PRICE_RANGE,LOGON_TIMEOUT_SECS,
ISO_LANG,'tsm10' environment from tsm10.client_div;

create or replace view ftcommon.CLIENT_DIV_TO_LIC_APP as select
ID,CLIENT_DIV_ID,APP_NAME,LICENSE_EXP_DATE,
PRINCIPAL_CONTACT_ID,VERSION,'tsm10' environment from tsm10.CLIENT_DIV_TO_LIC_APP;

create or replace view ftcommon.ftuser_to_client_group as select
ID,CLIENT_GROUP_ID,FTUSER_ID,'tsm10' environment from tsm10.ftuser_to_client_group;

-- Following chnages are as per the request of Kelly on 09/16/2002 at 11:45am


create table ftcommon.application(
	id number(10),
	app_name varchar2(50),
	external_name varchar2(80),
	short_desc varchar2(128))
	tablespace tsmsmall
	pctused 80 pctfree 10;

create sequence ftcommon.application_seq;

Alter table ftcommon.application add constraint application_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 10;

Alter table ftcommon.application add constraint application_app_name_check check(
	app_name in ('DASHBOARD', 'PICASE', 'TRACE'));

Insert into ftcommon.application values
(ftcommon.application_seq.nextval,'TRACE','TrialSpace Resource and Cost Estimator',null);
Insert into ftcommon.application values
(ftcommon.application_seq.nextval,'PICASE','TrialSpace Grants Manager',null);

commit;	

-- Following chnages are as per the request opf Kelly on 09/17/2002 at 8:30 am

update "&1".task_template set start_milestone_template_id=5 where 
start_milestone_template_id=4 and end_milestone_template_id=6;
commit;

-- Following changes are as per the request of Colin on 09/24/2002


create table "&1".modelled_inclusion (
	id number (10),
 	coeff_type varchar2(7) not null,
	coeff_value varchar2(20))
	tablespace tsmsmall 
	pctused 60 pctfree 20;

Alter table "&1".modelled_inclusion add constraint modelled_inclusion_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 20;

create sequence "&1".modelled_inclusion_seq;

Create table "&1".modelled_upfence(
	id number(10),
	country_id number(10) not null,
	ta_id number(10) not null,
	upfence number(20,12) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 20;

Alter table "&1".modelled_upfence add constraint modelled_upfence_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 20;

create sequence "&1".modelled_upfence_seq;

Alter table "&1".modelled_upfence add constraint modelled_upfence_FK1
	foreign key (COUNTRY_ID) references "&1".country(id);

Alter table "&1".modelled_upfence add constraint modelled_upfence_FK2
	foreign key (TA_ID) references "&1".indmap(id);

Create table "&1".modelled_standardize(
	id number(10),
	country_id number(10), 
	type varchar2(10) not null,
	patient number(10) not null,
	duration number(20,12) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 20;

Alter table "&1".modelled_standardize add constraint modelled_standardize_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 20;

create sequence "&1".modelled_standardize_seq;

Alter table "&1".modelled_standardize add constraint modelled_standardize_FK1
	foreign key (COUNTRY_ID) references "&1".country(id);

Alter table "&1".modelled_standardize add constraint ms_type_check check(
	type in ('LOCATION','SCALE','ADD','MULT','N'));


-- Following chnages are as per the request of Kelly on 09/30/2002 at 2:20 pm

update "&1".task_template set start_milestone_template_id=5, end_milestone_template_id=6  
WHERE start_milestone_template_id=6 AND end_milestone_template_id=7;

commit;

-- Following chnages are as per the request of Kelly on 10/02/2002 at 10:00 am

update "&1".task_template set start_milestone_template_id=6, end_milestone_template_id=7 
where id in (82,102,106,109,117);

commit;


-- Following chnages are as per the request of Kelly on 10/02/2002 at 17:15 am

update "&1".task_template set end_milestone_template_id=7 where id=62;

commit;

update "&1".task_template set start_milestone_template_id=6, end_milestone_template_id=7 
where id in (52);

commit;


-- Following chnages are done by DB on 10/04/2002 at 8:30 am

create table "&1".id_control(
	table_owner varchar2(40),
	table_name varchar2(40),
	next_id number(10) not null)
	tablespace tsmsmall
	pctused 80 pctfree 10;

Alter table "&1".id_control add constraint id_control_pk
	primary key (table_owner,table_name) using index tablespace
	tsmsmall_indx pctfree 10;

Alter table "&1".id_control add constraint id_control_uq1
	unique (table_name) using index tablespace 
	tsmsmall_indx pctfree 10;


Insert into "&1".id_control select 'ft15', 'aclentries', nvl(max(id),0)+1 from "&1".ACLENTRIES ;
Insert into "&1".id_control select 'tsm10', 'add_study', nvl(max(id),0)+1 from "&1".ADD_STUDY ;
Insert into "&1".id_control select 'tsm10', 'affiliation_factor', nvl(max(id),0)+1 from "&1".AFFILIATION_FACTOR ;
Insert into "&1".id_control select 'tsm10', 'audit_hist', nvl(max(id),0)+1 from "&1".AUDIT_HIST ;
Insert into "&1".id_control select 'tsm10', 'budget_group_permission', nvl(max(id),0)+1 from "&1".BUDGET_GROUP_PERMISSION ;
Insert into "&1".id_control select 'tsm10', 'budget_user_permission', nvl(max(id),0)+1 from "&1".BUDGET_USER_PERMISSION ;
Insert into "&1".id_control select 'tsm10', 'build_code', nvl(max(id),0)+1 from "&1".BUILD_CODE ;
Insert into "&1".id_control select 'tsm10', 'build_tag', nvl(max(id),0)+1 from "&1".BUILD_TAG ;
Insert into "&1".id_control select 'tsm10', 'build_tag_to_client_div', nvl(max(id),0)+1 from "&1".BUILD_TAG_TO_CLIENT_DIV ;
Insert into "&1".id_control select 'ft15', 'client', nvl(max(id),0)+1 from "&1".CLIENT ;
Insert into "&1".id_control select 'tsm10', 'client_currency_cnv', nvl(max(id),0)+1 from "&1".CLIENT_CURRENCY_CNV ;
Insert into "&1".id_control select 'tsm10', 'client_div', nvl(max(id),0)+1 from "&1".CLIENT_DIV ;
Insert into "&1".id_control select 'tsm10', 'client_div_to_build_code', nvl(max(id),0)+1 from "&1".CLIENT_DIV_TO_BUILD_CODE ;
Insert into "&1".id_control select 'tsm10', 'client_div_to_lic_app', nvl(max(id),0)+1 from "&1".CLIENT_DIV_TO_LIC_APP ;
Insert into "&1".id_control select 'tsm10', 'client_div_to_lic_country', nvl(max(id),0)+1 from "&1".CLIENT_DIV_TO_LIC_COUNTRY ;
Insert into "&1".id_control select 'tsm10', 'client_div_to_lic_indmap', nvl(max(id),0)+1 from "&1".CLIENT_DIV_TO_LIC_INDMAP ;
Insert into "&1".id_control select 'tsm10', 'client_div_to_lic_phase', nvl(max(id),0)+1 from "&1".CLIENT_DIV_TO_LIC_PHASE ;
Insert into "&1".id_control select 'tsm10', 'client_group', nvl(max(id),0)+1 from "&1".CLIENT_GROUP ;
Insert into "&1".id_control select 'tsm10', 'cost_item', nvl(max(id),0)+1 from "&1".COST_ITEM ;
Insert into "&1".id_control select 'tsm10', 'country', nvl(max(id),0)+1 from "&1".COUNTRY ;
Insert into "&1".id_control select 'tsm10', 'currency', nvl(max(id),0)+1 from "&1".CURRENCY ;
Insert into "&1".id_control select 'tsm10', 'custom_set', nvl(max(id),0)+1 from "&1".CUSTOM_SET ;
Insert into "&1".id_control select 'tsm10', 'custom_set_item', nvl(max(id),0)+1 from "&1".CUSTOM_SET_ITEM ;
Insert into "&1".id_control select 'tsm10', 'def_publish_groups', nvl(max(id),0)+1 from "&1".DEF_PUBLISH_GROUPS ;
Insert into "&1".id_control select 'tsm10', 'drug_class', nvl(max(id),0)+1 from "&1".DRUG_CLASS ;
Insert into "&1".id_control select 'tsm10', 'drug_code', nvl(max(id),0)+1 from "&1".DRUG_CODE ;
Insert into "&1".id_control select 'ft15', 'ftgroup', nvl(max(id),0)+1 from "&1".FTGROUP ;
Insert into "&1".id_control select 'ft15', 'ftgroup_to_aclentries', nvl(max(id),0)+1 from "&1".FTGROUP_TO_ACLENTRIES ;
Insert into "&1".id_control select 'ft15', 'ftuser', nvl(max(id),0)+1 from "&1".FTUSER ;
Insert into "&1".id_control select 'ft15', 'ftuser_to_aclentries', nvl(max(id),0)+1 from "&1".FTUSER_TO_ACLENTRIES ;
Insert into "&1".id_control select 'tsm10', 'ftuser_to_client_group', nvl(max(id),0)+1 from "&1".FTUSER_TO_CLIENT_GROUP ;
Insert into "&1".id_control select 'ft15', 'ftuser_to_ftgroup', nvl(max(id),0)+1 from "&1".FTUSER_TO_FTGROUP ;
Insert into "&1".id_control select 'ft15', 'ft_foreign_key_info', nvl(max(id),0)+1 from "&1".FT_FOREIGN_KEY_INFO ;
Insert into "&1".id_control select 'tsm10', 'indmap', nvl(max(id),0)+1 from "&1".INDMAP ;
Insert into "&1".id_control select 'tsm10', 'institution', nvl(max(id),0)+1 from "&1".INSTITUTION ;
Insert into "&1".id_control select 'tsm10', 'investig', nvl(max(id),0)+1 from "&1".INVESTIG ;
Insert into "&1".id_control select 'tsm10', 'ip_business_factors', nvl(max(id),0)+1 from "&1".IP_BUSINESS_FACTORS ;
Insert into "&1".id_control select 'tsm10', 'ip_cpp', nvl(max(id),0)+1 from "&1".IP_CPP ;
Insert into "&1".id_control select 'tsm10', 'ip_duration', nvl(max(id),0)+1 from "&1".IP_DURATION ;
Insert into "&1".id_control select 'tsm10', 'ip_duration_factor', nvl(max(id),0)+1 from "&1".IP_DURATION_FACTOR ;
Insert into "&1".id_control select 'tsm10', 'ip_session', nvl(max(id),0)+1 from "&1".IP_SESSION ;
Insert into "&1".id_control select 'tsm10', 'ip_weight', nvl(max(id),0)+1 from "&1".IP_WEIGHT ;
Insert into "&1".id_control select 'tsm10', 'local_to_euro', nvl(max(id),0)+1 from "&1".LOCAL_TO_EURO ;
Insert into "&1".id_control select 'tsm10', 'location_set', nvl(max(id),0)+1 from "&1".LOCATION_SET ;
Insert into "&1".id_control select 'tsm10', 'location_set_item', nvl(max(id),0)+1 from "&1".LOCATION_SET_ITEM ;
Insert into "&1".id_control select 'tsm10', 'mapper', nvl(max(id),0)+1 from "&1".MAPPER ;
Insert into "&1".id_control select 'tsm10', 'md_odc_oh_pct', nvl(max(id),0)+1 from "&1".MD_ODC_OH_PCT ;
Insert into "&1".id_control select 'tsm10', 'medicare', nvl(max(id),0)+1 from "&1".MEDICARE ;
Insert into "&1".id_control select 'tsm10', 'milestone_inst', nvl(max(id),0)+1 from "&1".MILESTONE_INST ;
Insert into "&1".id_control select 'tsm10', 'milestone_template', nvl(max(id),0)+1 from "&1".MILESTONE_TEMPLATE ;
Insert into "&1".id_control select 'tsm10', 'modelled_coeff', nvl(max(id),0)+1 from "&1".MODELLED_COEFF ;
Insert into "&1".id_control select 'tsm10', 'modelled_inclusion', nvl(max(id),0)+1 from "&1".MODELLED_INCLUSION ;
Insert into "&1".id_control select 'tsm10', 'modelled_standardize', nvl(max(id),0)+1 from "&1".MODELLED_STANDARDIZE ;
Insert into "&1".id_control select 'tsm10', 'modelled_upfence', nvl(max(id),0)+1 from "&1".MODELLED_UPFENCE ;
Insert into "&1".id_control select 'tsm10', 'odc_def', nvl(max(id),0)+1 from "&1".ODC_DEF ;
Insert into "&1".id_control select 'tsm10', 'pap_euro_overhead', nvl(max(id),0)+1 from "&1".PAP_EURO_OVERHEAD ;
Insert into "&1".id_control select 'tsm10', 'pap_odc_pct', nvl(max(id),0)+1 from "&1".PAP_ODC_PCT ;
Insert into "&1".id_control select 'tsm10', 'pap_odc_pct_to_indmap', nvl(max(id),0)+1 from "&1".PAP_ODC_PCT_TO_INDMAP ;
Insert into "&1".id_control select 'tsm10', 'payments', nvl(max(id),0)+1 from "&1".PAYMENTS ;
Insert into "&1".id_control select 'tsm10', 'phase', nvl(max(id),0)+1 from "&1".PHASE ;
Insert into "&1".id_control select 'tsm10', 'picas_visit', nvl(max(id),0)+1 from "&1".PICAS_VISIT ;
Insert into "&1".id_control select 'tsm10', 'picas_visit_set', nvl(max(id),0)+1 from "&1".PICAS_VISIT_SET ;
Insert into "&1".id_control select 'tsm10', 'picas_visit_set_item', nvl(max(id),0)+1 from "&1".PICAS_VISIT_SET_ITEM ;
Insert into "&1".id_control select 'tsm10', 'picas_visit_to_cost_item', nvl(max(id),0)+1 from "&1".PICAS_VISIT_TO_COST_ITEM ;
Insert into "&1".id_control select 'tsm10', 'price_level', nvl(max(id),0)+1 from "&1".PRICE_LEVEL ;
Insert into "&1".id_control select 'tsm10', 'procedure_def', nvl(max(id),0)+1 from "&1".PROCEDURE_DEF ;
Insert into "&1".id_control select 'tsm10', 'procedure_to_protocol', nvl(max(id),0)+1 from "&1".PROCEDURE_TO_PROTOCOL ;
Insert into "&1".id_control select 'tsm10', 'project', nvl(max(id),0)+1 from "&1".PROJECT ;
Insert into "&1".id_control select 'tsm10', 'project_area', nvl(max(id),0)+1 from "&1".PROJECT_AREA ;
Insert into "&1".id_control select 'tsm10', 'project_phase', nvl(max(id),0)+1 from "&1".PROJECT_PHASE ;
Insert into "&1".id_control select 'tsm10', 'protocol', nvl(max(id),0)+1 from "&1".PROTOCOL ;
Insert into "&1".id_control select 'tsm10', 'protocol_to_indmap', nvl(max(id),0)+1 from "&1".PROTOCOL_TO_INDMAP ;
Insert into "&1".id_control select 'ft15', 'protocol_version', nvl(max(id),0)+1 from "&1".PROTOCOL_VERSION ;
Insert into "&1".id_control select 'tsm10', 'rate_set', nvl(max(id),0)+1 from "&1".RATE_SET ;
Insert into "&1".id_control select 'tsm10', 'region', nvl(max(id),0)+1 from "&1".REGION ;
Insert into "&1".id_control select 'tsm10', 'report_template', nvl(max(id),0)+1 from "&1".REPORT_TEMPLATE ;
Insert into "&1".id_control select 'tsm10', 'role_inst', nvl(max(id),0)+1 from "&1".ROLE_INST ;
Insert into "&1".id_control select 'tsm10', 'role_inst_to_task_inst', nvl(max(id),0)+1 from "&1".ROLE_INST_TO_TASK_INST ;
Insert into "&1".id_control select 'tsm10', 'role_template', nvl(max(id),0)+1 from "&1".ROLE_TEMPLATE ;
Insert into "&1".id_control select 'tsm10', 'role_to_task_template', nvl(max(id),0)+1 from "&1".ROLE_TO_TASK_TEMPLATE ;
Insert into "&1".id_control select 'tsm10', 'specificity', nvl(max(id),0)+1 from "&1".SPECIFICITY ;
Insert into "&1".id_control select 'ft15', 'sponsor', nvl(max(id),0)+1 from "&1".SPONSOR ;
Insert into "&1".id_control select 'tsm10', 'task_group_inst', nvl(max(id),0)+1 from "&1".TASK_GROUP_INST ;
Insert into "&1".id_control select 'tsm10', 'task_group_template', nvl(max(id),0)+1 from "&1".TASK_GROUP_TEMPLATE ;
Insert into "&1".id_control select 'tsm10', 'task_inst', nvl(max(id),0)+1 from "&1".TASK_INST ;
Insert into "&1".id_control select 'tsm10', 'task_template', nvl(max(id),0)+1 from "&1".TASK_TEMPLATE ;
Insert into "&1".id_control select 'tsm10', 'temp_inst_to_company', nvl(max(id),0)+1 from "&1".TEMP_INST_TO_COMPANY ;
Insert into "&1".id_control select 'tsm10', 'temp_ip_study_price', nvl(max(id),0)+1 from "&1".TEMP_IP_STUDY_PRICE ;
Insert into "&1".id_control select 'tsm10', 'temp_odc', nvl(max(id),0)+1 from "&1".TEMP_ODC ;
Insert into "&1".id_control select 'tsm10', 'temp_overhead', nvl(max(id),0)+1 from "&1".TEMP_OVERHEAD ;
Insert into "&1".id_control select 'tsm10', 'temp_procedure', nvl(max(id),0)+1 from "&1".TEMP_PROCEDURE ;
Insert into "&1".id_control select 'tsm10', 'trace_estimate', nvl(max(id),0)+1 from "&1".TRACE_ESTIMATE ;
Insert into "&1".id_control select 'tsm10', 'trace_user_prefs', nvl(max(id),0)+1 from "&1".TRACE_USER_PREFS ;
Insert into "&1".id_control select 'ft15', 'trial', nvl(max(id),0)+1 from "&1".TRIAL ;
Insert into "&1".id_control select 'tsm10', 'trial_budget', nvl(max(id),0)+1 from "&1".TRIAL_BUDGET ;
Insert into "&1".id_control select 'ft15', 'trial_metrics_history', nvl(max(id),0)+1 from "&1".TRIAL_METRICS_HISTORY ;
Insert into "&1".id_control select 'tsm10', 'tsm_message', nvl(max(id),0)+1 from "&1".TSM_MESSAGE ;
Insert into "&1".id_control select 'tsm10', 'tsm_trial_rollup', nvl(max(id),0)+1 from "&1".TSM_TRIAL_ROLLUP ;
Insert into "&1".id_control select 'tsm10', 'umbrella_orgs', nvl(max(id),0)+1 from "&1".UMBRELLA_ORGS ;
Insert into "&1".id_control select 'tsm10', 'unlisted_procedure', nvl(max(id),0)+1 from "&1".UNLISTED_PROCEDURE ;
Insert into "&1".id_control select 'ft15', 'usage_history', nvl(max(id),0)+1 from "&1".USAGE_HISTORY ;
Insert into "&1".id_control select 'tsm10', 'user_pref', nvl(max(id),0)+1 from "&1".USER_PREF ;
Insert into "&1".id_control select 'tsm10', 'working_trial', nvl(max(id),0)+1 from "&1".WORKING_TRIAL ;

commit;



create or replace function "&1".Increment_sequence (seq_name in varchar2,
increment_by in number default 1)  return number is
pragma autonomous_transaction;

start_value number(10);

begin

select next_id into start_value from "&1".id_control where 
table_name = lower(substr(seq_name,1,length(seq_name)-4))
for update;

update "&1".id_control set next_id = next_id+increment_by where 
table_name = lower(substr(seq_name,1,length(seq_name)-4));

commit;
return(start_value);

end;
/

-- Following chnages are as per Debashish for migrating #6002-4 codes

Insert into "&1".odc_def select "&1".odc_def_seq.nextval,CPT_CODE,LONG_DESC,
OBSOLETE_FLG,OBSOLETE_DATE,PROCEDURE_LEVEL,ADDED_IN_BUILD_ID,1
from "&1".procedure_def where cpt_code in ('#6002','#6003','#6004');


/* Then Manually decide what need to be inserted into the mapper table */
/* and which mapper table */
/* Also follwing delete statements will fail if all client mapper tables */
/* are not taken into consideration */

/* Insert into mapper values (mapper_seq.nextval,?,null);
Insert into mapper values (mapper_seq.nextval,?,null);
Insert into mapper values (mapper_seq.nextval,?,null); */

delete from "&1".MAPPER where procedure_def_id in (select id from "&1".procedure_def 
	where cpt_code in ('#6002','#6003','#6004'));

delete from "&1".procedure_def where cpt_code = '#6002';
delete from "&1".procedure_def where cpt_code = '#6003';
delete from "&1".procedure_def where cpt_code = '#6004';


-- Following chnages are as per the request of Phil on 10/08/2002 at 15:57

aLTER TABLE "&1".TRIAL_BUDGET DROP CONSTRAINT TB_OVHD_PCT_RANGE_CHECK;

aLTER TABLE "&1".TRIAL_BUDGET ADD CONSTRAINT TB_OVHD_PCT_RANGE_CHECK
CHECK (OVERHEAD_PCT_RANGE IN ('Low','Med','High','Co_Med','Custom'));





---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  24   DevTSM    1.23        2/22/2008 11:55:21 AMDebashish Mishra  
--  23   DevTSM    1.22        9/19/2006 12:10:39 AMDebashish Mishra   
--  22   DevTSM    1.21        3/2/2005 10:48:41 PM Debashish Mishra  
--  21   DevTSM    1.20        8/29/2003 5:15:37 PM Debashish Mishra  
--  20   DevTSM    1.19        2/26/2003 3:35:52 PM Debashish Mishra Updated
--       creation scripts upto whatever implemented in prod so far
--  19   DevTSM    1.18        10/9/2002 4:50:26 PM Debashish Mishra constraint
--       change in trial_budget
--  18   DevTSM    1.17        10/7/2002 10:25:50 AMDebashish Mishra Migration of
--       #6002-4 codes
--  17   DevTSM    1.16        10/4/2002 9:30:04 AM Debashish Mishra changes
--       relatred to new id_control table
--  16   DevTSM    1.15        10/2/2002 5:17:24 PM Debashish Mishra Updated
--       task_template set end milestone=7 where id=62
--  15   DevTSM    1.14        10/2/2002 10:07:06 AMDebashish Mishra updated start
--       and end milestone id to 6,7 for id's = 82,102,106,109,117 id's 52,101,105
--       remains unchanged.
--  14   DevTSM    1.13        9/30/2002 5:00:27 PM Debashish Mishra Updated 
--       task_template static data 
--  13   DevTSM    1.12        9/26/2002 4:09:12 PM Debashish Mishra 3 new tables
--  12   DevTSM    1.11        9/23/2002 12:16:05 PMDebashish Mishra MOdified to
--       include two new table in client schema and schema name changes related to
--       tsmclient0 schema
--  11   DevTSM    1.10        9/23/2002 11:34:16 AMDebashish Mishra  
--  10   DevTSM    1.9         9/17/2002 9:16:59 AM Debashish Mishra Update to
--       task_template 
--  9    DevTSM    1.8         9/16/2002 3:46:33 PM Debashish Mishra New table:
--       Application
--  8    DevTSM    1.7         9/13/2002 2:47:53 PM Debashish Mishra New column
--       client_div_to_lic_app.version
--  7    DevTSM    1.6         9/12/2002 9:05:52 AM Debashish Mishra New views in
--       ftcommon
--  6    DevTSM    1.5         9/11/2002 10:34:53 AMDebashish Mishra chnages to
--       ip_business_factors for num_days for ph2+dur type
--  5    DevTSM    1.4         9/6/2002 11:19:35 AM Debashish Mishra new table
--       md_odc_oh_pct
--  4    DevTSM    1.3         9/5/2002 5:32:13 PM  Debashish Mishra Modified
--       modelled_coeff.*type
--  3    DevTSM    1.2         9/3/2002 2:54:31 PM  Debashish Mishra Modified
--       modelled_coeff.coeff
--  2    DevTSM    1.1         9/3/2002 2:30:05 PM  Debashish Mishra New table
--       modelled_coeff
--  1    DevTSM    1.0         9/3/2002 10:05:50 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
