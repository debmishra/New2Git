--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tsm10_procedures.sql$ 
--
-- $Revision: 19$        $Date: 2/22/2008 11:56:05 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

create or replace function Increment_sequence (seq_name in varchar2,
increment_by in number default 1)  return number is
pragma autonomous_transaction;

start_value number(10);

begin

select next_id into start_value from id_control where 
table_name = lower(substr(seq_name,1,length(seq_name)-4))
for update;

update id_control set next_id = next_id+increment_by where 
table_name = lower(substr(seq_name,1,length(seq_name)-4));

commit;
return(start_value);

end;
/



create or replace procedure CreateTsmMessage(ClientDivId in number,
	msg_hdr in varchar2,msg_txt in varchar2) as

admin_userid number(10);

begin

  select id into admin_userid from ftuser where name = 'ftadmin@fasttrack';

  Insert into tsm_message (ID,MESSAGE_TEXT,CREATOR_FTUSER_ID,ADDRESSEE_FTUSER_ID,
  MESSAGE_DATE,DISMISSED_FLG,SEEN_FLG,MESSAGE_HEADER) select increment_sequence('tsm_message_seq',1),
  msg_txt,admin_userid,id,sysdate,0,0,msg_hdr from ftuser where client_div_id = ClientDivId;

 commit;
end;
/
sho err

 
create or replace procedure releaseClientBld(BuildTagId in number, 
    ClientDivId in number) as


cnt1 number(10);


begin

  update build_tag_to_client_div set (released, released_date) =
  (select 1,sysdate from dual) where client_div_id=ClientDivId 
   and build_tag_id=BuildTagId;

  update client_div set build_tag_id=BuildTagId where 
  id=ClientDivId;

  select count(*) into cnt1 from build_tag_to_client_div 
  where released=1 and client_div_id=ClientDivId;

  If cnt1 > 2 then
     delete build_tag_to_client_div where client_div_id=ClientDivId 
     and released=1 and build_tag_id = (select min(build_tag_id) from 
     build_tag_to_client_div where client_div_id=ClientDivId and 
     released=1);
  End if;

  CreateTsmMessage(ClientDivId,'New Build Data','New data is available for your company.  Please update the data accordingly.');

 commit;
end;
/
sho err

create or replace procedure LicenseWarning as

  cursor c1 is select client_div_id from client_div_to_lic_app where 
        license_exp_date <= sysdate+6 and license_exp_date > sysdate+2 and
        app_name = 'PICASE' ;
  cursor c2 is select client_div_id from client_div_to_lic_app where 
	license_exp_date <= sysdate+2 and license_exp_date > sysdate+1 and
	app_name = 'PICASE' ;

  client_admin_users number(10);
  admin_userid number(10);
  message_exist number(10);
  msg_txt1 varchar2(100);
  msg_txt2 varchar2(100);
  msg_txt3 varchar2(100);
  lic_exp_dt varchar2(40);
  msg_hdr varchar2(40):= 'License Warning';
  msg_txt varchar2(256);

begin

  select id into admin_userid from ftuser where name = 'ftadmin@fasttrack'; 

  msg_txt1:='Your Grants Manager contract will expire on ';
  msg_txt2:='. You will not be able to access the system after this date. ';
  msg_txt3:='Please contact your Fast Track representative if needed.  Thank you.';

  for ix1 in c1 loop
 
    select count(*) into client_admin_users from ftuser a, ftuser_to_ftgroup b, ftgroup c
    where a.id = b.ftuser_id and b.ftgroup_id = c.id and a.client_div_id =  ix1.client_div_id and 
    c.name = 'Client Admin' ;

    select to_char(license_exp_date,'YYYY-MM-DD') into 
    lic_exp_dt from client_div_to_lic_app where client_div_id = ix1.client_div_id 
    and app_name = 'PICASE';

    If client_admin_users > 0  then

      msg_txt:=msg_txt1||lic_exp_dt||msg_txt2||msg_txt3;

      select count(*) into message_exist from tsm_message where message_date between
      sysdate-7 and sysdate  and message_header = 'License Warning' and
      addressee_ftuser_id in (select a.id from ftuser a, ftuser_to_ftgroup b, ftgroup c
      where a.id = b.ftuser_id and b.ftgroup_id = c.id and a.client_div_id =  ix1.client_div_id and 
      c.name = 'Client Admin'); 
    
      If message_exist = 0 then 

        Insert into  tsm_message (ID,MESSAGE_TEXT,CREATOR_FTUSER_ID,ADDRESSEE_FTUSER_ID,
        MESSAGE_DATE,DISMISSED_FLG,SEEN_FLG,MESSAGE_HEADER) select increment_sequence('tsm_message_seq',1),
        msg_txt,admin_userid,a.id,sysdate,0,0,msg_hdr from ftuser a, ftuser_to_ftgroup b, ftgroup c
        where a.id = b.ftuser_id and b.ftgroup_id = c.id and a.client_div_id =  ix1.client_div_id and 
        c.name = 'Client Admin' ;

      end if;
    end if;
  End loop;

  for ix2 in c2 loop

    select count(*) into client_admin_users from ftuser a, ftuser_to_ftgroup b, ftgroup c
    where a.id = b.ftuser_id and b.ftgroup_id = c.id and a.client_div_id =  ix2.client_div_id and 
    c.name = 'Client Admin' ;


      select to_char(license_exp_date,'YYYY-MM-DD') into 
      lic_exp_dt from client_div_to_lic_app where client_div_id = ix2.client_div_id 
      and app_name = 'PICASE';

    If client_admin_users > 0  then

      msg_txt:=msg_txt1||lic_exp_dt||msg_txt2||msg_txt3;

      select count(*) into message_exist from tsm_message where message_date between
      sysdate-7 and sysdate  and message_header = 'License Warning' and seen_flg = 0 and
      addressee_ftuser_id in ( select a.id from ftuser a, ftuser_to_ftgroup b, ftgroup c
      where a.id = b.ftuser_id and b.ftgroup_id = c.id and a.client_div_id =  ix2.client_div_id and 
      c.name = 'Client Admin') ;    

      If message_exist = 0 then 

         Insert into  tsm_message (ID,MESSAGE_TEXT,CREATOR_FTUSER_ID,ADDRESSEE_FTUSER_ID,
         MESSAGE_DATE,DISMISSED_FLG,SEEN_FLG,MESSAGE_HEADER) select increment_sequence('tsm_message_seq',1),
         msg_txt,admin_userid,a.id,sysdate,0,0,msg_hdr from ftuser a, ftuser_to_ftgroup b, ftgroup c
         where a.id = b.ftuser_id and b.ftgroup_id = c.id and a.client_div_id =  ix2.client_div_id and 
         c.name = 'Client Admin' ;

      End if;
    End if;

  End loop;

 commit;
