--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ft15_schema_changes_for_tsm10_1.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:08 PM$
--
--
-- Description:  Schema modifications for Exec. suite schema
--
---------------------------------------------------------------------
 


Alter table client add (de_acronym varchar2(3));

Insert into client(id,name,client_identifier,client_acronym)
	values (0,'Dummy TSM client for trial.projectid not null constraint',
	'DUMMY','DUMMY');

commit;

--Alter table trial add(
--	Archived_flag  number(1) default 0 not null,
--	archived_date  date,
--	archived_by_id number(10),
--	project_id number(10) default 0 not null,
--	Indmap_id number(10),
--	phase_id number(10));

Alter table trial add(
	project_id number(10) default 0 not null,
	Indmap_id number(10),
	phase_id number(10));


--Alter table trial add constraint 
--	trial_arch_flg_check check (archived_flag in (0,1));

Alter table trial add constraint trial_fk3
	foreign key (project_id) references "&1".project(id);

Alter table trial add constraint trial_fk4
	foreign key (indmap_id) references "&1".indmap(id);	

Alter table trial add constraint trial_fk5
	foreign key (phase_id) references "&1".phase(id);

--Alter table trial add (ft_type varchar2(5) default 'ES' not null);

--Alter table trial add constraint trial_ft_type_check
--	check(ft_type in ('ES','TSM','Both'));

Alter table trial add(
	WIZARD_PAGE_NUMBER NUMBER(2),	
	WIZARD_PAGE_FLG NUMBER(1) default 0 not null,
	LOCKING_FTUSER_ID NUMBER(10),
	LOCK_DATE DATE);

Alter table trial drop column use_study_setup_docs;

Alter table trial add constraint 
	wizard_page_flg_check check (wizard_page_flg in (0,1));

--Alter table trial drop column archived_flag;

--Alter table trial add(archived_flg number(1) default 0 not null);

--Alter table trial add constraint 
--	trial_arch_flg_check check (archived_flg in (0,1));

--Alter table trial add(creator_ftuser_id number(10),
--	tsm_trial_name varchar2(256));

--Alter table trial add constraint trial_fk6
--	foreign key (creator_ftuser_id) references
--	ftuser(id);

-- Following line is added due to data load problems of tsm clients

Alter trigger "&2".client_trg1 disable;

Alter table ftgroup drop constraint FTGROUP_NAME_CHECK;

Alter table ftgroup add constraint FTGROUP_NAME_CHECK check(
	name in ('Fast Track Administrator','Site Administrator', 
	'Sponsor Administrator','Site User','CRA','CRA Manager', 
	'Site Handheld','CRA Handheld','Client Read Only User',
	'Client User','Client Admin'));

Insert into ftgroup values(9,'Client Read Only User');
Insert into ftgroup values(10,'Client User');
Insert into ftgroup values(11,'Client Admin');




commit;


Alter table ftuser add(client_div_id number(10));

Alter table ftuser add constraint ftuser_fk4
	foreign key (client_div_id) references "&1".client_div(id);


CREATE OR REPLACE TRIGGER
ftuser_name_check_trg1
before insert or update on ftuser
referencing new as n old as o
for each row


declare
extension_v ftuser.name%type;
site_id_cnt  number(20);
client_id_cnt  number(20);
client_div_id_cnt number(10);
Invalid_site_id exception;
Invalid_client_id exception;
invalid_ftuser exception;
invalid_client_div_id exception;

begin

 If :n.name like '%@%' then

    extension_v:=substr(:n.name,instr(:n.name,'@')+1);

    If :n.site_id is not null then

        select count(*) into  site_id_cnt from site where site_identifier = extension_v;

        If site_id_cnt <1 then
           Raise Invalid_site_id;
        end if;
    elsif :n.client_id is not null and :n.client_div_id is null then

        select count(*) into client_id_cnt from client where client_identifier = extension_v;

        If client_id_cnt <1 then
           Raise Invalid_client_id;
        end if; 

    elsif :n.client_div_id is not null then

        select count(*) into client_div_id_cnt from "&1".client_div where client_div_identifier = extension_v;

        If client_div_id_cnt <1 then
           Raise Invalid_client_div_id;
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

  when Invalid_client_div_id then
       Raise_application_error(-20102,'Invalid client division identifier attached with name');


