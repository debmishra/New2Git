--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_post_beta3_4_TSD_GA.sql$ 
--
-- $Revision: 17$        $Date: 2/22/2008 11:56:03 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
--Alter table currency add (is_viewable number(1) default 0 not null);

--Alter table currency add constraint currency_is_viewable_check
--	check(is_viewable in (0,1));

--update currency a set a.is_viewable = (select max(b.is_viewable) from country b
--      where b.currency_id = a.id ) where exists (select c.id from country c
--       where c.currency_id = a.id);

--update currency set (name,symbol,is_viewable) = (select 'Yen','¥',1 from dual)
--where id = (select currency_id from country where abbreviation='JAP');

--commit;

Alter table currency add (viewable_flg number(1) default 0 not null);

Alter table currency add constraint currency_viewable_flg_check
	check(viewable_flg in (0,1));

update currency a set a.viewable_flg = (select max(b.is_viewable) from country b
      where b.currency_id = a.id ) where exists (select c.id from country c
       where c.currency_id = a.id);

update currency set (name,symbol,viewable_flg) = (select 'Yen','¥',1 from dual)
where id = (select currency_id from country where abbreviation='JAP');

commit;




-- This procedure is as per the request of Henry on 02-03-2004 at 1:21pm
-- This proceudre will not go t production

create or replace procedure delete_tspd_trial(
trialid in number) 
is

begin

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


-- Following procedure was created by Debashish on 02-03-2003 at 15:45

Create or replace procedure oracle_sendmail(ftrecipient in varchar2, ftsubject in varchar2, 
ftmessage in varchar2)
is
  c utl_smtp.connection;
 
  PROCEDURE send_header(name IN VARCHAR2, header IN VARCHAR2) AS
  BEGIN
    utl_smtp.write_data(c, name || ': ' || header || utl_tcp.CRLF);
  END;
 
BEGIN
  c := utl_smtp.open_connection('localhost');
  utl_smtp.helo(c, 'fast-track.com');
  utl_smtp.mail(c, 'none@fast-track.com');
  utl_smtp.rcpt(c, ftrecipient);
  utl_smtp.open_data(c);
  send_header('From',    '"FT Alert" <none@fast-track.com>');
  send_header('To',      ftrecipient);
  send_header('Subject', ftsubject);
  utl_smtp.write_data(c, utl_tcp.CRLF || ftmessage);
  utl_smtp.close_data(c);
  utl_smtp.quit(c);
EXCEPTION
  WHEN utl_smtp.transient_error OR utl_smtp.permanent_error THEN
    BEGIN
      utl_smtp.quit(c);
    EXCEPTION
      WHEN utl_smtp.transient_error OR utl_smtp.permanent_error THEN
        NULL; -- When the SMTP server is down or unavailable, we don't have
              -- a connection to the server. The quit call will raise an
              -- exception that we can ignore.
    END;
    raise_application_error(-20107,
      'Oracle failed to send mail due to the following error: ' || sqlerrm);
END;
/


create table oracle_alert_config(
	id	number(10),
	alert_event	varchar2(128),
	email_recipient	varchar2(512),
	email_subject	varchar2(128),
	email_text	varchar2(1024))
	tablespace tspdsmall
	pctused 65 pctfree 20;

Alter table oracle_alert_config add constraint oracle_alert_config_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table oracle_alert_config add constraint oracle_alert_config_uq1
	unique (alert_event) using index tablespace
	tspdsmall_indx pctfree 20;

Insert into id_control values('tsm10','oracle_alert_config',1);
commit;

Insert into oracle_alert_config select increment_sequence('oracle_alert_config_seq'),
	'UserLocked','dmishra@fast-track.com',
	'Info- FastTrack application user has been locked',null from dual;
commit;

-- replace the word ft15xxxxxxx with appropriate user name

grant execute on oracle_sendmail to ft15xxxxxxxx;
grant select on oracle_alert_config to ft15xxxxxxxx;
grant execute on increment_sequence to ft15xxxxxxxx;
grant select,insert,update,delete on audit_hist to ft15xxxxxxx;

