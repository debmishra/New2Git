--*** Schema Changes for Designer 2.7 ***--
--*** 10/13/2009                      ***--

--As per Kelly's request on 10/13/2009
create or replace PROCEDURE  Insert_tspd_template_email(ClientDivId IN NUMBER) AS
BEGIN

  INSERT INTO tspd_template_email
  SELECT increment_sequence('tspd_template_email_seq'),ClientDivId,
         TEMPLATE_NAME, SUBJECT, MESSAGE_TEXT
  FROM tspd_template_email
  WHERE client_div_id is null;

  COMMIT;

END;
/

--Implemented upto this in devl on 10/13/2009


--As per Fiammetta's request on 11/17/2009
ALTER TABLE tspd_client_div ADD (APP_COUNTRY_ID number(10),
                                 APP_CURRENCY_ID number(10));

ALTER TABLE tspd_client_div ADD CONSTRAINT tspd_client_div_fk2 
FOREIGN KEY (APP_COUNTRY_ID) REFERENCES country(ID);

ALTER TABLE tspd_client_div ADD CONSTRAINT tspd_client_div_fk3 
FOREIGN KEY (APP_CURRENCY_ID) REFERENCES CURRENCY(ID);

UPDATE tspd_client_div a 
SET (app_country_id,app_currency_id)=(SELECT nvl(b.country_id,b.def_country_id),b.def_plan_currency_id 
                                      FROM client_div b
                                      WHERE b.id=a.client_div_id);

ALTER TABLE tspd_client_div modify(APP_COUNTRY_ID not null, APP_CURRENCY_ID  not null);

CREATE OR REPLACE TRIGGER CLIENT_DIV_TRG1 
after insert on client_div
referencing new as n old as o
for each row
DECLARE
   TspdClientDivId number(10);

BEGIN

  INSERT INTO tspd_client_div (id,client_div_id,app_country_id,app_currency_id) 
  VALUES(increment_Sequence('tspd_client_div_seq'),:n.id,nvl(:n.country_id,:n.def_country_id),:n.def_plan_currency_id);

END;
/
ALTER TRIGGER CLIENT_DIV_TRG1 ENABLE;

--Implemented upto this in devl on 11/17/2009
--Implemented upto this in d002,d003 on 11/18/2009


--As per Fiammetta's request on 12/11/2009
ALTER TABLE tspd_client_div ADD(EMAIL_STAGE_LOCK   number(1) default 0 not null,
                                EMAIL_STAGE_UNLOCK number(1) default 0 not null,
                                EMAIL_SME_LOCK number(1) default 0 not null,
                                EMAIL_SME_UNLOCK number(1) default 0 not null);


--Implemented upto this in devl,d002,d003 on 12/14/2009
--Implemented upto this in q002 on 12/14/2009
--******************************************************
--Implemented upto this in perf on 12/31/2009
--******************************************************

-- As per Kelly's request on 04/28/2010
ALTER TABLE tspd_document drop CONSTRAINT td_document_type_check;

--Implemented upto this in devl
--  d002,d003 on 04/30/2010 


-- As per Kelly's request on 05/03/2010
ALTER TABLE TSPD_DOCUMENT_AUTHORS drop CONSTRAINT TDA_DOCUMENT_TYPE_CHECK;

--Implemented upto this in devl
--  d002,d003 on 05/03/2010 
----Implemented upto this in q002 on 05/14/2010

--As per DB's request on 05/10/2010
create or replace
TRIGGER client_div_trg2
before insert or update of client_id on client_div
referencing new as n old as o
for each row

declare
client_exists number(10);

begin

select count(*) into client_exists from client_div where client_id=:n.client_id;

   If inserting and client_exists > 0 then
     Raise_application_error(-20071,'Sorry, this client has already been used. Please use a different client');
   End if;

  If updating and :o.client_id is not null and :o.client_id <> :n.client_id then
    Raise_application_error(-20072,'Sorry, client_id can not be changed');
  End if;

end;
/


--Implemented upto this in devl,d002,d003,d004 on 05/18/2010 



-- As per Kelly's request on 06/08/2010

ALTER TABLE icp_instance MODIFY(snapshot_type  null);
ALTER TABLE icp_instance MODIFY(snapshot_type default null);


create or replace
procedure Upgrade2Designer30 (clientdivid in number)
is
cursor mycur is select a.trial_id from trial c, tspd_trial a where
                c.id=a.trial_id and c.client_div_id=clientdivid and not exists
                (select 1 from tspd_document b where b.trial_id=a.trial_id and
                 b.document_type='Design');
