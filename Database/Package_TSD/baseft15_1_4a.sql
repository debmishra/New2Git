--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: baseft15_1_4a.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:06 PM$
--
--
-- Description:  This file is for migration between 1.4 and 1.4a
--
---------------------------------------------------------------------
 
create sequence comment_item_seq; 
create sequence tmf_deliverable_seq;
create sequence global_tmf_deliverable_seq;
create sequence subject_disposition_seq;
create sequence client_seq;
create sequence usage_history_seq;
create sequence trial_metrics_history_seq;

-- Following changes are done in ft14 schema as per the request of Kelly on 06/12/2001 at 16:50


drop table d_setup_event_mon_instance;
drop table d_monitor_site_visit;
drop table del_temp_patsub;

Create table d_setup_event_mon_instance as select * from setup_event_mon_instance where 1=2;
Create table d_monitor_site_visit as select * from monitor_site_visit where 1=2;
create table del_temp_patsub (col1 number) tablespace ftsmall pctused 60 pctfree 20;

Alter table D_EVENT_CORE add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);

Alter table D_GENERAL_EVENT add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);

Alter table D_MEDICAL_RECORD_NUMBER add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);

Alter table D_PATIENT add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);

Alter table D_PROTOCOL_EVGROUP_INST add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);

Alter table D_SUBJECT add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);

Alter table D_SUBJECT_ENCOUNTER add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);

Alter table D_UNENCODED_EVENT add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);

Alter table D_MONITOR_SITE_VISIT add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);

Alter table D_SETUP_EVENT_MON_INSTANCE add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);


create or replace trigger general_event_trg1
after insert or update of event_core_id on general_event 
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

exception

when invalid_event then
     Raise_application_error(-20014,'Invalid template type in event_core. It must point to GEN');
end;
/
sho err

create or replace trigger monitor_site_visit_trg1
after insert or update of event_core_id on monitor_site_visit 
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

exception

when invalid_event then
     Raise_application_error(-20015,'Invalid template type in event_core. It must point to MON');
when invalid_stt_monitor then
     Raise_application_error(-20021,'Invalid combination of site_to_trial and ftuser');

end;
/
sho err

create or replace procedure delete_monitor_site_visit (msvid number, ftuserid number) as
begin

   Insert into d_setup_event_mon_instance 
   select ID,SETUP_EVENT_STATUS,MONITOR_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,
   STUDY_SETUP_EVENT_CORE_ID,sysdate,ftuserid from setup_event_mon_instance
   where  MON_SITE_VISIT_EVENT_CORE_ID = msvid;

   delete from setup_event_mon_instance
   where  MON_SITE_VISIT_EVENT_CORE_ID = msvid;     

   delete from del_temp_patsub;

   Insert into del_temp_patsub 
   select event_core_id from subject_encounter  
   where mon_site_visit_event_core_id = msvid;

   Insert into del_temp_patsub 
   select event_core_id from unencoded_event  
   where mon_site_visit_event_core_id = msvid;

   Insert into del_temp_patsub values (msvid);

   Insert into del_temp_patsub 
   select event_core_id 
   from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   mon_site_visit_event_core_id = msvid);

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   mon_site_visit_event_core_id = msvid);

   delete from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   mon_site_visit_event_core_id = msvid);

   Insert into d_subject_encounter
   select EVENT_CORE_ID,ENCOUNTER_STATUS,RESCHED_EVENT_ID,PROTOCOL_VERSION_ID,            
   ENCOUNTER_NOTE,MONITOR_STATUS,MONITOR_NOTE,SEQ,PARENT_PEG_INST_ID,HIDE,CREATOR,                        
   SUBJECT_ID,ICF_VERSION,MONITOR_SEE_PAPER_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,   
   TIME_PERIOD_CATEGORY,MIN_DATE,MIN_DATE_PRECISION,MAX_DATE,MAX_DATE_PRECISION,            
   PREF_DATE,PREF_DATE_PRECISION,sysdate,ftuserid 
   from subject_encounter where mon_site_visit_event_core_id = msvid;
  
   delete from subject_encounter where mon_site_visit_event_core_id = msvid;

   Insert into d_unencoded_event
   select EVENT_CORE_ID,ENCOUNTER_STATUS,MONITOR_STATUS,MONITOR_NOTE,HIDE,CREATOR,                        
   PARENT_PEG_INST_ID,SEQ,SUBJECT_ID,MONITOR_SEE_PAPER_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,
   RESCHED_EVENT_ID,sysdate,ftuserid                
   from unencoded_event where mon_site_visit_event_core_id = msvid;
 
   delete from unencoded_event where mon_site_visit_event_core_id = msvid;

   Insert into d_monitor_site_visit 
   select EVENT_CORE_ID,SITE_TO_TRIAL_ID,MONITOR_NOTE,START_DATE,END_DATE,              
   STATUS,FTUSER_ID,sysdate,ftuserid 
   from monitor_site_visit where event_core_id = msvid;

   delete from monitor_site_visit where event_core_id = msvid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id in (select col1 from del_temp_patsub);

   delete from event_core where id in (select col1 from del_temp_patsub);

   delete from del_temp_patsub;

   commit;

end;
/

sho err

create or replace procedure delete_subject_encounter (seid number, ftuserid number) as
begin

   delete from del_temp_patsub;

   Insert into del_temp_patsub select event_core_id from general_event
   where attached_object_type='Event' and
   attached_object_id=seid;  

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Event' and
   attached_object_id=seid;

   delete from general_event where attached_object_type='Event' and
   attached_object_id=seid;

   Insert into d_subject_encounter
   select EVENT_CORE_ID,ENCOUNTER_STATUS,RESCHED_EVENT_ID,PROTOCOL_VERSION_ID,            
   ENCOUNTER_NOTE,MONITOR_STATUS,MONITOR_NOTE,SEQ,PARENT_PEG_INST_ID,HIDE,CREATOR,                        
   SUBJECT_ID,ICF_VERSION,MONITOR_SEE_PAPER_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,   
   TIME_PERIOD_CATEGORY,MIN_DATE,MIN_DATE_PRECISION,MAX_DATE,MAX_DATE_PRECISION,            
   PREF_DATE,PREF_DATE_PRECISION,sysdate,ftuserid 
   from subject_encounter where EVENT_CORE_ID=seid;
  
   delete from subject_encounter where EVENT_CORE_ID=seid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id = seid;

   delete from event_core where id = seid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id in (select col1 from del_temp_patsub);

   delete from event_core where id in (select col1 from del_temp_patsub);

   delete from del_temp_patsub;

   commit;

end;
/

sho err

create or replace procedure delete_patient  (patid number, ftuserid number) as
begin
   delete from del_temp_patsub;

   Insert into del_temp_patsub select event_core_id from general_event 
   where event_core_id in (select
   a.id from event_core a, subject_encounter b, subject c
   where c.id=b.subject_id 
   and a.id=b.event_core_id
   and c.patient_id=patid);

   Insert into del_temp_patsub select event_core_id from general_event 
   where attached_object_type='Patient' and
   attached_object_id=patid;

   Insert into del_temp_patsub select event_core_id from general_event 
   where attached_object_type='Subject' and
   attached_object_id in(select id from subject where patient_id=patid);

   Insert into del_temp_patsub select event_core_id from general_event 
   where attached_object_type='Event' and
   attached_object_id in(select a.event_core_id 
   from subject_encounter a, subject b
   where a.subject_id=b.id and b.patient_id=patid);

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where event_core_id in (select
   a.id from event_core a, subject_encounter b, subject c
   where c.id=b.subject_id 
   and a.id=b.event_core_id
   and c.patient_id=patid);

   delete from general_event where event_core_id in (select
   a.id from event_core a, subject_encounter b, subject c
   where c.id=b.subject_id 
   and a.id=b.event_core_id
   and c.patient_id=patid);

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Patient' and
   attached_object_id=patid;

   delete from general_event where attached_object_type='Patient' and
   attached_object_id=patid;

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Subject' and
   attached_object_id in(select id from subject where patient_id=patid);

   delete from general_event where attached_object_type='Subject' and
   attached_object_id in(select id from subject where patient_id=patid);

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Event' and
   attached_object_id in(select a.event_core_id 
   from subject_encounter a, subject b
   where a.subject_id=b.id and b.patient_id=patid);

   delete from general_event where attached_object_type='Event' and
   attached_object_id in(select a.event_core_id 
   from subject_encounter a, subject b
   where a.subject_id=b.id and b.patient_id=patid);

   Insert into del_temp_patsub select a.event_core_id 
   from subject_encounter a, subject b where
   a.subject_id = b.id and
   b.patient_id=patid;

   Insert into del_temp_patsub select a.event_core_id 
   from unencoded_event a, subject b where
   a.subject_id = b.id and
   b.patient_id=patid;

   Insert into del_temp_patsub select a.event_core_id 
   from protocol_evgroup_inst a, subject b where
   a.subject_id = b.id and
   b.patient_id=patid;

   Insert into d_subject_encounter
   select EVENT_CORE_ID,ENCOUNTER_STATUS,RESCHED_EVENT_ID,PROTOCOL_VERSION_ID,            
   ENCOUNTER_NOTE,MONITOR_STATUS,MONITOR_NOTE,SEQ,PARENT_PEG_INST_ID,HIDE,CREATOR,                        
   SUBJECT_ID,ICF_VERSION,MONITOR_SEE_PAPER_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,   
   TIME_PERIOD_CATEGORY,MIN_DATE,MIN_DATE_PRECISION,MAX_DATE,MAX_DATE_PRECISION,            
   PREF_DATE,PREF_DATE_PRECISION,sysdate,ftuserid 
   from subject_encounter where subject_id in (select id 
   from subject where patient_id=patid);
  
   delete from subject_encounter where subject_id in (select id 
   from subject where patient_id=patid);

   Insert into d_unencoded_event
   select EVENT_CORE_ID,ENCOUNTER_STATUS,MONITOR_STATUS,MONITOR_NOTE,HIDE,CREATOR,                        
   PARENT_PEG_INST_ID,SEQ,SUBJECT_ID,MONITOR_SEE_PAPER_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,
   RESCHED_EVENT_ID,sysdate,ftuserid                
   from unencoded_event where subject_id in (select id 
   from subject where patient_id=patid);

   delete from unencoded_event where subject_id in (select id 
   from subject where patient_id=patid);

   Insert into d_protocol_evgroup_inst
   select EVENT_CORE_ID,PARENT_PEGINST_ID,ANCHOR_DATE,PROTOCOL_VERSION_ID,
   SUBJECT_ID,SEQ,CREATOR,UNENCODED_EVENT_PEG,sysdate,ftuserid
   from protocol_evgroup_inst where subject_id in (select
   id from subject where patient_id=patid);

   delete from protocol_evgroup_inst where subject_id in (select
   id from subject where patient_id=patid);

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id in (select col1 from del_temp_patsub);

   delete from event_core where id in (select col1 from del_temp_patsub);

   delete from del_temp_patsub;

   Insert into d_subject 
   select ID,PATIENT_ID,SITE_TO_TRIAL_ID,ENROLLING_MD,ICF_VERSION,ICF_DATE_SIGNED,               
   NEXT_VISIT_TYPE_ID,NEXT_VISIT_DATE,SUBJECT_STATUS,NOTE,SUBJECT_ID,                     
   NEXT_VISIT_TYPE_NAME,ENROLLED_DATE,LAST_MODIFIED_DATE,SCREENING_IDENTIFIER,           
   ASSIGNED_CC_ID,COMPLETED_ENCOUNTERS,UNMONITORED_SCREENING_VISITS,   
   UNMONITORED_TREATMENT_VISITS,UNMONITORED_FOLLOWUP_VISITS,UNMONITORED_SCREENFAIL_VISITS,
   UNMONITORED_EARLYTERM_VISITS,PROTOCOL_VERSION_ID,INITIAL_ICF_VERSION,            
   INITIAL_ICF_DATE,SCREENING_ID,CREATE_DT,SPONSOR_NOTE,sysdate,ftuserid                    
   from subject where patient_id=patid;

   delete from subject where patient_id=patid;

   Insert into d_medical_record_number
   select ID,PATIENT_ID,MRNUMBER,APP_ID,sysdate,ftuserid
   from medical_record_number where patient_id=patid;

   delete from medical_record_number where patient_id=patid;

   Insert into d_patient 
   select ID,SITE_ID,FIRST_NAME,LAST_NAME,INITIALS,ADDRESS_LINE_1,ADDRESS_LINE_2,         
   CITY,WORK_PHONE,STATE,POSTAL_CODE,COUNTRY,HOME_PHONE,FAX,EMAIL,GENDER,                 
   DATE_OF_BIRTH,RACE,MOBILE_PHONE,MIDDLE_INITIALS,PREFERRED_CONTACT,
   STATUS,CREATE_DT,sysdate,ftuserid
   from patient where id=patid;

   delete from patient where id=patid;

   commit;

end;
/

sho err

create or replace procedure delete_subject (subid number, ftuserid number) as
begin

   delete from del_temp_patsub;

   Insert into del_temp_patsub select event_core_id from general_event 
   where event_core_id in (select
   a.id from event_core a, subject_encounter b 
   where a.id=b.event_core_id
   and b.subject_id=subid);

   Insert into del_temp_patsub select event_core_id from general_event 
   where attached_object_type='Subject' and
   attached_object_id = subid ;

   Insert into del_temp_patsub select event_core_id from general_event
   where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   subject_id=subid);

   Insert into d_general_event 
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where event_core_id in (select
   a.id from event_core a, subject_encounter b 
   where a.id=b.event_core_id
   and b.subject_id=subid);

   delete from general_event where event_core_id in (select
   a.id from event_core a, subject_encounter b 
   where a.id=b.event_core_id
   and b.subject_id=subid);

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Subject' and
   attached_object_id=subid;

   delete from general_event where attached_object_type='Subject' and
   attached_object_id=subid;

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   subject_id=subid);

   delete from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   subject_id=subid);

   Insert into del_temp_patsub select a.event_core_id 
   from subject_encounter a where
   a.subject_id = subid;

   Insert into del_temp_patsub select a.event_core_id 
   from unencoded_event a where
   a.subject_id = subid;

   Insert into del_temp_patsub select a.event_core_id 
   from protocol_evgroup_inst a where
   a.subject_id = subid;

   Insert into d_subject_encounter
   select EVENT_CORE_ID,ENCOUNTER_STATUS,RESCHED_EVENT_ID,PROTOCOL_VERSION_ID,            
   ENCOUNTER_NOTE,MONITOR_STATUS,MONITOR_NOTE,SEQ,PARENT_PEG_INST_ID,HIDE,CREATOR,                        
   SUBJECT_ID,ICF_VERSION,MONITOR_SEE_PAPER_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,   
   TIME_PERIOD_CATEGORY,MIN_DATE,MIN_DATE_PRECISION,MAX_DATE,MAX_DATE_PRECISION,            
   PREF_DATE,PREF_DATE_PRECISION,sysdate,ftuserid 
   from subject_encounter where subject_id = subid;
  
   delete from subject_encounter where subject_id = subid;

   Insert into d_unencoded_event
   select EVENT_CORE_ID,ENCOUNTER_STATUS,MONITOR_STATUS,MONITOR_NOTE,HIDE,CREATOR,                        
   PARENT_PEG_INST_ID,SEQ,SUBJECT_ID,MONITOR_SEE_PAPER_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,
   RESCHED_EVENT_ID,sysdate,ftuserid                
   from unencoded_event where subject_id = subid;

   delete from unencoded_event where subject_id = subid;

   Insert into d_protocol_evgroup_inst
   select EVENT_CORE_ID,PARENT_PEGINST_ID,ANCHOR_DATE,PROTOCOL_VERSION_ID,
   SUBJECT_ID,SEQ,CREATOR,UNENCODED_EVENT_PEG,sysdate,ftuserid
   from protocol_evgroup_inst where subject_id = subid;

   delete from protocol_evgroup_inst where subject_id = subid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id in (select col1 from del_temp_patsub);

   delete from event_core where id in (select col1 from del_temp_patsub);

   delete from del_temp_patsub;

   Insert into d_subject 
   select ID,PATIENT_ID,SITE_TO_TRIAL_ID,ENROLLING_MD,ICF_VERSION,ICF_DATE_SIGNED,               
   NEXT_VISIT_TYPE_ID,NEXT_VISIT_DATE,SUBJECT_STATUS,NOTE,SUBJECT_ID,                     
   NEXT_VISIT_TYPE_NAME,ENROLLED_DATE,LAST_MODIFIED_DATE,SCREENING_IDENTIFIER,           
   ASSIGNED_CC_ID,COMPLETED_ENCOUNTERS,UNMONITORED_SCREENING_VISITS,   
   UNMONITORED_TREATMENT_VISITS,UNMONITORED_FOLLOWUP_VISITS,UNMONITORED_SCREENFAIL_VISITS,
   UNMONITORED_EARLYTERM_VISITS,PROTOCOL_VERSION_ID,INITIAL_ICF_VERSION,            
   INITIAL_ICF_DATE,SCREENING_ID,CREATE_DT,SPONSOR_NOTE,sysdate,ftuserid                    
   from subject where id=subid;

   delete from subject where id=subid;
   commit;
end;
/

sho err

-- Following changes are as per the request of Allen on 06/13/2001 at 16:20 hrs

create table usage_history(
	id Number(10),
	ftuser_id  Number(10),
	screen_name Varchar2(100),
	access_date Date)
	tablespace ftlarge pctused 85 pctfree 10;

Alter table usage_history add constraint usage_history_pk
	primary key (id) using index tablespace ftlarge_indx
	pctfree 10;



create table trial_metrics_history(
	id Number(10),
	ftuser_id Number(10),
	subject_id Number(10),
	subject_status_before Varchar2(50),
	subject_status_after Varchar2(50),
	event_date Date)
	tablespace ftlarge pctused 85 pctfree 10;

Alter table trial_metrics_history add constraint trial_metrics_history_pk
	primary key (id) using index tablespace ftlarge_indx
	pctfree 10;

alter table trial_metrics_history add constraint Trial_Met_Hist_SUB_STAT1_CHECK
	check (subject_status_before in ('Not Assigned','Screening',
	'On Treatment','On Follow-Up','Completed','Screen Failure-Died',
	'Screen Failure-Not Eligible','Screen Failure-Other',
	'Early Term-Died','Early Term-Lost To Follow-Up',
	'Early Term-Other','Entered In Error'));

alter table trial_metrics_history add constraint Trial_Met_Hist_SUB_STAT2_CHECK
	check (subject_status_after in ('Not Assigned','Screening',
	'On Treatment','On Follow-Up','Completed','Screen Failure-Died',
	'Screen Failure-Not Eligible','Screen Failure-Other',
	'Early Term-Died','Early Term-Lost To Follow-Up',
	'Early Term-Other','Entered In Error'));


-- The following trigger was recreated after finding the bug with Kelly on 06/13/2001 at 18:45

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

 If :n.cc_ftuser_id is not null then 

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
 End if;
exception

  When Invalid_site_cc then
       Raise_application_error(-20034,'Not a valid site for cc_ftuser_id');
  when invalid_site_pi then 
       Raise_application_error(-20035,'Site_id invalid between cc_ftuser_id and pi_ftuser_id');
end;
/

sho err

-- Following triggers are added as per the new delete requirements on 06/27/2001 at 9:50 AM

create or replace trigger subject_encounter_status_trg1
after insert or delete or update of encounter_status,monitor_status on subject_encounter
referencing new as n old as o
for each row
begin

If inserting then

   If :n.encounter_status = 'Completed' then



    If  ( :n.creator = 'Site' and :n.hide = 0 ) then

		update subject set completed_encounters = nvl(completed_encounters,0)+1
			where id = :n.subject_id;

      If :n.monitor_status <> 'Completed' or :n.monitor_status is null then

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


end if;

If updating then

    If :n.encounter_status = 'Completed' and :o.encounter_status <> 'Completed' then



    If  ( :n.creator = 'Site' and :n.hide = 0 ) then

		update subject set completed_encounters = nvl(completed_encounters,0)+1
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

		update subject set completed_encounters = nvl(completed_encounters,0)-1
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

If deleting then

   If :o.encounter_status = 'Completed' then

     If  ( :o.creator = 'Site' and :o.hide = 0 ) then

		update subject set completed_encounters = nvl(completed_encounters,0)-1
			where id = :o.subject_id;
       
        If :o.monitor_status is null or :o.monitor_status <> 'Completed' then         

           If :o.time_period_category = 'Screening' then
			update subject set unmonitored_screening_visits =
			nvl(unmonitored_screening_visits,0) - 1 where id = :o.subject_id;
           elsif :o.time_period_category = 'Treatment' then
			update subject set unmonitored_treatment_visits =
			nvl(unmonitored_treatment_visits,0) - 1 where id = :o.subject_id;
           elsif :o.time_period_category = 'Followup' then
			update subject set unmonitored_followup_visits =
			nvl(unmonitored_followup_visits,0) - 1 where id = :o.subject_id;
           end if;

        end if;
        end if;
        end if;
        end if;

end;
/

create or replace trigger unencoded_event_status_trg2
after insert or delete or update on unencoded_event
referencing new as n old as o
for each row
declare

v_name misc_event_prototype.name%type;

begin

If inserting then

  Select a.name into v_name from misc_event_prototype a, event_core b where
  b.template_id=a.id and b.id=:n.event_core_id;

  If :n.encounter_status='Completed' then

	if ( :n.creator = 'Site' and :n.hide = 0) then

        if  :n.monitor_status is null or :n.monitor_status <> 'Completed' then

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

end if;


If updating then

  Select a.name into v_name from misc_event_prototype a, event_core b where
  b.template_id=a.id and b.id=:n.event_core_id;

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

If deleting then

  Select a.name into v_name from misc_event_prototype a, event_core b where
  b.template_id=a.id and b.id=:o.event_core_id;

  If :o.encounter_status='Completed' then
  if  :o.monitor_status is null or :o.monitor_status <> 'Completed' then

	if ( :o.creator = 'Site' and :o.hide = 0) then

    If v_name = 'Early Termination' then 
	update subject set unmonitored_earlyterm_visits =
	nvl(unmonitored_earlyterm_visits,0) + 1 where id = :o.subject_id;
    elsif v_name = 'Screen Failure Termination' then 
	update subject set unmonitored_screenfail_visits =
	nvl(unmonitored_screenfail_visits,0) + 1 where id = :o.subject_id;
    end if;

         end if;
  end if;
  end if;

end if;

end;
/
sho err



-- Following trigger was added after finding the deletion problems by Nancy on 06/29/01 at 17:30 hrs


create or replace trigger unencoded_event_trg1
after insert or update of event_core_id on unencoded_event 
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
 
