--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: shema_updates_for_tsd_1_01.sql$ 
--
-- $Revision: 20$        $Date: 2/22/2008 11:56:04 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
-- Following chnages are as per the request of Kelly on 04-15-2004 at 3:38pm

Alter table tspd_template add(
	version varchar2(50),
	status varchar2(20) default 'Testing',
	create_date date default sysdate,
	creator_ftuser_id number(10),
	released_date date,
	retired_date date);

Alter table tspd_template add constraint tt_status_check
	check(status in ('Testing','Released','Retired'));

Alter table tspd_template add constraint tspd_template_fk3
	foreign key(creator_ftuser_id) references ftuser(id);

Alter table tspd_template drop constraint TSPD_TEMPLATE_UQ1;

Alter table tspd_template add constraint TSPD_TEMPLATE_UQ1
	unique(client_div_id, name, version ) using
	index tablespace tspdsmall_indx pctfree 20;

create or replace view tspd_template_noblob as
select id,client_div_id,last_updated,name,
SOFTWARE_VERSION, UPDATED_BY_FTUSER_ID,VERSION,
STATUS,CREATE_DATE,CREATOR_FTUSER_ID,RELEASED_DATE,
RETIRED_DATE from tspd_template;

-- Following changes are as per the request of Kelly on 04-22-2004 at 9:32am

update tspd_template set (status,version)=(select
'Released','V1' from dual);
update tspd_template set released_date=last_updated;
commit;

Alter table tspd_template_history add(
	version varchar2(50),
	status varchar2(20) default 'Testing',
	create_date date default sysdate,
	creator_ftuser_id number(10),
	released_date date,
	retired_date date);

Create or replace trigger tspd_template_trg1
before insert or update on tspd_template
referencing new as n old as o
for each row
begin
If updating then
   Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
   sysdate,:o.id,:o.client_div_id,:o.last_updated,:o.name,:o.data,:o.software_version,
   :o.updated_by_ftuser_id,:o.version,:o.status,:o.create_date,:o.creator_ftuser_id,
   :o.released_date,:o.retired_date from dual;  
end if;
 :n.last_updated:=sysdate;
end;
/
sho err	

-- Following chnages are as per the request of Chris/Kelly on 04-26-2004 at 4pm

conn tsm10xxxx/welcome
grant select on password_rule to ft15xxx;
grant select on client_div_to_lic_app to ft15xxx;

Alter table client_div_to_lic_app add (Alert_email varchar2(100));
update client_div_to_lic_app a set a.alert_email=
	(select b.email from ftuser b where b.id=a.principal_contact_id);
commit;

CREATE OR REPLACE
TRIGGER client_div_to_lic_app_trg1
before insert or update of PRINCIPAL_CONTACT_ID 
ON client_div_to_lic_app
referencing new as n old as o
for each row
declare
principal_contact_email varchar2(100);

begin

If :n.principal_contact_id is not null 
 then
    select email into  principal_contact_email from ftuser where
    id=:n.principal_contact_id;

    If :n.alert_email is null 
     then
       :n.alert_email:=principal_contact_email;
    end if;
end if;
end;
/


conn ft15xxxx/welcome
create synonym password_rule for tsm10xxxx.password_rule;
create synonym client_div_to_lic_app for tsm10xxxx.client_div_to_lic_app;

CREATE OR REPLACE
TRIGGER ftuser_trg4
after update of locked,failed_login_attempts
ON ftuser
referencing new as n old as o
for each row
declare
 AlertMessage varchar2(4000);
 AlertRecipient varchar2(512);
 AlertSubject varchar2(128);
 Failed_login_time varchar2(1024);
 Num_failed_attempts number(5);
 password_rule_exists number(1);
 pcontactid number(10);
 
