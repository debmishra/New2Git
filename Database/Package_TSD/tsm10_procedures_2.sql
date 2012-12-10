--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tsm10_procedures_2.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:10 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------


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


exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:10 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:38:09 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:27:04 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