-- Following changes are as per the request of Nancy on 07/05/2001 at 16:00 hrs


Alter table trial add(
	logging number(1),
        tmf number(1));

update trial set logging = 0;
update trial set tmf=0;

Alter table trial modify(
	logging not null,
 	tmf not null);

Alter table trial add constraint trial_logging_check 
	check(logging in (0,1));

Alter table trial add constraint trial_tmf_check 
	check(tmf in (0,1));

-- Following changes are as per the request of Allen on 07/13/01 at 11:30 hrs

Create table subject_disposition(
	id  number(10),
	disposition_type varchar2(5) not null,
        trial_id number(10) not null,
        disposition_name varchar2(50) not null)
	tablespace ftlarge pctused 70 pctfree 20;

Alter table subject_disposition add constraint subject_disposition_PK 
	primary key (ID) using index tablespace ftlarge_indx
	pctfree 20;

Alter table subject_disposition add constraint subject_disposition_fk1 
	foreign key (trial_id) 
        references trial(id);

Alter table subject_disposition add constraint subject_disposition_type_check
	check (disposition_type in ('ET','SF'));

create index subject_disposition_index1 on subject_disposition(trial_id)
	tablespace ftlarge_indx pctfree 20;

create index subject_disposition_index2 on subject_disposition(disposition_name)
	tablespace ftlarge_indx pctfree 20;

Alter table subject add(
	subject_disposition_id number(10),
        subject_disposition_note varchar2(50));

Alter table subject add constraint subject_fk7
	foreign key (subject_disposition_id)
	references subject_disposition(id);

create index subject_index1 on subject(subject_disposition_id)
	tablespace ftlarge_indx pctfree 20;


-- Following changes are as given by Colin on 07/17/01 at 11:45 AM

CREATE TABLE CLIENT(
 	ID                       NUMBER(10),
 	NAME                     VARCHAR2(255) NOT NULL,
 	MAIN_CONTACT_ID          NUMBER(10),
 	HANDHELD_STALE_PERIOD    NUMBER(2) DEFAULT 8  NOT NULL,
 	CLIENT_IDENTIFIER        VARCHAR2(20) NOT NULL,
 	CONFIDENTIALITY_MESSAGE  VARCHAR2(2000) NOT NULL,
 	CLIENT_ACRONYM           VARCHAR2(20) NOT NULL)
	tablespace ftsmall pctused 60 pctfree 30;


Alter table Client add constraint Client_PK 
	primary key (ID) using index tablespace ftsmall_indx
	pctfree 30;

Alter table Client add constraint client_fk1 
	foreign key (Main_contact_id) 
        references ftuser(id);

Alter table Client add constraint client_uq1
        unique (client_identifier)
        using index tablespace ftsmall_indx
        pctfree 30;

Alter table Client add constraint client_uq2
        unique (name)
        using index tablespace ftsmall_indx
        pctfree 30;

ALTER TABLE ftuser DROP CONSTRAINT ftuser_fk3;

Alter table ftuser add (client_id number(10));

Alter table ftuser add constraint ftuser_fk3 
    foreign key (client_id) references client(id);


Alter table trial add (client_id number(10));

Alter table trial add constraint trial_client_fk2 
   foreign key (client_id) references client(id);

CREATE OR REPLACE TRIGGER
client_trg1
after insert or update on client
referencing new as n old as o
for each row


declare

v_exist1 number(10);
v_exist2 number(10);
Invalid_name exception;
v_client ftuser.client_id%type;
Invalid_ftuser exception;
clientcnt number(10);

begin

 Select count(*) into v_exist1 from site where site_identifier=:n.client_identifier;

 Select count(*) into v_exist2 from site where name=:n.name;

   If v_exist1 >0 or v_exist2 >0 then
	raise invalid_name;
   End if;

 select count(*) into clientcnt from ftuser where id=:n.main_contact_id;

 if clientcnt > 0 then
  select client_id into v_client from ftuser where id=:n.main_contact_id;

  If v_client is not null and v_client <> :n.id then
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


 INSERT INTO client 
 SELECT client_seq.NEXTVAL, NAME, main_contact_id,
    handheld_stale_period, sponsor_identifier,
    confidentiality_message, sponsor_acronym
 FROM sponsor;


 update trial set client_id = (select client.id
 from client, sponsor
 where client.name = sponsor.name
 and trial.sponsor_id = sponsor.id);

ALTER TABLE sponsor DROP CONSTRAINT SPONSOR_UQ1;

alter table sponsor drop column HANDHELD_STALE_PERIOD;
alter table sponsor drop column SPONSOR_IDENTIFIER;
alter table sponsor drop column SPONSOR_ACRONYM;

CREATE OR REPLACE TRIGGER
ftuser_name_check_trg1
before insert or update on ftuser
referencing new as n old as o
for each row


declare
extension_v ftuser.name%type;
site_id_cnt  number(20);
client_id_cnt  number(20);
Invalid_site_id exception;
Invalid_client_id exception;
invalid_ftuser exception;

begin

 If :n.name like '%@%' then

    extension_v:=substr(:n.name,instr(:n.name,'@')+1);

    If :n.site_id is not null then

        select count(*) into  site_id_cnt from site where site_identifier = extension_v;

        If site_id_cnt <1 then
           Raise Invalid_site_id;
        end if;
    elsif :n.client_id is not null then

        select count(*) into client_id_cnt from client where client_identifier = extension_v;

        If client_id_cnt <1 then
           Raise Invalid_client_id;
        end if;
    end if;


 end if;

 If :n.site_id is not null and :n.client_id is not null then
    Raise invalid_ftuser;
 end if;



Exception

  When Invalid_site_id then
       Raise_application_error(-20006,'Invalid site identifier attached with name');

  when Invalid_client_id then
       Raise_application_error(-20020,'Invalid client identifier attached with name');

  when Invalid_ftuser then
       Raise_application_error(-20042,'Both site_id and client_id can not exist together');

end;
/
sho err


update ftuser set client_id = (select client.id
from client, sponsor
where client.name = sponsor.name
and ftuser.sponsor_id = sponsor.id);

-- IMP: After doing this make sure no procedures and triggers are disabled.


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
        Insert into sponsor(id,name)
        select ft_ui,nvl(preferred_long_name,'Unknown')
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

create or replace trigger sponsor_trg1 
after insert or update on sponsor
referencing new as n old as o
for each row

declare

v_sponsor ftuser.sponsor_id%type;
Invalid_ftuser exception;
sponsorcnt number(10);

begin

 select count(*) into sponsorcnt from ftuser where id=:n.main_contact_id;

 if sponsorcnt > 0 then 
  select sponsor_id into v_sponsor from ftuser where id=:n.main_contact_id;

  If v_sponsor is not null and v_sponsor <> :n.id then
	raise invalid_ftuser;
  end if;
 end if;

exception

 when invalid_ftuser then
      Raise_application_error(-20041,'Invalid main_contact_id');
end ;
/

sho err

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

 Select count(*) into v_exist1 from client where client_identifier=:n.site_identifier;
 
 Select count(*) into v_exist2 from client where name=:n.name;

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
      Raise_application_error(-20030,'Name/Identifier already used as a client'); 
 when invalid_ftuser then
      Raise_application_error(-20040,'Invalid main_site_contact_id');
end ;
/

sho err


create table del_temp_ftuser(id number(10)) tablespace ftsmall;

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
Delete from del_temp_ftuser;
Insert into del_temp_ftuser select id from ftuser where site_id=siteid;
Update ftuser set site_id=null where site_id=siteid;
Delete from site where id=siteid;
Delete from  ftuser where id in (select id from del_temp_ftuser);
Delete from del_temp_ftuser;

end;
/

-- Following changes are as per ECR 39 on 07/18/2001 at 15:15 pm

Alter table site_to_trial add (version_change_code varchar2(50));

Alter table site_to_trial add constraint stt_ver_change_code_check 
	check( version_change_code in ('NoICF', 'ICFRequired', 'ICFOptional'));

update site_to_trial set version_change_code = 'NoICF';

Alter table site_to_trial modify (version_change_code not null);

Alter table subject add(dual_version_code varchar2(50));

Alter table subject add constraint subject_dual_ver_code_check
	check(dual_version_code in ('Old','New'));


create or replace trigger stt_update_pv_trg1
after update of protocol_version_id on site_to_trial
referencing new as n old as o
for each row
begin

   If :n.protocol_version_id <> :o.protocol_version_id then

   Insert into site_to_trial_pv_history values (
	site_to_trial_pv_history_seq.nextval, :o.id,:o.protocol_version_id,sysdate);

 end if;

end;
/
sho err

-- Following change was done temporarily on 07/19/2001 at 10:30 am after kelly found the problem

Alter table site_to_trial modify (VERSION_CHANGE_CODE null);

-- Following changes were done to avoid data inconsistency due to subject_disposition on 7/19/01 at 13:45

create or replace trigger Subject_site_check_trg1
after insert or update of site_to_trial_id,patient_id, 
assigned_cc_id, subject_disposition_id on Subject
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
trial_thro_sub_disp subject_disposition.trial_id%type;
Invalid_trial exception;
Invalid_sub_disp exception;


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

   If :n.subject_disposition_id is not null then

      Select trial_id into trial_thro_stt from site_to_trial 
         where id = :n.site_to_trial_id;

      Select trial_id into trial_thro_sub_disp from subject_disposition
         where id = :n.subject_disposition_id;

     If trial_thro_sub_disp is not null and trial_thro_sub_disp <> trial_thro_stt then
        Raise invalid_sub_disp;
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
  when invalid_sub_disp then
       Raise_application_error(-20047,'Trial_id invalid between Site_to_trial and Subject Disposition');

end;
/

sho err

-- Following changes are as per the request of Nancy on 07/19/2001 at 16:00

Alter table monitor_site_visit add(
	type varchar2(50));

Alter table monitor_site_visit add constraint monitor_site_visit_type_check
	check (type in ('Qualification','Initiation','Routine','Close-Out','Other'));


-- Following change was due to modification in ECR39 on 07/19/2001 at 16:10

Alter table site_to_trial_pv_history add( icf_version varchar2(128));

create or replace trigger stt_update_pv_trg1
after update of protocol_version_id, icf_version on site_to_trial
referencing new as n old as o
for each row
begin

   If :n.protocol_version_id <> :o.protocol_version_id or
      :n.icf_version <> :o.icf_version then

   Insert into site_to_trial_pv_history (id,site_to_trial_id, protocol_version_id,
        pv_change_date,icf_version) values (
	site_to_trial_pv_history_seq.nextval, :o.id,:o.protocol_version_id,sysdate,
        :o.icf_version);

 end if;

end;
/
sho err

-- Following changes were done as per the request of Allen on 07/23/01 at 16:10 

Alter table subject_disposition add(disposition_code varchar2(10));

create index subject_disposition_index3 on subject_disposition(disposition_code)
	tablespace ftlarge_indx pctfree 20;

-- Following changes are done as per requests from kelly on 07/24/01 at 10:12

create or replace trigger monitor_site_visit_trg2
after insert or update  on monitor_site_visit 
referencing new as n old as o
for each row
declare

v_client1 trial.client_id%type;
v_client2 ftuser.client_id%type;
invalid_client exception;

begin

 
 Select client_id into v_client1 from trial where id = (select trial_id
       from site_to_trial where id = :n.site_to_trial_id);

 Select client_id into v_client2 from ftuser where id = :n.ftuser_id;

 If v_client1 is not null and v_client2 is not null  and  v_client1 <> v_client2  then
    raise Invalid_client;
 end if;

exception

when invalid_client then
     Raise_application_error(-20046,'Invalid client between site_to_trial and ftuser');

end;
/
sho err

-- Following changes are done as per requests from Allen on 07/24/01 at 10:30

Alter table subject drop column subject_disposition_note;

-- Following changes are done by debashish on 7/24/01 at 11:15

create or replace trigger handheld_device_trg1
after insert or update on handheld_device
referencing new as n old as o
for each row
declare

relation_check exception;
v_cnt number(10);
v_site1  ftuser.site_id%type;
v_client1 ftuser.sponsor_id%type;
v_site2  ftuser.site_id%type;
v_client2 ftuser.sponsor_id%type;
Invalid_site exception;
Invalid_client exception;


begin

If :n.handheld_group_id is not null and :n.ftuser_id is not null then
     raise relation_check;
end if;

 Select count(*) into v_cnt from ftuser where name= :n.device_id;

     If v_cnt = 1 and :n.ftuser_id is not null then

        select  site_id, client_id into v_site1, v_client1 from ftuser where name=:n.device_id;
        
        select  site_id, client_id into v_site2, v_client2 from ftuser where id=:n.ftuser_id;

        
           If v_site1 is not null and v_site2 is not null and v_site1 <> v_site2 then
                 raise Invalid_site;
           end if;


           If v_client1 is not null and v_client2 is not null and v_client1 <> v_client2 then
                 raise Invalid_client;
           end if;

      end if;


exception

When relation_check then
     Raise_application_error(-20007,'Handheld device can not be related to both ftuser and handheld group');

When Invalid_site then
     Raise_application_error(-20044,'Site_id does not match for the ftuser_id and device_id');

When Invalid_client then
     Raise_application_error(-20045,'client_id does not match for the ftuser_id and device_id');

end;
/
sho err


create or replace trigger monitor_to_site_to_trial_trg1
after insert or update on monitor_to_site_to_trial 
referencing new as n old as o
for each row
declare

invalid_client exception;
client_thro_stt  trial.client_id%type;
client_thro_ftuser  ftuser.client_id%type;

begin

  select client_id into client_thro_ftuser from ftuser 
	where id = :n.ftuser_id;

  select b.client_id into client_thro_stt from site_to_trial a, trial b
	where a.trial_id=b.id and
              a.id = :n.site_to_trial_id ;

  If client_thro_ftuser is not null and client_thro_stt is not null and
     client_thro_ftuser <> client_thro_stt then
		raise invalid_client;
  end if;

exception

when invalid_client then
     Raise_application_error(-20027,'client_id does not match between ftuser and trial');
end;
/
sho err

Create or replace trigger ftuser_trial_filter_trg1  
after insert or update on ftuser_trial_filter
referencing new as n old as o
for each row

declare
v_client1  ftuser.sponsor_id%type;
v_client2  trial.sponsor_id%type;
invalid_client exception;

begin

   If :n.ftuser_id is not null and :n.trial_id is not null then
         
       select client_id into v_client1 from ftuser where id=:n.ftuser_id;
       select client_id into v_client2 from trial where id=:n.trial_id;

       
       If v_client1 is not null and v_client2 is not null and v_client1 <> v_client2 then
           Raise Invalid_client;
       end if;

   end if;

exception

  when Invalid_client then
       Raise_application_error(-20043,'ftuser_id and trial_id refers to different clients');
   
end;
/

sho err

-- Following changes are as per the request of Nancy on 08/24/2001 at 15:15
-- and subsequently changed immediately on 08/26/2001 at 17:10 hrs

Create table global_tmf_deliverable(
	id number(10),
	name varchar2(128))
	tablespace ftsmall pctused 60 pctfree 25;

Alter table global_tmf_deliverable add constraint global_tmf_deliverable_PK 
	primary key (ID) using index tablespace ftsmall_indx
	pctfree 20;

Create table tmf_deliverable(
	id number(10),
	global_tmf_deliverable_id number(10),
	trial_id number(10) not null,
	name varchar2(128) not null,
	due_date date,
	is_optional number(1) not null)
	tablespace ftsmall pctused 60 pctfree 25;

Alter table tmf_deliverable add constraint tmf_deliverable_PK 
	primary key (ID) using index tablespace ftsmall_indx
	pctfree 20;

Alter table tmf_deliverable add constraint tmf_delv_optional_check
	check (is_optional in (0,1));

Alter table tmf_deliverable add constraint tmf_deliverable_fk1 
	foreign key (trial_id) 
        references trial(id);

Alter table tmf_deliverable add constraint tmf_deliverable_fk2 
	foreign key (global_tmf_deliverable_id) 
        references global_tmf_deliverable(id);

-- Following changes are as per the request of Nancy on 07/25/01 at 17:25 

Alter table event_core drop constraint EVENT_CORE_TT_CHECK;

Alter table Event_core add constraint EVENT_CORE_TT_CHECK check(
	template_type in ('ENC','DOC','MON','GEN','GRP','UNEV','TMF'));


Create table tmf_deliverable_event(
	event_core_id number(10),
	site_to_trial_id number(10) not null,
	due_date date,
	last_update date,
	status varchar2(50) not null,
	date_completed date)
	tablespace ftsmall pctused 60 pctfree 25;

Alter table tmf_deliverable_event add constraint tmf_deliverable_event_pk
	primary key (event_core_ID) using index tablespace ftsmall_indx
	pctfree 25;

Alter table tmf_deliverable_event add constraint tmf_deliverable_event_fk1 
	foreign key (event_core_id) 
        references event_core(id);

Alter table tmf_deliverable_event add constraint tmf_deliverable_event_fk2 
	foreign key (site_to_trial_id) 
        references site_to_trial(id);

Alter table tmf_deliverable_event add constraint tmf_delV_evnt_STATUS_CHECK check(
	status in ('Pending', 'Submitted', 'Completed'));


create or replace trigger tmf_deliverable_event_trg1
after insert or update of event_core_id on tmf_deliverable_event
referencing new as n old as o
for each row
declare

invalid_event exception;
template event_core.template_type%type;

begin

If inserting or updating then

 select template_type into template from event_core where  id = :n.event_core_id;

 If upper(template) <> 'TMF' then
    raise invalid_event;
 end if;

end if;

exception

 when invalid_event then
     Raise_application_error(-20048,'Invalid template_type in event_core');
end;
/
sho err
 

-- Following trigger was recreated on 07/26/2001 at 9:15 am

Insert into site_to_trial_pv_history (id,site_to_trial_id, protocol_version_id,
        pv_change_date,icf_version) select site_to_trial_pv_history_seq.nextval, 
	id, PROTOCOL_VERSION_ID, sysdate, ICF_VERSION from site_to_trial;

create or replace trigger stt_update_pv_trg1
after insert or update of protocol_version_id, icf_version on site_to_trial
referencing new as n old as o
for each row
begin

If inserting then 

   Insert into site_to_trial_pv_history (id,site_to_trial_id, protocol_version_id,
        pv_change_date,icf_version) values (
	site_to_trial_pv_history_seq.nextval, :n.id,:n.protocol_version_id,sysdate,
        :n.icf_version);

end if;

If updating then

   If :n.protocol_version_id <> :o.protocol_version_id or
      :n.icf_version <> :o.icf_version then

   Insert into site_to_trial_pv_history (id,site_to_trial_id, protocol_version_id,
        pv_change_date,icf_version) values (
	site_to_trial_pv_history_seq.nextval, :n.id,:n.protocol_version_id,sysdate,
        :n.icf_version);

 end if;

end if;
end;
/
sho err

-- Following change was done as per the rquest of colin on 07/26/2001 at 17:00hrs

Alter table monitor_site_visit add (visit_duration number(10) default 1 );

update monitor_site_visit set visit_duration = 1 ;

Alter table monitor_site_visit modify (visit_duration not null);

-- Following changes are as per the request from Nancy on 07/27/2001 at 14:10 hrs


Create table d_global_tmf_deliverable as select * from global_tmf_deliverable where 1=2;
Create table d_tmf_deliverable as select * from tmf_deliverable where 1=2;
Create table d_tmf_deliverable_event as select * from tmf_deliverable_event where 1=2;

Alter table d_global_tmf_deliverable add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);

Alter table d_tmf_deliverable add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);

Alter table d_tmf_deliverable_event add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);

create or replace procedure delete_tmf_deliverable (tmfdelid number, ftuserid number) as
begin

   Insert into d_tmf_deliverable_event select event_core_id,site_to_trial_id,
   due_date, last_update, status, date_completed, sysdate, ftuserid from 
   tmf_deliverable_event where event_core_id in (
   select id from event_core where template_type='TMF' and
   template_id=tmfdelid);

   delete from tmf_deliverable_event where event_core_id in (
   select id from event_core where template_type='TMF' and
   template_id=tmfdelid);


   Insert into d_event_core select ID ,TEMPLATE_ID,NAME,CREATOR_ID,
   DATE_TIME,TEMPLATE_TYPE,SITE_ID, DATE_TIME_PRECISION,DISMISSED,
   sysdate ,ftuserid from event_core where template_type='TMF' and
   template_id=tmfdelid;         

   delete from event_core where template_type='TMF' and 
   template_id=tmfdelid; 

   Insert into d_tmf_deliverable select ID ,GLOBAL_TMF_DELIVERABLE_ID,
   TRIAL_ID ,NAME,DUE_DATE,IS_OPTIONAL, sysdate, ftuserid from 
   tmf_deliverable where id=tmfdelid;                    

   delete from tmf_deliverable where id=tmfdelid;

   commit;
end;
/
sho err

create or replace procedure delete_global_tmf_deliverable (gtmfdelid number, ftuserid number) as

 cursor c1 is select id from tmf_deliverable where global_tmf_deliverable_id=gtmfdelid;

 begin

   for ix in c1 loop

    delete_tmf_deliverable(ix.id, ftuserid);
   
   end loop;

	Insert into d_global_tmf_deliverable select id, name, sysdate, ftuserid 
      	from global_tmf_deliverable where id = gtmfdelid;


	delete from global_tmf_deliverable where id = gtmfdelid;

 commit;
end;
/
sho err

-- Following table has been created as per request from Joel on 07/30/2001 at 13:30 hrs

Create table comment_item(
	id		number(10),
	parent_id	number(10) not null,
	parent_table	varchar2(40) not null,
	parent_field	varchar2(40) not null,
	Author_id 	number(10) not null,
	create_date	date not null,
	comments 	varchar2(2000))
	tablespace ftsmall pctused 60 pctfree 30;
	
Alter table comment_item add constraint comment_item_pk 
	primary key (id) using index tablespace
	ftsmall_indx pctfree 30;

-- Following changes are as per the request from Colin on 07/30/2001 at 16:10 hrs

Alter table trial add (expected_trial_close_date date);

-- Following chages are as per discussins with Nancy and her confirmations with Alex on 7/31/01 at 11:45 

create or replace trigger tmf_deliverable_event_trg1
after insert or update of event_core_id, site_to_trial_id on tmf_deliverable_event
referencing new as n old as o
for each row
declare

invalid_event exception;
template event_core.template_type%type;
siteid1 site_to_trial.site_id%type;
siteid2 event_core.site_id%type;
invalid_site exception;