begin
 If nvl(:n.failed_login_attempts,0) > nvl(:o.failed_login_attempts,0) then

   Insert into audit_hist(ID,FTUSER_ID,APP_TYPE,ACTION,TARGET_PRIMARY_TABLE,TARGET_ID,
   ENTITY_TYPE,ENTITY_ID,MODIFY_DATE) select increment_sequence('audit_hist_seq'),:o.id,      
   'TSPD','auditAction.login_failed','ftuser',:o.id,'system',205,sysdate from dual;
 end if; 

 If :n.locked = 1 and :o.locked <> 1 
   then
    
    if :o.client_div_id is not null 
      then
         select count(*) into password_rule_exists from password_rule where
         client_div_id=:o.client_div_id;

         if password_rule_exists=1 
           then
            select lockout_login_attempts into num_failed_attempts from password_rule 
            where client_div_id=:o.client_div_id;
         else 
            num_failed_attempts:=1;
         end if;
    else
       num_failed_attempts:=1;
    end if;

    declare

     cursor c1 is SELECT rank,to_char(modify_date,'
Mon dd, yyyy hh24:mi:ss')||' hrs PST' mdate FROM
     	(SELECT MODIFY_DATE,
     	RANK() OVER (PARTITION BY ftuser_id,action
     	ORDER BY modify_date DESC) Rank
     	FROM audit_hist where ftuser_id=:o.id and action='auditAction.login_failed')
     	where to_number(to_char(rank)) <= to_number(to_char(num_failed_attempts));
      
    begin
      for ix1 in c1 loop
         Failed_login_time:=ix1.mdate||Failed_login_time;
      end loop;
    end;       
     
  AlertMessage:='From: Fast Track Data Center
Product: TrialSpace Designer
Auto alert: User lockout

The following user has been locked out of TrialSpace Designer:

'||:o.name||' with a user name of '||initcap(:o.first_name)||' '||initcap(:o.last_name)||'

Because of '||to_char(num_failed_attempts)||' consecutive failed attempts to login that occurred on:
'||Failed_login_time||'

Please ensure that this user is contacted and verifies the unsuccessful login attempts before unlocking this user.

For further details please contact client support on: 215-358-1400 opt 2

Thank you

Fast Track Systems Inc';

   select email_subject into AlertSubject from oracle_alert_config
   where alert_event = 'UserLocked';


  if :o.client_div_id is not null 
   then
     select alert_email into AlertRecipient from client_div_to_lic_app where 
     client_div_id=:o.client_div_id and app_name='TSPD';
       if AlertRecipient is null 
         then
    	   select email_recipient  into AlertRecipient from oracle_alert_config
    	   where alert_event = 'UserLocked';
       end if;
   else 
      select email_recipient  into AlertRecipient from oracle_alert_config
      where alert_event = 'UserLocked';      
   end if;           

   oracle_sendmail(AlertRecipient, AlertSubject,AlertMessage) ;

   Insert into audit_hist(ID,FTUSER_ID,APP_TYPE,ACTION,TARGET_PRIMARY_TABLE,TARGET_ID,
   ENTITY_TYPE,ENTITY_ID,MODIFY_DATE) select increment_sequence('audit_hist_seq'),:o.id,      
   'TSPD','auditAction.user_lockout','ftuser',:o.id,'system',205,sysdate from dual;
 end if;
end;
/

conn tsm10******/welcome


-- Following chnages are as per the request of Kelly on 05-04-2004

Alter table tspd_document add(
	locale varchar2(20),
	date_format varchar2(30));

Alter table tspd_template add(
	locale varchar2(20),
	date_format varchar2(30));

create or replace view TSPD_TEMPLATE_NOBLOB as
select id,client_div_id,last_updated,name,
SOFTWARE_VERSION, UPDATED_BY_FTUSER_ID,VERSION,
STATUS,CREATE_DATE,CREATOR_FTUSER_ID,RELEASED_DATE,
RETIRED_DATE,locale,date_format from tspd_template;


create or replace view TSPD_DOCUMENT_NOBLOB as
select id,trial_id,document_type,document_name,
author_ftuser_id,create_date,last_updated,
version_timestamp,snapshot_type,snapshot_name,
snapshot_notes, review_by_date,review_by_time,
amend_to_tspd_document_id,icp_instance_id,
snapshot_status,document_notes,snapshot_create_date,
REVIEW_REMINDER_DAYS,AMEND_NAME,LAST_COOKIE,
SOFTWARE_VERSION,locale,date_format from tspd_document;

-- Implemented upto this in tsm10e@TEST on 05-07-2003 at 6:50pm

alter table tspd_template add(
starteam_tag varchar(30));

create or replace view tspd_template_noblob as
select id,client_div_id,last_updated,name,
SOFTWARE_VERSION, UPDATED_BY_FTUSER_ID,VERSION,
STATUS,CREATE_DATE,CREATOR_FTUSER_ID,RELEASED_DATE,
RETIRED_DATE,starteam_tag from tspd_template;

-- bug fix 44V.
--

CREATE OR REPLACE
TRIGGER client_div_to_lic_app_trg1
before insert or update of PRINCIPAL_CONTACT_ID 
ON client_div_to_lic_app
referencing new as n old as o
for each row
declare
new_principal_contact_email varchar2(100);
old_principal_contact_email varchar2(100);

begin

If :n.principal_contact_id is not null 
 then
    select email into  new_principal_contact_email from ftuser where
    id=:n.principal_contact_id;

    select email into  old_principal_contact_email from ftuser where
    id=:o.principal_contact_id;

    If :n.alert_email is null or :o.alert_email = old_principal_contact_email
     then
       :n.alert_email:=new_principal_contact_email;
    end if;
end if;
end;
/

-- Implemented upto this in tsm10e@TEST on 05-17-2004 at 4:00pm
-- Implemented upto this in tsm10t@PREV on 05-17-2004 at 4:00pm
-- Implemented upto this in tsm10g@PROD on 07-01-2004 at 11:10pm
-- Implemented upto this in tsm10e@PREV on 11-05-2004 at 20:54pm
-- Implemented upto this in tsm10e@PROD on 11-06-2004 at 1:02 am
-- Implemented upto this in tsm10@PROD on 11-06-2004 at 1:02 am

-- Following changes are as per the request of Michael on 02-10-2005 at 6:25am
-- for new TSD enhancements
-- ========================

Create table tspd_document_authors(
	id NUMBER(10),
	tspd_document_id number(10) not null,
	ftuser_id number(10) not null,
	document_type varchar2(80) not null)
	tablespace tspdsmall 
	pctused 70 pctfree 20;

Alter table tspd_document_authors add constraint tspd_document_authors_pk 
	primary key (id) using index tablespace 
	tspdsmall_indx pctfree 25;

Alter table tspd_document_authors add constraint tspd_document_authors_fk1
	foreign key (tspd_document_id) references 
	tspd_document(id); 

Alter table tspd_document_authors add constraint tspd_document_authors_fk2
	foreign key (ftuser_id) references 
	ftuser(id);

Alter table tspd_document_authors add constraint tda_document_type_check
	check(document_type in ('Protocol','StudyGuide'));

Alter table tspd_document add(author_relinquished_dt date);

Alter table tspd_document add(author_model_type varchar2(24) default 'PUSH' not null);
Alter table tspd_document add constraint td_author_model_type_check
	check (author_model_type in ('PUSH','PULL'));

Alter table client_div add(author_model_type varchar2(24) default 'PUSH' not null);
Alter table client_div add constraint cd_author_model_type_check
	check (author_model_type in ('PUSH','PULL'));

insert into id_control values('tsm10','tspd_document_authors',1);

commit;


Alter table tspd_document add(public_visible_flg  number(1) default 0 not null);
Alter table tspd_document add constraint td_public_visible_flg_check
	check (public_visible_flg in (0,1));

Alter table client_div add(show_author_model_flg  number(1) default 0 not null);
Alter table client_div add constraint cd_show_author_model_flg_check
	check (show_author_model_flg in (0,1));

-- Implemented upto this in tsm10e@TEST on 03-02-2005 at 9:00pm

-- Implemented upto this in tsm10t@PREV on 03-03-2005 at 6am
-- Following changes are per the request of Michael on 03-04-2005

create or replace procedure delete_my_tspd_trial(
myuserid in varchar2) 
is

begin

delete from tspd_document_authors where tspd_document_id in
(select a.id from tspd_document a, tspd_trial b, ftuser c where
a.trial_id=b.trial_id and
b.CREATOR_FTUSER_ID=c.id and
upper(c.name) = upper(myuserid));


delete from tspd_doc_comment where tspd_document_id in 
(select a.id from tspd_document a, tspd_trial b, ftuser c where 
a.trial_id=b.trial_id and 
b.CREATOR_FTUSER_ID=c.id and
upper(c.name) = upper(myuserid)); 

delete from tspd_doc_reviewer where tspd_document_id in 
(select a.id from tspd_document a, tspd_trial b, ftuser c where 
a.trial_id=b.trial_id and 
b.CREATOR_FTUSER_ID=c.id and
upper(c.name) = upper(myuserid));


delete from tspd_doc_advisory where tspd_document_id in 
(select a.id from tspd_document a, tspd_trial b, ftuser c where 
a.trial_id=b.trial_id and 
b.CREATOR_FTUSER_ID=c.id and
upper(c.name) = upper(myuserid));

delete from tspd_document where trial_id in (select trial_id from
tspd_trial b, ftuser c where 
b.CREATOR_FTUSER_ID=c.id and
upper(c.name) = upper(myuserid));
 

delete from icp_instance where trial_id in (select trial_id from
tspd_trial b, ftuser c where 
b.CREATOR_FTUSER_ID=c.id and
upper(c.name) = upper(myuserid));

delete from tspd_trial where CREATOR_FTUSER_ID in (select id from
ftuser where upper(name) = upper(myuserid));

delete from trial where created_by = 'TSPD' and
not id in (select trial_id from tspd_trial);

commit;
end;
/
sho err

create or replace procedure delete_tspd_trial(
trialid in number) 
is

begin

delete from tspd_document_authors where tspd_document_id in
(select a.id from tspd_document a where a.trial_id=trialid); 


delete from tspd_doc_comment where tspd_document_id in 
(select a.id from tspd_document a where a.trial_id=trialid); 

delete from tspd_doc_reviewer where tspd_document_id in 
(select a.id from tspd_document a where a.trial_id=trialid);


delete from tspd_doc_advisory where tspd_document_id in 
(select a.id from tspd_document a where a.trial_id=trialid);

delete from tspd_document where trial_id=trialid;
 

delete from icp_instance where trial_id=trialid;

delete from tspd_trial where trial_id=trialid;

delete from trial where created_by = 'TSPD' and id=trialid;
 
commit;
end;
/

create or replace procedure delete_tspd_template(
templateid in number)
is

begin

delete from tspd_document_authors where
tspd_document_id in (select a.id from tspd_document a,
tspd_trial b where
a.trial_id=b.trial_id and b.tspd_template_id=templateid);

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

--********************************************************************************
-- Implemented upto this in tsm10e@TEST on 04-29-2005 at 7:00am
-- Implemented upto this in tsm10t@PREV on 05-03-2005 at 8:40am
-- Implemented upto this in tsm10g@PROD on 05-07-2005 at 11:50pm
-- Implemented upto this in tsm10e@PREV on 08-11-2005 at 00:14am
-- Implemented upto this in tsm10e@PROD on 08-12-2005 at 8:12 pm
-- Implemented upto this in tsm10@PROD on 08-12-2005 at 8:12 pm
--********************************************************************************


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  20   DevTSM    1.19        2/22/2008 11:56:04 AMDebashish Mishra  
--  19   DevTSM    1.18        9/19/2006 12:11:38 AMDebashish Mishra   
--  18   DevTSM    1.17        8/19/2005 6:23:12 AM Debashish Mishra  
--  17   DevTSM    1.16        5/9/2005 1:00:53 AM  Debashish Mishra  
--  16   DevTSM    1.15        3/18/2005 8:48:19 AM Debashish Mishra  
--  15   DevTSM    1.14        3/2/2005 10:51:09 PM Debashish Mishra  
--  14   DevTSM    1.13        2/12/2005 7:03:17 PM Debashish Mishra  
--  13   DevTSM    1.12        2/12/2005 7:00:49 PM Debashish Mishra  
--  12   DevTSM    1.11        2/10/2005 10:55:32 PMDebashish Mishra  
--  11   DevTSM    1.10        2/10/2005 7:38:56 AM Debashish Mishra TSD
--       enhancements as requested by Michael on 02-09
--  10   DevTSM    1.9         11/16/2004 12:38:37 AMDebashish Mishra  
--  9    DevTSM    1.8         7/15/2004 12:35:48 PMDebashish Mishra  
--  8    DevTSM    1.7         5/27/2004 8:34:35 AM Debashish Mishra modified
--       ip_session.location_set_id to null an d moved some tags around
--  7    DevTSM    1.6         5/18/2004 8:03:43 AM Kelly Kingdon   added comments
--       about when test and prev were updated
--  6    DevTSM    1.5         5/14/2004 11:56:42 AMKelly Kingdon   bug fix 44V. 
--       need to copy principal_contact_email if princ. contact changes in
--       client_div_to_lic_app and the alert_email is the prior contact email, or
--       if null.
--  5    DevTSM    1.4         5/13/2004 5:19:33 PM Kelly Kingdon   added
--       starteam_tag field for tspd_template
--  4    DevTSM    1.3         5/7/2004 6:59:24 PM  Debashish Mishra  
--  3    DevTSM    1.2         5/6/2004 8:15:35 PM  Debashish Mishra  
--  2    DevTSM    1.1         4/15/2004 4:26:44 PM Debashish Mishra Changed case
--       of check constraint in tspd_template.status
--  1    DevTSM    1.0         4/15/2004 4:08:19 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
