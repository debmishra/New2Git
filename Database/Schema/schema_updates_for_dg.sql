--*** Schema Changes for Designer Gateway (DG) ***--
--*** 01/13/2009                               ***--

create table dg_trial(
id		Number(10),
trial_id	Number(10) NOT NULL,
rave_dest_id	Number(10),
create_date	date NOT NULL,
creator_ftuser_id Number(10) NOT NULL)
tablespace tspdsmall pctfree 20;

Alter table dg_trial add constraint dg_trial_pk 
	primary key (id) using index tablespace 
	tspdsmall_indx pctfree 30;

Alter table dg_trial add constraint dg_trial_fk1
	foreign key (trial_id) references 
	trial(id);

Alter table dg_trial add constraint dg_trial_fk2
	foreign key (rave_dest_id) references 
	client_div_to_rave_dest(id);

Alter table dg_trial add constraint dg_trial_fk3
	foreign key (creator_ftuser_id) references 
	ftuser(id);

insert into id_control values('tsm10','dg_trial',1);
commit;

create table dg_trial_version(
id		Number(10),
trial_id	Number(10) NOT NULL,
icp_instance_id Number(10) NOT NULL,
version_timestamp Number(10) NOT NULL,
rave_study_version varchar2(40),
last_updated	date NOT NULL,
last_updated_ftuser_id Number(10) NOT NULL,
exported NUMBER(1) DEFAULT 0 NOT NULL,
export_date date,
export_ftuser_id NUMBER (10))
tablespace tspdsmall pctfree 20;

Alter table dg_trial_version add constraint dg_trial_version_pk 
	primary key (id) using index tablespace 
	tspdsmall_indx pctfree 30;

Alter table dg_trial_version add constraint dg_trial_version_fk1
	foreign key (trial_id) references 
	trial(id);

Alter table dg_trial_version add constraint dg_trial_version_fk2
	foreign key (icp_instance_id) 
        references icp_instance(id);

Alter table dg_trial_version add constraint dg_trial_version_fk3
	foreign key (last_updated_ftuser_id) 
        references ftuser(id);

Alter table dg_trial_version add constraint dg_trial_version_fk4
	foreign key (Export_ftuser_id) 
        references ftuser(id);

insert into id_control values('tsm10','dg_trial_version',1);
commit;

create table tspd_crf_form(
id		Number(10),
client_div_id	Number(10) NOT NULL,
crf_name varchar2(80) NOT NULL,
oid varchar2(80) NOT NULL,
crf_description varchar2(256),
sequence Number(10) NOT NULL,
rave_oid_version varchar2(80) NOT NULL,
designer_version varchar2(80) NOT NULL,
visible NUMBER(1) DEFAULT 0 NOT NULL,
last_updated	date NOT NULL)
tablespace tspdsmall pctfree 20;

Alter table tspd_crf_form add constraint tspd_crf_form_pk 
	primary key (id) using index tablespace 
	tspdsmall_indx pctfree 30;

Alter table tspd_crf_form add constraint tspd_crf_form_fk1
	foreign key (client_div_id) 
        references client_div(id);

insert into id_control values('tsm10','tspd_crf_form',1);
commit;

create table client_div_to_rave_dest(
id		Number(10),
client_div_id	Number(10) NOT NULL,
rave_client_id varchar2(80),
rave_url varchar2(80) NOT NULL,
gateway_user varchar2(80) NOT NULL,
gateway_pwd varchar2(80) NOT NULL)
tablespace tspdsmall pctfree 20;

Alter table client_div_to_rave_dest add constraint client_div_to_rave_dest_pk 
	primary key (id) using index tablespace 
	tspdsmall_indx pctfree 30;

Alter table client_div_to_rave_dest add constraint client_div_to_rave_dest_fk1
	foreign key (client_div_id) 
        references client_div(id);

insert into id_control values('tsm10','client_div_to_rave_dest',1);
commit;


alter table dg_trial_version rename column trial_id to dg_trial_id;

alter table dg_trial_version drop constraint dg_trial_version_fk1;

Alter table dg_trial_version add constraint dg_trial_version_fk1
	foreign key (dg_trial_id) references 
	dg_trial(id);

alter table tspd_crf_form rename column sequence to form_sequence;

ALTER TABLE dg_trial DROP  constraint dg_trial_fk2;
alter table client_div_to_rave_dest drop constraint client_div_to_rave_dest_fk1;
alter table client_div_to_rave_dest drop constraint client_div_to_rave_dest_pk;

rename client_div_to_rave_dest to client_div_to_dest_system;
update id_control set table_name='client_div_to_dest_system' where table_name='client_div_to_rave_dest';

alter table client_div_to_dest_system rename column RAVE_CLIENT_ID to dest_system_id;
alter table client_div_to_dest_system rename column RAVE_URL to dest_system_url;

ALTER TABLE client_div_to_dest_system
  ADD CONSTRAINT client_div_to_dest_system_pk PRIMARY KEY (
    id
  )
  USING INDEX
    TABLESPACE tspdsmall_indx
    PCTFREE   30
/
 
ALTER TABLE client_div_to_dest_system
  ADD CONSTRAINT client_div_to_dest_system_fk1 FOREIGN KEY (
    client_div_id
  ) REFERENCES client_div (
    id
  )