begin

 select template_type into template from event_core where  id = :n.event_core_id;

 If upper(template) <> 'TMF' then
    raise invalid_event;
 end if;

 If :n.site_to_trial_id is not null and :n.event_core_id is not null then

    Select site_id into siteid1 from site_to_trial where id = :n.site_to_trial_id;
    Select site_id into siteid2 from event_core where id = :n.event_core_id;
 
    if siteid1 is not null and siteid2 is not null and siteid1 <> siteid2 then
	Raise invalid_site;
    end if;

 end if; 

exception

 when invalid_event then
     Raise_application_error(-20048,'Invalid template_type in event_core');
 when invalid_site then
     Raise_application_error(-20049,'Invalid site_id between event_core and site_to_trial');

end;
/
sho err
 
-- Following changes are as per the request from Joel on 08/01/2001 at 14:15 

Alter table comment_item add (author_name varchar2(255));

Update comment_item a set a.author_name = (select b.name from ftuser b 
	where b.id = a.author_id);

Alter table comment_item modify (author_name not null);


-- Following changes are as per the request from Colin on 08/01/2001 at 16:25

Alter table trial add (target_enrollment number(6));

-- Following trigger is dropped by debashish after finding a duplicate on on 08/02/2001 at 14:10

drop trigger study_setup_event_trg2;

-- Following changes are as per the request of Nancy on 08/08/2001 at 13:40 

Alter table tmf_deliverable_event add (is_optional number(1));
Alter table tmf_deliverable_event add constraint
	tmf_dlv_evnt_is_optional_check check(
	is_optional in (0,1));
update tmf_deliverable_event set is_optional=0;
Alter table tmf_deliverable_event modify(is_optional not null);


-- Following changes are done temporarily as per the request of Phil/Mike on 08/09/2001
-- some decision need to be taken after Kelly comes back from vacation
-- As of 08/16/2001 Colin is working on it

update site_to_trial set ONFOLLOWUPCNT = 0 where  ONFOLLOWUPCNT is null;
update site_to_trial set COMPLETEDCNT = 0 where  COMPLETEDCNT is null;   
update site_to_trial set ENROLLEDCNT = 0 where  ENROLLEDCNT is null;    
update site_to_trial set ONTREATMENTCNT = 0 where  ONTREATMENTCNT is null;                 
update site_to_trial set EARLYTERMCNT_DIED = 0 where  EARLYTERMCNT_DIED is null;              
update site_to_trial set EARLYTERMCNT_LOSTTOFOLLOWUP = 0 where  EARLYTERMCNT_LOSTTOFOLLOWUP is null;    
update site_to_trial set EARLYTERMCNT_OTHER = 0 where  EARLYTERMCNT_OTHER is null;             
update site_to_trial set SCREENFAILURECNT_DIED = 0 where  SCREENFAILURECNT_DIED is null;          
update site_to_trial set SCREENFAILURECNT_NOTELIGIBLE = 0 where  SCREENFAILURECNT_NOTELIGIBLE is null;   
update site_to_trial set SCREENFAILURECNT_OTHER = 0 where  SCREENFAILURECNT_OTHER is null;         
update site_to_trial set SCREENINGCNT = 0 where  SCREENINGCNT is null;                   
update site_to_trial set NOTASSIGNEDCNT = 0 where  NOTASSIGNEDCNT is null;  

commit;

Create or replace trigger site_to_trial_tmp_trg1
before insert or update on site_to_trial 
referencing new as n old as o
for each row
begin

If :n.ONFOLLOWUPCNT is null then  :n.ONFOLLOWUPCNT := 0; end if;
If :n.COMPLETEDCNT is null then  :n.COMPLETEDCNT := 0; end if;   
If :n.ENROLLEDCNT is null then  :n.ENROLLEDCNT := 0; end if;    
If :n.ONTREATMENTCNT is null then  :n.ONTREATMENTCNT := 0; end if;                 
If :n.EARLYTERMCNT_DIED is null then  :n.EARLYTERMCNT_DIED := 0; end if;              
If :n.EARLYTERMCNT_LOSTTOFOLLOWUP is null then  :n.EARLYTERMCNT_LOSTTOFOLLOWUP := 0; end if;    
If :n.EARLYTERMCNT_OTHER is null then  :n.EARLYTERMCNT_OTHER := 0; end if;             
If :n.SCREENFAILURECNT_DIED is null then  :n.SCREENFAILURECNT_DIED := 0; end if;          
If :n.SCREENFAILURECNT_NOTELIGIBLE is null then  :n.SCREENFAILURECNT_NOTELIGIBLE := 0; end if;   
If :n.SCREENFAILURECNT_OTHER is null then  :n.SCREENFAILURECNT_OTHER := 0; end if;         
If :n.SCREENINGCNT is null then  :n.SCREENINGCNT := 0; end if;                   
If :n.NOTASSIGNEDCNT is null then  :n.NOTASSIGNEDCNT := 0; end if;

end;
/
sho err  

update subject set COMPLETED_ENCOUNTERS = 0 where COMPLETED_ENCOUNTERS is null;      
update subject set UNMONITORED_SCREENING_VISITS = 0 where UNMONITORED_SCREENING_VISITS is null;
update subject set UNMONITORED_TREATMENT_VISITS = 0 where UNMONITORED_TREATMENT_VISITS is null;
update subject set UNMONITORED_FOLLOWUP_VISITS = 0 where UNMONITORED_FOLLOWUP_VISITS is null;
update subject set UNMONITORED_SCREENFAIL_VISITS = 0 where UNMONITORED_SCREENFAIL_VISITS is null;
update subject set UNMONITORED_EARLYTERM_VISITS = 0 where UNMONITORED_EARLYTERM_VISITS is null;

commit;

Create or replace trigger subject_tmp_trg1
before insert or update on subject 
referencing new as n old as o
for each row
begin

If :n.COMPLETED_ENCOUNTERS is null then  :n.COMPLETED_ENCOUNTERS := 0; end if;       
If :n.UNMONITORED_SCREENING_VISITS is null then  :n.UNMONITORED_SCREENING_VISITS := 0; end if;
If :n.UNMONITORED_TREATMENT_VISITS is null then  :n.UNMONITORED_TREATMENT_VISITS := 0; end if;
If :n.UNMONITORED_FOLLOWUP_VISITS is null then  :n.UNMONITORED_FOLLOWUP_VISITS := 0; end if;
If :n.UNMONITORED_SCREENFAIL_VISITS is null then  :n.UNMONITORED_SCREENFAIL_VISITS := 0; end if;
If :n.UNMONITORED_EARLYTERM_VISITS is null then  :n.UNMONITORED_EARLYTERM_VISITS := 0; end if;

end;
/
sho err


-- Following changes are as per the request from Alex on 08/10/2001 at 11:30 


Alter table MISC_EVENT_PROTOTYPE drop constraint 
	MISC_EVNT_PTTYPE_TYPE_CHECK;


Alter table MISC_EVENT_PROTOTYPE add constraint 
	MISC_EVNT_PTTYPE_TYPE_CHECK check (
	type in ('Encounter', 'General','Monsitevisit','Ftpeg','TMF'));

select max(id) from misc_event_prototype;
select misc_event_prototype_seq.nextval from dual;
Insert into misc_event_prototype values (
misc_event_prototype_seq.nextval,'TMF Item','Sponsor','TMF');
commit;

-- Following changes are as per the request of Nancy on 08/10/2001 at 15:00

Alter table tmf_deliverable_event drop constraint tmf_deliverable_event_fk1;
Alter table tmf_deliverable_event drop constraint tmf_deliverable_event_fk2 ;

Alter table tmf_deliverable_event add constraint tmf_deliverable_event_fk1 
	foreign key (event_core_id) 
        references event_core(id)
	on delete cascade;

Alter table tmf_deliverable_event add constraint tmf_deliverable_event_fk2 
	foreign key (site_to_trial_id) 
        references site_to_trial(id)
	on delete cascade;


-- Following modifications are done as per the request of Casey on 08/13/2001 at 9:40 am

create or replace trigger client_trg2 
before insert or update of confidentiality_message on client
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

-- Following lines are added as per the request of crystal on 08/13/01 at 15:15


Alter table site_to_trial add (install_date date);


-- Following changes are as per the request of Nancy on 08/13/01 at 15:30 

Alter table global_tmf_deliverable add (long_desc varchar2(255));
Alter table tmf_deliverable add (long_desc varchar2(255));
Alter table tmf_deliverable_event add (long_desc varchar2(255));


-- Following changes are as per Kelly's mail on 08/14/2001 at 15:45
-- This has been implemented only in clienttest14a schema for the time being

update ftuser set client_id=null where client_id in (
select id from client where not upper(name) like '%AMGEN%');

update trial set client_id=null where client_id in (
select id from client where not upper(name) like '%AMGEN%');

delete from client where not upper(name) like '%AMGEN%';

commit;

-- Following changes were done on 08/16/01 at 10:30 am

create or replace trigger study_setup_event_trg1
after insert or update of event_core_id,site_to_trial_id on study_setup_event 
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

exception

 when invalid_event then
     Raise_application_error(-20013,'Invalid template type in event_core. It must point to DOC');
 when invalid_site then
     Raise_application_error(-20038,'Invalid site between site_to_trial and event_core');

end;
/
sho err

-- Following procedure was created for Nancy on 08/16/01 at 11:30

create table d_study_setup_event as select * from study_setup_event where 1=2;
create table d_site_to_trial as select * from site_to_trial where 1=2;
create table d_monitor_to_site_to_trial as select * from monitor_to_site_to_trial where 1=2;
create table d_site as select * from site where 1=2;

Alter table d_study_setup_event add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);
Alter table d_site_to_trial add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);
Alter table d_monitor_to_site_to_trial add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);
Alter table d_site add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);

Alter table d_tmf_deliverable_event add(
        is_optional number(1), long_desc varchar(255));


create or replace procedure delete_site_to_trial (sttid number, ftuserid number) 
as
cursor c1 is select id from subject where site_to_trial_id=sttid;
cursor c2 is select event_core_id from monitor_site_visit where site_to_trial_id=sttid;

begin

for ix1 in c1 loop
  delete_subject(ix1.id,ftuserid);
end loop;

for ix2 in c2 loop
  delete_monitor_site_visit(ix2.event_core_id, ftuserid);
end loop;


   delete from del_temp_patsub;

   Insert into del_temp_patsub select event_core_id from tmf_deliverable_event 
   where  site_to_trial_id = sttid;

   Insert into d_tmf_deliverable_event select event_core_id,site_to_trial_id,
   due_date, last_update, status, date_completed, sysdate, ftuserid ,
   is_optional, long_desc from tmf_deliverable_event where site_to_trial_id = sttid ;

   delete from tmf_deliverable_event where site_to_trial_id = sttid ;

   Insert into d_setup_event_mon_instance select 
   ID,SETUP_EVENT_STATUS,MONITOR_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,
   STUDY_SETUP_EVENT_CORE_ID,sysdate,ftuserid from 
   setup_event_mon_instance where 
   study_setup_event_core_id in (select event_core_id from
   study_setup_event where site_to_trial_id=sttid);      

   delete from setup_event_mon_instance where 
   study_setup_event_core_id in (select event_core_id from
   study_setup_event where site_to_trial_id=sttid);

   Insert into del_temp_patsub select event_core_id from study_setup_event
   where  site_to_trial_id = sttid;

   Insert into d_study_setup_event 
   select EVENT_CORE_ID,LONG_DESC,CREATOR,REQUIRED_FOR_ACCRUAL,REMIND_DATE,            
   VISIBILITY,COMPLETED_DATE,MONITOR_BY_DATE,SITE_TO_TRIAL_ID,ASSIGNED_COORDINATOR,
   DOCUMENT_VERSION,COMPLETION_AUTHORITY,CREATOR_COMPLETE,sysdate,ftuserid
   from study_setup_event where  site_to_trial_id = sttid;     

   delete from study_setup_event where site_to_trial_id=sttid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id in (select col1 from del_temp_patsub);

   delete from event_core where id in (select col1 from del_temp_patsub);

   delete from del_temp_patsub;

   Insert into d_monitor_to_site_to_trial 
   select ID,SITE_TO_TRIAL_ID,ROLE,FTUSER_ID,sysdate,ftuserid
   from monitor_to_site_to_trial where site_to_trial_id = sttid;
            
   delete from monitor_to_site_to_trial where site_to_trial_id = sttid;

   Insert into d_site_to_trial 
   select ID,SITE_ID,TRIAL_ID,PROTOCOL_VERSION_ID,SITE_SPONSOR_NAME,SITE_TRIAL_NAME,                
   SITE_VERSION_NAME,ACCRUAL_STATUS,PATIENT_MNGMENT_STS,TARGET_ENROLLMENT,EXPECTED_ACCRUAL_CLOSE,         
   ONFOLLOWUPCNT,COMPLETEDCNT,ICF_VERSION,EXPECTED_TRIAL_COMPLETION_DATE,ENROLLEDCNT,                    
   LAST_MONITOR_DATE,NEXT_MONITOR_DATE,KEY_ELIGIB_SUMMARY,EXPECTED_LPLV_DATE,CRA_NOTES,                      
   WHO_MAINTAINS_STATS,NUM_DECEASED,LAST_MODIFIED_DATE,ACCRUAL_START_DATE,SITE_NUMBER,                    
   SITE_SHORT_TITLE,CC_FTUSER_ID,PI_FTUSER_ID,ONTREATMENTCNT,EARLYTERMCNT_DIED,              
   EARLYTERMCNT_LOSTTOFOLLOWUP,EARLYTERMCNT_OTHER,SCREENFAILURECNT_DIED,          
   SCREENFAILURECNT_NOTELIGIBLE,SCREENFAILURECNT_OTHER,SCREENINGCNT,NOTASSIGNEDCNT,                 
   LATEST_ICF_DATE,VERSION_CHANGE_CODE,INSTALL_DATE,sysdate,ftuserid
   from site_to_trial where id=sttid;                   

   delete from site_to_trial where id = sttid;

   commit;

end ;
/
sho err

Alter table d_monitor_site_visit add(
        type varchar2(50), visit_duration number(10));


create or replace procedure delete_monitor_site_visit (msvid number, ftuserid number) as
begin

   Insert into d_setup_event_mon_instance 
   select ID,SETUP_EVENT_STATUS,MONITOR_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,
   STUDY_SETUP_EVENT_CORE_ID,sysdate,ftuserid from setup_event_mon_instance
   where  MON_SITE_VISIT_EVENT_CORE_ID = msvid;

   delete from setup_event_mon_instance
   where  MON_SITE_VISIT_EVENT_CORE_ID = msvid;     

   delete from del_temp_patsub;

   Insert into del_temp_patsub values (msvid);

   Insert into del_temp_patsub 
   select event_core_id 
   from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   mon_site_visit_event_core_id = msvid);

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   mon_site_visit_event_core_id = msvid);

   delete from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   mon_site_visit_event_core_id = msvid);

   update subject_encounter set mon_site_visit_event_core_id = null
   where mon_site_visit_event_core_id = msvid;

   update unencoded_event set mon_site_visit_event_core_id = null 
   where mon_site_visit_event_core_id = msvid;

   Insert into d_monitor_site_visit 
   select EVENT_CORE_ID,SITE_TO_TRIAL_ID,MONITOR_NOTE,START_DATE,END_DATE,              
   STATUS,FTUSER_ID,sysdate,ftuserid,type, visit_duration 
   from monitor_site_visit where event_core_id = msvid;

   delete from monitor_site_visit where event_core_id = msvid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id in (select col1 from del_temp_patsub);

   delete from event_core where id in (select col1 from del_temp_patsub);

   delete from del_temp_patsub;

   commit;

end;
/
sho err

Alter table d_subject add(
        subject_disposition_id number(10), 
        dual_version_code varchar2(50));


create or replace procedure delete_subject (subid number, ftuserid number) as
begin

   delete from del_temp_patsub;

   Insert into del_temp_patsub select event_core_id from general_event 
   where event_core_id in (select
   a.id from event_core a, subject_encounter b 
   where a.id=b.event_core_id
   and b.subject_id=subid);

   Insert into del_temp_patsub select event_core_id from general_event 
   where attached_object_type='Subject' and
   attached_object_id = subid ;

   Insert into del_temp_patsub select event_core_id from general_event
   where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   subject_id=subid);

   Insert into d_general_event 
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where event_core_id in (select
   a.id from event_core a, subject_encounter b 
   where a.id=b.event_core_id
   and b.subject_id=subid);

   delete from general_event where event_core_id in (select
   a.id from event_core a, subject_encounter b 
   where a.id=b.event_core_id
   and b.subject_id=subid);

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Subject' and
   attached_object_id=subid;

   delete from general_event where attached_object_type='Subject' and
   attached_object_id=subid;

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   subject_id=subid);

   delete from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   subject_id=subid);

   Insert into del_temp_patsub select a.event_core_id 
   from subject_encounter a where
   a.subject_id = subid;

   Insert into del_temp_patsub select a.event_core_id 
   from unencoded_event a where
   a.subject_id = subid;

   Insert into del_temp_patsub select a.event_core_id 
   from protocol_evgroup_inst a where
   a.subject_id = subid;

   Insert into d_subject_encounter
   select EVENT_CORE_ID,ENCOUNTER_STATUS,RESCHED_EVENT_ID,PROTOCOL_VERSION_ID,            
   ENCOUNTER_NOTE,MONITOR_STATUS,MONITOR_NOTE,SEQ,PARENT_PEG_INST_ID,HIDE,CREATOR,                        
   SUBJECT_ID,ICF_VERSION,MONITOR_SEE_PAPER_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,   
   TIME_PERIOD_CATEGORY,MIN_DATE,MIN_DATE_PRECISION,MAX_DATE,MAX_DATE_PRECISION,            
   PREF_DATE,PREF_DATE_PRECISION,sysdate,ftuserid 
   from subject_encounter where subject_id = subid;
  
   delete from subject_encounter where subject_id = subid;

   Insert into d_unencoded_event
   select EVENT_CORE_ID,ENCOUNTER_STATUS,MONITOR_STATUS,MONITOR_NOTE,HIDE,CREATOR,                        
   PARENT_PEG_INST_ID,SEQ,SUBJECT_ID,MONITOR_SEE_PAPER_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,
   RESCHED_EVENT_ID,sysdate,ftuserid                
   from unencoded_event where subject_id = subid;

   delete from unencoded_event where subject_id = subid;

   Insert into d_protocol_evgroup_inst
   select EVENT_CORE_ID,PARENT_PEGINST_ID,ANCHOR_DATE,PROTOCOL_VERSION_ID,
   SUBJECT_ID,SEQ,CREATOR,UNENCODED_EVENT_PEG,sysdate,ftuserid
   from protocol_evgroup_inst where subject_id = subid;

   delete from protocol_evgroup_inst where subject_id = subid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id in (select col1 from del_temp_patsub);

   delete from event_core where id in (select col1 from del_temp_patsub);

   delete from del_temp_patsub;

   Insert into d_subject 
   select ID,PATIENT_ID,SITE_TO_TRIAL_ID,ENROLLING_MD,ICF_VERSION,ICF_DATE_SIGNED,               
   NEXT_VISIT_TYPE_ID,NEXT_VISIT_DATE,SUBJECT_STATUS,NOTE,SUBJECT_ID,                     
   NEXT_VISIT_TYPE_NAME,ENROLLED_DATE,LAST_MODIFIED_DATE,SCREENING_IDENTIFIER,           
   ASSIGNED_CC_ID,COMPLETED_ENCOUNTERS,UNMONITORED_SCREENING_VISITS,   
   UNMONITORED_TREATMENT_VISITS,UNMONITORED_FOLLOWUP_VISITS,UNMONITORED_SCREENFAIL_VISITS,
   UNMONITORED_EARLYTERM_VISITS,PROTOCOL_VERSION_ID,INITIAL_ICF_VERSION,            
   INITIAL_ICF_DATE,SCREENING_ID,CREATE_DT,SPONSOR_NOTE,sysdate,ftuserid,
   subject_disposition_id, dual_version_code                   
   from subject where id=subid;

   delete from subject where id=subid;
   commit;
end;
/

sho err


create or replace procedure delete_patient  (patid number, ftuserid number) as
 cursor c1 is select id from subject where patient_id = patid;
begin

  for ix1 in c1 loop
    delete_subject(ix1.id, ftuserid);
  end loop;

   Insert into d_medical_record_number
   select ID,PATIENT_ID,MRNUMBER,APP_ID,sysdate,ftuserid
   from medical_record_number where patient_id=patid;

   delete from medical_record_number where patient_id=patid;

   Insert into d_patient 
   select ID,SITE_ID,FIRST_NAME,LAST_NAME,INITIALS,ADDRESS_LINE_1,ADDRESS_LINE_2,         
   CITY,WORK_PHONE,STATE,POSTAL_CODE,COUNTRY,HOME_PHONE,FAX,EMAIL,GENDER,                 
   DATE_OF_BIRTH,RACE,MOBILE_PHONE,MIDDLE_INITIALS,PREFERRED_CONTACT,
   STATUS,CREATE_DT,sysdate,ftuserid
   from patient where id=patid;

   delete from patient where id=patid;

   commit;

end;
/

sho err

Alter table unencoded_event drop constraint unencoded_event_fk2;
Alter table unencoded_event add constraint unencoded_event_fk2
	foreign key (resched_event_id) references 
	unencoded_event(event_core_id);

Alter table subject_encounter drop constraint subject_encounter_fk2;
Alter table subject_encounter add constraint subject_encounter_fk2
	foreign key (resched_event_id) references 
	subject_encounter(event_core_id);

Alter table unencoded_event drop constraint unencoded_event_fk4;
Alter table unencoded_event add constraint unencoded_event_fk4
	foreign key (parent_peg_inst_id) references 
	protocol_evgroup_inst(event_core_id);

Alter table subject_encounter drop constraint subject_encounter_fk5;
Alter table subject_encounter add constraint
        subject_encounter_fk5 foreign key (Parent_peg_inst_id)
        references protocol_evgroup_inst(event_core_id);

Alter table protocol_evgroup_inst drop constraint protocol_evgroup_inst_fk2;
Alter table protocol_evgroup_inst add constraint
        protocol_evgroup_inst_fk2 foreign key (Parent_peginst_id)
        references protocol_evgroup_inst(event_core_id);

Alter table setup_event_mon_instance drop constraint setup_event_mon_instance_fk3;
Alter table setup_event_mon_instance add constraint setup_event_mon_instance_fk3
	foreign key(STUDY_SETUP_EVENT_CORE_ID) references 
        study_setup_event(event_core_id);

Alter table unencoded_event drop constraint unencoded_event_fk3;
Alter table unencoded_event add constraint unencoded_event_fk3
	foreign key (mon_site_visit_event_core_id) references 
	monitor_site_visit(event_core_id);

