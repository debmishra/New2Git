----------------------------
---BEGIN GM3.0 SECTION -----
----------------------------
INSERT INTO country(id,NAME,ABBREVIATION,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE,group_country_id) 
VALUES(increment_sequence('country_seq'),'Ecuador','EDR',1,2,0,0,0,0,1,126);
INSERT INTO country(id,NAME,ABBREVIATION,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE,group_country_id) 
VALUES(increment_sequence('country_seq'),'Iran','IRN',1,2,0,0,0,0,1,125);
INSERT INTO country(id,NAME,ABBREVIATION,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE,group_country_id) 
VALUES(increment_sequence('country_seq'),'Kenya','KYA',1,2,0,0,0,0,1,122);
INSERT INTO country(id,NAME,ABBREVIATION,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE,group_country_id) 
VALUES(increment_sequence('country_seq'),'Tanzania','TNZ',1,2,0,0,0,0,1,122);
INSERT INTO country(id,NAME,ABBREVIATION,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE,group_country_id) 
VALUES(increment_sequence('country_seq'),'Uganda','UGN',1,2,0,0,0,0,1,122);
INSERT INTO country(id,NAME,ABBREVIATION,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE,group_country_id) 
VALUES(increment_sequence('country_seq'),'Zambia','ZMB',1,2,0,0,0,0,1,122);
INSERT INTO country(id,NAME,ABBREVIATION,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE,group_country_id) 
VALUES(increment_sequence('country_seq'),'Malawi','MWI',1,2,0,0,0,0,1,122);


--BELOW INSERT ONLY VALID FOR DEVL database.
--INSERT INTO client_div_to_lic_country 
--SELECT increment_sequence('client_div_to_lic_country_seq'),31, id FROM country 
--WHERE is_mdsol_viewable=1 
--AND id not in (select country_id FROM client_div_to_lic_country WHERE client_div_id=31);

--BELOW INSERTS ONLY VALID FOR Q002 database.
--INSERT INTO client_div_to_lic_country 
--SELECT increment_sequence('client_div_to_lic_country_seq'),91, id FROM country 
--WHERE is_mdsol_viewable=1 
--AND id not in (select country_id FROM client_div_to_lic_country WHERE client_div_id=91);
--INSERT INTO client_div_to_lic_country 
--SELECT increment_sequence('client_div_to_lic_country_seq'),98, id FROM country 
--WHERE is_mdsol_viewable=1 
--AND id not in (select country_id FROM client_div_to_lic_country WHERE client_div_id=98);

--INSERT INTO client_div_to_lic_country 
--SELECT increment_sequence('client_div_to_lic_country_seq'),101, id FROM country 
--WHERE is_mdsol_viewable=1 
--AND id not in (select country_id FROM client_div_to_lic_country WHERE client_div_id=101);
--INSERT INTO client_div_to_lic_country 
--SELECT increment_sequence('client_div_to_lic_country_seq'),103, id FROM country 
--WHERE is_mdsol_viewable=1 
--AND id not in (select country_id FROM client_div_to_lic_country WHERE client_div_id=103);
--INSERT INTO client_div_to_lic_country 
--SELECT increment_sequence('client_div_to_lic_country_seq'),104, id FROM country 
--WHERE is_mdsol_viewable=1 
--AND id not in (select country_id FROM client_div_to_lic_country WHERE client_div_id=104);


--Implemented upto this in DEVL,D002,D003  on 09/19/2009
--Implemented upto this in q002  on 09/19/2009


--As per Phil's request on 09/30/2009
ALTER TABLE trial_budget MODIFY  (avg_cpp_low  NUMBER(12,2),  avg_cpp_med        NUMBER(12,2),
  avg_cpp_high         NUMBER(12,2),  avg_cpp_company      NUMBER(12,2),
  avg_cpp_selected     NUMBER(12,2),  total_cost  NUMBER(17,2),
 total_cost_local     NUMBER(17,2), avg_cpp_selected_local     NUMBER(12,2),
  total_cost_pvb       NUMBER(12,2),
  total_cost_pvb_local       NUMBER(17,2),  total_cost_no_oh     NUMBER(12,2),
  total_cost_no_oh_local     NUMBER(12,2),  total_cost_pvb_no_oh       NUMBER(12,2),
  total_cost_pvb_no_oh_local NUMBER(12,2), total_cost_low       NUMBER(12,2),
  total_cost_med       NUMBER(12,2),  total_cost_high      NUMBER(12,2),
  total_cost_co        NUMBER(12,2), total_cost_pvb_low   NUMBER(12,2),
  total_cost_pvb_med   NUMBER(12,2),  total_cost_pvb_high  NUMBER(12,2),
  total_cost_pvb_co    NUMBER(12,2));