end;
/

sho err


--create or replace function Increment_sequence (seq_name in varchar2,
--increment_by in number default 1)  return number is

--type TabSeqTyp is ref cursor;
--tab_seq TabSeqTyp;

--start_value number(10);
--last_value number(10);
--diff_value number(10);

--begin

--<<try_again>>

--open tab_seq for 'select '||seq_name||'.nextval from dual';
--fetch tab_seq into start_value ;
--close tab_seq;

--for i in 1..increment_by-1 loop 

--open tab_seq for 'select '||seq_name||'.nextval from dual';
--fetch tab_seq into last_value ;
--close tab_seq;

--end loop;

--diff_value:=last_value-start_value+1;

--If diff_value <> increment_by then 
--   goto try_again;
--end if; 
--
--return(start_value);
--end;
--/

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
sho err

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
sho err

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

create or replace procedure TGM_client_build_1 (clientDivIdentifier in varchar2)
as 
begin
update client_div set (country_id,using_webstart)=(select id,0 from country where
abbreviation = 'USA') where client_div_identifier = ClientDivIdentifier;
Insert into client_group(id,client_div_id,name) select 
	increment_sequence('client_group_seq'),id,'Default Group' from client_div
	where client_div_identifier = ClientDivIdentifier;
commit;
end;
/

create or replace procedure TGM_client_build_2 (clientDivIdentifier in varchar2,
PrincipalContact in varchar2,
AppType in varchar2 default 'PICASE',
tel# in varchar2 default null, GMVersion in varchar2 default null,
FrontEndVersion in varchar2 default null, 
PatchAvailable in number default 0,
PatchVersion in varchar2 default null)
as
begin
update ftuser set last_password_update=sysdate 
where name='fasttrack@'||clientDivIdentifier;

update client_div_to_lic_app set principal_contact_id = (Select id from ftuser
where name=PrincipalContact||'@'||clientDivIdentifier)
where client_div_id = (select id from client_div where
client_div_identifier = clientDivIdentifier
and app_name = AppType);

If tel# is not null then
  update ftuser set WORK_PHONE = tel# where name=PrincipalContact||'@'||clientDivIdentifier;
end if;

If GMVersion is not null then
  update client_div_to_lic_app set version = GMVersion 
  where client_div_id = (select id from client_div where
  client_div_identifier = clientDivIdentifier
  and app_name = AppType);
end if;

If FrontEndVersion is not null then 
  update client_div_to_lic_app set frontend_version = FrontEndVersion 
  where client_div_id = (select id from client_div where
  client_div_identifier = clientDivIdentifier
  and app_name = AppType);
end if;

If PatchAvailable=1 then
  update client_div_to_lic_app set patch_available = PatchAvailable 
  where client_div_id = (select id from client_div where
  client_div_identifier = clientDivIdentifier
  and app_name = AppType);
end if;

If PatchVersion is not null then 
  update client_div_to_lic_app set patch_version = PatchVersion 
  where client_div_id = (select id from client_div where
  client_div_identifier = clientDivIdentifier
  and app_name = AppType);
end if;

commit;
end;
/

create or replace procedure update_tspd_proc_pricing(BuildTag number) as