/
Alter table dg_trial add constraint dg_trial_fk2
	foreign key (rave_dest_id) references 
	client_div_to_dest_system(id);


--Rename tables on 02/19/09 in tsm10@devl,tsm10@d003
--tsm10@d002

rename client_div_to_dest_system to dg_dest_system ;

ALTER TABLE dg_trial DROP  constraint dg_trial_fk2;
alter table dg_dest_system drop constraint client_div_to_dest_system_fk1;
alter table dg_dest_system drop constraint client_div_to_dest_system_pk;

update id_control set table_name='dg_dest_system' where table_name='client_div_to_dest_system';
commit;

ALTER TABLE dg_dest_system
  ADD CONSTRAINT dg_dest_system_pk PRIMARY KEY (
    id
  )
  USING INDEX
    TABLESPACE tspdsmall_indx
    PCTFREE   30
/
 
ALTER TABLE dg_dest_system
  ADD CONSTRAINT dg_dest_system_fk1 FOREIGN KEY (
    client_div_id
  ) REFERENCES client_div (
    id
  )
/

Alter table dg_trial add constraint dg_trial_fk2
	foreign key (rave_dest_id) references 
	dg_dest_system(id);


--Implemented upto this in tsm10@q002 on 02/26/2009 at 4:00pm

--As per Justin's request on 03/10/2009
alter table user_pref drop constraint UP_APP_TYPE_CHECK;

alter table user_pref add constraint UP_APP_TYPE_CHECK 
CHECK (app_type IN ('DASHBOARD','PICASE','TRACE','TSPD','FTADMIN','CROCAS','TSN','GMOWN','DGW'));

--As per Kelly's request on 04/01/2009
ALTER TABLE tspd_crf_form ADD CONSTRAINT TSPD_CRF_FORM_uk1 UNIQUE (oid)
USING INDEX TABLESPACE tspdsmall_indx PCTFREE 5;
--Implemented upto this in tsm10@devl, d003 on 04/01/2009 at 11:30AM
--Implemented upto this in q002 on 04/01/2009 at 3:00pm


--This was missed in earlier deployment.
alter table tspd_crf_form add (CREATE_DATE date not null,
                               CREATOR_FTUSER_ID number(10) not null);

Alter table tspd_crf_form add constraint tspd_crf_form_fk2
	foreign key (CREATOR_FTUSER_ID) 
        references ftuser(id);

--Implemented upto this in d003 on 04/20/2009 at 4:00pm
--Implemented upto this in q002 on 04/20/2009 at 4:00pm

--As per Peter's request on 04/26/2009 11:00AM
--Implemented in devl, d002,d03 and q002 databases.
alter table audit_hist drop constraint audit_hist_app_type_check;
ALTER TABLE audit_hist
  ADD CONSTRAINT audit_hist_app_type_check CHECK (
    app_type in
('DASHBOARD','PICASE','TRACE','TSPD','FTADMIN','CROCAS','PBTOWN','GMOWN','TSN','DGW','UNKNOWN')
  );
--Implemented upto this in devl,d002,d003 on 04/26/2009 at 11:00am
--Implemented upto this in q002 on04/26/2009 at 11:00am


alter table ENV_VAR drop constraint ENV_VAR_APP_TYPE_CHECK;
alter table ENV_VAR 
add constraint ENV_VAR_APP_TYPE_CHECK CHECK ( app_type in
('DASHBOARD','PICASE','TRACE','TSPD','FTADMIN','CROCAS','PBTOWN','GMOWN','TSN','DGW','UNKNOWN') );

--Implemented upto this in devl,d002,d003 on 04/29/2009 at 11:00am
--Implemented upto this in q002 on 04/29/2009 at 11:00am


--As per Fiammetta's request on 05/12/09
create table DG_LIBRARY_SNAPSHOT(
id		Number(10) NOT NULL,
oid             varchar2(80) NOT NULL,
version         varchar2(80) NOT NULL,
create_date     date NOT NULL,
last_updated    date NOT NULL,
client_div_id   number(10,0) not null,
dg_dest_system_id number(10,0) not null,
Library_type varchar2(80) default 'library' NOT NULL,
odm blob NOT NULL)
tablespace tspdsmall pctfree 20;

insert into id_control values('tsm10','dg_library_snapshot',1);
commit;

Alter table DG_LIBRARY_SNAPSHOT add constraint DG_LIBRARY_SNAPSHOT_pk PRIMARY KEY (id) 
USING INDEX TABLESPACE tspdsmall_indx PCTFREE 30;

Alter table DG_LIBRARY_SNAPSHOT add constraint DG_LIBRARY_SNAPSHOT_fk1
foreign key (client_div_id) references client_div(id);

Alter table DG_LIBRARY_SNAPSHOT add constraint DG_LIBRARY_SNAPSHOT_check CHECK( Library_type in ('library','study'));

ALTER TABLE DG_LIBRARY_SNAPSHOT  add constraint DG_LIBRARY_SNAPSHOT_UQ1
unique (dg_dest_system_id, oid, version  ) using index tablespace tspdsmall_indx pctfree 5;

ALTER TABLE DG_DEST_SYSTEM  add constraint DG_DEST_SYSTEM_UQ1
unique (id, client_div_id) using index tablespace tspdsmall_indx pctfree 5;