ALTER TABLE tsm_trial_rollup MODIFY (total_cost_pvb      NUMBER(17,2));

ALTER TABLE gm_budget_group MODIFY  ( total_cost             NUMBER(17,2),  total_cost_pvb         NUMBER(12,2),
  total_cost_no_oh       NUMBER(12,2),  total_cost_pvb_no_oh   NUMBER(12,2),
  total_cost_low         NUMBER(12,2),  total_cost_med         NUMBER(12,2),
  total_cost_high        NUMBER(12,2),  total_cost_co          NUMBER(12,2),
  total_cost_pvb_low     NUMBER(12,2),  total_cost_pvb_med     NUMBER(12,2),
  total_cost_pvb_high    NUMBER(12,2),  total_cost_pvb_co      NUMBER(12,2));

--Implemented upto this in DEVL,D002,D003  on 10/01/2009
--Implemented upto this in q002  on 10/06/2009



--As per Tonya's request on 10/20/2009
ALTER TABLE gm_budget_group ADD( specify_odc_flg NUMBER(1)  DEFAULT 1 NOT NULL);

--Implemented upto this in DEVL,D002,D003  on 10/20/2009
--Implemented upto this in q002  on 10/23/2009
--Implemented upto this in perf on 11/02/2009
/***********************************************************/
--Implemented upto this in demo on 11/03/2009
/***********************************************************/

--As per Phil's request on 11/13/2009
UPDATE region SET type='Metro', name='Metropolitan Area Washington DC' WHERE id=106;

--Implemented upto this in DEVL,D002,D003  on 11/13/2009
--Implemented upto this in q002  on 11/13/2009
--Implemented upto this in perf on 11/23/2009
--Implemented upto this in q003 on 11/25/2009

--As per Kelly's request on 12/15/2009
ALTER TABLE client_div_to_lic_app DROP CONSTRAINT cdtla_app_name_check;
ALTER TABLE client_div_to_lic_app ADD CONSTRAINT cdtla_app_name_check 
    CHECK (app_name in ('DASHBOARD','PICASE','TRACE','TSPD','CROCAS','TSN','GMOWN','GM30'));

--Implemented upto this in devl,d002,d003 on 12/15/2009
--Implemented upto this in q002  on 12/16/2009

create or replace procedure new_gm_clientdiv (ClientDivId in number)
is
begin
null;
end;
/

create or replace procedure new_gm30_clientdiv (ClientDivId in number)
is
begin
null;
end;
/

create or replace procedure new_gmc_clientdiv (ClientDivId in number)
is
begin
null;
end;
/

create or replace procedure new_gma_clientdiv (ClientDivId in number)
is
begin
null;
end;
/

create or replace procedure new_cc_clientdiv (ClientDivId in number)
is
begin
null;
end;
/

create or replace procedure upgrade_gm_clientdiv (ClientDivId in number)
is
begin
null;
end;
/

create or replace procedure upgrade_gm30_clientdiv (ClientDivId in number)
is
begin
null;
end;
/

create or replace procedure upgrade_gmc_clientdiv (ClientDivId in number)
is
begin
null;
end;
/

create or replace procedure upgrade_gma_clientdiv (ClientDivId in number)
is
begin
null;
end;
/

create or replace procedure upgrade_cc_clientdiv (ClientDivId in number)
is
begin
null;
end;
/
--Implemented upto this in devl,d002,d003 on 12/16/2009
--Implemented upto this in q002  on 12/16/2009


alter table audit_hist drop constraint audit_hist_app_type_check;
ALTER TABLE audit_hist
  ADD CONSTRAINT audit_hist_app_type_check CHECK (
    app_type in
('DASHBOARD','PICASE','TRACE','TSPD','FTADMIN','CROCAS','PBTOWN','GMOWN','TSN','DGW','GM30','UNKNOWN')
  );