end;
/
sho err


Alter table trial add(planning_currency_id number(10));

Alter table trial add constraint trial_fk7
	foreign key (planning_currency_id) references "&1".currency(id);


CREATE OR REPLACE TRIGGER trial_trg1
before insert or update of GUID on trial
referencing new as n old as o
for each row

begin

 If :n.guid = 'TSM' then 
	:n.guid := 'TSM_'||:n.id; 
 end if; 
end;
/


-- Following changes are as per the request from peter on 01/17/2001 at 10 AM

--Alter table trial add (create_date date);

-- Following changes ae done as per the request from Kelly on 01/25/2002 at 14:45

Alter table client modify (de_acronym varchar2(4));

--following changes are as per the request of Allen on 02/04/2002 at 15:00

--Alter table trial add(budget_type varchar2(40));

--Alter table trial add constraint trial_budget_type_check check(
--	budget_type in ('Industry Cost','Per Patient Budget','Per Visit Budget'));


-- Following changes are as per the request of Joel and Colin on 02/19,20/2002


alter table FTGROUP
drop constraint FTGROUP_NAME_CHECK;

alter table ftgroup add constraint
 FTGROUP_NAME_CHECK  CHECK ( name in ('Fast Track Administrator','Site Administrator',
 'Sponsor Administrator','Site User','CRA','CRA Manager',
 'Site Handheld','CRA Handheld','Client Read Only User',
 'Client User','Client Admin', 'TSM Super Admin','TSM FTAdmin','Sysinfo'));


insert into ftgroup values (12,'TSM Super Admin');
insert into ftgroup values (13,'TSM FTAdmin');
insert into ftgroup values (14,'Sysinfo');

declare

 ftuser_maxid number(10);
 u2g_maxid number(10);
 ftgroupid number(10);

begin

 select max(id)+1 into ftuser_maxid from ftuser;
 select nvl(max(id),0)+1 into u2g_maxid from ftuser_to_ftgroup;
 select id into ftgroupid from ftgroup where name = 'Sysinfo';
 
 Insert into ftuser(id, name, password, first_name, last_name)
 values (ftuser_maxid, 'sysinfo','sysinfo','sysinfo','sysinfo');

 insert into ftuser_to_ftgroup values (u2g_maxid, ftuser_maxid, ftgroupid);

 commit;
end;
/

-- Following changes are as per Nancy on 03/07/2002 at 17:00

Alter table ftuser add(display_name varchar2(128));


-- Following changes are as per Allen for ECR001 on 03/15/2002 at 11:12


Alter table trial add (client_div_id number(10), project_area_id number(10));

Alter table trial add constraint trial_fk13 foreign key(client_div_id)
	references "&1".client_div(id);

Alter table trial add constraint trial_fk14 foreign key(project_area_id)
	references "&1".project_area(id);


-- Following changes are done on 03/21/2002 at 17:00

Alter table ftuser add(active_trace_user number(1) default 0 not null);
Alter table ftuser add constraint ftuser_active_trace_user_check
check (active_trace_user in (0,1));

-- Following changes are as per the request of Peter on 03/20/2002 at 17:12

Alter table trial drop constraint check_status;

Alter table trial add constraint trial_status_check check(
    trial_status in ('CREATION', 'ACTIVE', 'CLOSED','TSM_PUB'));


-- Following changes are as per the request of Nancy on 03/26/2002 at 9:30

-- Alter table trial add(publish_date date);


-- Following changes to ft15 are for trace

Alter table ftuser add(active_tsm_user number(1) default 0 not null);

Alter table ftuser add constraint ftuser_active_tsm_user_check
	check (active_tsm_user in (0,1));


--Alter table trial add (
--	nickname varchar2(40), 
--	drug_code_id number(10),
--	drug_class_id number(10),
--	trace_archived number(1) default 0 not null,
--	trace_archived_date date,
--	trace_locked_by_id number(10),
--	trace_author_id number(10),
--	trace_create_date date,
--	trace_audit_history_id number(10));


--Alter table trial add constraint trial_fk8 
--	foreign key(drug_code_id) references "&1".drug_code(id);

--Alter table trial add constraint trial_fk9 
--	foreign key(drug_class_id) references "&1".drug_class(id);
			