Alter table DG_LIBRARY_SNAPSHOT add constraint DG_LIBRARY_SNAPSHOT_fk2
foreign key (dg_dest_system_id,client_div_id) references dg_dest_system(id,client_div_id);
--Implemented upto this in devl on 05/12/2009 at 2:00pm

--As per Michael's request on 05/14/2009
ALTER TABLE dg_trial ADD(archived number(1) default 0 not null);
--Implemented upto this in devl on 05/13/2009 at 2:00pm

--As per Michael's request on 05/14/2009
ALTER TABLE tspd_document drop constraint TD_SNAPSHOT_TYPE_CHECK;
ALTER TABLE tspd_document add constraint TD_SNAPSHOT_TYPE_CHECK CHECK (
snapshot_type in ('WorkingCopy','ReviewCopy','FinalVersion','ConflictVersion','AuthorChange','DocTypeChange','Baseline','TrackChanges','Restored','Corrupted','Export') );
--Implemented upto this in devl on 05/14/2009 at 9:00am


--As per Justin's request on 05/14/2009
ALTER TABLE dg_trial_version ADD(Rave_Study_OID varchar2(50), Session_State blob);
--Implemented upto this in devl on 05/14/2009 at 1:30pm
--Upto this in d003, d002 on 05/15/2009 at 4:40pm


--As per Kelly's request on 05/21/2009
ALTER TABLE tspd_crf_form ADD(ignore_flg number(1) default 0);
--Implemented upto this in devl,d002,d003 on 05/21/2009 at 5:00pm


--As per Fiammetta's request on 05/22/2009
ALTER TABLE dg_library_snapshot ADD(library_name VARCHAR2(80));
--Implemented upto this in devl,d002,d003 on 05/22/2009 at 9:40AM
--Implemented upto this in q002 on 05/26/2009 at 3:00pm


--As per Kelly's request on 05/26/09
ALTER TABLE tspd_crf_form ADD dg_library_snapshot_id NUMBER(10);

ALTER TABLE tspd_crf_form ADD constraint TSPD_CRF_FORM_FK3
	foreign key (dg_library_snapshot_id) 
        references dg_library_snapshot(id);

CREATE GLOBAL TEMPORARY TABLE gtemp_dg_procedure_tasks (
  id  NUMBER
) ON COMMIT DELETE ROWS;
 
CREATE GLOBAL TEMPORARY TABLE gtemp_dg_unlisted_tasks (
  id  NUMBER
) ON COMMIT DELETE ROWS;

--Implemented upto this in devl,d002,d003 on 05/29/2009 
--Implemented upto this in q002 on 06/09/2009 at 11:30pm


--As per Kelly's request on 06/03/09
ALTER TABLE dg_trial_version ADD(TSPD_DOCUMENT_ID NUMBER(10));

ALTER TABLE dg_trial_version ADD constraint dg_trial_version_FK5
	foreign key (TSPD_DOCUMENT_id) 
        references tspd_document(id);

ALTER TABLE dg_trial  add constraint dg_trial_UQ1
unique (trial_id) using index tablespace tspdsmall_indx pctfree 5;

ALTER TABLE dg_trial_version add constraint dg_trial_version_UQ1
unique (dg_trial_id,icp_instance_id) using index tablespace tspdsmall_indx pctfree 5;
--Implemented upto this in devl,d002,d003 on 06/03/2009 

--As per Kelly's request on 06/11/2009
ALTER TABLE dg_trial_version DROP constraint dg_trial_version_UQ1;
ALTER TABLE dg_trial_version add constraint dg_trial_version_UQ1
unique (dg_trial_id,tspd_document_Id) using index tablespace tspdsmall_indx pctfree 5;
--Implemented upto this in devl,d002,d003 on 06/11/2009 


--As per Kelly's request on 06/17/2009
ALTER TABLE dg_trial_version DROP column ICP_INSTANCE_ID;
CREATE TABLE dg_trial_version_hist AS SELECT * FROM dg_trial_version WHERE rownum<1;
CREATE TABLE dg_trial_hist AS SELECT * FROM dg_trial WHERE rownum<1;

CREATE OR REPLACE TRIGGER DG_TRIAL_DEL_TRG1 
AFTER DELETE ON DG_TRIAL
REFERENCING OLD AS o NEW AS n 
FOR EACH ROW 
BEGIN
  INSERT INTO dg_trial_hist VALUES(:o.id,:o.trial_id,:o.rave_dest_id,:o.create_date,:o.creator_ftuser_id,:o.archived);
END;
/
ALTER TRIGGER DG_TRIAL_DEL_TRG1 ENABLE;

CREATE OR REPLACE TRIGGER DG_TRIAL_VERSION_DEL_TRG1 
AFTER DELETE ON DG_TRIAL_VERSION
REFERENCING OLD AS o NEW AS n 
FOR EACH ROW 
BEGIN
  INSERT INTO DG_TRIAL_VERSION_hist VALUES(:o.ID,:o.DG_TRIAL_ID,:o.VERSION_TIMESTAMP,
  :o.RAVE_STUDY_VERSION,:o.LAST_UPDATED,:o.LAST_UPDATED_FTUSER_ID,:o.EXPORTED,:o.EXPORT_DATE,
  :o.EXPORT_FTUSER_ID,:o.RAVE_STUDY_OID,:o.SESSION_STATE,:o.TSPD_DOCUMENT_ID);