tspddocid number(10);
icpinstanceid number(10);
icpinstancenewid number(10);
tspddocumentnextid number(10);
maxcreatedate date;
docexists number(5);
myerror exception;
vartrialid number(10);
snapshottype varchar2(80);

begin

DELETE FROM audit_hist
WHERE entity_type='tspd_document'
AND entity_id IN (SELECT tspd_document.id
                  FROM tspd_document,tspd_trial, trial
                  WHERE snapshot_type='TrackChanges'
                  AND tspd_document.trial_id=trial.id
                  AND trial.client_div_id=clientdivid);
                  
DELETE FROM tspd_document
WHERE id IN (SELECT tspd_document.id
             FROM tspd_document,tspd_trial, trial
             WHERE snapshot_type='TrackChanges'
             AND tspd_document.trial_id=trial.id
             AND trial.client_div_id=clientdivid);

UPDATE icp_instance SET snapshot_type=null 
WHERE trial_id IN (SELECT id FROM trial
                   WHERE trial.client_div_id=clientdivid);
                   
 FOR var1 IN mycur LOOP
   
   select var1.trial_id INTO vartrialid from dual;
       select id,  icp_instance_id, snapshot_type
        into tspddocid, icpinstanceid,snapshottype
        from ( select id,icp_instance_id,snapshot_type
              FROM tspd_document
              WHERE trial_id=var1.trial_id
              AND document_type='Protocol'
              AND snapshot_type in ('WorkingCopy','FinalVersion')
              order by snapshot_type desc, id desc)
        WHERE rownum<2;
  
    icpinstancenewid := null;
  
    IF snapshottype='FinalVersion' THEN
 
      SELECT increment_sequence('icp_instance_seq') INTO icpinstancenewid 
      FROM dual;
    
      INSERT INTO icp_instance
      SELECT icpinstancenewid,TRIAL_ID,LAST_UPDATED,1,DATA,SNAPSHOT_TYPE,ICP_TYPE
      FROM icp_instance
      WHERE id=icpinstanceid;
    ELSE
      icpinstancenewid:=icpinstanceid;
    END IF;
  
    SELECT increment_sequence('tspd_document_seq') INTO tspddocumentnextid FROM dual;
  
    INSERT INTO tspd_document 
    SELECT tspddocumentnextid,TRIAL_ID,'Design',DOCUMENT_NAME,
           AUTHOR_FTUSER_ID,CREATE_DATE,LAST_UPDATED,1,DATA,'WorkingCopy',
           null,null,null,REVIEW_BY_TIME,null,icpinstancenewid,null,
           DOCUMENT_NOTES,SNAPSHOT_CREATE_DATE,SOA_TBL_FORMAT,REVIEW_REMINDER_DAYS,
           null,LAST_COOKIE,SOFTWARE_VERSION,LOCALE,DATE_FORMAT,null,
           AUTHOR_MODEL_TYPE,PUBLIC_VISIBLE_FLG,MACROS_DIRTY,UPDATE_REVISION_DOC_FLG
    FROM   tspd_document
    WHERE id=tspddocid;
    
    INSERT INTO tspd_document_authors
    SELECT increment_sequence('tspd_document_authors_seq'),tspddocumentnextid,
           FTUSER_ID,'Design'
    FROM   tspd_document_authors
    WHERE  TSPD_DOCUMENT_ID=tspddocid;

  END LOOP;
exception
    when myerror then
       Raise_application_error(-20100,'More than one row with exact same create date found -- trial_id='||vartrialid);
end;
/
--Implemented upto this in devl,d002,d003,d004 on 06/08/2010 
--Implemented upto this in q002 on 06/14/2010

--As per Kelly's request on 06/15/2010

create table tspd_trial_backup_2Bdeleted as select * from tspd_trial;
alter table tspd_trial add a clob;
update tspd_trial set a = LOCKING_STATUS;
commit;
alter table tspd_trial drop column LOCKING_STATUS;
alter table tspd_trial rename column a to LOCKING_STATUS;

alter table tspd_trial add b number(1) default 0 not null;
update tspd_trial set b=LOCKING_AUTHOR_ASSIGN;
commit;
alter table tspd_trial drop column LOCKING_AUTHOR_ASSIGN;
alter table tspd_trial rename column b to LOCKING_AUTHOR_ASSIGN;
alter table tspd_trial add constraint TT_LOCKING_AUTHOR_ASSIGN_CHECK check (LOCKING_AUTHOR_ASSIGN in (0,1));
commit;