--Alter table trial add constraint trial_fk10 
--	foreign key(trace_locked_by_id) references ftuser(id);

--Alter table trial add constraint trial_fk11 
--	foreign key(trace_author_id) references ftuser(id);

--Alter table trial add constraint trial_fk12 
--	foreign key(trace_audit_history_id) references "&1".trace_audit_history(id);

-- Following changes are as per the request of Kelly on 04/08/2002 at 16:00

Create table Exec_trial(
Trial_ID 		NUMBER(10) NOT NULL,
SPONSOR_ID 		NUMBER(10),	 
ACCRUAL_STATUS 		VARCHAR2(50),	 
PATIENT_MNGMNT_STATUS 	VARCHAR2(50),	 
EXPECTED_ACCRUAL_CLOSE_DATE	DATE,	 
EXPECTED_LPLV_DATE	DATE,	 
START_DATE		DATE,	 
LOGGING			NUMBER(1) default 0 NOT NULL,
TMF			NUMBER(1) default 0 NOT NULL,
EXPECTED_TRIAL_CLOSE_DATE DATE,
TARGET_ENROLLMENT	NUMBER(6),	
ARCHIVED_DATE		DATE,	
ARCHIVED_BY_ID		NUMBER(10),	
ARCHIVED_FLG		NUMBER(1) default 0 NOT NULL,
CREATOR_FTUSER_ID	NUMBER(10),	
CREATE_DATE		DATE)	
tablespace tsmsmall 
pctused 60 pctfree 25;

Alter table Exec_trial add constraint Exec_trial_pk 
	primary key (trial_id) using index tablespace tsmsmall_indx 
	pctfree 25;

Alter table Exec_trial add constraint Exec_trial_fk1 
	foreign key (trial_id) references trial(id);

Alter table Exec_trial add constraint Exec_trial_fk2 
	foreign key (SPONSOR_ID) references SPONSOR(id);

Alter table Exec_trial add constraint Exec_trial_fk3 
	foreign key (ARCHIVED_BY_ID) references ftuser(id);

Alter table Exec_trial add constraint Exec_trial_fk4 
	foreign key (CREATOR_FTUSER_ID) references ftuser(id);

Alter table Exec_trial add constraint et_ACCRUAL_STATUS_check
	check(ACCRUAL_STATUS in ('ACTIVE', 'HOLD', 'CLOSED', 'TESTING'));

Alter table Exec_trial add constraint et_ARCHIVED_FLG_check
	check(ARCHIVED_FLG in (0,1));

Alter table Exec_trial add constraint et_LOGGING_check
	check(LOGGING in (0,1));

Alter table Exec_trial add constraint et_TMF_check
	check(TMF in (0,1));


Alter table trial drop column SPONSOR_ID;                     
Alter table trial drop column ACCRUAL_STATUS;                 
Alter table trial drop column PATIENT_MNGMNT_STATUS;          
Alter table trial drop column EXPECTED_ACCRUAL_CLOSE_DATE;
Alter table trial drop column EXPECTED_LPLV_DATE;             
Alter table trial drop column START_DATE;                     
Alter table trial drop column LOGGING;
Alter table trial drop column TMF;    
Alter table trial drop column EXPECTED_TRIAL_CLOSE_DATE;
Alter table trial drop column TARGET_ENROLLMENT ;             
--Alter table trial drop column ARCHIVED_DATE ;                 
--Alter table trial drop column ARCHIVED_BY_ID ;                
--Alter table trial drop column ARCHIVED_FLG;
--Alter table trial drop column BUDGET_TYPE ;   
--Alter table trial drop column PUBLISH_DATE  ; 


Alter table trial add(protocol_identifier varchar2(256));
--update trial set protocol_identifier = TSM_TRIAL_NAME;
--commit;

--Alter table trial drop column TSM_TRIAL_NAME;


--Alter table trial drop column NICKNAME;               
--Alter table trial drop column DRUG_CODE_ID;          
--Alter table trial drop column DRUG_CLASS_ID ;         
--Alter table trial drop column TRACE_ARCHIVED ;        
--Alter table trial drop column TRACE_ARCHIVED_DATE ;   
--Alter table trial drop column TRACE_LOCKED_BY_ID;     
--Alter table trial drop column TRACE_AUTHOR_ID;        
--Alter table trial drop column TRACE_CREATE_DATE ;     
--Alter table trial drop column TRACE_AUDIT_HISTORY_ID ;
--Alter table trial drop column ft_type;