alter table TSM_MESSAGE drop constraint TM_APP_TYPE_CHECK;
ALTER TABLE TSM_MESSAGE
  ADD CONSTRAINT TM_APP_TYPE_CHECK CHECK (
    app_type in ('PICASE','TRACE','TSPD','FTADMIN','CROCAS','TSN','GMOWN','GM30')
  );

alter table user_pref drop constraint UP_APP_TYPE_CHECK;
alter table user_pref add constraint UP_APP_TYPE_CHECK 
CHECK (app_type IN ('DASHBOARD','PICASE','TRACE','TSPD','FTADMIN','CROCAS','TSN','GMOWN','DGW','GM30'));


alter table ENV_VAR drop constraint ENV_VAR_APP_TYPE_CHECK;
alter table ENV_VAR 
add constraint ENV_VAR_APP_TYPE_CHECK CHECK ( app_type in
('DASHBOARD','PICASE','TRACE','TSPD','FTADMIN','CROCAS','PBTOWN','GMOWN','TSN','DGW','GM30','UNKNOWN') );

alter table TRIAL drop constraint TRIAL_CREATED_BY_CHECK;
alter table TRIAL 
add constraint TRIAL_CREATED_BY_CHECK CHECK ( created_by in ('DASHBOARD','PICASE','TRACE','TSPD','CROCAS','TSN','GM30') );

---
---Connect as FTCOMMON 
---
--conn ftcommon
accept passwd char prompt 'Connect to FTCOMMON. Enter password:' hide;
accept db_name char prompt 'Enter database name:';
conn ftcommon/&passwd@&db_name

ALTER TABLE application DROP CONSTRAINT APPLICATION_APP_NAME_CHECK;
ALTER TABLE application ADD CONSTRAINT APPLICATION_APP_NAME_CHECK 
CHECK (app_name in ('PICASE', 'TRACE','TSPD','FTADMIN','CROCAS','GM30'));
INSERT INTO application VALUES(6,'GM30','Grants Manager 3.0',null);
commit;

--Implemented upto this in devl,d002,d003 on 12/18/2009
--Implemented upto this in q002,perf on 12/28/2009

--CONNECT AS TSM10 or TSM10E
--BELOW connect statements might fail if run by copy-paste into sqlplus
accept uname char prompt 'Connect to master schema. Enter username:';
accept passwd char prompt 'Enter password:' hide;
accept db_name char prompt 'Enter database name:';
conn &uname/&passwd@&db_name

--As per DB's request on 12/29/2009
CREATE OR REPLACE TRIGGER trial_trg1
before insert or update of created_by
ON trial
referencing new as n old as o
for each row
begin

 If :n.created_by = 'PICAS-E' or :n.created_by = 'Trace' or
    :n.created_by = 'PICASE' or :n.created_by = 'TRACE' or
    :n.created_by = 'Crocas' or :n.created_by = 'CROCAS' or
    :n.created_by = 'TSPD' or  :n.created_by='GM30' then
  :n.guid := 'TSM_'||:n.id;
 end if;

end;
/

--Implemented upto this in devl,d002,d003 on 12/29/2009
--Implemented upto this in q002,perf on 12/29/2009


create or replace procedure new_tspd_clientdiv (ClientDivId in number)
is
begin
null;
end;
/

create or replace procedure upgrade_tspd_clientdiv (ClientDivId in number)
is
begin
null;
end;
/

create or replace procedure new_clientdiv (ClientDivId in number)
is
begin
null;
end;
/

--Implemented upto this in devl,d002,d003 on 12/28/2009
--Implemented upto this in q002 on 12/30/2009
--Implemented upto this in perf on 12/31/2009

-- As per request on 01/12/2010 ---
CREATE OR REPLACE procedure new_gm30_clientdiv (ClientDivId in number)
is
 BEGIN
 UPDATE client_div SET allow_create_unlisted=1 WHERE id=ClientDivId;
 end;
/


CREATE OR REPLACE procedure new_tspd_clientdiv (ClientDivId in number)
is
BEGIN
 UPDATE client_div SET tspd_build_tag_id = (Select Max(tspd_build_tag_id) FROM client_div)
 WHERE id =   ClientDivId;
