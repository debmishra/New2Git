--As per Kelly's request on 10/15/2009
ALTER TABLE ftuser ADD(imed_name VARCHAR2(255), imed_key VARCHAR2(255), imed_id NUMBER(10));


--CONNECT AS FTCOMMON and recreate the ftcommon.ftuser view
--BELOW connect statements might fail if run by copy-paste into sqlplus
accept passwd char prompt 'Connect to FTCOMMON. Enter password:' hide;
accept db_name char prompt 'Enter database name:';
conn ftcommon/&passwd@&db_name

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

--CONNECT AS TSM10 or TSM10E
--BELOW connect statements might fail if run by copy-paste into sqlplus
accept uname char prompt 'Connect to master schema. Enter username:';
accept passwd char prompt 'Enter password:' hide;
accept db_name char prompt 'Enter database name:';
conn &uname/&passwd@&db_name

--Implemented upto this in devl on 10/15/2009
--Implemented upto this in d002 on 10/15/2009
--Implemented upto this in d003 on 10/15/2009


CREATE OR REPLACE TRIGGER FTUSER_NAME_CHECK_TRG1
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

 If :n.name like '%@%' AND :n.name<>'jsp@fasttrack' then
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
        select count(*) into client_div_id_cnt from client_div where client_div_identifier = extension_v;

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
ALTER TRIGGER TSM10.FTUSER_NAME_CHECK_TRG1 ENABLE;
--Implemented upto this in devl on 10/16/2009
--Implemented upto this in d002 on 10/16/2009
--Implemented upto this in d003 on 10/16/2009


--As per Kelly's request on 10/16/2009

--CONNECT AS FTCOMMON and create the ftcommon.insertftuser procedure
--BELOW connect statements might fail if run by copy-paste into sqlplus
accept passwd char prompt 'Connect to FTCOMMON. Enter password:' hide;
accept db_name char prompt 'Enter database name:';
conn ftcommon/&passwd@&db_name

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

--CONNECT AS TSM10 or TSM10E
--BELOW connect statements might fail if run by copy-paste into sqlplus
accept uname char prompt 'Connect to master schema. Enter username:';
accept passwd char prompt 'Enter password:' hide;
accept db_name char prompt 'Enter database name:';
conn &uname/&passwd@&db_name

--Implemented upto this in devl on 10/20/2009
--Implemented upto this in d002 on 10/20/2009
--Implemented upto this in d003 on 10/20/2009
--Implemented upto this in q002 on 10/23/2009
--Implemented upto this in perf on 11/02/2009
--Implemented upto this in q003 on 11/25/2009


--As per Fiammetta's request on 11/23/2009

  ALTER TABLE audit_hist add (CODED_REASON  varchar2(50));

--Implemented upto this in devl on 11/23/2009
--Implemented upto this in d002,d003 on 11/23/2009

--As per Kelly's request on 12/07/2009

insert into id_control values ('tsm10','tspd_unlisted_proc_name',1000);
commit;

--Implemented upto this in devl,d002,d003 on 12/07/2009
--Implemented in q002 on 12/14/2009


--As per Kelly's request on 12/29/2009
conn ftcmmon;
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

conn tsm10;
CREATE OR REPLACE TRIGGER FTUSER_NAME_CHECK_TRG1 
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
 If :n.name like '%@%' AND :n.name not like '%@fasttrack' then
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

        select count(*) into client_div_id_cnt from client_div where client_div_identifier = extension_v;

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

ALTER TABLE ftuser ADD CONSTRAINT ftuser_uq2 UNIQUE (imed_name) USING INDEX
TABLESPACE tsmsmall_indx PCTFREE 5
/ 

INSERT INTO ftgroup VALUES(38,'FTAdmin Super User');
commit;

--Implemented upto this in devl,d002,d003 on 12/30/2009
--Implemented upto this in q002 on 12/30/2009


Create table ftadmin_stored_procedure (proc_name varchar2(128), Description varchar2 (2000)) tablespace tsmsmall;

Insert into ftadmin_stored_procedure values ('new_gm_clientdiv', 'Dummy Description'); 

Insert into ftadmin_stored_procedure values ('new_gm30_clientdiv', 'Dummy Description'); 

Insert into ftadmin_stored_procedure values ('new_gmc_clientdiv', 'Dummy Description'); 

Insert into ftadmin_stored_procedure values ('new_gma_clientdiv','Dummy Description'); 

Insert into ftadmin_stored_procedure values ('new_cc_clientdiv', 'Dummy Description'); 

Insert into ftadmin_stored_procedure values ('upgrade_gm_clientdiv', 'Dummy Description'); 

Insert into ftadmin_stored_procedure values ('upgrade_gm30_clientdiv', 'Dummy Description'); 

Insert into ftadmin_stored_procedure values ('upgrade_gmc_clientdiv', 'Dummy Description'); 

Insert into ftadmin_stored_procedure values ('upgrade_gma_clientdiv', 'Dummy Description'); 

Insert into ftadmin_stored_procedure values ('upgrade_cc_clientdiv', 'Dummy Description'); 