END;
/
ALTER TRIGGER DG_TRIAL_VERSION_DEL_TRG1 ENABLE;
--Implemented upto this in devl,d002,d003 on 06/17/2009 
--Implemented upto this in q002 on 07/06/2009 at 11:20am

--As per Kelly's request on 07/06/09
ALTER TABLE dg_library_snapshot MODIFY(ODM NULL);


--As per Justin's request on 07/06/09
ALTER TABLE dg_trial_version ADD(PROJECT_NAME VARCHAR2(80), DRAFT_NAME VARCHAR2(80),
                                 SIGNATURE_PROMPT VARCHAR2(250) ,PRIMARY_FORM VARCHAR2(80));
ALTER TABLE translated_text MODIFY(TEXT VARCHAR2(320));

ALTER TABLE dg_trial_version_hist ADD(PROJECT_NAME VARCHAR2(80), DRAFT_NAME VARCHAR2(80),
                                 SIGNATURE_PROMPT VARCHAR2(250) ,PRIMARY_FORM VARCHAR2(80));

CREATE OR REPLACE TRIGGER DG_TRIAL_VERSION_DEL_TRG1 
AFTER DELETE ON DG_TRIAL_VERSION
REFERENCING OLD AS o NEW AS n 
FOR EACH ROW 
BEGIN
  INSERT INTO DG_TRIAL_VERSION_hist VALUES(:o.ID,:o.DG_TRIAL_ID,:o.VERSION_TIMESTAMP,
  :o.RAVE_STUDY_VERSION,:o.LAST_UPDATED,:o.LAST_UPDATED_FTUSER_ID,:o.EXPORTED,:o.EXPORT_DATE,
  :o.EXPORT_FTUSER_ID,:o.RAVE_STUDY_OID,:o.SESSION_STATE,:o.TSPD_DOCUMENT_ID,:o.PROJECT_NAME,
  :o.DRAFT_NAME,:o.SIGNATURE_PROMPT,:o.PRIMARY_FORM);
END;
/
ALTER TRIGGER DG_TRIAL_VERSION_DEL_TRG1 ENABLE;

--Implemented upto this in devl,d002,d003 on 07/06/2009 


--As per Kelly's request on 07/10/09
ALTER TABLE dg_library_snapshot ADD(version_name VARCHAR2(80));
UPDATE dg_library_snapshot 
SET version_name=(SELECT max(rave_oid_version) 
                  FROM tspd_crf_form 
                  WHERE dg_library_snapshot_id=dg_library_snapshot.id); 

-- select count(*) from dg_library_snapshot where version_name is null
-- if there are any, let me know, i'll hve to update manually

ALTER TABLE tspd_crf_form DROP COLUMN rave_oid_version;
ALTER TABLE tspd_crf_form RENAME COLUMN creator_ftuser_id TO last_updated_ftuser_id;

ALTER TABLE unit_of_measure MODIFY( constant_a  NUMBER(17,7),
				    constant_b          NUMBER(17,7),
  				    constant_c          NUMBER(17,7),
  				    constant_k          NUMBER(17,7) );
--Implemented upto this in devl,d002,d003 on 07/10/2009 


--As per Peter's request on 07/13/09
ALTER TABLE tspd_crf_form ADD(log_form     NUMBER(1,0)   DEFAULT 0 NOT NULL);
--Implemented upto this in devl,d002,d003 on 07/13/2009 
--Implemented upto this in q002 on 07/20/2009


--As per Kelly's request on 07/17/2009
--In SQA (q002)
update dg_dest_system set dest_system_url = dest_system_url||'/RaveWebServices2.0'

--As per Kelly's request on 07/28/2009
ALTER TABLE dg_trial RENAME COLUMN rave_dest_id TO dg_dest_system_id;
ALTER TABLE dg_trial_hist RENAME COLUMN rave_dest_id TO dg_dest_system_id;

ALTER TABLE dg_trial_version ADD(SOA_INSTANCE_ID Number(10));
ALTER TABLE dg_trial_version DROP column RAVE_STUDY_VERSION;
ALTER TABLE dg_trial_version DROP column RAVE_STUDY_OID;

ALTER TABLE dg_trial_version_hist ADD(SOA_INSTANCE_ID Number(10));
ALTER TABLE dg_trial_version_hist DROP column RAVE_STUDY_VERSION;
ALTER TABLE dg_trial_version_hist DROP column RAVE_STUDY_OID;

--As per Kelly's request on 08/03/2009
ALTER TABLE dg_trial_version MODIFY(PRIMARY_FORM VARCHAR2(250));
ALTER TABLE dg_trial_version_hist MODIFY(PRIMARY_FORM VARCHAR2(250));

CREATE OR REPLACE TRIGGER DG_TRIAL_DEL_TRG1 
AFTER DELETE ON DG_TRIAL
REFERENCING OLD AS o NEW AS n 
FOR EACH ROW 
BEGIN
  INSERT INTO dg_trial_hist(ID,TRIAL_ID,DG_DEST_SYSTEM_ID,CREATE_DATE,CREATOR_FTUSER_ID,ARCHIVED) 
  VALUES(:o.id,:o.trial_id,:o.dg_dest_system_id,:o.create_date,:o.creator_ftuser_id,:o.archived);