end;
/

--Implemented upto this in devl,d002,d003 on 01/12/2010
--Implemented upto this in q002 on 01/12/2010


-- As per Phil's request on 01/13/2010
CREATE OR REPLACE FUNCTION GM30_BUDGET_COUNTRY (TrialId in number) return VARCHAR2 as
BudgetCountry varchar2(2000):=null;
cursor C1 is select b.abbreviation, min(a.id) budgetid,
                    min(a.gm_budget_group_id) budgetgroupid, count(a.country_id) cnt
             from trial_budget a, country b
             WHERE a.trial_id=TrialId AND a.country_id=b.id
             AND a.region_id is null AND a.institution_id is null
             GROUP BY b.abbreviation order by 1;
begin
   FOR ix1 in c1 Loop
   --  if ix1.cnt > 0 then
         BudgetCountry := BudgetCountry||', '||ix1.abbreviation||'_|_'||ix1.budgetgroupid||'_|_'||ix1.budgetid||'_|_'||ix1.cnt;
   --  else
   --  BudgetCountry := BudgetCountry||', '||ix1.abbreviation;
   --  end if;
   end loop;
   RETURN (substr(budgetcountry,3));
end;
/
 

CREATE OR REPLACE FUNCTION GM30_BUDGET_GROUP (TrialId in number) return VARCHAR2 as
BudgetGroup varchar2(2000):=null;
cursor C1 is select budget_group_name from gm_budget_group
              where trial_id=TrialId AND budget_group_type='ARM' order by 1;
begin

   FOR ix1 in c1 Loop
     budgetgroup := budgetgroup||', '||ix1.budget_group_name;
   end loop;
    RETURN (substr(BudgetGroup,3));
end;
/
 

  CREATE OR REPLACE FUNCTION GM30_BUDGET_REGION (TrialId in number) return VARCHAR2 as
BudgetRegion varchar2(2000):=null;
cursor C1 is select b.name,min(a.id) budgetid,
                    min(a.gm_budget_group_id) budgetgroupid, count(a.region_id) cnt
             from trial_budget a, country b
WHERE a.trial_id=TrialId AND a.region_id is not null AND a.region_id=b.id
group by b.name order by 1;
begin
   FOR ix1 in c1 Loop
       BudgetRegion := BudgetRegion||', '||ix1.name||'_|_'||ix1.budgetgroupid||'_|_'||ix1.budgetid||'_|_'||ix1.cnt;
   end loop;
   RETURN (substr(BudgetRegion,3));
end;
/
 

  CREATE OR REPLACE FUNCTION GM30_BUDGET_SITE (TrialId in number) return VARCHAR2 as
BudgetSite varchar2(4000):=null;
cursor C1 is select b.name,  min(a.id) budgetid,
                    min(a.gm_budget_group_id) budgetgroupid, count(a.institution_id) cnt
             from trial_budget a, institution b
             WHERE a.trial_id=TrialId AND a.institution_id is not null AND a.institution_id=b.id
             group by b.name order by 1;
begin
   FOR ix1 in c1 Loop
      BudgetSite := BudgetSite||'#,,# '||ix1.name||'_|_'||ix1.budgetgroupid||'_|_'||ix1.budgetid||'_|_'||ix1.cnt;
   end loop;
   RETURN (substr(BudgetSite,6));
end;
/
 

  CREATE OR REPLACE FUNCTION GM30_INDICATION_NAME (TrialId in number) return VARCHAR2 as
indtype varchar2(30);
tacode varchar2(256);
shortdesc varchar2(256);
indmapid number;
begin
   SELECT indmap_id INTO indmapid FROM trial where id=TrialId;
   SELECT type,code,short_desc INTO indtype,tacode,shortdesc FROM indmap WHERE id=indmapid;
   IF indtype='Therapeutic Area' THEN
     RETURN tacode;
   ELSE
     RETURN shortdesc;
   END IF;
end;
/
 

  CREATE OR REPLACE FUNCTION GM30_LATEST_BUILD (TrialId in number) return VARCHAR2 as
 builddate DATE;
