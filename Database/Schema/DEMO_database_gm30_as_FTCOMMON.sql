----------------------------
---BEGIN GM3.0 SECTION -----
----------------------------

ALTER TABLE application DROP CONSTRAINT APPLICATION_APP_NAME_CHECK;
ALTER TABLE application ADD CONSTRAINT APPLICATION_APP_NAME_CHECK 
CHECK (app_name in ('PICASE', 'TRACE','TSPD','FTADMIN','CROCAS','GM30'));
INSERT INTO application VALUES(6,'GM30','Grants Manager 3.0',null);
commit;

--Implemented upto this in devl,d002,d003 on 12/18/2009
--Implemented upto this in q002,perf on 12/28/2009

select '**** END GM3.0 SECTIONS ******' from dual;

----------------------------
---END GM3.0 SECTION -----
----------------------------

----------------------------
---BEGIN COMMON SECTION ----
----------------------------

--CONNECT AS FTCOMMON and recreate the ftcommon.ftuser view

--MODIFY the schema name to TSM10E for prev database
CREATE OR REPLACE FORCE VIEW FTCOMMON.FTUSER (ID, NAME, PASSWORD, SITE_ID, STARTING_SCREEN, 
LAST_PASSWORD_UPDATE, FIRST_NAME, LAST_NAME, LAST_LOGIN_DATE, PRIMARY_TA_ID, ADDRESS_LINE_1, 
ADDRESS_LINE_2, CITY, STATE, POSTAL_CODE, COUNTRY, WORK_PHONE, HOME_PHONE, FAX,
 MOBILE_PHONE, EMAIL, PREFERRED_CONTACT, TITLE, CLIENT_ID, CLIENT_DIV_ID, DISPLAY_NAME,
 ACTIVE_TRACE_USER, ACTIVE_TSM_USER, CAN_MODEL_FLAG, DEF_PLAN_CURRENCY_ID, OLD_PASSWORD,
 ACTIVE_TSPD_USER, LOCKED, FAILED_LOGIN_ATTEMPTS, ENVIRONMENT,IMED_NAME,imed_key,imed_id ) 
AS SELECT ID,NAME||'@tsm10' name, PASSWORD,SITE_ID,STARTING_SCREEN,LAST_PASSWORD_UPDATE,
FIRST_NAME,LAST_NAME,LAST_LOGIN_DATE,PRIMARY_TA_ID,ADDRESS_LINE_1,
ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,WORK_PHONE,
HOME_PHONE,FAX,MOBILE_PHONE,EMAIL,PREFERRED_CONTACT,TITLE,
CLIENT_ID,CLIENT_DIV_ID,DISPLAY_NAME,ACTIVE_TRACE_USER,
ACTIVE_TSM_USER,CAN_MODEL_FLAG,DEF_PLAN_CURRENCY_ID,
OLD_PASSWORD,ACTIVE_TSPD_USER,locked,failed_login_attempts,
'tsm10' environment,decode(IMED_NAME,null,null,IMED_NAME||'@tsm10') IMED_NAME ,imed_key,imed_id from tsm10.ftuser;

--Implemented upto this in devl on 10/15/2009
--Implemented upto this in d002 on 10/15/2009
--Implemented upto this in d003 on 10/15/2009

--As per Kelly's request on 10/16/2009

--CONNECT AS FTCOMMON and create the ftcommon.insertftuser procedure