Alter table CRA_MANAGER_TO_TRIAL drop constraint CRA_MANAGER_TO_TRIAL_FK2;        
Alter table FTUSER_TRIAL_FILTER drop constraint FTUSER_TRIAL_FILTER_FK2;        
Alter table PATIENT_MANAGEMENT_TASK drop constraint PATIENT_MANAGEMENT_TASK_FK1;   
Alter table PROTOCOL_EVENT_GROUP drop constraint PROTOCOL_EVENT_GROUP_FK1;     
Alter table SUBJECT_DISPOSITION drop constraint SUBJECT_DISPOSITION_FK1;      
Alter table TMF_DELIVERABLE drop constraint TMF_DELIVERABLE_FK1;          
Alter table SITE_CHECKLIST_TEMPLATE drop constraint SITE_CKLST_TEMPLATE_TRIAL_FK1; 
Alter table PROTOCOL_VERSION drop constraint TRIAL_FK;                       
Alter table VISIT_TYPE_SAVE drop constraint VISIT_TYPE_FK1;              
Alter table SITE_TO_TRIAL drop constraint TRIAL_FK2;                     
Alter table PROTOCOL_EVENT drop constraint PROTOCOL_EVENT_FK1; 

Alter table CRA_MANAGER_TO_TRIAL add constraint CRA_MANAGER_TO_TRIAL_FK2
	foreign key (trial_id) references exec_trial(trial_id);       
Alter table FTUSER_TRIAL_FILTER add constraint FTUSER_TRIAL_FILTER_FK2
	foreign key (trial_id) references exec_trial(trial_id);        
Alter table PATIENT_MANAGEMENT_TASK add constraint PATIENT_MANAGEMENT_TASK_FK1
	foreign key (trial_id) references exec_trial(trial_id);   
Alter table PROTOCOL_EVENT_GROUP add constraint PROTOCOL_EVENT_GROUP_FK1
	foreign key (trial_id) references exec_trial(trial_id);     
Alter table SUBJECT_DISPOSITION add constraint SUBJECT_DISPOSITION_FK1
	foreign key (trial_id) references exec_trial(trial_id);      
Alter table TMF_DELIVERABLE add constraint TMF_DELIVERABLE_FK1
	foreign key (trial_id) references exec_trial(trial_id);          
Alter table SITE_CHECKLIST_TEMPLATE add constraint SITE_CKLST_TEMPLATE_TRIAL_FK1
	foreign key (trial_id) references exec_trial(trial_id); 
Alter table PROTOCOL_VERSION add constraint TRIAL_FK
	foreign key (trial_id) references exec_trial(trial_id);                       
Alter table VISIT_TYPE_SAVE add constraint VISIT_TYPE_FK1
	foreign key (trial_id) references exec_trial(trial_id);              
Alter table SITE_TO_TRIAL add constraint TRIAL_FK2
	foreign key (trial_id) references exec_trial(trial_id);                     
Alter table PROTOCOL_EVENT add constraint PROTOCOL_EVENT_FK1
	foreign key (trial_id) references exec_trial(trial_id);   


--Alter table trial drop column creator_ftuser_id;
--Alter table trial drop column create_date;

Alter table trial drop constraint trial_created_by_check;
update trial set created_by = 'PICAS-E' ;
Alter table trial add constraint trial_created_by_check check(
	created_by in ('ExecSuite', 'PICAS-E', 'Trace'));


-- Following changes are as per the request of Kelly on 04/17/2002 at 11 am

CREATE OR REPLACE TRIGGER trial_trg1
before insert or update of created_by on trial
referencing new as n old as o
for each row

begin

 If :n.created_by = 'PICAS-E' or :n.created_by = 'Trace'  then 
	:n.guid := 'TSM_'||:n.id; 
 end if; 

end;
/


-- Following changes are as per the request of kelly on 04/15/2002 at 12:20

alter table FTGROUP
drop constraint FTGROUP_NAME_CHECK;