begin
   SELECT max(bl.released_date) INTO builddate
   FROM  build_tag_to_client_div  bl, client_div d, trial t, trial_budget b
   WHERE b.trial_id=TrialId AND t.client_div_id=d.id
   AND bl.client_div_id=d.id AND b.build_tag_id=bl.build_tag_id;
   RETURN builddate;
end;
/
 

  CREATE OR REPLACE FUNCTION GM30_TA_NAME (TrialId in number) return VARCHAR2 as
indtype varchar2(30);
tacode varchar2(256);
shortdesc varchar2(256);
indmapid number;
begin
   SELECT indmap_id INTO indmapid FROM trial where id=TrialId;
   SELECT type,code INTO indtype,tacode FROM indmap WHERE id=indmapid;
   IF indtype='Indication' THEN
     SELECT code INTO tacode FROM indmap
     WHERE LEVEL=3 CONNECT BY id= PRIOR parent_indmap_id
                   START WITH id=indmapid;
   ELSIF indtype='Indication Group' THEN
     SELECT code INTO tacode FROM indmap
     WHERE LEVEL=2 CONNECT BY id= PRIOR parent_indmap_id
                   START WITH id=indmapid;
   END IF;
   RETURN tacode;
end;
/
 

  CREATE OR REPLACE FUNCTION GM30_TRIAL_AUTHOR (TrialId in number) return  VARCHAR2 AS
retname varchar2(256):=NULL;
lastname VARCHAR(128):=NULL; 
firstname VARCHAR(128):=null;
BEGIN
  SELECT f.last_name||', '||f.first_name INTO retname FROM ftuser f, picase_trial p, trial t
  WHERE p.trial_id=t.id AND f.id=p.creator_ftuser_id AND t.id=TrialId;
  RETURN retname;
end;
/
 

  CREATE OR REPLACE FUNCTION GM30_TRIAL_LOCK (TrialId in number, FtuserId in number) return VARCHAR2 as
cnt        number;
begin
   SELECT count(*) INTO cnt FROM trial_budget 
   WHERE trial_id=TrialId AND locking_ftuser_id IS NOT NULL
   AND locking_ftuser_id!=FtuserId;

   IF cnt > 0 THEN
     RETURN (2);
   END IF;

   SELECT count(*) INTO cnt FROM trial_budget 
   WHERE trial_id=TrialId AND locking_ftuser_id IS NOT NULL
   AND locking_ftuser_id=FtuserId;
   IF cnt > 0 THEN
     RETURN (1);
   END IF;
   
   SELECT count(*) INTO cnt FROM trial_budget 
   WHERE trial_id=TrialId AND locking_ftuser_id IS NOT NULL;
   IF cnt = 0 THEN
     RETURN (3);
   END IF;

end;
/
 

--Implemented upto this in devl,d002,d003 on 01/13/2010
--Implemented upto this in q002 on 01/13/2010
--Implemented upto this in perf on 01/13/2010

--As per Frank's request on 01/14/2010
CREATE OR REPLACE FUNCTION GM30_INDICATION_NAME (TrialId in number) return VARCHAR2 as
indtype varchar2(30);
tacode varchar2(256);
shortdesc varchar2(256);
indmapid number;
begin
   SELECT indmap_id INTO indmapid FROM trial where id=TrialId;
   SELECT type,code,short_desc INTO indtype,tacode,shortdesc FROM indmap WHERE id=indmapid;
   IF indtype='Therapeutic Area' THEN
     RETURN tacode;
   ELSE
     RETURN tacode||'-'||shortdesc;
   END IF;
end;
/

--Implemented upto this in devl,d002,d003 on 01/14/10


--As per DB's request on 01/15/10
Update currency set viewable_flg = 1 where id in (select currency_id from country where is_viewable=1 or is_mdsol_viewable=1);
Commit;


--Implemented upto this in devl,d002,d003 on 01/15/10
--Implemented upto this in q002 and perf on 01/15/10

--As per Frank's request on 01/18/2010
ALTER TABLE gm_budget_group  MODIFY(total_cost_pvb NUMBER(19,2),  total_cost_no_oh NUMBER(19,2), total_cost_pvb_no_oh NUMBER(19,2));  

--Implemented upto this in devl,d002,d003 on 01/15/10


--As per Frank's request on 01/18/2010

