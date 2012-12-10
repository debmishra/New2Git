create or replace
procedure insertftuser
 (schemaname in varchar2, username in varchar2,firstname in varchar2,lastname in varchar2,
  ClientDiv IN varchar2, imedname in varchar2,imedkey in varchar2,activetspduser in number,
  activetsmuser in number,activetraceuser in number, activecrocasuser in number,email in varchar2, imedid in number )
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
 
 /* Due to issues with special characters in imed_key the Dynamic SQL  */
 /* is commented and replaced by SQL below.                            */
 --query_stmt := 'INSERT INTO '||table_name1||'(id,name,first_name,last_name,client_div_id,client_id,imed_name,imed_key,imed_id,active_tspd_user,
 --                      active_tsm_user, active_trace_user, active_crocas_user,last_login_date, last_password_update,email )
 --      VALUES('||incseq||'(''ftuser_seq''),'''||username||''','''||firstname||''','''||lastname||''','||
 --               ClientDivId||','||ClientID||','''||imedname||''','''||imedkey_mod||''','||imedid||','||activetspduser||','||activetsmuser||
 --               ','||activetraceuser||','||activecrocasuser||','||'sysdate'||','||'sysdate'||','''||email||''')';
 --EXECUTE IMMEDIATE query_stmt;
 
 /* Due to issues with special characters in imed_key the schema name is */
 /* hard coded to tsm10. If in future other schema is used then have more*/
 /* updates in "IF" condition.                                           */
 INSERT INTO tsm10.ftuser (id,name,first_name,last_name,client_div_id,client_id,imed_name,imed_key,imed_id,active_tspd_user,
                          active_tsm_user, active_trace_user, active_crocas_user,last_login_date, last_password_update,email)
 VALUES (tsm10.increment_sequence('ftuser_seq'),username,firstname,lastname, ClientDivId,ClientID,imedname,imedkey_mod,imedid,
 activetspduser,activetsmuser,activetraceuser,activecrocasuser,sysdate,sysdate,email);
 
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
sho err

create or replace
PROCEDURE UPDATEFTUSER (schemaname in varchar2, username in varchar2,emailaddress in varchar2,
  imedname in varchar2,imedkey in varchar2, imedid in number, ftuserid in number )
 as
   table_name1 varchar2(70);
   query_stmt varchar2(1000);
   currdate  varchar2(10);
 begin
 /* Assign variables using the schema parameter */
 table_name1:=schemaname||'.ftuser';
 
 /* Due to issues with special characters in imed_key the Dynamic SQL  */
 /* is commented and replaced by SQL below.                            */
 --currdate:='sysdate';
 --query_stmt := 'UPDATE '||table_name1||' SET name='''||username||''', email='''||emailaddress||''', imed_name='''||imedname||''', imed_key='''||imedkey||''', imed_id='||imedid||' WHERE id='||ftuserid;
 --EXECUTE IMMEDIATE query_stmt;
 
 /* Due to issues with special characters in imed_key the schema name is */
 /* hard coded to tsm10. If in future other schema is used then have more*/
 /* updates in "IF" condition.                                           */
 
 UPDATE tsm10.ftuser 
 SET email=emailaddress, imed_name=imedname, 
          imed_key=imedkey, imed_id=imedid 
 WHERE id=ftuserid;
 
 commit;
 end;
/

--******************************************************
--Implemented upto this in devl,d002,d003,d004,d005 on 09/28/2010
--Implemented upto this in q002 on 09/28/2010
--Implemented upto this in q003 on 11/03/2010
--Implemented upto this in q004 on 11/05/2010
--******************************************************