Alter table subject_encounter drop constraint subject_encounter_fk4;
Alter table subject_encounter add constraint subject_encounter_fk4
	foreign key (mon_site_visit_event_core_id) references 
	monitor_site_visit(event_core_id);

Alter table setup_event_mon_instance drop constraint setup_event_mon_instance_fk2;
Alter table setup_event_mon_instance add constraint setup_event_mon_instance_fk2
	foreign key(MON_SITE_VISIT_EVENT_CORE_ID) references 
        monitor_site_visit(event_core_id);

Alter table unencoded_event drop constraint unencoded_event_fk5;
Alter table unencoded_event add constraint 
	unencoded_event_fk5 foreign key (subject_id)
	references subject(id);

Alter table subject_encounter drop constraint subject_encounter_fk6;
Alter table subject_encounter add constraint 
        subject_encounter_fk6 foreign key (subject_id)  
        references subject(id);

Alter table protocol_evgroup_inst drop constraint protocol_evgroup_inst_fk4;
Alter table protocol_evgroup_inst add constraint 
        protocol_evgroup_inst_fk4 foreign key (subject_id)  
        references subject(id);

Alter table monitor_to_site_to_trial drop constraint monitor_to_site_to_trial_fk2;
Alter table monitor_to_site_to_trial add constraint 
        monitor_to_site_to_trial_fk2 foreign key (site_to_trial_id)  
        references site_to_trial(id);

Alter table monitor_site_visit drop constraint monitor_site_visit_fk3;
Alter table monitor_site_visit add constraint 
        monitor_site_visit_fk3 foreign key (site_to_trial_id)  
        references site_to_trial(id);

Alter table tmf_deliverable_event drop constraint tmf_deliverable_event_fk1;
Alter table tmf_deliverable_event drop constraint tmf_deliverable_event_fk2 ;

Alter table tmf_deliverable_event add constraint tmf_deliverable_event_fk1 
	foreign key (event_core_id) 
        references event_core(id);

Alter table tmf_deliverable_event add constraint tmf_deliverable_event_fk2 
	foreign key (site_to_trial_id) 
        references site_to_trial(id);


create table d_cra_manager_to_monitor as select * from cra_manager_to_monitor where 1=2;
create table d_cra_manager_to_trial as select * from cra_manager_to_trial where 1=2;
create table d_ftuser_taclassifier_filter as select * from ftuser_taclassifier_filter where 1=2;
create table d_ftuser_to_aclentries as select * from ftuser_to_aclentries where 1=2;
create table d_ftuser_to_ftgroup as select * from ftuser_to_ftgroup where 1=2;
create table d_ftuser_trial_filter as select * from ftuser_trial_filter where 1=2;
create table d_hhgroup_to_classifiers as select * from hhgroup_to_classifiers where 1=2;
create table d_handheld_device as select * from handheld_device where 1=2;
create table d_monitor as select * from monitor where 1=2;
create table d_handheld_group as select * from handheld_group where 1=2;
create table d_ftuser as select * from ftuser where 1=2;


Alter table D_cra_manager_to_monitor add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);

Alter table D_cra_manager_to_trial add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);

Alter table D_ftuser_taclassifier_filter add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);

Alter table D_ftuser_to_aclentries add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);

Alter table D_ftuser_to_ftgroup add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);

Alter table D_ftuser_trial_filter add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);

Alter table D_hhgroup_to_classifiers add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);

Alter table D_handheld_device add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);

Alter table D_monitor add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);

Alter table D_handheld_group add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);

Alter table D_FTUSER add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);




-- Following changes are as per the request of Colin/Kelly on 08/20/2001 at 3:30 pm

Alter table ftuser drop column sponsor_id;
Alter table d_ftuser drop column sponsor_id;

drop trigger sponsor_trg1;

Create or replace trigger ftuser_trial_filter_trg1  
after insert or update on ftuser_trial_filter
referencing new as n old as o
for each row

declare
v_client1  ftuser.client_id%type;
v_client2  trial.client_id%type;
invalid_client exception;

begin

   If :n.ftuser_id is not null and :n.trial_id is not null then
         
       select client_id into v_client1 from ftuser where id=:n.ftuser_id;
       select client_id into v_client2 from trial where id=:n.trial_id;

       
       If v_client1 is not null and v_client2 is not null and v_client1 <> v_client2 then
           Raise Invalid_client;
       end if;

   end if;

exception

  when Invalid_client then
       Raise_application_error(-20043,'ftuser_id and trial_id refers to different clients');
   
end;
/

sho err


create or replace trigger handheld_device_trg1
after insert or update on handheld_device
referencing new as n old as o
for each row
declare

relation_check exception;
relation_exist exception;
v_cnt number(10);
v_site1  ftuser.site_id%type;
v_client1 ftuser.client_id%type;
v_site2  ftuser.site_id%type;
v_client2 ftuser.client_id%type;
Invalid_site exception;
Invalid_client exception;


begin

If :n.handheld_group_id is not null and :n.ftuser_id is not null then
     raise relation_check;
end if;

 Select count(*) into v_cnt from ftuser where name= :n.device_id;

     If v_cnt = 1 and :n.ftuser_id is not null then

        select  site_id, client_id into v_site1, v_client1 from ftuser where name=:n.device_id;
        
        select  site_id, client_id into v_site2, v_client2 from ftuser where id=:n.ftuser_id;

        
           If v_site1 is not null and v_site2 is not null and v_site1 <> v_site2 then
                 raise Invalid_site;
           end if;


           If v_client1 is not null and v_client2 is not null and v_client1 <> v_client2 then
                 raise Invalid_client;
           end if;

      end if;


exception

When relation_check then
     Raise_application_error(-20007,'Handheld device can not be related to both ftuser and handheld group');

When Invalid_site then
     Raise_application_error(-20044,'Site_id does not match for the ftuser_id and device_id');

When Invalid_client then
     Raise_application_error(-20045,'Client_id does not match for the ftuser_id and device_id');

end;
/
sho err

-- Following changes are done after finding that two delete procedures are not compiling

create or replace procedure delete_tmf_deliverable (tmfdelid number, ftuserid number) as
begin

   Insert into d_tmf_deliverable_event select event_core_id,site_to_trial_id,
   due_date, last_update, status, date_completed, sysdate, 
   ftuserid, is_optional, long_desc from 
   tmf_deliverable_event where event_core_id in (
   select id from event_core where template_type='TMF' and
   template_id=tmfdelid);

   delete from tmf_deliverable_event where event_core_id in (
   select id from event_core where template_type='TMF' and
   template_id=tmfdelid);


   Insert into d_event_core select ID ,TEMPLATE_ID,NAME,CREATOR_ID,
   DATE_TIME,TEMPLATE_TYPE,SITE_ID, DATE_TIME_PRECISION,DISMISSED,
   sysdate ,ftuserid from event_core where template_type='TMF' and
   template_id=tmfdelid;         

   delete from event_core where template_type='TMF' and 
   template_id=tmfdelid; 

   Insert into d_tmf_deliverable select ID ,GLOBAL_TMF_DELIVERABLE_ID,
   TRIAL_ID ,NAME,DUE_DATE,IS_OPTIONAL, sysdate, ftuserid from 
   tmf_deliverable where id=tmfdelid;                    

   delete from tmf_deliverable where id=tmfdelid;

   commit;
end;
/
sho err

Alter procedure delete_global_tmf_deliverable compile;
sho err

-- Following changes are done on 08/20/2001 at 16:30

Create or replace procedure delete_site (siteid in number,ftuserid in number) as

cursor c1 is select id from site_to_trial where site_id = siteid;
cursor c2 is select id from patient where site_id = siteid;

begin

for ix1 in c1 loop
 delete_site_to_trial(ix1.id,ftuserid);
end loop;

for ix2 in c2 loop
 delete_patient(ix2.id, ftuserid);
end loop;

delete from del_temp_patsub;

Insert into del_temp_patsub select event_core_id from general_event 
	where event_core_id in ( select id from 
	event_core where site_id = siteid);

Insert into d_general_event
   	select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   	EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   	from general_event where event_core_id in ( select id from 
	event_core where site_id = siteid);

delete from general_event where event_core_id in ( select id from 
	event_core where site_id = siteid);

Insert into d_event_core select ID,TEMPLATE_ID,NAME,CREATOR_ID,             
	DATE_TIME,TEMPLATE_TYPE,SITE_ID,DATE_TIME_PRECISION,
	DISMISSED,sysdate,ftuserid from event_core where 
	id in (select col1 from del_temp_patsub);             

Delete from event_core where  id in (select col1 from del_temp_patsub);

delete from del_temp_patsub;

Insert into d_event_core select ID,TEMPLATE_ID,NAME,CREATOR_ID,             
	DATE_TIME,TEMPLATE_TYPE,SITE_ID,DATE_TIME_PRECISION,
	DISMISSED,sysdate,ftuserid from event_core where 
	site_id=siteid;

Delete from event_core where site_id=siteid;

Insert into d_cra_manager_to_monitor 
	select ID,MANAGER_FTUSER_ID,FTUSER_ID,sysdate,ftuserid from
	cra_manager_to_monitor where ftuser_id in (select
	id from ftuser where site_id=siteid);            

Delete from  cra_manager_to_monitor where ftuser_id in (select
	id from ftuser where site_id=siteid);

Insert into d_cra_manager_to_monitor
	select ID,MANAGER_FTUSER_ID,FTUSER_ID,sysdate,ftuserid from
	cra_manager_to_monitor where manager_ftuser_id in (select
	id from ftuser where site_id=siteid);

Delete from  cra_manager_to_monitor where manager_ftuser_id in (select
	id from ftuser where site_id=siteid);

Insert into d_cra_manager_to_trial 
	select ID,MANAGER_FTUSER_ID,TRIAL_ID,sysdate,ftuserid from
    	cra_manager_to_trial where manager_ftuser_id in (select
	id from ftuser where site_id=siteid);               

Delete from  cra_manager_to_trial where manager_ftuser_id in (select
	id from ftuser where site_id=siteid);

Insert into d_ftuser_taclassifier_filter
	select ID,FTUSER_ID,TACLASSIFIER_ID,sysdate,ftuserid from
	ftuser_taclassifier_filter where ftuser_id in (select
	id from ftuser where site_id=siteid);        

Delete from  ftuser_taclassifier_filter where ftuser_id in (select
	id from ftuser where site_id=siteid); 

Insert into d_ftuser_to_aclentries
	select ID,FTUSER_ID,ACLENTRIES_ID,sysdate,ftuserid from
	ftuser_to_aclentries where ftuser_id in (select
	id from ftuser where site_id=siteid); 

Delete from  ftuser_to_aclentries where ftuser_id in (select
	id from ftuser where site_id=siteid); 

Insert into d_ftuser_to_ftgroup 
	select ID,FTUSER_ID,FTGROUP_ID,sysdate,ftuserid from
	ftuser_to_ftgroup where ftuser_id in (select
	id from ftuser where site_id=siteid); 

Delete from  ftuser_to_ftgroup where ftuser_id in (select
	id from ftuser where site_id=siteid); 

Insert into d_ftuser_trial_filter 
	select ID,FTUSER_ID,TRIAL_ID,sysdate,ftuserid from
	ftuser_trial_filter where ftuser_id in (select
	id from ftuser where site_id=siteid);        

Delete from  ftuser_trial_filter where ftuser_id in (select
	id from ftuser where site_id=siteid); 

Insert into d_hhgroup_to_classifiers
	select ID,TACLASSIFIER_ID,HANDHELD_GROUP_ID,sysdate,ftuserid
	from hhgroup_to_classifiers where handheld_group_id in (select
	id from handheld_group where site_id=siteid);

Delete from hhgroup_to_classifiers where handheld_group_id in (select
	id from handheld_group where site_id=siteid);

Insert into d_handheld_device 
	select ID,DEVICE_ID,HANDHELD_GROUP_ID,LAST_SYNCH_TIME,        
	HH_TYPE,COMMENTS,AVANTGO_ID,FTUSER_ID,PIN,sysdate,ftuserid
	from handheld_device where ftuser_id in (select
	id from ftuser where site_id=siteid);                    

Delete from  handheld_device where ftuser_id in (select
	id from ftuser where site_id=siteid);

Insert into d_handheld_device 
	select ID,DEVICE_ID,HANDHELD_GROUP_ID,LAST_SYNCH_TIME,        
	HH_TYPE,COMMENTS,AVANTGO_ID,FTUSER_ID,PIN,sysdate,ftuserid
	from handheld_device where device_id in (select
	name from ftuser where site_id=siteid);

Delete from  handheld_device where device_id in (select
	name from ftuser where site_id=siteid);

Insert into d_handheld_device 
	select ID,DEVICE_ID,HANDHELD_GROUP_ID,LAST_SYNCH_TIME,        
	HH_TYPE,COMMENTS,AVANTGO_ID,FTUSER_ID,PIN,sysdate,ftuserid
	from handheld_device where handheld_group_id in (select
	id from handheld_group where site_id=siteid);

Delete from  handheld_device where handheld_group_id in (select
	id from handheld_group where site_id=siteid);

Insert into d_monitor 
	select CRA_TYPE,FTUSER_ID,sysdate,ftuserid from 
	monitor where ftuser_id in (select
	id from ftuser where site_id=siteid); 

Delete from  monitor where ftuser_id in (select
	id from ftuser where site_id=siteid); 

Insert into d_monitor_to_site_to_trial 
	select ID,SITE_TO_TRIAL_ID,ROLE,FTUSER_ID,sysdate,ftuserid
	from monitor_to_site_to_trial where ftuser_id in (select
	id from ftuser where site_id=siteid);              

Delete from  monitor_to_site_to_trial where ftuser_id in (select
	id from ftuser where site_id=siteid);

Insert into d_site_to_trial 
   select ID,SITE_ID,TRIAL_ID,PROTOCOL_VERSION_ID,SITE_SPONSOR_NAME,SITE_TRIAL_NAME,                
   SITE_VERSION_NAME,ACCRUAL_STATUS,PATIENT_MNGMENT_STS,TARGET_ENROLLMENT,EXPECTED_ACCRUAL_CLOSE,         
   ONFOLLOWUPCNT,COMPLETEDCNT,ICF_VERSION,EXPECTED_TRIAL_COMPLETION_DATE,ENROLLEDCNT,                    
   LAST_MONITOR_DATE,NEXT_MONITOR_DATE,KEY_ELIGIB_SUMMARY,EXPECTED_LPLV_DATE,CRA_NOTES,                      
   WHO_MAINTAINS_STATS,NUM_DECEASED,LAST_MODIFIED_DATE,ACCRUAL_START_DATE,SITE_NUMBER,                    
   SITE_SHORT_TITLE,CC_FTUSER_ID,PI_FTUSER_ID,ONTREATMENTCNT,EARLYTERMCNT_DIED,              
   EARLYTERMCNT_LOSTTOFOLLOWUP,EARLYTERMCNT_OTHER,SCREENFAILURECNT_DIED,          
   SCREENFAILURECNT_NOTELIGIBLE,SCREENFAILURECNT_OTHER,SCREENINGCNT,NOTASSIGNEDCNT,                 
   LATEST_ICF_DATE,VERSION_CHANGE_CODE,INSTALL_DATE,sysdate,ftuserid
   from site_to_trial where cc_ftuser_id in (select 
   id from ftuser where site_id=siteid);

Delete from  site_to_trial where cc_ftuser_id in (select 
	id from ftuser where site_id=siteid);

Insert into d_site_to_trial 
   select ID,SITE_ID,TRIAL_ID,PROTOCOL_VERSION_ID,SITE_SPONSOR_NAME,SITE_TRIAL_NAME,                
   SITE_VERSION_NAME,ACCRUAL_STATUS,PATIENT_MNGMENT_STS,TARGET_ENROLLMENT,EXPECTED_ACCRUAL_CLOSE,         
   ONFOLLOWUPCNT,COMPLETEDCNT,ICF_VERSION,EXPECTED_TRIAL_COMPLETION_DATE,ENROLLEDCNT,                    
   LAST_MONITOR_DATE,NEXT_MONITOR_DATE,KEY_ELIGIB_SUMMARY,EXPECTED_LPLV_DATE,CRA_NOTES,                      
   WHO_MAINTAINS_STATS,NUM_DECEASED,LAST_MODIFIED_DATE,ACCRUAL_START_DATE,SITE_NUMBER,                    
   SITE_SHORT_TITLE,CC_FTUSER_ID,PI_FTUSER_ID,ONTREATMENTCNT,EARLYTERMCNT_DIED,              
   EARLYTERMCNT_LOSTTOFOLLOWUP,EARLYTERMCNT_OTHER,SCREENFAILURECNT_DIED,          
   SCREENFAILURECNT_NOTELIGIBLE,SCREENFAILURECNT_OTHER,SCREENINGCNT,NOTASSIGNEDCNT,                 
   LATEST_ICF_DATE,VERSION_CHANGE_CODE,INSTALL_DATE,sysdate,ftuserid
   from site_to_trial where pi_ftuser_id in (select 
   id from ftuser where site_id=siteid);

Delete from  site_to_trial where pi_ftuser_id in (select 
	id from ftuser where site_id=siteid);

Insert into d_handheld_group 
	select ID,NAME,SITE_ID,PIN,sysdate,ftuserid from
	handheld_group where site_id=siteid;	    

Delete from handheld_group where site_id=siteid;

Insert into d_site select ID,SITE_IDENTIFIER,NAME,FT_SITE_NAME,BASE_FASTTRACK_URL,     
	MAIN_SITE_LOCATION,TIME_ZONE_ID,LOCALE,HANDHELD_STALE_PERIOD,  
	MAIN_SITE_CONTACT_ID,SITE_ACRONYM,NUM_WEEKS_PAST_ON_HH,NUM_WEEKS_FORWARD_ON_HH,
	ADDRESS_LINE_1,ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,                
	CONFIDENTIALITY_MESSAGE,sysdate,ftuserid from site where id=siteid;

Insert into d_ftuser select ID,NAME,PASSWORD,SITE_ID,STARTING_SCREEN,        
	LAST_PASSWORD_UPDATE,FIRST_NAME,LAST_NAME,LAST_LOGIN_DATE,PRIMARY_TA_ID,          
	ADDRESS_LINE_1,ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,WORK_PHONE,             
	HOME_PHONE,FAX,MOBILE_PHONE,EMAIL,PREFERRED_CONTACT,TITLE,CLIENT_ID,
	sysdate,ftuserid from ftuser where id in (select id from del_temp_ftuser);

update site set main_site_contact_id = (
	select min(id) from ftuser where upper(name)='SYSTEM')
       	where id=siteid;

Delete from ftuser where site_id = siteid;

Delete from site where id = siteid;

commit;

end;
/

sho err

-- Following trigger is added by Debashish to avoid future data inconsistency problems 
-- on 08/20/2001 at 2:30 pm


create or replace trigger ftuser_trg3
after update of site_id,client_id on ftuser 
referencing new as n old as o
for each row

begin

  If :o.site_id is not null and :o.site_id <> :n.site_id then
    Raise_application_error(-20050,'Sorry, site_id can not be changed');
  End if;

  If :o.client_id is not null and :o.client_id <> :n.client_id then
    Raise_application_error(-20051,'Sorry, client_id can not be changed');
  End if;

end;
/
sho err

-- Following changes are as per the request from Nancy on 08/24/2001 at 11:15 am

Create table d_comment_item as select * from comment_item where 1=2;

Alter table d_comment_item add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);

create or replace procedure delete_tmf_deliverable (tmfdelid number, ftuserid number) as
begin

      
 
   Insert into d_tmf_deliverable_event select event_core_id,site_to_trial_id,
   due_date, last_update, status, date_completed, sysdate, 
   ftuserid, is_optional, long_desc from 
   tmf_deliverable_event where event_core_id in (
   select id from event_core where template_type='TMF' and
   template_id=tmfdelid);

   delete from tmf_deliverable_event where event_core_id in (
   select id from event_core where template_type='TMF' and
   template_id=tmfdelid);


   Insert into d_event_core select ID ,TEMPLATE_ID,NAME,CREATOR_ID,
   DATE_TIME,TEMPLATE_TYPE,SITE_ID, DATE_TIME_PRECISION,DISMISSED,
   sysdate ,ftuserid from event_core where template_type='TMF' and
   template_id=tmfdelid;         

   delete from event_core where template_type='TMF' and 
   template_id=tmfdelid; 

   Insert into d_comment_item select ID,PARENT_ID,PARENT_TABLE,PARENT_FIELD,AUTHOR_ID,      
   CREATE_DATE,COMMENTS,AUTHOR_NAME,sysdate ,ftuserid from comment_item where
   parent_table = 'TMF_DELIVERABLE' and parent_id = tmfdelid;

   Delete from comment_item where parent_table = 'TMF_DELIVERABLE'
   and parent_id = tmfdelid;

   Insert into d_tmf_deliverable select ID ,GLOBAL_TMF_DELIVERABLE_ID,
   TRIAL_ID ,NAME,DUE_DATE,IS_OPTIONAL, sysdate, ftuserid from 
   tmf_deliverable where id=tmfdelid;                    

   delete from tmf_deliverable where id=tmfdelid;

   commit;
end;
/
sho err

Alter procedure delete_global_tmf_deliverable compile;
sho err
   
-- Following chnages are as per the request from Crystal on 08/24/2001 at 11:45 AM

Alter table monitor_site_visit add (how_conducted varchar2(50));

Alter table monitor_site_visit add constraint msv_how_conducted_check 
   check (how_conducted in ('Site Visit', 'Telephone', 'Other'));

Alter table d_monitor_site_visit add (how_conducted varchar2(50));

create or replace procedure delete_monitor_site_visit (msvid number, ftuserid number) as
begin

   Insert into d_setup_event_mon_instance 
   select ID,SETUP_EVENT_STATUS,MONITOR_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,
   STUDY_SETUP_EVENT_CORE_ID,sysdate,ftuserid from setup_event_mon_instance
   where  MON_SITE_VISIT_EVENT_CORE_ID = msvid;

   delete from setup_event_mon_instance
   where  MON_SITE_VISIT_EVENT_CORE_ID = msvid;     

   delete from del_temp_patsub;

   Insert into del_temp_patsub values (msvid);

   Insert into del_temp_patsub 
   select event_core_id 
   from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   mon_site_visit_event_core_id = msvid);

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   mon_site_visit_event_core_id = msvid);

   delete from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   mon_site_visit_event_core_id = msvid);

   update subject_encounter set mon_site_visit_event_core_id = null
   where mon_site_visit_event_core_id = msvid;

   update unencoded_event set mon_site_visit_event_core_id = null 
   where mon_site_visit_event_core_id = msvid;

   Insert into d_monitor_site_visit 
   select EVENT_CORE_ID,SITE_TO_TRIAL_ID,MONITOR_NOTE,START_DATE,END_DATE,              
   STATUS,FTUSER_ID,sysdate,ftuserid,type, visit_duration, how_conducted
   from monitor_site_visit where event_core_id = msvid;

   delete from monitor_site_visit where event_core_id = msvid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id in (select col1 from del_temp_patsub);

   delete from event_core where id in (select col1 from del_temp_patsub);

   delete from del_temp_patsub;

   commit;

