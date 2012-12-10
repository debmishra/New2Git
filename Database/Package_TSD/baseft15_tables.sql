--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: baseft15_tables.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:07 PM$
--
--
-- Description:  Create tables.
--
---------------------------------------------------------------------
 
create table Disease(
    ID numeric(10),
    name varchar2(128) not null)
    tablespace ftsmall 
    pctused 90 pctfree 5;

Alter table Disease add constraint disease_pk 
  primary key (ID) using index tablespace ftsmall_indx
  pctfree 5 Nologging;

Alter table Disease add constraint disease_uq1
  unique (name) using index tablespace ftsmall_indx
  pctfree 5 Nologging;

create table Stage(
    ID numeric(10),
    name varchar2(128) not null,
    display_category varchar2(128) not null)
    tablespace ftsmall
    pctused 90 pctfree 5;

Alter table Stage add constraint stage_pk 
    primary key (ID) using index tablespace ftsmall_indx
    pctfree 5 Nologging;

Alter table Stage add constraint stage_uq1
   unique (name) using index tablespace ftsmall_indx
   pctfree 5 Nologging;

create table Disease_to_Stage (
	disease_id numeric(10),
	stage_id numeric(10),
	sort_order numeric(4) not null)
        tablespace ftsmall 
        pctused 90 pctfree 5;

Alter table Disease_to_Stage add constraint Disease_to_Stage_pk
   primary key (disease_id,stage_id) using index tablespace ftsmall_indx
   pctfree 5 Nologging;      

create table Trial(
    ID Numeric(10),
    GUID varchar2 (128) not null,
    disease_ID numeric (10) not null, 	/* foreign key */
    trial_status VARCHAR2(40) not null constraint check_status CHECK 
	( trial_status in ('CREATION', 'ACTIVE', 'CLOSED'))) 
    Tablespace ftsmall
    pctused 80 pctfree 10;

Alter table trial add constraint trial_pk 
    primary key(ID) using index tablespace ftsmall_indx
    pctfree 10 Nologging;

Alter table trial add constraint trial_uq1
    unique (GUID) using Index tablespace ftsmall_indx
    pctfree 10 Nologging;

create table Protocol_Version(
    ID numeric(10),
    authored_sponsor_name varchar2(128),
    authored_trial_name varchar2(256),
    full_title varchar2(1024),
    short_title varchar2(256),
    information varchar2(4000),
    version_name varchar2(128) not null,
    version_date date not null,
    trial_ID numeric(10), 		/* foreign key */
    release_status varchar2(40) constraint check_rel_status CHECK 
	(release_status in ('TESTING', 'RELEASED')))
    Tablespace ftlarge 
    pctused 70 pctfree 15 ;

Alter table Protocol_Version add constraint Protocol_Version_pk
    primary key (ID) using index tablespace ftlarge_indx
    pctfree 15 Nologging;

create table Protocol_Version_to_Stage (
	protocol_version_id numeric(10),
	stage_id numeric(10),
	sort_order numeric(4) not null)
        tablespace ftsmall 
        pctused 70 pctfree 15;

Alter table Protocol_Version_to_Stage add constraint 
     Protocol_Version_to_Stage_pk 
     primary key (protocol_version_id,stage_id)
     using Index tablespace ftsmall_indx 
     pctfree 15 Nologging;

create table Criterion (
    ID numeric(10) ,
	seq numeric(4) not null,
    GUID varchar2(128) not null,
    short_desc varchar2(256),
    long_desc varchar2(4000),
    category char(1) not null constraint category_check CHECK 
	(category in ('I','E')),
    protocol_version_ID numeric(10) not null  /* foreign key */
   )Tablespace ftlarge 
   pctused 70 pctfree 15 ;

Alter table criterion add constraint criterion_pk 
   primary key (ID) using Index tablespace ftlarge_indx
   pctfree 15 nologging;