ALTER TABLE gm_budget_group  MODIFY(cost_per_patient       NUMBER(19,2),cost_per_visit         NUMBER(19,2),
                                    total_cost_low         NUMBER(19,2),total_cost_med         NUMBER(19,2),
                                    total_cost_high        NUMBER(19,2),total_cost_co          NUMBER(19,2),
                                    total_cost_pvb_low     NUMBER(19,2),total_cost_pvb_med     NUMBER(19,2),
                                    total_cost_pvb_high    NUMBER(19,2),total_cost_pvb_co      NUMBER(19,2),
                                    avg_cpp_low            NUMBER(19,2),avg_cpp_med            NUMBER(19,2),
                                    avg_cpp_high           NUMBER(19,2),avg_cpp_company        NUMBER(19,2));

ALTER TABLE tsm_trial_rollup  MODIFY(COST_PER_PATIENT  NUMBER(19,2),COST_PER_VISIT  NUMBER(19,2));


--Implemented upto this in devl,d002,d003 on 01/19/10
--Implemented upto this in q002 and perf on 01/19/10

--As per Frank's request on 01/19/2010
ALTER TABLE trial_budget MODIFY(AVG_CPP_LOW                  NUMBER(19,2),
AVG_CPP_MED                  NUMBER(19,2),
AVG_CPP_HIGH                 NUMBER(19,2),
AVG_CPP_COMPANY              NUMBER(19,2),
AVG_CPP_SELECTED             NUMBER(19,2),
AVG_CPP_SELECTED_LOCAL       NUMBER(19,2),
TOTAL_COST_PVB               NUMBER(19,2),
TOTAL_COST_NO_OH             NUMBER(19,2),
TOTAL_COST_NO_OH_LOCAL       NUMBER(19,2),
fixed_scr_fail_cost          NUMBER(19,2),
TOTAL_COST_PVB_NO_OH         NUMBER(19,2),
TOTAL_COST_PVB_NO_OH_LOCAL   NUMBER(19,2),
TOTAL_COST_LOW               NUMBER(19,2),
TOTAL_COST_MED               NUMBER(19,2),
TOTAL_COST_HIGH              NUMBER(19,2),
TOTAL_COST_CO                NUMBER(19,2),
TOTAL_COST_PVB_LOW           NUMBER(19,2),
TOTAL_COST_PVB_MED           NUMBER(19,2),
TOTAL_COST_PVB_HIGH          NUMBER(19,2),
TOTAL_COST_PVB_CO            NUMBER(19,2) );

ALTER TABLE trial_budget MODIFY(TOTAL_COST NUMBER(19,2), TOTAL_COST_LOCAL NUMBER(19,2), TOTAL_COST_PVB_LOCAL NUMBER(19,2));
ALTER TABLE gm_budget_group MODIFY(TOTAL_COST NUMBER(19,2));
ALTER TABLE tsm_trial_rollup  MODIFY(TOTAL_COST_PVB  NUMBER(19,2),TOTAL_COST  NUMBER(19,2));
--******************************************************
--Implemented upto this in devl,d002,d003 on 01/19/10
--Implemented upto this in q002 and perf on 01/20/10
--Modified to 19,2 on 01/21/2010
--Implemented upto this in q003 on 01/28/2010
--******************************************************

select '**** END GM3.0 SECTIONS ******' from dual;

----------------------------
---END GM3.0 SECTION -----
----------------------------

----------------------------
---BEGIN COMMON SECTION ----
----------------------------

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
--conn ftcmmon;

accept passwd char prompt 'Connect to FTCOMMON. Enter password:' hide;
accept db_name char prompt 'Enter database name:';
conn ftcommon/&passwd@&db_name

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

--conn tsm10;
--CONNECT AS TSM10 or TSM10E
--BELOW connect statements might fail if run by copy-paste into sqlplus
accept uname char prompt 'Connect to master schema. Enter username:';
accept passwd char prompt 'Enter password:' hide;
accept db_name char prompt 'Enter database name:';
conn &uname/&passwd@&db_name

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
--******************************************************
--Implemented upto this in devl,d002,d003,q002 on 01/05/2010
--Implemented upto this in perf on 01/08/2010
--Implemented upto this in q003 on 01/28/2010
--******************************************************

----------------------------
---END COMMON SECTION ----
----------------------------