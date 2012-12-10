--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_for_tspd_after_picase_ga.sql$ 
--
-- $Revision: 45$        $Date: 2/22/2008 11:56:03 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
-- Following chnages are as per the request of Kelly on 01/03/2003 at 16:45

Alter table client_div_to_lic_app drop constraint CDTLA_APP_NAME_CHECK;

Alter table client_div_to_lic_app add constraint CDTLA_APP_NAME_CHECK
	check ( app_name in ('DASHBOARD', 'PICASE', 'TRACE', 'TSPD'));

-- Following chnages are as per the request of Kelly on 01/06/2003 at 9:45


Alter table audit_hist drop constraint audit_hist_app_type_check;

Alter table audit_hist add constraint audit_hist_app_type_check check(
	app_type in ('DASHBOARD', 'PICASE', 'TRACE', 'TSPD'));


Alter table User_Pref drop constraint up_app_type_check;

Alter table User_Pref add constraint up_app_type_check 
	check (app_type in ('DASHBOARD', 'PICASE', 'TRACE', 'TSPD'));


conn ft15/??@??

Alter table trial drop constraint trial_created_by_check;

Alter table trial add constraint trial_created_by_check check(
	created_by in ('DASHBOARD', 'PICASE', 'TRACE', 'TSPD'));


-- Following chnages are as per the request of Kelly on 01/07/2003 at 8:10 am

alter table ftgroup drop constraint FTGROUP_NAME_CHECK;

Insert into ftgroup values (17,'TSPD Viewer');
Insert into ftgroup values (18,'TSPD Author');
Insert into ftgroup values (19,'TSPD Admin');
commit;


conn tsm10/??@??

-- Following changes are as per the request of Joel on 05/22/2003 at 2:50 PM

create table tspd_template (
	id	NUMBER(10),
	client_div_id	NUMBER(10) NOT NULL,
	last_updated	DATE NOT NULL,
	name	VARCHAR2(80)	NOT NULL,
	data	BLOB)
	tablespace tspdblob 
	pctused 65 pctfree 20;

Alter table tspd_template add constraint tspd_template_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table tspd_template add constraint tspd_template_fk1
	foreign key (client_div_id) references client_div(id);

Create or replace trigger tspd_template_trg1
before insert or update on tspd_template
referencing new as n old as o
for each row
begin
 :n.last_updated:=sysdate;
end;
/
sho err	

create or replace view tspd_template_noblob as
	select id,client_div_id,last_updated,name 
	from tspd_template;


create table tspd_trial (
	trial_id	NUMBER(10),
	tspd_template_id	NUMBER(10)	NOT NULL,
	creator_ftuser_id	NUMBER(10)	NOT NULL,
	owner_ftuser_id	NUMBER(10)	NOT NULL,
	create_date	DATE default sysdate NOT NULL,
	short_title	VARCHAR2(256),	
	full_title	VARCHAR2(1024),	
	short_desc	VARCHAR2(256),	
	full_desc	VARCHAR2(1024),	
	indication_desc	VARCHAR2(1024),	
	study_type	VARCHAR2(80),	
	study_countries	VARCHAR2(1024),	
	planned_sites	NUMBER(5),
	build_tag_id 	NUMBER(10) not null)
	tablespace tspdsmall 
	pctused 65 pctfree 20;

