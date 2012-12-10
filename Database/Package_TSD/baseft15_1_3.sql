--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: baseft15_1_3.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:05 PM$
--
--
-- Description:  Schema changes for rel 1.3
--
---------------------------------------------------------------------
 
--***************** 
-- Create sequences
--***************** 

create sequence contact_seq;
create sequence ftuser_seq;
create sequence ftgroup_seq;
create sequence ftuser_to_ftgroup_seq;
create sequence aclentries_seq;
create sequence patient_seq;
create sequence subject_seq;
create sequence medical_record_number_seq;
create sequence ftuser_to_disease_seq;

--*******************************************
-- Create tables with primary and unique keys
--*******************************************

create table contact(id number(10),
        first_name varchar2(128) not null,
        last_name varchar2(128) not null,
        phone varchar2(30))
        tablespace ftsmall pctused 80 pctfree 10;

Alter table contact add constraint contact_pk
        primary key (ID) using index tablespace ftsmall_indx
        pctfree 10 Nologging;

create table ftuser(id number(10),
        contact_id number(10) not null,
        name varchar2(255) not null,
        password varchar2(255) not null)
        tablespace ftsmall pctused 70 pctfree 20;

Alter table ftuser add constraint ftuser_pk
        primary key (ID) using index tablespace ftsmall_indx
        pctfree 20 Nologging;

create table ftgroup (id number(10),
        name varchar2(255) not null,
        member varchar2(255) not null)
        tablespace ftsmall pctused 70 pctfree 20;

Alter table ftgroup add constraint ftgroup_pk
        primary key (ID) using index tablespace ftsmall_indx
        pctfree 20 Nologging;

create table ftuser_to_ftgroup (id number(10),
        ftuser_id number(10),
        ftgroup_id number(10))
        tablespace ftsmall pctused 70 pctfree 20;

Alter table ftuser_to_ftgroup add constraint ftuser_to_ftgroup_pk
        primary key (ID) using index tablespace ftsmall_indx
        pctfree 20 Nologging;

Alter table ftuser_to_ftgroup add constraint ftuser_to_ftgroup_uq1
        unique(ftuser_id, ftgroup_id) using index tablespace ftsmall_indx
        pctfree 20 Nologging;

create table aclentries(id number(10),
        ftgroup_id number(10) not null,
        name varchar2(255) not null,
        principal varchar2(255) ,
        permission varchar2(255))
        tablespace ftsmall pctused 80 pctfree 10;

Alter table aclentries add constraint aclentries_pk
        primary key (ID) using index tablespace ftsmall_indx
        pctfree 10 Nologging;

create table patient(id number(10),
        site_id number(10) not null,
        first_name varchar2(255) not null,
        last_name varchar2(255) not null,
        initials varchar2(10) ,
        address_line_1 varchar2(255),
        address_line_2 varchar2(255),
        city varchar2(255),
        work_phone varchar2(50),
        state varchar2(100),
        postal_code varchar2(20),
        country varchar2(255),
        home_phone varchar2(50),
        fax varchar2(50),
        email varchar2(100),
        gender char(1),
        date_of_birth date,
        race varchar2(50),
        mobile_phone varchar2(50))
        tablespace ftlarge pctused 80 pctfree 10;

Alter table patient add constraint patient_pk
        primary key (ID) using index tablespace ftlarge_indx
        pctfree 10 Nologging;

create table subject(id number(10),
        patient_id number(10) not null,
        site_to_trial_id number(10) not null,
        enrolling_md varchar2(255),
        icf_version varchar2(255),
        icf_date_signed date,
        patient_status varchar2(50) not null,
        patient_note varchar2(255),
        next_visit_type_id number(10),
        next_visit_date date)
        tablespace ftlarge pctused 80 pctfree 10;

Alter table subject add constraint subject_pk
        primary key (ID) using index tablespace ftlarge_indx
        pctfree 10 Nologging;

create table medical_record_number(id number(10),
        patient_id number(10) not null,
        mrnumber varchar2(255) not null,
        app_id varchar2(255))
        tablespace ftlarge pctused 70 pctfree 20;

Alter table medical_record_number add constraint medical_record_number_pk
        primary key (ID) using index tablespace ftlarge_indx
        pctfree 20 Nologging;