end;
/
sho err

Alter procedure DELETE_SITE_TO_TRIAL compile;
Alter procedure DELETE_SITE compile;


-- Following changes are done to ftuser as per the request of Kelly on 08/27/2001 at 11:15 am


select max(id) from ftuser;
select ftuser_seq.nextval from dual;
Insert into ftuser (id,name,password,site_id,first_name,last_name) values
	(ftuser_seq.nextval,'ftadmin@fasttrack','12345678',0,'ftadmin@fasttrack','ftadmin@fasttrack');

Insert into ftuser_to_ftgroup 
select ftuser_to_ftgroup_seq.nextval, a.id,b.id from ftuser a, ftgroup b where 
a.name='ftadmin@fasttrack' and b.name='Fast Track Administrator';


Insert into ft_foreign_key_info values (ft_foreign_key_info_seq.nextval,
'TMF_DELIVERABLE','ID','COMMENT_ITEM','PARENT_ID');

Insert into ft_foreign_key_info values (ft_foreign_key_info_seq.nextval,
'TMF_DELIVERABLE_EVENT','EVENT_CORE_ID','COMMENT_ITEM','PARENT_ID');

Insert into ft_foreign_key_info values (ft_foreign_key_info_seq.nextval,
'SUBJECT_ENCOUNTER','EVENT_CORE_ID','COMMENT_ITEM','PARENT_ID');

Insert into ft_foreign_key_info values (ft_foreign_key_info_seq.nextval,
'UNENCODED_EVENT','EVENT_CORE_ID','COMMENT_ITEM','PARENT_ID');

Alter table ft_foreign_key_info add constraint ft_foreign_key_info_uq1
	unique (PKTABLE_NAME,PKCOLUMN_NAME,FKTABLE_NAME,FKCOLUMN_NAME)
	using index tablespace ftsmall pctfree 30;

-- Following changes are done as per the bug identified by Kelly on 08/29/2001 at 7:20 am


create or replace procedure delete_subject (subid number, ftuserid number) as
begin

   Insert into d_subject 
   select ID,PATIENT_ID,SITE_TO_TRIAL_ID,ENROLLING_MD,ICF_VERSION,ICF_DATE_SIGNED,               
   NEXT_VISIT_TYPE_ID,NEXT_VISIT_DATE,SUBJECT_STATUS,NOTE,SUBJECT_ID,                     
   NEXT_VISIT_TYPE_NAME,ENROLLED_DATE,LAST_MODIFIED_DATE,SCREENING_IDENTIFIER,           
   ASSIGNED_CC_ID,COMPLETED_ENCOUNTERS,UNMONITORED_SCREENING_VISITS,   
   UNMONITORED_TREATMENT_VISITS,UNMONITORED_FOLLOWUP_VISITS,UNMONITORED_SCREENFAIL_VISITS,
   UNMONITORED_EARLYTERM_VISITS,PROTOCOL_VERSION_ID,INITIAL_ICF_VERSION,            
   INITIAL_ICF_DATE,SCREENING_ID,CREATE_DT,SPONSOR_NOTE,sysdate,ftuserid,
   subject_disposition_id, dual_version_code                   
   from subject where id=subid;


   delete from del_temp_patsub;

   Insert into del_temp_patsub select event_core_id from general_event 
   where event_core_id in (select
   a.id from event_core a, subject_encounter b 
   where a.id=b.event_core_id
   and b.subject_id=subid);

   Insert into del_temp_patsub select event_core_id from general_event 
   where attached_object_type='Subject' and
   attached_object_id = subid ;

   Insert into del_temp_patsub select event_core_id from general_event
   where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   subject_id=subid);

   Insert into d_general_event 
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where event_core_id in (select
   a.id from event_core a, subject_encounter b 
   where a.id=b.event_core_id
   and b.subject_id=subid);

   delete from general_event where event_core_id in (select
   a.id from event_core a, subject_encounter b 
   where a.id=b.event_core_id
   and b.subject_id=subid);

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Subject' and
   attached_object_id=subid;

   delete from general_event where attached_object_type='Subject' and
   attached_object_id=subid;

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   subject_id=subid);

   delete from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   subject_id=subid);

   Insert into del_temp_patsub select a.event_core_id 
   from subject_encounter a where
   a.subject_id = subid;

   Insert into del_temp_patsub select a.event_core_id 
   from unencoded_event a where
   a.subject_id = subid;

   Insert into del_temp_patsub select a.event_core_id 
   from protocol_evgroup_inst a where
   a.subject_id = subid;

   Insert into d_subject_encounter
   select EVENT_CORE_ID,ENCOUNTER_STATUS,RESCHED_EVENT_ID,PROTOCOL_VERSION_ID,            
   ENCOUNTER_NOTE,MONITOR_STATUS,MONITOR_NOTE,SEQ,PARENT_PEG_INST_ID,HIDE,CREATOR,                        
   SUBJECT_ID,ICF_VERSION,MONITOR_SEE_PAPER_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,   
   TIME_PERIOD_CATEGORY,MIN_DATE,MIN_DATE_PRECISION,MAX_DATE,MAX_DATE_PRECISION,            
   PREF_DATE,PREF_DATE_PRECISION,sysdate,ftuserid 
   from subject_encounter where subject_id = subid;
  
   delete from subject_encounter where subject_id = subid;

   Insert into d_unencoded_event
   select EVENT_CORE_ID,ENCOUNTER_STATUS,MONITOR_STATUS,MONITOR_NOTE,HIDE,CREATOR,                        
   PARENT_PEG_INST_ID,SEQ,SUBJECT_ID,MONITOR_SEE_PAPER_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,
   RESCHED_EVENT_ID,sysdate,ftuserid                
   from unencoded_event where subject_id = subid;

   delete from unencoded_event where subject_id = subid;

   Insert into d_protocol_evgroup_inst
   select EVENT_CORE_ID,PARENT_PEGINST_ID,ANCHOR_DATE,PROTOCOL_VERSION_ID,
   SUBJECT_ID,SEQ,CREATOR,UNENCODED_EVENT_PEG,sysdate,ftuserid
   from protocol_evgroup_inst where subject_id = subid;

   delete from protocol_evgroup_inst where subject_id = subid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id in (select col1 from del_temp_patsub);

   delete from event_core where id in (select col1 from del_temp_patsub);

   delete from del_temp_patsub;

   delete from subject where id=subid;
   commit;
end;
/

sho err

create or replace procedure delete_site_to_trial (sttid number, ftuserid number) 
as
cursor c1 is select id from subject where site_to_trial_id=sttid;
cursor c2 is select event_core_id from monitor_site_visit where site_to_trial_id=sttid;

begin

   Insert into d_site_to_trial 
   select ID,SITE_ID,TRIAL_ID,PROTOCOL_VERSION_ID,SITE_SPONSOR_NAME,SITE_TRIAL_NAME,                
   SITE_VERSION_NAME,ACCRUAL_STATUS,PATIENT_MNGMENT_STS,TARGET_ENROLLMENT,EXPECTED_ACCRUAL_CLOSE,         
   ONFOLLOWUPCNT,COMPLETEDCNT,ICF_VERSION,EXPECTED_TRIAL_COMPLETION_DATE,ENROLLEDCNT,                    
   LAST_MONITOR_DATE,NEXT_MONITOR_DATE,KEY_ELIGIB_SUMMARY,EXPECTED_LPLV_DATE,CRA_NOTES,                      
   WHO_MAINTAINS_STATS,NUM_DECEASED,LAST_MODIFIED_DATE,ACCRUAL_START_DATE,SITE_NUMBER,                    
   SITE_SHORT_TITLE,CC_FTUSER_ID,PI_FTUSER_ID,ONTREATMENTCNT,EARLYTERMCNT_DIED,              
   EARLYTERMCNT_LOSTTOFOLLOWUP,EARLYTERMCNT_OTHER,SCREENFAILURECNT_DIED,          
   SCREENFAILURECNT_NOTELIGIBLE,SCREENFAILURECNT_OTHER,SCREENINGCNT,NOTASSIGNEDCNT,                 
   LATEST_ICF_DATE,VERSION_CHANGE_CODE,INSTALL_DATE,sysdate,ftuserid
   from site_to_trial where id=sttid;                   


for ix1 in c1 loop
  delete_subject(ix1.id,ftuserid);
end loop;

for ix2 in c2 loop
  delete_monitor_site_visit(ix2.event_core_id, ftuserid);
end loop;


   delete from del_temp_patsub;

   Insert into del_temp_patsub select event_core_id from tmf_deliverable_event 
   where  site_to_trial_id = sttid;

   Insert into d_tmf_deliverable_event select event_core_id,site_to_trial_id,
   due_date, last_update, status, date_completed, sysdate, ftuserid ,
   is_optional, long_desc from tmf_deliverable_event where site_to_trial_id = sttid ;

   delete from tmf_deliverable_event where site_to_trial_id = sttid ;

   Insert into d_setup_event_mon_instance select 
   ID,SETUP_EVENT_STATUS,MONITOR_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,
   STUDY_SETUP_EVENT_CORE_ID,sysdate,ftuserid from 
   setup_event_mon_instance where 
   study_setup_event_core_id in (select event_core_id from
   study_setup_event where site_to_trial_id=sttid);      

   delete from setup_event_mon_instance where 
   study_setup_event_core_id in (select event_core_id from
   study_setup_event where site_to_trial_id=sttid);

   Insert into del_temp_patsub select event_core_id from study_setup_event
   where  site_to_trial_id = sttid;

   Insert into d_study_setup_event 
   select EVENT_CORE_ID,LONG_DESC,CREATOR,REQUIRED_FOR_ACCRUAL,REMIND_DATE,            
   VISIBILITY,COMPLETED_DATE,MONITOR_BY_DATE,SITE_TO_TRIAL_ID,ASSIGNED_COORDINATOR,
   DOCUMENT_VERSION,COMPLETION_AUTHORITY,CREATOR_COMPLETE,sysdate,ftuserid
   from study_setup_event where  site_to_trial_id = sttid;     

   delete from study_setup_event where site_to_trial_id=sttid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id in (select col1 from del_temp_patsub);

   delete from event_core where id in (select col1 from del_temp_patsub);

   delete from del_temp_patsub;

   Insert into d_monitor_to_site_to_trial 
   select ID,SITE_TO_TRIAL_ID,ROLE,FTUSER_ID,sysdate,ftuserid
   from monitor_to_site_to_trial where site_to_trial_id = sttid;
            
   delete from monitor_to_site_to_trial where site_to_trial_id = sttid;

   delete from site_to_trial where id = sttid;

   commit;

end ;
/
sho err

create or replace trigger stt_update_pv_trg1
after insert or update of protocol_version_id, icf_version on site_to_trial
referencing new as n old as o
for each row
begin

If inserting then 

   Insert into site_to_trial_pv_history (id,site_to_trial_id, protocol_version_id,
        pv_change_date,icf_version) values (
	site_to_trial_pv_history_seq.nextval, :n.id,:n.protocol_version_id,sysdate,
        :n.icf_version);

end if;

If updating then

   If :n.protocol_version_id <> :o.protocol_version_id or 
      :n.icf_version <> :o.icf_version or 
      (:n.icf_version is not null and :o.icf_version is null) or
      (:n.icf_version is null and :o.icf_version is not null)  then

   Insert into site_to_trial_pv_history (id,site_to_trial_id, protocol_version_id,
        pv_change_date,icf_version) values (
	site_to_trial_pv_history_seq.nextval, :n.id,:n.protocol_version_id,sysdate,
        :n.icf_version);

 end if;

end if;
end;
/
sho err

create or replace procedure delete_tmf_deliverable (tmfdelid number, ftuserid number) as
begin
 
   Insert into d_comment_item select ID,PARENT_ID,PARENT_TABLE,PARENT_FIELD,AUTHOR_ID,      
   CREATE_DATE,COMMENTS,AUTHOR_NAME,sysdate ,ftuserid from comment_item where
   parent_table = 'TMF_DELIVERABLE' and parent_id = tmfdelid;

   Delete from comment_item where parent_table = 'TMF_DELIVERABLE'
   and parent_id = tmfdelid;

   Insert into d_tmf_deliverable select ID ,GLOBAL_TMF_DELIVERABLE_ID,
   TRIAL_ID ,NAME,DUE_DATE,IS_OPTIONAL, sysdate, ftuserid from 
   tmf_deliverable where id=tmfdelid;                    

   delete from tmf_deliverable where id=tmfdelid;

   commit;
end;
/
sho err

Alter procedure delete_global_tmf_deliverable compile;
sho err

-- Following changes are as per the mail of Kelly on 08/29/2001 at 15:25

Update subject_encounter set encounter_status = 'Scheduled' where
	encounter_status in ('Rescheduled','Toreschedule');

Alter table SUBJECT_ENCOUNTER drop constraint SUB_ENC_ENC_STATUS_CHECK;

Alter table SUBJECT_ENCOUNTER add constraint SUB_ENC_ENC_STATUS_CHECK 
	check ( Encounter_status in ('Completed','Missed','Inprogress',
       'Scheduled','Projected','NA','Entered In Error', 'Invalid',
       'Monitor Created' ));

-- Following changes are as per the mail of Kelly for Crystal on 08/29/2001 at 15:40 

Alter table site add (install_date date);

Alter table site_to_trial drop column install_date;

-- Following changes are as per the request of Colin on 08/29/2001 at 15:45

ALTER TABLE monitor_site_visit
DROP CONSTRAINT MON_SITE_VISIT_STATUS_CHECK;

ALTER TABLE monitor_site_visit
add CONSTRAINT MON_SITE_VISIT_STATUS_CHECK
check (status IN ('Complete','Pending', 'N/A'));

ALTER TABLE subject_encounter
DROP CONSTRAINT SUB_ENC_MON_STATUS_CHECK;

ALTER TABLE subject_encounter
add CONSTRAINT SUB_ENC_MON_STATUS_CHECK
check (Monitor_status IN ('Complete','Pending', 'N/A'));

-- Following changes are done on 09/05/2001 at 13:45

rename visit_type to visit_type_save;

drop trigger site_to_trial_tmp_trg1;
drop trigger subject_tmp_trg1;

-- Following stored procedure was added as per the request of Nancy on 09/10/2001 at 16:10

create or replace procedure delete_tmf_deliverable_event (tmfdelevntid number, ftuserid number) as
begin

   Insert into d_tmf_deliverable_event select event_core_id,site_to_trial_id,
   due_date, last_update, status, date_completed, sysdate, ftuserid,
   is_optional, long_desc from tmf_deliverable_event where event_core_id=tmfdelevntid ;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id = tmfdelevntid;

   delete from tmf_deliverable_event where event_core_id = tmfdelevntid;

   delete from event_core where id = tmfdelevntid;

   Insert into d_comment_item select ID,PARENT_ID,PARENT_TABLE,PARENT_FIELD,AUTHOR_ID,      
   CREATE_DATE,COMMENTS,AUTHOR_NAME,sysdate ,ftuserid from comment_item where
   parent_table = 'TMF_DELIVERABLE_EVENT' and parent_id = tmfdelevntid;

   delete from comment_item where
   parent_table = 'TMF_DELIVERABLE_EVENT' and parent_id = tmfdelevntid;

end;
/
sho err

-- Following changes has been done as per the request from Crystal on 09/17/2001 at 10 am

Insert into ft_foreign_key_info values (ft_foreign_key_info_seq.nextval,
'MONITOR_SITE_VISIT','EVENT_CORE_ID','COMMENT_ITEM','PARENT_ID');

commit;

-- Following changes has been done as per Joel's mail on 09/19/2001 at 10:10 am

Insert into comment_item select comment_item_seq.nextval, event_core_id,
	'SUBJECT_ENCOUNTER','MONITOR_NOTE',1,sysdate,monitor_note,'Unknown'
	from subject_encounter where monitor_note is not null;

Insert into comment_item select comment_item_seq.nextval, event_core_id,
	'UNENCODED_EVENT','MONITOR_NOTE',1,sysdate,monitor_note,'Unknown'
	from unencoded_event where monitor_note is not null;

Alter table subject_encounter drop column monitor_note;

Alter table unencoded_event drop column monitor_note;


Insert into d_comment_item select comment_item_seq.nextval, event_core_id,
	'SUBJECT_ENCOUNTER','MONITOR_NOTE',1,sysdate,monitor_note,'Unknown',
        Delete_date, delete_ftuser_id from d_subject_encounter where
        monitor_note is not null;

Insert into d_comment_item select comment_item_seq.nextval, event_core_id,
	'UNENCODED_EVENT','MONITOR_NOTE',1,sysdate,monitor_note,'Unknown',
        Delete_date, delete_ftuser_id from d_unencoded_event where
        monitor_note is not null;

Alter table d_subject_encounter drop column monitor_note;

Alter table d_unencoded_event drop column monitor_note;


create or replace procedure delete_subject_encounter (seid number, ftuserid number) as
begin

   delete from del_temp_patsub;

   Insert into del_temp_patsub select event_core_id from general_event
   where attached_object_type='Event' and
   attached_object_id=seid;  

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Event' and
   attached_object_id=seid;

   delete from general_event where attached_object_type='Event' and
   attached_object_id=seid;

   Insert into d_subject_encounter
   select EVENT_CORE_ID,ENCOUNTER_STATUS,RESCHED_EVENT_ID,PROTOCOL_VERSION_ID,            
   ENCOUNTER_NOTE,MONITOR_STATUS,SEQ,PARENT_PEG_INST_ID,HIDE,CREATOR,                        
   SUBJECT_ID,ICF_VERSION,MONITOR_SEE_PAPER_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,   
   TIME_PERIOD_CATEGORY,MIN_DATE,MIN_DATE_PRECISION,MAX_DATE,MAX_DATE_PRECISION,            
   PREF_DATE,PREF_DATE_PRECISION,sysdate,ftuserid 
   from subject_encounter where EVENT_CORE_ID=seid;
  
   delete from subject_encounter where EVENT_CORE_ID=seid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id = seid;

   delete from event_core where id = seid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id in (select col1 from del_temp_patsub);

   delete from event_core where id in (select col1 from del_temp_patsub);

   delete from del_temp_patsub;

   commit;

end;
/
sho err

create or replace procedure delete_subject (subid number, ftuserid number) as
begin

   Insert into d_subject 
   select ID,PATIENT_ID,SITE_TO_TRIAL_ID,ENROLLING_MD,ICF_VERSION,ICF_DATE_SIGNED,               
   NEXT_VISIT_TYPE_ID,NEXT_VISIT_DATE,SUBJECT_STATUS,NOTE,SUBJECT_ID,                     
   NEXT_VISIT_TYPE_NAME,ENROLLED_DATE,LAST_MODIFIED_DATE,SCREENING_IDENTIFIER,           
   ASSIGNED_CC_ID,COMPLETED_ENCOUNTERS,UNMONITORED_SCREENING_VISITS,   
   UNMONITORED_TREATMENT_VISITS,UNMONITORED_FOLLOWUP_VISITS,UNMONITORED_SCREENFAIL_VISITS,
   UNMONITORED_EARLYTERM_VISITS,PROTOCOL_VERSION_ID,INITIAL_ICF_VERSION,            
   INITIAL_ICF_DATE,SCREENING_ID,CREATE_DT,SPONSOR_NOTE,sysdate,ftuserid,
   subject_disposition_id, dual_version_code                   
   from subject where id=subid;


   delete from del_temp_patsub;

   Insert into del_temp_patsub select event_core_id from general_event 
   where event_core_id in (select
   a.id from event_core a, subject_encounter b 
   where a.id=b.event_core_id
   and b.subject_id=subid);

   Insert into del_temp_patsub select event_core_id from general_event 
   where attached_object_type='Subject' and
   attached_object_id = subid ;

   Insert into del_temp_patsub select event_core_id from general_event
   where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   subject_id=subid);

   Insert into d_general_event 
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where event_core_id in (select
   a.id from event_core a, subject_encounter b 
   where a.id=b.event_core_id
   and b.subject_id=subid);

   delete from general_event where event_core_id in (select
   a.id from event_core a, subject_encounter b 
   where a.id=b.event_core_id
   and b.subject_id=subid);

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Subject' and
   attached_object_id=subid;

   delete from general_event where attached_object_type='Subject' and
   attached_object_id=subid;

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   subject_id=subid);

   delete from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   subject_id=subid);

   Insert into del_temp_patsub select a.event_core_id 
   from subject_encounter a where
   a.subject_id = subid;

   Insert into del_temp_patsub select a.event_core_id 
   from unencoded_event a where
   a.subject_id = subid;

   Insert into del_temp_patsub select a.event_core_id 
   from protocol_evgroup_inst a where
   a.subject_id = subid;

   Insert into d_subject_encounter
   select EVENT_CORE_ID,ENCOUNTER_STATUS,RESCHED_EVENT_ID,PROTOCOL_VERSION_ID,            
   ENCOUNTER_NOTE,MONITOR_STATUS,SEQ,PARENT_PEG_INST_ID,HIDE,CREATOR,                        
   SUBJECT_ID,ICF_VERSION,MONITOR_SEE_PAPER_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,   
   TIME_PERIOD_CATEGORY,MIN_DATE,MIN_DATE_PRECISION,MAX_DATE,MAX_DATE_PRECISION,            
   PREF_DATE,PREF_DATE_PRECISION,sysdate,ftuserid 
   from subject_encounter where subject_id = subid;
  
   delete from subject_encounter where subject_id = subid;

   Insert into d_unencoded_event
   select EVENT_CORE_ID,ENCOUNTER_STATUS,MONITOR_STATUS,HIDE,CREATOR,                        
   PARENT_PEG_INST_ID,SEQ,SUBJECT_ID,MONITOR_SEE_PAPER_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,
   RESCHED_EVENT_ID,sysdate,ftuserid                
   from unencoded_event where subject_id = subid;

   delete from unencoded_event where subject_id = subid;

   Insert into d_protocol_evgroup_inst
   select EVENT_CORE_ID,PARENT_PEGINST_ID,ANCHOR_DATE,PROTOCOL_VERSION_ID,
   SUBJECT_ID,SEQ,CREATOR,UNENCODED_EVENT_PEG,sysdate,ftuserid
   from protocol_evgroup_inst where subject_id = subid;

   delete from protocol_evgroup_inst where subject_id = subid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id in (select col1 from del_temp_patsub);

   delete from event_core where id in (select col1 from del_temp_patsub);

   delete from del_temp_patsub;

   delete from subject where id=subid;
   commit;
