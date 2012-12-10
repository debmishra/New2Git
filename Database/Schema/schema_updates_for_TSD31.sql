--*** Schema Changes for Designer 3.1 ***--
--*** 03/15/2011                      ***--

--As per Michael's request on 03/15/2011 

ALTER TABLE tspd_client_div ADD (organization_name varchar2(255));


--Implemented upto this in devl on 03/15/2011
--Implemented upto this in d003 on 03/15/2011
--Implemented upto this in d005 on 03/15/2011
--Implemented upto this in d007 on 03/15/2011


--As per Kelly's request on 03/29/2011

ALTER TABLE  tspd_doc_comment ADD ( comment_type VARCHAR2(10) DEFAULT 'WORD' NOT NULL,
                                    thread_id NUMBER(10,0) NULL,
                                    element_path VARCHAR2(256) NULL,
                                    important_flg NUMBER(1,0) DEFAULT 0 NULL ) ;
alter table TSPD_DOC_COMMENT add constraint TDC_COMMENT_TYPE_CHECK CHECK (COMMENT_TYPE IN ('WORD','DG')) enable;

--Implemented upto this in devl on 03/29/2011


-- As per Michael's request on 03/30/2011

CREATE TABLE TSPD_LIB_GROUP (  ID        NUMBER(10,0)   NOT NULL,
                               NAME      VARCHAR2(255)  NOT NULL,
                               CREATE_DATE    DATE      NOT NULL,
                               CLIENT_DIV_ID  NUMBER(10,0) NOT NULL,
                               LAST_UPDATED   DATE         NOT NULL,
                               version_timestamp  NUMBER(10,0)   NOT NULL
                            )
  TABLESPACE tspdsmall
  PCTFREE   20
/

ALTER TABLE TSPD_LIB_GROUP
  ADD CONSTRAINT TSPD_LIB_GROUP_pk PRIMARY KEY (
    id
  )
  USING INDEX
    TABLESPACE tspdsmall_indx
    PCTFREE   20
/

INSERT INTO id_control VALUES ('tsm10','tspd_lib_group',1000);
commit;

ALTER TABLE tspd_lib_bucket ADD (TSPD_LIB_GROUP_ID NUMBER(10));

ALTER TABLE tspd_lib_bucket ADD CONSTRAINT tspd_lib_bucket_fk2 
FOREIGN KEY (TSPD_LIB_GROUP_ID) REFERENCES tspd_lib_group(ID);

--Implemented upto this in devl on 03/30/2011

--As per Kelly's request on 03/31/2011

ALTER TABLE  tspd_doc_comment ADD ( author_note varchar2(256) null);


--Implemented upto this in devl on 04/01/2011
--Implemented upto this in q002 on 04/01/2011
--Implemented upto this in d003 on 04/01/2011
--Implemented upto this in d005 on 04/01/2011
--Implemented upto this in d007 on 04/01/2011


--As per Michael Meyer on 4/19/2011

Alter table TSPD_LIB_ELEMENT drop constraint TLE_CONTENT_TYPE_CHECK;
ALTER TABLE tspd_lib_element
  ADD CONSTRAINT tle_content_type_check CHECK (
    content_type in ('Inline','Text','MSWord','Image','PDF'));


--Implemented upto this in devl on 04/19/2011
--Implemented upto this in q002 on 04/19/2011
--Implemented upto this in d003 on 04/19/2011
--Implemented upto this in d005 on 04/19/2011
--Implemented upto this in d007 on 04/19/2011

-- Following was added to upgrade a client division from 3.0.0 to 3.0.1 

/* 

CREATE OR REPLACE procedure upgrade_tspd_clientdiv (ClientDivId in number)
is
oid_exists number(5);
begin
  select count(*) into oid_exists from procedure_ext_meta where OID='shortDesc' 
  and client_div_id=ClientDivId;
   If oid_exists = 0 then 
    Insert into procedure_ext_meta (oid, client_div_id, data_type, description)
    select 'shortDesc',ClientDivId,0,'short desc' from dual;
   end if;
  select count(*) into oid_exists from procedure_ext_meta where OID='longDesc' 
  and client_div_id=ClientDivId;
   If oid_exists = 0 then 
    Insert into procedure_ext_meta (oid, client_div_id, data_type, description)
    select 'longDesc',ClientDivId,0,'long desc' from dual;
   end if;
  select count(*) into oid_exists from procedure_ext_meta where OID='OID' 
  and client_div_id=ClientDivId;
   If oid_exists = 0 then 
    Insert into procedure_ext_meta (oid, client_div_id, data_type, description)
    select 'OID',ClientDivId,0,'oid1' from dual;
   end if;
commit;
end;
/

CREATE OR REPLACE procedure new_tspd_clientdiv (ClientDivId in number)
is
oid_exists number(5);
begin
  select count(*) into oid_exists from procedure_ext_meta where OID='shortDesc'
  and client_div_id=ClientDivId;
   If oid_exists = 0 then
    Insert into procedure_ext_meta (oid, client_div_id, data_type, description)
    select 'shortDesc',ClientDivId,0,'short desc' from dual;
   end if;
  select count(*) into oid_exists from procedure_ext_meta where OID='longDesc'
  and client_div_id=ClientDivId;
   If oid_exists = 0 then
    Insert into procedure_ext_meta (oid, client_div_id, data_type, description)
    select 'longDesc',ClientDivId,0,'long desc' from dual;
   end if;
  select count(*) into oid_exists from procedure_ext_meta where OID='OID'
  and client_div_id=ClientDivId;
   If oid_exists = 0 then
    Insert into procedure_ext_meta (oid, client_div_id, data_type, description)
    select 'OID',ClientDivId,0,'oid1' from dual;
   end if;
commit;
end;
/

update FTADMIN_STORED_PROCEDURE set 
description='Database Script to Upgrade from 3.0.0 to 3.0.1 only'
where PROC_NAME='upgrade_tspd_clientdiv';
commit;
*/