CREATE TABLE tspd_30_upgrade_design_doc
(id NUMERIC(10) NOT NULL,
data BLOB,
create_date date);

delete from tspd_30_upgrade_design_doc;
CREATE DATABASE LINK dblink_to_devl connect to tsm10 identified by welcome using 'devl';
INSERT INTO tspd_30_upgrade_design_doc SELECT * FROM tspd_30_upgrade_design_doc@dblink_to_devl;
commit;
DROP DATABASE LINK dblink_to_devl;

create or replace
procedure Upgrade2Designer30 (clientdivid in number)
is
cursor mycur is select a.trial_id from trial c, tspd_trial a where
                c.id=a.trial_id and c.client_div_id=clientdivid and not exists
                (select 1 from tspd_document b where b.trial_id=a.trial_id and
                 upper(b.document_type)='DESIGN');
tspddocid number(10);
icpinstanceid number(10);
icpinstancenewid number(10);
tspddocumentnextid number(10);
maxcreatedate date;
docexists number(5);
myerror exception;
vartrialid number(10);
snapshottype varchar2(80);
blobdata     blob;

begin

DELETE FROM audit_hist
WHERE entity_type='tspd_document'
AND entity_id IN (SELECT tspd_document.id
                  FROM tspd_document,tspd_trial, trial
                  WHERE snapshot_type='TrackChanges'
                  AND tspd_document.trial_id=trial.id
                  AND trial.client_div_id=clientdivid);

DELETE FROM tspd_document
WHERE id IN (SELECT tspd_document.id
             FROM tspd_document,tspd_trial, trial
             WHERE snapshot_type='TrackChanges'
             AND tspd_document.trial_id=trial.id
             AND trial.client_div_id=clientdivid);

UPDATE icp_instance SET snapshot_type=null
WHERE trial_id IN (SELECT id FROM trial
                   WHERE trial.client_div_id=clientdivid);

SELECT data INTO blobdata FROM tspd_30_upgrade_design_doc;

 FOR var1 IN mycur LOOP

   select var1.trial_id INTO vartrialid from dual;
   SELECT count(*) INTO docexists FROM  tspd_document
              WHERE trial_id=var1.trial_id
              AND upper(document_type)='PROTOCOL'
              AND snapshot_type in ('WorkingCopy','FinalVersion');
  IF docexists > 0 THEN
       select id,  icp_instance_id, snapshot_type
        into tspddocid, icpinstanceid,snapshottype
        from ( select id,icp_instance_id,snapshot_type
              FROM tspd_document
              WHERE trial_id=var1.trial_id
              AND upper(document_type)='PROTOCOL'
              AND snapshot_type in ('WorkingCopy','FinalVersion')
              order by snapshot_type desc, id desc)
        WHERE rownum<2;

    icpinstancenewid := null;

    IF snapshottype='FinalVersion' THEN

      SELECT increment_sequence('icp_instance_seq') INTO icpinstancenewid
      FROM dual;

      INSERT INTO icp_instance
      SELECT icpinstancenewid,TRIAL_ID,LAST_UPDATED,1,DATA,SNAPSHOT_TYPE,ICP_TYPE
      FROM icp_instance
      WHERE id=icpinstanceid;
    ELSE
      icpinstancenewid:=icpinstanceid;
    END IF;

    SELECT increment_sequence('tspd_document_seq') INTO tspddocumentnextid FROM dual;

    INSERT INTO tspd_document
    SELECT tspddocumentnextid,TRIAL_ID,'Design',DOCUMENT_NAME,
           AUTHOR_FTUSER_ID,CREATE_DATE,LAST_UPDATED,1,blobdata,'WorkingCopy',
           null,null,null,REVIEW_BY_TIME,null,icpinstancenewid,null,
           DOCUMENT_NOTES,SNAPSHOT_CREATE_DATE,SOA_TBL_FORMAT,REVIEW_REMINDER_DAYS,
           null,LAST_COOKIE,SOFTWARE_VERSION,LOCALE,DATE_FORMAT,null,
           AUTHOR_MODEL_TYPE,PUBLIC_VISIBLE_FLG,MACROS_DIRTY,UPDATE_REVISION_DOC_FLG
    FROM   tspd_document
    WHERE id=tspddocid;

    INSERT INTO tspd_document_authors
    SELECT increment_sequence('tspd_document_authors_seq'),tspddocumentnextid,
           FTUSER_ID,'Design'
    FROM   tspd_document_authors
    WHERE  TSPD_DOCUMENT_ID=tspddocid;
    
  ELSE
    raise myerror;
  END IF;
   