conn ft15xxxxxx/*****@?????

create synonym oracle_alert_config for tsm10xxxxxxxx.oracle_alert_config;
create synonym oracle_sendmail for tsm10xxxxxxxx.oracle_sendmail;
create synonym increment_sequence for tsm10xxxxxxxx.increment_sequence;
create synonym audit_hist for tsm10xxxxxxxx.audit_hist;


CREATE OR REPLACE
TRIGGER ftuser_trg4
after update of locked
ON ftuser
referencing new as n old as o
for each row
declare
 AlertMessage varchar2(128);
 AlertRecipient varchar2(512);
 AlertSubject varchar2(128);
begin
 If :n.locked = 1 and :o.locked <> 1 
   then
   select email_recipient,email_subject into AlertRecipient,AlertSubject from oracle_alert_config
   where alert_event = 'UserLocked';
   AlertMessage:='The user '||:o.name||' has been locked on '||to_char(sysdate,'mm/dd/yy')||' at '||to_char(sysdate,'HH24:MI:sS')||' hrs';
   oracle_sendmail(AlertRecipient, AlertSubject,AlertMessage) ;

   Insert into audit_hist(ID,FTUSER_ID,APP_TYPE,ACTION,TARGET_PRIMARY_TABLE,TARGET_ID,
   ENTITY_TYPE,ENTITY_ID,MODIFY_DATE) select increment_sequence('audit_hist_seq'),:o.id,      
   'TSPD','auditAction.user_lockout','ftuser',:o.id,'system',205,sysdate from dual;
 end if;
end;
/

conn tsm10/*****@?????

-- Following changes are as per the request of Kelly on 02-16-2004 at 8am

Alter table CRITERIA drop constraint CRITERIA_TYPE_CHECK;

Alter table CRITERIA add constraint CRITERIA_TYPE_CHECK check(
TYPE in ('Inclusion','Exclusion','NotDefined','Undifferentiated','Other'));

Alter table criteria add (classifier varchar2(128));

Alter table custom_set_item add(
short_desc varchar2(128),
long_desc varchar2(1024));

-- Following changes are as per the request of Kelly on 02/17/2004 at 11:50 am

Alter table criteria add(other_classifier_desc VARCHAR2(256));

-- Applied database changes to tsm10@TEST upto this on 02-17-2004 at 3pm

-- Following changes are as per the request of Kelly on 02-18-2004 at 8:53 am

Alter table CRITERIA drop constraint CRITERIA_TYPE_CHECK;

update criteria set type='other' where type='Other';

Alter table CRITERIA add constraint CRITERIA_TYPE_CHECK check(
TYPE in ('Inclusion','Exclusion','NotDefined','Undifferentiated','other'));

-- Following chnages are as per the request of Kelly for only in development database on 02-24-2004 at 8:13

create or replace procedure delete_my_tspd_trial(
myuserid in varchar2) 
is

begin

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

-- Applied database changes to tsm10@TEST upto this on 02-24-2004 at 12:26pm
-- Applied database changes to tsm10e@TEST upto this on 03-02-2004 at 10:26am

-- Following chnages are as per the verbal discussion with Kelly on 03-03-2004
--*********************************************************************
-- Following few lines are not required whn is_viewable doesn't exist
--********************************************************************

Alter table currency add (viewable_flg number(1) default 0 not null);
update currency set viewable_flg=is_viewable;
commit;
Alter table currency add constraint currency_viewable_flg_check
check(viewable_flg in (0,1));

Alter table currency drop column is_viewable;

-- Applied database changes to tsm10@TEST upto this on 03-08-2004 at 12:26pm
-- Applied database changes to tsm10e@TEST upto this on 03-16-2004 at 11:11am

conn ft15/***@????

-- Following chnages are as per the verbal discussion with Joel on 03-19-2004 at 10am

alter table ftuser add(failed_login_attempts number(10));

CREATE OR REPLACE
TRIGGER ftuser_trg4
after update of locked,failed_login_attempts
ON ftuser
referencing new as n old as o
for each row
declare
 AlertMessage varchar2(128);
 AlertRecipient varchar2(512);
 AlertSubject varchar2(128);
begin
 If :n.locked = 1 and :o.locked <> 1 
   then
   select email_recipient,email_subject into AlertRecipient,AlertSubject from oracle_alert_config
   where alert_event = 'UserLocked';
   AlertMessage:='The user '||:o.name||' has been locked on '||to_char(sysdate,'mm/dd/yy')||' at '||to_char(sysdate,'HH24:MI:sS')||' hrs';
   oracle_sendmail(AlertRecipient, AlertSubject,AlertMessage) ;

   Insert into audit_hist(ID,FTUSER_ID,APP_TYPE,ACTION,TARGET_PRIMARY_TABLE,TARGET_ID,
   ENTITY_TYPE,ENTITY_ID,MODIFY_DATE) select increment_sequence('audit_hist_seq'),:o.id,      
   'TSPD','auditAction.user_lockout','ftuser',:o.id,'system',205,sysdate from dual;
 end if;
 If nvl(:n.failed_login_attempts,0) > nvl(:o.failed_login_attempts,0) then

   Insert into audit_hist(ID,FTUSER_ID,APP_TYPE,ACTION,TARGET_PRIMARY_TABLE,TARGET_ID,
   ENTITY_TYPE,ENTITY_ID,MODIFY_DATE) select increment_sequence('audit_hist_seq'),:o.id,      
   'TSPD','auditAction.login_failed','ftuser',:o.id,'system',205,sysdate from dual;
 end if; 
end;
/

grant update (failed_login_attempts) on ftuser to ftcommon;

conn ftcommon/****@?????

--++++++++++++++++++++++++++++++++++++++++++
---- ***ADJUST THE VIEW FOR ALL SCHEMAS****
--+++++++++++++++++++++++++++++++++++++++++++


create or replace view ftuser as 
select ID,NAME||'@tsm10' name ,PASSWORD,SITE_ID,STARTING_SCREEN,
LAST_PASSWORD_UPDATE,
FIRST_NAME,LAST_NAME,LAST_LOGIN_DATE,PRIMARY_TA_ID,ADDRESS_LINE_1,
ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,WORK_PHONE,
HOME_PHONE,FAX,MOBILE_PHONE,EMAIL,PREFERRED_CONTACT,TITLE,
CLIENT_ID,CLIENT_DIV_ID,DISPLAY_NAME,ACTIVE_TRACE_USER,
ACTIVE_TSM_USER,old_password,ACTIVE_TSPD_USER,DEF_PLAN_CURRENCY_ID,
locked,failed_login_attempts,'tsm10' environment from ft15.ftuser;

create or replace procedure FailedLoginAttempts
(schemaname in varchar2, username in varchar2)
as
mysql_stmt varchar2(200);
table_name varchar2(70);

begin

table_name:=schemaname||'.ftuser';
mysql_stmt:='Update '||table_name||' set failed_login_attempts=nvl(failed_login_attempts,0)+1 where name=:1';
execute immediate mysql_stmt using username;

commit;
end;
/
sho err

conn tsm10/****@???

-- Applied database changes to tsm10@TEST upto this on 03-24-2004 at 12:26pm
-- Applied database changes to tsm10t@PREV upto this on 04-05-2004 at 17:52

-- Following changes are as per the request of Kelly on 04-08-2004 at 15:53pm

create table tspd_document_history (
	ID				number(10),
	HISTORY_DATE	 		date NOT NULL,
	TSPD_DOCUMENT_ID		NUMBER(10) NOT NULL,
	TRIAL_ID                        NUMBER(10) NOT NULL,
	DOCUMENT_TYPE                   VARCHAR2(80) NOT NULL,
	DOCUMENT_NAME                   VARCHAR2(256),
	AUTHOR_FTUSER_ID                NUMBER(10) NOT NULL,
	CREATE_DATE                     DATE NOT NULL,
	LAST_UPDATED                    DATE NOT NULL,
	VERSION_TIMESTAMP               NUMBER(10) NOT NULL,
	DATA                            BLOB,
	SNAPSHOT_TYPE                   VARCHAR2(80),
	SNAPSHOT_NAME                   VARCHAR2(256),
	SNAPSHOT_NOTES                  VARCHAR2(1024),
	REVIEW_BY_DATE                  DATE,
	REVIEW_BY_TIME                  VARCHAR2(80),
	AMEND_TO_TSPD_DOCUMENT_ID       NUMBER(10),
	ICP_INSTANCE_ID                 NUMBER(10) NOT NULL,
	SNAPSHOT_STATUS                 VARCHAR2(80),
	DOCUMENT_NOTES                  VARCHAR2(1024),
	SNAPSHOT_CREATE_DATE            DATE,
	SOA_TBL_FORMAT                  BLOB,
	REVIEW_REMINDER_DAYS            NUMBER(2) NOT NULL,
	AMEND_NAME                      VARCHAR2(256),
	LAST_COOKIE                     NUMBER(10),
	SOFTWARE_VERSION                VARCHAR2(20))
	tablespace tspdblob 
	pctused 65 pctfree 20;

Alter table tspd_document_history add constraint tspd_document_history_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Insert into id_control values('tsm10','tspd_document_history',1);
commit;

create index tspd_document_history_indx1 on tspd_document_history(TSPD_DOCUMENT_ID)
	tablespace tspdsmall_indx pctfree 20;

Create or replace trigger tspd_document_trg1
before insert or update or delete on tspd_document
referencing new as n old as o
for each row
begin
If updating or deleting then
   Insert into tspd_document_history select increment_sequence('tspd_document_history_seq'),
   	sysdate,:o.id,:o.TRIAL_ID,:o.DOCUMENT_TYPE,
	:o.DOCUMENT_NAME,:o.AUTHOR_FTUSER_ID,:o.CREATE_DATE,:o.LAST_UPDATED,
	:o.VERSION_TIMESTAMP,:o.DATA,:o.SNAPSHOT_TYPE,:o.SNAPSHOT_NAME,:o.SNAPSHOT_NOTES,
	:o.REVIEW_BY_DATE,:o.REVIEW_BY_TIME,:o.AMEND_TO_TSPD_DOCUMENT_ID,
	:o.ICP_INSTANCE_ID,:o.SNAPSHOT_STATUS,:o.DOCUMENT_NOTES,:o.SNAPSHOT_CREATE_DATE,
	:o.SOA_TBL_FORMAT,:o.REVIEW_REMINDER_DAYS,:o.AMEND_NAME,:o.LAST_COOKIE,
	:o.SOFTWARE_VERSION from dual;  

   delete from tspd_document_history where id in(
  	select id from (SELECT id,
   	RANK() OVER (PARTITION BY tspd_document_id
   	ORDER BY history_date DESC) rank
   	FROM tspd_document_history where tspd_document_id=:o.id)
   	where rank > 3);

end if;
If updating or inserting then
 :n.last_updated:=sysdate;
end if;
end;
/
sho err	


create or replace view tspd_document_history_noblob as select
	ID,HISTORY_DATE,TSPD_DOCUMENT_ID,TRIAL_ID,DOCUMENT_TYPE,
	DOCUMENT_NAME,AUTHOR_FTUSER_ID,CREATE_DATE,LAST_UPDATED,
	VERSION_TIMESTAMP,SNAPSHOT_TYPE,SNAPSHOT_NAME,SNAPSHOT_NOTES,
	REVIEW_BY_DATE,REVIEW_BY_TIME,AMEND_TO_TSPD_DOCUMENT_ID,
	ICP_INSTANCE_ID,SNAPSHOT_STATUS,DOCUMENT_NOTES,SNAPSHOT_CREATE_DATE,
	REVIEW_REMINDER_DAYS,AMEND_NAME,LAST_COOKIE,
	SOFTWARE_VERSION from tspd_document_history;

-- Applied database changes to tsm10@TEST upto this on 04-09-2004 at 9am
-- Applied database changes to tsm10e@TEST upto this on 04-09-2004 at 9am

-- Following charges are as per the request of Kelly on 04-12-2004

Alter table tspd_doc_comment modify (comments varchar2(4000));

--**************************************************************************
-- Applied database changes to tsm10@TEST upto this on 04-18-2004 at 9:40pm
-- Applied database changes to tsm10e@TEST upto this on 04-18-2004 at 9:40pm
-- Applied database changes to tsm10t@PREV upto this on 04-29-2004 at 17:00pm
-- Applied database changes to tsm10g@PROD upto this on 04-29-2004 at 17:15pm
-- Applied database changes to tsm10e@prev upto this on 11-05-2004 at 20:50 
-- Applied database chnages to tsm10e@prod upto this on 11-06-2004 at 00:55 
-- Applied database chnages to tsm10@prod upto this on 11-06-2004 at 00:55

--**************************************************************************

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  17   DevTSM    1.16        2/22/2008 11:56:03 AMDebashish Mishra  
--  16   DevTSM    1.15        9/19/2006 12:11:37 AMDebashish Mishra   
--  15   DevTSM    1.14        3/2/2005 10:51:08 PM Debashish Mishra  
--  14   DevTSM    1.13        11/16/2004 12:38:36 AMDebashish Mishra  
--  13   DevTSM    1.12        5/6/2004 8:15:34 PM  Debashish Mishra  
--  12   DevTSM    1.11        4/12/2004 10:12:22 AMDebashish Mishra Increased
--       column width for tspd_doc_comment.comments from 1024 to 4000
--  11   DevTSM    1.10        4/9/2004 9:03:15 AM  Debashish Mishra Moved tags
--       around
--  10   DevTSM    1.9         4/8/2004 4:09:30 PM  Debashish Mishra  
--  9    DevTSM    1.8         3/19/2004 6:15:24 PM Debashish Mishra  
--  8    DevTSM    1.7         3/8/2004 10:37:15 AM Debashish Mishra  
--  7    DevTSM    1.6         3/3/2004 11:00:32 AM Debashish Mishra  
--  6    DevTSM    1.5         2/25/2004 2:46:14 PM Debashish Mishra Moved
--       deployment labels around
--  5    DevTSM    1.4         2/24/2004 12:27:19 PMDebashish Mishra  
--  4    DevTSM    1.3         2/20/2004 4:54:28 PM Debashish Mishra  
--  3    DevTSM    1.2         2/12/2004 10:41:36 AMDebashish Mishra  
--  2    DevTSM    1.1         1/30/2004 3:27:11 PM Debashish Mishra  
--  1    DevTSM    1.0         1/20/2004 6:17:36 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