-- following table was added as per the request from colin on 10/13/2000

Create table ftuser_to_disease (id number(10),
        ftuser_id number (10) not null,
        disease_id number(10) not null)
        tablespace ftsmall pctused 70 pctfree 20;

Alter table ftuser_to_disease add constraint ftuser_to_disease_pk
        primary key (ID) using index tablespace ftsmall_indx
        pctfree 20 Nologging;


--*****************************************
-- Establish relationship with foreign keys
--*****************************************


Alter table Patient add constraint patient_fk1
        foreign key (site_id) references site(id);

Alter table medical_record_number add constraint medical_record_number_fk
        foreign key (patient_id) references patient(id);

Alter table subject add constraint subject_fk1
        foreign key (patient_id) references patient(id);

Alter table subject add constraint subject_fk2
        foreign key (site_to_trial_id) references site_to_trial(id);

Alter table subject add constraint subject_fk3
        foreign key (next_visit_type_id) references visit_type(id);

Alter table ftuser add constraint ftuser_fk1
        foreign key (contact_id) references contact(id);

Alter table ftuser_to_ftgroup add constraint ftuser_to_ftgroup_fk1
        foreign key (ftuser_id) references ftuser(id);

Alter table ftuser_to_ftgroup add constraint ftuser_to_ftgroup_fk2
        foreign key (ftgroup_id) references ftgroup(id);

Alter table aclentries add constraint aclentries_fk1
        foreign key (ftgroup_id) references ftgroup(id);

-- following two constraints were added as per the request from colin on 10/13/2000

Alter table ftuser_to_disease add constraint ftuser_to_disease_fk1
        foreign key (ftuser_id) references ftuser(id);

Alter table ftuser_to_disease add constraint ftuser_to_disease_fk2
        foreign key (disease_id) references disease(id);


--********************************************************
-- Alter site and site_to_trial and handheld_device tables
--********************************************************


create table site_copy as select * from site;
create table site_to_trial_copy as select * from site_to_trial;

Alter table site add (handheld_stale_period number(2) default 7);
Update site set handheld_stale_period=7;
Alter table site modify(handheld_stale_period not null);

Alter table site add (main_site_contact_id number(10));

insert into contact
select contact_seq.nextval,
nvl(ltrim(rtrim(substr(MAIN_SITE_CONTACT_NAME,1,
instr(MAIN_SITE_CONTACT_NAME,' ')))),'unknown'),
nvl(ltrim(rtrim(substr(MAIN_SITE_CONTACT_NAME,
instr(MAIN_SITE_CONTACT_NAME,' ')))),'unknown'),
null from site;

update site a set a.main_site_contact_id = (
select id from contact b where
b.first_name=nvl(ltrim(rtrim(substr(a.MAIN_SITE_CONTACT_NAME,1,
instr(a.MAIN_SITE_CONTACT_NAME,' ')))),'unknown')
and
b.last_name=nvl(ltrim(rtrim(substr(a.MAIN_SITE_CONTACT_NAME,
instr(a.MAIN_SITE_CONTACT_NAME,' ')))),'unknown')
);

alter table site modify(main_site_contact_id not null);

alter table site drop column MAIN_SITE_CONTACT_NAME;


alter table site_to_trial add (pi_contact_id number(10)) 
add (Target_enrollment number(6))
add (expected_accrual_close date) 
add(cc_contact_id number(10));

insert into contact
select 
contact_seq.nextval,nvl(ltrim(rtrim(clinical_coord_fname)),'unknown'),
nvl(ltrim(rtrim(clinical_coord_lname)),'unknown'), 
nvl(ltrim(rtrim(clinical_coord_phone)),'unknown')
from site_to_trial;

delete from contact where not rowid in (select min(rowid) from
contact group by first_name,last_name,phone);

update site_to_trial a set a.cc_contact_id = (
select id from contact b where
b.first_name=nvl(ltrim(rtrim(a.clinical_coord_fname)),'unknown')
and b.last_name=nvl(ltrim(rtrim(a.clinical_coord_lname)),'unknown')
and b.phone=nvl(ltrim(rtrim(a.clinical_coord_phone)),'unknown')
);