end;
/

sho err

Alter procedure delete_patient compile;

sho err

Alter table d_site_to_trial drop column install_date;

create or replace procedure delete_site_to_trial (sttid number, ftuserid number) 
as
cursor c1 is select id from subject where site_to_trial_id=sttid;
cursor c2 is select event_core_id from monitor_site_visit where site_to_trial_id=sttid;

begin

   Insert into d_site_to_trial 
   select ID,SITE_ID,TRIAL_ID,PROTOCOL_VERSION_ID,SITE_SPONSOR_NAME,SITE_TRIAL_NAME,                
   SITE_VERSION_NAME,ACCRUAL_STATUS,PATIENT_MNGMENT_STS,TARGET_ENROLLMENT,EXPECTED_ACCRUAL_CLOSE,         
   ONFOLLOWUPCNT,COMPLETEDCNT,ICF_VERSION,EXPECTED_TRIAL_COMPLETION_DATE,ENROLLEDCNT,                    
   LAST_MONITOR_DATE,NEXT_MONITOR_DATE,KEY_ELIGIB_SUMMARY,EXPECTED_LPLV_DATE,CRA_NOTES,                      
   WHO_MAINTAINS_STATS,NUM_DECEASED,LAST_MODIFIED_DATE,ACCRUAL_START_DATE,SITE_NUMBER,                    
   SITE_SHORT_TITLE,CC_FTUSER_ID,PI_FTUSER_ID,ONTREATMENTCNT,EARLYTERMCNT_DIED,              
   EARLYTERMCNT_LOSTTOFOLLOWUP,EARLYTERMCNT_OTHER,SCREENFAILURECNT_DIED,          
   SCREENFAILURECNT_NOTELIGIBLE,SCREENFAILURECNT_OTHER,SCREENINGCNT,NOTASSIGNEDCNT,                 
   LATEST_ICF_DATE,VERSION_CHANGE_CODE,sysdate,ftuserid
   from site_to_trial where id=sttid;                   


for ix1 in c1 loop
  delete_subject(ix1.id,ftuserid);
end loop;

for ix2 in c2 loop
  delete_monitor_site_visit(ix2.event_core_id, ftuserid);
end loop;


   delete from del_temp_patsub;

   Insert into del_temp_patsub select event_core_id from tmf_deliverable_event 
   where  site_to_trial_id = sttid;

   Insert into d_tmf_deliverable_event select event_core_id,site_to_trial_id,
   due_date, last_update, status, date_completed, sysdate, ftuserid ,
   is_optional, long_desc from tmf_deliverable_event where site_to_trial_id = sttid ;

   delete from tmf_deliverable_event where site_to_trial_id = sttid ;

   Insert into d_setup_event_mon_instance select 
   ID,SETUP_EVENT_STATUS,MONITOR_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,
   STUDY_SETUP_EVENT_CORE_ID,sysdate,ftuserid from 
   setup_event_mon_instance where 
   study_setup_event_core_id in (select event_core_id from
   study_setup_event where site_to_trial_id=sttid);      

   delete from setup_event_mon_instance where 
   study_setup_event_core_id in (select event_core_id from
   study_setup_event where site_to_trial_id=sttid);

   Insert into del_temp_patsub select event_core_id from study_setup_event
   where  site_to_trial_id = sttid;

   Insert into d_study_setup_event 
   select EVENT_CORE_ID,LONG_DESC,CREATOR,REQUIRED_FOR_ACCRUAL,REMIND_DATE,            
   VISIBILITY,COMPLETED_DATE,MONITOR_BY_DATE,SITE_TO_TRIAL_ID,ASSIGNED_COORDINATOR,
   DOCUMENT_VERSION,COMPLETION_AUTHORITY,CREATOR_COMPLETE,sysdate,ftuserid
   from study_setup_event where  site_to_trial_id = sttid;     

   delete from study_setup_event where site_to_trial_id=sttid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id in (select col1 from del_temp_patsub);

   delete from event_core where id in (select col1 from del_temp_patsub);

   delete from del_temp_patsub;

   Insert into d_monitor_to_site_to_trial 
   select ID,SITE_TO_TRIAL_ID,ROLE,FTUSER_ID,sysdate,ftuserid
   from monitor_to_site_to_trial where site_to_trial_id = sttid;
            
   delete from monitor_to_site_to_trial where site_to_trial_id = sttid;

   delete from site_to_trial where id = sttid;

   commit;

end ;
/
sho err

Alter table d_site add (install_date date);

Create or replace procedure delete_site (siteid in number,ftuserid in number) as

cursor c1 is select id from site_to_trial where site_id = siteid;
cursor c2 is select id from patient where site_id = siteid;

begin

for ix1 in c1 loop
 delete_site_to_trial(ix1.id,ftuserid);
end loop;

for ix2 in c2 loop
 delete_patient(ix2.id, ftuserid);
end loop;

delete from del_temp_patsub;

Insert into del_temp_patsub select event_core_id from general_event 
	where event_core_id in ( select id from 
	event_core where site_id = siteid);

Insert into d_general_event
   	select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   	EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   	from general_event where event_core_id in ( select id from 
	event_core where site_id = siteid);

delete from general_event where event_core_id in ( select id from 
	event_core where site_id = siteid);

Insert into d_event_core select ID,TEMPLATE_ID,NAME,CREATOR_ID,             
	DATE_TIME,TEMPLATE_TYPE,SITE_ID,DATE_TIME_PRECISION,
	DISMISSED,sysdate,ftuserid from event_core where 
	id in (select col1 from del_temp_patsub);             

Delete from event_core where  id in (select col1 from del_temp_patsub);

delete from del_temp_patsub;

Insert into d_event_core select ID,TEMPLATE_ID,NAME,CREATOR_ID,             
	DATE_TIME,TEMPLATE_TYPE,SITE_ID,DATE_TIME_PRECISION,
	DISMISSED,sysdate,ftuserid from event_core where 
	site_id=siteid;

Delete from event_core where site_id=siteid;

Insert into d_cra_manager_to_monitor 
	select ID,MANAGER_FTUSER_ID,FTUSER_ID,sysdate,ftuserid from
	cra_manager_to_monitor where ftuser_id in (select
	id from ftuser where site_id=siteid);            

Delete from  cra_manager_to_monitor where ftuser_id in (select
	id from ftuser where site_id=siteid);

Insert into d_cra_manager_to_monitor
	select ID,MANAGER_FTUSER_ID,FTUSER_ID,sysdate,ftuserid from
	cra_manager_to_monitor where manager_ftuser_id in (select
	id from ftuser where site_id=siteid);

Delete from  cra_manager_to_monitor where manager_ftuser_id in (select
	id from ftuser where site_id=siteid);

Insert into d_cra_manager_to_trial 
	select ID,MANAGER_FTUSER_ID,TRIAL_ID,sysdate,ftuserid from
    	cra_manager_to_trial where manager_ftuser_id in (select
	id from ftuser where site_id=siteid);               

Delete from  cra_manager_to_trial where manager_ftuser_id in (select
	id from ftuser where site_id=siteid);

Insert into d_ftuser_taclassifier_filter
	select ID,FTUSER_ID,TACLASSIFIER_ID,sysdate,ftuserid from
	ftuser_taclassifier_filter where ftuser_id in (select
	id from ftuser where site_id=siteid);        

Delete from  ftuser_taclassifier_filter where ftuser_id in (select
	id from ftuser where site_id=siteid); 

Insert into d_ftuser_to_aclentries
	select ID,FTUSER_ID,ACLENTRIES_ID,sysdate,ftuserid from
	ftuser_to_aclentries where ftuser_id in (select
	id from ftuser where site_id=siteid); 

Delete from  ftuser_to_aclentries where ftuser_id in (select
	id from ftuser where site_id=siteid); 

Insert into d_ftuser_to_ftgroup 
	select ID,FTUSER_ID,FTGROUP_ID,sysdate,ftuserid from
	ftuser_to_ftgroup where ftuser_id in (select
	id from ftuser where site_id=siteid); 

Delete from  ftuser_to_ftgroup where ftuser_id in (select
	id from ftuser where site_id=siteid); 

Insert into d_ftuser_trial_filter 
	select ID,FTUSER_ID,TRIAL_ID,sysdate,ftuserid from
	ftuser_trial_filter where ftuser_id in (select
	id from ftuser where site_id=siteid);        

Delete from  ftuser_trial_filter where ftuser_id in (select
	id from ftuser where site_id=siteid); 

Insert into d_hhgroup_to_classifiers
	select ID,TACLASSIFIER_ID,HANDHELD_GROUP_ID,sysdate,ftuserid
	from hhgroup_to_classifiers where handheld_group_id in (select
	id from handheld_group where site_id=siteid);

Delete from hhgroup_to_classifiers where handheld_group_id in (select
	id from handheld_group where site_id=siteid);

Insert into d_handheld_device 
	select ID,DEVICE_ID,HANDHELD_GROUP_ID,LAST_SYNCH_TIME,        
	HH_TYPE,COMMENTS,AVANTGO_ID,FTUSER_ID,PIN,sysdate,ftuserid
	from handheld_device where ftuser_id in (select
	id from ftuser where site_id=siteid);                    

Delete from  handheld_device where ftuser_id in (select
	id from ftuser where site_id=siteid);

Insert into d_handheld_device 
	select ID,DEVICE_ID,HANDHELD_GROUP_ID,LAST_SYNCH_TIME,        
	HH_TYPE,COMMENTS,AVANTGO_ID,FTUSER_ID,PIN,sysdate,ftuserid
	from handheld_device where device_id in (select
	name from ftuser where site_id=siteid);

Delete from  handheld_device where device_id in (select
	name from ftuser where site_id=siteid);

Insert into d_handheld_device 
	select ID,DEVICE_ID,HANDHELD_GROUP_ID,LAST_SYNCH_TIME,        
	HH_TYPE,COMMENTS,AVANTGO_ID,FTUSER_ID,PIN,sysdate,ftuserid
	from handheld_device where handheld_group_id in (select
	id from handheld_group where site_id=siteid);

Delete from  handheld_device where handheld_group_id in (select
	id from handheld_group where site_id=siteid);

Insert into d_monitor 
	select CRA_TYPE,FTUSER_ID,sysdate,ftuserid from 
	monitor where ftuser_id in (select
	id from ftuser where site_id=siteid); 

Delete from  monitor where ftuser_id in (select
	id from ftuser where site_id=siteid); 

Insert into d_monitor_to_site_to_trial 
	select ID,SITE_TO_TRIAL_ID,ROLE,FTUSER_ID,sysdate,ftuserid
	from monitor_to_site_to_trial where ftuser_id in (select
	id from ftuser where site_id=siteid);              

Delete from  monitor_to_site_to_trial where ftuser_id in (select
	id from ftuser where site_id=siteid);

Insert into d_site_to_trial 
   select ID,SITE_ID,TRIAL_ID,PROTOCOL_VERSION_ID,SITE_SPONSOR_NAME,SITE_TRIAL_NAME,                
   SITE_VERSION_NAME,ACCRUAL_STATUS,PATIENT_MNGMENT_STS,TARGET_ENROLLMENT,EXPECTED_ACCRUAL_CLOSE,         
   ONFOLLOWUPCNT,COMPLETEDCNT,ICF_VERSION,EXPECTED_TRIAL_COMPLETION_DATE,ENROLLEDCNT,                    
   LAST_MONITOR_DATE,NEXT_MONITOR_DATE,KEY_ELIGIB_SUMMARY,EXPECTED_LPLV_DATE,CRA_NOTES,                      
   WHO_MAINTAINS_STATS,NUM_DECEASED,LAST_MODIFIED_DATE,ACCRUAL_START_DATE,SITE_NUMBER,                    
   SITE_SHORT_TITLE,CC_FTUSER_ID,PI_FTUSER_ID,ONTREATMENTCNT,EARLYTERMCNT_DIED,              
   EARLYTERMCNT_LOSTTOFOLLOWUP,EARLYTERMCNT_OTHER,SCREENFAILURECNT_DIED,          
   SCREENFAILURECNT_NOTELIGIBLE,SCREENFAILURECNT_OTHER,SCREENINGCNT,NOTASSIGNEDCNT,                 
   LATEST_ICF_DATE,VERSION_CHANGE_CODE,sysdate,ftuserid
   from site_to_trial where cc_ftuser_id in (select 
   id from ftuser where site_id=siteid);

Delete from  site_to_trial where cc_ftuser_id in (select 
	id from ftuser where site_id=siteid);

Insert into d_site_to_trial 
   select ID,SITE_ID,TRIAL_ID,PROTOCOL_VERSION_ID,SITE_SPONSOR_NAME,SITE_TRIAL_NAME,                
   SITE_VERSION_NAME,ACCRUAL_STATUS,PATIENT_MNGMENT_STS,TARGET_ENROLLMENT,EXPECTED_ACCRUAL_CLOSE,         
   ONFOLLOWUPCNT,COMPLETEDCNT,ICF_VERSION,EXPECTED_TRIAL_COMPLETION_DATE,ENROLLEDCNT,                    
   LAST_MONITOR_DATE,NEXT_MONITOR_DATE,KEY_ELIGIB_SUMMARY,EXPECTED_LPLV_DATE,CRA_NOTES,                      
   WHO_MAINTAINS_STATS,NUM_DECEASED,LAST_MODIFIED_DATE,ACCRUAL_START_DATE,SITE_NUMBER,                    
   SITE_SHORT_TITLE,CC_FTUSER_ID,PI_FTUSER_ID,ONTREATMENTCNT,EARLYTERMCNT_DIED,              
   EARLYTERMCNT_LOSTTOFOLLOWUP,EARLYTERMCNT_OTHER,SCREENFAILURECNT_DIED,          
   SCREENFAILURECNT_NOTELIGIBLE,SCREENFAILURECNT_OTHER,SCREENINGCNT,NOTASSIGNEDCNT,                 
   LATEST_ICF_DATE,VERSION_CHANGE_CODE,sysdate,ftuserid
   from site_to_trial where pi_ftuser_id in (select 
   id from ftuser where site_id=siteid);

Delete from  site_to_trial where pi_ftuser_id in (select 
	id from ftuser where site_id=siteid);

Insert into d_handheld_group 
	select ID,NAME,SITE_ID,PIN,sysdate,ftuserid from
	handheld_group where site_id=siteid;	    

Delete from handheld_group where site_id=siteid;

Insert into d_site select ID,SITE_IDENTIFIER,NAME,FT_SITE_NAME,BASE_FASTTRACK_URL,     
	MAIN_SITE_LOCATION,TIME_ZONE_ID,LOCALE,HANDHELD_STALE_PERIOD,  
	MAIN_SITE_CONTACT_ID,SITE_ACRONYM,NUM_WEEKS_PAST_ON_HH,NUM_WEEKS_FORWARD_ON_HH,
	ADDRESS_LINE_1,ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,                
	CONFIDENTIALITY_MESSAGE,sysdate,ftuserid,install_date from site where id=siteid;

Insert into d_ftuser select ID,NAME,PASSWORD,SITE_ID,STARTING_SCREEN,        
	LAST_PASSWORD_UPDATE,FIRST_NAME,LAST_NAME,LAST_LOGIN_DATE,PRIMARY_TA_ID,          
	ADDRESS_LINE_1,ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,WORK_PHONE,             
	HOME_PHONE,FAX,MOBILE_PHONE,EMAIL,PREFERRED_CONTACT,TITLE,CLIENT_ID,
	sysdate,ftuserid from ftuser where id in (select id from del_temp_ftuser);

update site set main_site_contact_id = (
	select min(id) from ftuser where upper(name)='SYSTEM')
       	where id=siteid;

Delete from ftuser where site_id = siteid;

Delete from site where id = siteid;

commit;

end;
/
sho err

drop procedure site_migration;

-- The following trigger was changed because of the data problems of gary and 
-- suggestion of Kelly on 09/24/2001 at 9:05 am


create or replace trigger site_to_trial_trg2
after insert or update of  site_id,cc_ftuser_id, pi_ftuser_id, patient_mngment_sts on site_to_trial
referencing new as n old as o
for each row

declare

site1_thro_ftuser  ftuser.site_id%type;
site2_thro_ftuser  ftuser.site_id%type;
Invalid_site_cc exception;
Invalid_site_pi exception;
pegtopegcnt number(10);
Invalid_patient_mgmt_status exception;

begin

 If :n.cc_ftuser_id is not null then 

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
 End if;

 If upper(:n.patient_mngment_sts) ='ACTIVE' then
   
   select count(*) into pegtopegcnt from peg_to_peg where 
   protocol_version_id = :n.protocol_version_id and
   parent_evgroup_id is null;

   If pegtopegcnt = 0 then 
      raise Invalid_patient_mgmt_status;
   end if;
 end if;

exception

  When Invalid_site_cc then
       Raise_application_error(-20034,'Not a valid site for cc_ftuser_id');
  when invalid_site_pi then 
       Raise_application_error(-20035,'Site_id invalid between cc_ftuser_id and pi_ftuser_id');
  when Invalid_patient_mgmt_status then
       Raise_application_error(-20052,'No peg_to_peg. Patient_mngment_sts can not be Active');

end;
/

sho err

-- Following changes has been done as per Joel on 09/25/2001 at 9:10 am

Insert into comment_item select comment_item_seq.nextval, event_core_id,
	'MONITOR_SITE_VISIT','MONITOR_NOTE',1,sysdate,monitor_note,'Unknown'
	from monitor_site_visit where monitor_note is not null;

Alter table monitor_site_visit drop column monitor_note;

Insert into d_comment_item select comment_item_seq.nextval, event_core_id,
	'MONITOR_SITE_VISIT','MONITOR_NOTE',1,sysdate,monitor_note,'Unknown',
        Delete_date, delete_ftuser_id from d_monitor_site_visit where
        monitor_note is not null;

Alter table d_monitor_site_visit drop column monitor_note;

create or replace procedure delete_monitor_site_visit (msvid number, ftuserid number) as
begin

   Insert into d_setup_event_mon_instance 
   select ID,SETUP_EVENT_STATUS,MONITOR_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,
   STUDY_SETUP_EVENT_CORE_ID,sysdate,ftuserid from setup_event_mon_instance
   where  MON_SITE_VISIT_EVENT_CORE_ID = msvid;

   delete from setup_event_mon_instance
   where  MON_SITE_VISIT_EVENT_CORE_ID = msvid;     

   delete from del_temp_patsub;

   Insert into del_temp_patsub values (msvid);

   Insert into del_temp_patsub 
   select event_core_id 
   from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   mon_site_visit_event_core_id = msvid);

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   mon_site_visit_event_core_id = msvid);

   delete from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   mon_site_visit_event_core_id = msvid);

   update subject_encounter set mon_site_visit_event_core_id = null
   where mon_site_visit_event_core_id = msvid;

   update unencoded_event set mon_site_visit_event_core_id = null 
   where mon_site_visit_event_core_id = msvid;

   Insert into d_monitor_site_visit 
   select EVENT_CORE_ID,SITE_TO_TRIAL_ID,START_DATE,END_DATE,              
   STATUS,FTUSER_ID,sysdate,ftuserid,type, visit_duration, how_conducted
   from monitor_site_visit where event_core_id = msvid;

   delete from monitor_site_visit where event_core_id = msvid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id in (select col1 from del_temp_patsub);

   delete from event_core where id in (select col1 from del_temp_patsub);

   delete from del_temp_patsub;

   commit;

end;
/
sho err

Alter procedure DELETE_SITE_TO_TRIAL compile;
Alter procedure DELETE_SITE compile;

-- Following changes to ciload was done to load sponsor.short_name 
-- as per request of Kelly on 09/25/2001 at 15:45

