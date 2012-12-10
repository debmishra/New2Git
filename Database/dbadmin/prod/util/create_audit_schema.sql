--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: create_audit_schema.sql$ 
--
-- $Revision: 5$        $Date: 2/27/2008 3:21:50 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

drop table dmishra.aud_tab;
drop view dmishra.ft_audit_trail;
drop view dmishra.ft_audit_object;
drop view dmishra.ft_audit_session;
drop view dmishra.ft_audit_statement;


create table dmishra.aud_tab(
	SESSIONID            NUMBER NOT NULL,  
	ENTRYID              NUMBER NOT NULL,
	STATEMENT            NUMBER NOT NULL,
	TIMESTAMP#           DATE NOT NULL,
	USERID               VARCHAR2(30),
	USERHOST             VARCHAR2(128),
	TERMINAL             VARCHAR2(255),
	ACTION#              NUMBER NOT NULL,
	RETURNCODE           NUMBER NOT NULL,
	OBJ$CREATOR          VARCHAR2(30),
	OBJ$NAME             VARCHAR2(128),
	AUTH$PRIVILEGES      VARCHAR2(16),
	AUTH$GRANTEE         VARCHAR2(30),
	NEW$OWNER            VARCHAR2(30),
	NEW$NAME             VARCHAR2(128),
	SES$ACTIONS          VARCHAR2(19),
	SES$TID              NUMBER,
	LOGOFF$LREAD         NUMBER,
	LOGOFF$PREAD         NUMBER,
	LOGOFF$LWRITE        NUMBER,
	LOGOFF$DEAD          NUMBER,
	LOGOFF$TIME          DATE,
	COMMENT$TEXT         VARCHAR2(4000),
	CLIENTID             VARCHAR2(64),
	SPARE1               VARCHAR2(255),
	SPARE2               NUMBER,
	OBJ$LABEL            RAW(255),
	SES$LABEL            RAW(255),
	PRIV$USED            NUMBER,
	SESSIONCPU           NUMBER)
	tablespace tsmlarge pctused 80 pctfree 5;

create or replace view dmishra.ft_audit_trail as 
select spare1           OS_USERNAME ,
       userid           USERNAME ,
       userhost         USERHOST ,
       terminal         TERMINAL ,
       timestamp#       TIMESTAMP ,
       obj$creator      OWNER ,
       obj$name         OBJ_NAME ,
       aud.action#      ACTION ,
       act.name         ACTION_NAME ,
       new$owner        NEW_OWNER ,
       new$name         NEW_NAME ,
       decode(aud.action#,
              108 /* grant  sys_priv */, null,
              109 /* revoke sys_priv */, null,
              114 /* grant  role */, null,
              115 /* revoke role */, null,
              auth$privileges)
                        OBJ_PRIVILEGE ,
       decode(aud.action#,
              108 /* grant  sys_priv */, spm.name,
              109 /* revoke sys_priv */, spm.name,
              null)
                         SYS_PRIVILEGE ,
       decode(aud.action#,
              108 /* grant  sys_priv */, substr(auth$privileges,1,1),
              109 /* revoke sys_priv */, substr(auth$privileges,1,1),
              114 /* grant  role */, substr(auth$privileges,1,1),
              115 /* revoke role */, substr(auth$privileges,1,1),
              null)
                         ADMIN_OPTION ,
       auth$grantee      GRANTEE ,
       decode(aud.action#,
              104 /* audit   */, aom.name,
              105 /* noaudit */, aom.name,
              null)
                         AUDIT_OPTION  ,
       ses$actions       SES_ACTIONS   ,
       logoff$time       LOGOFF_TIME   ,
       logoff$lread      LOGOFF_LREAD  ,
       logoff$pread      LOGOFF_PREAD  ,
       logoff$lwrite     LOGOFF_LWRITE ,
       decode(aud.action#,
              104 /* audit   */, null,
              105 /* noaudit */, null,
              108 /* grant  sys_priv */, null,
              109 /* revoke sys_priv */, null,
              114 /* grant  role */, null,
              115 /* revoke role */, null,
              aud.logoff$dead)
                         LOGOFF_DLOCK ,
       comment$text       COMMENT_TEXT ,
       sessionid          SESSIONID ,
       entryid            ENTRYID ,
       statement          STATEMENTID ,
       returncode         RETURNCODE ,
       spx.name          PRIV_USED ,
       clientid          CLIENT_ID ,
       sessioncpu        SESSION_CPU 
from dmishra.aud_tab aud, system_privilege_map spm, system_privilege_map spx,
     STMT_AUDIT_OPTION_MAP aom, audit_actions act
where   aud.action#     = act.action    (+)
  and - aud.logoff$dead = spm.privilege (+)
  and   aud.logoff$dead = aom.option#   (+)
  and - aud.priv$used   = spx.privilege (+);



create or replace view dmishra.ft_audit_object as
select OS_USERNAME, USERNAME, USERHOST, TERMINAL, TIMESTAMP,
       OWNER, OBJ_NAME, ACTION_NAME, NEW_OWNER, NEW_NAME,
       SES_ACTIONS, COMMENT_TEXT, SESSIONID, ENTRYID, STATEMENTID,
       RETURNCODE, PRIV_USED, CLIENT_ID, SESSION_CPU
from dmishra.ft_audit_trail
where (action between 1 and 16)
   or (action between 19 and 29)
   or (action between 32 and 41)
   or (action = 43)
   or (action between 51 and 99)
   or (action = 103)
   or (action between 110 and 113)
   or (action between 116 and 121)
   or (action between 123 and 128)
   or (action between 160 and 162);

create or replace view dmishra.ft_audit_session as
select os_username, username, userhost, terminal, timestamp, action_name,
       logoff_time, logoff_lread, logoff_pread, logoff_lwrite, logoff_dlock,
       sessionid, returncode, client_id, session_cpu
from dmishra.ft_audit_trail
where action between 100 and 102;

create or replace view dmishra.ft_audit_statement as
select OS_USERNAME, USERNAME, USERHOST, TERMINAL, TIMESTAMP,
       OWNER, OBJ_NAME, ACTION_NAME, NEW_NAME,
       OBJ_PRIVILEGE, SYS_PRIVILEGE, ADMIN_OPTION, GRANTEE, AUDIT_OPTION,
       SES_ACTIONS, COMMENT_TEXT, SESSIONID, ENTRYID, STATEMENTID,
       RETURNCODE, PRIV_USED, CLIENT_ID, SESSION_CPU
from dmishra.ft_audit_trail
where action in (        17 /* GRANT OBJECT  */,
                         18 /* REVOKE OBJECT */,
                         30 /* AUDIT OBJECT */,
                         31 /* NOAUDIT OBJECT */,
                         49 /* ALTER SYSTEM */,
                        104 /* SYSTEM AUDIT */,
                        105 /* SYSTEM NOAUDIT */,
                        106 /* AUDIT DEFAULT */,
                        107 /* NOAUDIT DEFAULT */,
                        108 /* SYSTEM GRANT */,
                        109 /* SYSTEM REVOKE */,
                        114 /* GRANT ROLE */,
                        115 /* REVOKE ROLE */ );



---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/27/2008 3:21:50 PM Debashish Mishra  
--  4    DevTSM    1.3         3/3/2005 6:44:51 AM  Debashish Mishra  
--  3    DevTSM    1.2         9/9/2003 8:25:12 AM  Debashish Mishra  
--  2    DevTSM    1.1         8/5/2002 1:54:52 PM  Debashish Mishra Modified for
--       implementation of audit_trail
--  1    DevTSM    1.0         8/2/2002 11:26:10 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
