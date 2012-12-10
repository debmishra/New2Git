--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: baseft15_1_4.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:05 PM$
--
--
-- Description:  rel1.3 to 1.4 migration script
--
---------------------------------------------------------------------
 
create sequence Candidate_seq;
create sequence Site_Checklist_Template_seq;
create sequence Visit_Checklist_Template_seq;
create sequence Monitor_seq;
create sequence Therapeutic_Area_seq;
create sequence TAClassifier_seq;
create sequence TAClassifier_to_TA_seq;
create sequence FTUser_TAClassifier_Filter_seq;
create sequence FTUser_Trial_Filter_seq;
create sequence HHGroup_to_Classifiers_seq;
create sequence ftuser_to_aclentries_seq;
create sequence ftgroup_to_aclentries_seq;
create sequence ft_foreign_key_info_seq;
create sequence PV_to_Classifier_seq;
create sequence protocol_event_seq;
create sequence protocol_event_group_seq;
create sequence patient_management_task_seq;
create sequence peg_to_peg_seq;
create sequence peg_to_event_seq;
create sequence task_to_protocol_event_seq;
create sequence event_core_seq;
create sequence protocol_evgroup_inst_seq;
create sequence subject_encounter_seq;
create sequence misc_event_prototype_seq;
create sequence monitor_site_visit_seq;
create sequence setup_event_mon_instance_seq;
create sequence monitor_trip_seq;
create sequence regulatory_document_seq;
create sequence study_setup_event_seq;
create sequence general_event_seq;
create sequence cra_manager_to_monitor_seq;
create sequence cra_manager_to_trial_seq;
create sequence monitor_to_site_to_trial_seq;
create sequence unencoded_event_seq;
create sequence site_to_trial_pv_history_seq;
create sequence ftuser_login_history_seq;
create sequence HANDHELD_USE_history_seq;



create table Candidate(
	ID number(10),
	patient_id number(10),
	trial_id number(10),
	primary_cc_contact_id number(10), 
	primary_phys_contact_id number(10),
	pre_screening_status varchar2(50), 
	pre_screening_failure_status varchar2(50),
	pre_screening_comment varchar2(255), 
	pre_screening_failure_comment varchar2(255),
	pre_screening_failure_date date,
	pre_screening_enrolled_date date,
	include_in_screen_log number(5),
	schedule_event_on_date date,
	schedule_event_comment varchar2(255), 
	reminder_event_only number(5))
        tablespace ftlarge pctused 60 pctfree 25; 

Alter table Candidate add constraint Candidate_pk
        primary key (id) using index tablespace 
        ftlarge_indx pctfree 25 Nologging;

Alter table candidate add constraint candidate_contact_fk1 
        foreign key (primary_cc_contact_id)
        references contact (id);

Alter table candidate add constraint candidate_contact_fk2 
        foreign key (primary_phys_contact_id)
        references contact (id);

Alter table candidate add constraint candidate_patient_fk3
        foreign key (patient_id) 
        references patient(id);

Alter table candidate add constraint candidate_trial_fk4
        foreign key (trial_id) 
        references trial(id);

Alter table Candidate add constraint  candidate_ps_status_check
        check (pre_screening_status in ('Active Candidate','Enrolled','Pre-Screening Failure'));

Alter table Candidate add constraint candidate_ps_failure_check
        check (pre_screening_failure_status in
        ('Refused Consent','Failed Criteria','Clinician Decision','Other'));
	
create table Site_Checklist_Template(
	ID number(10),
	trial_ID number(10),
	seq number(10),
	question varchar2(128))
        tablespace ftsmall pctused 70 pctfree 15;

Alter table Site_Checklist_Template add constraint 
        Site_Checklist_Template_pk primary key (id) using index tablespace 
        ftsmall_indx pctfree 15 nologging;

Alter table Site_Checklist_Template add constraint
        Site_Cklst_Template_trial_fk1 foreign key (trial_id)
        references trial(id);


create table Visit_Checklist_Template(
	ID number(10),
	category varchar2(50),	 
	seq number(10),
	question varchar2(128))
        tablespace ftsmall pctused 70 pctfree 15;

Alter table Visit_Checklist_Template add constraint 
        Visit_Checklist_Template_pk primary key (id) using index tablespace 
        ftsmall_indx pctfree 15 nologging;

Alter table Visit_Checklist_Template add constraint
        Visit_Cklst_Template_uq1 unique (category,seq) using index tablespace 
        ftsmall_indx pctfree 15 nologging;


Alter table Visit_Checklist_Template add constraint Visit_Cklst_Tmplt_ctgry_check
        check ( category in ('SCREENING','TREATMENT','FOLLOWUP'));

create table Monitor(
	ID number(10),
	sponsor_ID number(10),
	monitor_ftuser_id number(10),
	manager_ftuser_id number(10))
        tablespace ftsmall pctused 65 pctfree 20;

Alter table Monitor add constraint 
        Monitor_pk primary key (id) using index tablespace 
        ftsmall_indx pctfree 20 nologging;

Alter table Monitor add constraint
        Monitor_sponsor_fk1 foreign key (sponsor_id)
        references sponsor(id);

Alter table Monitor add constraint
        Monitor_ftuser_fk2 foreign key (monitor_ftuser_id)
        references ftuser(id);

Alter table Monitor add constraint
        Monitor_ftuser_fk3 foreign key (manager_ftuser_id)
        references ftuser(id);

Create table Therapeutic_Area(
	ID number(10),
	name varchar2(128))
        tablespace ftsmall pctused 70 pctfree 15;

Alter table Therapeutic_Area add constraint 
        Therapeutic_Area_pk primary key (id) using index tablespace 
        ftsmall_indx pctfree 15 nologging;

Insert into Therapeutic_Area values (1,'Oncology');
commit;
	

Create table TAClassifier(
	ID number(10),
	name  varchar2(128))
        tablespace ftsmall pctused 65 pctfree 20;

Alter table TAClassifier add constraint 
        TAClassifier_pk primary key (id) using index tablespace 
        ftsmall_indx pctfree 20 nologging;

Insert into TAClassifier select id,name from disease;
commit;

create table TAClassifier_to_TA(
        ID number(10),
        TAClassifier_id number(10) not null,
        TA_ID number(10) not null)
        tablespace ftsmall pctused 65 pctfree 20;

Alter table TAClassifier_to_TA add constraint 
        TAClassifier_to_TA_pk primary key (id) using index tablespace 
        ftsmall_indx pctfree 20 nologging;

Alter table TAClassifier_to_TA add constraint
        TAClassifier_to_TA_fk1 foreign key (TAClassifier_id)
        references TAClassifier(id);

Alter table TAClassifier_to_TA add constraint
        TAClassifier_to_TA_fk2 foreign key (TA_ID)
        references Therapeutic_Area(id);

	
Create table FTUser_TAClassifier_Filter(
	ID number(10),
	ftuser_ID number(10),
	taclassifier_ID number(10))
        tablespace ftsmall pctused 65 pctfree 20;

Alter table FTUser_TAClassifier_Filter add constraint 
        FTUser_TAClassifier_Filter_pk primary key (id) using index tablespace 
        ftsmall_indx pctfree 20 nologging;

Alter table FTUser_TAClassifier_Filter add constraint
        FTUser_TAClass_Flt_fk1 foreign key (ftuser_id)
        references FTUser(id);

Alter table FTUser_TAClassifier_Filter add constraint
        FTUser_TAClass_Flt_fk2 foreign key (taclassifier_id)
        references taclassifier(id);

Insert into FTUser_TAClassifier_Filter select id,ftuser_id,disease_id from ftuser_to_disease;

Create table FTUser_Trial_Filter(
	ID number(10),
	ftuser_ID number(10),
	trial_ID number(10))
        tablespace ftsmall pctused 65 pctfree 20;

Alter table FTUser_Trial_Filter add constraint 
        FTUser_Trial_Filter_pk primary key (id) using index tablespace 
        ftsmall_indx pctfree 20 nologging;

Alter table FTUser_Trial_Filter add constraint
        FTUser_Trial_Filter_fk1 foreign key (ftuser_id)
        references FTUser(id);

Alter table FTUser_Trial_Filter add constraint
        FTUser_Trial_Filter_fk2 foreign key (trial_id)
        references trial(id);

Create table HHGroup_to_Classifiers(
	ID number(10),
	hhgroup_id number(10),
	taclassifier_ID number(10))
        tablespace ftsmall pctused 65 pctfree 20;

Alter table HHGroup_to_Classifiers add constraint 
        HHGroup_to_Classifiers_pk primary key (id) using index tablespace 
        ftsmall_indx pctfree 20 nologging;

Alter table HHGroup_to_Classifiers add constraint
        HHGroup_to_Classifiers_fk1 foreign key (hhgroup_id)
        references handheld_group(id);

Alter table HHGroup_to_Classifiers add constraint
        HHGroup_to_Classifiers_fk2 foreign key (taclassifier_id)
        references taclassifier(id);

Insert into HHGroup_to_Classifiers select HHGroup_to_Classifiers_seq.nextval,
        handheld_group_id, disease_id from handheld_group_to_disease;
commit;

-- rename handheld_group_to_disease to handheld_group_to_disease_old;


create table FT_Foreign_Key_Info (
        ID  number(10),
        PKTable_Name varchar2(128),
        PKColumn_Name varchar2(128),
        FKTable_Name varchar2(128),
        FKColumn_Name varchar2(128))
        tablespace ftsmall pctused 65 pctfree 20;

Alter table FT_Foreign_Key_Info add constraint
        FT_Foreign_Key_Info_pk primary key (id) using index tablespace
        ftsmall_indx pctfree 20 nologging;


create table PV_to_Classifier (
	ID  number(10),
	protocol_version_id  number(10),
	taclassifier_id  number(10),
	protocol_Type_ID  number(10))
        tablespace ftsmall pctused 65 pctfree 20;

Alter table PV_to_Classifier add constraint 
        PV_to_Classifier_pk primary key (id) using index tablespace 
        ftsmall_indx pctfree 20 nologging;

Alter table PV_to_Classifier add constraint
        PV_to_Classifier_fk1 foreign key (protocol_version_id)
        references protocol_version(id);

Alter table PV_to_Classifier add constraint
        PV_to_Classifier_fk2 foreign key (taclassifier_id)
        references taclassifier(id);

Alter table PV_to_Classifier add constraint
        PV_to_Classifier_fk3 foreign key (protocol_Type_ID)
        references protocol_Type(id);

Insert into pv_to_classifier select * from pv_to_disease;
commit;
-- rename pv_to_disease to pv_to_disease_old;

-- *************************
-- Changes to existing tables
-- *************************

Alter table sponsor add(main_contact_id number(10));

Alter table sponsor add constraint
        sponsor_contact_fk1 foreign key (main_contact_id)
        references contact(id);

Alter table Site add (num_weeks_past_on_hh number(4) default 1,
	              num_weeks_forward_on_hh  number(4) default 8);

Alter table trial add(
	sponsor_id number(10),
	accrual_status varchar2(50),
	patient_mngmnt_status varchar2(50),
	expected_accrual_close_date date,
	expected_lplv_date date,
	start_date date,
	created_by varchar2(50),		 
	use_study_setup_docs number(4));

Alter table trial add constraint trial_sponsor_fk1 
        foreign key(sponsor_id) references sponsor(id);	 

Alter table trial add constraint trial_created_by_check
        check (created_by in ('Sponsor','Site','FastTrack'));

Alter table Site_to_Trial add(
	last_monitor_date date,
	next_monitor_date date,
	key_eligib_summary varchar2(128),
	expected_lplv_date date,
	cra_notes varchar2(255),
	monitor_contact_id number(10),
	who_maintains_stats varchar2(50),	 
	screening_failures number(10),	 
	num_deceased number(10),
	last_modified_date date	default sysdate);
	
Alter table site_to_trial add constraint stt_who_check 
        check (who_maintains_stats in ('Sponsor', 'Site'));

Alter table site_to_trial drop constraint site_to_trial_uq1;

Alter table site_to_trial add constraint site_to_trial_uq1
    unique (site_ID, trial_ID) 
    using index tablespace ftsmall_indx
    pctfree 20 nologging;

alter table site_to_trial add constraint site_to_trial_contact_fk4
foreign key (MONITOR_CONTACT_ID) references contact (id);

-- screening_failures	(int, trigger generated from candidate prescreen failure)
-- num_deceased		(int, trigger generated from patient status)
-- last_modified_date	(trigger on update/insert)

Alter table Patient add(status varchar2(50));

Alter table patient add constraint patient_status_check
       check (status in ('Active','Deceased','Inactive'));	

Alter table Subject add(
	last_modified_date date default sysdate,
	screening_identifier varchar2(50));

-- last_modified_date	(trigger on update/insert)	

Alter table Protocol_Version add(special_instructions varchar2(255));

Alter table Contact add(
	address_line_1 varchar2(255),
	address_line_2 varchar2(255),
	city  varchar2(255),
	state  varchar2(255),
	postal_code  varchar2(20),
	country  varchar2(255),
	work_phone  varchar2(50),
	home_phone  varchar2(50),
	fax  varchar2(50),
	mobile_phone  varchar2(255),
	email varchar2(100),
	preferred_contact varchar2(50),
	site_id number(10),
	sponsor_id number(10));

Alter table contact add constraint contact_site_fk1
        foreign key (site_id) references site(id);

Alter table contact add constraint contact_sponsor_fk2
        foreign key (sponsor_id) references sponsor(id);

Update contact set work_phone=phone;
alter table contact drop column phone;

Alter table FTUser add(
	last_login_date date,
	primary_TA_ID varchar2(128));	


-- Following changes were done as per the request of collin on 11/20/2000

Alter table ftgroup drop constraint FTGROUP_MEMBER_FK1;

drop sequence ftuser_to_ftgroup_seq;
create sequence ftuser_to_ftgroup_seq;

delete from ftgroup where id=1;

Insert into ftgroup values (1,'Fast Track Administrator','dummy data');

-- Insert into ftuser_to_ftgroup 
--	select ftuser_to_ftgroup_seq.nextval,
--	a.id,1 from ftuser a,ftgroup b where a.name = b.member;

Alter table ftgroup drop column member;

Delete from ftgroup where id <>1;

Insert into ftgroup values (2,'Site Administrator');
Insert into ftgroup values (3,'Sponsor Administrator');
Insert into ftgroup values (4,'Site User');
Insert into ftgroup values (5,'CRA');
Insert into ftgroup values (6,'CRA Manager');

insert into ftuser_to_ftgroup
       select ftuser_to_ftgroup_seq.nextval,id,4 from ftuser;


Alter table Aclentries drop column FTGROUP_ID;
Alter table Aclentries drop column PRINCIPAL;
Alter table Aclentries modify(permission not null);
-- Alter table ftuser drop column sponsor_id;
-- Alter table ftuser drop column site_id;
-- Alter table ftuser drop column first_name;
-- Alter table ftuser drop column last_name;

Create table ftuser_to_aclentries(
         id number(10),
         ftuser_id number(10) not null,
         aclentries_id number(10) not null)
         tablespace ftsmall
         pctused 65 pctfree 20;

Alter table ftuser_to_aclentries add constraint
         ftuser_to_aclentries_pk primary key (id)
         using index tablespace ftsmall_indx
         pctfree 20 nologging;

Alter table ftuser_to_aclentries add constraint 
         ftuser_to_aclentries_fk1 foreign key (ftuser_id)
         references ftuser(id);

Alter table ftuser_to_aclentries add constraint 
         ftuser_to_aclentries_fk2 foreign key (aclentries_id)
         references aclentries(id);

Create table ftgroup_to_aclentries(
         id number(10),
         ftgroup_id number(10) not null,
         aclentries_id number(10) not null)
         tablespace ftsmall
         pctused 65 pctfree 20;

Alter table ftgroup_to_aclentries add constraint
         ftgroup_to_aclentries_pk primary key (id)
         using index tablespace ftsmall_indx
         pctfree 20 nologging;

Alter table ftgroup_to_aclentries add constraint 
         ftgroup_to_aclentries_fk1 foreign key (ftgroup_id)
         references ftgroup(id);

Alter table ftgroup_to_aclentries add constraint 
         ftgroup_to_aclentries_fk2 foreign key (aclentries_id)
         references aclentries(id);

-- following triggers are added as per the original request of Kelly

create or replace trigger subject_last_modified_trg1
before insert or update on Subject
referencing new as n old as o
for each row
begin
select sysdate into :n.last_modified_date from dual;
end;
/
sho err

create or replace trigger stt_last_modified_trg1
before insert or update on site_to_trial
referencing new as n old as o
for each row
begin
select sysdate into :n.last_modified_date from dual;
end;
/
sho err

create or replace trigger patient_status_trg1
after  update of status on patient
referencing new as n old as o
for each row
begin

if  :n.status = 'Deceased' and :n.status <> :o.status then

   update site_to_trial set num_deceased = nvl(num_deceased,0)+1 
   where id in (select site_to_trial_id from subject where 
   patient_id = :n.id);

end if;

end;
/
sho err


create or replace trigger candidate_ps_status_trg1
after  insert or update of pre_screening_status on candidate
referencing new as n old as o
for each row
begin

if  :n.pre_screening_status = 'Pre-Screening Failure' and 
    :n.pre_screening_status <> :o.pre_screening_status then

    update site_to_trial set screening_failures = nvl(screening_failures,0)+1
    where trial_id = :n.trial_id and 
          site_id in (select site_id from patient where id=:n.patient_id);

end if;

end;
/
sho err


    
-- Following changes were done as per the request of Phil on 12/04/2000 at 13:30 

Alter table handheld_device add
(ftuser_id number(10) constraint handheld_device_fk2 references ftuser(id),
pin varchar2(16));

create or replace trigger handheld_device_trg1
after insert or update on handheld_device
referencing new as n old as o
for each row
declare

relation_check exception;
relation_exist exception;
invalid_pin exception;

begin

If :n.handheld_group_id is not null and :n.ftuser_id is not null then
     raise relation_check;
end if;

If :n.handheld_group_id is null and :n.ftuser_id is null then
     raise relation_exist;
end if;

If :n.handheld_group_id is not null and :n.pin is not null then
     raise Invalid_pin;
end if;

exception

When relation_check then
     Raise_application_error(-20007,'Handheld device can not be related to both ftuser and handheld group');
when relation_exist then
     Raise_application_error(-20008,'Both Handheld_device_id and ftuser_id  can not be null');
when invalid_pin then
     Raise_application_error(-20009,'It is not possible to have a PIN for a device in handheld group');

end;
/
sho err

-- Following changes were done as per the request of kelly on 12/04/2000 at 16:30 


Alter table site_to_trial add
(accrual_start_date date,
site_number  varchar2(20),
site_short_title varchar2(256));

Alter table subject add
(assigned_cc_id number(10) constraint subject_fk5 references contact(id));

Alter table subject modify 
(enrolled_date null,
last_modified_date not null);

Alter table site_to_trial modify 
(last_modified_date not null);

-- Following changes were done as per the request of Phil on 12/08/2000 at 8:30 


alter table handheld_device modify
(HANDHELD_GROUP_ID null);

-- *****************************
-- New Tables for Event Monitor
-- *****************************

create table protocol_event(
	ID number(10),
	short_desc varchar2(256) not null,
	Long_desc varchar2(4000),
	GUID varchar2(128) not null,
	Time_period_category varchar2(50) not null,
	Trial_id number(10) not null)
        tablespace ftsmall pctused 65 pctfree 20;

Alter table protocol_event add constraint 
        protocol_event_pk primary key (id) using index tablespace 
        ftsmall_indx pctfree 20 nologging;

Alter table protocol_event add constraint 
        protocol_event_fk1 foreign key (trial_id)  
        references trial(id);

Alter table protocol_event add constraint protocol_event_tp_check
        check (time_period_category in ('Screening','Treatment','Followup'));

create table protocol_event_group(
	ID number(10),
	GUID varchar2(128) not null,
	Trial_id number(10) not null,
	short_desc varchar2(256) not null,
	long_desc varchar2(4000))
        tablespace ftsmall pctused 65 pctfree 20;

Alter table protocol_event_group add constraint 
        protocol_event_group_pk primary key (id) using index tablespace 
        ftsmall_indx pctfree 20 nologging;

Alter table protocol_event_group add constraint 
        protocol_event_group_fk1 foreign key (trial_id)  
        references trial(id);


create table patient_management_task(
	ID number(10),
	GUID varchar2(128) not null,
	Trial_id number(10) not null,
	Short_desc varchar2(256) not null,
	long_desc varchar2(4000) not null,
	drill_down_important number(1) not null)
        tablespace ftsmall pctused 65 pctfree 20;

Alter table patient_management_task add constraint 
        patient_management_task_pk primary key (id) using index tablespace 
        ftsmall_indx pctfree 20 nologging;

Alter table patient_management_task add constraint
	patient_management_task_fk1 foreign key (trial_id)
	references trial(id);


Alter table patient_management_task add constraint patient_mgmt_task_ddi_check 
        check (drill_down_important in (0,1));

create table peg_to_peg(
	ID number(10),
	Protocol_version_id number(10) not null,
	Protocol_evgroup_id number(10) not null,
	Parent_evgroup_id number(10),
	Seq number(4))
        tablespace ftlarge pctused 65 pctfree 20;

Alter table peg_to_peg add constraint 
        peg_to_peg_pk primary key (id) using index tablespace 
        ftlarge_indx pctfree 20 nologging;

Alter table peg_to_peg add constraint 
        peg_to_peg_fk1 foreign key (Protocol_version_id)  
        references Protocol_version(id);

Alter table peg_to_peg add constraint 
        peg_to_peg_fk2 foreign key (Protocol_evgroup_id)  
        references protocol_event_group(id);

Alter table peg_to_peg add constraint 
        peg_to_peg_fk3 foreign key (Parent_evgroup_id)  
        references protocol_event_group(id);

create table peg_to_event(
	ID number(10),
	Protocol_version_id number(10) not null,
	Protocol_event_id number(10) not null,
	Parent_evgroup_id number(10) not null,
	Seq number(4) not null,
	Time_offset number(10),
	Neg_offset_window number(10),
	Pos_offset_window number(10),
	Time_unit varchar2(1))
        tablespace ftlarge pctused 65 pctfree 20;

Alter table peg_to_event add constraint 
        peg_to_event_pk primary key (id) using index tablespace 
        ftlarge_indx pctfree 20 nologging;

Alter table peg_to_event add constraint 
        peg_to_event_fk1 foreign key (Protocol_version_id)  
        references Protocol_version(id);

Alter table peg_to_event add constraint 
        peg_to_event_fk2 foreign key (Protocol_event_id)  
        references Protocol_event(id);

Alter table peg_to_event add constraint 
        peg_to_event_fk3 foreign key (Parent_evgroup_id)  
        references protocol_event_group(id);

Alter table peg_to_event add constraint peg_to_event_tu_check
        check (time_unit in ('H','D','W','M','Y'));

create table task_to_protocol_event(
	ID number(10),
	Protocol_version_ID number(10) not null,
	Patient_mngmt_task_ID number(10) not null,
	Protocol_event_id number(10) not null,
	Seq_no number(4) not null)
        tablespace ftsmall pctused 65 pctfree 20;

Alter table task_to_protocol_event add constraint 
        task_to_protocol_event_pk primary key (id) using index tablespace 
        ftsmall_indx pctfree 20 nologging;

Alter table task_to_protocol_event add constraint 
        task_to_protocol_event_fk1 foreign key (Protocol_version_id)  
        references Protocol_version(id);

Alter table task_to_protocol_event add constraint 
        task_to_protocol_event_fk2 foreign key (Patient_mngmt_task_id)  
        references patient_management_task(id);

Alter table task_to_protocol_event add constraint 
        task_to_protocol_event_fk3 foreign key (Protocol_event_id)  
        references Protocol_event(id);

create table event_core(
	ID number(10) not null,
	Template_id number(10) not null,
	Name varchar2(128) not null,
	Creator_id number(10) not null,
	Date_time date,
	Template_type varchar2(50) not null)
        tablespace ftlarge pctused 65 pctfree 20;

Alter table event_core add constraint 
        event_core_pk primary key (id) using index tablespace 
        ftlarge_indx pctfree 20 nologging;

Alter table event_core add constraint 
        event_core_fk1 foreign key (Creator_id)  
        references contact(id);

Alter table event_core add constraint event_core_tt_check
        check (Template_type in ('ENC','DOC','MON','GEN','GRP'));

create table study_setup_event(
	ID number(10),
	Event_core_id  number(10) not null,
	long_desc varchar2(4000) not null,
	Creator varchar2(50) not null,
	Required_for_accrual number(1) not null,
	Remind_date date,
	Visibility varchar2(50) not null,
	Completed_date date,
	Monitor_by_date date,
	Site_to_trial_id number(10),
	Assigned_coordinator number(10),
	Document_version varchar2(128),
	Completion_authority varchar2(50),
	Creator_complete number(1) not null)
        tablespace ftsmall pctused 65 pctfree 20;

Alter table study_setup_event add constraint 
        study_setup_event_pk primary key (id) using index tablespace 
        ftsmall_indx pctfree 20 nologging;

Alter table study_setup_event add constraint 
        study_setup_event_fk1 foreign key (event_core_id)  
        references event_core(id);

Alter table study_setup_event add constraint 
        study_setup_event_fk2 foreign key (site_to_trial_id)  
        references site_to_trial(id);

Alter table study_setup_event add constraint sse_req_for_accrual_check
        check (required_for_accrual in (0,1));