BuildTagExists			number(5);
GMBuildExists			number(5);
TSDBuildExists			number(5);
GMTableExists			number(5);
TSDTableExists			number(5);
curruser			varchar2(30);
stmt				varchar2(512);
		

InvalidBuildTag			exception;
InvalidGMBuild			exception;
InvalidTSDBuild			exception;
InvalidGMTable			exception;
InvalidTSDTable			exception;

begin

select count(*) into BuildTagExists from build_tag where id=BuildTag;
   if BuildTagExists =0 then
      raise InvalidBuildTag;
   end if;

select user into currUser from dual;
select count(*) into GMBuildExists from all_users where username=CurrUser||'_FTS_'||BuildTag;
select count(*) into TSDBuildExists from all_users where username=CurrUser||'_TSPD_'||BuildTag;

If GMBuildExists=0 then 
   raise InvalidGMBuild;
end if;

If TSDBuildExists=0 then 
   raise InvalidTSDBuild;
end if;

select count(*) into GMTableExists from all_tables where owner=CurrUser||'_FTS_'||BuildTag and table_name='PAP_CLINICAL_PROC_COST';
select count(*) into TSDTableExists from all_tables where owner=CurrUser||'_TSPD_'||BuildTag and table_name='TSPD_PROC_PRICING';

If GMTableExists=0 then 
   raise InvalidGMTable;
end if;

If TSDTableExists=0 then 
   raise InvalidTSDTable;
end if;

stmt:='update '||CurrUser||'_TSPD_'||BuildTag||'.tspd_proc_pricing a set a.pct50=
(select pct50 from '||CurrUser||'_FTS_'||BuildTag||'.pap_clinical_proc_cost b, country c
where b.mapper_id=a.mapper_id and b.country_id=c.id and c.abbreviation='||''''||'USA'||''''||' 
and b.phase_id=0 and b.indmap_id=0)';


execute immediate(stmt);

commit;
exception

  when InvalidBuildTag then
      raise_application_error(-20111,'Invalid Build Tag');
  when InvalidGMBuild then
      raise_application_error(-20112,'GM FTS build not found with build tag '||BuildTag);
  when InvalidTSDBuild then
      raise_application_error(-20113,'TSD build not found with build tag '||BuildTag);
  when InvalidGMTable then
      raise_application_error(-20114,'table PAP_CLINICAL_PROC_COST not found in the GM build');
  when InvalidTSDTable then
      raise_application_error(-20115,'table TSPD_PROC_PRICING not found in TSD build');

end;
/

exit;


create or replace function Increment_sequence (seq_name in varchar2,
increment_by in number default 1)  return number is
pragma autonomous_transaction;

start_value number(10);

begin

update id_control set next_id = next_id+increment_by where 
table_name = lower(substr(seq_name,1,length(seq_name)-4));


select next_id - increment_by into start_value from id_control where 
table_name = lower(substr(seq_name,1,length(seq_name)-4));

commit;

return(start_value);

end;
/

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  19   DevTSM    1.18        2/22/2008 11:56:05 AMDebashish Mishra  
--  18   DevTSM    1.17        5/8/2007 5:57:19 PM  Debashish Mishra  
--  17   DevTSM    1.16        9/19/2006 12:11:44 AMDebashish Mishra   
--  16   DevTSM    1.15        8/16/2006 1:48:09 PM Debashish Mishra  
--  15   DevTSM    1.14        3/18/2005 8:48:20 AM Debashish Mishra  
--  14   DevTSM    1.13        3/2/2005 10:51:15 PM Debashish Mishra  
--  13   DevTSM    1.12        1/26/2005 7:00:42 AM Debashish Mishra  
--  12   DevTSM    1.11        11/16/2004 12:38:43 AMDebashish Mishra  
--  11   DevTSM    1.10        4/8/2004 4:09:35 PM  Debashish Mishra  
--  10   DevTSM    1.9         7/30/2003 4:45:24 PM Debashish Mishra  
--  9    DevTSM    1.8         10/24/2002 3:40:35 PMDebashish Mishra  
--  8    DevTSM    1.7         10/17/2002 4:09:55 PMDebashish Mishra bugs fixed
--  7    DevTSM    1.6         10/4/2002 9:30:05 AM Debashish Mishra changes
--       relatred to new id_control table
--  6    DevTSM    1.5         7/2/2002 1:27:52 PM  Debashish Mishra Added one
--       constraint to role_inst and a temporary procedure to populate it
--  5    DevTSM    1.4         6/13/2002 11:51:22 AMDebashish Mishra all changes
--       done after Picas-e beta
--  4    DevTSM    1.3         5/15/2002 9:45:30 AM Debashish Mishra  
--  3    DevTSM    1.2         5/10/2002 11:59:29 AMDebashish Mishra  
--  2    DevTSM    1.1         4/3/2002 6:58:48 PM  Debashish Mishra  
--  1    DevTSM    1.0         3/22/2002 12:52:40 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
