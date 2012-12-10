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

sho err

Alter table ftuser add (messaging_flg number (1,0));

Alter table ftuser add constraint ftuser_messaging_flg_check 
check(messaging_flg in (0,1));

exit;