Alter table criterion add constraint criterion_uq1
   unique (protocol_version_id, category, seq)
   using index tablespace ftlarge_indx
   pctfree 15 nologging;
   
create table Site(
    ID numeric(10),
    site_identifier varchar2(40) not null,
    name varchar2(128) not null,
    FT_site_name varchar2(128),
    base_fasttrack_URL varchar2(128),
    main_site_contact_name varchar2(128),
    main_site_location varchar2(256),
    time_zone_id varchar2 (25) not null,
    locale varchar2 (20))
    tablespace ftsmall     pctused 80 pctfree 10;

Alter table site add constraint site_pk 
    primary key (ID) using Index tablespace ftsmall_indx
    pctfree 10 nologging;

Alter table site add constraint site_uq1
    unique (site_identifier) using Index tablespace ftsmall_indx
    pctfree 10 nologging;
    
Alter table site add constraint site_uq2
    unique (name) using Index tablespace ftsmall_indx
    pctfree 10 nologging;

create table Site_to_Trial (
	ID numeric (10),
	site_ID numeric(10) not null,		/* foreign key */
	trial_ID numeric(10) not null,		/* foreign key */
        protocol_version_ID numeric(10) not null, /* foreign key */
	site_sponsor_name varchar2 (128),
	site_trial_name varchar2 (256),
	site_version_name varchar2 (128),
	clinical_coord_fname varchar2(80),
	clinical_coord_lname varchar2(80),
	clinical_coord_phone varchar2(20),
	accrual_status varchar2(40) constraint accrual_status_check CHECK
		( accrual_status in ('ACTIVE','HOLD','CLOSED')),
	patient_mngment_sts varchar2(40) constraint patient_mngment_sts_check
		CHECK (patient_mngment_sts in ('NONE','ACTIVE','CLOSED')))
        tablespace ftsmall
        pctused 60 pctfree 20 ;

Alter table site_to_trial add constraint site_to_trial_pk
    primary key (ID) using index tablespace ftsmall_indx
    pctfree 20 nologging;

Alter table site_to_trial add constraint site_to_trial_uq1
    unique (site_ID, trial_ID, protocol_version_ID) 
    using index tablespace ftsmall_indx
    pctfree 20 nologging;

create table HandHeld_Group
(	ID numeric(10),
	name varchar2(80) not null,
	site_ID numeric (10) not null, /* foreign key */
	pin varchar2(16) not null)
        tablespace ftsmall 
        pctused 70 pctfree 15 ;

Alter table HandHeld_Group add constraint HandHeld_Group_pk
    primary key (ID) using index tablespace ftsmall_indx
    pctfree 15 nologging;

Alter table HandHeld_Group add constraint HandHeld_Group_uq1
    unique (name, site_ID) 
    using index tablespace ftsmall_indx
    pctfree 15 nologging;


create table HandHeld_Group_to_Disease
(	HandHeld_Group_ID numeric(10),	/* foreign key */
	Disease_ID numeric(10))
        tablespace ftsmall
        pctused 70 pctfree 20 ;

Alter table HandHeld_Group_to_Disease add constraint 
    HandHeld_Group_to_Disease_pk
    primary key (HandHeld_Group_ID, Disease_ID) 
    using index tablespace ftsmall_indx
    pctfree 20 nologging;

create table HandHeld_Device
(	ID numeric (10) not null,
	device_ID varchar2(80) not null,
	HandHeld_Group_ID numeric (10) not null, /* foreign key */
	last_synch_time date,
	hh_type varchar2 (40) not null constraint hh_type_check CHECK (
		hh_type in ('QUICKSCREEN','TASK MANAGEMENT')),
        comments varchar2(256))
        tablespace ftsmall
        pctused 70 pctfree 15 ;

Alter table HandHeld_Device add constraint HandHeld_Device_pk
    primary key (ID) using index tablespace ftsmall_indx
    pctfree 15 nologging;