END;
/
ALTER TRIGGER DG_TRIAL_DEL_TRG1 ENABLE;

CREATE OR REPLACE TRIGGER DG_TRIAL_VERSION_DEL_TRG1 
AFTER DELETE ON DG_TRIAL_VERSION
REFERENCING OLD AS o NEW AS n 
FOR EACH ROW 
BEGIN
  INSERT INTO DG_TRIAL_VERSION_hist VALUES(:o.ID,:o.DG_TRIAL_ID,:o.VERSION_TIMESTAMP,
  :o.LAST_UPDATED,:o.LAST_UPDATED_FTUSER_ID,:o.EXPORTED,:o.EXPORT_DATE,
  :o.EXPORT_FTUSER_ID,:o.SESSION_STATE,:o.TSPD_DOCUMENT_ID,:o.PROJECT_NAME,
  :o.DRAFT_NAME,:o.SIGNATURE_PROMPT,:o.PRIMARY_FORM,:o.SOA_INSTANCE_ID);
END;
/
ALTER TRIGGER DG_TRIAL_VERSION_DEL_TRG1 ENABLE;


--Implemented upto this in devl,d002,d003 on 08/03/2009 
--Implemented upto this in q002 on 08/03/2009


--As per Justin's request on 08/25/09
update unit_of_measure set oid = 'None_Item' where OID='None' and parent_oid='None';
--Implemented upto this in devl,d002,d003 on 08/25/2009 
--Implemented upto this in q002 on 08/25/2009 


--As per Kelly's request on 08/27/2009
ALTER TABLE tspd_crf_form MODIFY(crf_name VARCHAR2(200));
--Implemented upto this in devl,d002,d003 on 08/27/2009 


--As per Kelly's request on 09/08/2009
ALTER TABLE dg_dest_system add constraint dg_dest_system_UQ2
unique (CLIENT_DIV_ID,DEST_SYSTEM_URL) using index tablespace tspdsmall_indx pctfree 5;

--Implemented upto this in devl,d002,d003,q002 on 09/08/2009 


create or replace PROCEDURE insert_into_uom(ClientDivId IN NUMBER) AS
   v_translation_id NUMBER(10);
   v_uom_id NUMBER(10);
   v_parent_oid VARCHAR2(50);
CURSOR c IS SELECT * from tspd_unit_of_measure;
BEGIN
 EXECUTE IMMEDIATE 'ALTER TABLE unit_of_measure disable constraint UNIT_OF_MEASURE_FK2';
  FOR c1 in C LOOP
  SELECT increment_sequence('translated_text_seq') INTO v_translation_id FROM DUAL;
  INSERT INTO translated_text
  VALUES( v_translation_id,c1.short_desc, 'unit_of_measure',
          'en','US', c1.short_desc,ClientDivId,0);

--  SELECT short_desc INTO v_parent_oid FROM tspd_unit_of_measure
 -- WHERE id=c1.parent_uom_id;

  INSERT INTO unit_of_measure
  VALUES(increment_sequence('unit_of_measure_seq'),
         c1.short_desc, c1.long_desc, c1.obsolete_flg,
         1,1,0,0,c1.parent_uom_id, null,
         v_translation_id,ClientDivId,c1.id,null,null);
  END LOOP;

UPDATE unit_of_measure a
SET a.parent_oid=(SELECT b.short_desc FROM tspd_unit_of_measure b
              WHERE b.parent_uom_id=a.parent_id
              AND b.id = a.tspd_uom_id)
WHERE a.client_div_id=ClientDivId;

UPDATE unit_of_measure a
SET a.parent_id=(SELECT b.id FROM unit_of_measure b
                 WHERE b.tspd_uom_id=a.parent_id
                 AND b.client_div_id=ClientDivId)
WHERE a.client_div_id=ClientDivId;

UPDATE unit_of_measure SET oid=REPLACE(oid,' ','_')
WHERE oid LIKE '% %'
AND client_div_id=ClientDivId;

UPDATE unit_of_measure SET parent_oid=REPLACE(parent_oid,' ','_')
WHERE parent_oid LIKE '% %'
AND client_div_id=ClientDivId;

update unit_of_measure set oid = 'None_Item' where oid = 'None' and parent_oid = 'None';

EXECUTE IMMEDIATE 'ALTER TABLE unit_of_measure enable constraint UNIT_OF_MEASURE_FK2';
END;
/
--Implemented upto this in devl,d002,d003 on 09/09/2009
--Implemented upto this in q002 on 09/09/2009 


--As per Larry's request on 09/14/2009
ALTER TABLE UNIT_OF_MEASURE add(SHORT_DESC VARCHAR2(50));
--Implemented upto this in devl,d002,d003 on 09/14/2009 


--As per Kelly's request on 09/16/2009
create or replace PROCEDURE insert_into_uom(ClientDivId IN NUMBER) AS
   v_translation_id NUMBER(10);
   v_uom_id NUMBER(10);
   v_parent_oid VARCHAR2(50);