END LOOP;
  
  commit;
exception
    when myerror then
       Raise_application_error(-20100,'No records found for TRIAL_ID ='||vartrialid);
end;
/

--Implemented upto this in devl on 06/15/2010 
--Implemented upto this in d002,d003,d004 on 06/16/2010 
--******************************************************
--Implemented upto this in q002 on 06/17/2010
--******************************************************


--As per DB's request on 07/21/2010
create or replace procedure reset_gateway(ClientDiv in varchar2)
as
ClientDivId number(10);
begin
select id into ClientDivId from client_div where client_div_identifier=ClientDiv;
-- variables and mappings
Delete from tspd_variable_mapping where client_div_id=ClientDivID; 
Delete from tspd_study_variable where client_div_id=ClientDivID;
-- crf forms
Delete from tspd_crf_form where client_div_id=ClientDivID;
-- code lists
Delete from code_list_item where code_list_id in 
 (select id from code_list where client_div_id=ClientDivID);
Delete from code_list where client_div_id=ClientDivID;
-- gateway trials and history
Delete from dg_trial_version_hist where dg_trial_id in 
 (select dg_trial.id from dg_trial, trial where dg_trial.trial_id=trial.id and trial.client_div_id=ClientDivID);
Delete from dg_trial_version where dg_trial_id in 
 (select dg_trial.id from dg_trial, trial where dg_trial.trial_id=trial.id and trial.client_div_id=ClientDivID);
Delete from dg_trial_hist where trial_id in 
 (select id from trial where client_div_id=ClientDivID);
Delete from dg_trial where trial_id in 
 (select id from trial where client_div_id=ClientDivID);
-- cached odms
Delete from dg_library_snapshot where client_div_id=ClientDivID;
end;
/



--Implemented upto this in devl on 07/21/2010 
--Implemented upto this in d002,d003,d004 on 07/21/2010 


--As per Kelly's request on 08/26/2010

create or replace
procedure copy_tspd_document(OldDocId in number, SnapshotType in varchar2 default 'Baseline' )
as
OldIcpId number(10);
NewIcpId number(10);
NewDocId number(10);

begin

select ICP_INSTANCE_ID into OldIcpId from tspd_document where id=OldDocId;
select increment_sequence('icp_instance_seq') into NewIcpId from dual;
select increment_sequence('tspd_document_seq') into NewDocId from dual;

Insert into icp_instance select NewIcpId,TRIAL_ID,LAST_UPDATED,
VERSION_TIMESTAMP,DATA, SnapshotType ,'Frozen' from icp_instance
where id=OldIcpId;

Insert into tspd_diagram select increment_sequence('tspd_diagram_seq'),NewIcpId,
DIAGRAM,ICP_OBJECT_ID,ICP_OBJECT_TYPE,VERSION_TIMESTAMP from tspd_diagram
where ICP_INSTANCE_ID=OldIcpId;

insert into tspd_document select NewDocId,TRIAL_ID,DOCUMENT_TYPE,
DOCUMENT_NAME,AUTHOR_FTUSER_ID,CREATE_DATE-(1/43200),LAST_UPDATED,VERSION_TIMESTAMP,
DATA,SnapshotType,SnapshotType,SNAPSHOT_NOTES,REVIEW_BY_DATE,
REVIEW_BY_TIME,AMEND_TO_TSPD_DOCUMENT_ID,NewIcpId,
'Final',DOCUMENT_NOTES,sysdate,SOA_TBL_FORMAT,
REVIEW_REMINDER_DAYS,AMEND_NAME,LAST_COOKIE,SOFTWARE_VERSION,LOCALE,
DATE_FORMAT,AUTHOR_RELINQUISHED_DT,AUTHOR_MODEL_TYPE,
PUBLIC_VISIBLE_FLG,MACROS_DIRTY,UPDATE_REVISION_DOC_FLG from tspd_document where id=OldDocId;

Insert into TSPD_DOCUMENT_AUTHORS select
increment_sequence('tspd_document_authors_seq'),NewDocId,ftuser_id,document_type
from TSPD_DOCUMENT_AUTHORS where tspd_document_id=OldDocId;

end;
/
--***************************************************************
--Implemented upto this in devl,d002,d003,d004,d005 on 08/26/2010 
--Implemented upto this in q002,d003,d004 on 08/26/2010
--***************************************************************