alter table ftgroup add constraint
 FTGROUP_NAME_CHECK  CHECK ( name in ('Fast Track Administrator','Site Administrator',
 'Sponsor Administrator','Site User','CRA','CRA Manager',
 'Site Handheld','CRA Handheld','Client Read Only User',
 'Client User','Client Admin', 'TSM Super Admin','TSM FTAdmin','Sysinfo',
 'TRACE Author','TRACE Admin'));


insert into ftgroup values (15,'TRACE Author');
insert into ftgroup values (16,'TRACE Admin');

commit;

-- Following chnages are as per the request of Kelly on 05/08/2002 at 14:03

Alter table trial drop constraint trial_created_by_check;

Alter table trial add constraint trial_created_by_check check(
	created_by in ('ExecSuite', 'PICAS-E', 'Trace','DASHBOARD', 'PICASE', 'TRACE'));

CREATE OR REPLACE TRIGGER trial_trg1
before insert or update of created_by on trial
referencing new as n old as o
for each row

begin

 If :n.created_by = 'PICAS-E' or :n.created_by = 'Trace' or
    :n.created_by = 'PICASE' or :n.created_by = 'TRACE' then 
	:n.guid := 'TSM_'||:n.id; 
 end if; 

end;
/


--following chnages are as per the request of Jeff on 05/22/2002 at 11:59 am


CREATE OR REPLACE TRIGGER
ftuser_name_check_trg1
before insert or update on ftuser
referencing new as n old as o
for each row


declare
extension_v ftuser.name%type;
site_id_cnt  number(20);
client_id_cnt  number(20);
client_div_id_cnt number(10);
Invalid_site_id exception;
Invalid_client_id exception;
invalid_ftuser exception;
invalid_client_div_id exception;

begin

 If :n.name like '%@%' then

    extension_v:=substr(:n.name,instr(:n.name,'@')+1);

    If :n.site_id is not null then

        select count(*) into  site_id_cnt from site where site_identifier = extension_v;

        If site_id_cnt <1 then
           Raise Invalid_site_id;
        end if;
    elsif :n.client_id is not null and :n.client_div_id is null then

        select count(*) into client_id_cnt from client where client_identifier = extension_v;

        If client_id_cnt <1 then
           Raise Invalid_client_id;
        end if; 

    elsif :n.client_div_id is not null then

        select count(*) into client_div_id_cnt from "&1".client_div where client_div_identifier = extension_v;

        If client_div_id_cnt <1 then
           Raise Invalid_client_div_id;
        end if;


   end if;


 end if;

 If :n.site_id is not null and :n.client_id is not null then
    Raise invalid_ftuser;
 end if;

 :n.display_name:=initcap(:n.first_name)||' '||initcap(:n.last_name);

Exception

  When Invalid_site_id then
       Raise_application_error(-20006,'Invalid site identifier attached with name');

  when Invalid_client_id then
       Raise_application_error(-20020,'Invalid client identifier attached with name');

  when Invalid_ftuser then
       Raise_application_error(-20042,'Both site_id and client_id can not exist together');

  when Invalid_client_div_id then
       Raise_application_error(-20102,'Invalid client division identifier attached with name');


end;
/
sho err


-- Following changes are as as per te verbal request of Jeff on 07/09/2002 at 14:51


CREATE OR REPLACE TRIGGER
ftuser_name_check_trg1
before insert or update on ftuser
referencing new as n old as o
for each row


declare
extension_v ftuser.name%type;
site_id_cnt  number(20);
client_id_cnt  number(20);
client_div_id_cnt number(10);
Invalid_site_id exception;
Invalid_client_id exception;
invalid_ftuser exception;
invalid_client_div_id exception;

begin

 If :n.name like '%@%' then

    extension_v:=substr(:n.name,instr(:n.name,'@')+1);

    If :n.site_id is not null then

        select count(*) into  site_id_cnt from site where site_identifier = extension_v;

        If site_id_cnt <1 then
           Raise Invalid_site_id;
        end if;
    elsif :n.client_id is not null and :n.client_div_id is null then

        select count(*) into client_id_cnt from client where client_identifier = extension_v;

        If client_id_cnt <1 then
           Raise Invalid_client_id;
        end if; 

    elsif :n.client_div_id is not null then

        select count(*) into client_div_id_cnt from "&1".client_div where client_div_identifier = extension_v;

        If client_div_id_cnt <1 then
           Raise Invalid_client_div_id;
        end if;


   end if;


 end if;

 If :n.site_id is not null and :n.client_id is not null then
    Raise invalid_ftuser;
 end if;


 If trim(:n.display_name) is null then
   :n.display_name:=initcap(:n.first_name)||' '||initcap(:n.last_name);
 end if;