alter table site_to_trial modify(cc_contact_id not null);

alter table site_to_trial drop column clinical_coord_fname;
alter table site_to_trial drop column clinical_coord_lname;
alter table site_to_trial drop column clinical_coord_phone;

--following six lines are added as per the request from Phil on 07/27/2000 at 12 noon

alter table site add (site_acronym varchar2(20));
update site set site_acronym = 'FT';
alter table site modify(site_acronym not null);

alter table handheld_device add(avango_id number(10));
update handheld_device  set avango_id = 0;
alter table handheld_device modify(avango_id not null);

--following two lines are added as per the request from Kelly on 07/27/2000 at 2PM

Alter table VISIT_TYPE drop constraint VISIT_TYPE_CATEGORY_CHECK;
alter table visit_type add constraint VISIT_TYPE_CATEGORY_CHECK check (category in ('Treatment','Followup','Screening'));

--following lines were added as per the request from kelly on 07/31/2000 at 2 PM

insert into DISEASE values (disease_seq.nextval, 'Leukemia');
insert into DISEASE values (disease_seq.nextval, 'Hodgkin''s lymphoma');
insert into DISEASE values (disease_seq.nextval, 'Non-Hodgkin''s lymphoma');
insert into DISEASE values (disease_seq.nextval, 'Bone metastases');
insert into disease values (disease_seq.nextval,'Diabetes mellitus');
insert into disease values (disease_seq.nextval,'Psoriasis');
commit;

--following lines were added as per the request from kelly on 08/01/2000 at 2.30 PM

Alter table visit_task add (drill_down_important number(1));
Alter table visit_task add constraint vt_ddi_check check (drill_down_important in (0,1));
Alter table criterion add (drill_down_important number(1));
Alter table criterion add constraint criterion_ddi_check check (drill_down_important in (0,1));

--following lines were added as per the request from collin on 08/03/2000 at 8.30 AM

create table sponsor (id number(10),
        name varchar2(255) not null)
        tablespace ftsmall pctused 70 pctfree 20;

Alter table sponsor add constraint sponsor_pk
        primary key (ID) using index tablespace ftsmall_indx
        pctfree 20 Nologging;


Alter table ftuser add (site_id number(10)) add (sponsor_id number(10));

Alter table ftuser add constraint ftuser_fk2
        foreign key (site_id) references site(id);
Alter table ftuser add constraint ftuser_fk3
        foreign key (sponsor_id) references sponsor(id);

--following lines were added as per the request from kelly on 08/08/2000 at 9.30 AM

Alter table subject add (arm_id number(10) constraint subject_fk4  references arm(id));

--following lines were added as per the request from kelly on 08/09/2000 at 9.30 AM

Alter table subject add (subject_status varchar2(50));
update subject set subject_status = patient_status;
alter table subject modify (subject_status not null);
alter table subject drop column patient_status;

Alter table subject add constraint subject_subject_status_check check ( subject_status in 
('On Study', 'On Follow-up', 'Lost to Follow-up', 'Completed', 'Early Term'));

Alter table subject add (note varchar2(255));
update subject set note = patient_note;
alter table subject drop column patient_note;

Alter table subject add (subject_id varchar2(50));

update subject b set b.subject_id = (select 
upper(substr(a.first_name,1,1)||substr(a.last_name,1,1)||'-'||b.id)
from patient a where b.patient_id = a.id) ;
commit;

--following lines were added as per the request from crystal on 08/09/2000 at 10.30 AM

alter table handheld_device add (avantgo_id number(10));
update handheld_device set avantgo_id = AVANGO_ID      ;
alter table handheld_device drop column AVANGO_ID;
alter table handheld_device modify (avantgo_id NOT NULL);

--following lines were added as per the request from kelly on 08/09/2000 at 10.45 AM

alter table site_to_trial
add (onStudyCnt number(10))
add (onFollowUpCnt number(10))
add (earlyTermCnt number(10))
add (completedCnt number(10))
add (lostToFollowUpCnt   number(10));

--following trigger was added as per the request from kelly on 08/09/2000 at 12.45 PM