Alter table sponsor add(short_name varchar2(50));

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
        Insert into sponsor(id,name,short_name)
        select ft_ui,nvl(preferred_long_name,'Unknown'),nvl(preferred_short_name,'Unknown')
        from ci_sponsor where ft_ui=ix1.ft_ui;
   End if;

   If id_exist=1 then
        Update sponsor set (name, short_name) =(select nvl(preferred_long_name,'Unknown'),
        nvl(preferred_short_name,'Unknown') from ci_sponsor 
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

-- Following changes are as per the request(verbal) from Gary on 09/27/2001 at 15:30 hrs

Alter table subject add (unev_completed_encounters number(10) default 0);

Update subject a set a.unev_completed_encounters = (select count(*) from unencoded_event b where
	b.encounter_status = 'Completed' and b.subject_id = a.id);

commit;

create or replace trigger unencoded_event_status_trg2
after insert or delete or update on unencoded_event
referencing new as n old as o
for each row
declare

v_name misc_event_prototype.name%type;

begin

If inserting then

  Select a.name into v_name from misc_event_prototype a, event_core b where
  b.template_id=a.id and b.id=:n.event_core_id;

  If :n.encounter_status='Completed' then

	if ( :n.creator = 'Site' and :n.hide = 0) then

           update subject set unev_completed_encounters = nvl(unev_completed_encounters,0)+1
           where id = :n.subject_id;

        if  :n.monitor_status is null or :n.monitor_status <> 'Completed' then

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

end if;


If updating then

  Select a.name into v_name from misc_event_prototype a, event_core b where
  b.template_id=a.id and b.id=:n.event_core_id;

  If ( :o.encounter_status <> 'Completed' and :n.encounter_status='Completed' ) then

	if (:n.creator = 'Site' and :n.hide = 0) then

           update subject set unev_completed_encounters = nvl(unev_completed_encounters,0)+1
           where id = :n.subject_id;

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

           update subject set unev_completed_encounters = nvl(unev_completed_encounters,0)-1
           where id = :n.subject_id;

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

If deleting then

  Select a.name into v_name from misc_event_prototype a, event_core b where
  b.template_id=a.id and b.id=:o.event_core_id;

  If :o.encounter_status='Completed' then

   if ( :o.creator = 'Site' and :o.hide = 0) then

         update subject set unev_completed_encounters = nvl(unev_completed_encounters,0)-1
         where id = :n.subject_id;

   if  :o.monitor_status is null or :o.monitor_status <> 'Completed' then

    If v_name = 'Early Termination' then 
	update subject set unmonitored_earlyterm_visits =
	nvl(unmonitored_earlyterm_visits,0) + 1 where id = :o.subject_id;
    elsif v_name = 'Screen Failure Termination' then 
	update subject set unmonitored_screenfail_visits =
	nvl(unmonitored_screenfail_visits,0) + 1 where id = :o.subject_id;
    end if;

         end if;
  end if;
  end if;

end if;

end;
/
sho err

Alter table d_subject add (UNEV_COMPLETED_ENCOUNTERS NUMBER(10));

create or replace procedure delete_subject (subid number, ftuserid number) as
begin

   Insert into d_subject 
   select ID,PATIENT_ID,SITE_TO_TRIAL_ID,ENROLLING_MD,ICF_VERSION,ICF_DATE_SIGNED,               
   NEXT_VISIT_TYPE_ID,NEXT_VISIT_DATE,SUBJECT_STATUS,NOTE,SUBJECT_ID,                     
   NEXT_VISIT_TYPE_NAME,ENROLLED_DATE,LAST_MODIFIED_DATE,SCREENING_IDENTIFIER,           
   ASSIGNED_CC_ID,COMPLETED_ENCOUNTERS,UNMONITORED_SCREENING_VISITS,   
   UNMONITORED_TREATMENT_VISITS,UNMONITORED_FOLLOWUP_VISITS,UNMONITORED_SCREENFAIL_VISITS,
   UNMONITORED_EARLYTERM_VISITS,PROTOCOL_VERSION_ID,INITIAL_ICF_VERSION,            
   INITIAL_ICF_DATE,SCREENING_ID,CREATE_DT,SPONSOR_NOTE,sysdate,ftuserid,
   subject_disposition_id, dual_version_code, unev_completed_encounters                   
   from subject where id=subid;


   delete from del_temp_patsub;

   Insert into del_temp_patsub select event_core_id from general_event 
   where event_core_id in (select
   a.id from event_core a, subject_encounter b 
   where a.id=b.event_core_id
   and b.subject_id=subid);

   Insert into del_temp_patsub select event_core_id from general_event 
   where attached_object_type='Subject' and
   attached_object_id = subid ;

   Insert into del_temp_patsub select event_core_id from general_event
   where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   subject_id=subid);

   Insert into d_general_event 
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where event_core_id in (select
   a.id from event_core a, subject_encounter b 
   where a.id=b.event_core_id
   and b.subject_id=subid);

   delete from general_event where event_core_id in (select
   a.id from event_core a, subject_encounter b 
   where a.id=b.event_core_id
   and b.subject_id=subid);

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Subject' and
   attached_object_id=subid;

   delete from general_event where attached_object_type='Subject' and
   attached_object_id=subid;

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   subject_id=subid);

   delete from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   subject_id=subid);

   Insert into del_temp_patsub select a.event_core_id 
   from subject_encounter a where
   a.subject_id = subid;

   Insert into del_temp_patsub select a.event_core_id 
   from unencoded_event a where
   a.subject_id = subid;

   Insert into del_temp_patsub select a.event_core_id 
   from protocol_evgroup_inst a where
   a.subject_id = subid;

   Insert into d_subject_encounter
   select EVENT_CORE_ID,ENCOUNTER_STATUS,RESCHED_EVENT_ID,PROTOCOL_VERSION_ID,            
   ENCOUNTER_NOTE,MONITOR_STATUS,SEQ,PARENT_PEG_INST_ID,HIDE,CREATOR,                        
   SUBJECT_ID,ICF_VERSION,MONITOR_SEE_PAPER_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,   
   TIME_PERIOD_CATEGORY,MIN_DATE,MIN_DATE_PRECISION,MAX_DATE,MAX_DATE_PRECISION,            
   PREF_DATE,PREF_DATE_PRECISION,sysdate,ftuserid 
   from subject_encounter where subject_id = subid;
  
   delete from subject_encounter where subject_id = subid;

   Insert into d_unencoded_event
   select EVENT_CORE_ID,ENCOUNTER_STATUS,MONITOR_STATUS,HIDE,CREATOR,                        
   PARENT_PEG_INST_ID,SEQ,SUBJECT_ID,MONITOR_SEE_PAPER_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,
   RESCHED_EVENT_ID,sysdate,ftuserid                
   from unencoded_event where subject_id = subid;

   delete from unencoded_event where subject_id = subid;

   Insert into d_protocol_evgroup_inst
   select EVENT_CORE_ID,PARENT_PEGINST_ID,ANCHOR_DATE,PROTOCOL_VERSION_ID,
   SUBJECT_ID,SEQ,CREATOR,UNENCODED_EVENT_PEG,sysdate,ftuserid
   from protocol_evgroup_inst where subject_id = subid;

   delete from protocol_evgroup_inst where subject_id = subid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id in (select col1 from del_temp_patsub);

   delete from event_core where id in (select col1 from del_temp_patsub);

   delete from del_temp_patsub;

   delete from subject where id=subid;
   commit;
end;
/

sho err

Alter procedure delete_patient compile;

sho err

Alter procedure delete_site_to_trial compile;

sho err

Alter procedure delete_site compile;

sho err

-- Following stored procedure was added as per the request of Nancy on 09/28/2001 at 11:50 AM


create table d_client as select * from client where 1=2;

Alter table d_client add (
	Delete_date date default sysdate not null,
	Delete_ftuser_id number(10) not null);

create or replace procedure delete_client (clientid number, ftuserid number) as

cursor c1 is select a.event_core_id from monitor_site_visit a, ftuser b where
  	     a.ftuser_id = b.id and b.client_id = clientid;
begin

	insert into d_client select ID,NAME,MAIN_CONTACT_ID,HANDHELD_STALE_PERIOD,  
	CLIENT_IDENTIFIER,CONFIDENTIALITY_MESSAGE,CLIENT_ACRONYM,sysdate,ftuserid
	from client where id = clientid;         
	
	insert into d_ftuser select ID,NAME,PASSWORD,SITE_ID,STARTING_SCREEN,        
	LAST_PASSWORD_UPDATE,FIRST_NAME,LAST_NAME,LAST_LOGIN_DATE,PRIMARY_TA_ID,          
	ADDRESS_LINE_1,ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,WORK_PHONE,             
	HOME_PHONE,FAX,MOBILE_PHONE,EMAIL,PREFERRED_CONTACT,TITLE,CLIENT_ID,
	sysdate,ftuserid from ftuser where client_id = clientid;	              

	insert into d_monitor_to_site_to_trial select ID,SITE_TO_TRIAL_ID,ROLE,FTUSER_ID,
	sysdate,ftuserid from monitor_to_site_to_trial where ftuser_id in (select id from ftuser
	where client_id = clientid);              

	insert into d_cra_manager_to_trial select ID,MANAGER_FTUSER_ID,TRIAL_ID,
	sysdate,ftuserid from cra_manager_to_trial where manager_ftuser_id in 
	(select id from ftuser where client_id = clientid);               

	insert into d_cra_manager_to_monitor select ID,MANAGER_FTUSER_ID,FTUSER_ID,
	sysdate,ftuserid from cra_manager_to_monitor where ftuser_id in (select id from ftuser
	where client_id = clientid);		              

	insert into d_monitor select CRA_TYPE,FTUSER_ID,sysdate,ftuserid
	from monitor where ftuser_id in (select id from ftuser
	where client_id = clientid);

	insert into d_ftuser_taclassifier_filter select ID,FTUSER_ID,TACLASSIFIER_ID,
	sysdate,ftuserid from ftuser_taclassifier_filter where ftuser_id in (select id from ftuser
	where client_id = clientid);

	insert into d_ftuser_trial_filter select ID,FTUSER_ID,TRIAL_ID,sysdate,ftuserid
	from ftuser_trial_filter where ftuser_id in (select id from ftuser
	where client_id = clientid);       

	insert into d_ftuser_to_aclentries select ID,FTUSER_ID,ACLENTRIES_ID,
	sysdate,ftuserid from ftuser_to_aclentries where ftuser_id in (select id from ftuser
	where client_id = clientid);

	insert into d_ftuser_to_ftgroup select ID,FTUSER_ID,FTGROUP_ID,sysdate,ftuserid
	from ftuser_to_ftgroup where ftuser_id in (select id from ftuser
	where client_id = clientid);

   for ix1 in c1 loop
    delete_monitor_site_visit(ix1.event_core_id,ftuserid);
   end loop;

        update trial set client_id = null where client_id=clientid;

        update event_core set creator_id = (select id from ftuser where 
        upper(name) = 'FTADMIN@FASTTRACK') where creator_id in (select id from ftuser
	where client_id = clientid);

	delete from monitor_to_site_to_trial where ftuser_id in (select id from ftuser
	where client_id = clientid);

        delete from cra_manager_to_trial where manager_ftuser_id in (select id from ftuser
	where client_id = clientid);
        
	delete from cra_manager_to_monitor where ftuser_id in (select id from ftuser
	where client_id = clientid);	

        delete from monitor where ftuser_id in (select id from ftuser
	where client_id = clientid);	

	delete from ftuser_taclassifier_filter where ftuser_id in (select id from ftuser
	where client_id = clientid);

	delete from ftuser_trial_filter where ftuser_id in (select id from ftuser
	where client_id = clientid);

	delete from ftuser_to_aclentries where ftuser_id in (select id from ftuser
	where client_id = clientid);

	delete from ftuser_to_ftgroup where ftuser_id in (select id from ftuser
	where client_id = clientid);

	insert into d_handheld_device select ID,DEVICE_ID,HANDHELD_GROUP_ID,      
	LAST_SYNCH_TIME,HH_TYPE,COMMENTS,AVANTGO_ID,FTUSER_ID,PIN,sysdate,ftuserid
	from handheld_device where  device_id in (select name from ftuser
	where client_id = clientid);                     

        delete from handheld_device where  device_id in (select name from ftuser
	where client_id = clientid);       

	insert into d_handheld_device select ID,DEVICE_ID,HANDHELD_GROUP_ID,      
	LAST_SYNCH_TIME,HH_TYPE,COMMENTS,AVANTGO_ID,FTUSER_ID,PIN,sysdate,ftuserid
	from handheld_device where  ftuser_id in (select id from ftuser
	where client_id = clientid);                     

        delete from handheld_device where  ftuser_id in (select id from ftuser
	where client_id = clientid);

        update client set main_contact_id=null where id = clientid;

        delete from ftuser where client_id = clientid;

        delete from client where id=clientid;

commit;
end;
/

sho err

-- Following stored_procedure has been added as per Kelly on 10/01/2001 at 14:15

create or replace procedure delete_unencoded_event (unevid number, ftuserid number) as
begin

   delete from del_temp_patsub;

   Insert into del_temp_patsub select event_core_id from general_event
   where attached_object_type='Event' and
   attached_object_id=unevid;  

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Event' and
   attached_object_id=unevid;

   delete from general_event where attached_object_type='Event' and
   attached_object_id=unevid;

   Insert into d_unencoded_event
   select EVENT_CORE_ID,ENCOUNTER_STATUS,MONITOR_STATUS,HIDE,CREATOR,                        
	PARENT_PEG_INST_ID,SEQ,SUBJECT_ID,MONITOR_SEE_PAPER_NOTE,         
	MON_SITE_VISIT_EVENT_CORE_ID,RESCHED_EVENT_ID,sysdate,ftuserid 
   from unencoded_event where EVENT_CORE_ID=unevid;
  
   delete from unencoded_event where EVENT_CORE_ID=unevid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id = unevid;

   delete from event_core where id = unevid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id in (select col1 from del_temp_patsub);

   delete from event_core where id in (select col1 from del_temp_patsub);

   delete from del_temp_patsub;

   commit;

end;
/
sho err

create or replace procedure delete_patient  (patid number, ftuserid number) as
 cursor c1 is select id from subject where patient_id = patid;
begin

   delete from del_temp_patsub;

   Insert into del_temp_patsub select event_core_id from general_event
   where attached_object_type='Patient' and
   attached_object_id=patid;  

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Patient' and
   attached_object_id=patid;

   delete from general_event where attached_object_type = 'Patient' and
   attached_object_id = patid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id in (select col1 from del_temp_patsub);

   delete from event_core where id in (select col1 from del_temp_patsub);

   delete from del_temp_patsub;

  for ix1 in c1 loop
    delete_subject(ix1.id, ftuserid);
  end loop;

   Insert into d_medical_record_number
   select ID,PATIENT_ID,MRNUMBER,APP_ID,sysdate,ftuserid
   from medical_record_number where patient_id=patid;

   delete from medical_record_number where patient_id=patid;

   Insert into d_patient 
   select ID,SITE_ID,FIRST_NAME,LAST_NAME,INITIALS,ADDRESS_LINE_1,ADDRESS_LINE_2,         
   CITY,WORK_PHONE,STATE,POSTAL_CODE,COUNTRY,HOME_PHONE,FAX,EMAIL,GENDER,                 
   DATE_OF_BIRTH,RACE,MOBILE_PHONE,MIDDLE_INITIALS,PREFERRED_CONTACT,
   STATUS,CREATE_DT,sysdate,ftuserid
   from patient where id=patid;

   delete from patient where id=patid;

   commit;

end;
/

sho err


-- Following update as per the mail of Kelly on 10/01/2001 at 15:45

update patient set status ='Active' where status is null;

commit;

-- Following changes are as per the request from Allen on 10/2/2001 at 4 pm

Alter table subject_encounter add(last_hh_activity_date date);

Alter table unencoded_event add(last_hh_activity_date date);

Alter table d_subject_encounter add(last_hh_activity_date date);

Alter table d_unencoded_event add(last_hh_activity_date date);

create or replace procedure delete_subject_encounter (seid number, ftuserid number) as
begin

   delete from del_temp_patsub;

   Insert into del_temp_patsub select event_core_id from general_event
   where attached_object_type='Event' and
   attached_object_id=seid;  

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Event' and
   attached_object_id=seid;

   delete from general_event where attached_object_type='Event' and
   attached_object_id=seid;

   Insert into d_subject_encounter
   select EVENT_CORE_ID,ENCOUNTER_STATUS,RESCHED_EVENT_ID,PROTOCOL_VERSION_ID,            
   ENCOUNTER_NOTE,MONITOR_STATUS,SEQ,PARENT_PEG_INST_ID,HIDE,CREATOR,                        
   SUBJECT_ID,ICF_VERSION,MONITOR_SEE_PAPER_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,   
   TIME_PERIOD_CATEGORY,MIN_DATE,MIN_DATE_PRECISION,MAX_DATE,MAX_DATE_PRECISION,            
   PREF_DATE,PREF_DATE_PRECISION,sysdate,ftuserid,last_hh_activity_date 
   from subject_encounter where EVENT_CORE_ID=seid;
  
   delete from subject_encounter where EVENT_CORE_ID=seid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id = seid;

   delete from event_core where id = seid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id in (select col1 from del_temp_patsub);

   delete from event_core where id in (select col1 from del_temp_patsub);

   delete from del_temp_patsub;

   commit;

end;
/
sho err


create or replace procedure delete_unencoded_event (unevid number, ftuserid number) as
begin

   delete from del_temp_patsub;

   Insert into del_temp_patsub select event_core_id from general_event
   where attached_object_type='Event' and
   attached_object_id=unevid;  

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Event' and
   attached_object_id=unevid;

   delete from general_event where attached_object_type='Event' and
   attached_object_id=unevid;

   Insert into d_unencoded_event
   select EVENT_CORE_ID,ENCOUNTER_STATUS,MONITOR_STATUS,HIDE,CREATOR,                        
	PARENT_PEG_INST_ID,SEQ,SUBJECT_ID,MONITOR_SEE_PAPER_NOTE,         
	MON_SITE_VISIT_EVENT_CORE_ID,RESCHED_EVENT_ID,sysdate,ftuserid,
	last_hh_activity_date 
   from unencoded_event where EVENT_CORE_ID=unevid;
  
   delete from unencoded_event where EVENT_CORE_ID=unevid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id = unevid;

   delete from event_core where id = unevid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id in (select col1 from del_temp_patsub);

   delete from event_core where id in (select col1 from del_temp_patsub);

   delete from del_temp_patsub;

   commit;

end;
/
sho err
create or replace procedure delete_subject (subid number, ftuserid number) as
begin

   Insert into d_subject 
   select ID,PATIENT_ID,SITE_TO_TRIAL_ID,ENROLLING_MD,ICF_VERSION,ICF_DATE_SIGNED,               
   NEXT_VISIT_TYPE_ID,NEXT_VISIT_DATE,SUBJECT_STATUS,NOTE,SUBJECT_ID,                     
   NEXT_VISIT_TYPE_NAME,ENROLLED_DATE,LAST_MODIFIED_DATE,SCREENING_IDENTIFIER,           
   ASSIGNED_CC_ID,COMPLETED_ENCOUNTERS,UNMONITORED_SCREENING_VISITS,   
   UNMONITORED_TREATMENT_VISITS,UNMONITORED_FOLLOWUP_VISITS,UNMONITORED_SCREENFAIL_VISITS,
   UNMONITORED_EARLYTERM_VISITS,PROTOCOL_VERSION_ID,INITIAL_ICF_VERSION,            
   INITIAL_ICF_DATE,SCREENING_ID,CREATE_DT,SPONSOR_NOTE,sysdate,ftuserid,
   subject_disposition_id, dual_version_code,UNEV_COMPLETED_ENCOUNTERS                   
   from subject where id=subid;


   delete from del_temp_patsub;

   Insert into del_temp_patsub select event_core_id from general_event 
   where event_core_id in (select
   a.id from event_core a, subject_encounter b 
   where a.id=b.event_core_id
   and b.subject_id=subid);

   Insert into del_temp_patsub select event_core_id from general_event 
   where attached_object_type='Subject' and
   attached_object_id = subid ;

   Insert into del_temp_patsub select event_core_id from general_event
   where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   subject_id=subid);

   Insert into d_general_event 
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where event_core_id in (select
   a.id from event_core a, subject_encounter b 
   where a.id=b.event_core_id
   and b.subject_id=subid);

   delete from general_event where event_core_id in (select
   a.id from event_core a, subject_encounter b 
   where a.id=b.event_core_id
   and b.subject_id=subid);

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Subject' and
   attached_object_id=subid;

   delete from general_event where attached_object_type='Subject' and
   attached_object_id=subid;

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   subject_id=subid);

   delete from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   subject_id=subid);

   Insert into del_temp_patsub select a.event_core_id 
   from subject_encounter a where
   a.subject_id = subid;

   Insert into del_temp_patsub select a.event_core_id 
   from unencoded_event a where
   a.subject_id = subid;

   Insert into del_temp_patsub select a.event_core_id 
   from protocol_evgroup_inst a where
   a.subject_id = subid;

   Insert into d_subject_encounter
   select EVENT_CORE_ID,ENCOUNTER_STATUS,RESCHED_EVENT_ID,PROTOCOL_VERSION_ID,            
   ENCOUNTER_NOTE,MONITOR_STATUS,SEQ,PARENT_PEG_INST_ID,HIDE,CREATOR,                        
   SUBJECT_ID,ICF_VERSION,MONITOR_SEE_PAPER_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,   
   TIME_PERIOD_CATEGORY,MIN_DATE,MIN_DATE_PRECISION,MAX_DATE,MAX_DATE_PRECISION,            
   PREF_DATE,PREF_DATE_PRECISION,sysdate,ftuserid,last_hh_activity_date 
   from subject_encounter where subject_id = subid;
  
   delete from subject_encounter where subject_id = subid;

   Insert into d_unencoded_event
   select EVENT_CORE_ID,ENCOUNTER_STATUS,MONITOR_STATUS,HIDE,CREATOR,                        
   PARENT_PEG_INST_ID,SEQ,SUBJECT_ID,MONITOR_SEE_PAPER_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,
   RESCHED_EVENT_ID,sysdate,ftuserid,last_hh_activity_date                
   from unencoded_event where subject_id = subid;

   delete from unencoded_event where subject_id = subid;

   Insert into d_protocol_evgroup_inst
   select EVENT_CORE_ID,PARENT_PEGINST_ID,ANCHOR_DATE,PROTOCOL_VERSION_ID,
   SUBJECT_ID,SEQ,CREATOR,UNENCODED_EVENT_PEG,sysdate,ftuserid
   from protocol_evgroup_inst where subject_id = subid;

   delete from protocol_evgroup_inst where subject_id = subid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id in (select col1 from del_temp_patsub);

   delete from event_core where id in (select col1 from del_temp_patsub);

   delete from del_temp_patsub;

   delete from subject where id=subid;
   commit;
end;
/

sho err

-- Following changes are as per the request of Kelly on 10/02/2001 at 4 pm


create or replace trigger subject_encounter_status_trg1
after insert or delete or update of encounter_status,monitor_status on subject_encounter
referencing new as n old as o
for each row
begin

If inserting then

   If :n.encounter_status = 'Completed' then



    If  ( :n.creator = 'Site' and :n.hide = 0 ) then

		update subject set completed_encounters = nvl(completed_encounters,0)+1
			where id = :n.subject_id;

      If :n.monitor_status <> 'Completed' or :n.monitor_status is null then

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


end if;

If updating then

    If :n.encounter_status = 'Completed' and :o.encounter_status <> 'Completed' then



    If  ( :n.creator = 'Site' and :n.hide = 0 ) then

		update subject set completed_encounters = nvl(completed_encounters,0)+1
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



    If :n.monitor_status = 'N/A' and :o.monitor_status = 'Pending'  then

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

    If :o.monitor_status = 'N/A' and :n.monitor_status = 'Pending'  then

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

		update subject set completed_encounters = nvl(completed_encounters,0)-1
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

If deleting then

   If :o.encounter_status = 'Completed' then

     If  ( :o.creator = 'Site' and :o.hide = 0 ) then

		update subject set completed_encounters = nvl(completed_encounters,0)-1
			where id = :o.subject_id;
       
        If :o.monitor_status is null or :o.monitor_status <> 'Completed' then         

           If :o.time_period_category = 'Screening' then
			update subject set unmonitored_screening_visits =
			nvl(unmonitored_screening_visits,0) - 1 where id = :o.subject_id;
           elsif :o.time_period_category = 'Treatment' then
			update subject set unmonitored_treatment_visits =
			nvl(unmonitored_treatment_visits,0) - 1 where id = :o.subject_id;
           elsif :o.time_period_category = 'Followup' then
			update subject set unmonitored_followup_visits =
			nvl(unmonitored_followup_visits,0) - 1 where id = :o.subject_id;
           end if;

        end if;
        end if;
        end if;
        end if;

end;
/
sho err

create or replace trigger unencoded_event_status_trg2
after insert or delete or update on unencoded_event
referencing new as n old as o
for each row
declare

v_name misc_event_prototype.name%type;

begin