Exception

  When Invalid_site_id then
       Raise_application_error(-20006,'Invalid site identifier attached with name');

  when Invalid_client_id then
       Raise_application_error(-20020,'Invalid client identifier attached with name');

  when Invalid_ftuser then
       Raise_application_error(-20042,'Both site_id and client_id can not exist together');

  when Invalid_client_div_id then
       Raise_application_error(-20102,'Invalid client division identifier attached with name');

end;
/
sho err

-- Following changes are per the discussions with Kelly on 07/12/2002 at 15:50

Alter table trial drop constraint trial_created_by_check;

Alter table trial add constraint trial_created_by_check check(
	created_by in ('DASHBOARD', 'PICASE', 'TRACE'));


-- Following chnages are as per the request of Phil on 11/4/2002 at 11:00

Alter table ftuser add (CAN_MODEL_FLAG  number(1) default 0 not null);

Alter table ftuser add constraint ftuser_CAN_MODEL_FLAG_check 
check (CAN_MODEL_FLAG in (0,1));


--*****************************************
--ft15 schema chnages for GM1.1 starts here
--*****************************************

-- Following chnages are as per the request of Joel on 04/11/2003 at 11:15 

Alter table trial drop constraint TRIAL_STATUS_CHECK;
Alter table trial add constraint TRIAL_STATUS_CHECK
 	check (trial_status in 
	('CREATION', 'ACTIVE', 'CLOSED','TSM_PUB','DELETED'));

Alter table trial add constraint trial_uq2 
	unique(CLIENT_DIV_ID,CREATED_BY,PROTOCOL_IDENTIFIER)
	using index tablespace tsmsmall_indx pctfree 20;

create index ftuser_indx1 on ftuser(client_div_id) 
	tablespace ftsmall pctfree 20;

Alter table ftuser add(def_plan_currency_id number(10));
Alter table ftuser add constraint ftuser_fk5 foreign key (def_plan_currency_id)
	references "&1".currency(id);

--*****************************************
--ft15 schema chnages for TSPD starts here
--*****************************************

Alter table trial drop constraint trial_created_by_check;

Alter table trial add constraint trial_created_by_check check(
	created_by in ('DASHBOARD', 'PICASE', 'TRACE', 'TSPD'));


alter table ftgroup drop constraint FTGROUP_NAME_CHECK;

Insert into ftgroup values (17,'TSPD Viewer');
Insert into ftgroup values (18,'TSPD Author');
Insert into ftgroup values (19,'TSPD Admin');
Insert into ftgroup values (20,'TSPD Library Admin');
Insert into ftgroup values (21,'TSPD FTAdmin');
Insert into ftgroup values (22,'TSPD Super Dolly');
Insert into ftgroup values (23,'TSPD Dolly');

commit;

Alter table ftuser add(old_password varchar2(255));

Alter table ftuser add (active_tspd_user number(1) default 0 not null);

Alter table ftuser add constraint ftuser_active_tspd_user_check
	check(active_tspd_user in (0,1));

-- Following changes are as per the request of Kelly on 06/30/2003 at 1:50PM

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

-- Following chnages are as per the request of Colin on 08/14/2003 at 15:34 
Alter table ftuser add (locked number(1) default 0 not null);
Alter table ftuser add constraint ftuser_locked_check 
check (locked in (0,1));

-- Following chnages are as per the verbal discussion with Joel on 03-19-2004 at 10am

alter table ftuser add(failed_login_attempts number(10));



alter table ftuser add (input_pref varchar2(40));
Alter table ftuser add (creation_date date, 
			messaging_opt number(1));
Alter table ftuser add constraint ftuser_messaging_opt_check 
	check(messaging_opt in (0,1,2));


exit;
---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:08 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:37:53 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:26:51 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
