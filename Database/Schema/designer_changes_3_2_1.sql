/**Created by Vikram 04-16-12
Applied on DEVL 
***/
create or replace
procedure  ftcommon.failedloginattempts
(schemaname in varchar2, username in varchar2, apptype in varchar2 default 'UNKNOWN', reason in varchar2 default null)
as
mysql_stmt varchar2(200);
table_name varchar2(70);

mysql_stmt2 varchar2(500);
table_name2 varchar2(70);
incseq varchar2(70);
appname varchar2(50);
fail_reason varchar2(250);

begin

table_name:=schemaname||'.ftuser';
mysql_stmt:='Update '||table_name||' set failed_login_attempts=nvl(failed_login_attempts,0)+1 where LOWER(name)=LOWER(:1)';
execute immediate mysql_stmt using username;


table_name2:=schemaname||'.audit_hist';
incseq:=schemaname||'.increment_sequence';
appname:=apptype;
fail_reason:=reason;

mysql_stmt2:='Insert into '||table_name2||'(ID,FTUSER_ID,APP_TYPE,ACTION,TARGET_PRIMARY_TABLE,TARGET_ID,
   ENTITY_TYPE,ENTITY_ID,MODIFY_DATE,COMMENTS) select '||incseq||'('||''''||'audit_hist_seq'||''''||'),id,'||
   ''''||appname||''''||','||''''||'auditAction.login_failed'||''''||','||''''||'ftuser'||''''||','||'id,'||''''||'system'||''''||
   ',205,sysdate,'||''''||fail_reason||''''||' from '||table_name||' where LOWER(name)=LOWER(:1)' ;
execute immediate mysql_stmt2 using username;

commit;
end;
/