CURSOR c IS SELECT * from tspd_unit_of_measure;
BEGIN
 EXECUTE IMMEDIATE 'ALTER TABLE unit_of_measure disable constraint UNIT_OF_MEASURE_FK2';
  FOR c1 in C LOOP
  SELECT increment_sequence('translated_text_seq') INTO v_translation_id FROM DUAL;
  INSERT INTO translated_text
  VALUES( v_translation_id,c1.short_desc, 'unit_of_measure',
          'en','US', c1.short_desc,ClientDivId,0);

--  SELECT short_desc INTO v_parent_oid FROM tspd_unit_of_measure
 -- WHERE id=c1.parent_uom_id;

  INSERT INTO unit_of_measure
  VALUES(increment_sequence('unit_of_measure_seq'),
         c1.short_desc, c1.long_desc, c1.obsolete_flg,
         1,1,0,0,c1.parent_uom_id, null,
         v_translation_id,ClientDivId,c1.id,null,null,null);
  END LOOP;

UPDATE unit_of_measure a
SET a.parent_oid=(SELECT b.short_desc FROM tspd_unit_of_measure b
              WHERE b.parent_uom_id=a.parent_id
              AND b.id = a.tspd_uom_id)
WHERE a.client_div_id=ClientDivId;

UPDATE unit_of_measure a
SET a.parent_id=(SELECT b.id FROM unit_of_measure b
                 WHERE b.tspd_uom_id=a.parent_id
                 AND b.client_div_id=ClientDivId)
WHERE a.client_div_id=ClientDivId;

UPDATE unit_of_measure SET oid=REPLACE(oid,' ','_')
WHERE oid LIKE '% %'
AND client_div_id=ClientDivId;

UPDATE unit_of_measure SET parent_oid=REPLACE(parent_oid,' ','_')
WHERE parent_oid LIKE '% %'
AND client_div_id=ClientDivId;

update unit_of_measure set oid = 'None_Item' where oid = 'None' and parent_oid = 'None';

EXECUTE IMMEDIATE 'ALTER TABLE unit_of_measure enable constraint UNIT_OF_MEASURE_FK2';

INSERT INTO unit_of_measure(id,oid,long_desc,short_desc,client_div_id,CONSTANT_A,CONSTANT_B,CONSTANT_C,CONSTANT_K) 
VALUES(increment_sequence('unit_of_measure_seq'),'Rave','Rave','Rave',ClientDivId,1,1,0,0);

END;
/
--Implemented upto this in devl,d002,d003 on 09/16/2009 
--Implemented upto this in q002 on 09/17/2009 
--Implemented upto this in q003 on 09/18/2009 


--As per request on 09/21/2009
ALTER TABLE tspd_unit_of_measure ADD(oid varchar2(50));