create or replace 
procedure   insertftuser
 (schemaname in varchar2, username in varchar2,firstname in varchar2,lastname in varchar2,
  ClientDiv IN varchar2, imedname in varchar2,imedkey in varchar2,activetspduser in number,
  activetsmuser in number,activetraceuser in number, activecrocasuser in number,email in varchar2 )
 as
   ClientDivId number;
   ClientId number;
   table_name1 varchar2(70);
   table_name2 varchar2(70);
   incseq varchar2(70);
   query_stmt varchar2(1000);
   query1 varchar2(200);
   currdate  varchar2(10);
 begin
 
 /* Assign variables using the schema parameter */
 table_name1:=schemaname||'.ftuser';
 table_name2:=schemaname||'.client_div';
 incseq:=schemaname||'.increment_sequence';
 currdate:='sysdate';
 
 /* Retrieve client_div_id value from the the client_div table */
 query1 := 'SELECT id,client_id FROM '||table_name2||' WHERE client_div_identifier='''||clientdiv||'''';
 EXECUTE IMMEDIATE query1 INTO ClientDivId, ClientID;
 
 /* Insert new record into FTUSER table */
 query_stmt := 'INSERT INTO '||table_name1||'(id,name,first_name,last_name,client_div_id,client_id,imed_name,imed_key, active_tspd_user,
                       active_tsm_user, active_trace_user, active_crocas_user,last_login_date, last_password_update,email )
        VALUES('||incseq||'(''ftuser_seq''),'''||username||''','''||firstname||''','''||lastname||''','||
                ClientDivId||','||ClientID||','''||imedname||''','''||imedkey||''','||activetspduser||','||activetsmuser||
                ','||activetraceuser||','||activecrocasuser||','||'sysdate'||','||'sysdate'||','''||email||''')';
 EXECUTE IMMEDIATE query_stmt;
 commit;
 end;
/

--As per Kelly's request on 12/29/2009
--conn ftcmmon;


create or replace
procedure            insertftuser
 (schemaname in varchar2, username in varchar2,firstname in varchar2,lastname in varchar2,
  ClientDiv IN varchar2, imedname in varchar2,imedkey in varchar2,activetspduser in number,
  activetsmuser in number,activetraceuser in number, activecrocasuser in number,email in varchar2 )
 as
   ClientDivId number;
   ClientId number;
   table_name1 varchar2(70);
   table_name2 varchar2(70);
   table_name3 varchar2(70);
   incseq varchar2(70);
   query_stmt varchar2(1000);
   query1 varchar2(200);
   currdate  varchar2(10);
   FtuserId number;
   query2 varchar2(100);
   query_stmt1 varchar2(1000);

 begin
 
 /* Assign variables using the schema parameter */
 table_name1:=schemaname||'.ftuser';
 table_name2:=schemaname||'.client_div';
 table_name3:=schemaname||'.ftuser_to_ftgroup';
 incseq:=schemaname||'.increment_sequence';
 currdate:='sysdate';
 
 /* Retrieve client_div_id value from the the client_div table */
 query1 := 'SELECT id,client_id FROM '||table_name2||' WHERE client_div_identifier='''||clientdiv||'''';
 EXECUTE IMMEDIATE query1 INTO ClientDivId, ClientID;
 
 /* Insert new record into FTUSER table */
 query_stmt := 'INSERT INTO '||table_name1||'(id,name,first_name,last_name,client_div_id,client_id,imed_name,imed_key, active_tspd_user,
                       active_tsm_user, active_trace_user, active_crocas_user,last_login_date, last_password_update,email )
        VALUES('||incseq||'(''ftuser_seq''),'''||username||''','''||firstname||''','''||lastname||''','||
                ClientDivId||','||ClientID||','''||imedname||''','''||imedkey||''','||activetspduser||','||activetsmuser||
                ','||activetraceuser||','||activecrocasuser||','||'sysdate'||','||'sysdate'||','''||email||''')';
 EXECUTE IMMEDIATE query_stmt;

 /* Insert 2 records into FTUSER_TO_FTGROUP table if activetsmuser=1 */
 IF activetsmuser=1 
 THEN
   query2 := 'SELECT id FROM '||table_name1||' WHERE name='''||username||'''';
   EXECUTE IMMEDIATE query2 INTO FtuserId;

   query_stmt1 := 'INSERT INTO '||table_name3||'(id,ftuser_id,ftgroup_id)
        VALUES('||incseq||'(''ftuser_to_ftgroup_seq''),'||FtuserId||','||9||')';  
   EXECUTE IMMEDIATE query_stmt1;

   query_stmt1 := 'INSERT INTO '||table_name3||'(id,ftuser_id,ftgroup_id)
        VALUES('||incseq||'(''ftuser_to_ftgroup_seq''),'||FtuserId||','||10||')';  
   EXECUTE IMMEDIATE query_stmt1;
 END IF;

 commit;
 end;
/

create or replace
procedure            insertftuser
 (schemaname in varchar2, username in varchar2,firstname in varchar2,lastname in varchar2,
  ClientDiv IN varchar2, imedname in varchar2,imedkey in varchar2,activetspduser in number,
  activetsmuser in number,activetraceuser in number, activecrocasuser in number,email in varchar2 )
 as
   ClientDivId number;
   ClientId number;
   table_name1 varchar2(70);
   table_name2 varchar2(70);
   table_name3 varchar2(70);
   incseq varchar2(70);
   query_stmt varchar2(1000);
   query1 varchar2(200);
   currdate  varchar2(10);
   FtuserId number;
   query2 varchar2(100);
   query_stmt1 varchar2(1000);
   imedkey_mod varchar2(500);
 begin
 /* Assign variables using the schema parameter */
 table_name1:=schemaname||'.ftuser';
 table_name2:=schemaname||'.client_div';
 table_name3:=schemaname||'.ftuser_to_ftgroup';
 incseq:=schemaname||'.increment_sequence';
 currdate:='sysdate';

 select replace(imedkey,'''','''''') INTO imedkey_mod FROM dual;

 /* Retrieve client_div_id value from the the client_div table */
 query1 := 'SELECT id,client_id FROM '||table_name2||' WHERE client_div_identifier='''||clientdiv||'''';
 EXECUTE IMMEDIATE query1 INTO ClientDivId, ClientID;
 /* Insert new record into FTUSER table */
 query_stmt := 'INSERT INTO '||table_name1||'(id,name,first_name,last_name,client_div_id,client_id,imed_name,imed_key, active_tspd_user,
                       active_tsm_user, active_trace_user, active_crocas_user,last_login_date, last_password_update,email )
        VALUES('||incseq||'(''ftuser_seq''),'''||username||''','''||firstname||''','''||lastname||''','||
                ClientDivId||','||ClientID||','''||imedname||''','''||imedkey_mod||''','||activetspduser||','||activetsmuser||
                ','||activetraceuser||','||activecrocasuser||','||'sysdate'||','||'sysdate'||','''||email||''')';
 EXECUTE IMMEDIATE query_stmt;
 IF activetsmuser=1
 THEN
   query2 := 'SELECT id FROM '||table_name1||' WHERE name='''||username||'''';
   EXECUTE IMMEDIATE query2 INTO FtuserId;
   query_stmt1 := 'INSERT INTO '||table_name3||'(id,ftuser_id,ftgroup_id)
        VALUES('||incseq||'(''ftuser_to_ftgroup_seq''),'||FtuserId||','||9||')';
   EXECUTE IMMEDIATE query_stmt1;
   query_stmt1 := 'INSERT INTO '||table_name3||'(id,ftuser_id,ftgroup_id)
        VALUES('||incseq||'(''ftuser_to_ftgroup_seq''),'||FtuserId||','||10||')';
   EXECUTE IMMEDIATE query_stmt1;
 END IF;
 commit;
 end;
/

--Implemented upto this in devl,d002,d003,q002 on 02/11/2010
--Implemented upto this in perf on 02/11/2010
--Implemented upto this in q004 on 02/10/2010


--As per Kelly's request on 02/24/2010
create or replace
procedure            insertftuser
 (schemaname in varchar2, username in varchar2,firstname in varchar2,lastname in varchar2,
  ClientDiv IN varchar2, imedname in varchar2,imedkey in varchar2,activetspduser in number,
  activetsmuser in number,activetraceuser in number, activecrocasuser in number,email in varchar2 )
 as
   ClientDivId number;
   ClientId number;
   table_name1 varchar2(70);
   table_name2 varchar2(70);
   table_name3 varchar2(70);
   table_name4 varchar2(70);
   table_name5 varchar2(70);
   incseq varchar2(70);
   query_stmt varchar2(1000);
   query1 varchar2(200);
   currdate  varchar2(10);
   FtuserId number;
   query2 varchar2(100);
   query_stmt1 varchar2(1000);
   imedkey_mod varchar2(500);
 begin
 /* Assign variables using the schema parameter */
 table_name1:=schemaname||'.ftuser';
 table_name2:=schemaname||'.client_div';
 table_name3:=schemaname||'.ftuser_to_ftgroup';
 table_name4:=schemaname||'.client_group';
 table_name5:=schemaname||'.ftuser_to_client_group';
 incseq:=schemaname||'.increment_sequence';
 currdate:='sysdate';
 select replace(imedkey,'''','''''') INTO imedkey_mod FROM dual;
 /* Retrieve client_div_id value from the the client_div table */
 query1 := 'SELECT id,client_id FROM '||table_name2||' WHERE client_div_identifier='''||clientdiv||'''';
 EXECUTE IMMEDIATE query1 INTO ClientDivId, ClientID;
 /* Insert new record into FTUSER table */
 query_stmt := 'INSERT INTO '||table_name1||'(id,name,first_name,last_name,client_div_id,client_id,imed_name,imed_key, active_tspd_user,
                       active_tsm_user, active_trace_user, active_crocas_user,last_login_date, last_password_update,email )
        VALUES('||incseq||'(''ftuser_seq''),'''||username||''','''||firstname||''','''||lastname||''','||
                ClientDivId||','||ClientID||','''||imedname||''','''||imedkey_mod||''','||activetspduser||','||activetsmuser||
                ','||activetraceuser||','||activecrocasuser||','||'sysdate'||','||'sysdate'||','''||email||''')';
 EXECUTE IMMEDIATE query_stmt;
 IF activetsmuser=1
 THEN
   query2 := 'SELECT id FROM '||table_name1||' WHERE name='''||username||'''';
   EXECUTE IMMEDIATE query2 INTO FtuserId;
   query_stmt1 := 'INSERT INTO '||table_name3||'(id,ftuser_id,ftgroup_id)
        VALUES('||incseq||'(''ftuser_to_ftgroup_seq''),'||FtuserId||','||9||')';
   EXECUTE IMMEDIATE query_stmt1;
   query_stmt1 := 'INSERT INTO '||table_name3||'(id,ftuser_id,ftgroup_id)
        VALUES('||incseq||'(''ftuser_to_ftgroup_seq''),'||FtuserId||','||10||')';
   EXECUTE IMMEDIATE query_stmt1;
   query_stmt1 := 'INSERT INTO '||table_name5||'  SELECT '||incseq||'(''ftuser_to_client_group_seq''),id,'||FtuserId||', 1
   FROM '||table_name4||' WHERE client_div_id='||ClientDivId||' and name=''Default Group''';
   EXECUTE IMMEDIATE query_stmt1;
 END IF;
 commit;
 end;
/

--Implemented upto this in devl,d002,d003,q004 on 02/24/2010
--Implemented upto this in q002 and perf on 02/25/2010

----------------------------
---END COMMON SECTION ----
----------------------------