create or replace trigger subject_status_trg1
after insert or update of subject_status on Subject
referencing new as n old as o
for each row
begin
if inserting then
  if upper(:n.subject_status) = 'ON STUDY' then
     update site_to_trial set onstudycnt=nvl(onstudycnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'ON FOLLOW-UP' then
     update site_to_trial set onfollowupcnt=nvl(onfollowupcnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'LOST TO FOLLOW-UP' then
     update site_to_trial set losttofollowupcnt=nvl(losttofollowupcnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'COMPLETED' then
     update site_to_trial set completedcnt=nvl(completedcnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'EARLY TERM' then
     update site_to_trial set earlytermcnt=nvl(earlytermcnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;

end if;

if updating then
    
  if upper(:o.subject_status) = 'ON STUDY' then
     update site_to_trial set onstudycnt=nvl(onstudycnt,0) -1 where 
     id = :o.site_to_trial_id;
  end if;
  if upper(:o.subject_status) = 'ON FOLLOW-UP' then
     update site_to_trial set onfollowupcnt=nvl(onfollowupcnt,0)-1 where 
     id = :o.site_to_trial_id;
  end if;
  if upper(:o.subject_status) = 'LOST TO FOLLOW-UP' then
     update site_to_trial set losttofollowupcnt=nvl(losttofollowupcnt,0)-1 where 
     id = :o.site_to_trial_id;
  end if;
  if upper(:o.subject_status) = 'COMPLETED' then
     update site_to_trial set completedcnt=nvl(completedcnt,0)-1 where 
     id = :o.site_to_trial_id;
  end if;
  if upper(:o.subject_status) = 'EARLY TERM' then
     update site_to_trial set earlytermcnt=nvl(earlytermcnt,0)-1 where 
     id = :o.site_to_trial_id;
  end if;

  if upper(:n.subject_status) = 'ON STUDY' then
     update site_to_trial set onstudycnt=nvl(onstudycnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'ON FOLLOW-UP' then
     update site_to_trial set onfollowupcnt=nvl(onfollowupcnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'LOST TO FOLLOW-UP' then
     update site_to_trial set losttofollowupcnt=nvl(losttofollowupcnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'COMPLETED' then
     update site_to_trial set completedcnt=nvl(completedcnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'EARLY TERM' then
     update site_to_trial set earlytermcnt=nvl(earlytermcnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;

end if;

end;
/
show err

update site_to_trial a set a.onstudycnt = (select count(*) from subject b 
where upper(b.subject_status)='ON STUDY'
and a.id = b.site_to_trial_id);

update site_to_trial a set a.onfollowupcnt = (select count(*) from subject b 
where upper(b.subject_status)='ON FOLLOW-UP'
and a.id = b.site_to_trial_id);

update site_to_trial a set a.losttofollowupcnt = (select count(*) from subject b 
where upper(b.subject_status)='LOST TO FOLLOW-UP'
and a.id = b.site_to_trial_id);

update site_to_trial a set a.completedcnt = (select count(*) from subject b 
where upper(b.subject_status)='COMPLETED'
and a.id = b.site_to_trial_id);

update site_to_trial a set a.earlytermcnt = (select count(*) from subject b 
where upper(b.subject_status)='EARLY TERM'
and a.id = b.site_to_trial_id);

commit;

--following lines were added as per the request from Colin on 08/16/2000 at 11.45 AM
alter table patient modify (gender varchar2(15));

update patient set gender = 'Unknown' where gender is null;
commit;
alter table patient modify (gender not null);

Alter table patient add constraint patient_gender_check
check (gender in ('Male', 'Female', 'Unknown', 'Other'));

--following lines were added as per the request from Colin on 08/31/2000 at 9 AM

alter table subject add (protocol_version_id number(10) references
protocol_version(id));

--following lines were added as per the request from kelly on 09/06/2000 at 11 AM

alter table protocol_version add (version_date_precision number(3));

--following lines were added to rectify earlier mistakes by DB 09/06/2000 at 2:30 PM

alter table site add constraint site_FK1 foreign key (MAIN_SITE_CONTACT_ID)
references contact(id);

alter table site_to_trial add constraint CONTACT_FK1 foreign key (CC_CONTACT_ID)
references contact(id);

--following lines were added as per the request from kelly on 09/07/2000 at 2:10 PM
 
create table Protocol_type (id number(10),
        name varchar2(128) not null,
        sort_order number(4) not null)
        tablespace ftsmall pctused 70 pctfree 20;

Alter table Protocol_type add constraint Protocol_type_pk
        primary key (ID) using index tablespace ftsmall_indx
        pctfree 20 Nologging;

create table pv_to_disease (id number(10),
        protocol_version_id number(10) not null,
        disease_id number(10) not null,
        protocol_type_id number(10) not null)
        tablespace ftsmall pctused 70 pctfree 20;

Alter table pv_to_disease add constraint pv_to_disease_pk
        primary key (ID) using index tablespace ftsmall_indx
        pctfree 20 Nologging;

Alter table pv_to_disease add constraint pv_to_disease_fk1
        foreign key (protocol_version_id) references protocol_version(id);

Alter table pv_to_disease add constraint pv_to_disease_fk2
        foreign key (disease_id) references disease(id);

Alter table pv_to_disease add constraint pv_to_disease_fk3
        foreign key (protocol_type_id) references protocol_type(id);

@base15_req_data13

create sequence temp_sequence;

Insert into pv_to_disease select temp_sequence.nextval,
           b.id, a.disease_id, 1 from trial a, protocol_version b
           where b.trial_id = a.id;

commit;

drop sequence temp_sequence;

--following lines were added as per the request from Colin on 09/08/2000 at 4:30 PM

alter table patient add (middle_initials varchar2(10));

-- following lines were added as per the request from kelly/Colin on 09/11/2000 at 4 PM

alter table visit_task modify (drill_down_important default 0);
alter table criterion modify (drill_down_important default 0);
update visit_task set drill_down_important = 0 where drill_down_important is null;
update criterion set drill_down_important = 0 where drill_down_important is null;
alter table visit_task modify (drill_down_important not null);
alter table criterion modify (drill_down_important not null);

-- following lines were added as per the request from colin (jeff)  on 09/11/2000 at 4.15 PM

alter table subject add (next_visit_type_name varchar2(255));

-- following lines were added as per the request from colin on 09/15/2000 at 11 AM

alter table patient add (preferred_contact varchar2(50) default 'patient.home_phone' not null);

-- following lines wew added as per the request from crystal (and confirmation from Phil) on 09/15/2000 at 5:30 PM

alter table handheld_device modify (AVANTGO_ID null);

-- following lines were added as per the request from colin on 09/18/2000 at 2 PM

update subject a set a.PROTOCOL_VERSION_ID = (select b.PROTOCOL_VERSION_ID from
site_to_trial b where b.ID=a.SITE_TO_TRIAL_ID);

alter table subject modify (PROTOCOL_VERSION_ID not null);

-- following lines were added as per the request from kelly (carsten) on 09/19/2000 at 10:15 AM

alter table site_to_trial add (icf_version varchar2(128),
expected_trial_completion_date date,
enrolledcnt number(10));

-- following lines were added as per the request from kelly on 09/20/2000 at 4 PM

alter table subject drop constraint subject_subject_status_check;

Alter table subject add constraint subject_subject_status_check check ( subject_status in 
('On Study', 'On Follow-up', 'Lost to Follow-up', 'Completed', 'Early Term', 'Mistake'));


create or replace trigger subject_status_trg1
after insert or update of subject_status on Subject
referencing new as n old as o
for each row
begin
if inserting then
  if upper(:n.subject_status) = 'ON STUDY' then
     update site_to_trial set onstudycnt=nvl(onstudycnt,0)+1 where  
     id = :n.site_to_trial_id;
     update site_to_trial set enrolledcnt=nvl(enrolledcnt,0)+1 where  
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'ON FOLLOW-UP' then
     update site_to_trial set onfollowupcnt=nvl(onfollowupcnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'LOST TO FOLLOW-UP' then
     update site_to_trial set losttofollowupcnt=nvl(losttofollowupcnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'COMPLETED' then
     update site_to_trial set completedcnt=nvl(completedcnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'EARLY TERM' then
     update site_to_trial set earlytermcnt=nvl(earlytermcnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;

end if;

if updating then
    
  if upper(:o.subject_status) = 'ON STUDY' then
     update site_to_trial set onstudycnt=nvl(onstudycnt,0) -1 where 
     id = :o.site_to_trial_id;
  end if;
  if upper(:o.subject_status) = 'ON FOLLOW-UP' then
     update site_to_trial set onfollowupcnt=nvl(onfollowupcnt,0)-1 where 
     id = :o.site_to_trial_id;
  end if;
  if upper(:o.subject_status) = 'LOST TO FOLLOW-UP' then
     update site_to_trial set losttofollowupcnt=nvl(losttofollowupcnt,0)-1 where 
     id = :o.site_to_trial_id;
  end if;
  if upper(:o.subject_status) = 'COMPLETED' then
     update site_to_trial set completedcnt=nvl(completedcnt,0)-1 where 
     id = :o.site_to_trial_id;
  end if;
  if upper(:o.subject_status) = 'EARLY TERM' then
     update site_to_trial set earlytermcnt=nvl(earlytermcnt,0)-1 where 
     id = :o.site_to_trial_id;
  end if;
  if upper(:o.subject_status) = 'MISTAKE' then
     update site_to_trial set enrolledcnt=nvl(enrolledcnt,0)+1 where 
     id = :o.site_to_trial_id;
  end if;


  if upper(:n.subject_status) = 'ON STUDY' then
     update site_to_trial set onstudycnt=nvl(onstudycnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'ON FOLLOW-UP' then
     update site_to_trial set onfollowupcnt=nvl(onfollowupcnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'LOST TO FOLLOW-UP' then
     update site_to_trial set losttofollowupcnt=nvl(losttofollowupcnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'COMPLETED' then
     update site_to_trial set completedcnt=nvl(completedcnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'EARLY TERM' then
     update site_to_trial set earlytermcnt=nvl(earlytermcnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'MISTAKE' then
     update site_to_trial set enrolledcnt=nvl(enrolledcnt,0)-1 where 
     id = :n.site_to_trial_id;
  end if;


end if;

end;
/
show err

--following lines were added as per the request from collin on 09/25/2000 at 3.30 PM

alter table subject add (enrolled_date date);
update subject set enrolled_date=sysdate;
alter table subject modify (enrolled_date not null);

--following lines were added as per the request from Kelly on 09/26/2000 at 10.30 AM

drop table disease_to_stage;
drop table protocol_version_to_stage;
drop table stage;

-- following lines were added as per the subject inconsistent problem indicated by kelly on 09/28/2000

Create or replace trigger Subject_site_check_trg1  
before insert or update of site_to_trial_id,patient_id on Subject
referencing new as n old as o
for each row

declare

site_thro_patient site.id%type;
site_thro_site_to_trial  site.id%type;
Invalid_subject exception;

begin

   Select b.id into site_thro_patient from patient a, site b
      where a.site_id = b.id and  a.id = :n.patient_id;
   Select b.id into site_thro_site_to_trial from site_to_trial a, site b
     where a.site_id = b.id and  a.id = :n.site_to_trial_id;

   If site_thro_patient <> site_thro_site_to_trial then
     Raise  Invalid_subject;
   end if;

Exception 

  When Invalid_subject then
       Raise_application_error(-20001,'Data inconsistency between patient_id and site_to_trial_id');
end;
/

sho err

--following lines were added as per the request from Kelly on 10/02/2000 at 2.20 PM

alter table trial drop column disease_ID;

--following lines were added as per the request from Kelly on 10/02/2000 at 4.20 PM

Create or replace trigger Subject_site_check_trg1  
before insert or update of site_to_trial_id,patient_id,arm_id,protocol_version_id,next_visit_type_id on Subject
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

   If :n.arm_id is null and :n.next_visit_type_id is not null then
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
    End if;
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
sho err

--following lines were added as per the request from colin on 10/09/2000 at 5.20 PM

alter table SITE_TO_TRIAL drop constraint ACCRUAL_STATUS_CHECK;

alter table SITE_TO_TRIAL add constraint ACCRUAL_STATUS_CHECK check ( 
accrual_status in ('ACTIVE','HOLD','CLOSED','TESTING') );

--following lines were added as per the request from kelly on 10/10/2000 at 2.30 PM

alter table site add constraint HH_STALE_PERIOD_CHECK check (
HANDHELD_STALE_PERIOD between 1 and 7);

alter table site modify(HANDHELD_STALE_PERIOD default 7);


--following lines were added as per the request from crystal on 10/12/2000 at 12.30 PM

alter table FTUSER add constraint FTUSER_name_uq1 
unique (name) using index tablespace ftsmall_indx;

--following lines were added as per the request from colin on 10/13/2000 at 10.10 AM

Alter table ftgroup add constraint FTGROUP_MEMBER_FK1 foreign key (member)
references ftuser(name);

-- following lines were added as per the request from colin on 10/13/2000 at 12.45 PM

Alter table ftuser add (starting_screen varchar2(255));
update ftuser set STARTING_SCREEN = 'HOME';
alter table ftuser modify (starting_screen default 'HOME' not null);

-- following lines were added as per the request from jeff on 10/16/00 at 5 PM

update patient set gender = 'Other' where
gender = 'Unknown';

commit;

-- following lines were added as per the request from colin on 10/17/00 at 2 PM


alter table patient drop constraint PATIENT_GENDER_CHECK;

alter table patient add constraint PATIENT_GENDER_CHECK 
check (gender in ('Male', 'Female','Other'));


-- following lines were added as per the request from kelly on 10/18/00 at 5:30 PM

alter table protocol_version add
(has_arms number(1) default 0 not null);
alter table protocol_version add constraint
has_arms_check check (has_arms in (0,1));

update protocol_version set has_arms = 1 where id
in (select distinct protocol_version_id from
arm_to_protocol_version);

-- following lines were added to fix the bug identified by Nadine on 10/23/00 at 3:45 PM

create or replace trigger subject_status_trg1
after insert or update of subject_status on Subject
referencing new as n old as o
for each row
begin
if inserting then

  update site_to_trial set enrolledcnt=nvl(enrolledcnt,0)+1 where  
  id = :n.site_to_trial_id;

  if upper(:n.subject_status) = 'ON STUDY' then
     update site_to_trial set onstudycnt=nvl(onstudycnt,0)+1 where  
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'ON FOLLOW-UP' then
     update site_to_trial set onfollowupcnt=nvl(onfollowupcnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'LOST TO FOLLOW-UP' then
     update site_to_trial set losttofollowupcnt=nvl(losttofollowupcnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'COMPLETED' then
     update site_to_trial set completedcnt=nvl(completedcnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'EARLY TERM' then
     update site_to_trial set earlytermcnt=nvl(earlytermcnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;

end if;

if updating then
    
  if upper(:o.subject_status) = 'ON STUDY' then
     update site_to_trial set onstudycnt=nvl(onstudycnt,0) -1 where 
     id = :o.site_to_trial_id;
  end if;
  if upper(:o.subject_status) = 'ON FOLLOW-UP' then
     update site_to_trial set onfollowupcnt=nvl(onfollowupcnt,0)-1 where 
     id = :o.site_to_trial_id;
  end if;
  if upper(:o.subject_status) = 'LOST TO FOLLOW-UP' then
     update site_to_trial set losttofollowupcnt=nvl(losttofollowupcnt,0)-1 where 
     id = :o.site_to_trial_id;
  end if;
  if upper(:o.subject_status) = 'COMPLETED' then
     update site_to_trial set completedcnt=nvl(completedcnt,0)-1 where 
     id = :o.site_to_trial_id;
  end if;
  if upper(:o.subject_status) = 'EARLY TERM' then
     update site_to_trial set earlytermcnt=nvl(earlytermcnt,0)-1 where 
     id = :o.site_to_trial_id;
  end if;
  if upper(:o.subject_status) = 'MISTAKE' then
     update site_to_trial set enrolledcnt=nvl(enrolledcnt,0)+1 where 
     id = :o.site_to_trial_id;
  end if;


  if upper(:n.subject_status) = 'ON STUDY' then
     update site_to_trial set onstudycnt=nvl(onstudycnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'ON FOLLOW-UP' then
     update site_to_trial set onfollowupcnt=nvl(onfollowupcnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'LOST TO FOLLOW-UP' then
     update site_to_trial set losttofollowupcnt=nvl(losttofollowupcnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'COMPLETED' then
     update site_to_trial set completedcnt=nvl(completedcnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'EARLY TERM' then
     update site_to_trial set earlytermcnt=nvl(earlytermcnt,0)+1 where 
     id = :n.site_to_trial_id;
  end if;
  if upper(:n.subject_status) = 'MISTAKE' then
     update site_to_trial set enrolledcnt=nvl(enrolledcnt,0)-1 where 
     id = :n.site_to_trial_id;
  end if;


end if;

end;
/
show err

--following lines were added as per the request from Colin on 10/23/00 at 4 PM 

alter table ftuser add (last_password_update date);

--following lines were added as per the request from Colin on 10/24/00 at 10:15 AM 

alter table subject drop column protocol_version_id;


--following lines were added as per the problems found due to the statement above on 10/24/2000 at 5.25 PM

Alter trigger SUBJECT_STATUS_TRG1 compile;

Create or replace trigger Subject_site_check_trg1  
before insert or update of site_to_trial_id,patient_id,arm_id,next_visit_type_id on Subject
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

   If :n.arm_id is null and :n.next_visit_type_id is not null then
     Raise Invalid_visit_type;
   End if;

   If :n.arm_id is not null then

       /* Select count(*) into arm_to_pv_cnt from arm_to_protocol_version
       where arm_id = :n.arm_id and protocol_version_id = :n.protocol_version_id;
       If arm_to_pv_cnt < 1 then
          raise  Invalid_arm2pv_ref;
       end if;  */
   
       If :n.next_visit_type_id is not null then

            Select count(*) into visit_type_to_arm_cnt from visit_type_to_arm 
            where arm_id = :n.arm_id and visit_type_id = :n.next_visit_type_id;
            If visit_type_to_arm_cnt < 1 then
                raise Invalid_vt2arm_ref;
            End if;
            
            /* Select obsoleted_protocol_version_id,added_protocol_version_id into opv_id,apv_id
            from visit_type_to_arm where arm_id = :n.arm_id and visit_type_id = :n.next_visit_type_id;
            
            If  :n.protocol_version_id < apv_id then
                raise Invalid_pv;
            end if;
            If opv_id is not null and :n.protocol_version_id >=opv_id then
                raise Invalid_pv;
            end if; */
        End if;
    End if;
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
sho err

-- following lines were added as the request from kelly on 10/30/2000 at 11:30 AM

alter table ftuser add (FIRST_NAME VARCHAR2(128),
LAST_NAME VARCHAR2(128));

update ftuser a set (a.FIRST_NAME, a.last_name) = (
select b.FIRST_NAME, b.LAST_NAME from contact b 
where b.id= a.CONTACT_ID);

alter table ftuser modify (first_name not null, last_name not null);


Create or replace trigger ftuser_name_check_trg1  
before insert or update of name on ftuser
referencing new as n old as o
for each row

declare
Valid_site_id  ftuser.name%type;
site_id_cnt  number(20);
Invalid_site_id exception;

begin

 If :n.name like '%@%' then
    Valid_site_id:=substr(:n.name,instr(:n.name,'@')+1);
    select count(*) into  site_id_cnt from site where site_identifier = Valid_site_id;

    If site_id_cnt <1 then 
        Raise Invalid_site_id;
    end if;
 end if;

Exception 

  When Invalid_site_id then
       Raise_application_error(-20006,'Invalid site identifier attached with name');

end;
/
sho err

-- following lines were added as per the request from colin on 11/2/2000 at 14:45
-- These changes couldn't be added to req_data13 as ftuser table has changed

Update site set site_identifier='fasttrack' where site_identifier='0' and name='FastTrack';

Insert into ftuser values (2,1,'jsp@fasttrack','12345678',0,null,'NONE',null,'fasttrack','fasttrack');
Insert into ftgroup values (2,'fasttrack','jsp@fasttrack');

--following lines were added as per the request from Nadine

delete from disease where NAME = 'BMT-treated cancer';

commit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:05 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:37:41 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:26:41 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