update tspd_unit_of_measure set oid='PRU' where short_desc='PRU' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Density' where short_desc='Density' and parent_uom_id is null;
update tspd_unit_of_measure set oid='kg_m3' where short_desc='kg/m³' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='kgm3_1000' where short_desc='(kg/m³)/1000' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='U_ug' where short_desc='U/µg' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='U_mg' where short_desc='U/mg' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='U_g' where short_desc='U/g' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='U_uL' where short_desc='U/µL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='U_mL' where short_desc='U/mL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='U_dL' where short_desc='U/dL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='U_L' where short_desc='U/L' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='IU_ug' where short_desc='IU/µg' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='IU_mg' where short_desc='IU/mg' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='IU_g' where short_desc='IU/g' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='IU_uL' where short_desc='IU/µL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='IU_mL' where short_desc='IU/mL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='IU_dL' where short_desc='IU/dL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='IU_L' where short_desc='IU/L' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='T-score' where short_desc='T-score' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Z-score' where short_desc='Z-score' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='U_mm3' where short_desc='U/mm³' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='U_HPF' where short_desc='U/HPF' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='U_LPF' where short_desc='U/LPF' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Concentration' where short_desc='Concentration' and parent_uom_id is null;
update tspd_unit_of_measure set oid='ug_mL' where short_desc='µg/mL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='ug_dL' where short_desc='µg/dL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mg_mL' where short_desc='mg/mL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mg_dL' where short_desc='mg/dL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mg_L' where short_desc='mg/L' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='g_dL' where short_desc='g/dL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='g_L' where short_desc='g/L' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='ppm' where short_desc='ppm' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='ppb' where short_desc='ppb' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='M_L' where short_desc='M/L' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='M_kg' where short_desc='M/kg' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mmol_L' where short_desc='mmol/L' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mEq_L' where short_desc='mEq/L' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='ng_mL' where short_desc='ng/mL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='ng_dL' where short_desc='ng/dL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='nmol_L' where short_desc='nmol/L' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='pg_mL' where short_desc='pg/mL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='pg_dL' where short_desc='pg/dL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='pmol_L' where short_desc='pmol/L' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Misc' where short_desc='Misc' and parent_uom_id is null;
update tspd_unit_of_measure set oid='PR' where short_desc='PR' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mm_Hg' where short_desc='mm/Hg' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='perc' where short_desc='%' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Units' where short_desc='Units' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='IU' where short_desc='IU' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='pH' where short_desc='pH' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='USP' where short_desc='U.S.P.' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Light' where short_desc='Light' and parent_uom_id is null;
update tspd_unit_of_measure set oid='Motion' where short_desc='Motion' and parent_uom_id is null;
update tspd_unit_of_measure set oid='Energy_Power' where short_desc='Energy and Power' and parent_uom_id is null;
update tspd_unit_of_measure set oid='cal' where short_desc='cal' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='kcal' where short_desc='kcal' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Acoustics' where short_desc='Acoustics' and parent_uom_id is null;
update tspd_unit_of_measure set oid='dB' where short_desc='dB' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='phon' where short_desc='phon' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Radiation' where short_desc='Radiation' and parent_uom_id is null;
update tspd_unit_of_measure set oid='rad' where short_desc='rad' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mGy' where short_desc='mGy' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mrem' where short_desc='mrem' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Curie' where short_desc='Curie' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='None' where short_desc='None' and parent_uom_id is null;
update tspd_unit_of_measure set oid='None' where short_desc='None' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Other' where short_desc='Other' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Temperature' where short_desc='Temperature' and parent_uom_id is null;
update tspd_unit_of_measure set oid='F' where short_desc='°F' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='C' where short_desc='°C' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='K' where short_desc='°K' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Weight' where short_desc='Weight' and parent_uom_id is null;
update tspd_unit_of_measure set oid='kg' where short_desc='kg' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='g' where short_desc='g' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mg' where short_desc='mg' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='ug' where short_desc='µg' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='oz' where short_desc='oz' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='lb' where short_desc='lb' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='ng' where short_desc='ng' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Dimension' where short_desc='Dimension' and parent_uom_id is null;
update tspd_unit_of_measure set oid='nm' where short_desc='nm' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='nm2' where short_desc='nm²' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mm' where short_desc='mm' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mm2' where short_desc='mm²' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='cm' where short_desc='cm' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='cm2' where short_desc='cm²' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='m' where short_desc='m' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='m2' where short_desc='m²' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='inches' where short_desc='inches' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='inches2' where short_desc='inches²' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Liquid_Flow' where short_desc='Liquid and Flow' and parent_uom_id is null;
update tspd_unit_of_measure set oid='uL' where short_desc='µL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mL' where short_desc='mL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='dL' where short_desc='dL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='L' where short_desc='L' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='uL_min' where short_desc='µL/min' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mL_min' where short_desc='mL/min' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mL_hour' where short_desc='mL/hour' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='uL_min_kg' where short_desc='µL/min/kg' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mL_min_kg' where short_desc='mL/min/kg' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mL_hour_kg' where short_desc='mL/hour/kg' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='g_mL_hour' where short_desc='g/mL/hour' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mg_mL_hour' where short_desc='mg/mL/hour' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='ug_mL_hr' where short_desc='µg/mL/hr' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='ng_mL_hr' where short_desc='ng/mL/hr' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='pL' where short_desc='pL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='fL' where short_desc='fL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='kg_m2' where short_desc='kg/m2' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='years' where short_desc='years' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='ddmmmyyy' where short_desc='dd mmm yyy' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='per_minute' where short_desc='per minute' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='24_hr_clock' where short_desc='24 hr clock' and parent_uom_id is not null;
commit;

CREATE OR REPLACE PROCEDURE insert_into_uom(ClientDivId IN NUMBER) AS
   v_translation_id NUMBER(10);
   v_uom_id NUMBER(10);
   v_parent_oid VARCHAR2(50);
   v_none_id number(10);
   v_none_oid varchar2(50);
   CURSOR c1 IS SELECT * from tspd_unit_of_measure a where a.parent_uom_id is null and trim(lower(a.short_desc)) <> 'other'
                and not exists (select 1 from unit_of_measure b where b.tspd_uom_id=a.id and b.client_div_id=ClientDivId)  ;

   cursor c3 is select id,uom_id from TSPD_study_variable where client_div_id=ClientDivId 
                and uom_id in (select id from tspd_unit_of_measure);

begin

-- Start the outer loop for parent rows

   for ix1 in c1 loop

       	SELECT increment_sequence('translated_text_seq') INTO v_translation_id FROM DUAL;
 	INSERT INTO translated_text (ID,ITEM_OID,OWNER_TABLE,LANGUAGE,REGION,TEXT,CLIENT_DIV_ID,DELETED)        
  		VALUES( v_translation_id,ix1.oid, 'unit_of_measure',
          	'en',null, ix1.short_desc,ClientDivId,0);
     
        SELECT increment_sequence('unit_of_measure_seq') INTO v_uom_id FROM DUAL;
	INSERT INTO unit_of_measure(ID,OID,LONG_DESC,DELETED,CONSTANT_A,CONSTANT_B,CONSTANT_C,
		CONSTANT_K,PARENT_ID,PARENT_OID,TRANSLATION_TEXT_ID,CLIENT_DIV_ID,TSPD_UOM_ID,
		STANDARD_OID,STANDARD_ID,SHORT_DESC) VALUES (v_uom_id,ix1.oid,ix1.long_desc, 
		ix1.obsolete_flg,1,1,0,0,null, null,v_translation_id,ClientDivId,ix1.id,null,
		null,ix1.short_desc);

     declare
         cursor c2 is select * from tspd_unit_of_measure where parent_uom_id = ix1.id and trim(lower(short_desc)) <> 'other';

     begin