Alter table tspd_trial add constraint tspd_trial_pk
	primary key (trial_id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table tspd_trial add constraint tspd_trial_fk1
foreign key (TRIAL_ID) references trial(id);

Alter table tspd_trial add constraint tspd_trial_fk2
foreign key (tspd_template_id) references tspd_template(id);

Alter table tspd_trial add constraint tspd_trial_fk3
foreign key (creator_ftuser_id) references ftuser(id);

Alter table tspd_trial add constraint tspd_trial_fk4
foreign key (owner_ftuser_id) references ftuser(id);

Alter table tspd_trial add constraint tspd_trial_fk5
foreign key (build_tag_id) references build_tag(id);

Alter table tspd_trial add constraint tt_study_type_check 
check(study_type in ('MultipleCenters','SingleCenter','Other')); 


create table icp_instance (
	id	NUMBER(10),
	trial_id	NUMBER(10),
	last_updated	DATE,
	version_timestamp	NUMBER(10),
	data	BLOB,
	snapshot_type VARCHAR2(80) default 'WorkingCopy' not null)
	tablespace tspdblob 
	pctused 65 pctfree 20;

Alter table icp_instance add constraint icp_instance_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;	

Alter table icp_instance add constraint icp_instance_fk1
	foreign key (TRIAL_ID) references tspd_trial(trial_id);

alter table icp_instance add constraint ii_snapshot_type_check
	check(snapshot_type in ('WorkingCopy','ReviewCopy','FinalVersion'));

Create or replace trigger icp_instance_trg1
before insert or update on icp_instance
referencing new as n old as o
for each row
begin
 :n.last_updated:=sysdate;
end;
/
sho err

create or replace view icp_instance_noblob as
	select id,trial_id,last_updated,
	version_timestamp,snapshot_type 
	from icp_instance;	

create table tspd_document (
	id	NUMBER(10),
	trial_id	NUMBER(10)	NOT NULL,
	document_type	VARCHAR2(80)	NOT NULL,
	document_name	VARCHAR2(256),
	author_ftuser_id	NUMBER(10)	NOT NULL,
	create_date	DATE	NOT NULL,
	last_updated	DATE	NOT NULL,
	version_timestamp	NUMBER(10)	NOT NULL,
	data	BLOB,	
	snapshot_type	VARCHAR2(80),	
	snapshot_name	VARCHAR2(256),	
	snapshot_notes	VARCHAR2(1024),	
	review_by_date	DATE,	
	review_by_time	VARCHAR2(80),	
	amend_to_tspd_document_id	NUMBER(10),	
	icp_instance_id	NUMBER(10)	NOT NULL,
	snapshot_status	VARCHAR2(80),
	document_notes  VARCHAR2(1024),
	snapshot_create_date date,
	soa_tbl_format blob)
	tablespace tspdblob 
	pctused 65 pctfree 20;

Alter table tspd_document add constraint tspd_document_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table tspd_document add constraint tspd_document_fk1
	foreign key (TRIAL_ID) references tspd_trial(trial_id);

Alter table tspd_document add constraint tspd_document_fk2
	foreign key (author_ftuser_id) references ftuser(id);

Alter table tspd_document add constraint tspd_document_fk3
	foreign key (icp_instance_id) references icp_instance(id);	

Alter table tspd_document add constraint tspd_document_fk4
	foreign key (amend_to_tspd_document_id) references tspd_document(id);

Alter table tspd_document add constraint td_document_type_check
	check(document_type in ('Protocol','StudyGuide'));

Alter table tspd_document add constraint td_snapshot_type_check
	check(snapshot_type in ('WorkingCopy','ReviewCopy','FinalVersion'));

Alter table tspd_document add constraint td_snapshot_status_check
	check(snapshot_status in ('Open','Closed','Final'));


Create or replace trigger tspd_document_trg1
before insert or update on tspd_document
referencing new as n old as o
for each row
begin
 :n.last_updated:=sysdate;
end;
/
sho err	

create or replace view tspd_document_noblob as
	select id,trial_id,document_type,document_name,
	author_ftuser_id,create_date,last_updated,
	version_timestamp,snapshot_type,snapshot_name,	
	snapshot_notes,	review_by_date,review_by_time,	
	amend_to_tspd_document_id,icp_instance_id,
	snapshot_status,document_notes,snapshot_create_date
	from tspd_document;


create table tspd_doc_reviewer(
	id	NUMBER(10),
	ftuser_id	NUMBER(10)	NOT NULL,
	tspd_document_id	NUMBER(10)	NOT NULL,
	review_status	VARCHAR2(80),	
	completion_status	VARCHAR2(80),	
	review_notes	VARCHAR2(1024),	
	user_status	VARCHAR2(80))	
	tablespace tspdsmall 
	pctused 65 pctfree 20;


Alter table tspd_doc_reviewer add constraint tspd_doc_reviewer_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table tspd_doc_reviewer add constraint tspd_doc_reviewer_uq1
	unique (ftuser_id,tspd_document_id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table tspd_doc_reviewer add constraint tspd_doc_reviewer_fk1
	foreign key (tspd_document_id) references tspd_document(id);

Alter table tspd_doc_reviewer add constraint tspd_doc_reviewer_fk2
	foreign key (ftuser_id) references ftuser(id);

Alter table tspd_doc_reviewer add constraint tdr_review_status_check
	check(review_status in ('Approved','ApprovedWithRevisions','NotApproved'));

Alter table tspd_doc_reviewer add constraint tdr_completion_status_check
	check(completion_status in ('Complete','Partial'));

Alter table tspd_doc_reviewer add constraint tdr_user_status_check
	check(user_status in ('Active','Removed'));

create table tspd_doc_comment(
	id	NUMBER(10),
	comments	VARCHAR2(1024),
	WORD_RANGE_START  NUMBER(10),
	WORD_RANGE_END NUMBER(10),
	CREATE_DATE DATE,
	TSPD_DOCUMENT_ID NUMBER(10),
	ftuser_id number(10) not null)
	tablespace tspdsmall 
	pctused 65 pctfree 20;

Alter table tspd_doc_comment add constraint tspd_doc_comment_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table tspd_doc_comment add constraint tspd_doc_comment_fk1
	foreign key (ftuser_id) references ftuser(id);

Alter table tspd_doc_comment add constraint tspd_doc_comment_fk2 
	foreign key (TSPD_DOCUMENT_ID) references TSPD_DOCUMENT(ID);

Alter table tspd_doc_comment add constraint tspd_doc_comment_fk3
	foreign key (ftuser_id,TSPD_DOCUMENT_ID) 
	references tspd_doc_reviewer(ftuser_id,TSPD_DOCUMENT_ID);	

create table tspd_doc_advisory(
	id	NUMBER(10),
	tspd_document_id	NUMBER(10)	NOT NULL,
	status	VARCHAR2(80)	NOT NULL,
	reason_for_close	VARCHAR2(1024),	
	advisory_rule	VARCHAR2(80)	NOT NULL,
	advisory_object	VARCHAR2(256)	NOT NULL)
	tablespace tspdsmall 
	pctused 65 pctfree 20;

Alter table tspd_doc_advisory add constraint tspd_doc_advisory_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table tspd_doc_advisory add constraint tspd_doc_advisory_fk1
	foreign key (tspd_document_id) references tspd_document(id);

Alter table tspd_doc_advisory add constraint tda_status_check
	check(status in ('Open','Closed'));	

create table criteria(
	id	NUMBER(10),
	client_div_id	NUMBER(10)	NOT NULL,
	type	VARCHAR2(80)	NOT NULL,
	short_desc	VARCHAR2(256),	
	long_desc	VARCHAR2(2048),
	rationale	VARCHAR2(2048))	
	tablespace tspdsmall 
	pctused 65 pctfree 20;

Alter table criteria add constraint criteria_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table criteria add constraint criteria_fk1
	foreign key (client_div_id) references client_div(id);
	
Alter table criteria add constraint criteria_type_check
	check(type in ('Inclusion','Exclusion','NotDefined'));

create table criteria_set(
	id	NUMBER(10),
	name	VARCHAR2(80)	NOT NULL,
	create_date	DATE	NOT NULL,
	client_div_id	NUMBER(10)	NOT NULL,
	ftuser_id	NUMBER(10)	NOT NULL)
	tablespace tspdsmall 
	pctused 65 pctfree 20;

Alter table criteria_set add constraint criteria_set_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table criteria_set add constraint criteria_set_fk1
	foreign key (client_div_id) references client_div(id);
	
Alter table criteria_set add constraint criteria_set_fk2
	foreign key (ftuser_id) references ftuser(id);

create table criteria_set_item(
	id	NUMBER(10),
	criteria_set_id	NUMBER(10)	NOT NULL,
	criteria_id	NUMBER(10)	NOT NULL)
	tablespace tspdsmall 
	pctused 65 pctfree 20;

Alter table criteria_set_item add constraint criteria_set_item_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table criteria_set_item add constraint criteria_set_item_fk1
	foreign key (criteria_id) references criteria(id);
	
Alter table criteria_set_item add constraint criteria_set_item_fk2
	foreign key (criteria_set_id) references criteria_set(id);

create table password_rule(
	id	NUMBER(10),
	client_div_id	NUMBER(10)	NOT NULL,
	username_min_chars	NUMBER(3) default 0	NOT NULL,
	username_max_chars	NUMBER(3) default 0	NOT NULL,
	password_min_chars	NUMBER(3) default 0	NOT NULL,
	password_max_chars	NUMBER(3) default 0	NOT NULL,
	password_has_numeric	NUMBER(1) default 0	NOT NULL,
	password_valid_days	NUMBER(5) default 0 	NOT NULL,
	password_ntfy_user_days 	NUMBER(5) default 0	NOT NULL,
	password_allow_reuse_days	NUMBER(5) default 0	NOT NULL)
	tablespace tspdsmall 
	pctused 65 pctfree 20;

Alter table password_rule add constraint password_rule_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table password_rule add constraint password_rule_fk1
	foreign key (client_div_id) references client_div(id);

Alter table password_rule add constraint password_rule_uq1
	unique (client_div_id) using index tablespace tspdsmall_indx
	pctfree 20;

Insert into id_control select 'tsm10', 'tspd_template', nvl(max(id),0)+1 from tspd_template ;
Insert into id_control select 'tsm10', 'tspd_document', nvl(max(id),0)+1 from tspd_document ;
Insert into id_control select 'tsm10', 'icp_instance', nvl(max(id),0)+1 from icp_instance ;
Insert into id_control select 'tsm10', 'tspd_doc_reviewer', nvl(max(id),0)+1 from tspd_doc_reviewer ;
Insert into id_control select 'tsm10', 'tspd_doc_comment', nvl(max(id),0)+1 from tspd_doc_comment ;
Insert into id_control select 'tsm10', 'tspd_doc_advisory', nvl(max(id),0)+1 from tspd_doc_advisory ;
Insert into id_control select 'tsm10', 'criteria', nvl(max(id),0)+1 from criteria ;
Insert into id_control select 'tsm10', 'criteria_set', nvl(max(id),0)+1 from criteria_set ;
Insert into id_control select 'tsm10', 'criteria_set_item', nvl(max(id),0)+1 from criteria_set_item;
Insert into id_control select 'tsm10', 'password_rule', nvl(max(id),0)+1 from password_rule ;
commit;

conn ft15/****@????

Insert into ftgroup values (20,'TSPD Library Admin');
commit;

Alter table ftuser add(old_password varchar2(255));

conn ftcommon/****@???
create or replace view FTUSER as
select ID,NAME||'@tsm10' name ,PASSWORD,SITE_ID,STARTING_SCREEN,LAST_PASSWORD_UPDATE,
FIRST_NAME,LAST_NAME,LAST_LOGIN_DATE,PRIMARY_TA_ID,ADDRESS_LINE_1,
ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,WORK_PHONE,
HOME_PHONE,FAX,MOBILE_PHONE,EMAIL,PREFERRED_CONTACT,TITLE,
CLIENT_ID,CLIENT_DIV_ID,DISPLAY_NAME,ACTIVE_TRACE_USER,
ACTIVE_TSM_USER,old_password,'tsm10' environment from ft15.ftuser
union all
select ID,NAME||'@tsm10e' name ,PASSWORD,SITE_ID,STARTING_SCREEN,LAST_PASSWORD_UPDATE,
FIRST_NAME,LAST_NAME,LAST_LOGIN_DATE,PRIMARY_TA_ID,ADDRESS_LINE_1,
ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,WORK_PHONE,
HOME_PHONE,FAX,MOBILE_PHONE,EMAIL,PREFERRED_CONTACT,TITLE,
CLIENT_ID,CLIENT_DIV_ID,DISPLAY_NAME,ACTIVE_TRACE_USER,
ACTIVE_TSM_USER,null,'tsm10e' environment from ft15e.ftuser;


-- Following chnages were done on 05/28/2003 at 9:40 AM

conn ft15/****@????

Alter table ftuser add (active_tspd_user number(1) default 0 not null);

Alter table ftuser add constraint ftuser_active_tspd_user_check
check(active_tspd_user in (0,1));

-- Following chnages are as per the request of Tonya on 06/19/2003 at 3:25 PM

conn tsm10/*****@?????

Alter table CUSTOM_SET drop constraint CUSTOM_SET_TYPE_CHECK;

Alter table CUSTOM_SET add constraint CUSTOM_SET_TYPE_CHECK
check(type in ('ODC','CLIN','TASK'));

Alter table unlisted_procedure drop constraint UP_PROC_TYPE_CHECK;

Alter table unlisted_procedure add constraint UP_PROC_TYPE_CHECK
check(type in ('ODC','CLIN','TASK'));

-- Following chnages are as per the request of Kelly on 06/30/2003 at 8:49 AM


Alter table client_div add (tspd_build_tag_id NUMBER(10));
Alter table client_div add constraint CLIENT_DIV_FK7
foreign key(tspd_build_tag_id) references build_tag(id);

conn ftcommon/***@????


create or replace view client_div as
select ID,CLIENT_ID,NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,
STARTING_VIEW,COUNTRY_ID,BUILD_TAG_ID,USE_OWN_CNV_FLG,
DEF_PRICE_RANGE,LOGON_TIMEOUT_SECS,
ISO_LANG,USING_WEBSTART,G50_COL_ENABLED,G50_HDNG,G50_SPEC_HDNG,
G50_PCKLST_DESC,ALLOW_CREATE_UNLISTED,TSPD_BUILD_TAG_ID,
'tsm10' environment from tsm10.client_div
union all
select ID,CLIENT_ID,NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,
STARTING_VIEW,COUNTRY_ID,BUILD_TAG_ID,USE_OWN_CNV_FLG,
DEF_PRICE_RANGE,LOGON_TIMEOUT_SECS,
ISO_LANG,USING_WEBSTART,null,null,null,null,null,null,
'tsm10e' environment from tsm10e.client_div;

-- Following changes are as per the request of Kelly on 06/30/2003 at 1:50PM

conn ft15/****@????

CREATE OR REPLACE TRIGGER trial_trg1
before insert or update of created_by on trial
referencing new as n old as o
for each row

begin

 If :n.created_by = 'PICAS-E' or :n.created_by = 'Trace' or
    :n.created_by = 'PICASE' or :n.created_by = 'TRACE' or 
    :n.created_by = 'TSPD' then 
	:n.guid := 'TSM_'||:n.id; 
 end if; 

end;
/
sho err

update trial set PROTOCOL_IDENTIFIER=GUID   where PROTOCOL_IDENTIFIER is null;
Alter table trial modify(PROTOCOL_IDENTIFIER not null);


-- *****************************BE CAREFUL************
-- *****************************BE CAREFUL************
-- Make sure that the appropriate grants is given to appropriate tsm10e/d/ schema
-- *****************************BE CAREFUL************

-- Following changes are as per the request of Kelly to allow access from TSPD dataset on 7/7/03 at 8:50 AM

Grant select,insert,update,delete,references on ft_foreign_key_info to "tsm10" with grant option;

conn tsm10/****@?????

Alter table protocol add(earliest_grant_date date);

update protocol set earliest_grant_date = (
select min(grant_date) from investig where
investig.protocol_id =protocol.id);
commit;

-- Implemented in tsm10e@test upto this on 07/14/2003 at 5:45 PM


-- Following chnages are as per the request of Tonya on 07/23/2003 at 12:25 PM

Alter table CUSTOM_SET drop constraint CUSTOM_SET_TYPE_CHECK;

Alter table CUSTOM_SET add constraint CUSTOM_SET_TYPE_CHECK
check(type in ('ODC','CLIN','TSPD_TASK'));

Alter table unlisted_procedure drop constraint UP_PROC_TYPE_CHECK;

Alter table unlisted_procedure add constraint UP_PROC_TYPE_CHECK
check(type in ('ODC','CLIN','TSPD_TASK'));

-- Following chnages are as per the request of Kelly on 07/24/2003 at 11 AM

Alter table tspd_doc_comment add(hide_flg number(1) default 1 not null);
Alter table tspd_doc_comment add constraint tdc_hide_flg_check check 
(hide_flg in (0,1));

-- Following chnages are as per the request of Kelly on 07/24/2003 at 3:30 PM

alter table tspd_doc_reviewer add (VERSION_TIMESTAMP NUMBER(10) default 1);
update tspd_doc_reviewer set VERSION_TIMESTAMP=1;
commit;

-- Following chnages are as per the request of Matt on 07/29/2003 at 10:18 AM

create table TSPD_TEMPLATE_EMAIL(
	id	NUMBER(10),
	client_div_id	NUMBER(10),
	TEMPLATE_NAME  	VARCHAR2(30) NOT NULL,
	SUBJECT	VARCHAR2(256) NOT NULL,	
	MESSAGE_TEXT 	VARCHAR2(4000))	
	tablespace tspdsmall 
	pctused 65 pctfree 20;


Alter table TSPD_TEMPLATE_EMAIL add constraint TSPD_TEMPLATE_EMAIL_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table TSPD_TEMPLATE_EMAIL add constraint TSPD_TEMPLATE_EMAIL_fk1
	foreign key (client_div_id) references client_div(id);

Insert into id_control select user, 'tspd_template_email', nvl(max(id),0)+1 from 
	tspd_template_email;

commit;

-- Following chnages are as per the request of Matt on 07/31/2003 at 5 pm

Alter table tspd_document add(review_reminder_days number(2) default 0 not null);

-- Following chnages are as per the request of Tonya on 08/10/2003 at 8:40 am

Alter table audit_hist add (tspd_role varchar2(50));

-- Following chnages are as per the request of Matt on 08/05/2003 

Alter table password_rule add(
	LOCKOUT_INACTIVITY_DAYS number(5) default 0 not null,
	LOCKOUT_LOGIN_ATTEMPTS number(5) default 0 not null);

-- Following chnages are as per the request of Joel on 08/05/2003 at 2:01 PM

alter table unlisted_procedure add (VERSION_TIMESTAMP NUMBER(10) default 1);
update unlisted_procedure set VERSION_TIMESTAMP=1;
commit;

alter table custom_set add (VERSION_TIMESTAMP NUMBER(10) default 1);
update custom_set set VERSION_TIMESTAMP=1;
commit;

alter table criteria_set add (VERSION_TIMESTAMP NUMBER(10) default 1);
update criteria_set set VERSION_TIMESTAMP=1;
commit;

-- Following chnages are as per the request of Matt on 08/14/2003 at 11:37 am

Alter table criteria_set  add constraint criteria_set_uq1
unique (CLIENT_DIV_ID,NAME) using index tablespace 
tsmsmall_indx pctfree 15;

conn ft15/??@??

-- Following chnages are as per the request of Colin on 08/14/2003 at 15:34 

Alter table ftuser add (locked number(1) default 0 not null);
Alter table ftuser add constraint ftuser_locked_check 
check (locked in (0,1));

conn tsm10/??@??
-- Following changes are as per the request of Joel on 08/25/2003 at 4:36 PM

Alter table tspd_doc_reviewer drop constraint tdr_review_status_check;

Alter table tspd_doc_reviewer add constraint tdr_review_status_check
	check(review_status in ('Approved','ApprovedWithRevisions','NotApproved','NotReviewed'));

Alter table tspd_doc_reviewer drop constraint tdr_completion_status_check;

Alter table tspd_doc_reviewer add constraint tdr_completion_status_check
	check(completion_status in ('Complete','Partial','Incomplete'));

-- Following changes are as per the request of Joel on 8/26 at 4pm

Alter table tspd_doc_reviewer modify (user_status default 'Active');
Alter table tspd_doc_reviewer modify (completion_status default 'Incomplete');
Alter table tspd_doc_reviewer modify (review_status default 'NotReviewed');

-- Following chnages are as per the request of Matt on 08/27/2003 at 11:26 AM

  INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES (
      increment_sequence('tspd_template_email_seq'), 
      'CLOSE_SNAPSHOT_DATE_AND_TIME', 
      'Protocol <protocol id> / <snapshot name> document closed for review',
      'The <protocol id> / <snapshot name> protocol has been closed for further review.  The review was due <review due date> on <review due time>.  If you have not yet completed your review and have additional comments please notify me directly.'
      ); 
  
  INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES (
      increment_sequence('tspd_template_email_seq'), 
      'CLOSE_SNAPSHOT_DATE', 
      'Protocol <protocol id> / <snapshot name> document closed for review',
      'The <protocol id> / <snapshot name> protocol has been closed for further review.  The review was due <review due date>.  If you have not yet completed your review and have additional comments please notify me directly.'
      ); 

  INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES (
      increment_sequence('tspd_template_email_seq'), 
      'CLOSE_SNAPSHOT', 
      'Protocol <protocol id> / <snapshot name> document closed for review',
      'The <protocol id> / <snapshot name> protocol has been closed for further review.  If you have not yet completed your review and have additional comments please notify me directly.'
      ); 
commit;

-- Implemented in tsm10e@test upto this on 09/03/2003 at 10:28 AM

-- Following changes are as per the request of Kelly on 09/05/2003 3:11 PM
-- Kelly asked on 09/08/2003 to remove this column 

-- alter table tspd_document add(soa_table_format varchar2(4000));

-- Following chnages are as per the request of Matt on 09/05/2003 3:30 PM

INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES (
       increment_sequence('tspd_template_email_seq'),
      'REVIEW_NONFINAL_SNAPSHOT_DUE',
      'Protocol <protocol id> / <snapshot name> document posted for your review',
      'The <protocol id> / <snapshot name> protocol has been posted for your review.  Please log in to the TrialSpace Protocol Designer to review and add your comments.  Once your review is complete, please submit and sign your review.\n\nThe review is due <review due date> on <review due time>.  If you are unable to complete your review you may re-assign the review to another reviewer.');
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES (
      increment_sequence('tspd_template_email_seq'),
      'SUBMIT_REVIEW',
      'Review submitted for trial <protocol id>, <doc or amendment name> / <snapshot name>',
      '<reviewer display name> has submitted a review for trial <protocol id> <doc or amendment name> / <snapshot name>Review Status: <completion status / review status> Notes: <review notes>');

commit;

-- Following changes are as per the discussion with tonya/kelly on 09/08/2003 at 9:55 AM

create table tspd_lib_bucket(
	ID	NUMBER(10),
	NAME	VARCHAR2(255) not null,
	CREATE_DATE	DATE not null,
	CLIENT_DIV_ID	NUMBER(10),
	LAST_UPDATED	DATE not null)
	tablespace tspdsmall 
	pctused 70 pctfree 20;

Alter table tspd_lib_bucket add constraint tspd_lib_bucket_pk
	primary key (id) using index tablespace tspdsmall_indx
	pctfree 20;

Alter table tspd_lib_bucket add constraint tspd_lib_bucket_fk1
	foreign key (client_div_id) references client_div(id);

Create or replace trigger tspd_lib_bucket_trg1
before insert or update on tspd_lib_bucket
referencing new as n old as o
for each row
begin
 :n.last_updated:=sysdate;
end;
/

insert into id_control select 'tsm10','tspd_lib_bucket',
nvl(max(id),0) from tspd_lib_bucket;
commit;

create table tspd_lib_element(
	ID			NUMBER(10),
	TSPD_LIB_BUCKET_ID	NUMBER(10) NOT NULL,
	NAME			VARCHAR2(255),
	CREATE_DATE		DATE NOT NULL,
	CONTENT_TYPE		NUMBER(10),
	CREATOR_FTUSER_ID	NUMBER(10),
	CONTENT_SUBTYPE		NUMBER(10),
	FILENAME		VARCHAR2(255),
	DATA			BLOB)
	tablespace tspdblob
	pctused 70 pctfree 20;

Alter table tspd_lib_element add constraint tspd_lib_element_pk
	primary key (id) using index tablespace tspdsmall_indx
	pctfree 20;

Alter table tspd_lib_element add constraint tspd_lib_element_fk1
	foreign key (TSPD_LIB_BUCKET_ID) references TSPD_LIB_BUCKET(id);

Alter table tspd_lib_element add constraint tspd_lib_element_fk2
	foreign key (CREATOR_FTUSER_ID) references FTUSER(id);

insert into id_control select 'tsm10','tspd_lib_element',
nvl(max(id),0) from tspd_lib_element;
commit;

create or replace view tspd_lib_element_noblob as
select ID,TSPD_LIB_BUCKET_ID,NAME,CREATE_DATE,CONTENT_TYPE,
CREATOR_FTUSER_ID,CONTENT_SUBTYPE,FILENAME from tspd_lib_element;

-- Following changes are as per the request of Colin on 09/08/2003 at 3 pm

conn ft15/***@????

grant update (locked) on ftuser to ftcommon;

conn tsm10/****@????

grant select on password_rule to ftcommon;

conn ftcommon/****@????

create or replace view ftuser as
select ID,NAME||'@tsm10' name ,PASSWORD,SITE_ID,STARTING_SCREEN,
LAST_PASSWORD_UPDATE,
FIRST_NAME,LAST_NAME,LAST_LOGIN_DATE,PRIMARY_TA_ID,ADDRESS_LINE_1,
ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,WORK_PHONE,
HOME_PHONE,FAX,MOBILE_PHONE,EMAIL,PREFERRED_CONTACT,TITLE,
CLIENT_ID,CLIENT_DIV_ID,DISPLAY_NAME,ACTIVE_TRACE_USER,
ACTIVE_TSM_USER,old_password,ACTIVE_TSPD_USER,DEF_PLAN_CURRENCY_ID,
locked,'tsm10' environment from ft15.ftuser
union all
select ID,NAME||'@tsm10e' name ,PASSWORD,SITE_ID,STARTING_SCREEN,
LAST_PASSWORD_UPDATE,
FIRST_NAME,LAST_NAME,LAST_LOGIN_DATE,PRIMARY_TA_ID,ADDRESS_LINE_1,
ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,WORK_PHONE,
HOME_PHONE,FAX,MOBILE_PHONE,EMAIL,PREFERRED_CONTACT,TITLE,
CLIENT_ID,CLIENT_DIV_ID,DISPLAY_NAME,ACTIVE_TRACE_USER,
ACTIVE_TSM_USER,null,null,null,null,
'tsm10e' environment from ft15e.ftuser;

create or replace view password_rule as
select ID,CLIENT_DIV_ID,USERNAME_MIN_CHARS,USERNAME_MAX_CHARS,
PASSWORD_MIN_CHARS,PASSWORD_MAX_CHARS,PASSWORD_HAS_NUMERIC,
PASSWORD_VALID_DAYS,PASSWORD_NTFY_USER_DAYS,PASSWORD_ALLOW_REUSE_DAYS,
LOCKOUT_INACTIVITY_DAYS,LOCKOUT_LOGIN_ATTEMPTS,
'tsm10' environment from tsm10.password_rule;

create or replace procedure lock_ftuser
(schemaname in varchar2, username in varchar2, lock_value in number)
as
mysql_stmt varchar2(200);
table_name varchar2(70);
begin
table_name:=schemaname||'.ftuser';
mysql_stmt:='Update '||table_name||' set locked=:1 where name=:2';
execute immediate mysql_stmt using lock_value, username;
commit;
end;
/
sho err

-- Implemented in tsm10e@test upto this on 09/08/2003 at 15:51  

conn tsm10/****@????

-- Following changes are as per the request of Nancy/Gary on 09/08/2003 at 3:35 PM

alter table tspd_doc_advisory add (advisoryid varchar2(512));

-- Following changes are as per the request of Tonya on 09/09/2003 at 10:40 AM

alter table tspd_lib_bucket add(VERSION_TIMESTAMP NUMBER(10));

-- Following chnages are as per the request of Tonya on 09/10/2003 at 7:30 AM

alter table criteria add(other_desc VARCHAR2(256));

-- Implemented in tsm10e@test upto this on 09/11/2003 at 16:06  

-- Following chnages are as per the request of Matt on 09/11/2003 at 8am

Alter table tspd_trial add (client_support_access_allowed number(1) default 0 not null);

Alter table tspd_trial add constraint tt_clnt_sprt_allwd_check check(
client_support_access_allowed in (0,1));

INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'USER_TRIAL_ROLE_ADDED',
  'Change in roles for trial <protocol id>',
  '<user being added> has been added as <user role> to trial <protocol id>.');

INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'USER_TRIAL_ROLE_REPLACED',
  'Change in roles for trial <protocol id>',
  '<user being added> has been added as <user role> to trial <protocol id>.  <user being replaced> has been replaced as <user role>.');

commit;

-- Following changes are as per the request of Kelly on 09/15/2003 at 8:20 am

alter table tspd_document add(amend_name VARCHAR2(256));

-- Following changes are as per the request of Allen on 09/12/2003 at 5pm

Insert into ftgroup values (21,'TSPD FTAdmin');
Insert into ftgroup values (22,'TSPD Super Dolly');
Insert into ftgroup values (23,'TSPD Dolly');
commit;

-- Following changes are as per the request of Gary on 09/15/2003 at 11:56 AM

alter table tspd_doc_advisory modify (ADVISORY_OBJECT varchar2(2048));
 
-- Implemented in tsm10e@test upto this on 09/16/2003 at 20:26  

-- Following changes are as per the request of Kelly on 09/17/2003 at 10:50 pm

Alter table tspd_document drop constraint td_snapshot_type_check;

Alter table tspd_document add constraint td_snapshot_type_check
	check(snapshot_type in ('WorkingCopy','ReviewCopy','FinalVersion','ConflictVersion'));

alter table icp_instance drop constraint ii_snapshot_type_check;

alter table icp_instance add constraint ii_snapshot_type_check
	check(snapshot_type in ('WorkingCopy','ReviewCopy','FinalVersion','ConflictVersion'));

-- Following changes are done by debashish to keep the database uptodate on 09/19/2003 at 9:52 AM

create or replace view tspd_document_noblob as
	select id,trial_id,document_type,document_name,
	author_ftuser_id,create_date,last_updated,
	version_timestamp,snapshot_type,snapshot_name,	
	snapshot_notes,	review_by_date,review_by_time,	
	amend_to_tspd_document_id,icp_instance_id,
	snapshot_status,document_notes,snapshot_create_date,
	REVIEW_REMINDER_DAYS,AMEND_NAME             
	from tspd_document;

-- Following changes are as per the request of Kelly on 09/21/2003 at 3:24 pm

Alter table tspd_lib_element add (ct varchar2(20), cst varchar2(20));
update tspd_lib_element set ct = to_char(content_type);
update tspd_lib_element set cst = to_char(content_subtype);
commit;
update tspd_lib_element set content_type = null;
update tspd_lib_element set content_subtype = null;
commit;
Alter table tspd_lib_element modify(content_type varchar2(20),
				    content_subtype varchar2(20));
update tspd_lib_element set content_type = ct;
update tspd_lib_element set content_subtype = cst;
commit;

alter table tspd_lib_element drop column ct;
alter table tspd_lib_element drop column cst;

Alter table tspd_lib_element add constraint tle_content_type_check
check (content_type in ('Inline','Text','MSWord','Image','Binary'));

Alter table tspd_lib_element add constraint tle_content_subtype_check
check (content_subtype in ('PNG','JPG','BMP'));

-- Following changes are as per the request of Kelly on 09/23/2003 at 12 noon

Alter table tspd_lib_element add(tooltip varchar2(256));


-- Implemented in tsm10@test upto this on 09/23/2003 at 14:52 
-- Implemented in tsm10p@prev upto this on 09/24/2003 at 8:50

-- Following chnages are as per the request of Kelly on 09/23/2003 at 15:05

Alter table tspd_lib_element drop constraint tle_content_type_check;

Alter table tspd_lib_element add constraint tle_content_type_check
check (content_type in ('Inline','Text','MSWord','Image'));

Alter table tspd_lib_element drop constraint tle_content_subtype_check;

Alter table tspd_lib_element add constraint tle_content_subtype_check
check (content_subtype in ('PNG','JPG','BMP','GIF'));

-- Following chnages are as per the request of Henry on 09/23/2003 at 5pm

create or replace procedure delete_tspd_template(
templateid in number) 
is
begin

delete from tspd_doc_comment where
tspd_document_id in (select a.id from tspd_document a,
tspd_trial b where
a.trial_id=b.trial_id and b.tspd_template_id=templateid);

delete from tspd_doc_reviewer where
tspd_document_id in (select a.id from tspd_document a,
tspd_trial b where
a.trial_id=b.trial_id and b.tspd_template_id=templateid);


delete from tspd_doc_advisory where
tspd_document_id in (select a.id from tspd_document a,
tspd_trial b where
a.trial_id=b.trial_id and b.tspd_template_id=templateid);

delete from tspd_document where trial_id in
(select trial_id from tspd_trial where 
tspd_template_id=templateid);

delete from icp_instance where trial_id in
(select trial_id from tspd_trial where 
tspd_template_id=templateid);

delete from tspd_trial where tspd_template_id=templateid;

delete from tspd_template where id=templateid;

delete from trial where created_by = 'TSPD' and
not id in (select trial_id from tspd_trial);

commit;
end;
/

-- Following chnages are as per the request of MAtt on 09/25/2003 at 7pm

alter table tspd_document add (last_cookie number(10));

-- Following chnages are as per the request of Kelly on 09/25/2003 at 7 pm

Alter table tspd_lib_element add (filepath varchar2(256));

-- Implemented in tsm10e@test upto this on 09/30/2003 at 8:10
-- Implemented in tsm10@test upto this on 09/30/2003 at 8:10  
-- Implemented in tsm10p@prev upto this on 09/24/2003 at 9:20  

-- Following changes are as per the request of Nancy on 10/2/2003 at 15:22

alter table tspd_doc_advisory drop column advisory_rule;

-- Following chnages are as per the request of Kelly on 10/03/03 at 15:15

alter table tspd_lib_element add(inline_data varchar2(2048));

create or replace view tspd_lib_element_noblob as
select ID,TSPD_LIB_BUCKET_ID,NAME,CREATE_DATE,CONTENT_TYPE,
CREATOR_FTUSER_ID,CONTENT_SUBTYPE,FILENAME,TOOLTIP,
FILEPATH,INLINE_DATA from tspd_lib_element;

-- Following changes are as per the request of Kelly on 10/05 at 12:17

Alter table tspd_document drop constraint TD_SNAPSHOT_TYPE_CHECK;

Alter table tspd_document add constraint TD_SNAPSHOT_TYPE_CHECK 
	check (snapshot_type in (
	'WorkingCopy','ReviewCopy','FinalVersion','ConflictVersion','AuthorChange'));


-- Implemented in tsm10e@test upto this on 10/07/2003 at 10:17
-- Implemented in tsm10@test upto this on 10/14/2003 at 9:30  
-- Implemented in tsm10p@prev upto this on 10/14/2003 at 9:30  

-- Following chnages are as per the request of Kelly on 10/15/2003 at 15:07 pm

Alter table icp_instance add (icp_type varchar2(80));

Alter table icp_instance add constraint icp_instance_icp_type_check
	check(icp_type in ('WorkingCopy','Frozen'));

update icp_instance set icp_type='WorkingCopy' where snapshot_type='WorkingCopy';
update icp_instance set icp_type='Frozen' where snapshot_type='FinalCopy';

commit;


create or replace view icp_instance_noblob as
	select id,trial_id,last_updated,
	version_timestamp,snapshot_type,icp_type 
	from icp_instance;

-- Following chnages are done by Kelly between 10/17/2003 and 10/24/2003


  delete tspd_template_email ;
  commit;
  INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES (
      increment_sequence('tspd_template_email_seq'), 
      'CLOSE_SNAPSHOT_DATE_AND_TIME', 
      'Protocol <protocol id> / <snapshot name> document closed for review',
'The <protocol id> / <snapshot name> protocol has been closed for further review.  
The review was due <review due date> at <review due time>.  If you have not yet
completed your review and have additional comments please notify me directly.'
      ); 
  
  INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES (
      increment_sequence('tspd_template_email_seq'), 
      'CLOSE_SNAPSHOT_DATE', 
      'Protocol <protocol id> / <snapshot name> document closed for review',
'The <protocol id> / <snapshot name> protocol has been closed for further review.
The review was due <review due date>.  If you have not yet completed your 
review and have additional comments please notify me directly.'
      ); 

  INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES (
      increment_sequence('tspd_template_email_seq'), 
      'CLOSE_SNAPSHOT', 
      'Protocol <protocol id> / <snapshot name> document closed for review',
'The <protocol id> / <snapshot name> protocol has been closed for further review.
If you have not yet completed your review and have additional comments please 
notify me directly.'
      ); 


INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES (
       increment_sequence('tspd_template_email_seq'),
      'REVIEW_NONFINAL_SNAPSHOT',
      'Protocol <protocol id> / <snapshot name> document posted for your review',
'The <protocol id> / <snapshot name> protocol has been posted for your review.
Please log into TrialSpace Designer to review and add your comments.  
Once your review is complete, please submit and sign your review.  
If you are unable to complete your review you may re-assign the 
review to another reviewer.');

  INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES (
      increment_sequence('tspd_template_email_seq'),
      'SUBMIT_REVIEW',
      'Review submitted for protocol <protocol id> / <snapshot name>',
'<reviewer display name> has submitted a review for protocol <protocol id> / <snapshot name>
Review Status: <completion status> / <review status>
Notes: <review notes>');


INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'USER_TRIAL_ROLE_DELETED',
  'Change in roles for protocol <protocol id>',
  '<user being deleted> has been deleted as <user role> from protocol <protocol id>.');

INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'USER_TRIAL_ROLE_ADDED',
  'Change in roles for protocol <protocol id>',
  '<user being added> has been added as <user role> to protocol <protocol id>.');

INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'USER_TRIAL_ROLE_REPLACED',
  'Change in roles for protocol <protocol id>',
  '<user being added> has been added as <user role> to protocol <protocol id>.  <user being replaced> has been replaced as <user role>.');


INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'REASSIGN_AUTHOR',
  'Change in authorship for protocol <protocol id>',
  'Authorship of protocol <protocol id> has been reassigned to <new author>.');

INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'REASSIGN_REVIEWER',
  'Change in reviewer for protocol <protocol id> / <snapshot name>',
  '<reviewer being added> has been added as reviewer to protocol <protocol id> / <snapshot name>.  <reviewer being replaced> has been replaced as reviewer.');



INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'REVIEW_CC',
  'Protocol <protocol id> / <snapshot name>',
'The <protocol id> / <snapshot name> protocol is available for your review.  
You will find it attached to this message in PDF format.');

INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'FINAL_SNAPSHOT',
  'Final protocol <protocol id> created', 
'The final <protocol id> protocol has been created.  You will find it attached 
to this message in PDF format.');


INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'REVIEWER_REMINDER',
  'Protocol <protocol id> / <snapshot name> document will be closed for review in <# days> days',
'The <protocol id> / <snapshot name> protocol will be closed for your review in 
<# days> days.  Your review has not yet been completed.  Please log in to the 
TrialSpace Designer to review and add your comments.  Once your review is 
complete, please submit and sign your reivew.  If you are unable to complete 
your review you may re-assign the review to another reviewer.');

commit;

-- Following chnages are as per the request of Kelly/Fiammetta on 11/6/2003 at 11 am

update id_control set NEXT_ID=10000 where
lower(table_name) = 'tspd_template';

insert into id_control select 'tsm10','shared_tspd_template',
nvl(max(id),0)+1 from tspd_template;

commit;

-- Implemented in tsm10e@test upto this on 11/10/2003 at 10:17

-- Following chnages are as per the request of Kelly on 11/14/2003 at 10am

Alter table tspd_template add constraint
tspd_template_uq1 unique(CLIENT_DIV_ID, NAME)
using index tablespace TSPDSMALL_INDX
pctfree 10;

-- Implemented in tsm10@test upto this on 11/17/2003 at 4:09 PM

-- Following chnages are as per the request of Kelly on 11/24/2003 at 1:45PM

conn ftcommon/******@??????

Alter table application drop constraint APPLICATION_APP_NAME_CHECK;

Insert into ftcommon.application(ID,APP_NAME,EXTERNAL_NAME) 
values(3,'TSPD','TrialSpace Designer');

Alter table application add constraint APPLICATION_APP_NAME_CHECK
check (app_name in ('PICASE', 'TRACE','TSPD'));

commit;


--************************************************************ 
-- Implemented in tsm10e@test upto this on 11/26/2003 at 14:53
-- Implemented in tsm10@test upto this on 12/01/2003 at 10:30 AM
-- Implemented in tsm10p@prev upto this on 12/2/2003 at 12:52 
-- Implemented in tsm10t@prod upto this on 12/3/2003 at 16:40 
-- Implemented in tsm10e@prev upto this on 11/5/2004 at 20:40 
-- Implemeted in tsm10e@PROD upto this on 11/6/2004 at 00:41
-- Implemeted in tsm10@PROD upto this on 11/6/2004 at 00:41
--************************************************************ 





---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  45   DevTSM    1.44        2/22/2008 11:56:03 AMDebashish Mishra  
--  44   DevTSM    1.43        9/19/2006 12:11:36 AMDebashish Mishra   
--  43   DevTSM    1.42        3/2/2005 10:51:07 PM Debashish Mishra  
--  42   DevTSM    1.41        11/16/2004 12:38:35 AMDebashish Mishra  
--  41   DevTSM    1.40        12/8/2003 5:57:09 PM Debashish Mishra  
--  40   DevTSM    1.39        12/3/2003 12:18:16 PMDebashish Mishra Moved tags
--       around
--  39   DevTSM    1.38        11/24/2003 2:45:27 PMDebashish Mishra  
--  38   DevTSM    1.37        11/14/2003 11:49:41 AMDebashish Mishra Added unique
--       constraint to tspd_template
--  37   DevTSM    1.36        11/6/2003 12:13:24 PMDebashish Mishra Made changes
--       to id_control table as per the request of Kelly
--  36   DevTSM    1.35        11/4/2003 11:19:34 AMDebashish Mishra Added Insert
--       satements to tspd_template_email
--  35   DevTSM    1.34        11/4/2003 10:59:56 AMDebashish Mishra  
--  34   DevTSM    1.33        10/5/2003 12:20:49 PMDebashish Mishra Added new
--       constrasint value AuthorChange to tspd_document.snapshot_type
--  33   DevTSM    1.32        10/3/2003 3:28:50 PM Debashish Mishra Updated
--       tspd_lib_element_noblob
--  32   DevTSM    1.31        10/3/2003 3:15:35 PM Debashish Mishra new column
--       tspd_lib_element.inline_data
--  31   DevTSM    1.30        10/2/2003 3:24:43 PM Debashish Mishra Removed
--       tspd_doc_advisory.advisory.rule
--  30   DevTSM    1.29        9/30/2003 9:32:40 AM Debashish Mishra Moved update
--       flags around
--  29   DevTSM    1.28        9/26/2003 4:05:56 PM Debashish Mishra  
--  28   DevTSM    1.27        9/22/2003 7:46:55 AM Debashish Mishra modified
--       content_type and content_subtype in tspd_lib_element
--  27   DevTSM    1.26        9/19/2003 9:55:32 AM Debashish Mishra updated
--       tspd_document_noblob view
--  26   DevTSM    1.25        9/16/2003 8:28:39 PM Debashish Mishra  
--  25   DevTSM    1.24        9/9/2003 8:23:54 AM  Debashish Mishra  
--  24   DevTSM    1.23        9/3/2003 10:29:35 AM Debashish Mishra moved labels
--       for tsm10e@test
--  23   DevTSM    1.22        8/26/2003 4:39:18 PM Debashish Mishra  
--  22   DevTSM    1.21        8/11/2003 12:00:35 PMDebashish Mishra  
--  21   DevTSM    1.20        7/30/2003 4:45:23 PM Debashish Mishra  
--  20   DevTSM    1.19        7/23/2003 2:13:05 PM Debashish Mishra removed
--       default value from tspd_template.last_updated
--  19   DevTSM    1.18        7/23/2003 12:30:30 PMDebashish Mishra Constraint
--       modified in custom_set and unlisted_procedure
--  18   DevTSM    1.17        7/16/2003 4:48:19 PM Debashish Mishra  
--  17   DevTSM    1.16        7/14/2003 5:10:00 PM Debashish Mishra Chnages made
--       as requested by Kelly on 07-14-2003
--  16   DevTSM    1.15        7/9/2003 5:09:59 PM  Debashish Mishra  
--  15   DevTSM    1.14        7/7/2003 9:05:22 AM  Debashish Mishra New grant on
--       ft_foreign_key_info from ft15 to tsm10
--  14   DevTSM    1.13        7/2/2003 5:43:20 PM  Debashish Mishra  
--  13   DevTSM    1.12        6/30/2003 8:58:57 AM Debashish Mishra New column
--       client_div.build_tag_id
--  12   DevTSM    1.11        6/20/2003 11:26:54 AMDebashish Mishra Modified
--       constraints in custom_set and unlisted_procedures
--  11   DevTSM    1.10        6/19/2003 3:26:50 PM Debashish Mishra Added
--       constraint values to custom_set.type and unlisted_procedure.type
--  10   DevTSM    1.9         6/19/2003 11:45:28 AMDebashish Mishra Added unique
--       constraint to password_rule.cliet_div_id
--  9    DevTSM    1.8         6/13/2003 8:00:51 AM Debashish Mishra  
--  8    DevTSM    1.7         5/30/2003 4:30:40 PM Debashish Mishra  
--  7    DevTSM    1.6         5/30/2003 12:03:47 PMDebashish Mishra Added foreign
--       key/check constraints
--  6    DevTSM    1.5         5/28/2003 3:48:20 PM Debashish Mishra  
--  5    DevTSM    1.4         5/22/2003 2:51:42 PM Debashish Mishra TSPD new
--       tables
--  4    DevTSM    1.3         1/20/2003 3:35:53 PM Debashish Mishra  
--  3    DevTSM    1.2         1/7/2003 9:13:16 AM  Debashish Mishra MOdified
--       constraint in ftgroup table
--  2    DevTSM    1.1         1/6/2003 10:51:56 AM Debashish Mishra Modified more
--       check constraints
--  1    DevTSM    1.0         1/3/2003 6:10:36 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