-- Following changes are as per request of Michael Meyer on 4/26/2011 at 5:29pm

-- Not needed as it has already been taken care of by QPL deployment.. Don't deploy the following two lines
--alter table audit_hist drop constraint audit_hist_app_type_check;
--alter table audit_hist add constraint audit_hist_app_type_check
--  CHECK ( app_type in
--  ('DASHBOARD','PICASE','TRACE','TSPD','FTADMIN','CROCAS','PBTOWN','GMOWN','TSN','DGW','GM30','UNKNOWN','DMS'));


-- Following changes are as per request of Kelly on 5/5/2011 at 9:30am

CREATE OR REPLACE procedure upgrade2designer30 (clientdivid in number)
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

DELETE FROM tspd_doc_advisory
WHERE tspd_document_id IN (SELECT tspd_document.id
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
UPDATE criteria SET long_desc=short_desc
WHERE long_desc IS NULL
AND short_desc IS NOT NULL
AND client_div_id=clientdivid;
Designer30_EmailTemplates(clientdivid);
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

  update tspd_document set document_type='protocol' where document_type='Protocol' 
  and trial_id in (select id from trial where client_div_id=clientdivid);
  commit;

exception
    when myerror then
       Raise_application_error(-20100,'No records found for TRIAL_ID ='||vartrialid);
end;
/





--Implemented upto this in devl on 04/26/2011
--Implemented upto this in d003 on 04/26/2011
--Implemented upto this in d005 on 04/26/2011
--Implemented upto this in d007 on 04/26/2011
--Implemented upto this in q002 on 04/26/2011



-- Following changes are as per request of Michael Meyer on 4/28/2011 at 8:53 am

Alter table client_div add (uuid  varchar2(64), public_key varchar2(2048));

Alter table ftuser add uuid varchar2(64);
Alter table trial add uuid varchar2(64);

-- Following changes are as per request of Michael Meyer on 5/11/2011 at 2:50pm

alter table ftuser add DELEGATED_AUTH_ACTIVE NUMBER(1) default 0 not null;



--Implemented upto this in d003 on 05/11/2011
--Implemented upto this in d005 on 05/11/2011
--Implemented upto this in d007 on 05/11/2011
--Implemented upto this in devl on 05/11/2011


--Implemented upto this in q002 on 05/18/2011


-- Following changes are as per request of Kelly on 6/3/2011 at 1:19pm

CREATE TABLE tspd_doc_thread_reply (
  id	NUMBER(10),   
  author_note 		VARCHAR2(4000), 
  disposal_state        VARCHAR2(40),
  disposal_ftuser_id    NUMBER(10),
  create_date         DATE,
  tspd_document_id    NUMBER(10))
  TABLESPACE tspdsmall PCTFREE 10;
 

ALTER TABLE tspd_doc_thread_reply
  ADD CONSTRAINT tspd_doc_thread_reply_pk PRIMARY KEY (id)
  USING INDEX TABLESPACE tspdsmall_indx
  PCTFREE 10;
 

ALTER TABLE tspd_doc_thread_reply
  ADD CONSTRAINT tspd_doc_thread_reply_fk1 FOREIGN KEY (disposal_ftuser_id) 
  REFERENCES ftuser (id);

ALTER TABLE tspd_doc_thread_reply
  ADD CONSTRAINT tspd_doc_thread_reply_fk2 FOREIGN KEY (tspd_document_id) 
  REFERENCES tspd_document (id);

insert into id_control values('tsm10','tspd_doc_thread_reply',1);
commit;


ALTER TABLE tspd_doc_comment 
  ADD ( tspd_doc_thread_reply_id NUMBER(10)); 

--ALTER TABLE tspd_doc_comment 
--  ADD ( tspd_doc_thread_reply_id NUMBER(10)); 



--********************************************
--Implemented upto this in devl on 6/3/2011
--Implemented upto this in d003 on 6/3/2011
--Implemented upto this in d005 on 6/3/2011
--Implemented upto this in d007 on 6/3/2011
--Implemented upto this in q002 on 06/07/2011
--********************************************