Alter table study_setup_event add constraint sse_creator_check
        check (creator in ('Site','Sponsor'));

Alter table study_setup_event add constraint sse_visibility_check
        check (visibility in ('Site','Sponsor'));

Alter table study_setup_event add constraint sse_completion_authority_check
        check (completion_authority in ('Site','Sponsor'));

Alter table study_setup_event add constraint sse_creator_complete_check
        check (creator_complete in (0,1));

create table protocol_evgroup_inst(
	ID number(10),
	event_core_id number(10) not null,
	Parent_peginst_id number(10),
	Anchor_date date,
	Protocol_version_id number(10) not null,
        subject_id number(10) not null)
        tablespace ftsmall pctused 65 pctfree 20;

Alter table protocol_evgroup_inst add constraint 
        protocol_evgroup_inst_pk primary key (id) using index tablespace 
        ftsmall_indx pctfree 20 nologging;

Alter table protocol_evgroup_inst add constraint 
        protocol_evgroup_inst_fk1 foreign key (event_core_id)  
        references event_core(id);

Alter table protocol_evgroup_inst add constraint 
        protocol_evgroup_inst_fk2 foreign key (Parent_peginst_id)  
        references protocol_evgroup_inst(id);

Alter table protocol_evgroup_inst add constraint 
        protocol_evgroup_inst_fk3 foreign key (Protocol_version_id)  
        references Protocol_version(id);

Alter table protocol_evgroup_inst add constraint 
        protocol_evgroup_inst_fk4 foreign key (subject_id)  
        references subject(id);

create table monitor_site_visit(
	ID number(10),
	Event_core_id number(10) not null,
	Site_to_trial_id number(10) not null,
	Monitor_note varchar2(255) not null,
        start_date date,
        end_date date)
        tablespace ftsmall pctused 65 pctfree 20;

Alter table monitor_site_visit add constraint 
        monitor_site_visit_pk primary key (id) using index tablespace 
        ftsmall_indx pctfree 20 nologging;

Alter table monitor_site_visit add constraint 
        monitor_site_visit_fk1 foreign key (Event_core_id)  
        references event_core(id);

-- Alter table monitor_site_visit add constraint 
--        monitor_site_visit_fk2 foreign key (Monitor_trip_id)  
--        references Monitor_trip(id);

Alter table monitor_site_visit add constraint 
        monitor_site_visit_fk3 foreign key (site_to_trial_id)  
        references site_to_trial(id);

create table subject_encounter(
	ID number(10),
	Event_core_id number(10) not null,
	Encounter_status varchar2(50) not null,
	Resched_event_id number(10) not null,
	Protocol_version_id number(10) not null,
	Encounter_note varchar2(255) not null,
	Monitor_status varchar2(50),
	Monitor_site_visit_id number(10),
	Monitor_note varchar2(255),
	Seq number(4) not null,
	Parent_peg_inst_id number(10) not null,
	Hide number(1) not null,
	Creator varchar2(50) not null,
        subject_id number(10) not null)
        tablespace ftlarge pctused 65 pctfree 20;

Alter table subject_encounter add constraint 
        subject_encounter_pk primary key (id) using index tablespace 
        ftlarge_indx pctfree 20 nologging;

Alter table subject_encounter add constraint 
        subject_encounter_fk1 foreign key (event_core_id)  
        references event_core(id);

Alter table subject_encounter add constraint 
        subject_encounter_fk2 foreign key (Resched_event_id)  
        references event_core(id);

Alter table subject_encounter add constraint 
        subject_encounter_fk3 foreign key (Protocol_version_id)  
        references Protocol_version(id);

Alter table subject_encounter add constraint 
        subject_encounter_fk4 foreign key (Monitor_site_visit_id)  
        references Monitor_site_visit(id);

Alter table subject_encounter add constraint 
        subject_encounter_fk5 foreign key (Parent_peg_inst_id)  
        references protocol_evgroup_inst(id);

Alter table subject_encounter add constraint 
        subject_encounter_fk6 foreign key (subject_id)  
        references subject(id);

Alter table subject_encounter add constraint sub_enc_enc_status_check
        check (Encounter_status in ('Completed','Missed','Rescheduled','Inprogress',
                                   'Scheduled','Toreschedule','Prospective','NA'));

Alter table subject_encounter add constraint sub_enc_mon_status_check
        check (Monitor_status in ('Complete','Pending'));

Alter table subject_encounter add constraint sub_enc_hide_check
        check (hide in (0,1));

Alter table subject_encounter add constraint sub_enc_creator_check
        check (creator in ('Site','Sponsor'));

create table misc_event_prototype(
	ID number(10),
	Name varchar2(128) not null,
	Default_visibility varchar2(50) not null)
        tablespace ftsmall pctused 65 pctfree 20;

Alter table misc_event_prototype add constraint 
        misc_event_prototype_pk primary key (id) using index tablespace 
        ftsmall_indx pctfree 20 nologging;

Alter table misc_event_prototype add constraint mep_default_visibility_check
        check (default_visibility in ('Site','Sponsor','User'));


create table setup_event_mon_instance(
	ID number(10),
	study_Setup_event_id number(10) not null,
	Monitor_site_visit_id number(10) not null,
	Setup_event_status varchar2(50) not null,
	Monitor_note varchar2(255) not null)
        tablespace ftsmall pctused 65 pctfree 20;

Alter table setup_event_mon_instance add constraint 
        setup_event_mon_instance_pk primary key (id) using index tablespace 
        ftsmall_indx pctfree 20 nologging;

Alter table setup_event_mon_instance add constraint 
        setup_event_mon_instance_fk3 foreign key (study_Setup_event_id)  
        references study_Setup_event(id);

Alter table setup_event_mon_instance add constraint 
        setup_event_mon_instance_fk2 foreign key (Monitor_site_visit_id)  
        references Monitor_site_visit(id);

Alter table setup_event_mon_instance add constraint setup_event_status_check
        check (setup_event_status in ('Scheduled','Pending','Complete'));

create table regulatory_document(
	ID number(10),
	short_desc varchar2(256) not null,
	long_desc varchar2(4000) not null,
	Required_flag number(1) not null)
        tablespace ftsmall pctused 65 pctfree 20;

Alter table regulatory_document add constraint 
        regulatory_document_pk primary key (id) using index tablespace 
        ftsmall_indx pctfree 20 nologging;

Alter table regulatory_document add constraint reg_doc_req_flag_check
        check (required_flag in (0,1));

create table general_event(
	ID number(10),
	Event_core_id number(10) not null,
	Attached_object_id number(10),
	Attached_object_type varchar2(50),
	Event_status varchar2(50) not null,
	Comments varchar2(255) not null,
	Visibility varchar2(50) not null)
        tablespace ftsmall pctused 65 pctfree 20;

Alter table general_event add constraint 
        general_event_pk primary key (id) using index tablespace 
        ftsmall_indx pctfree 20 nologging;

Alter table general_event add constraint 
        general_event_fk1 foreign key (event_core_id)  
        references event_core(id);

Alter table general_event add constraint general_event_obj_type_check
        check (Attached_object_type in ('Event','User','Subject','Trial','Patient','Candidate'));

Alter table general_event add constraint general_event_status_check
        check (event_status in ('Done','Notdone'));

Alter table general_event add constraint general_event_visibility_check
        check (visibility in ('Sponsor','Site','User'));

create or replace trigger general_event_trg1
after insert or update on general_event
referencing new as n old as o
for each row
declare

object_check exception;

begin

If :n.attached_object_id is not null and :n.attached_object_type is null then
     raise object_check;
end if;

exception

when object_check then
     Raise_application_error(-20010,'Attached_object_type can not be null when attached_object_id exists');
end;
/

sho err


-- Following changes were made as per the requesr of Peter on 01/04/2001 at 10:30 AM

alter table subject_encounter modify (resched_event_id null);


-- ***********************************************************************
-- Floowing new tables and old table modifications were carried our as per
-- the requirement of CRA as per the request of Phil on 01/05/2001 at 9 AM
-- ***********************************************************************

create table monitor_to_site_to_trial(
	id number(10),
	monitor_id number(10) not null,
	site_to_trial_id number(10) not null,
	role varchar2(20))
	tablespace ftsmall pctused 65 pctfree 20;

Alter table monitor_to_site_to_trial add constraint 
        monitor_to_site_to_trial_pk primary key (id) using index tablespace 
        ftsmall_indx pctfree 20 nologging;

Alter table monitor_to_site_to_trial add constraint 
        monitor_to_site_to_trial_fk1 foreign key (monitor_id)  
        references monitor(id);

Alter table monitor_to_site_to_trial add constraint 
        monitor_to_site_to_trial_fk2 foreign key (site_to_trial_id)  
        references site_to_trial(id);

Alter table monitor_to_site_to_trial add constraint monitor_to_stt_role_check 
	check (role in ('Lead'));

create  table cra_manager_to_trial(
	id number(10),
	manager_ftuser_id number(10) not null,
	trial_id number(10) not null)
	tablespace ftsmall pctused 65 pctfree 20;

Alter table cra_manager_to_trial add constraint 
        cra_manager_to_trial_pk primary key (id) using index tablespace 
        ftsmall_indx pctfree 20 nologging;

Alter table cra_manager_to_trial add constraint 
        cra_manager_to_trial_fk1 foreign key (manager_ftuser_id)  
        references ftuser(id);

Alter table cra_manager_to_trial add constraint 
        cra_manager_to_trial_fk2 foreign key (trial_id)  
        references trial(id);

create table cra_manager_to_monitor(
	id number(10),
	manager_ftuser_id number(10) not null,
	monitor_id number(10) not null)
	tablespace ftsmall pctused 65 pctfree 20;

Alter table cra_manager_to_monitor add constraint 
        cra_manager_to_monitor_pk primary key (id) using index tablespace 
        ftsmall_indx pctfree 20 nologging;

Alter table cra_manager_to_monitor add constraint 
        cra_manager_to_monitor_fk1 foreign key (manager_ftuser_id)  
        references ftuser(id);

Alter table cra_manager_to_monitor add constraint 
        cra_manager_to_monitor_fk2 foreign key (monitor_id)  
        references monitor(id);

-- ******************************************
-- Table changes for CRA as requested by Phil
-- ******************************************

Alter table site_to_trial drop column monitor_contact_id;

Alter table monitor drop column manager_ftuser_id;

Alter table monitor drop column sponsor_id;

Alter table monitor add( cra_type varchar2(128) not null);

Alter table monitor add constraint monitor_cra_type_check
	check( cra_type in ('Contractor','Regional','Inhouse','Cro'));

-- Following changes were done as per the request of Peter on 01/10/2001 at 11:15 AM

Alter table protocol_evgroup_inst add (seq number(4));
update protocol_evgroup_inst set seq = 0;
Alter table protocol_evgroup_inst modify (seq not null);


Alter table event_core add ( site_id number(10));
update event_core set site_id = 0;
Alter table event_core modify (site_id not null);
Alter table event_core add constraint event_core_fk2 
	foreign key (site_id) references site(id);

Alter table peg_to_event add (anchor_event_id number(10));
Alter table peg_to_event add constraint peg_to_event_fk4 
	foreign key (anchor_event_id ) references event_core (id);

-- Following changes were requested for colin to remove the contact table on 01/10/2001 at 4 PM

-- alter table ftuser add(FIRST_NAME VARCHAR2(128),
-- LAST_NAME  VARCHAR2(128),
-- ADDRESS_LINE_1  VARCHAR2(255),
-- ADDRESS_LINE_2  VARCHAR2(255),
-- CITY VARCHAR2(255),
-- STATE   VARCHAR2(255),
-- POSTAL_CODE    VARCHAR2(20),
-- COUNTRY    VARCHAR2(255),
-- WORK_PHONE   VARCHAR2(50),
-- HOME_PHONE   VARCHAR2(50),
-- FAX     VARCHAR2(50),
-- MOBILE_PHONE     VARCHAR2(255),
-- EMAIL          VARCHAR2(100),
-- PREFERRED_CONTACT      VARCHAR2(50),
-- SITE_ID       NUMBER(10),
-- SPONSOR_ID         NUMBER(10));

alter table ftuser add(ADDRESS_LINE_1  VARCHAR2(255),
ADDRESS_LINE_2  VARCHAR2(255),
CITY VARCHAR2(255),
STATE   VARCHAR2(255),
POSTAL_CODE    VARCHAR2(20),
COUNTRY    VARCHAR2(255),
WORK_PHONE   VARCHAR2(50),
HOME_PHONE   VARCHAR2(50),
FAX     VARCHAR2(50),
MOBILE_PHONE     VARCHAR2(255),
EMAIL          VARCHAR2(100),
PREFERRED_CONTACT      VARCHAR2(50));


Alter table ftuser modify (NAME null,PASSWORD null,
	STARTING_SCREEN null);

-- Alter table ftuser add constraint ftuser_site_fk1
--       foreign key (site_id) references site(id);

-- Alter table ftuser add constraint ftuser_sponsor_fk2
--        foreign key (sponsor_id) references sponsor(id);

Update ftuser a set (a.ADDRESS_LINE_1, a.ADDRESS_LINE_2,
	a.CITY, a.STATE, a.POSTAL_CODE,a.COUNTRY, a.WORK_PHONE, a.HOME_PHONE,
        a.FAX, a.MOBILE_PHONE, a.EMAIL, a.PREFERRED_CONTACT) 
	= (select b.ADDRESS_LINE_1, b.ADDRESS_LINE_2,
        b.CITY, b.STATE, b.POSTAL_CODE,b.COUNTRY, b.WORK_PHONE, b.HOME_PHONE,
        b.FAX, b.MOBILE_PHONE, b.EMAIL, b.PREFERRED_CONTACT 
	from contact b where b.id = a.contact_id) where
	a.contact_id <> 1 ;

Insert into ftuser select ftuser_seq.nextval,id,null,null,site_id,
	sponsor_id,null,null,FIRST_NAME,LAST_NAME,null,null,
	ADDRESS_LINE_1,ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,
	WORK_PHONE,HOME_PHONE,FAX,MOBILE_PHONE,EMAIL,PREFERRED_CONTACT
	from contact where not id in (select contact_id from ftuser);


-- Alter table ftuser modify (first_name not null, last_name not null);

Alter table sponsor drop constraint sponsor_contact_fk1;

Update sponsor a set a.main_contact_id= (select min(b.id) from ftuser b
	where b.contact_id = a.main_contact_id);


Alter table sponsor add constraint
	sponsor_contact_fk1 foreign key (main_contact_id)
	references ftuser(id);


alter table subject drop constraint subject_fk5;

Update subject a set a.assigned_cc_id= (select min(b.id) from ftuser b
	where b.contact_id = a.assigned_cc_id);

Alter table subject add	constraint subject_fk5 
	foreign key (assigned_cc_id) references ftuser(id);

Alter table event_core drop constraint event_core_fk1;

Update event_core a set a.Creator_id= (select min(b.id) from ftuser b
	where b.contact_id = a.Creator_id);

Alter table event_core add constraint 
        event_core_fk1 foreign key (Creator_id)  
        references ftuser(id);

Alter table site drop constraint site_fk1;

Update site a set a.MAIN_SITE_CONTACT_ID= (select min(b.id) from ftuser b
	where b.contact_id = a.MAIN_SITE_CONTACT_ID);

alter table site add constraint site_fk1
	foreign key (MAIN_SITE_CONTACT_ID) references ftuser (id);

alter table site_to_trial drop constraint CONTACT_FK1;

Update site_to_trial a set a.CC_CONTACT_ID= (select min(b.id) from ftuser b
	where b.contact_id = a.CC_CONTACT_ID);

alter table site_to_trial add constraint site_to_trial_FK1
	foreign key (CC_CONTACT_ID) references ftuser(id);


alter table site_to_trial add (cc_ftuser_id number(10));

update site_to_trial set cc_ftuser_id = cc_contact_id;

alter table site_to_trial modify(cc_ftuser_id not null);

alter table site_to_trial add constraint site_to_trial_FK4
	foreign key (CC_FTUSER_ID) references ftuser(id);

Update site_to_trial a set a.PI_CONTACT_ID= (select min(b.id) from ftuser b
	where b.contact_id = a.PI_CONTACT_ID) where a.PI_CONTACT_ID is not null;

alter table site_to_trial add (pi_ftuser_id number(10));

update site_to_trial set pi_ftuser_id = PI_CONTACT_ID;

-- alter table site_to_trial modify(pi_ftuser_id not null);

alter table site_to_trial add constraint site_to_trial_FK5
	foreign key (PI_FTUSER_ID) references ftuser(id);

alter table ftuser drop column contact_id;


Alter table candidate drop column primary_cc_contact_id;
Alter table candidate drop column primary_phys_contact_id;
Alter table candidate add (primary_cc_ftuser_id number(10),
			   primary_phys_contact_id number(10));
Alter table candidate add constraint candidate_ftuser_fk1
	foreign key (primary_cc_ftuser_id) references ftuser(id);
Alter table candidate add constraint candidate_ftuser_fk2
	foreign key (primary_phys_contact_id) references ftuser(id);

drop table contact;



-- Following changes are requested by Kelly on 01/10/2001 at 4.45 PM

Alter table protocol_version add (ft_version_name varchar2(20));

Update protocol_version set ft_version_name = 1;

Alter table protocol_version modify (ft_version_name not null);

-- After this manually updated the duplicate values to be unique using navigator

Alter table protocol_version add constraint protocol_version_uq1
	unique (trial_id, version_name, ft_version_name) using
	index tablespace ftlarge_indx pctfree 20 nologging;

-- Following changes are as per the verbal request of Matt on 01/11/2001

Alter table subject_encounter add (ICF_VERSION VARCHAR2(255));

-- Following changes were requested by Phil on 01/17/2001 at 2 PM when e-mail was down

Alter table subject add( completed_encounters number(10) default 0,
	unmonitored_visits number(10) default 0);

-- Following changes are requested by colin on 01/18/2001 at 4:15 PM

alter table site_to_trial drop column cc_contact_id;
alter table site_to_trial drop column PI_CONTACT_ID;

-- alter table site_to_trial modify(PI_FTUSER_ID null);

-- Following changes are requested by Peter on 01/19/2001 at 11:30 AM

Alter table subject_encounter drop constraint sub_enc_enc_status_check;

Alter table subject_encounter add constraint sub_enc_enc_status_check
        check (Encounter_status in 
        ('Completed','Missed','Rescheduled','Inprogress',
         'Scheduled','Toreschedule','Prospective','NA',
          'Entered In Error', 'Invalid' ));

alter table protocol_evgroup_inst add (
	creator varchar2(50));

update protocol_evgroup_inst set Creator='Site';

alter table protocol_evgroup_inst modify (creator Not null);

Alter table protocol_evgroup_inst add constraint
	pevgroup_inst_creator_check check (creator
        in ('Site','Sponsor'));


-- Following changes are as per the request of Kelly/Phil for new subject status

alter trigger SUBJECT_STATUS_TRG1 disable;

alter table subject drop constraint SUBJECT_SUBJECT_STATUS_CHECK;
update subject set subject_status = 'Early Term-Other'
	where subject_status = 'Early Term';
update subject set subject_status = 'Early Term-Lost To Follow-Up'
	where subject_status = 'Lost to Follow-up';
update subject set subject_status = 'On Follow-Up'
	where subject_status = 'On Follow-up';
update subject set subject_status = 'On Treatment'
	where subject_status = 'On Study';
update subject set subject_status = 'Entered in Error'
	where subject_status = 'Mistake';
commit;
alter table subject add constraint SUBJECT_SUBJECT_STATUS_CHECK
	check (SUBJECT_STATUS in ('Not Assigned','Screening',
	'On Treatment','On Follow-Up','Completed','Screen Failure-Died',
	'Screen Failure-Not Eligible','Screen Failure-Other',
	'Early Term-Died','Early Term-Lost To Follow-Up',
	'Early Term-Other','Entered in Error'));


Alter table site_to_trial add (
	ONTREATMENTCNT number(10),
	EARLYTERMCNT_DIED number(10),
	EARLYTERMCNT_LOSTTOFOLLOWUP number(10),
	EARLYTERMCNT_OTHER number(10),
	SCREENFAILURECNT_DIED number(10),
	SCREENFAILURECNT_NOTELIGIBLE number(10),
	SCREENFAILURECNT_OTHER number(10),
	SCREENINGCNT number(10),
	NOTASSIGNEDCNT number(10));

Update site_to_trial set ONTREATMENTCNT=ONSTUDYCNT;
Update site_to_trial set EARLYTERMCNT_OTHER=EARLYTERMCNT;
Update site_to_trial set EARLYTERMCNT_LOSTTOFOLLOWUP=LOSTTOFOLLOWUPCNT;

-- Alter table site_to_trial drop column onstudycnt;
-- Alter table site_to_trial drop column earlytermcnt;
-- Alter table site_to_trial drop column losttofollowupcnt;

create or replace trigger subject_status_trg1
after insert or update of subject_status on subject
referencing new as n old as o
for each row

begin

if inserting then
  if upper(:n.subject_status) in ('ON TREATMENT','ON FOLLOW-UP','COMPLETED','EARLY TERM-DIED',
                                  'EARLY TERM-LOST TO FOLLOW-UP','EARLY TERM-OTHER') then
  update site_to_trial set enrolledcnt=nvl(enrolledcnt,0)+1 where
  id = :n.site_to_trial_id;
  end if;
end if;

if updating then
  if upper(:o.subject_status) in ('ENTERED IN ERROR','NOT ASSIGNED','SCREENING','SCREEN FAILURE-DIED',
                                 'SCREEN FAILURE-NOT ELIGIBLE', 'SCREEN FAILURE-OTHER')
  and upper(:n.subject_status) in ('ON TREATMENT','ON FOLLOW-UP','COMPLETED','EARLY TERM-DIED',
                                  'EARLY TERM-LOST TO FOLLOW-UP','EARLY TERM-OTHER') then
     update site_to_trial set enrolledcnt=nvl(enrolledcnt,0)+1 where
     id = :o.site_to_trial_id;
  end if;

  if upper(:n.subject_status) in ('ENTERED IN ERROR','NOT ASSIGNED','SCREENING','SCREEN FAILURE-DIED',
                                 'SCREEN FAILURE-NOT ELIGIBLE', 'SCREEN FAILURE-OTHER')
  and upper(:o.subject_status) in ('ON TREATMENT','ON FOLLOW-UP','COMPLETED','EARLY TERM-DIED',
                                  'EARLY TERM-LOST TO FOLLOW-UP','EARLY TERM-OTHER') then
     update site_to_trial set enrolledcnt=nvl(enrolledcnt,0)-1 where
     id = :n.site_to_trial_id;
  end if;