Insert into ftadmin_stored_procedure values ('new_tspd_clientdiv','Dummy Description');  

Insert into ftadmin_stored_procedure values ('upgrade_tspd_clientdiv', 'Dummy Description'); 

Insert into ftadmin_stored_procedure values ('new_clientdiv','Dummy Description'); 

commit;


create or replace function getentity(tablename in varchar2,
entityID in number) return VARCHAR2 as
name varchar2(70);
begin

         IF  tablename = 'ftuser' then
           SELECT display_name INTO name FROM ftuser WHERE id = entityID  ;
         ELSIF tablename = 'dg_dest_system'   then
          SELECT dest_system_id INTO name      FROM dg_dest_system WHERE id= entityID ;
         ELSIF tablename = 'client_div'    then
          SELECT client_div_identifier INTO name      FROM client_div WHERE id= entityID ;
         ELSIF tablename = 'client'        then
          SELECT client_identifier INTO name      FROM client WHERE id= entityID ;
        END IF;

    RETURN name ;

end;
/
--Implemented upto this in devl,d002,d003 on 12/31/2009
--Implemented upto this in q002 on 12/31/2009
--Implemented upto this in perf on 12/31/2009

CREATE OR REPLACE function getentity(tablename in varchar2,
entityID in number) return VARCHAR2 as
name varchar2(70);
begin
         IF  tablename = 'ftuser' then
           SELECT display_name INTO name FROM ftuser WHERE id = entityID  ;
         ELSIF tablename = 'dg_dest_system'   then
          SELECT dest_system_id INTO name      FROM dg_dest_system WHERE id= entityID ;
         ELSIF tablename = 'client_div'    then
          SELECT client_div_identifier INTO name      FROM client_div WHERE id= entityID ;
         ELSIF tablename = 'client'        then
          SELECT client_identifier INTO name      FROM client WHERE id= entityID ;
         ELSIF tablename = 'client_div_to_build_code'        then
          SELECT client_div_identifier INTO name      FROM client_div WHERE id= entityID ;
         ELSIF tablename = 'client_div_to_lic_country'        then
          SELECT client_div_identifier INTO name      FROM client_div WHERE id= entityID ;
        END IF;
    RETURN name ;
end;
/

--Implemented upto this in devl,d002,d003,q002 on 01/05/2010
--Implemented upto this in perf on 01/08/2010
--Implemented upto this in q003 on 01/28/2010


--As FTCOMMON user
conn ftcommon

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

conn tsm10

--Implemented upto this in devl,d002,d003,q002 on 02/11/2010
--Implemented upto this in perf on 02/11/2010
--Implemented upto this in q004 on 02/10/2010


--As per Kelly's request on 02/24/2010
conn ftcommon
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

conn tsm10

--Implemented upto this in devl,d002,d003,q004 on 02/24/2010
--Implemented upto this in q002 and perf on 02/25/2010

GRANT EXECUTE ON  INCREMENT_SEQUENCE TO ftcommon;
GRANT INSERT ON  AUDIT_HIST TO ftcommon;
GRANT INSERT ON  FTUSER TO ftcommon;
GRANT INSERT ON  FTUSER_TO_CLIENT_GROUP TO ftcommon;
GRANT INSERT ON  FTUSER_TO_FTGROUP TO ftcommon;
GRANT SELECT ON  CLIENT_DIV TO ftcommon;
GRANT SELECT ON  CLIENT_DIV_TO_LIC_APP TO ftcommon;
GRANT SELECT ON  CLIENT_GROUP TO ftcommon;
GRANT SELECT ON  FTGROUP TO ftcommon;
GRANT SELECT ON  FTUSER TO ftcommon;
GRANT SELECT ON  FTUSER_TO_CLIENT_GROUP TO ftcommon;
GRANT SELECT ON  FTUSER_TO_FTGROUP TO ftcommon;
GRANT SELECT ON  ID_CONTROL TO ftcommon;
GRANT SELECT ON  PASSWORD_RULE TO ftcommon;
GRANT UPDATE (FAILED_LOGIN_ATTEMPTS) ON FTUSER TO ftcommon;
GRANT UPDATE (LOCKED) ON FTUSER TO ftcommon;

--Implemented upto this in devl,d002,d003 on 03/11/2010
--*****************************************************
--Implemented upto this in q004 on 03/11/2010
--Implemented upto this in q002 and q003 on 03/11/2010
--*****************************************************

-- As per DB's request on 03/15/2010
alter table client_div add (study_group_id number(10) default -1 not null);


--Implemented upto this in devl,q002 on 03/15/2010
--Implemented upto this in d002, d003 on 03/17/2010
--Implemented upto this in q002, q003 on 03/17/2010

ALTER TABLE ftuser ADD CONSTRAINT ftuser_uq3 UNIQUE (client_div_id,display_name) USING INDEX
TABLESPACE tsmsmall_indx PCTFREE 5
/ 
--Implemented upto this in devl,q002 on 03/15/2010
--Implemented upto this in d002, d003 on 03/17/2010
--Implemented upto this in q002, q003, q004 on 03/17/2010