Alter table HandHeld_Device add constraint HandHeld_Device_uq1
    unique (device_id) using index tablespace ftsmall_indx
    pctfree 15 nologging;


create table Arm (
   ID Number (10),
   GUID varchar2 (128) not null,
   Trial_id number(10) not null,
   short_desc varchar2(256) not null,
   long_desc varchar2(4000))
   tablespace ftlarge pctused 70 pctfree 15;

Alter table Arm add constraint Arm_pk 
   primary key (ID) using Index tablespace ftlarge_indx
   pctfree 15 nologging;

Alter table Arm add constraint Arm_uq1
   unique (GUID, Trial_id) using index tablespace ftlarge_indx
   pctfree 15 nologging;

create table Visit_type (
   ID number(10),
   GUID varchar2 (128) not null,
   trial_id number(10) not null,
   short_desc varchar2(256) not null,
   long_desc varchar2(4000),
   category varchar2(10) not null constraint visit_type_category_check 
   CHECK (category in ('Treatment','Followup')))
   tablespace ftlarge pctused 70 pctfree 15;

Alter table Visit_type add constraint Visit_type_pk 
   primary key (ID) using Index tablespace ftlarge_indx
   pctfree 15 nologging;

Alter table Visit_type add constraint Visit_type_uq1
   unique (GUID, Trial_id) using index tablespace ftlarge_indx
   pctfree 15 nologging;

create table visit_task (
   ID number(10),
   GUID varchar2 (128) not null,
   trial_id number(10) not null,
   short_desc varchar2(256) not null,
   long_desc varchar2(4000))
   tablespace ftlarge pctused 70 pctfree 15;

Alter table Visit_task add constraint Visit_task_pk 
   primary key (ID) using Index tablespace ftlarge_indx
   pctfree 15 nologging;

Alter table Visit_task add constraint Visit_task_uq1
   unique (GUID, Trial_id) using index tablespace ftlarge_indx
   pctfree 15 nologging;

create table visit_task_to_visit_type(
   ID number(10),
   visit_task_id number(10) not null,
   visit_type_id number(10) not null,
   seq number(4) not null,
   obsoleted_protocol_version_id number(10),
   added_protocol_version_id number(10) not null)
   tablespace ftlarge pctused 70 pctfree 15;

Alter table visit_task_to_visit_type 
   add constraint visit_task_to_visit_type_pk 
   primary key (ID) using Index tablespace ftlarge_indx
   pctfree 15 nologging;

Alter table visit_task_to_visit_type
   add constraint visit_task_to_visit_type_uq1
   unique (visit_task_id, visit_type_id) using index tablespace ftlarge_indx
   pctfree 15 nologging;

create table visit_type_to_arm (
   ID number(10),
   visit_type_id number(10) not null,
   arm_id number(10) not null,
   seq number(4) not null,
   obsoleted_protocol_version_id number(10),
   added_protocol_version_id number(10) not null)
   tablespace ftlarge pctused 70 pctfree 15;

Alter table visit_type_to_arm 
   add constraint visit_type_to_arm_pk 
   primary key (ID) using Index tablespace ftlarge_indx
   pctfree 15 nologging;

Alter table visit_type_to_arm
   add constraint visit_type_to_arm_uq1
   unique (visit_type_id, arm_id) using index tablespace ftlarge_indx
   pctfree 15 nologging;

create table arm_to_protocol_version (
   ID number(10),
   arm_id number(10) not null,
   protocol_version_id number(10) not null,
   seq number(4) not null)
   tablespace ftlarge pctused 70 pctfree 15;  

Alter table arm_to_protocol_version 
   add constraint arm_to_protocol_version_pk 
   primary key (ID) 
   using Index tablespace ftlarge_indx
   pctfree 15 nologging;

Alter table arm_to_protocol_version
   add constraint arm_to_protocol_version_uq1
   unique (arm_id, protocol_version_id) using index tablespace ftlarge_indx
   pctfree 15 nologging;




---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:07 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:37:51 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:26:49 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