-- Start the inner loop for child rows for a given parent from outer loop

        for ix2 in c2 loop

       		SELECT increment_sequence('translated_text_seq') INTO v_translation_id FROM DUAL;
 		INSERT INTO translated_text (ID,ITEM_OID,OWNER_TABLE,LANGUAGE,REGION,TEXT,CLIENT_DIV_ID,DELETED)        
  			VALUES( v_translation_id,ix2.oid, 'unit_of_measure','en',null, ix2.short_desc,ClientDivId,0);     

		INSERT INTO unit_of_measure(ID,OID,LONG_DESC,DELETED,CONSTANT_A,CONSTANT_B,CONSTANT_C,
			CONSTANT_K,PARENT_ID,PARENT_OID,TRANSLATION_TEXT_ID,CLIENT_DIV_ID,TSPD_UOM_ID,
			STANDARD_OID,STANDARD_ID,SHORT_DESC) select increment_sequence('unit_of_measure_seq'),
			ix2.oid,ix2.long_desc,ix2.obsolete_flg,1,1,0,0,v_uom_id,ix1.oid,v_translation_id,
			ClientDivId,ix2.id,null,null,ix2.short_desc from dual;
       end loop;
     end;
   end loop;

-- Insert "OTHER" row with None as Parent

 select id,oid into v_none_id,v_none_oid from unit_of_measure where client_div_id=ClientDivId and parent_id is null 
   	and trim(lower(short_desc))='none';

 SELECT increment_sequence('translated_text_seq') INTO v_translation_id FROM DUAL;
 INSERT INTO translated_text (ID,ITEM_OID,OWNER_TABLE,LANGUAGE,REGION,TEXT,CLIENT_DIV_ID,DELETED)        
  	VALUES( v_translation_id,'Other', 'unit_of_measure','en',null,'Other',ClientDivId,0);     

 INSERT INTO unit_of_measure(ID,OID,LONG_DESC,DELETED,CONSTANT_A,CONSTANT_B,CONSTANT_C,
	CONSTANT_K,PARENT_ID,PARENT_OID,TRANSLATION_TEXT_ID,CLIENT_DIV_ID,TSPD_UOM_ID,
	STANDARD_OID,STANDARD_ID,SHORT_DESC) select increment_sequence('unit_of_measure_seq'),
	'Other','Other',0,1,1,0,0,v_none_id,v_none_oid,v_translation_id,
	ClientDivId,null,null,null,'Other' from dual;

-- Insert special "RAVE" row

 SELECT increment_sequence('translated_text_seq') INTO v_translation_id FROM DUAL;
 INSERT INTO translated_text (ID,ITEM_OID,OWNER_TABLE,LANGUAGE,REGION,TEXT,CLIENT_DIV_ID,DELETED)        
  	VALUES( v_translation_id,'Rave', 'unit_of_measure','en',null,'Rave',ClientDivId,0);     

 INSERT INTO unit_of_measure(ID,OID,LONG_DESC,DELETED,CONSTANT_A,CONSTANT_B,CONSTANT_C,
	CONSTANT_K,PARENT_ID,PARENT_OID,TRANSLATION_TEXT_ID,CLIENT_DIV_ID,TSPD_UOM_ID,
	STANDARD_OID,STANDARD_ID,SHORT_DESC) select increment_sequence('unit_of_measure_seq'),
	'Rave','Rave',0,1,1,0,0,null,null,v_translation_id,
	ClientDivId,null,null,null,'Rave' from dual;

-- Update the None child to None_item

 select id into v_uom_id from unit_of_measure where client_div_id=ClientDivId and 
        trim(lower(short_desc))='none' and Parent_id is not null;
 update unit_of_measure set oid='None_Item', short_desc='None_Item', long_desc='None_Item' where id=v_uom_id;

-- update tspd_study_variable for new uom_id's if any

  for ix3 in c3 loop      
	update tspd_study_variable a set (a.UOM_ID,a.UOM_SHORT_DESC) = (select b.id,b.oid from unit_of_measure b 
	where b.tspd_uom_id=ix3.uom_id and b.client_div_id=ClientDivId) where a.id=ix3.id;
  end loop;
end;
/
sho err;

--Implemented upto this in devl on 09/21/2009
--Implemented upto this in q002 on 09/21/2009
--Implemented upto this in d002,d003 on 09/23/2009
--Implemented upto this in q003 on 09/23/2009

Create or replace trigger tspd_study_variable_trg1
before insert or update of uom_id on tspd_study_variable
referencing new as n old as o
for each row
declare

v_exists number(2);
invalid_uom exception;

begin
 
 if :n.uom_id is not null then
  select count(*) into v_exists from tspd_unit_of_measure where id=:n.uom_id;

  if v_exists <> 1 then
       select count(*) into v_exists from unit_of_measure where client_div_id=:n.client_div_id
       and id=:n.uom_id;
    if v_exists <> 1 then
 raise invalid_uom;
    end if;
  end if;
 end if; 
exception

   when invalid_uom then
 Raise_application_error(-20502,'Invalid UOM_ID. Please contact support');
end;
/
sho err;

--******************************************************
--Implemented upto this in devl on 09/23/2009
--Implemented upto this in q002 on 09/23/2009
--Implemented upto this in d002,d003 on 09/23/2009
--Implemented upto this in q003 on 09/23/2009
--******************************************************