If inserting then

  Select a.name into v_name from misc_event_prototype a, event_core b where
  b.template_id=a.id and b.id=:n.event_core_id;

  If :n.encounter_status='Completed' then

	if ( :n.creator = 'Site' and :n.hide = 0) then

           update subject set unev_completed_encounters = nvl(unev_completed_encounters,0)+1
           where id = :n.subject_id;

        if  :n.monitor_status is null or :n.monitor_status <> 'Completed' then

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

end if;


If updating then

  Select a.name into v_name from misc_event_prototype a, event_core b where
  b.template_id=a.id and b.id=:n.event_core_id;

  If ( :o.encounter_status <> 'Completed' and :n.encounter_status='Completed' ) then

	if (:n.creator = 'Site' and :n.hide = 0) then

           update subject set unev_completed_encounters = nvl(unev_completed_encounters,0)+1
           where id = :n.subject_id;

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

           update subject set unev_completed_encounters = nvl(unev_completed_encounters,0)-1
           where id = :n.subject_id;

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


   If :n.monitor_status='N/A' and :o.monitor_status='Pending'  then
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

   If :o.monitor_status='N/A' and :n.monitor_status='Pending'  then
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

If deleting then

  Select a.name into v_name from misc_event_prototype a, event_core b where
  b.template_id=a.id and b.id=:o.event_core_id;

  If :o.encounter_status='Completed' then

   if ( :o.creator = 'Site' and :o.hide = 0) then

         update subject set unev_completed_encounters = nvl(unev_completed_encounters,0)-1
         where id = :n.subject_id;

   if  :o.monitor_status is null or :o.monitor_status <> 'Completed' then

    If v_name = 'Early Termination' then 
	update subject set unmonitored_earlyterm_visits =
	nvl(unmonitored_earlyterm_visits,0) + 1 where id = :o.subject_id;
    elsif v_name = 'Screen Failure Termination' then 
	update subject set unmonitored_screenfail_visits =
	nvl(unmonitored_screenfail_visits,0) + 1 where id = :o.subject_id;
    end if;

         end if;
  end if;
  end if;

end if;

end;
/
sho err

Alter table Unencoded_event drop constraint UNENCOD_EVNT_MON_STATUS_CHECK; 

Alter table Unencoded_event add constraint UNENCOD_EVNT_MON_STATUS_CHECK 
	check ( monitor_status in ('Complete','Pending','N/A'));

-- kkingdon14a has been updated upto this point on 10/02/2001 at 16:45

-- changes per Allen, this field needs a precision, so i have to shorten
-- the name and add a precision field (kkingdon 10/3/01)

-- drop old
Alter table subject_encounter drop(last_hh_activity_date );
Alter table unencoded_event drop(last_hh_activity_date );
Alter table d_subject_encounter drop(last_hh_activity_date );
Alter table d_unencoded_event drop(last_hh_activity_date );

-- add new date field
Alter table subject_encounter add(last_hh_act_date date);
Alter table unencoded_event add(last_hh_act_date date);
Alter table d_subject_encounter add(last_hh_act_date date);
Alter table d_unencoded_event add(last_hh_act_date date);

-- add precision field
Alter table subject_encounter add(last_hh_act_date_precision number(3));
Alter table unencoded_event add(last_hh_act_date_precision number(3));
Alter table d_subject_encounter add(last_hh_act_date_precision number(3));
Alter table d_unencoded_event add(last_hh_act_date_precision number(3));


-- mod procs to use new field name plus precision
create or replace procedure delete_subject_encounter (seid number, ftuserid number) as
begin

   delete from del_temp_patsub;

   Insert into del_temp_patsub select event_core_id from general_event
   where attached_object_type='Event' and
   attached_object_id=seid;  

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Event' and
   attached_object_id=seid;

   delete from general_event where attached_object_type='Event' and
   attached_object_id=seid;

   Insert into d_subject_encounter
   select EVENT_CORE_ID,ENCOUNTER_STATUS,RESCHED_EVENT_ID,PROTOCOL_VERSION_ID,            
   ENCOUNTER_NOTE,MONITOR_STATUS,SEQ,PARENT_PEG_INST_ID,HIDE,CREATOR,                        
   SUBJECT_ID,ICF_VERSION,MONITOR_SEE_PAPER_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,   
   TIME_PERIOD_CATEGORY,MIN_DATE,MIN_DATE_PRECISION,MAX_DATE,MAX_DATE_PRECISION,            
   PREF_DATE,PREF_DATE_PRECISION,sysdate,ftuserid,last_hh_act_date,last_hh_act_date_precision 
   from subject_encounter where EVENT_CORE_ID=seid;
  
   delete from subject_encounter where EVENT_CORE_ID=seid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id = seid;

   delete from event_core where id = seid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id in (select col1 from del_temp_patsub);

   delete from event_core where id in (select col1 from del_temp_patsub);

   delete from del_temp_patsub;

   commit;

end;
/
sho err


create or replace procedure delete_unencoded_event (unevid number, ftuserid number) as
begin

   delete from del_temp_patsub;

   Insert into del_temp_patsub select event_core_id from general_event
   where attached_object_type='Event' and
   attached_object_id=unevid;  

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Event' and
   attached_object_id=unevid;

   delete from general_event where attached_object_type='Event' and
   attached_object_id=unevid;

   Insert into d_unencoded_event
   select EVENT_CORE_ID,ENCOUNTER_STATUS,MONITOR_STATUS,HIDE,CREATOR,                        
	PARENT_PEG_INST_ID,SEQ,SUBJECT_ID,MONITOR_SEE_PAPER_NOTE,         
	MON_SITE_VISIT_EVENT_CORE_ID,RESCHED_EVENT_ID,sysdate,ftuserid,
	last_hh_act_date , last_hh_act_date_precision
   from unencoded_event where EVENT_CORE_ID=unevid;
  
   delete from unencoded_event where EVENT_CORE_ID=unevid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id = unevid;

   delete from event_core where id = unevid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id in (select col1 from del_temp_patsub);

   delete from event_core where id in (select col1 from del_temp_patsub);

   delete from del_temp_patsub;

   commit;

end;
/
sho err
create or replace procedure delete_subject (subid number, ftuserid number) as
begin

   Insert into d_subject 
   select ID,PATIENT_ID,SITE_TO_TRIAL_ID,ENROLLING_MD,ICF_VERSION,ICF_DATE_SIGNED,               
   NEXT_VISIT_TYPE_ID,NEXT_VISIT_DATE,SUBJECT_STATUS,NOTE,SUBJECT_ID,                     
   NEXT_VISIT_TYPE_NAME,ENROLLED_DATE,LAST_MODIFIED_DATE,SCREENING_IDENTIFIER,           
   ASSIGNED_CC_ID,COMPLETED_ENCOUNTERS,UNMONITORED_SCREENING_VISITS,   
   UNMONITORED_TREATMENT_VISITS,UNMONITORED_FOLLOWUP_VISITS,UNMONITORED_SCREENFAIL_VISITS,
   UNMONITORED_EARLYTERM_VISITS,PROTOCOL_VERSION_ID,INITIAL_ICF_VERSION,            
   INITIAL_ICF_DATE,SCREENING_ID,CREATE_DT,SPONSOR_NOTE,sysdate,ftuserid,
   subject_disposition_id, dual_version_code,UNEV_COMPLETED_ENCOUNTERS                   
   from subject where id=subid;


   delete from del_temp_patsub;

   Insert into del_temp_patsub select event_core_id from general_event 
   where event_core_id in (select
   a.id from event_core a, subject_encounter b 
   where a.id=b.event_core_id
   and b.subject_id=subid);

   Insert into del_temp_patsub select event_core_id from general_event 
   where attached_object_type='Subject' and
   attached_object_id = subid ;

   Insert into del_temp_patsub select event_core_id from general_event
   where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   subject_id=subid);

   Insert into d_general_event 
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where event_core_id in (select
   a.id from event_core a, subject_encounter b 
   where a.id=b.event_core_id
   and b.subject_id=subid);

   delete from general_event where event_core_id in (select
   a.id from event_core a, subject_encounter b 
   where a.id=b.event_core_id
   and b.subject_id=subid);

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Subject' and
   attached_object_id=subid;

   delete from general_event where attached_object_type='Subject' and
   attached_object_id=subid;

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   subject_id=subid);

   delete from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   subject_id=subid);

   Insert into del_temp_patsub select a.event_core_id 
   from subject_encounter a where
   a.subject_id = subid;

   Insert into del_temp_patsub select a.event_core_id 
   from unencoded_event a where
   a.subject_id = subid;

   Insert into del_temp_patsub select a.event_core_id 
   from protocol_evgroup_inst a where
   a.subject_id = subid;

   Insert into d_subject_encounter
   select EVENT_CORE_ID,ENCOUNTER_STATUS,RESCHED_EVENT_ID,PROTOCOL_VERSION_ID,            
   ENCOUNTER_NOTE,MONITOR_STATUS,SEQ,PARENT_PEG_INST_ID,HIDE,CREATOR,                        
   SUBJECT_ID,ICF_VERSION,MONITOR_SEE_PAPER_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,   
   TIME_PERIOD_CATEGORY,MIN_DATE,MIN_DATE_PRECISION,MAX_DATE,MAX_DATE_PRECISION,            
   PREF_DATE,PREF_DATE_PRECISION,sysdate,ftuserid,last_hh_act_date , last_hh_act_date_precision
   from subject_encounter where subject_id = subid;
  
   delete from subject_encounter where subject_id = subid;

   Insert into d_unencoded_event
   select EVENT_CORE_ID,ENCOUNTER_STATUS,MONITOR_STATUS,HIDE,CREATOR,                        
   PARENT_PEG_INST_ID,SEQ,SUBJECT_ID,MONITOR_SEE_PAPER_NOTE,MON_SITE_VISIT_EVENT_CORE_ID,
   RESCHED_EVENT_ID,sysdate,ftuserid,last_hh_act_date, last_hh_act_date_precision                
   from unencoded_event where subject_id = subid;

   delete from unencoded_event where subject_id = subid;

   Insert into d_protocol_evgroup_inst
   select EVENT_CORE_ID,PARENT_PEGINST_ID,ANCHOR_DATE,PROTOCOL_VERSION_ID,
   SUBJECT_ID,SEQ,CREATOR,UNENCODED_EVENT_PEG,sysdate,ftuserid
   from protocol_evgroup_inst where subject_id = subid;

   delete from protocol_evgroup_inst where subject_id = subid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id in (select col1 from del_temp_patsub);

   delete from event_core where id in (select col1 from del_temp_patsub);

   delete from del_temp_patsub;

   delete from subject where id=subid;
   commit;
end;
/

sho err

-- per Kelly Kingdon.  we need to allow null for this so we can first 
-- insert without it, then create user with this site id, then update this
-- table.  we have a circular dependency.

Alter table Site modify(main_site_contact_id null);

-- added for Nancy, need to make sure no 2 PVs per trial have same date,
-- they shouldn't.
Alter table protocol_version add constraint protocol_version_uq3
	unique (trial_id, version_date) using
	index tablespace ftlarge_indx pctfree 30;

-- added for Alex, removal of obsolete tables

create or replace procedure delete_monitor_site_visit (msvid number, ftuserid number) as
begin

   delete from del_temp_patsub;

   Insert into del_temp_patsub values (msvid);

   Insert into del_temp_patsub 
   select event_core_id 
   from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   mon_site_visit_event_core_id = msvid);

   Insert into d_general_event
   select EVENT_CORE_ID,ATTACHED_OBJECT_ID,ATTACHED_OBJECT_TYPE,
   EVENT_STATUS,COMMENTS,VISIBILITY,sysdate,ftuserid
   from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   mon_site_visit_event_core_id = msvid);

   delete from general_event where attached_object_type='Event' and
   attached_object_id in (select event_core_id from subject_encounter where
   mon_site_visit_event_core_id = msvid);

   update subject_encounter set mon_site_visit_event_core_id = null
   where mon_site_visit_event_core_id = msvid;

   update unencoded_event set mon_site_visit_event_core_id = null 
   where mon_site_visit_event_core_id = msvid;

   Insert into d_monitor_site_visit 
   select EVENT_CORE_ID,SITE_TO_TRIAL_ID,START_DATE,END_DATE,              
   STATUS,FTUSER_ID,sysdate,ftuserid,type, visit_duration, how_conducted
   from monitor_site_visit where event_core_id = msvid;

   delete from monitor_site_visit where event_core_id = msvid;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,                
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id in (select col1 from del_temp_patsub);

   delete from event_core where id in (select col1 from del_temp_patsub);

   delete from del_temp_patsub;

   commit;

end;
/
sho err

create or replace procedure delete_site_to_trial (sttid number, ftuserid number) 
as
cursor c1 is select id from subject where site_to_trial_id=sttid;
cursor c2 is select event_core_id from monitor_site_visit where site_to_trial_id=sttid;

begin

   Insert into d_site_to_trial 
   select ID,SITE_ID,TRIAL_ID,PROTOCOL_VERSION_ID,SITE_SPONSOR_NAME,SITE_TRIAL_NAME,                
   SITE_VERSION_NAME,ACCRUAL_STATUS,PATIENT_MNGMENT_STS,TARGET_ENROLLMENT,EXPECTED_ACCRUAL_CLOSE,         
   ONFOLLOWUPCNT,COMPLETEDCNT,ICF_VERSION,EXPECTED_TRIAL_COMPLETION_DATE,ENROLLEDCNT,                    
   LAST_MONITOR_DATE,NEXT_MONITOR_DATE,KEY_ELIGIB_SUMMARY,EXPECTED_LPLV_DATE,CRA_NOTES,                      
   WHO_MAINTAINS_STATS,NUM_DECEASED,LAST_MODIFIED_DATE,ACCRUAL_START_DATE,SITE_NUMBER,                    
   SITE_SHORT_TITLE,CC_FTUSER_ID,PI_FTUSER_ID,ONTREATMENTCNT,EARLYTERMCNT_DIED,              
   EARLYTERMCNT_LOSTTOFOLLOWUP,EARLYTERMCNT_OTHER,SCREENFAILURECNT_DIED,          
   SCREENFAILURECNT_NOTELIGIBLE,SCREENFAILURECNT_OTHER,SCREENINGCNT,NOTASSIGNEDCNT,                 
   LATEST_ICF_DATE,VERSION_CHANGE_CODE,sysdate,ftuserid
   from site_to_trial where id=sttid;                   


for ix1 in c1 loop
  delete_subject(ix1.id,ftuserid);
end loop;

for ix2 in c2 loop
  delete_monitor_site_visit(ix2.event_core_id, ftuserid);
end loop;


   delete from del_temp_patsub;

   Insert into del_temp_patsub select event_core_id from tmf_deliverable_event 
   where  site_to_trial_id = sttid;

   Insert into d_tmf_deliverable_event select event_core_id,site_to_trial_id,
   due_date, last_update, status, date_completed, sysdate, ftuserid ,
   is_optional, long_desc from tmf_deliverable_event where site_to_trial_id = sttid ;

   delete from tmf_deliverable_event where site_to_trial_id = sttid ;

   Insert into d_event_core 
   select ID,TEMPLATE_ID,NAME,CREATOR_ID,DATE_TIME,TEMPLATE_TYPE,SITE_ID,    
   DATE_TIME_PRECISION,DISMISSED,sysdate,ftuserid             
   from event_core where id in (select col1 from del_temp_patsub);

   delete from event_core where id in (select col1 from del_temp_patsub);

   delete from del_temp_patsub;

   Insert into d_monitor_to_site_to_trial 
   select ID,SITE_TO_TRIAL_ID,ROLE,FTUSER_ID,sysdate,ftuserid
   from monitor_to_site_to_trial where site_to_trial_id = sttid;
            
   delete from monitor_to_site_to_trial where site_to_trial_id = sttid;

   delete from site_to_trial where id = sttid;

   commit;

end ;
/
sho err

Alter procedure DELETE_MONITOR_SITE_VISIT compile;
Alter procedure DELETE_SITE_TO_TRIAL compile;

drop table regulatory_document ;
drop table setup_event_mon_instance ;
drop table d_setup_event_mon_instance ;
drop table study_setup_event ;
drop table d_study_setup_event ;
drop sequence regulatory_document_seq;
drop sequence study_setup_event_seq;


-- Following changes are as per the request of Colin on 10/19/2001 at 10:45 

Alter table sponsor drop column MAIN_CONTACT_ID;
Alter table sponsor drop column CONFIDENTIALITY_MESSAGE;
drop trigger sponsor_trg2;

-- Following changes are for the bug# f8P9HA0000TY of Casey dated 10/24/2001 at 15:25

create or replace trigger subject_encounter_status_trg1
after insert or delete or update of encounter_status,monitor_status on subject_encounter
referencing new as n old as o
for each row
begin

If inserting then

   If :n.encounter_status = 'Completed' then



    If  ( :n.creator = 'Site' and :n.hide = 0 ) then

		update subject set completed_encounters = nvl(completed_encounters,0)+1
			where id = :n.subject_id;

      If :n.monitor_status <> 'Completed' or :n.monitor_status is null then

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


end if;

If updating then

    If :n.encounter_status = 'Completed' and :o.encounter_status <> 'Completed' then



    If  ( :n.creator = 'Site' and :n.hide = 0 ) then

		update subject set completed_encounters = nvl(completed_encounters,0)+1
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



    If :n.monitor_status = 'N/A' and :o.monitor_status = 'Pending' 
	and :n.encounter_status = 'Completed' then

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

    If :o.monitor_status = 'N/A' and :n.monitor_status = 'Pending' 
	and :n.encounter_status = 'Completed'  then

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

		update subject set completed_encounters = nvl(completed_encounters,0)-1
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

If deleting then

   If :o.encounter_status = 'Completed' then

     If  ( :o.creator = 'Site' and :o.hide = 0 ) then

		update subject set completed_encounters = nvl(completed_encounters,0)-1
			where id = :o.subject_id;
       
        If :o.monitor_status is null or :o.monitor_status <> 'Completed' then         

           If :o.time_period_category = 'Screening' then
			update subject set unmonitored_screening_visits =
			nvl(unmonitored_screening_visits,0) - 1 where id = :o.subject_id;
           elsif :o.time_period_category = 'Treatment' then
			update subject set unmonitored_treatment_visits =
			nvl(unmonitored_treatment_visits,0) - 1 where id = :o.subject_id;
           elsif :o.time_period_category = 'Followup' then
			update subject set unmonitored_followup_visits =
			nvl(unmonitored_followup_visits,0) - 1 where id = :o.subject_id;
           end if;

        end if;
        end if;
        end if;
        end if;

end;
/
sho err

create or replace trigger unencoded_event_status_trg2
after insert or delete or update on unencoded_event
referencing new as n old as o
for each row
declare

v_name misc_event_prototype.name%type;

begin

If inserting then

  Select a.name into v_name from misc_event_prototype a, event_core b where
  b.template_id=a.id and b.id=:n.event_core_id;

  If :n.encounter_status='Completed' then

	if ( :n.creator = 'Site' and :n.hide = 0) then

           update subject set unev_completed_encounters = nvl(unev_completed_encounters,0)+1
           where id = :n.subject_id;

        if  :n.monitor_status is null or :n.monitor_status <> 'Completed' then

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

end if;


If updating then

  Select a.name into v_name from misc_event_prototype a, event_core b where
  b.template_id=a.id and b.id=:n.event_core_id;

  If ( :o.encounter_status <> 'Completed' and :n.encounter_status='Completed' ) then

	if (:n.creator = 'Site' and :n.hide = 0) then

           update subject set unev_completed_encounters = nvl(unev_completed_encounters,0)+1
           where id = :n.subject_id;

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

           update subject set unev_completed_encounters = nvl(unev_completed_encounters,0)-1
           where id = :n.subject_id;

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


   If :n.monitor_status='N/A' and :o.monitor_status='Pending' 
	and :n.encounter_status = 'Completed'  then
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

   If :o.monitor_status='N/A' and :n.monitor_status='Pending'  
	and :n.encounter_status = 'Completed' then
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

If deleting then

  Select a.name into v_name from misc_event_prototype a, event_core b where
  b.template_id=a.id and b.id=:o.event_core_id;

  If :o.encounter_status='Completed' then

   if ( :o.creator = 'Site' and :o.hide = 0) then

         update subject set unev_completed_encounters = nvl(unev_completed_encounters,0)-1
         where id = :n.subject_id;

   if  :o.monitor_status is null or :o.monitor_status <> 'Completed' then

    If v_name = 'Early Termination' then 
	update subject set unmonitored_earlyterm_visits =
	nvl(unmonitored_earlyterm_visits,0) + 1 where id = :o.subject_id;
    elsif v_name = 'Screen Failure Termination' then 
	update subject set unmonitored_screenfail_visits =
	nvl(unmonitored_screenfail_visits,0) + 1 where id = :o.subject_id;
    end if;

         end if;
  end if;
  end if;

end if;

end;
/
sho err

-- Following lines of code were added by Debashish to fix bug#f8P9HA0000WN

update ftuser set first_name = 'ftadmin' where name = 'ftadmin@fasttrack';

update ftuser set last_name = 'ftadmin' where name = 'ftadmin@fasttrack';

commit;

-- Following lines are as per the mail of Kelly/Carol on 11/5/2001 at 10:15 am

Insert into protocol_type values (10,'Tolerability',10);

create sequence protocol_type_seq start with 11;

-- Following changes are as per the request from Navin on 11/12/2001 at 14:35

create or replace trigger monitor_site_visit_trg2
after insert or update  on monitor_site_visit 
referencing new as n old as o
for each row
declare

v_client1 trial.client_id%type;
v_client2 ftuser.client_id%type;
invalid_client exception;
invalid_status exception;

begin

 
 Select client_id into v_client1 from trial where id = (select trial_id
       from site_to_trial where id = :n.site_to_trial_id);

 Select client_id into v_client2 from ftuser where id = :n.ftuser_id;

 If v_client1 is not null and v_client2 is not null  and  v_client1 <> v_client2  then
    raise Invalid_client;
 end if;

 If :n.status = 'Complete' and :n.start_date is null then
    raise invalid_status;
 end if;

exception

when invalid_client then
     Raise_application_error(-20046,'Invalid client between site_to_trial and ftuser');
When invalid_status then
     Raise_application_error(-20053,'Monitor site visit status can not be completed without a start date');



end;
/
sho err


-- Following line is added by debashish on 09/20/2001 at 16:20 
-- and always to be executed at the end

Alter table general_event drop constraint general_event_obj_type_check;

Alter table general_event add constraint general_event_obj_type_check
        check (Attached_object_type in ('Event','User','Subject','Trial','Patient'));


--exec ciload;



---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:06 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:37:46 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:26:45 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