end if;

  if upper(:n.subject_status) = 'NOT ASSIGNED' and upper(:o.subject_status) <> 'NOT ASSIGNED' then
     update site_to_trial set NOTASSIGNEDCNT=nvl(NOTASSIGNEDCNT,0)+1 where
     id = :n.site_to_trial_id;
  elsif upper(:n.subject_status) = 'SCREENING' and upper(:o.subject_status) <> 'SCREENING' then
     update site_to_trial set SCREENINGCNT=nvl(SCREENINGCNT,0)+1 where
     id = :n.site_to_trial_id;
  elsif upper(:n.subject_status) = 'ON TREATMENT' and upper(:o.subject_status) <> 'ON TREATMENT' then
     update site_to_trial set ONTREATMENTCNT=nvl(ONTREATMENTCNT,0)+1 where
     id = :n.site_to_trial_id;
  elsif upper(:n.subject_status) = 'ON FOLLOW-UP' and upper(:o.subject_status) <> 'ON FOLLOW-UP' then
     update site_to_trial set ONFOLLOWUPCNT=nvl(ONFOLLOWUPCNT,0)+1 where
     id = :n.site_to_trial_id;
  elsif upper(:n.subject_status) = 'COMPLETED' and upper(:o.subject_status) <> 'COMPLETED' then
     update site_to_trial set COMPLETEDCNT=nvl(COMPLETEDCNT,0)+1 where
     id = :n.site_to_trial_id;
  elsif upper(:n.subject_status) = 'SCREEN FAILURE-DIED' and upper(:o.subject_status) <> 'SCREEN FAILURE-DIED' then
     update site_to_trial set SCREENFAILURECNT_DIED=nvl(SCREENFAILURECNT_DIED,0)+1 where
     id = :n.site_to_trial_id;
  elsif upper(:n.subject_status) = 'SCREEN FAILURE-NOT ELIGIBLE' and upper(:o.subject_status) <> 'SCREEN FAILURE-NOT ELIGIBLE' then
     update site_to_trial set SCREENFAILURECNT_NOTELIGIBLE=nvl(SCREENFAILURECNT_NOTELIGIBLE,0)+1 where
     id = :n.site_to_trial_id;
  elsif upper(:n.subject_status) = 'SCREEN FAILURE-OTHER' and upper(:o.subject_status) <> 'SCREEN FAILURE-OTHER' then
     update site_to_trial set SCREENFAILURECNT_OTHER=nvl(SCREENFAILURECNT_OTHER,0)+1 where
     id = :n.site_to_trial_id;
  elsif upper(:n.subject_status) = 'EARLY TERM-DIED' and upper(:o.subject_status) <> 'EARLY TERM-DIED' then
     update site_to_trial set EARLYTERMCNT_DIED=nvl(EARLYTERMCNT_DIED,0)+1 where
     id = :n.site_to_trial_id;
  elsif upper(:n.subject_status) = 'EARLY TERM-LOST TO FOLLOW-UP' and upper(:o.subject_status) <> 'EARLY TERM-LOST TO FOLLOW-UP' then
     update site_to_trial set EARLYTERMCNT_LOSTTOFOLLOWUP=nvl(EARLYTERMCNT_LOSTTOFOLLOWUP,0)+1 where
     id = :n.site_to_trial_id;
  elsif upper(:n.subject_status) = 'EARLY TERM-OTHER' and upper(:o.subject_status) <> 'EARLY TERM-OTHER' then
     update site_to_trial set EARLYTERMCNT_OTHER=nvl(EARLYTERMCNT_OTHER,0)+1 where
     id = :n.site_to_trial_id;
  end if;

  if upper(:o.subject_status) = 'NOT ASSIGNED' and upper(:n.subject_status) <> 'NOT ASSIGNED' then
     update site_to_trial set NOTASSIGNEDCNT=nvl(NOTASSIGNEDCNT,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'SCREENING' and upper(:n.subject_status) <> 'SCREENING' then
     update site_to_trial set SCREENINGCNT=nvl(SCREENINGCNT,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'ON TREATMENT' and upper(:n.subject_status) <> 'ON TREATMENT' then
     update site_to_trial set ONTREATMENTCNT=nvl(ONTREATMENTCNT,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'ON FOLLOW-UP' and upper(:n.subject_status) <> 'ON FOLLOW-UP' then
     update site_to_trial set ONFOLLOWUPCNT=nvl(ONFOLLOWUPCNT,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'COMPLETED' and upper(:n.subject_status) <> 'COMPLETED' then
     update site_to_trial set COMPLETEDCNT=nvl(COMPLETEDCNT,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'SCREEN FAILURE-DIED' and upper(:n.subject_status) <> 'SCREEN FAILURE-DIED' then
     update site_to_trial set SCREENFAILURECNT_DIED=nvl(SCREENFAILURECNT_DIED,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'SCREEN FAILURE-NOT ELIGIBLE' and upper(:n.subject_status) <> 'SCREEN FAILURE-NOT ELIGIBLE' then
     update site_to_trial set SCREENFAILURECNT_NOTELIGIBLE=nvl(SCREENFAILURECNT_NOTELIGIBLE,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'SCREEN FAILURE-OTHER' and upper(:n.subject_status) <> 'SCREEN FAILURE-OTHER' then
     update site_to_trial set SCREENFAILURECNT_OTHER=nvl(SCREENFAILURECNT_OTHER,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'EARLY TERM-DIED' and upper(:n.subject_status) <> 'EARLY TERM-DIED' then
     update site_to_trial set EARLYTERMCNT_DIED=nvl(EARLYTERMCNT_DIED,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'EARLY TERM-LOST TO FOLLOW-UP' and upper(:n.subject_status) <> 'EARLY TERM-LOST TO FOLLOW-UP' then
     update site_to_trial set EARLYTERMCNT_LOSTTOFOLLOWUP=nvl(EARLYTERMCNT_LOSTTOFOLLOWUP,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'EARLY TERM-OTHER' and upper(:n.subject_status) <> 'EARLY TERM-OTHER' then
     update site_to_trial set EARLYTERMCNT_OTHER=nvl(EARLYTERMCNT_OTHER,0)-1 where
     id = :o.site_to_trial_id;
  end if;
end;
/

-- Following changes are as per the request of kelly on 01/24/2001 at15:30 hrs

alter table patient_management_task modify (LONG_DESC null);
alter table regulatory_document modify(LONG_DESC null);
alter table STUDY_SETUP_EVENT modify(LONG_DESC null);

Alter table task_to_protocol_event add (seq number(4));
update task_to_protocol_event set seq = seq_no;
Alter table task_to_protocol_event modify (seq not null);
Alter table task_to_protocol_event drop column seq_no;

-- Following changes are as per the request of kelly/Nancy on 01/29/2001 at 11:30 hrs

Alter table study_setup_event add constraint study_setup_event_uq1
	unique (event_core_id) using index tablespace ftsmall_indx
	pctfree 20 nologging;

Alter table Monitor_site_visit add constraint Monitor_site_visit_uq1
	unique (event_core_id) using index tablespace ftsmall_indx
	pctfree 20 nologging;

Alter table general_event add constraint general_event_uq1
	unique (event_core_id) using index tablespace ftsmall_indx
	pctfree 20 nologging;

Alter table subject_encounter add constraint subject_encounter_uq1
	unique (event_core_id) using index tablespace ftlarge_indx
	pctfree 20 nologging;

-- Following changes are as per the request of Nancy on 01/29/2001 at 14:00 hrs

Alter table setup_event_mon_instance add constraint setup_event_mon_instance_uq1
	unique (monitor_site_visit_id, study_setup_event_id) using index tablespace 
	ftsmall_indx pctfree 20 nologging;

-- Following changes are as per the request of Kelly on 01/30/2001 at 10:00 hrs

alter table setup_event_mon_instance  modify (MONITOR_NOTE null);


-- The following changes which was implemented earlier in pservedio schema
-- is now been implemented in fasttrack14 schema on 2/1/2001 at 7:30 AM


Alter table subject drop column unmonitored_visits;

Alter table subject add (
	unmonitored_screening_visits  number(10),
	unmonitored_treatment_visits  number(10),
	unmonitored_followup_visits   number(10),
        unmonitored_screenfail_visits number(10),
        unmonitored_earlyterm_visits  number(10),
        unmonitored_completed_visits  number(10));

create or replace trigger subject_encounter_status_trg1
after insert or update on subject_encounter
referencing new as n old as o
for each row
declare

completed_encounters_v  subject.completed_encounters%type;
unmon_screening_visits_v   subject.unmonitored_screening_visits%type;
unmon_treatment_visits_v   subject.unmonitored_treatment_visits%type;
unmon_followup_visits_v    subject.unmonitored_followup_visits%type;
unmon_screenfail_visits_v  subject.unmonitored_screenfail_visits%type;
unmon_earlyterm_visits_v   subject.unmonitored_earlyterm_visits%type;
unmon_completed_visits_v   subject.unmonitored_completed_visits%type;
subject_status_v           subject.subject_status%type;

begin
	Select nvl(completed_encounters,0), nvl(unmonitored_screening_visits,0),
		nvl(unmonitored_treatment_visits,0),nvl(unmonitored_followup_visits,0),
        	nvl(unmonitored_screenfail_visits,0),nvl(unmonitored_earlyterm_visits,0),
        	nvl(unmonitored_completed_visits,0),subject_status
	into 
        	completed_encounters_v,unmon_screening_visits_v,
		unmon_treatment_visits_v,unmon_followup_visits_v,
		unmon_screenfail_visits_v,unmon_earlyterm_visits_v,
		unmon_completed_visits_v,subject_status_v
	from subject where id=:n.subject_id;

If :n.encounter_status = 'Completed' and :o.encounter_status <> 'Completed'  then

	update subject set completed_encounters = completed_encounters+1
     	where id = :n.subject_id;

	if subject_status_v = 'Screening' then
		update subject set unmonitored_screening_visits =
		nvl(unmonitored_screening_visits,0) + 1 where id = :n.subject_id;
	elsif subject_status_v = 'On Treatment' then
		update subject set unmonitored_treatment_visits =
		nvl(unmonitored_treatment_visits,0) + 1 where id = :n.subject_id;
	elsif subject_status_v = 'On Follow-Up' then
		update subject set unmonitored_followup_visits =
		nvl(unmonitored_followup_visits,0) + 1 where id = :n.subject_id;
	elsif subject_status_v = 'Screen Failure-Died' 
           or subject_status_v = 'Screen Failure-Not Eligible'
           or subject_status_v = 'Screen Failure-Other' then
		update subject set unmonitored_screenfail_visits =
		nvl(unmonitored_screenfail_visits,0) + 1 where id = :n.subject_id;
	elsif subject_status_v = 'Early Term-Died' 
           or subject_status_V = 'Early Term-Lost To Follow-Up'
           or subject_status_v = 'Early Term-Other' then
		update subject set unmonitored_earlyterm_visits =
		nvl(unmonitored_earlyterm_visits,0) + 1 where id = :n.subject_id;
	elsif subject_status_v = 'Completed' then
		update subject set unmonitored_completed_visits =
		nvl(unmonitored_completed_visits,0) + 1 where id = :n.subject_id;
        end if;
end if;
     
If :o.encounter_status = 'Completed' and :n.encounter_status <> 'Completed'
	and :n.encounter_status <> 'Invalid'  then

	If completed_encounters_v > 0 then
		update subject set completed_encounters = completed_encounters-1
     	        where id = :n.subject_id;
	end if;

   If :n.monitor_status = 'Completed' then

	if subject_status_v = 'Screening' and unmon_screening_visits_v>0 then
		update subject set unmonitored_screening_visits =
		unmonitored_screening_visits - 1 where id = :n.subject_id;
	elsif subject_status_v = 'On Treatment' and unmon_treatment_visits_v>0 then
		update subject set unmonitored_treatment_visits =
		unmonitored_treatment_visits - 1 where id = :n.subject_id;
	elsif subject_status_v = 'On Follow-Up' and unmon_followup_visits_v>0  then
		update subject set unmonitored_followup_visits =
		unmonitored_followup_visits - 1 where id = :n.subject_id;
	elsif subject_status_v = 'Screen Failure-Died' 
           or subject_status_v = 'Screen Failure-Not Eligible'
           or subject_status_v = 'Screen Failure-Other' then
             if unmon_screenfail_visits_v > 0 then
		update subject set unmonitored_screenfail_visits =
		unmonitored_screenfail_visits - 1 where id = :n.subject_id;
             end if;
	elsif subject_status_v = 'Early Term-Died' 
           or subject_status_v = 'Early Term-Lost To Follow-Up'
           or subject_status_v = 'Early Term-Other' then
             if unmon_earlyterm_visits_v > 0 then
		update subject set unmonitored_earlyterm_visits =
		unmonitored_earlyterm_visits - 1 where id = :n.subject_id;
             end if;
	elsif subject_status_v = 'Completed' and unmon_completed_visits_v>0  then
		update subject set unmonitored_completed_visits =
		unmonitored_completed_visits - 1 where id = :n.subject_id;
        end if;

   end if;
end if;

If :n.monitor_status = 'Completed' and :o.monitor_status <> 'Completed'  then

	if subject_status_v = 'Screening' and unmon_screening_visits_v>0 then
		update subject set unmonitored_screening_visits =
		unmonitored_screening_visits - 1 where id = :n.subject_id;
	elsif subject_status_v = 'On Treatment' and unmon_treatment_visits_v>0 then
		update subject set unmonitored_treatment_visits =
		unmonitored_treatment_visits - 1 where id = :n.subject_id;
	elsif subject_status_v = 'On Follow-Up' and unmon_followup_visits_v>0  then
		update subject set unmonitored_followup_visits =
		unmonitored_followup_visits - 1 where id = :n.subject_id;
	elsif subject_status_v = 'Screen Failure-Died' 
           or subject_status_v = 'Screen Failure-Not Eligible'
           or subject_status_v = 'Screen Failure-Other' then
             if unmon_screenfail_visits_v > 0 then
		update subject set unmonitored_screenfail_visits =
		unmonitored_screenfail_visits - 1 where id = :n.subject_id;
             end if;
	elsif subject_status_v = 'Early Term-Died' 
           or subject_status_v = 'Early Term-Lost To Follow-Up'
           or subject_status_v = 'Early Term-Other' then
             if unmon_earlyterm_visits_v > 0 then
		update subject set unmonitored_earlyterm_visits =
		unmonitored_earlyterm_visits - 1 where id = :n.subject_id;
             end if;
	elsif subject_status_v = 'Completed' and unmon_completed_visits_v>0  then
		update subject set unmonitored_completed_visits =
		unmonitored_completed_visits - 1 where id = :n.subject_id;
        end if;
end if;

If :n.monitor_status = 'Pending' and :o.monitor_status = 'Completed'  then

	if subject_status_v = 'Screening' then
		update subject set unmonitored_screening_visits =
		nvl(unmonitored_screening_visits,0) + 1 where id = :n.subject_id;
	elsif subject_status_v = 'On Treatment' then
		update subject set unmonitored_treatment_visits =
		nvl(unmonitored_treatment_visits,0) + 1 where id = :n.subject_id;
	elsif subject_status_v = 'On Follow-Up' then
		update subject set unmonitored_followup_visits =
		nvl(unmonitored_followup_visits,0) + 1 where id = :n.subject_id;
	elsif subject_status_v = 'Screen Failure-Died' 
           or subject_status_v = 'Screen Failure-Not Eligible'
           or subject_status_v = 'Screen Failure-Other' then
		update subject set unmonitored_screenfail_visits =
		nvl(unmonitored_screenfail_visits,0) + 1 where id = :n.subject_id;
	elsif subject_status_v = 'Early Term-Died' 
           or subject_status_v = 'Early Term-Lost To Follow-Up'
           or subject_status_v = 'Early Term-Other' then
		update subject set unmonitored_earlyterm_visits =
		nvl(unmonitored_earlyterm_visits,0) + 1 where id = :n.subject_id;
	elsif subject_status_v = 'Completed' then
		update subject set unmonitored_completed_visits =
		nvl(unmonitored_completed_visits,0) + 1 where id = :n.subject_id;
        end if;
end if;
   
end;
/

sho err

-- The following triggers were added as per the request from kelly on 02/01/01 at 8:35 AM

create or replace trigger event_core_trg1
before update of template_type on event_core 
referencing new as n old as o
for each row

begin

 Raise_application_error(-20011,'Sorry ! Template_type can not be updated');

end;
/
sho err

create or replace trigger subject_encounter_trg1
after insert or delete or update of event_core_id on subject_encounter 
referencing new as n old as o
for each row
declare

invalid_event exception;
template event_core.template_type%type;

begin

If inserting or updating then

 select template_type into template from event_core where  id = :n.event_core_id;

 If upper(template) <> 'ENC' then
    raise invalid_event;
 end if;
end if;

If deleting then 
       delete from event_core where id=:o.event_core_id; 
end if;

exception

when invalid_event then
     Raise_application_error(-20012,'Invalid template type in event_core. It must point to ENC');
end;
/
sho err

create or replace trigger study_setup_event_trg1
after insert or delete or update of event_core_id on study_setup_event 
referencing new as n old as o
for each row
declare

invalid_event exception;
template event_core.template_type%type;

begin

If inserting or updating then

 select template_type into template from event_core where  id = :n.event_core_id;

 If upper(template) <> 'DOC' then
    raise invalid_event;
 end if;
end if;

If deleting then
  delete from event_core where id=:o.event_core_id; 
end if;

exception

when invalid_event then
     Raise_application_error(-20013,'Invalid template type in event_core. It must point to DOC');
end;
/
sho err

create or replace trigger general_event_trg1
after insert or delete or update of event_core_id on general_event 
referencing new as n old as o
for each row
declare

invalid_event exception;
template event_core.template_type%type;

begin

If inserting or updating then

 select template_type into template from event_core where  id = :n.event_core_id;

 If upper(template) <> 'GEN' then
    raise invalid_event;
 end if;
end if;
If deleting then
  delete from event_core where id=:o.event_core_id; 
end if;

exception

when invalid_event then
     Raise_application_error(-20014,'Invalid template type in event_core. It must point to GEN');
end;
/
sho err

create or replace trigger monitor_site_visit_trg1
after insert or delete or update of event_core_id on monitor_site_visit 
referencing new as n old as o
for each row
declare

invalid_event exception;
template event_core.template_type%type;

begin

If inserting or updating then

 select template_type into template from event_core where  id = :n.event_core_id;

 If upper(template) <> 'MON' then
    raise invalid_event;
 end if;
end if;

If deleting then
  delete from event_core where id=:o.event_core_id; 
end if;


exception

when invalid_event then
     Raise_application_error(-20015,'Invalid template type in event_core. It must point to MON');
end;
/
sho err

create or replace trigger protocol_evgroup_inst_trg1
after insert or delete or update of event_core_id on protocol_evgroup_inst 
referencing new as n old as o
for each row
declare

invalid_event exception;
template event_core.template_type%type;

begin

If inserting or updating then

 select template_type into template from event_core where  id = :n.event_core_id;

 If upper(template) <> 'GRP' then
    raise invalid_event;
 end if;
end if;

If deleting then
  delete from event_core where id=:o.event_core_id; 
end if;

exception

when invalid_event then
     Raise_application_error(-20016,'Invalid template type in event_core. It must point to GRP');
end;
/
sho err

-- Following changes are made as per the request from kelly on 02/01/2001 at 10:10 AM

alter table site add( 
ADDRESS_LINE_1  VARCHAR2(255),
ADDRESS_LINE_2  VARCHAR2(255),
CITY VARCHAR2(255),
STATE   VARCHAR2(255),
POSTAL_CODE    VARCHAR2(20),
COUNTRY    VARCHAR2(255));


-- Following changes are made as per the request of Phil on 02/01/2001 at 11:20 AM

Alter table subject modify(
COMPLETED_ENCOUNTERS default 0,
UNMONITORED_SCREENING_VISITS default 0,
UNMONITORED_TREATMENT_VISITS default 0,
UNMONITORED_FOLLOWUP_VISITS default 0,
UNMONITORED_SCREENFAIL_VISITS default 0,
UNMONITORED_EARLYTERM_VISITS default 0,
UNMONITORED_COMPLETED_VISITS default 0);

Update subject set COMPLETED_ENCOUNTERS = 0 where COMPLETED_ENCOUNTERS is null;
Update subject set UNMONITORED_SCREENING_VISITS = 0 where UNMONITORED_SCREENING_VISITS is null;
Update subject set UNMONITORED_TREATMENT_VISITS = 0 where UNMONITORED_TREATMENT_VISITS is null;
Update subject set UNMONITORED_FOLLOWUP_VISITS = 0 where UNMONITORED_FOLLOWUP_VISITS is null;
Update subject set UNMONITORED_SCREENFAIL_VISITS = 0 where UNMONITORED_SCREENFAIL_VISITS is null;
Update subject set UNMONITORED_EARLYTERM_VISITS = 0 where UNMONITORED_EARLYTERM_VISITS is null;
Update subject set UNMONITORED_COMPLETED_VISITS = 0 where UNMONITORED_COMPLETED_VISITS is null;

commit;

-- Following changes are made as per the request of colin on 02/01/2001 at 13:30 


Update site_to_trial set patient_mngment_sts='NONE' where patient_mngment_sts is null;
Update site_to_trial set accrual_status='TESTING' where accrual_status is null;

alter table site_to_trial modify (
patient_mngment_sts default 'NONE' not null,
accrual_status default 'TESTING' not null);

-- Following changes are as per the request from Phil on 02/01/2001 at 14:30

Alter table SUBJECT_ENCOUNTER drop constraint SUB_ENC_ENC_STATUS_CHECK;

Update subject_encounter set encounter_status = 'Projected' where 
	encounter_status = 'Prospective';

Alter table subject_encounter add constraint sub_enc_enc_status_check
        check (Encounter_status in 
        ('Completed','Missed','Rescheduled','Inprogress',
         'Scheduled','Toreschedule','Projected','NA',
          'Entered In Error', 'Invalid' ));

-- Following changes are made after the refresh of data load for event model on 02/02/01 at 12 noon

create or replace trigger subject_encounter_trg1
after insert or update on subject_encounter 
referencing new as n old as o
for each row
declare

invalid_event exception;
template event_core.template_type%type;
invalid_site exception;
site_id_v1 event_core.site_id%type;
site_id_v2 site_to_trial.site_id%type;

begin

 select template_type into template from event_core where  id = :n.event_core_id;

 If upper(template) <> 'ENC' then
    raise invalid_event;
 end if;

 Select site_id  into site_id_v1 from event_core  where 
	id = :n.event_core_id;

 Select min(a.site_id) into site_id_v2 from site_to_trial a, subject b 
 	where a.id=b.site_to_trial_id and b.id = :n.subject_id;
   If site_id_v1 <> site_id_v2 then
 	raise invalid_site;
   end if;

exception

when invalid_event then
     Raise_application_error(-20012,'Invalid template type in event_core. It must point to ENC');
when invalid_site then
     Raise_application_error(-20017,'Not a valid site.. inconsistency in site_id');

end;
/
sho err

-- Following changes are added as per the request of Peter on 02/05/2001 at 9:30 AM

create table unencoded_event(
	id  number(10),
	event_core_id number(10) not null,
	encounter_status varchar2(50) not null,
	reschedule_id number(10),
	monitor_status varchar2(50) not null,
	monitor_visit_id number(10),
	monitor_note varchar2(4000),
	hide number(1) not null,
	creator varchar2(50) not null)
	tablespace ftsmall pctused 65 pctfree 20;

Alter table unencoded_event add constraint unencoded_event_pk
        primary key (id) using index tablespace 
        ftsmall_indx pctfree 20 nologging;

Alter table unencoded_event add constraint 
        unencoded_event_fk1 foreign key (event_core_id)  
        references event_core(id);

Alter table unencoded_event add constraint 
        unencoded_event_fk2 foreign key (reschedule_id)  
        references event_core(id);

Alter table unencoded_event add constraint 
        unencoded_event_fk3 foreign key (monitor_visit_id)  
        references event_core(id);

Alter table unencoded_event add constraint unencod_evnt_enc_status_check
        check (Encounter_status in 
        ('Completed','Missed','Rescheduled','Inprogress',
         'Scheduled','Toreschedule','Projected','NA',
          'Entered In Error', 'Invalid' ));

Alter table unencoded_event add constraint unencod_evnt_creator_check
        check (creator in ('Site','Sponsor'));

Alter table unencoded_event add constraint unencod_evnt_mon_status_check
        check (Monitor_status in ('Complete','Pending'));

Alter table unencoded_event add constraint unencod_evnt_hide_check
        check (hide in (0,1));


-- Following changes are as per the request from kelly on 02/06/2001 at 10:30 AM

Alter table site_to_trial modify(
ONFOLLOWUPCNT default 0,
COMPLETEDCNT   default 0,
ENROLLEDCNT    default 0,
ONTREATMENTCNT  default 0,          
EARLYTERMCNT_DIED    default 0,          
EARLYTERMCNT_LOSTTOFOLLOWUP    default 0,
EARLYTERMCNT_OTHER             default 0,
SCREENFAILURECNT_DIED          default 0,
SCREENFAILURECNT_NOTELIGIBLE   default 0,
SCREENFAILURECNT_OTHER         default 0,
SCREENINGCNT                   default 0,
NOTASSIGNEDCNT  default 0);

update site_to_trial set ONFOLLOWUPCNT=0 where ONFOLLOWUPCNT is null;
update site_to_trial set COMPLETEDCNT=0 where COMPLETEDCNT is null;
update site_to_trial set ENROLLEDCNT=0 where  ENROLLEDCNT is null;   
update site_to_trial set ONTREATMENTCNT=0 where ONTREATMENTCNT is null;  
update site_to_trial set EARLYTERMCNT_DIED=0 where EARLYTERMCNT_DIED is null;    
update site_to_trial set EARLYTERMCNT_LOSTTOFOLLOWUP=0 where EARLYTERMCNT_LOSTTOFOLLOWUP is null; 
update site_to_trial set EARLYTERMCNT_OTHER=0 where EARLYTERMCNT_OTHER is null;   
update site_to_trial set SCREENFAILURECNT_DIED=0 where SCREENFAILURECNT_DIED is null;   
update site_to_trial set SCREENFAILURECNT_NOTELIGIBLE=0 where  SCREENFAILURECNT_NOTELIGIBLE is null; 
update site_to_trial set SCREENFAILURECNT_OTHER=0 where  SCREENFAILURECNT_OTHER is null;
update site_to_trial set SCREENINGCNT=0 where   SCREENINGCNT is null;
update site_to_trial set NOTASSIGNEDCNT=0 where NOTASSIGNEDCNT is null;

commit;

-- Following changes are as per the request from Peter on 02/06/2001 at 15:00 hrs

alter table MISC_EVENT_PROTOTYPE add (type varchar2(50) not null);

Alter table MISC_EVENT_PROTOTYPE add constraint MISC_EVNT_PTTYPE_TYPE_CHECK 
	check(type in ('Encounter', 'General','Monsitevisit'));


-- Following changes are as per the request from Peter on 02/07/2001 at 9 AM

alter table subject_encounter modify(ENCOUNTER_NOTE null);

-- Following changes are as per the request of Joel on 02/07/2001 at 9:05 AM

Alter table subject_encounter add(
monitor_see_paper_note number(1) default 0);

Update subject_encounter set monitor_see_paper_note =0;

Alter table subject_encounter modify (
monitor_see_paper_note not null);

Alter table subject_encounter add constraint
sub_enc_mon_see_pap_note_check check (
monitor_see_paper_note in (0,1));

-- FOllowing changes are as per the request of Peter on 02/07/2001 at 9:20 AM

Alter table protocol_evgroup_inst 
	drop constraint PROTOCOL_EVGROUP_INST_FK2;

Alter table protocol_evgroup_inst add constraint
        protocol_evgroup_inst_fk2 foreign key (Parent_peginst_id)
        references event_core(id);

Alter table subject_encounter 
	drop constraint SUBJECT_ENCOUNTER_FK5;

Alter table subject_encounter add constraint
        subject_encounter_fk5 foreign key (Parent_peg_inst_id)
        references event_core(id);

-- FOllowing changes are as per the request of Peter on 02/07/2001 at 9:45 AM


alter table EVENT_CORE drop constraint EVENT_CORE_TT_CHECK;

Alter table Event_core add constraint EVENT_CORE_TT_CHECK check(
	template_type in ('ENC','DOC','MON','GEN','GRP','UNEV'));

Alter table MISC_EVENT_PROTOTYPE 
	drop constraint MISC_EVNT_PTTYPE_TYPE_CHECK;

Alter table MISC_EVENT_PROTOTYPE add constraint 
	MISC_EVNT_PTTYPE_TYPE_CHECK check (
	type in ('Encounter', 'General','Monsitevisit','Ftpeg'));

Alter table general_event modify (visibility null);

Alter table subject add(
	protocol_version_id Number(10),
	Initial_icf_version Varchar2(255),
	Initial_icf_date Date);

Alter table subject add constraint subject_fk6 
	foreign key (protocol_version_id) 
	references protocol_version(id);

alter table subject drop column ARM_ID;

-- Following changes are as per the request from Kelly on 02/07/2001 10 AM

Alter table Sponsor add (external_identifier varchar2(20));

update sponsor set external_identifier = name;

Alter table Sponsor modify (external_identifier not null);

-- Following modifications were done as per the problem reported by Joel

create or replace trigger Subject_site_check_trg1
before insert or update of site_to_trial_id,patient_id,next_visit_type_id
on Subject
referencing new as n old as o
for each row

declare

site_thro_patient site.id%type;
site_thro_site_to_trial  site.id%type;
arm_to_pv_cnt  number(10);
visit_type_to_arm_cnt number(10);

Invalid_site exception;
Invalid_arm2pv_ref exception;
Invalid_visit_type exception;
Invalid_vt2arm_ref exception;
Invalid_pv exception;

opv_id visit_type_to_arm.obsoleted_protocol_version_id%type;
apv_id visit_type_to_arm.added_protocol_version_id%type;

begin

   Select b.id into site_thro_patient from patient a, site b
      where a.site_id = b.id and  a.id = :n.patient_id;
   Select b.id into site_thro_site_to_trial from site_to_trial a, site b
     where a.site_id = b.id and  a.id = :n.site_to_trial_id;

   If site_thro_patient <> site_thro_site_to_trial then
     Raise  Invalid_site;
   end if;

/*   If :n.arm_id is null and :n.next_visit_type_id is not null then
     Raise Invalid_visit_type;
   End if;

   If :n.arm_id is not null then

        Select count(*) into arm_to_pv_cnt from arm_to_protocol_version
       where arm_id = :n.arm_id and protocol_version_id = :n.protocol_version_id;
       If arm_to_pv_cnt < 1 then
          raise  Invalid_arm2pv_ref;
       end if;  

       If :n.next_visit_type_id is not null then

            Select count(*) into visit_type_to_arm_cnt from visit_type_to_arm
            where arm_id = :n.arm_id and visit_type_id = :n.next_visit_type_id;
            If visit_type_to_arm_cnt < 1 then
                raise Invalid_vt2arm_ref;
            End if;

             Select obsoleted_protocol_version_id,added_protocol_version_id into opv_id,apv_id
            from visit_type_to_arm where arm_id = :n.arm_id and visit_type_id = :n.next_visit_type_id;

            If  :n.protocol_version_id < apv_id then
                raise Invalid_pv;
            end if;
            If opv_id is not null and :n.protocol_version_id >=opv_id then
                raise Invalid_pv;
            end if; 
        End if;
    End if; */
Exception

  When Invalid_site then
       Raise_application_error(-20001,'Data inconsistency between patient_id and site_to_trial_id');
  When Invalid_visit_type then
       Raise_application_error(-20002,'Does not make sense to have next_visit_type without arm');
  When Invalid_arm2pv_ref then
       Raise_application_error(-20003,'This combination of Arm and protocol version not found in arm_to_pv table');
  When Invalid_vt2arm_ref then
       Raise_application_error(-20004,'This combination of Arm  and next_visit_type not found in visit_type_to_arm');
  When Invalid_pv then
       Raise_application_error(-20005,'The protocol_version is not consistent with visit_type_to_arm table');

end;
/

-- Following changes are made as per the request from Kelly/carsten at 3PM on 02/07/2001

Alter table site_to_trial add (LATEST_ICF_DATE date);

-- Following update was made as per the request of kelly on 02/08/2001
-- but needs confirmation from her to implement in production

update subject a set a.protocol_version_id = (select b.protocol_version_id from
site_to_trial b where b.id=a.site_to_trial_id) where a.protocol_version_id is null;


-- Following changes were made as per the request from Nancy on 02/08/2001 at 11:30 AM

Alter table unencoded_event add (PARENT_PEG_INST_ID number(10) not null);

Alter table unencoded_event add constraint
        unencoded_event_fk4 foreign key (Parent_peg_inst_id)
        references event_core(id);


create or replace trigger unencoded_event_trg1
after insert or delete or update of event_core_id on unencoded_event 
referencing new as n old as o
for each row
declare

invalid_event exception;
template event_core.template_type%type;

begin

If inserting or updating then

 select template_type into template from event_core where  id = :n.event_core_id;

 If upper(template) <> 'UNEV' then
    raise invalid_event;
 end if;
end if;

If deleting then
  delete from event_core where id=:o.event_core_id; 
end if;

exception

when invalid_event then
     Raise_application_error(-20018,'Invalid template type in event_core. It must point to UNEV');
end;
/
sho err

-- Following changes are made as per the request from Colin on 02/08/2001 at 13:50 

Alter table HHGROUP_TO_CLASSIFIERS  add (HANDHELD_GROUP_ID  number(10));

Update HHGROUP_TO_CLASSIFIERS set HANDHELD_GROUP_ID = hhgroup_id;

Alter table HHGROUP_TO_CLASSIFIERS drop column hhgroup_id;

Alter table HHGROUP_TO_CLASSIFIERS add constraint HHGROUP_TO_CLASSIFIERS_FK1
	foreign key (HANDHELD_GROUP_ID) references HANDHELD_GROUP(ID);

-- Following lines were added as per the request of Kelly on 02/08/2001 at 16:22

Alter table subject add (screening_id varchar2(20));


-- Following lines were added as per the request of colin on 02/12/2001 at 8:25 AM

create or replace trigger stt_last_modified_trg1
before insert or update on site_to_trial
referencing new as n old as o
for each row
declare
Invalid_trial_pv exception;
exist_trial_pv number(10);

begin

select sysdate into :n.last_modified_date from dual;

select count(*) into exist_trial_pv from protocol_version 
	where id=:n.PROTOCOL_VERSION_ID and trial_id=:n.trial_id;

	If exist_trial_pv = 0 then 
		raise Invalid_trial_pv;
	end if;

exception

when Invalid_trial_pv then
     Raise_application_error(-20019,'Invalid combination of trial and protocol version');

end;
/
sho err

-- Following changes are done as per the request of Colin on 02/12/2001 at 9:55 AM

Alter table event_core add (date_time_precision number(3));

-- Following changes are done as per the request of Kelly on 02/12/2001 at 10:15 AM

Create or replace trigger ftuser_name_check_trg1  
before insert or update of name on ftuser
referencing new as n old as o
for each row

declare
extension_v ftuser.name%type; 
site_id_cnt  number(20);
sponsor_id_cnt  number(20);
Invalid_site_id exception;
Invalid_sponsor_id exception;

begin

 If :n.name like '%@%' then

    extension_v:=substr(:n.name,instr(:n.name,'@')+1);

    If :n.site_id is not null then 

        select count(*) into  site_id_cnt from site where site_identifier = extension_v;

        If site_id_cnt <1 then 
           Raise Invalid_site_id;
        end if;
    elsif :n.sponsor_id is not null then 

        select count(*) into sponsor_id_cnt from sponsor where name = extension_v;

        If sponsor_id_cnt <1 then 
           Raise Invalid_sponsor_id;
        end if;
    end if;


 end if;

Exception 

  When Invalid_site_id then
       Raise_application_error(-20006,'Invalid site identifier attached with name');

  when Invalid_sponsor_id then
       Raise_application_error(-20020,'Invalid sponsor identifier attached with name');

end;
/
sho err


-- on delete cascades as per the request of kelly on 02/12/2001 at 14:43

ALTER TABLE CRITERION DROP CONSTRAINT PROTOCOL_VERSION_FK;
ALTER TABLE CRITERION ADD CONSTRAINT PROTOCOL_VERSION_FK FOREIGN KEY (PROTOCOL_VERSION_ID)
REFERENCES PROTOCOL_VERSION(ID) ON DELETE CASCADE;

ALTER TABLE PEG_TO_EVENT DROP CONSTRAINT PEG_TO_EVENT_FK1;
ALTER TABLE PEG_TO_EVENT ADD CONSTRAINT PEG_TO_EVENT_FK1 FOREIGN KEY (PROTOCOL_VERSION_ID)
REFERENCES PROTOCOL_VERSION(ID) ON DELETE CASCADE;

ALTER TABLE PEG_TO_PEG DROP CONSTRAINT PEG_TO_PEG_FK1;
ALTER TABLE PEG_TO_PEG ADD CONSTRAINT PEG_TO_PEG_FK1 FOREIGN KEY (PROTOCOL_VERSION_ID)
REFERENCES PROTOCOL_VERSION(ID) ON DELETE CASCADE;

ALTER TABLE PV_TO_CLASSIFIER DROP CONSTRAINT PV_TO_CLASSIFIER_FK1;
ALTER TABLE PV_TO_CLASSIFIER ADD CONSTRAINT PV_TO_CLASSIFIER_FK1 FOREIGN KEY (PROTOCOL_VERSION_ID)
REFERENCES PROTOCOL_VERSION(ID) ON DELETE CASCADE;

ALTER TABLE TASK_TO_PROTOCOL_EVENT DROP CONSTRAINT TASK_TO_PROTOCOL_EVENT_FK1;
ALTER TABLE TASK_TO_PROTOCOL_EVENT ADD CONSTRAINT TASK_TO_PROTOCOL_EVENT_FK1 FOREIGN KEY (PROTOCOL_VERSION_ID)
REFERENCES PROTOCOL_VERSION(ID) ON DELETE CASCADE;

ALTER TABLE SITE_TO_TRIAL DROP CONSTRAINT PROTOCOL_VERSION_FK3;
ALTER TABLE SITE_TO_TRIAL ADD CONSTRAINT PROTOCOL_VERSION_FK3 FOREIGN KEY (PROTOCOL_VERSION_ID)
REFERENCES PROTOCOL_VERSION(ID) ON DELETE CASCADE;

ALTER TABLE STUDY_SETUP_EVENT DROP CONSTRAINT STUDY_SETUP_EVENT_FK2;
ALTER TABLE STUDY_SETUP_EVENT ADD CONSTRAINT STUDY_SETUP_EVENT_FK2 FOREIGN KEY (SITE_TO_TRIAL_ID)
REFERENCES SITE_TO_TRIAL(ID) ON DELETE CASCADE;

Create or replace trigger STUDY_SETUP_EVENT_TRG2 
after delete on STUDY_SETUP_EVENT 
referencing new as n old as o 
for each row
begin
delete from event_core where id=:o.event_core_id;
end;
/

ALTER TABLE PROTOCOL_EVENT DROP CONSTRAINT PROTOCOL_EVENT_FK1;
ALTER TABLE PROTOCOL_EVENT ADD CONSTRAINT PROTOCOL_EVENT_FK1 FOREIGN KEY (TRIAL_ID)
REFERENCES TRIAL(ID) ON DELETE CASCADE;

ALTER TABLE PATIENT_MANAGEMENT_TASK DROP CONSTRAINT PATIENT_MANAGEMENT_TASK_FK1;
ALTER TABLE PATIENT_MANAGEMENT_TASK ADD CONSTRAINT PATIENT_MANAGEMENT_TASK_FK1 FOREIGN KEY (TRIAL_ID)
REFERENCES TRIAL(ID) ON DELETE CASCADE;

ALTER TABLE PROTOCOL_EVENT_GROUP DROP CONSTRAINT PROTOCOL_EVENT_GROUP_FK1;
ALTER TABLE PROTOCOL_EVENT_GROUP ADD CONSTRAINT PROTOCOL_EVENT_GROUP_FK1 FOREIGN KEY (TRIAL_ID)
REFERENCES TRIAL(ID) ON DELETE CASCADE;

-- Following changes are made as per the request of colin on 02/13/2001 at 10 AM

Update ftgroup set name = 'Fast Track Administrator' where
	name='fasttrack';

Alter table ftgroup add constraint ftgroup_name_check check (
name in ('Fast Track Administrator','Site Administrator',
'Sponsor Administrator','Site User','CRA','CRA Manager'));

-- Following changes were made as per the request of Kelly on 02/13/2001 at 10:30

ALTER TABLE SITE_TO_TRIAL DROP COLUMN SCREENING_FAILURES;
drop table candidate;

-- **** Updated schema document *******

-- Following changes are made as per the request of Peter on 02/13/2001 at 12:56 

Alter table protocol_evgroup_inst add(
	unencoded_event_peg number(1));

Update protocol_evgroup_inst set unencoded_event_peg=0;

Alter table protocol_evgroup_inst modify(
	unencoded_event_peg not null);

Alter table protocol_evgroup_inst add constraint
	pevg_inst_unev_peg_check check (
	unencoded_event_peg in (0,1));

Alter table unencoded_event add(
	SEQ NUMBER(4));

update unencoded_event set SEQ = 1;

Alter table unencoded_event modify( 
	SEQ not null);

-- Following changes are made as per the request of Matt on 02/13/2001 at 16:10

Alter table event_core add (
	dismissed number(1));
Update event_core set dismissed=0;
Alter table event_core modify (dismissed not null);

Alter table event_core add constraint event_core_dismissed_check check(
	dismissed in (1,0));

-- Following changes are made as per the request of Peter on 02/14/2001 at 15:10 


Alter table unencoded_event add (subject_id number(10) not null);

Alter table unencoded_event add constraint 
unencoded_event_fk5 foreign key (subject_id)
references subject(id);

Alter table subject_encounter add (
mon_site_visit_event_core_id number(10));

Alter table subject_encounter drop column MONITOR_SITE_VISIT_ID;

Alter table subject_encounter add constraint subject_encounter_fk4
foreign key (mon_site_visit_event_core_id)
references event_core(id);

-- Following changes are made as per the request from Phil at 

Alter table sponsor add(
	HANDHELD_STALE_PERIOD NUMBER(2) default 8);

Update sponsor set HANDHELD_STALE_PERIOD=8;

Alter table sponsor modify(HANDHELD_STALE_PERIOD not null);

-- FOllowing changes are made as per the request from Peter at 17:10

Alter table subject_encounter add(time_period_category varchar2(50));

-- Following changes are made as per the request from Nanacy on 02/16/2001 at 9 AM

Alter table MONITOR_SITE_VISIT add(
monitor_id number(10));

Alter table MONITOR_SITE_VISIT add constraint
MONITOR_SITE_VISIT_FK4 foreign key (monitor_id)
references monitor(id);

create or replace trigger monitor_site_visit_trg1
after insert or delete or update of event_core_id on monitor_site_visit 
referencing new as n old as o
for each row
declare

invalid_event exception;
template event_core.template_type%type;
exist_stt_monitor  number(10);
invalid_stt_monitor exception;

begin

If inserting or updating then

 select template_type into template from event_core where  id = :n.event_core_id;

 If upper(template) <> 'MON' then
    raise invalid_event;
 end if;

 Select count(*) into exist_stt_monitor from monitor_to_site_to_trial
        where site_to_trial_id=:n.site_to_trial_id
        and  monitor_id=:n.monitor_id;

	If exist_stt_monitor = 0 then 
		raise invalid_stt_monitor;
	end if;
end if;

If deleting then
  delete from event_core where id=:o.event_core_id; 
end if;


exception

when invalid_event then
     Raise_application_error(-20015,'Invalid template type in event_core. It must point to MON');
when invalid_stt_monitor then
     Raise_application_error(-20021,'Invalid combination of site_to_trial and monitor');

end;
/
sho err

-- The following changes are done as per the request of Joel on 02/16/2001 at 14:20

alter table VISIT_CHECKLIST_TEMPLATE 
	drop constraint VISIT_CKLST_TMPLT_CTGRY_CHECK;

alter table VISIT_CHECKLIST_TEMPLATE add
	constraint VISIT_CKLST_TMPLT_CTGR_CHECK check (
	category in ('Screening','Treatment','Followup'));

-- The following changes are done as per the request of Nancy on 02/16/2001 at 15:30

Alter table monitor_site_visit modify (monitor_id not null);

-- The following changes are as per the request of kelly on 02/19/2001 at 9.45 AM

alter table sponsor drop column EXTERNAL_IDENTIFIER;
alter table sponsor add(sponsor_identifier VARCHAR2(20));
update sponsor set sponsor_identifier=name;
alter table sponsor modify(sponsor_identifier not null);

Create or replace trigger ftuser_name_check_trg1  
before insert or update of name on ftuser
referencing new as n old as o
for each row

declare
extension_v ftuser.name%type; 
site_id_cnt  number(20);
sponsor_id_cnt  number(20);
Invalid_site_id exception;
Invalid_sponsor_id exception;

begin

 If :n.name like '%@%' then

    extension_v:=substr(:n.name,instr(:n.name,'@')+1);

    If :n.site_id is not null then 

        select count(*) into  site_id_cnt from site where site_identifier = extension_v;

        If site_id_cnt <1 then 
           Raise Invalid_site_id;
        end if;
    elsif :n.sponsor_id is not null then 

        select count(*) into sponsor_id_cnt from sponsor where sponsor_identifier = extension_v;

        If sponsor_id_cnt <1 then 
           Raise Invalid_sponsor_id;
        end if;
    end if;


 end if;

Exception 

  When Invalid_site_id then
       Raise_application_error(-20006,'Invalid site identifier attached with name');

  when Invalid_sponsor_id then
       Raise_application_error(-20020,'Invalid sponsor identifier attached with name');

end;
/
sho err



-- The following changes are as per the request of kelly on 02/19/2001 at 10.25 AM
drop table pv_to_disease;
drop table handheld_group_to_disease;
drop table ftuser_to_disease;
drop table visit_type_to_arm;
drop table visit_task_to_visit_type;
drop table arm_to_protocol_version;
drop table arm;
drop table visit_task;
drop table disease;


-- Following trigger was added as per the request of Phil on 02/20/2001 at 11.20 AM

create or replace trigger Subject_site_check_trg1
before insert or update of site_to_trial_id,patient_id,next_visit_type_id
on Subject
referencing new as n old as o
for each row

declare

site_thro_patient site.id%type;
site_thro_site_to_trial  site.id%type;
Invalid_site exception;
Invalid_subject_id exception;

begin

   Select b.id into site_thro_patient from patient a, site b
      where a.site_id = b.id and  a.id = :n.patient_id;
   Select b.id into site_thro_site_to_trial from site_to_trial a, site b
     where a.site_id = b.id and  a.id = :n.site_to_trial_id;

   If site_thro_patient <> site_thro_site_to_trial then
     Raise  Invalid_site;
   end if;

   If :n.subject_id is null and :n.screening_id is null then 
     Raise Invalid_subject_id;
   end if;

Exception

  When Invalid_site then
       Raise_application_error(-20001,'Data inconsistency between patient_id and site_to_trial_id');
  When Invalid_subject_id then
       Raise_application_error(-20021,'Both subject_id and screening_id can not be null');

end;
/

-- The following changes are as per the request of Peter on 02/20/2001 at 12:20 pm

Update patient set PREFERRED_CONTACT='Homephone' where
	PREFERRED_CONTACT='patient.home_phone';
Update patient set PREFERRED_CONTACT='Workphone' where
	PREFERRED_CONTACT='patient.work_phone';
Update patient set PREFERRED_CONTACT='Mobilephone' where
        PREFERRED_CONTACT='patient.mobile_phone';
update patient set preferred_contact = 'Email' where 
	preferred_contact = 'patient.email';

Alter table patient add constraint patient_pref_contact_check
check (preferred_contact in ('Homephone','Workphone','Email','Mobilephone'));

-- Following changes are done as per the request of Matt on 02/22/2001 at 12:30 pm

Alter table monitor_site_visit add (status varchar2(50));

Alter table monitor_site_visit add constraint 
	mon_site_visit_status_check check (
        status in ('Monitored','Unmonitored','Pending'));

Update monitor_site_visit set status = 'Pending';

Alter table monitor_site_visit modify (status not null);

-- Following changes are done as per the request of Matt on 02/22/2001 at 17:30

alter table monitor add (monitor_title varchar2(128));

-- Following changes are as per the request of Joel on 02/23/2001 at 9 AM

Alter table unencoded_event  add(
monitor_see_paper_note number(1) default 0);

Update unencoded_event  set monitor_see_paper_note =0;

Alter table unencoded_event  modify (
monitor_see_paper_note not null);

Alter table unencoded_event  add constraint
unev_mon_see_pap_note_check check (
monitor_see_paper_note in (0,1));

-- Following changes were done as per the request of Kelly on 02/26/2001 at 10:50 

Update site_to_trial set ONFOLLOWUPCNT = 0 where ONFOLLOWUPCNT is null;
Update site_to_trial set COMPLETEDCNT = 0 where COMPLETEDCNT is null;   
Update site_to_trial set ENROLLEDCNT = 0 where ENROLLEDCNT is null;
Update site_to_trial set ONTREATMENTCNT = 0 where ONTREATMENTCNT is null;                 
Update site_to_trial set EARLYTERMCNT_DIED = 0 where EARLYTERMCNT_DIED is null;              
Update site_to_trial set EARLYTERMCNT_LOSTTOFOLLOWUP = 0 where EARLYTERMCNT_LOSTTOFOLLOWUP is null;    
Update site_to_trial set EARLYTERMCNT_OTHER = 0 where EARLYTERMCNT_OTHER is null;             
Update site_to_trial set SCREENFAILURECNT_DIED = 0 where SCREENFAILURECNT_DIED is null;          
Update site_to_trial set SCREENFAILURECNT_NOTELIGIBLE = 0 where SCREENFAILURECNT_NOTELIGIBLE is null;
Update site_to_trial set SCREENFAILURECNT_OTHER = 0 where SCREENFAILURECNT_OTHER is null;         
Update site_to_trial set SCREENINGCNT = 0 where SCREENINGCNT is null;                   
Update site_to_trial set NOTASSIGNEDCNT  = 0 where NOTASSIGNEDCNT is null;   

Alter table site_to_trial modify(
ONFOLLOWUPCNT default 0,
COMPLETEDCNT default 0,   
ENROLLEDCNT default 0, 
ONTREATMENTCNT default 0,                 
EARLYTERMCNT_DIED default 0,       
EARLYTERMCNT_LOSTTOFOLLOWUP default 0,     
EARLYTERMCNT_OTHER default 0, 
SCREENFAILURECNT_DIED default 0, 
SCREENFAILURECNT_NOTELIGIBLE default 0, 
SCREENFAILURECNT_OTHER default 0, 
SCREENINGCNT default 0, 
NOTASSIGNEDCNT default 0);

-- Following changes were done as per the request of Nancy on 02/26/2001 at 17:10 

Alter table ftuser add (title varchar2(128));

Alter table monitor drop column monitor_title;

-- Following changes were done as per the request of Peter on 03/01/2001 at 10:30 

create or replace trigger subject_encounter_trg1
after insert or update on subject_encounter 
referencing new as n old as o
for each row
declare

invalid_event exception;
template event_core.template_type%type;
invalid_site exception;
site_id_v1 event_core.site_id%type;
site_id_v2 site_to_trial.site_id%type;
invalid_subject exception;
subject_id_v1 protocol_evgroup_inst.subject_id%type;

begin

 select template_type into template from event_core where  id = :n.event_core_id;

 If upper(template) <> 'ENC' then
    raise invalid_event;
 end if;

 Select site_id  into site_id_v1 from event_core  where 
	id = :n.event_core_id;

 Select min(a.site_id) into site_id_v2 from site_to_trial a, subject b 
 	where a.id=b.site_to_trial_id and b.id = :n.subject_id;
   If site_id_v1 <> site_id_v2 then
 	raise invalid_site;
   end if;

 Select subject_id into subject_id_v1 from protocol_evgroup_inst 
 	where event_core_id=:n.parent_peg_inst_id;
   If  subject_id_v1 <> :n.subject_id then
   	raise invalid_subject;
   end if;

exception

when invalid_event then
     Raise_application_error(-20012,'Invalid template type in event_core. It must point to ENC');
when invalid_site then
     Raise_application_error(-20017,'Not a valid site.. inconsistency in site_id');
when invalid_subject then
     Raise_application_error(-20022,'Different subject in parent event');
end;
/
sho err


create or replace trigger unencoded_event_trg1
after insert or delete or update of event_core_id on unencoded_event 
referencing new as n old as o
for each row
declare

invalid_event exception;
template event_core.template_type%type;
invalid_subject exception;
subject_id_v1 protocol_evgroup_inst.subject_id%type;

begin

If inserting or updating then

 select template_type into template from event_core where  id = :n.event_core_id;

 If upper(template) <> 'UNEV' then
    raise invalid_event;
 end if;



 Select subject_id into subject_id_v1 from protocol_evgroup_inst 
 	where event_core_id=:n.parent_peg_inst_id;
   If  subject_id_v1 <> :n.subject_id then
   	raise invalid_subject;
   end if;

end if;

If deleting then
  delete from event_core where id=:o.event_core_id; 
end if;


exception

when invalid_event then
     Raise_application_error(-20018,'Invalid template type in event_core. It must point to UNEV');
when invalid_subject then
     Raise_application_error(-20023,'Different subject in parent event');

end;
/
sho err


-- Following changes are as per the request of Kelly on 03/02/2001 at 9:17 AM

create or replace trigger handheld_device_trg1
after insert or update on handheld_device
referencing new as n old as o
for each row
declare

relation_check exception;
relation_exist exception;

begin

If :n.handheld_group_id is not null and :n.ftuser_id is not null then
     raise relation_check;
end if;

If :n.handheld_group_id is null and :n.ftuser_id is null then
     raise relation_exist;
end if;

exception

When relation_check then
     Raise_application_error(-20007,'Handheld device can not be related to both ftuser and handheld group');
when relation_exist then
     Raise_application_error(-20008,'Both Handheld_device_id and ftuser_id  can not be null');

end;
/
sho err

-- Following changes are done as per the request of Nancy on 03/01/2001 at 17:30 

Alter table monitor add (ftuser_id number(10));
update monitor set ftuser_id=monitor_ftuser_id;
Alter table monitor drop column monitor_ftuser_id;
Alter table monitor add constraint monitor_fk1 
	foreign key(ftuser_id) references ftuser(id);



-- Following changes are done as per the request of Nancy on 03/05/2001 at 11:00 


Alter table cra_manager_to_monitor add(ftuser_id number(10));

update cra_manager_to_monitor a set a.ftuser_id = (select b.ftuser_id from
	monitor b where b.id=a.monitor_id); 

Alter table cra_manager_to_monitor modify(ftuser_id not null);

Alter table cra_manager_to_monitor drop column monitor_id;

Alter table cra_manager_to_monitor add constraint CRA_MANAGER_TO_MONITOR_FK2
	foreign key (ftuser_id) references ftuser(id);


Alter table monitor_to_site_to_trial add(ftuser_id number(10));

update monitor_to_site_to_trial a set a.ftuser_id = (select b.ftuser_id from
	monitor b where b.id=a.monitor_id); 

Alter table monitor_to_site_to_trial modify(ftuser_id not null);

Alter table monitor_to_site_to_trial drop column monitor_id;

Alter table monitor_to_site_to_trial add constraint monitor_to_site_to_trial_FK1
	foreign key (ftuser_id) references ftuser(id);






-- Following lines were added as per the request of Kelly on 03/06/2001 at 10:15

create or replace trigger peg_to_peg_trg1
after insert or update on peg_to_peg 
referencing new as n old as o
for each row
declare

invalid_trial1 exception;
invalid_trial2 exception;
trial_thro_pv protocol_version.trial_id%type;
trial_thro_protocol_evg  protocol_event_group.trial_id%type;
trial_thro_parent_evg  protocol_event_group.trial_id%type;

begin


  select trial_id into trial_thro_pv from protocol_version
	where id = :n.protocol_version_id;

  select trial_id into trial_thro_protocol_evg from protocol_event_group
	where id = :n.protocol_evgroup_id;

  If :n.parent_evgroup_id is not null then 

     select trial_id into trial_thro_parent_evg from protocol_event_group
	where id = :n.parent_evgroup_id;

	If trial_thro_protocol_evg <> trial_thro_parent_evg then
		raise invalid_trial1;
	end if;
  end if;

  If trial_thro_pv <> trial_thro_protocol_evg then 
	raise invalid_trial2;
  end if;

exception

when invalid_trial1 then
     Raise_application_error(-20023,'Trial_id does not match between protocol event and parent');
when invalid_trial2 then
     Raise_application_error(-20024,'Trial_id does not match between protocol event and protocol version');

end;
/
sho err



create or replace trigger peg_to_event_trg1
after insert or update on peg_to_event 
referencing new as n old as o
for each row
declare

invalid_trial1 exception;
invalid_trial2 exception;
trial_thro_pv protocol_version.trial_id%type;
trial_thro_protocol_event  protocol_event.trial_id%type;
trial_thro_parent_evg  protocol_event_group.trial_id%type;

begin


  select trial_id into trial_thro_pv from protocol_version
	where id = :n.protocol_version_id;

  select trial_id into trial_thro_protocol_event from protocol_event
	where id = :n.protocol_event_id;

  select trial_id into trial_thro_parent_evg from protocol_event_group
	where id = :n.parent_evgroup_id;

  If trial_thro_protocol_event <> trial_thro_parent_evg then
		raise invalid_trial1;
  end if;


  If trial_thro_pv <> trial_thro_protocol_event then 
	raise invalid_trial2;
  end if;

exception

when invalid_trial1 then
     Raise_application_error(-20025,'Trial_id does not match between protocol event and parent event group');
when invalid_trial2 then
     Raise_application_error(-20026,'Trial_id does not match between protocol event and protocol version');

end;
/
sho err


create or replace trigger monitor_to_site_to_trial_trg1
after insert or update on monitor_to_site_to_trial 
referencing new as n old as o
for each row
declare

invalid_sponsor exception;
sponsor_thro_stt  trial.sponsor_id%type;
sponsor_thro_ftuser  ftuser.sponsor_id%type;

begin

  select sponsor_id into sponsor_thro_ftuser from ftuser 
	where id = :n.ftuser_id;

  select b.sponsor_id into sponsor_thro_stt from site_to_trial a, trial b
	where a.trial_id=b.id and
              a.id = :n.site_to_trial_id ;

  If sponsor_thro_ftuser is not null and sponsor_thro_stt is not null and
     sponsor_thro_ftuser <> sponsor_thro_stt then
		raise invalid_sponsor;
  end if;

exception

when invalid_sponsor then
     Raise_application_error(-20027,'Sponsor_id does not match between ftuser and trial');
end;
/
sho err


-- Following changes are done as per the request of Peter at 4:50 PM

Alter table hhgroup_to_classifiers add constraint hhgroup_to_classifiers_uq1
	unique (taclassifier_id, handheld_group_id) using index tablespace 
	ftsmall_indx pctfree 20 nologging;

create or replace trigger task_to_protocol_event_trg1
after insert or update on task_to_protocol_event 
referencing new as n old as o
for each row
declare

invalid_trial1 exception;
invalid_trial2 exception;
trial_thro_pv protocol_version.trial_id%type;
trial_thro_pt_mgmt_task  patient_management_task.trial_id%type;
trial_thro_protocol_event protocol_event.trial_id%type;

begin

  select trial_id into trial_thro_pv from protocol_version
	where id = :n.protocol_version_id;

  select trial_id into trial_thro_pt_mgmt_task from patient_management_task
	where id = :n.PATIENT_MNGMT_TASK_ID;

  select trial_id into trial_thro_protocol_event from protocol_event
	where id = :n.protocol_event_id;

  If trial_thro_protocol_event <> trial_thro_pt_mgmt_task then
		raise invalid_trial1;
  end if;

  If trial_thro_pv <> trial_thro_protocol_event then 
	raise invalid_trial2;
  end if;

exception

when invalid_trial1 then
     Raise_application_error(-20028,'Trial_id does not match between patient management task and protocol version');
when invalid_trial2 then
     Raise_application_error(-20029,'Trial_id does not match between patient management task and protocol event');



end;
/

sho err

-- Following changes are done as per the request of Kelly on 03/07/2001 at 14:50 


create or replace trigger stt_update_pv_trg1
after update of protocol_version_id on site_to_trial
referencing new as n old as o
for each row
begin

  update subject set protocol_version_id = :n.protocol_version_id 
	where protocol_version_id = :o.protocol_version_id and 
        subject_status in ('Screening',  'On Treatment','On Follow-Up');


end;
/
sho err


-- Following lines are added as per the request of Peter on 03/08/2001 at 9:40 AM

Insert into misc_event_prototype values (
1,'General Event','Site','General');

Insert into misc_event_prototype values (
2,'Monitor Site Visit','Sponsor','Monsitevisit');

Insert into misc_event_prototype values (
3,'Early Termination','Site','Encounter');

Insert into misc_event_prototype values (
4,'Screen Failure Termination','Site','Encounter');

Insert into misc_event_prototype values (
5,'Randomization','Site','Encounter');

Insert into misc_event_prototype values (
6,'PEG for Unencoded Events','Site','Ftpeg');

Insert into misc_event_prototype values (
7,'1.3VisitMigrationInfo','Site','Encounter');



Insert into regulatory_document values (
1,'FDA Form 1572','A wild and woolly document','1');

Insert into regulatory_document values (
2,'Investigator CVs','A wild and woolly document','1');

Insert into regulatory_document values (
3,'IRB Approval Letter','A wild and woolly document','0');

Insert into regulatory_document values (
4,'Protocol Amendments','A wild and woolly document','0');

Insert into regulatory_document values (
5,'Informed consent form','A wild and woolly document','0');

Insert into regulatory_document values (
6,'Investigator Brochures','A wild and woolly document','1');

Insert into regulatory_document values (
7,'IND Safety Reports','A wild and woolly document','1');

Insert into regulatory_document values (
8,'Patient Exclusion Logs','A wild and woolly document','1');


commit;

-- Following changes were done as per the request from Carsten on 03/08/2001 at 10:15 AM

alter table general_event modify (comments null);


-- Following procedure is created to load the ta/sponsor tables received from cI



-- The following line was added after casey found a bug on 03/08/2001 at 11:15 AM

alter table monitor_site_visit modify(monitor_note null);


-- Following lines has been added to recreate a trigger which has become invalid

create or replace trigger monitor_site_visit_trg1
after insert or delete or update of event_core_id on monitor_site_visit 
referencing new as n old as o
for each row
declare

invalid_event exception;
template event_core.template_type%type;
exist_stt_monitor  number(10);
invalid_stt_monitor exception;

begin

If inserting or updating then

 select template_type into template from event_core where  id = :n.event_core_id;

 If upper(template) <> 'MON' then
    raise invalid_event;
 end if;

 Select count(*) into exist_stt_monitor from monitor_to_site_to_trial
        where site_to_trial_id=:n.site_to_trial_id
        and  ftuser_id in (select ftuser_id from monitor where id= :n.monitor_id);

	If exist_stt_monitor = 0 then 
		raise invalid_stt_monitor;
	end if;
end if;

If deleting then
  delete from event_core where id=:o.event_core_id; 
end if;


exception

when invalid_event then
     Raise_application_error(-20015,'Invalid template type in event_core. It must point to MON');
when invalid_stt_monitor then
     Raise_application_error(-20021,'Invalid combination of site_to_trial and ftuser');

end;
/
sho err



-- Following changes are done as per the confirmation from Kelly on 03/12/2001 at 14:30 hrs

Alter table Unencoded_event drop constraint UNENCOD_EVNT_MON_STATUS_CHECK;

Alter table Unencoded_event add constraint UNENCOD_EVNT_MON_STATUS_CHECK 
	check ( monitor_status in ('Complete','Pending','Not Tracked'));


-- Following procedure is created for migrating sites

Create or replace procedure site_migration (siteid in varchar2) as

test_num  number(10);
mip misc_event_prototype.id%type;
ev1 event_core.id%type;
ev2 event_core.id%type;
ev3 event_core.id%type;
pegtopeg peg_to_peg.id%type;
ftuserid  ftuser.id%type;
pvid protocol_version.id%type;
nvdate subject.next_visit_date%type;

Cursor c1 is select id from subject where site_to_trial_id in (select id
                       from site_to_trial where site_id=siteid) and
                       subject_status in ('On Treatment','On Follow-Up','Screening') and
                       NEXT_VISIT_TYPE_ID is not null and
                       NEXT_VISIT_DATE is not null;
begin


For ix in c1 loop

     select count(*) into test_num from peg_to_peg a,subject b where
	a.protocol_version_id=b.protocol_version_id and
        b.id=ix.id and a.parent_evgroup_id is null;
  
   If test_num = 0 then

      dbms_output.put_line ('No peg_to_peg found...skipping subject_id '||ix.id);

   else

     select a.id into pegtopeg from peg_to_peg a,subject b where
	a.protocol_version_id=b.protocol_version_id and
        b.id=ix.id and a.parent_evgroup_id is null;

     select id into ftuserid from ftuser where  upper(name)='SYSTEM';    
     
     select event_core_seq.nextval into ev1 from dual;

     Insert into event_core values(ev1,pegtopeg,'Root Node',ftuserid,sysdate,'GRP',siteid,3,0);

     select protocol_version_id,next_visit_date into pvid,nvdate from subject where id=ix.id;


     Insert into protocol_evgroup_inst values(protocol_evgroup_inst_seq.nextval,ev1,null,null,pvid,
                                       ix.id,1,'Site',0);

     Select min(id) into mip from misc_event_prototype where name='PEG for Unencoded Events';

     select event_core_seq.nextval into ev2 from dual;

     Insert into event_core values(ev2,mip,'PEG for Unencoded Events',ftuserid,sysdate,'GRP',siteid,3,0);  

     Insert into protocol_evgroup_inst values(protocol_evgroup_inst_seq.nextval,ev2,ev1,null,pvid,
                                       ix.id,1,'Site',0);
           
     Select min(id) into mip from misc_event_prototype where name='1.3VisitMigrationInfo';

     select event_core_seq.nextval into ev3 from dual;

     Insert into event_core values(ev3,mip,'PEG for Unencoded Events',ftuserid,nvdate,'UNEV',siteid,3,0);

     Insert into unencoded_event values(unencoded_event_seq.nextval,ev3,
                                 decode(least(nvdate,sysdate),nvdate,'Completed','Scheduled'),
                                 null,'Not Tracked',null,null,0,'Site',ev2,1,ix.id,0);
  end if;
end loop;

commit;

end;
/

sho err


-- Following code is added to ensure uniqueness of site/sponsor names on 03/12/2001 at 14:45 hrs

Alter table sponsor add constraint sponsor_uq1 unique (SPONSOR_IDENTIFIER)
	using index tablespace ftsmall_indx pctfree 20 nologging;

Alter table sponsor add constraint sponsor_uq2 unique (name)
	using index tablespace ftsmall_indx pctfree 20 nologging;


create or replace trigger site_trg1 
after insert or update on site
referencing new as n old as o
for each row

declare

v_exist1 number(10);
v_exist2 number(10);
Invalid_name exception;
v_site ftuser.site_id%type;
Invalid_ftuser exception;

begin

 Select count(*) into v_exist1 from sponsor where sponsor_identifier=:n.site_identifier;
 
 Select count(*) into v_exist2 from sponsor where name=:n.name;

   If v_exist1 >0 or v_exist2 >0 then
	raise invalid_name;
   End if;

 select site_id into v_site from ftuser where id=:n.main_site_contact_id;

 If v_site is not null and v_site <> :n.id then
	raise invalid_ftuser;
 end if;


exception

 when invalid_name then
      Raise_application_error(-20030,'Name/Identifier already used as a sponsor'); 
 when invalid_ftuser then
      Raise_application_error(-20040,'Invalid main_site_contact_id');
end ;
/

sho err


create or replace trigger sponsor_trg1 
after insert or update on sponsor
referencing new as n old as o
for each row

declare

v_exist1 number(10);
v_exist2 number(10);
Invalid_name exception;
v_sponsor ftuser.sponsor_id%type;
Invalid_ftuser exception;

begin

 Select count(*) into v_exist1 from site where site_identifier=:n.sponsor_identifier;
 
 Select count(*) into v_exist2 from site where name=:n.name;

   If v_exist1 >0 or v_exist2 >0 then
	raise invalid_name;
   End if;

 select sponsor_id into v_sponsor from ftuser where id=:n.main_contact_id;

 If v_sponsor is not null and v_sponsor <> :n.id then
	raise invalid_ftuser;
 end if;


exception

 when invalid_name then
      Raise_application_error(-20031,'Name/Identifier already used as a site'); 
 when invalid_ftuser then
      Raise_application_error(-20041,'Invalid main_contact_id');
end ;
/

sho err



-- Following triggers are added as per the findings of data inconsistencies on 03/13/2001 at 10 AM


create or replace trigger Subject_site_check_trg1
before insert or update of site_to_trial_id,patient_id,next_visit_type_id,protocol_version_id,
assigned_cc_id on Subject
referencing new as n old as o
for each row

declare

site_thro_patient site.id%type;
site_thro_site_to_trial  site.id%type;
site_thro_ftuser site.id%type;
Invalid_site exception;
Invalid_subject_id exception;
Invalid_cc exception;
trial_thro_stt site_to_trial.trial_id%type;
trial_thro_pv protocol_version.trial_id%type;

Invalid_trial exception;


begin

   Select b.id into site_thro_patient from patient a, site b
      where a.site_id = b.id and  a.id = :n.patient_id;
   Select b.id into site_thro_site_to_trial from site_to_trial a, site b
     where a.site_id = b.id and  a.id = :n.site_to_trial_id;

   If site_thro_patient <> site_thro_site_to_trial then
     Raise  Invalid_site;
   end if;

   If :n.subject_id is null and :n.screening_id is null then 
     Raise Invalid_subject_id;
   end if;



   If :n.protocol_version_id is not null then

      Select trial_id into trial_thro_stt from site_to_trial 
         where id = :n.site_to_trial_id;
       
      Select trial_id into trial_thro_pv from protocol_version
         where id = :n.protocol_version_id;

      If  trial_thro_pv is not null and  trial_thro_stt <> trial_thro_pv then
        Raise Invalid_trial;

      end if;
   end if;

   If :n.assigned_cc_id is not null then

     select site_id into site_thro_ftuser from ftuser where id=:n.assigned_cc_id ;

     If site_thro_ftuser is not null and site_thro_ftuser <> site_thro_site_to_trial then
        Raise invalid_cc;
     end if;
   end if;
  

Exception

  When Invalid_site then
       Raise_application_error(-20001,'Data inconsistency between patient_id and site_to_trial_id');
  When Invalid_subject_id then
       Raise_application_error(-20021,'Both subject_id and screening_id can not be null');
  When Invalid_trial then
       Raise_application_error(-20032,'Not a valid trial between site_to_trial and protcol_version');
  when invalid_cc then 
       Raise_application_error(-20033,'Site_id invalid between assigned_cc and site_to_trial');
end;
/

sho err


create or replace trigger site_to_trial_trg2
before insert or update of  site_id,cc_ftuser_id, pi_ftuser_id on site_to_trial
referencing new as n old as o
for each row

declare

site1_thro_ftuser  ftuser.site_id%type;
site2_thro_ftuser  ftuser.site_id%type;
Invalid_site_cc exception;
Invalid_site_pi exception;


begin

  select site_id into site1_thro_ftuser from ftuser where id=:n.cc_ftuser_id;

 	If site1_thro_ftuser is not null and site1_thro_ftuser <> :n.site_id then
    	   Raise Invalid_site_cc;
 	

          If :n.pi_ftuser_id is not null then 
            select site_id into site2_thro_ftuser from ftuser where id=:n.pi_ftuser_id;
           
             If site2_thro_ftuser is not null and site2_thro_ftuser<> site1_thro_ftuser then
               Raise invalid_site_pi;
             End if;
          End if;

   	End if;
exception

  When Invalid_site_cc then
       Raise_application_error(-20034,'Not a valid site for cc_ftuser_id');
  when invalid_site_pi then 
       Raise_application_error(-20035,'Site_id invalid between cc_ftuser_id and pi_ftuser_id');
end;
/

sho err


create or replace trigger protocol_evgroup_inst_trg1
after insert or delete or update of event_core_id,subject_id on protocol_evgroup_inst 
referencing new as n old as o
for each row
declare

invalid_event exception;
template event_core.template_type%type;
site_thro_subject site_to_trial.site_id%type;
site_thro_event_core  event_core.site_id%type;
invalid_site exception;


begin

If inserting or updating then

 select template_type into template from event_core where  id = :n.event_core_id;

 If upper(template) <> 'GRP' then
    raise invalid_event;
 end if;

 
 select b.site_id into site_thro_subject from subject a, site_to_trial b where 
        a.site_to_trial_id=b.id and a.id=:n.subject_id; 

 Select site_id into site_thro_event_core from event_core where id=:n.event_core_id;

 If site_thro_subject <> site_thro_event_core then 
   raise invalid_site;
 end if;

end if;

If deleting then
  delete from event_core where id=:o.event_core_id; 
end if;

exception

 when invalid_event then
     Raise_application_error(-20016,'Invalid template type in event_core. It must point to GRP');
 when invalid_site then
     Raise_application_error(-20036,'Invalid site between subject and event_core');
end;
/
sho err


create or replace trigger SETUP_EVENT_MON_INSTANCE_trg1
after insert or update on SETUP_EVENT_MON_INSTANCE 
referencing new as n old as o
for each row
declare

stt_thro_sse study_setup_event.site_to_trial_id%type;
stt_thro_msv monitor_site_visit.site_to_trial_id%type;
invalid_stt exception;

begin

    select site_to_trial_id into stt_thro_sse from study_setup_event where
           id = :n.study_setup_event_id;

    If stt_thro_sse is not null then

       select site_to_trial_id into stt_thro_msv from monitor_site_visit where
           id = :n.monitor_site_visit_id;

       If stt_thro_sse <> stt_thro_msv then 
          Raise invalid_stt;
       end if;
    end if;
exception

 when invalid_stt then
     Raise_application_error(-20037,'Invalid site_to_trial between monitor_site_visit and study_setup_event');

end;
/
sho err


create or replace trigger study_setup_event_trg1
after insert or delete or update of event_core_id,site_to_trial_id on study_setup_event 
referencing new as n old as o
for each row
declare

invalid_event exception;
template event_core.template_type%type;
site_thro_ev_core event_core.site_id%type;
site_thro_stt site_to_trial.site_id%type;
invalid_site exception;


begin

If inserting or updating then

 select template_type into template from event_core where  id = :n.event_core_id;

 If upper(template) <> 'DOC' then
    raise invalid_event;
 end if;

  If :n.site_to_trial_id is not null then

    select site_id into site_thro_stt from site_to_trial where id=:n.site_to_trial_id;
    select site_id into site_thro_ev_core from event_core where id=:n.event_core_id;
    
    If site_thro_stt <> site_thro_ev_core then
      raise invalid_site;
    end if;
  end if;

end if;

If deleting then
  delete from event_core where id=:o.event_core_id; 
end if;

exception

 when invalid_event then
     Raise_application_error(-20013,'Invalid template type in event_core. It must point to DOC');
 when invalid_site then
     Raise_application_error(-20038,'Invalid site between site_to_trial and event_core');

end;
/
sho err

create or replace trigger unencoded_event_trg1
after insert or delete or update of event_core_id on unencoded_event 
referencing new as n old as o
for each row
declare

invalid_event exception;
template event_core.template_type%type;
invalid_subject exception;
subject_id_v1 protocol_evgroup_inst.subject_id%type;
site_thro_stt site_to_trial.site_id%type;
site_thro_ev_core  event_core.site_id%type;
Invalid_site exception;

begin

If inserting or updating then

 select template_type into template from event_core where  id = :n.event_core_id;

 If upper(template) <> 'UNEV' then
    raise invalid_event;
 end if;



 Select subject_id into subject_id_v1 from protocol_evgroup_inst 
 	where event_core_id=:n.parent_peg_inst_id;
   If  subject_id_v1 <> :n.subject_id then
   	raise invalid_subject;
   end if;
 
 select  b.site_id into site_thro_stt from subject a, site_to_trial b where
    a.site_to_trial_id=b.id and a.subject_id= :n.subject_id;

 select site_id into site_thro_ev_core from event_core where 
    id=:n.event_core_id;

  If site_thro_stt <> site_thro_ev_core then 
        Raise Invalid_site;
  End if;

end if;

 If deleting then
   delete from event_core where id=:o.event_core_id; 
 end if;


exception

 when invalid_event then
     Raise_application_error(-20018,'Invalid template type in event_core. It must point to UNEV');
 when invalid_subject then
     Raise_application_error(-20023,'Different subject in parent event');
 when invalid_site then
     Raise_application_error(-20039,'Invalid site between event_core and subject');


end;
/
sho err


-- Following changes are as per the request of Peter on 03/15/2001 at 9:35 AM for ECR42.2

Alter table subject_encounter add (
	min_date  Date,
	min_date_precision Number(3),
	max_date Date,
	max_date_precision Number(3));

-- Following cganges were done by debashish after finding some problem with these triggers

create or replace trigger site_trg1 
after insert or update on site
referencing new as n old as o
for each row

declare

v_exist1 number(10);
v_exist2 number(10);
Invalid_name exception;
v_site ftuser.site_id%type;
Invalid_ftuser exception;
sitecnt number(10);

begin

 Select count(*) into v_exist1 from sponsor where sponsor_identifier=:n.site_identifier;
 
 Select count(*) into v_exist2 from sponsor where name=:n.name;

   If v_exist1 >0 or v_exist2 >0 then
	raise invalid_name;
   End if;

 select count(*) into sitecnt from ftuser where id=:n.main_site_contact_id;

 If sitecnt > 0 then 

  select site_id into v_site from ftuser where id=:n.main_site_contact_id;

  If v_site is not null and v_site <> :n.id then
	raise invalid_ftuser;
  end if;
 end if;

exception

 when invalid_name then
      Raise_application_error(-20030,'Name/Identifier already used as a sponsor'); 
 when invalid_ftuser then
      Raise_application_error(-20040,'Invalid main_site_contact_id');
end ;
/

sho err


create or replace trigger sponsor_trg1 
after insert or update on sponsor
referencing new as n old as o
for each row

declare

v_exist1 number(10);
v_exist2 number(10);
Invalid_name exception;
v_sponsor ftuser.sponsor_id%type;
Invalid_ftuser exception;
sponsorcnt number(10);

begin

 Select count(*) into v_exist1 from site where site_identifier=:n.sponsor_identifier;
 
 Select count(*) into v_exist2 from site where name=:n.name;

   If v_exist1 >0 or v_exist2 >0 then
	raise invalid_name;
   End if;

 select count(*) into sponsorcnt from ftuser where id=:n.main_contact_id;

 if sponsorcnt > 0 then 
  select sponsor_id into v_sponsor from ftuser where id=:n.main_contact_id;

  If v_sponsor is not null and v_sponsor <> :n.id then
	raise invalid_ftuser;
  end if;
 end if;

exception

 when invalid_name then
      Raise_application_error(-20031,'Name/Identifier already used as a site'); 
 when invalid_ftuser then
      Raise_application_error(-20041,'Invalid main_contact_id');
end ;
/

sho err



-- Following changes are as per the request of Kelly on 03/20/2001 at 15:10 AM

create or replace trigger handheld_device_trg1
after insert or update on handheld_device
referencing new as n old as o
for each row
declare

relation_check exception;
relation_exist exception;

begin

If :n.handheld_group_id is not null and :n.ftuser_id is not null then
     raise relation_check;
end if;

exception

When relation_check then
     Raise_application_error(-20007,'Handheld device can not be related to both ftuser and handheld group');

end;
/
sho err



-- Following changes are as per the request of all(Nancy, Matt, Colin, Kelly) on 03/21/2001 at 8:50 AM

Create or replace trigger ftuser_name_check_trg1  
before insert or update on ftuser
referencing new as n old as o
for each row

declare
extension_v ftuser.name%type; 
site_id_cnt  number(20);
sponsor_id_cnt  number(20);
Invalid_site_id exception;
Invalid_sponsor_id exception;
invalid_ftuser exception;

begin

 If :n.name like '%@%' then

    extension_v:=substr(:n.name,instr(:n.name,'@')+1);

    If :n.site_id is not null then 

        select count(*) into  site_id_cnt from site where site_identifier = extension_v;

        If site_id_cnt <1 then 
           Raise Invalid_site_id;
        end if;
    elsif :n.sponsor_id is not null then 

        select count(*) into sponsor_id_cnt from sponsor where sponsor_identifier = extension_v;

        If sponsor_id_cnt <1 then 
           Raise Invalid_sponsor_id;
        end if;
    end if;


 end if;

 If :n.site_id is not null and :n.sponsor_id is not null then
    Raise invalid_ftuser;
 end if;



Exception 

  When Invalid_site_id then
       Raise_application_error(-20006,'Invalid site identifier attached with name');

  when Invalid_sponsor_id then
       Raise_application_error(-20020,'Invalid sponsor identifier attached with name');
 
  when Invalid_ftuser then
       Raise_application_error(-20042,'Both site_id and sponsor_id can not exist together');

end;
/
sho err


-- Following triggers were added as part of the sponsor side data inconsistencies on 03/21/2001 at 10:20

Create or replace trigger ftuser_trial_filter_trg1  
after insert or update on ftuser_trial_filter
referencing new as n old as o
for each row

declare
v_sponsor1  ftuser.sponsor_id%type;
v_sponsor2  trial.sponsor_id%type;
invalid_combination exception;

begin

   If :n.ftuser_id is not null and :n.trial_id is not null then
         
       select sponsor_id into v_sponsor1 from ftuser where id=:n.ftuser_id;
       select sponsor_id into v_sponsor2 from trial where id=:n.trial_id;

       
       If v_sponsor1 is not null and v_sponsor2 is not null and v_sponsor1 <> v_sponsor2 then
           Raise Invalid_combination;
       end if;

   end if;

exception

  when Invalid_combination then
       Raise_application_error(-20043,'ftuser_id and trial_id refers to different sponsors');
   
end;
/

sho err


-- Following lines were added as per the request of Peter on 03/21/2001 at 13:45


Alter table patient drop constraint patient_pref_contact_check;



Alter table patient add constraint patient_pref_contact_check
check (preferred_contact in ('Homephone','Workphone','Email','Mobilephone','Fax'));


-- Following trigger is added to support delete from subjects on 03/21/2001 at 16:00

create or replace trigger subject_status_trg2
after delete on subject
referencing new as n old as o
for each row

begin


  if upper(:o.subject_status) in ('ON TREATMENT','ON FOLLOW-UP','COMPLETED','EARLY TERM-DIED',
                                  'EARLY TERM-LOST TO FOLLOW-UP','EARLY TERM-OTHER') then
  update site_to_trial set enrolledcnt=nvl(enrolledcnt,0)-1 where
  id = :o.site_to_trial_id;
  end if;
  if upper(:o.subject_status) = 'NOT ASSIGNED' then
     update site_to_trial set NOTASSIGNEDCNT=nvl(NOTASSIGNEDCNT,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'SCREENING' then
     update site_to_trial set SCREENINGCNT=nvl(SCREENINGCNT,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'ON TREATMENT' then
     update site_to_trial set ONTREATMENTCNT=nvl(ONTREATMENTCNT,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'ON FOLLOW-UP' then
     update site_to_trial set ONFOLLOWUPCNT=nvl(ONFOLLOWUPCNT,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'COMPLETED' then
     update site_to_trial set COMPLETEDCNT=nvl(COMPLETEDCNT,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'SCREEN FAILURE-DIED' then
     update site_to_trial set SCREENFAILURECNT_DIED=nvl(SCREENFAILURECNT_DIED,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'SCREEN FAILURE-NOT ELIGIBLE' then
     update site_to_trial set SCREENFAILURECNT_NOTELIGIBLE=nvl(SCREENFAILURECNT_NOTELIGIBLE,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'SCREEN FAILURE-OTHER' then
     update site_to_trial set SCREENFAILURECNT_OTHER=nvl(SCREENFAILURECNT_OTHER,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'EARLY TERM-DIED' then
     update site_to_trial set EARLYTERMCNT_DIED=nvl(EARLYTERMCNT_DIED,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'EARLY TERM-LOST TO FOLLOW-UP' then
     update site_to_trial set EARLYTERMCNT_LOSTTOFOLLOWUP=nvl(EARLYTERMCNT_LOSTTOFOLLOWUP,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'EARLY TERM-OTHER' then
     update site_to_trial set EARLYTERMCNT_OTHER=nvl(EARLYTERMCNT_OTHER,0)-1 where
     id = :o.site_to_trial_id;
  end if;
end;
/

sho err



-- Following changes for Kelly on 03/21/2001 at 17:30  


create table monitor_backup as select * from monitor;

Alter table monitor_site_visit drop constraint monitor_site_visit_fk4;

Alter table cra_manager_to_monitor drop constraint cra_manager_to_monitor_fk2;

Alter table monitor_to_site_to_trial drop constraint monitor_to_site_to_trial_fk1;

Alter table monitor drop column id;

Alter table monitor add constraint monitor_pk primary key(ftuser_id)
	using index tablespace ftsmall_indx pctfree 20 nologging;

Alter table monitor_to_site_to_trial add constraint monitor_to_site_to_trial_fk1
	foreign key (ftuser_id) references monitor(ftuser_id);

Alter table cra_manager_to_monitor add constraint cra_manager_to_monitor_fk2
	foreign key (ftuser_id) references monitor(ftuser_id);


Alter table monitor_site_visit add(ftuser_id number(10));

update monitor_site_visit a set a.ftuser_id = (select b.ftuser_id from
	monitor_backup b where b.id=a.monitor_id); 

Alter table monitor_site_visit modify(ftuser_id not null);

Alter table monitor_site_visit drop column monitor_id;

Alter table monitor_site_visit add constraint monitor_site_visit_FK4
	foreign key (ftuser_id) references monitor(ftuser_id);

drop table monitor_backup;

create or replace trigger monitor_site_visit_trg1
after insert or delete or update of event_core_id on monitor_site_visit 
referencing new as n old as o
for each row
declare

invalid_event exception;
template event_core.template_type%type;
exist_stt_monitor  number(10);
invalid_stt_monitor exception;

begin

If inserting or updating then

 select template_type into template from event_core where  id = :n.event_core_id;

 If upper(template) <> 'MON' then
    raise invalid_event;
 end if;

 Select count(*) into exist_stt_monitor from monitor_to_site_to_trial
        where site_to_trial_id=:n.site_to_trial_id
        and  ftuser_id=:n.ftuser_id;

	If exist_stt_monitor = 0 then 
		raise invalid_stt_monitor;
	end if;
end if;

If deleting then
  delete from event_core where id=:o.event_core_id; 
end if;


exception

when invalid_event then
     Raise_application_error(-20015,'Invalid template type in event_core. It must point to MON');
when invalid_stt_monitor then
     Raise_application_error(-20021,'Invalid combination of site_to_trial and ftuser');

end;
/
sho err


create table monitor_site_visit_backup as select * from monitor_site_visit;
create table study_setup_event_backup as select * from study_setup_event;


Alter table setup_event_mon_instance drop constraint setup_event_mon_instance_fk2;
Alter table setup_event_mon_instance drop constraint setup_event_mon_instance_fk3;

Alter table general_event drop column id;
Alter table subject_encounter drop column id;
Alter table monitor_site_visit drop column id;
Alter table protocol_evgroup_inst drop column id;
Alter table study_setup_event drop column id;
Alter table unencoded_event drop column id;

Alter table general_event drop constraint general_event_UQ1;
Alter table subject_encounter drop constraint subject_encounter_UQ1;
Alter table monitor_site_visit drop constraint monitor_site_visit_UQ1;
Alter table study_setup_event drop constraint study_setup_event_UQ1;



Alter table general_event add constraint general_event_pk primary key (event_core_id)
	using index tablespace ftsmall_indx pctfree 20 nologging;

Alter table subject_encounter add constraint subject_encounter_pk primary key (event_core_id)
	using index tablespace ftlarge_indx pctfree 20 nologging;

Alter table monitor_site_visit add constraint monitor_site_visit_pk primary key (event_core_id)
	using index tablespace ftsmall_indx pctfree 20 nologging;

Alter table study_setup_event add constraint study_setup_event_pk primary key (event_core_id)
	using index tablespace ftsmall_indx pctfree 20 nologging;

Alter table protocol_evgroup_inst add constraint protocol_evgroup_inst_pk primary key (event_core_id)
	using index tablespace ftsmall_indx pctfree 20 nologging;

Alter table unencoded_event add constraint unencoded_event_pk primary key (event_core_id)
	using index tablespace ftsmall_indx pctfree 20 nologging;


Alter table subject_encounter drop  constraint subject_encounter_fk5;


Alter table subject_encounter add constraint
        subject_encounter_fk5 foreign key (Parent_peg_inst_id)
        references protocol_evgroup_inst(event_core_id);

Alter table protocol_evgroup_inst drop constraint protocol_evgroup_inst_fk2;

Alter table protocol_evgroup_inst add constraint
        protocol_evgroup_inst_fk2 foreign key (Parent_peginst_id)
        references protocol_evgroup_inst(event_core_id);

Alter table setup_event_mon_instance add (mon_site_visit_event_core_id  number(10));

Alter table setup_event_mon_instance add (study_setup_event_core_id  number(10));


Alter trigger SETUP_EVENT_MON_INSTANCE_TRG1 disable;

update setup_event_mon_instance a set a.MON_SITE_VISIT_EVENT_CORE_ID = (
	select b.event_core_id from monitor_site_visit_backup b where
	b.id=a.MONITOR_SITE_VISIT_ID  );

update setup_event_mon_instance a set a.study_setup_event_core_id = (
	select b.event_core_id from study_setup_event_backup b where
	b.id=a.STUDY_SETUP_EVENT_ID  );


Alter table setup_event_mon_instance modify(
	MON_SITE_VISIT_EVENT_CORE_ID not null,
	STUDY_SETUP_EVENT_CORE_ID not null);

Alter table setup_event_mon_instance add constraint setup_event_mon_instance_fk2
	foreign key(MON_SITE_VISIT_EVENT_CORE_ID) references 
        monitor_site_visit(event_core_id);

Alter table setup_event_mon_instance add constraint setup_event_mon_instance_fk3
	foreign key(STUDY_SETUP_EVENT_CORE_ID) references 
        study_setup_event(event_core_id);


Alter table setup_event_mon_instance drop constraint setup_event_mon_instance_uq1;

Alter table setup_event_mon_instance add constraint setup_event_mon_instance_uq1
	unique (MON_SITE_VISIT_EVENT_CORE_ID, STUDY_SETUP_EVENT_CORE_ID) using index tablespace 
	ftsmall_indx pctfree 20 nologging;


Alter table setup_event_mon_instance  drop column MONITOR_SITE_VISIT_ID;
Alter table setup_event_mon_instance  drop column STUDY_SETUP_EVENT_ID;

drop table MONITOR_SITE_VISIT_backup;
drop table study_setup_event_backup;


Alter table subject_encounter drop constraint subject_encounter_fk4;
Alter table subject_encounter drop constraint subject_encounter_fk2;

Alter table subject_encounter add constraint subject_encounter_fk4
	foreign key (mon_site_visit_event_core_id) references 
	monitor_site_visit(event_core_id);

Alter table subject_encounter add constraint subject_encounter_fk2
	foreign key (resched_event_id) references 
	subject_encounter(event_core_id);


Alter table unencoded_event drop constraint unencoded_event_fk2;
Alter table unencoded_event drop constraint unencoded_event_fk3;
Alter table unencoded_event drop constraint unencoded_event_fk4;

Alter table unencoded_event add constraint unencoded_event_fk2
	foreign key (reschedule_id) references 
	unencoded_event(event_core_id);

Alter table unencoded_event add constraint unencoded_event_fk4
	foreign key (parent_peg_inst_id) references 
	protocol_evgroup_inst(event_core_id);

Alter table unencoded_event add( mon_site_visit_event_core_id number(10));

Update unencoded_event set mon_site_visit_event_core_id = monitor_visit_id;

Alter table unencoded_event add constraint unencoded_event_fk3
	foreign key (mon_site_visit_event_core_id) references 
	monitor_site_visit(event_core_id);

Alter table unencoded_event drop column monitor_visit_id;

Alter table unencoded_event add (resched_event_id number(10));

Update unencoded_event set resched_event_id = reschedule_id;

Alter table unencoded_event drop column reschedule_id;

Alter table unencoded_event add constraint unencoded_event_fk2
	foreign key (resched_event_id) references 
	unencoded_event(event_core_id);


-- Recreate the site migration procedure on 03/23/2001 at 11:40 AM

-- Following procedure is created for migrating sites

Create or replace procedure site_migration (siteid in varchar2) as

test_num  number(10);
mip misc_event_prototype.id%type;
ev1 event_core.id%type;
ev2 event_core.id%type;
ev3 event_core.id%type;
pegtopeg peg_to_peg.id%type;
ftuserid  ftuser.id%type;
pvid protocol_version.id%type;
nvdate subject.next_visit_date%type;

Cursor c1 is select id from subject where site_to_trial_id in (select id
                       from site_to_trial where site_id=siteid) and
                       subject_status in ('On Treatment','On Follow-Up','Screening') and
                       NEXT_VISIT_TYPE_ID is not null and
                       NEXT_VISIT_DATE is not null;
begin


For ix in c1 loop

     select count(*) into test_num from peg_to_peg a,subject b where
	a.protocol_version_id=b.protocol_version_id and
        b.id=ix.id and a.parent_evgroup_id is null;
  
   If test_num = 0 then

      dbms_output.put_line ('No peg_to_peg found...skipping subject_id '||ix.id);

   else

     select a.id into pegtopeg from peg_to_peg a,subject b where
	a.protocol_version_id=b.protocol_version_id and
        b.id=ix.id and a.parent_evgroup_id is null;

     select id into ftuserid from ftuser where  upper(name)='SYSTEM';    
     
     select event_core_seq.nextval into ev1 from dual;

     Insert into event_core values(ev1,pegtopeg,'Root Node',ftuserid,sysdate,'GRP',siteid,3,0);

     select protocol_version_id,next_visit_date into pvid,nvdate from subject where id=ix.id;


     Insert into protocol_evgroup_inst values(ev1,null,null,pvid,
                                       ix.id,1,'Site',0);

     Select min(id) into mip from misc_event_prototype where name='PEG for Unencoded Events';

     select event_core_seq.nextval into ev2 from dual;

     Insert into event_core values(ev2,mip,'PEG for Unencoded Events',ftuserid,sysdate,'GRP',siteid,3,0);  

     Insert into protocol_evgroup_inst values(ev2,ev1,null,pvid,
                                       ix.id,1,'Site',0);
           
     Select min(id) into mip from misc_event_prototype where name='1.3VisitMigrationInfo';

     select event_core_seq.nextval into ev3 from dual;

     Insert into event_core values(ev3,mip,'PEG for Unencoded Events',ftuserid,nvdate,'UNEV',siteid,3,0);

     Insert into unencoded_event values(ev3,
                                 decode(least(nvdate,sysdate),nvdate,'Completed','Scheduled'),
                                 null,'Not Tracked',null,null,0,'Site',ev2,1,ix.id,0);
  end if;
end loop;

commit;

end;
/

sho err


-- Following trigger was recreated after doing the modifications for kelly on 03/23/2001 at 13:30

create or replace trigger SETUP_EVENT_MON_INSTANCE_trg1
after insert or update on SETUP_EVENT_MON_INSTANCE 
referencing new as n old as o
for each row
declare

stt_thro_sse study_setup_event.site_to_trial_id%type;
stt_thro_msv monitor_site_visit.site_to_trial_id%type;
invalid_stt exception;

begin

    select site_to_trial_id into stt_thro_sse from study_setup_event where
           event_core_id = :n.STUDY_SETUP_EVENT_CORE_ID;

    If stt_thro_sse is not null then

       select site_to_trial_id into stt_thro_msv from monitor_site_visit where
           event_core_id = :n.MON_SITE_VISIT_EVENT_CORE_ID;

       If stt_thro_sse <> stt_thro_msv then 
          Raise invalid_stt;
       end if;
    end if;
exception

 when invalid_stt then
     Raise_application_error(-20037,'Invalid site_to_trial between monitor_site_visit and study_setup_event');

end;
/
sho err

-- Following trigger was rewritten after finding a bug in the counts on 03/26/2001 at 9:30 AM


create or replace trigger subject_status_trg1
after insert or update of subject_status on subject
referencing new as n old as o
for each row

begin

if inserting then
  if upper(:n.subject_status) in ('ON TREATMENT','ON FOLLOW-UP','COMPLETED','EARLY TERM-DIED',
                                  'EARLY TERM-LOST TO FOLLOW-UP','EARLY TERM-OTHER') then
  update site_to_trial set enrolledcnt=nvl(enrolledcnt,0)+1 where
  id = :n.site_to_trial_id;
  end if;
end if;

if updating then
  if upper(:o.subject_status) in ('ENTERED IN ERROR','NOT ASSIGNED','SCREENING','SCREEN FAILURE-DIED',
                                 'SCREEN FAILURE-NOT ELIGIBLE', 'SCREEN FAILURE-OTHER')
  and upper(:n.subject_status) in ('ON TREATMENT','ON FOLLOW-UP','COMPLETED','EARLY TERM-DIED',
                                  'EARLY TERM-LOST TO FOLLOW-UP','EARLY TERM-OTHER') then
     update site_to_trial set enrolledcnt=nvl(enrolledcnt,0)+1 where
     id = :o.site_to_trial_id;
  end if;

  if upper(:n.subject_status) in ('ENTERED IN ERROR','NOT ASSIGNED','SCREENING','SCREEN FAILURE-DIED',
                                 'SCREEN FAILURE-NOT ELIGIBLE', 'SCREEN FAILURE-OTHER')
  and upper(:o.subject_status) in ('ON TREATMENT','ON FOLLOW-UP','COMPLETED','EARLY TERM-DIED',
                                  'EARLY TERM-LOST TO FOLLOW-UP','EARLY TERM-OTHER') then
     update site_to_trial set enrolledcnt=nvl(enrolledcnt,0)-1 where
     id = :n.site_to_trial_id;
  end if;
end if;

  if upper(:n.subject_status) = 'NOT ASSIGNED'  then
     update site_to_trial set NOTASSIGNEDCNT=nvl(NOTASSIGNEDCNT,0)+1 where
     id = :n.site_to_trial_id;
  elsif upper(:n.subject_status) = 'SCREENING'  then
     update site_to_trial set SCREENINGCNT=nvl(SCREENINGCNT,0)+1 where
     id = :n.site_to_trial_id;
  elsif upper(:n.subject_status) = 'ON TREATMENT'  then
     update site_to_trial set ONTREATMENTCNT=nvl(ONTREATMENTCNT,0)+1 where
     id = :n.site_to_trial_id;
  elsif upper(:n.subject_status) = 'ON FOLLOW-UP'  then
     update site_to_trial set ONFOLLOWUPCNT=nvl(ONFOLLOWUPCNT,0)+1 where
     id = :n.site_to_trial_id;
  elsif upper(:n.subject_status) = 'COMPLETED'  then
     update site_to_trial set COMPLETEDCNT=nvl(COMPLETEDCNT,0)+1 where
     id = :n.site_to_trial_id;
  elsif upper(:n.subject_status) = 'SCREEN FAILURE-DIED'  then
     update site_to_trial set SCREENFAILURECNT_DIED=nvl(SCREENFAILURECNT_DIED,0)+1 where
     id = :n.site_to_trial_id;
  elsif upper(:n.subject_status) = 'SCREEN FAILURE-NOT ELIGIBLE'  then
     update site_to_trial set SCREENFAILURECNT_NOTELIGIBLE=nvl(SCREENFAILURECNT_NOTELIGIBLE,0)+1 where
     id = :n.site_to_trial_id;
  elsif upper(:n.subject_status) = 'SCREEN FAILURE-OTHER'  then
     update site_to_trial set SCREENFAILURECNT_OTHER=nvl(SCREENFAILURECNT_OTHER,0)+1 where
     id = :n.site_to_trial_id;
  elsif upper(:n.subject_status) = 'EARLY TERM-DIED' then
     update site_to_trial set EARLYTERMCNT_DIED=nvl(EARLYTERMCNT_DIED,0)+1 where
     id = :n.site_to_trial_id;
  elsif upper(:n.subject_status) = 'EARLY TERM-LOST TO FOLLOW-UP' then
     update site_to_trial set EARLYTERMCNT_LOSTTOFOLLOWUP=nvl(EARLYTERMCNT_LOSTTOFOLLOWUP,0)+1 where
     id = :n.site_to_trial_id;
  elsif upper(:n.subject_status) = 'EARLY TERM-OTHER'  then
     update site_to_trial set EARLYTERMCNT_OTHER=nvl(EARLYTERMCNT_OTHER,0)+1 where
     id = :n.site_to_trial_id;
  end if;

  if upper(:o.subject_status) = 'NOT ASSIGNED' then
     update site_to_trial set NOTASSIGNEDCNT=nvl(NOTASSIGNEDCNT,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'SCREENING'  then
     update site_to_trial set SCREENINGCNT=nvl(SCREENINGCNT,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'ON TREATMENT' then
     update site_to_trial set ONTREATMENTCNT=nvl(ONTREATMENTCNT,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'ON FOLLOW-UP' then
     update site_to_trial set ONFOLLOWUPCNT=nvl(ONFOLLOWUPCNT,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'COMPLETED' then
     update site_to_trial set COMPLETEDCNT=nvl(COMPLETEDCNT,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'SCREEN FAILURE-DIED' then
     update site_to_trial set SCREENFAILURECNT_DIED=nvl(SCREENFAILURECNT_DIED,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'SCREEN FAILURE-NOT ELIGIBLE' then
     update site_to_trial set SCREENFAILURECNT_NOTELIGIBLE=nvl(SCREENFAILURECNT_NOTELIGIBLE,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'SCREEN FAILURE-OTHER' then
     update site_to_trial set SCREENFAILURECNT_OTHER=nvl(SCREENFAILURECNT_OTHER,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'EARLY TERM-DIED' then
     update site_to_trial set EARLYTERMCNT_DIED=nvl(EARLYTERMCNT_DIED,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'EARLY TERM-LOST TO FOLLOW-UP'  then
     update site_to_trial set EARLYTERMCNT_LOSTTOFOLLOWUP=nvl(EARLYTERMCNT_LOSTTOFOLLOWUP,0)-1 where
     id = :o.site_to_trial_id;
  elsif upper(:o.subject_status) = 'EARLY TERM-OTHER' then
     update site_to_trial set EARLYTERMCNT_OTHER=nvl(EARLYTERMCNT_OTHER,0)-1 where
     id = :o.site_to_trial_id;
  end if;
end;
/

-- Foloowing changes are made as per the request of Allen/Peter on 03/26/2001 at 6 PM

Alter table unencoded_event drop constraint UNENCOD_EVNT_ENC_STATUS_CHECK;

Alter table unencoded_event add constraint UNENCOD_EVNT_ENC_STATUS_CHECK 
	check ( Encounter_status in ('Completed','Missed','Rescheduled','Inprogress',
       'Scheduled','Toreschedule','Projected','NA','Entered In Error', 'Invalid',
       'Monitor Created' ));

Alter table SUBJECT_ENCOUNTER drop constraint SUB_ENC_ENC_STATUS_CHECK;

Alter table SUBJECT_ENCOUNTER add constraint SUB_ENC_ENC_STATUS_CHECK 
	check ( Encounter_status in ('Completed','Missed','Rescheduled','Inprogress',
       'Scheduled','Toreschedule','Projected','NA','Entered In Error', 'Invalid',
       'Monitor Created' ));


-- Following changes are made as per the request of Kelly on 03/26/2001 at 6PM

create table site_to_trial_pv_history (
	id number(10),
	site_to_trial_id number(10) not null,
        protocol_version_id number(10) not null,
        pv_change_date date default sysdate not null)
        tablespace ftlarge pctused 70 pctfree 20;

Alter table site_to_trial_pv_history add constraint site_to_trial_pv_history_pk
	primary key (id) using index tablespace ftlarge_indx 
	pctfree 20 nologging;

Alter table site_to_trial_pv_history add constraint site_to_trial_pv_history_fk1
	foreign key (site_to_trial_id) references site_to_trial(id);

Alter table site_to_trial_pv_history add constraint site_to_trial_pv_history_fk2
	foreign key (protocol_version_id) references protocol_version(id);

	
Alter table patient add (create_dt date default sysdate);
Alter table subject add (create_dt date default sysdate);

create table ftuser_login_history (
	id number(10),
	ftuser_id number(10) not null,
        last_login_change_date date default sysdate not null)
        tablespace ftlarge pctused 70 pctfree 20;

Alter table ftuser_login_history add constraint ftuser_login_history_pk
	primary key (id) using index tablespace ftlarge_indx 
	pctfree 20 nologging;

Alter table ftuser_login_history add constraint ftuser_login_history_fk1
	foreign key (ftuser_id) references ftuser(id);


create or replace trigger stt_update_pv_trg1
after update of protocol_version_id on site_to_trial
referencing new as n old as o
for each row
begin

   If :n.protocol_version_id <> :o.protocol_version_id then

  update subject set protocol_version_id = :n.protocol_version_id 
	where protocol_version_id = :o.protocol_version_id and 
        subject_status in ('Screening',  'On Treatment','On Follow-Up');


  Insert into site_to_trial_pv_history values (
	site_to_trial_pv_history_seq.nextval, :o.id,:o.protocol_version_id,sysdate);

 end if;

end;
/
sho err

create or replace trigger subject_last_modified_trg1
before insert or update on Subject
referencing new as n old as o
for each row
begin
 :n.last_modified_date:=sysdate ;

 If inserting then 
	:n.create_dt:=sysdate ;
 end if;

end;
/
sho err

create or replace trigger patient_create_trg2
before  insert on patient
referencing new as n old as o
for each row
begin

:n.create_dt:=sysdate;

end;
/
sho err

Create or replace trigger ftuser_last_login_history_trg2  
after update of last_login_date on ftuser
referencing new as n old as o
for each row
 

begin


 If :n.last_login_date is not null or :o.last_login_date is not null then

 if :n.last_login_date is not null and :o.last_login_date is not null and :n.last_login_date <> :o.last_login_date then

 Insert into ftuser_login_history values (
       ftuser_login_history_seq.nextval,:o.id,sysdate);
  
 elsif  :n.last_login_date is null or :o.last_login_date is  null then
 
 Insert into ftuser_login_history values (
       ftuser_login_history_seq.nextval,:o.id,sysdate);
 end if;
 
 end if; 

end;
/
sho err

-- Following lines were added as per the request of Kelly on 03/27/2001 at 12:20 PM for ECR 42

Alter table Protocol_Event add (is_milestone number(1) default 0);

Update Protocol_event set is_milestone = 0;

Alter table Protocol_event modify (is_milestone not null);

Alter table protocol_event add constraint protocol_event_milestone_check
	check (is_milestone in (0,1));

-- Following changes are done for Kelly on kkingdon14 schema on 03/28/2001 at 15:40 
-- made official on 5/7/01 by kelly (uncommented it from script)

Alter table CRA_MANAGER_TO_MONITOR drop constraint CRA_MANAGER_TO_MONITOR_FK1;

Create or replace trigger cra_manager_to_monitor_trg1  
after insert or update on cra_manager_to_monitor
referencing new as n old as o
for each row
declare
v_cnt number(10);
tmp_exception exception;

begin

 select count(*) into v_cnt from monitor where ftuser_id=:n.manager_ftuser_id;

 if v_cnt=0 then
   raise tmp_exception;
 end if;

exception

when tmp_exception then
   Raise_application_error(-20499,'Temporary restriction to check proper monitor ftuser_id instead of constraint');

end ;
/
sho err




-- Following changes are done as per the request of kelly on 03/28/2001 at 16:30


Alter table peg_to_event DROP constraint peg_to_event_tu_check;

Alter table peg_to_event add constraint peg_to_event_tu_check
        check (time_unit in ('y','m','w','d','h','M'));

Alter table peg_to_event drop constraint peg_to_event_fk4;
 
Alter table peg_to_event add constraint peg_to_event_fk4 
	foreign key (anchor_event_id ) references protocol_event (id);



-- Following triggers are added as per the findings of data inconsistencies on 03/13/2001 at 10 AM


create or replace trigger Subject_site_check_trg1
before insert or update of site_to_trial_id,patient_id, 
assigned_cc_id on Subject
referencing new as n old as o
for each row

declare

site_thro_patient site.id%type;
site_thro_site_to_trial  site.id%type;
site_thro_ftuser site.id%type;
Invalid_site exception;
Invalid_subject_id exception;
Invalid_cc exception;
trial_thro_stt site_to_trial.trial_id%type;
trial_thro_pv protocol_version.trial_id%type;

Invalid_trial exception;


begin

  
   Select b.id into site_thro_patient from patient a, site b
      where a.site_id = b.id and  a.id = :n.patient_id;
   Select b.id into site_thro_site_to_trial from site_to_trial a, site b
     where a.site_id = b.id and  a.id = :n.site_to_trial_id;

   If site_thro_patient <> site_thro_site_to_trial then
     Raise  Invalid_site;
   end if;
   


   If :n.subject_id is null and :n.screening_id is null then 
     Raise Invalid_subject_id;
   end if;


    
   If :n.protocol_version_id is not null then

      Select trial_id into trial_thro_stt from site_to_trial 
         where id = :n.site_to_trial_id;
       
      Select trial_id into trial_thro_pv from protocol_version
         where id = :n.protocol_version_id;

      If  trial_thro_pv is not null and  trial_thro_stt <> trial_thro_pv then
        Raise Invalid_trial;

      end if;
   end if;
   
   If :n.assigned_cc_id is not null then

     select site_id into site_thro_ftuser from ftuser where id=:n.assigned_cc_id ;

     If site_thro_ftuser is not null and site_thro_ftuser <> site_thro_site_to_trial then
        Raise invalid_cc;
     end if;
   end if;
  

Exception

  When Invalid_site then
       Raise_application_error(-20001,'Data inconsistency between patient_id and site_to_trial_id');
  When Invalid_subject_id then
       Raise_application_error(-20021,'Both subject_id and screening_id can not be null');
  When Invalid_trial then
       Raise_application_error(-20032,'Not a valid trial between site_to_trial and protcol_version');
  when invalid_cc then 
       Raise_application_error(-20033,'Site_id invalid between assigned_cc and site_to_trial');
end;
/

sho err


-- Following changes are done as per the request of Phil on 03/29/2001 at 11 AM

Alter table site add (confidentiality_message varchar2(2000));
Alter table sponsor add (confidentiality_message varchar2(2000));

-- Following changes are done as per the request of Colin on 03/29/2001 at 11 AM



CREATE TABLE HANDHELD_USE_history(
 	ID  NUMBER(10) ,
	DEVICE_ID  VARCHAR2(80) NOT NULL,
	SITE_TO_TRIAL_ID  NUMBER(10),
	TIME_OF_PAGE_LOAD  DATE NOT NULL,
	VIEWED_URL  VARCHAR2(256) NOT NULL,
	APPLICATION_NAME  VARCHAR2(256) NOT NULL)
        tablespace ftlarge pctused 70 pctfree 20;

Alter table HANDHELD_USE_history add constraint HANDHELD_USE_history_pk
	primary key (id) using index tablespace ftlarge_indx 
	pctfree 20 nologging;


-- Following changes were done as per the request from MAtt on 03/29/2001 at 14:45 pm

Alter table monitor drop constraint monitor_cra_type_check;

Alter table monitor add constraint monitor_cra_type_check
	check( cra_type in ('Contractor','Regional','Inhouse','CRO'));


-- Following trigger was written after finding the bug in it with Peter on 03/29/2001 at 17:45 pm

create or replace trigger unencoded_event_trg1
after insert or delete or update of event_core_id on unencoded_event 
referencing new as n old as o
for each row
declare

invalid_event exception;
template event_core.template_type%type;
invalid_subject exception;
subject_id_v1 protocol_evgroup_inst.subject_id%type;
site_thro_stt site_to_trial.site_id%type;
site_thro_ev_core  event_core.site_id%type;
Invalid_site exception;

begin

If inserting or updating then

 select template_type into template from event_core where  id = :n.event_core_id;

 If upper(template) <> 'UNEV' then
    raise invalid_event;
 end if;



 Select subject_id into subject_id_v1 from protocol_evgroup_inst 
 	where event_core_id=:n.parent_peg_inst_id;
   If  subject_id_v1 <> :n.subject_id then
   	raise invalid_subject;
   end if;
 
 select  b.site_id into site_thro_stt from subject a, site_to_trial b where
    a.site_to_trial_id=b.id and a.id= :n.subject_id;

 select site_id into site_thro_ev_core from event_core where 
    id=:n.event_core_id;

  If site_thro_stt <> site_thro_ev_core then 
        Raise Invalid_site;
  End if;

end if;

 If deleting then
   delete from event_core where id=:o.event_core_id; 
 end if;


exception

 when invalid_event then
     Raise_application_error(-20018,'Invalid template type in event_core. It must point to UNEV');
 when invalid_subject then
     Raise_application_error(-20023,'Different subject in parent event');
 when invalid_site then
     Raise_application_error(-20039,'Invalid site between event_core and subject');


end;
/
sho err

-- Following chnages are as per the request of Joel on 04/02/2001 at 9:15 AM

Alter table handheld_use_history add(ftuser_id  number(10));

-- Following chnages are as per the request of Allen on 04/02/2001 at 9:45 AM

Alter table subject add (site_note varchar2(255));

-- Following chnages are added as per the discussion with colin on 04/02/2001 at 10:45 AM

Alter table handheld_device modify (device_id varchar2(255));

-- Alter table handheld_device add constraint handheld_device_fk3 
--	foreign key (device_id) references ftuser (name);


-- Following trigger was created as per the bug identified by Casey

create or replace trigger handheld_device_trg1
after insert or update on handheld_device
referencing new as n old as o
for each row
declare

relation_check exception;
relation_exist exception;
v_cnt number(10);
v_site1  ftuser.site_id%type;
v_sponsor1 ftuser.sponsor_id%type;
v_site2  ftuser.site_id%type;
v_sponsor2 ftuser.sponsor_id%type;
Invalid_site exception;
Invalid_sponsor exception;


begin

If :n.handheld_group_id is not null and :n.ftuser_id is not null then
     raise relation_check;
end if;

 Select count(*) into v_cnt from ftuser where name= :n.device_id;

     If v_cnt = 1 and :n.ftuser_id is not null then

        select  site_id, sponsor_id into v_site1, v_sponsor1 from ftuser where name=:n.device_id;
        
        select  site_id, sponsor_id into v_site2, v_sponsor2 from ftuser where id=:n.ftuser_id;

        
           If v_site1 is not null and v_site2 is not null and v_site1 <> v_site2 then
                 raise Invalid_site;
           end if;


           If v_sponsor1 is not null and v_sponsor2 is not null and v_sponsor1 <> v_sponsor2 then
                 raise Invalid_sponsor;
           end if;

      end if;


exception

When relation_check then
     Raise_application_error(-20007,'Handheld device can not be related to both ftuser and handheld group');

When Invalid_site then
     Raise_application_error(-20044,'Site_id does not match for the ftuser_id and device_id');

When Invalid_sponsor then
     Raise_application_error(-20045,'Sponsor_id does not match for the ftuser_id and device_id');

end;
/
sho err


create or replace trigger monitor_site_visit_trg2
after insert or update  on monitor_site_visit 
referencing new as n old as o
for each row
declare

v_sponsor1 trial.sponsor_id%type;
v_sponsor2 ftuser.sponsor_id%type;
invalid_sponsor exception;

begin

 Select sponsor_id into v_sponsor1 from trial where id = (select trial_id
       from site_to_trial where id = :n.site_to_trial_id);

 Select sponsor_id into v_sponsor2 from ftuser where id = :n.ftuser_id;

 If v_sponsor1 is not null and v_sponsor2 is not null  and  v_sponsor1 <> v_sponsor2  then
    raise Invalid_sponsor;
 end if;

exception

when invalid_sponsor then
     Raise_application_error(-20046,'Invalid sponsor between site_to_trial and ftuser');

end;
/
sho err



-- Following changes are made as per the request of Phil on 04/02/2001 at 5.50 PM


Alter table sponsor add (sponsor_acronym VARCHAR2(20));
update sponsor set sponsor_acronym = 'FT';
Alter table sponsor modify  (sponsor_acronym not null);


-- Following changes were done as per the request of Colin on 04/03/2001 at 16:00


Delete from ftuser_trial_filter where not rowid in (select min(rowid)
from ftuser_trial_filter group by FTUSER_ID,TRIAL_ID);


Alter table ftuser_trial_filter add constraint ftuser_trial_filter_uq1
unique (FTUSER_ID,TRIAL_ID) using index tablespace ftsmall_indx
pctfree 20 nologging;


-- Following changes are done as per the request of Allen on 04/03/2001 at 16:20 

Alter table subject add (sponsor_note varchar2(255));

update subject set sponsor_note=site_note;

-- Alter table subject drop column site_note;

-- Following channges are as per the request of Kelly on 04/04/2001 at 8:25 AM

create or replace view Monitor_Name as
select ID, last_name, first_name from ftuser, monitor where monitor.ftuser_id=ftuser.ID;

Insert into ft_foreign_key_info values(ft_foreign_key_info_seq.nextval,'MONITOR_NAME','ID','MONITOR_SITE_VISIT','FTUSER_ID');



update site set CONFIDENTIALITY_MESSAGE = 'This application contains confidential information
that may not be accessed or disclosed to anyone other than individuals who are currently under
contract to perform clinical trial services. The information contained in this application
may not be used for any purpose other than the conduct of clinical investigations.' where
CONFIDENTIALITY_MESSAGE is null;


update sponsor set CONFIDENTIALITY_MESSAGE = 'This application contains confidential 
information that may not be accessed or disclosed to anyone other than individuals who 
are currently under contract to perform clinical trial services. The information contained 
in this application may not be used for any purpose other than the conduct of clinical 
investigations.' where CONFIDENTIALITY_MESSAGE is null;



Alter table site modify (confidentiality_message not null);

Alter table sponsor modify (confidentiality_message not null);


create or replace trigger site_trg2 
before insert or update of confidentiality_message on site
referencing new as n old as o
for each row

declare

var1 varchar2(2000);
var2 varchar2(2000);
var3 varchar2(2000);
var4 varchar2(2000);

begin

  If :n.confidentiality_message is null then 


  var1:= 'This application contains confidential information that may not be accessed';
  var2:= ' or disclosed to anyone other than individuals who are currently under contract';
  var3:= ' to perform clinical trial services. The information contained in this application';
  var4:= ' may not be used for any purpose other than the conduct of clinical investigations.';

  :n.confidentiality_message := var1||var2||var3||var4 ;

  end if;

end ;
/

sho err


create or replace trigger sponsor_trg2 
before insert or update of confidentiality_message on sponsor
referencing new as n old as o
for each row

declare

var1 varchar2(2000);
var2 varchar2(2000);
var3 varchar2(2000);
var4 varchar2(2000);

begin

  If :n.confidentiality_message is null then 

  var1:= 'This application contains confidential information that may not be accessed';
  var2:= ' or disclosed to anyone other than individuals who are currently under contract';
  var3:= ' to perform clinical trial services. The information contained in this application';
  var4:= ' may not be used for any purpose other than the conduct of clinical investigations.';

  :n.confidentiality_message := var1||var2||var3||var4 ;


  end if;

end ;
/

sho err


-- Following changes are done as per the request of Peter on 04/05/2001 at 9:30 AM

Alter table subject_encounter add(pref_date date, pref_date_precision number(3));


Alter trigger peg_to_event_trg1 disable;

Alter table peg_to_event add (dominant number(1) default 0);

Alter table peg_to_event add constraint peg_to_event_dominant_check 
	check (dominant in (0,1));

Update peg_to_event set dominant=0;

Alter table peg_to_event modify (dominant not null);

Alter trigger peg_to_event_trg1 enable;


-- Following changes are as per the request from Kelly on 04/05/2001 at 9:45 AM

alter table FTUSER_TACLASSIFIER_FILTER add constraint FTUSER_TACLASSIFIER_FILTER_uq1
unique(FTUSER_ID,TACLASSIFIER_ID) using index tablespace ftsmall_indx pctfree 20
nologging;

alter table FTUSER_LOGIN_HISTORY drop constraint FTUSER_LOGIN_HISTORY_FK1;

alter table SITE_TO_TRIAL_PV_HISTORY drop constraint SITE_TO_TRIAL_PV_HISTORY_FK1;

alter table SITE_TO_TRIAL_PV_HISTORY drop constraint SITE_TO_TRIAL_PV_HISTORY_FK2;


Alter table peg_to_event modify (DOMINANT null);


-- Following changes are as per the request of matt on 04/06/2001 at 11:15 AM

Alter table monitor_site_visit drop constraint MON_SITE_VISIT_STATUS_CHECK;

Update monitor_site_visit set status='Complete' where status <> 'Pending' and end_date is not null;
Update monitor_site_visit set status='Pending' where status <> 'Pending' and end_date is null;

Alter table monitor_site_visit add constraint MON_SITE_VISIT_STATUS_CHECK check(
	status in ('Complete','Pending'));

-- Following changes are as per the request from Kelly on 04/11/2001 at 14:30 hrs

Alter table subject drop constraint SUBJECT_SUBJECT_STATUS_CHECK;

update subject set subject_status='Entered In Error' where subject_status='Entered in Error';


alter table subject add constraint SUBJECT_SUBJECT_STATUS_CHECK
	check (SUBJECT_STATUS in ('Not Assigned','Screening',
	'On Treatment','On Follow-Up','Completed','Screen Failure-Died',
	'Screen Failure-Not Eligible','Screen Failure-Other',
	'Early Term-Died','Early Term-Lost To Follow-Up',
	'Early Term-Other','Entered In Error'));

Alter table trial add constraint trial_ACCRUAL_STATUS_CHECK check (
	accrual_status in ('ACTIVE','HOLD','CLOSED','TESTING'));

Alter table handheld_device modify (HH_TYPE null);


-- Following lines were added as per the request of Colin on 04/16/2001 at 11 AM

Alter table ftgroup drop constraint ftgroup_name_check;

Alter table ftgroup add constraint ftgroup_name_check check (
name in ('Fast Track Administrator','Site Administrator',
'Sponsor Administrator','Site User','CRA','CRA Manager', 
'Site Handheld','CRA Handheld'));

Insert into Ftgroup values (7,'Site Handheld');
Insert into Ftgroup values (8, 'CRA Handheld');

drop sequence ftgroup_seq;
create sequence ftgroup_seq start with 9;


-- Following changes are done as per the request of Nancy on 04/17/2001 at 11:35 AM 

Alter table unencoded_event drop constraint unencoded_event_fk2;
Alter table unencoded_event add constraint unencoded_event_fk2
	foreign key (resched_event_id) references 
	unencoded_event(event_core_id) ON DELETE CASCADE;

Alter table subject_encounter drop constraint subject_encounter_fk2;
Alter table subject_encounter add constraint subject_encounter_fk2
	foreign key (resched_event_id) references 
	subject_encounter(event_core_id) ON DELETE CASCADE;

Alter table unencoded_event drop constraint unencoded_event_fk4;
Alter table unencoded_event add constraint unencoded_event_fk4
	foreign key (parent_peg_inst_id) references 
	protocol_evgroup_inst(event_core_id) ON DELETE CASCADE;

Alter table subject_encounter drop constraint subject_encounter_fk5;
Alter table subject_encounter add constraint
        subject_encounter_fk5 foreign key (Parent_peg_inst_id)
        references protocol_evgroup_inst(event_core_id) ON DELETE CASCADE;

Alter table protocol_evgroup_inst drop constraint protocol_evgroup_inst_fk2;
Alter table protocol_evgroup_inst add constraint
        protocol_evgroup_inst_fk2 foreign key (Parent_peginst_id)
        references protocol_evgroup_inst(event_core_id) ON DELETE CASCADE;

Alter table setup_event_mon_instance drop constraint setup_event_mon_instance_fk3;
Alter table setup_event_mon_instance add constraint setup_event_mon_instance_fk3
	foreign key(STUDY_SETUP_EVENT_CORE_ID) references 
        study_setup_event(event_core_id) ON DELETE CASCADE;

Alter table unencoded_event drop constraint unencoded_event_fk3;
Alter table unencoded_event add constraint unencoded_event_fk3
	foreign key (mon_site_visit_event_core_id) references 
	monitor_site_visit(event_core_id) ON DELETE CASCADE;

Alter table subject_encounter drop constraint subject_encounter_fk4;
Alter table subject_encounter add constraint subject_encounter_fk4
	foreign key (mon_site_visit_event_core_id) references 
	monitor_site_visit(event_core_id) ON DELETE CASCADE;

Alter table setup_event_mon_instance drop constraint setup_event_mon_instance_fk2;
Alter table setup_event_mon_instance add constraint setup_event_mon_instance_fk2
	foreign key(MON_SITE_VISIT_EVENT_CORE_ID) references 
        monitor_site_visit(event_core_id) ON DELETE CASCADE;

Alter table unencoded_event drop constraint unencoded_event_fk5;
Alter table unencoded_event add constraint 
	unencoded_event_fk5 foreign key (subject_id)
	references subject(id) ON DELETE CASCADE;

Alter table subject_encounter drop constraint subject_encounter_fk6;
Alter table subject_encounter add constraint 
        subject_encounter_fk6 foreign key (subject_id)  
        references subject(id) ON DELETE CASCADE;

Alter table protocol_evgroup_inst drop constraint protocol_evgroup_inst_fk4;
Alter table protocol_evgroup_inst add constraint 
        protocol_evgroup_inst_fk4 foreign key (subject_id)  
        references subject(id) ON DELETE CASCADE;

Alter table monitor_to_site_to_trial drop constraint monitor_to_site_to_trial_fk2;
Alter table monitor_to_site_to_trial add constraint 
        monitor_to_site_to_trial_fk2 foreign key (site_to_trial_id)  
        references site_to_trial(id) ON DELETE CASCADE;

Alter table monitor_site_visit drop constraint monitor_site_visit_fk3;
Alter table monitor_site_visit add constraint 
        monitor_site_visit_fk3 foreign key (site_to_trial_id)  
        references site_to_trial(id) ON DELETE CASCADE;





-- Following changes were done for Collin on 04/18/2001 at 4 PM


create table D_ftuser(id number(10)) tablespace ftsmall;

Create or replace procedure delete_site (siteid in varchar2) as

begin

Delete from  setup_event_mon_instance where mon_site_visit_event_core_id in (select
	id from event_core where site_id=siteid);
Delete from  setup_event_mon_instance where study_setup_event_core_id in (select
	id from event_core where site_id=siteid);
Delete from  general_event where event_core_id in (select 
	id from event_core where site_id=siteid);
Delete from  monitor_site_visit where event_core_id in (select 
	id from event_core where site_id=siteid); 
Delete from  study_setup_event where event_core_id in (select 
	id from event_core where site_id=siteid); 
Delete from  subject_encounter where event_core_id in (select 
	id from event_core where site_id=siteid); 
Delete from  protocol_evgroup_inst where event_core_id in (select 
	id from event_core where site_id=siteid); 
Delete from  unencoded_event where event_core_id in (select 
	id from event_core where site_id=siteid); 
Delete from  cra_manager_to_monitor where ftuser_id in (select
	id from ftuser where site_id=siteid);
Delete from  cra_manager_to_monitor where manager_ftuser_id in (select
	id from ftuser where site_id=siteid);
Delete from  cra_manager_to_trial where manager_ftuser_id in (select
	id from ftuser where site_id=siteid);
Delete from  ftuser_taclassifier_filter where ftuser_id in (select
	id from ftuser where site_id=siteid); 
Delete from  ftuser_to_aclentries where ftuser_id in (select
	id from ftuser where site_id=siteid); 
Delete from  ftuser_to_ftgroup where ftuser_id in (select
	id from ftuser where site_id=siteid); 
Delete from  ftuser_trial_filter where ftuser_id in (select
	id from ftuser where site_id=siteid); 
Delete from hhgroup_to_classifiers where handheld_group_id in (select
	id from handheld_group where site_id=siteid);
Delete from  handheld_device where ftuser_id in (select
	id from ftuser where site_id=siteid);
Delete from  handheld_device where device_id in (select
	name from ftuser where site_id=siteid);
Delete from  handheld_device where handheld_group_id in (select
	id from handheld_group where site_id=siteid);
Delete from  monitor where ftuser_id in (select
	id from ftuser where site_id=siteid); 
Delete from  monitor_to_site_to_trial where ftuser_id in (select
	id from ftuser where site_id=siteid);
Delete from  monitor_to_site_to_trial where site_to_trial_id in (select
	id from site_to_trial where site_id=siteid);
Delete from  subject where site_to_trial_id in (select
	id from site_to_trial where site_id=siteid);
Delete from  subject where site_to_trial_id in (select
	id from site_to_trial where cc_ftuser_id in (select 
	id from ftuser where site_id=siteid));
Delete from  subject where site_to_trial_id in (select
	id from site_to_trial where pi_ftuser_id in (select 
	id from ftuser where site_id=siteid));
Delete from  medical_record_number where patient_id in (select
	id from patient where site_id=siteid);
Delete from  site_to_trial where site_id = siteid;
Delete from  site_to_trial where cc_ftuser_id in (select 
	id from ftuser where site_id=siteid);
Delete from  site_to_trial where pi_ftuser_id in (select 
	id from ftuser where site_id=siteid);
Delete from  patient where  site_id = siteid;
Delete from  event_core where site_id = siteid; 
Delete from handheld_group where site_id=siteid;
Delete from d_ftuser;
Insert into d_ftuser select id from ftuser where site_id=siteid;
Update ftuser set site_id=null where site_id=siteid;
Delete from site where id=siteid;
Delete from  ftuser where id in (select id from d_ftuser);
Delete from d_ftuser;

end;
/


-- Recreated the procedure for changes in unenecoded_event table on 04/19/2001 at 18:30

Create or replace procedure site_migration (siteid in varchar2) as

test_num  number(10);
mip misc_event_prototype.id%type;
ev1 event_core.id%type;
ev2 event_core.id%type;
ev3 event_core.id%type;
pegtopeg peg_to_peg.id%type;
ftuserid  ftuser.id%type;
pvid protocol_version.id%type;
nvdate subject.next_visit_date%type;

Cursor c1 is select id from subject where site_to_trial_id in (select id
                       from site_to_trial where site_id=siteid) and
                       subject_status in ('On Treatment','On Follow-Up','Screening') and
                       NEXT_VISIT_TYPE_ID is not null and
                       NEXT_VISIT_DATE is not null;
begin


For ix in c1 loop

     select count(*) into test_num from peg_to_peg a,subject b where
	a.protocol_version_id=b.protocol_version_id and
        b.id=ix.id and a.parent_evgroup_id is null;
  
   If test_num = 0 then

      dbms_output.put_line ('No peg_to_peg found...skipping subject_id '||ix.id);

   else

     select a.id into pegtopeg from peg_to_peg a,subject b where
	a.protocol_version_id=b.protocol_version_id and
        b.id=ix.id and a.parent_evgroup_id is null;

     select id into ftuserid from ftuser where  upper(name)='SYSTEM';    
     
     select event_core_seq.nextval into ev1 from dual;

     Insert into event_core values(ev1,pegtopeg,'Root Node',ftuserid,sysdate,'GRP',siteid,3,0);

     select protocol_version_id,next_visit_date into pvid,nvdate from subject where id=ix.id;


     Insert into protocol_evgroup_inst values(ev1,null,null,pvid,
                                       ix.id,1,'Site',0);

     Select min(id) into mip from misc_event_prototype where name='PEG for Unencoded Events';

     select event_core_seq.nextval into ev2 from dual;

     Insert into event_core values(ev2,mip,'PEG for Unencoded Events',ftuserid,sysdate,'GRP',siteid,3,0);  

     Insert into protocol_evgroup_inst values(ev2,ev1,null,pvid,
                                       ix.id,1,'Site',0);
           
     Select min(id) into mip from misc_event_prototype where name='1.3VisitMigrationInfo';

     select event_core_seq.nextval into ev3 from dual;

     Insert into event_core values(ev3,mip,'PEG for Unencoded Events',ftuserid,nvdate,'UNEV',siteid,3,0);

     Insert into unencoded_event values(ev3,
                                 decode(least(nvdate,sysdate),nvdate,'Completed','Scheduled'),
                                 'Not Tracked',null,1,'Site',ev2,1,ix.id,0,null,null); 

end if;
end loop;

commit;

end;
/

sho err


-- Following changes were done after discussing with Allen on 04/19/2001 at 18:30

Alter table subject drop column site_note;

-- Following changes were done as per request of kelly on 04/24/2001 at 17:30 hrs


Alter table subject drop column unmonitored_completed_visits;
Alter table site_to_trial drop column onstudycnt;
Alter table site_to_trial drop column earlytermcnt;
Alter table site_to_trial drop column losttofollowupcnt;

create or replace trigger subject_encounter_status_trg1
after insert or update on subject_encounter
referencing new as n old as o
for each row
begin

If inserting then

   If :n.encounter_status = 'Completed' then


	update subject set completed_encounters = completed_encounters+1
     	where id = :n.subject_id;

        If :n.time_period_category = 'Screening' then
		update subject set unmonitored_screening_visits =
		nvl(unmonitored_screening_visits,0) + 1 where id = :n.subject_id;
        elsif :n.time_period_category = 'Treatment' then
		update subject set unmonitored_treatment_visits =
		nvl(unmonitored_treatment_visits,0) + 1 where id = :n.subject_id;
        elsif :n.time_period_category = 'Followup' then
		update subject set unmonitored_followup_visits =
		nvl(unmonitored_followup_visits,0) + 1 where id = :n.subject_id;
        end if;

   end if;

end if;

If updating then

    If :n.encounter_status = 'Completed' and :o.encounter_status <> 'Completed'  then


	update subject set completed_encounters = completed_encounters+1
     	where id = :n.subject_id;


        If :n.time_period_category = 'Screening' then
		update subject set unmonitored_screening_visits =
		nvl(unmonitored_screening_visits,0) + 1 where id = :n.subject_id;
        elsif :n.time_period_category = 'Treatment' then
		update subject set unmonitored_treatment_visits =
		nvl(unmonitored_treatment_visits,0) + 1 where id = :n.subject_id;
        elsif :n.time_period_category = 'Followup' then
		update subject set unmonitored_followup_visits =
		nvl(unmonitored_followup_visits,0) + 1 where id = :n.subject_id;
        end if;

    end if;

    If :n.monitor_status = 'Complete' and :o.monitor_status = 'Pending'  then

        If :n.time_period_category = 'Screening' then
		update subject set unmonitored_screening_visits =
		nvl(unmonitored_screening_visits,0) - 1 where id = :n.subject_id;
        elsif :n.time_period_category = 'Treatment' then
		update subject set unmonitored_treatment_visits =
		nvl(unmonitored_treatment_visits,0) - 1 where id = :n.subject_id;
        elsif :n.time_period_category = 'Followup' then
		update subject set unmonitored_followup_visits =
		nvl(unmonitored_followup_visits,0) - 1 where id = :n.subject_id;
        end if;


    end if;

end if;

end;
/




create or replace trigger unencoded_event_status_trg2
after insert or update on unencoded_event
referencing new as n old as o
for each row
declare

v_name misc_event_prototype.name%type;

begin

  Select a.name into v_name from misc_event_prototype a, event_core b where
  b.template_id=a.id and b.id=:n.event_core_id;


If inserting then

  If :n.encounter_status='Completed' and :n.creator <> 'Site' and :n.hide <> 1 then

    If v_name = 'Early Termination' then 
	update subject set unmonitored_earlyterm_visits =
	nvl(unmonitored_earlyterm_visits,0) + 1 where id = :n.subject_id;
    elsif v_name = 'Screen Failure Termination' then 
	update subject set unmonitored_screenfail_visits =
	nvl(unmonitored_screenfail_visits,0) + 1 where id = :n.subject_id;
    end if;

  end if;

end if;


If updating then

   If :n.monitor_status='Complete' and :o.monitor_status='Pending' 
      and :n.creator <> 'Site' and :n.hide <> 1 then

    If v_name = 'Early Termination' then 
	update subject set unmonitored_earlyterm_visits =
	nvl(unmonitored_earlyterm_visits,0) - 1 where id = :n.subject_id;
    elsif v_name = 'Screen Failure Termination' then 
	update subject set unmonitored_screenfail_visits =
	nvl(unmonitored_screenfail_visits,0) - 1 where id = :n.subject_id;
    end if;

  end if;

end if;


end;
/
sho err

-- Following changes are done as per the request of Kelly on 04/24/2001 at 17:45 hrs

create or replace trigger subject_encounter_trg1
after insert or update on subject_encounter 
referencing new as n old as o
for each row
declare

invalid_event exception;
template event_core.template_type%type;
invalid_site exception;
site_id_v1 event_core.site_id%type;
site_id_v2 site_to_trial.site_id%type;
invalid_subject exception;
subject_id_v1 protocol_evgroup_inst.subject_id%type;

begin

If inserting then

 select template_type into template from event_core where  id = :n.event_core_id;

 If upper(template) <> 'ENC' then
    raise invalid_event;
 end if;

 Select site_id  into site_id_v1 from event_core  where 
	id = :n.event_core_id;

 Select min(a.site_id) into site_id_v2 from site_to_trial a, subject b 
 	where a.id=b.site_to_trial_id and b.id = :n.subject_id;
   If site_id_v1 <> site_id_v2 then
 	raise invalid_site;
   end if;

 Select subject_id into subject_id_v1 from protocol_evgroup_inst 
 	where event_core_id=:n.parent_peg_inst_id;
   If  subject_id_v1 <> :n.subject_id then
   	raise invalid_subject;
   end if;
end if;


If updating then

 select template_type into template from event_core where  id = :n.event_core_id;

 If upper(template) <> 'ENC' then
    raise invalid_event;
 end if;

 Select subject_id into subject_id_v1 from protocol_evgroup_inst 
 	where event_core_id=:n.parent_peg_inst_id;
   If  subject_id_v1 <> :n.subject_id then
   	raise invalid_subject;
   end if;
end if;

exception

when invalid_event then
     Raise_application_error(-20012,'Invalid template type in event_core. It must point to ENC');
when invalid_site then
     Raise_application_error(-20017,'Not a valid site.. inconsistency in site_id');
when invalid_subject then
     Raise_application_error(-20022,'Different subject in parent event');
end;
/
sho err



create or replace trigger subject_encounter_status_trg1
after insert or update of encounter_status,monitor_status on subject_encounter
referencing new as n old as o
for each row
begin

If inserting then

   If :n.encounter_status = 'Completed' then


	update subject set completed_encounters = completed_encounters+1
     	where id = :n.subject_id;

   If  :n.creator <> 'Site' and :n.hide <> 1  then

        If :n.time_period_category = 'Screening' then
		update subject set unmonitored_screening_visits =
		nvl(unmonitored_screening_visits,0) + 1 where id = :n.subject_id;
        elsif :n.time_period_category = 'Treatment' then
		update subject set unmonitored_treatment_visits =
		nvl(unmonitored_treatment_visits,0) + 1 where id = :n.subject_id;
        elsif :n.time_period_category = 'Followup' then
		update subject set unmonitored_followup_visits =
		nvl(unmonitored_followup_visits,0) + 1 where id = :n.subject_id;
        end if;

   end if;

   end if;

end if;

If updating then

    If :n.encounter_status = 'Completed' and :o.encounter_status <> 'Completed' then


	update subject set completed_encounters = completed_encounters+1
     	where id = :n.subject_id;

    If  :n.creator <> 'Site' and :n.hide <> 1 then

        If :n.time_period_category = 'Screening' then
		update subject set unmonitored_screening_visits =
		nvl(unmonitored_screening_visits,0) + 1 where id = :n.subject_id;
        elsif :n.time_period_category = 'Treatment' then
		update subject set unmonitored_treatment_visits =
		nvl(unmonitored_treatment_visits,0) + 1 where id = :n.subject_id;
        elsif :n.time_period_category = 'Followup' then
		update subject set unmonitored_followup_visits =
		nvl(unmonitored_followup_visits,0) + 1 where id = :n.subject_id;
        end if;

    end if;

    end if;

    If :n.monitor_status = 'Complete' and :o.monitor_status = 'Pending' 
       and :n.creator <> 'Site' and :n.hide <> 1 then

        If :n.time_period_category = 'Screening' then
		update subject set unmonitored_screening_visits =
		nvl(unmonitored_screening_visits,0) - 1 where id = :n.subject_id;
        elsif :n.time_period_category = 'Treatment' then
		update subject set unmonitored_treatment_visits =
		nvl(unmonitored_treatment_visits,0) - 1 where id = :n.subject_id;
        elsif :n.time_period_category = 'Followup' then
		update subject set unmonitored_followup_visits =
		nvl(unmonitored_followup_visits,0) - 1 where id = :n.subject_id;
        end if;


    end if;

end if;

end;
/

sho err


create or replace trigger stt_update_pv_trg1
after update of protocol_version_id on site_to_trial
referencing new as n old as o
for each row
begin

   If :n.protocol_version_id <> :o.protocol_version_id then

  update subject set protocol_version_id = :n.protocol_version_id 
	where protocol_version_id = :o.protocol_version_id and 
        subject_status in ('Screening',  'On Treatment','On Follow-Up')
        and site_to_trial_id = :n.id;

  update subject_encounter set protocol_version_id = :n.protocol_version_id
	where protocol_version_id = :o.protocol_version_id and 
        Encounter_status in ('Projected','Scheduled')
        and subject_id in (select id from subject where 
        site_to_trial_id = :n.id);

  Insert into site_to_trial_pv_history values (
	site_to_trial_pv_history_seq.nextval, :o.id,:o.protocol_version_id,sysdate);

 end if;

end;
/
sho err


-- Following changes are as per the request of Kelly on 04/25/2001 at 16:20 hrs

Alter table monitor_to_site_to_trial add constraint monitor_to_site_to_trial_uq1 
	unique (ftuser_id, site_to_trial_id) using index tablespace ftsmall_indx
        pctfree 20 nologging;

-- Following triggers were added after finding problems with count logic on 04/26/2001 at 17:30



create or replace trigger subject_encounter_status_trg1
after insert or update of encounter_status,monitor_status on subject_encounter
referencing new as n old as o
for each row
begin

If inserting then

   If :n.encounter_status = 'Completed' then



    If  ( :n.creator = 'Site' and :n.hide = 0 ) then

		update subject set completed_encounters = completed_encounters+1
			where id = :n.subject_id;

        If :n.time_period_category = 'Screening' then
			update subject set unmonitored_screening_visits =
			nvl(unmonitored_screening_visits,0) + 1 where id = :n.subject_id;
        elsif :n.time_period_category = 'Treatment' then
			update subject set unmonitored_treatment_visits =
			nvl(unmonitored_treatment_visits,0) + 1 where id = :n.subject_id;
        elsif :n.time_period_category = 'Followup' then
			update subject set unmonitored_followup_visits =
			nvl(unmonitored_followup_visits,0) + 1 where id = :n.subject_id;
        end if;
   end if;

   end if;


end if;

If updating then

    If :n.encounter_status = 'Completed' and :o.encounter_status <> 'Completed' then



    If  ( :n.creator = 'Site' and :n.hide = 0 ) then

		update subject set completed_encounters = completed_encounters+1
			where id = :n.subject_id;

        If :n.time_period_category = 'Screening' then
			update subject set unmonitored_screening_visits =
			nvl(unmonitored_screening_visits,0) + 1 where id = :n.subject_id;
        elsif :n.time_period_category = 'Treatment' then
			update subject set unmonitored_treatment_visits =
			nvl(unmonitored_treatment_visits,0) + 1 where id = :n.subject_id;
        elsif :n.time_period_category = 'Followup' then
			update subject set unmonitored_followup_visits =
			nvl(unmonitored_followup_visits,0) + 1 where id = :n.subject_id;
        end if;

    end if;

    end if;

    If :n.monitor_status = 'Complete' and :o.monitor_status = 'Pending'  then

    If  (:n.creator = 'Site' and :n.hide = 0 )  then
        If :n.time_period_category = 'Screening' then
		update subject set unmonitored_screening_visits =
		nvl(unmonitored_screening_visits,0) - 1 where id = :n.subject_id;
        elsif :n.time_period_category = 'Treatment' then
		update subject set unmonitored_treatment_visits =
		nvl(unmonitored_treatment_visits,0) - 1 where id = :n.subject_id;
        elsif :n.time_period_category = 'Followup' then
		update subject set unmonitored_followup_visits =
		nvl(unmonitored_followup_visits,0) - 1 where id = :n.subject_id;
        end if;
	end if;

    end if;

    If :o.monitor_status = 'Complete' and :n.monitor_status = 'Pending'  then

    If  (:n.creator = 'Site' and :n.hide = 0 ) then
        If :n.time_period_category = 'Screening' then
		update subject set unmonitored_screening_visits =
		nvl(unmonitored_screening_visits,0) + 1 where id = :n.subject_id;
        elsif :n.time_period_category = 'Treatment' then
		update subject set unmonitored_treatment_visits =
		nvl(unmonitored_treatment_visits,0) + 1 where id = :n.subject_id;
        elsif :n.time_period_category = 'Followup' then
		update subject set unmonitored_followup_visits =
		nvl(unmonitored_followup_visits,0) + 1 where id = :n.subject_id;
        end if;
	end if;

    end if;

    If :o.encounter_status = 'Completed' and :n.encounter_status <> 'Completed' then


		If  (:n.creator = 'Site' and :n.hide = 0 ) then

		update subject set completed_encounters = completed_encounters-1
     	where id = :n.subject_id;

        If :n.time_period_category = 'Screening' then
			update subject set unmonitored_screening_visits =
			nvl(unmonitored_screening_visits,0) - 1 where id = :n.subject_id;
        elsif :n.time_period_category = 'Treatment' then
			update subject set unmonitored_treatment_visits =
			nvl(unmonitored_treatment_visits,0) - 1 where id = :n.subject_id;
        elsif :n.time_period_category = 'Followup' then
			update subject set unmonitored_followup_visits =
			nvl(unmonitored_followup_visits,0) - 1 where id = :n.subject_id;
		end if;
		end if;
	end if;

end if;

end;
/



create or replace trigger unencoded_event_status_trg2
after insert or update on unencoded_event
referencing new as n old as o
for each row
declare

v_name misc_event_prototype.name%type;

begin

  Select a.name into v_name from misc_event_prototype a, event_core b where
  b.template_id=a.id and b.id=:n.event_core_id;


If inserting then

  If :n.encounter_status='Completed' then

	if ( :n.creator = 'Site' and :n.hide = 0) then

    If v_name = 'Early Termination' then 
	update subject set unmonitored_earlyterm_visits =
	nvl(unmonitored_earlyterm_visits,0) + 1 where id = :n.subject_id;
    elsif v_name = 'Screen Failure Termination' then 
	update subject set unmonitored_screenfail_visits =
	nvl(unmonitored_screenfail_visits,0) + 1 where id = :n.subject_id;
    end if;
	end if;

  end if;

end if;


If updating then

  If ( :o.encounter_status <> 'Completed' and :n.encounter_status='Completed' ) then

	if (:n.creator = 'Site' and :n.hide = 0) then

    If v_name = 'Early Termination' then 
	update subject set unmonitored_earlyterm_visits =
	nvl(unmonitored_earlyterm_visits,0) + 1 where id = :n.subject_id;
    elsif v_name = 'Screen Failure Termination' then 
	update subject set unmonitored_screenfail_visits =
	nvl(unmonitored_screenfail_visits,0) + 1 where id = :n.subject_id;
    end if;
	end if;

  end if;

  If ( :n.encounter_status <> 'Completed' and :o.encounter_status='Completed' ) then

	if (:n.creator = 'Site' and :n.hide = 0) then

    If v_name = 'Early Termination' then 
	update subject set unmonitored_earlyterm_visits =
	nvl(unmonitored_earlyterm_visits,0) - 1 where id = :n.subject_id;
    elsif v_name = 'Screen Failure Termination' then 
	update subject set unmonitored_screenfail_visits =
	nvl(unmonitored_screenfail_visits,0) - 1 where id = :n.subject_id;
    end if;
	end if;

  end if;

   If :n.monitor_status='Complete' and :o.monitor_status='Pending'  then
	if ( :n.creator = 'Site' and :n.hide = 0) then

    If v_name = 'Early Termination' then 
	update subject set unmonitored_earlyterm_visits =
	nvl(unmonitored_earlyterm_visits,0) - 1 where id = :n.subject_id;
    elsif v_name = 'Screen Failure Termination' then 
	update subject set unmonitored_screenfail_visits =
	nvl(unmonitored_screenfail_visits,0) - 1 where id = :n.subject_id;
    end if;
	end if;

  end if;

   If :o.monitor_status='Complete' and :n.monitor_status='Pending'  then
	if ( :n.creator = 'Site' and :n.hide = 0) then

    If v_name = 'Early Termination' then 
	update subject set unmonitored_earlyterm_visits =
	nvl(unmonitored_earlyterm_visits,0) + 1 where id = :n.subject_id;
    elsif v_name = 'Screen Failure Termination' then 
	update subject set unmonitored_screenfail_visits =
	nvl(unmonitored_screenfail_visits,0) + 1 where id = :n.subject_id;
    end if;
	end if;

  end if;

end if;


end;
/

-- Following changes were done as per the request of Kelly on 04/27/2001 at 20:30

update trial set accrual_status='ACTIVE';
commit;




-- Following added by Kelly to set the patient_mngmt_status field correctly 
-- in trial when migrating existing sites.

create or replace procedure trialUpdPatMngmntSts as

id_exist number(10);
cursor c1 is select ID from Trial;

begin

for ix1 in c1 loop 

	select count(*) into id_exist from protocol_event_group where trial_id=ix1.ID;

   If id_exist=0 then
		update trial set patient_mngmnt_status='NONE';
   else
		update trial set patient_mngmnt_status='ACTIVE';
   End if;
end loop;

end;
/
sho err


-- Following lines will always be at the end



create or replace procedure ciload as

id_exist number(10);
cursor c1 is select ft_ui,obsolete_flag from ci_sponsor;
cursor c2 is select ft_ui,obsolete_flag from ci_ta_subspecialty;
cursor c3 is select ft_ui,obsolete_flag from ci_therapeutic_area;
cursor c4 is select ft_ui,obsolete_flag from ci_ta_to_tasubspecialty;

begin

for ix1 in c1 loop 

 If ix1.obsolete_flag=0 then

	select count(*) into id_exist from sponsor where id=ix1.ft_ui;

   If id_exist=0 then
        Insert into sponsor(id,name,handheld_stale_period,sponsor_identifier, sponsor_acronym)
        select ft_ui,nvl(preferred_long_name,'Unknown'),8,preferred_short_name,preferred_short_name
        from ci_sponsor where ft_ui=ix1.ft_ui;
   End if;

   If id_exist=1 then
        Update sponsor set name=(select nvl(preferred_long_name,'Unknown') from ci_sponsor 
        where ft_ui=ix1.ft_ui) where id=ix1.ft_ui;
   End if;        

 End if;

end loop;


for ix2 in c2 loop

 If ix2.obsolete_flag=0 then

	select count(*) into id_exist from taclassifier where id=ix2.ft_ui;

   If id_exist=0 then
        Insert into taclassifier(id,name)
        select ft_ui,preferred_name from
        ci_ta_subspecialty where ft_ui=ix2.ft_ui;
   End if;

   If id_exist=1 then
        Update taclassifier set name=(select preferred_name from ci_ta_subspecialty 
        where ft_ui=ix2.ft_ui) where id=ix2.ft_ui;
   End if;        

 End if;

end loop;

for ix3 in c3 loop

 If ix3.obsolete_flag=0 then

	select count(*) into id_exist from therapeutic_area where id=ix3.ft_ui;

   If id_exist=0 then
        Insert into therapeutic_area(id,name)
        select ft_ui,preferred_short_name from
        ci_therapeutic_area where ft_ui=ix3.ft_ui;
   End if;

   If id_exist=1 then
        Update therapeutic_area set name=(select preferred_short_name from ci_therapeutic_area 
        where ft_ui=ix3.ft_ui) where id=ix3.ft_ui;
   End if;        

 End if;

end loop;

for ix4 in c4 loop

 If nvl(ix4.obsolete_flag,0)=0 then

	select count(*) into id_exist from taclassifier_to_ta where id=ix4.ft_ui;

   If id_exist=0 then
        Insert into taclassifier_to_ta(id,taclassifier_id,ta_id)
        select ft_ui,ft_subspecialty_id,ft_ta_id from
        ci_ta_to_tasubspecialty where ft_ui=ix4.ft_ui;
   End if;

   If ix4.obsolete_flag=1 then
      Delete from taclassifier_to_ta where id=ix4.ft_ui;
   End if;
 end if;

end loop;


end;
/

sho err


--exec ciload;

Create table d_patient as select * from patient where 1=2;
Create table d_subject as select * from subject where 1=2;
Create table d_medical_record_number as select * from medical_record_number where 1=2;
create table d_protocol_evgroup_inst as select * from protocol_evgroup_inst where 1=2;
create table d_subject_encounter as select * from subject_encounter where 1=2;
create table d_unencoded_event as select * from unencoded_event where 1=2;
Create table d_event_core as select * from event_core where 1=2;
Create table d_general_event as select * from general_event where 1=2;

-- Added following two lines on 07/25/2001 and implemented in production for row-chaining issues

alter table subject pctused 60 pctfree 30;

alter table site_to_trial pctused 55 pctfree 30;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:05 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:37:43 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:26:42 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
