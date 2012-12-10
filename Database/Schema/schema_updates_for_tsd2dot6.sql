
--As per Fiametta's request in tsm10@devl On 01/22/2009
--tsm10@d003 on 01/27/2009
alter table tspd_variable_mapping add(ext_par_oid      VARCHAR2(80)   NULL);
alter table tspd_variable_mapping add(ext_par_sequence NUMBER(10,0)   NULL);

--As per Fiametta's request in tsm10@devl On 01/26/2009
--tsm10@d003 on 01/27/2009
alter table tspd_study_variable add(oid varchar2(80) NULL);

--As per Kelly's request in tsm10@devl, tsm10@d003
--On 01/27/2009
CREATE TABLE Procedure_Ext_Meta
(
OID VARCHAR2(50) NOT NULL,
CLIENT_DIV_ID NUMBER(10,0) NOT NULL,
DATA_TYPE NUMBER(10,0) NOT NULL,
DESCRIPTION VARCHAR2(250)
);

ALTER TABLE Procedure_Ext_Meta   ADD CONSTRAINT Procedure_Ext_Meta_uq1 
UNIQUE (OID,client_div_id) USING INDEX
TABLESPACE tsmsmall_indx PCTFREE 5; 

CREATE TABLE PROCEDURE_DEF_EXT
(
PROCEDURE_DEF_ID NUMBER(10,0) NOT NULL,
OID VARCHAR2(50) NOT NULL,
CLIENT_DIV_ID NUMBER(10,0) NOT NULL,
Value VARCHAR2(250)
);
ALTER TABLE PROCEDURE_DEF_EXT ADD CONSTRAINT PROCEDURE_DEF_EXT_uq1 
UNIQUE (procedure_def_id,OID) USING INDEX
TABLESPACE tsmsmall_indx PCTFREE 5; 

CREATE TABLE ODC_DEF_EXT
(
ODC_DEF_ID NUMBER(10,0) NOT NULL,
OID VARCHAR2(50) NOT NULL,
CLIENT_DIV_ID NUMBER(10,0) NOT NULL,
Value VARCHAR2(250)
);
ALTER TABLE ODC_DEF_EXT ADD CONSTRAINT ODC_DEF_EXT_uq1 
UNIQUE (odc_def_id,OID) USING INDEX
TABLESPACE tsmsmall_indx PCTFREE 5; 


CREATE TABLE UNLISTED_PROCEDURE_EXT
(
UNLISTED_PROCEDURE_ID NUMBER(10,0) NOT NULL,
OID VARCHAR2(50) NOT NULL, 
CLIENT_DIV_ID NUMBER(10,0) NOT NULL, 
Value VARCHAR2(250) ); 
ALTER TABLE UNLISTED_PROCEDURE_EXT ADD CONSTRAINT UNLISTED_PROCEDURE_EXT_uq1 
UNIQUE (unlisted_procedure_id,OID) USING INDEX
TABLESPACE tsmsmall_indx PCTFREE 5;

--As per Larry's request in TSM10@devl
--on 01/27/2009
CREATE TABLE code_list (
  id                NUMBER(10,0)   NOT NULL,
  name              VARCHAR2(80)   NOT NULL,
  data_type         VARCHAR2(20)   NOT NULL,
  sas_format_name   VARCHAR2(80)   NULL,
  external_dict     VARCHAR2(80)   NULL,
  external_version  VARCHAR2(80)   NULL,
  external_ref      VARCHAR2(1024) NULL,
  external_href     VARCHAR2(1024) NULL
)
TABLESPACE tsmsmall
  PCTFREE 20
/
 

ALTER TABLE code_list ADD CONSTRAINT data_type CHECK (
    data_type in ('integer','float','text','string') );


CREATE TABLE code_list_item (
  id                NUMBER(10,0)   NOT NULL,
  coded_value       VARCHAR(80)    NOT NULL,
  rank              NUMBER(10,0)   NULL,
  code_list_id      NUMBER(10,0)   NOT NULL
)
TABLESPACE tsmsmall
  PCTFREE 20
/

insert into id_control values('tsm10','code_list',1);
insert into id_control values('tsm10','code_list_item',1);
commit;

--As per Fiametta's request in TSM10@devl, tsm10@d003 and tsm10@d002
--on 01/28/2009
alter table TSPD_VARIABLE_MAPPING add(ext_par_type       VARCHAR2(80)   NULL);
alter table TSPD_VARIABLE_MAPPING add(ext_var_oid       VARCHAR2(80)   NULL);

alter table tspd_analysis_var_mapping add(ext_var_oid       VARCHAR2(80)   NULL);


--As per Larry's request in TSM10@devl, tsm10@d003 and tsm10@d002--on 01/28/2009
alter table code_list_item  rename column rank to item_rank;
alter table code_list rename column name to list_name;

--As per Fiametta's request in TSM10@devl, tsm10@d003 and tsm10@d002
--on 01/29/2009
alter table tspd_analysis_var_mapping add(variable_oid       VARCHAR2(80)   NULL);

--As per Larry's request in TSM10@devl,tsm10@d003, tsm10@d002 on 02/02/09
alter table code_list add (client_div_id     NUMBER(10,0) NOT NULL);
alter table code_list add (oid   VARCHAR2(80) NOT NULL);

alter table code_list_item  add (client_div_id     NUMBER(10,0) NOT NULL);
alter table code_list_item  add (oid  VARCHAR2(80) NOT NULL);
alter table code_list_item  add (code_list_oid   VARCHAR2(80) NOT NULL);

CREATE TABLE translated_text (
  id                NUMBER(10,0)  NOT NULL,  
  item_oid          VARCHAR2(80)  NOT NULL,
  owner_table       VARCHAR2(80)  NOT NULL,
  language          VARCHAR2(4)   NOT NULL,
  region            VARCHAR2(4)   NULL,
  text              VARCHAR2(80)  NOT NULL,
  client_div_id  NUMBER(10,0)     NOT NULL,  
  deleted             VARCHAR2(5) default 'FALSE' NOT NULL
)
TABLESPACE tsmsmall
  PCTFREE 20
/
ALTER TABLE translated_text ADD CONSTRAINT translated_text_check 
 CHECK (deleted in ('FALSE', 'TRUE'));

create or replace FUNCTION find_translation ( v_item_oid IN VARCHAR2, v_owner_table IN varchar2, 
                                              v_language in varchar2, v_region in varchar2) 
                                          RETURN VARCHAR2 AS

v_result varchar2(80);

BEGIN

v_result:= NULL;

SELECT text INTO v_result FROM translated_text
WHERE v_item_oid=item_oid 
AND v_owner_table=owner_table
AND v_language=language 
AND v_region=region;

IF v_result is NOT NULL THEN
   RETURN v_result;
END IF;


SELECT text INTO v_result FROM translated_text
WHERE v_item_oid=item_oid 
AND v_owner_table=owner_table
AND v_language=language;

IF v_result is NOT NULL THEN
   RETURN v_result;
END IF;

SELECT text INTO v_result FROM translated_text
WHERE v_item_oid=item_oid 
AND v_owner_table=owner_table
AND language='en';

IF v_result is NOT NULL THEN
   RETURN v_result;
END IF;

SELECT text INTO v_result FROM translated_text
WHERE v_item_oid=item_oid 
AND v_owner_table=owner_table
AND language='en' 
AND region='US';

RETURN v_result;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
     RETURN v_result;
END;
/

create or replace
TRIGGER CODE_LIST_ITEM_TRG1
BEFORE INSERT OR UPDATE ON CODE_LIST_ITEM
REFERENCING OLD AS o NEW AS n
FOR EACH ROW
DECLARE
     v_data_type varchar2(20);
     v_result    varchar2(2);
     invalid_value exception;
BEGIN

   v_result:='NO';

   SELECT data_type
   INTO v_data_type
   FROM code_list
   WHERE id=:n.code_list_id;

   IF v_data_type='integer' THEN
      SELECT 'OK' INTO v_result FROM dual WHERE REGEXP_LIKE(:n.coded_value,'^[[:digit:]]*$');
   ELSIF v_data_type='float' THEN
      SELECT 'OK' INTO v_result FROM dual WHERE REGEXP_LIKE(:n.coded_value,'^[[:digit:]]*\.[[:digit:]]*$');
   ELSE
      v_result:='OK';
   END IF;

   IF v_result='NO' THEN
      raise invalid_value;
   END IF;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
     raise_application_error(-20000,'No datatype found');
  WHEN invalid_value THEN
     raise_application_error(-20000,'Invalid coded value');
END;
/

ALTER TABLE translated_text 
  ADD CONSTRAINT translated_text_pk PRIMARY KEY (
    id
  )
  USING INDEX
    TABLESPACE tsmsmall_indx
    PCTFREE    20
/
insert into id_control values('tsm10','translated_text',1);

ALTER TABLE code_list
  ADD CONSTRAINT code_list_pk PRIMARY KEY ( 
    id
  )
  USING INDEX TABLESPACE tspdsmall_indx
  PCTFREE   30
/

ALTER TABLE code_list
  ADD CONSTRAINT code_list_fk1 FOREIGN KEY (
    client_div_id
  ) REFERENCES client_div (
    id
  )
/

ALTER TABLE code_list_item
  ADD CONSTRAINT code_list_item_pk PRIMARY KEY (
    id
  )
  USING INDEX TABLESPACE tspdsmall_indx
    PCTFREE   30
/

ALTER TABLE code_list_item
  ADD CONSTRAINT code_list_item_fk1 FOREIGN KEY (
   client_div_id
  ) REFERENCES client_div ( id )
/

ALTER TABLE code_list_item
  ADD CONSTRAINT code_list_item_fk2 FOREIGN KEY (
    code_list_id
  ) REFERENCES code_list ( id  )
/

ALTER TABLE translated_text
  ADD CONSTRAINT translated_text_fk1 FOREIGN KEY (
    client_div_id
  ) REFERENCES client_div (
    id
  )
/
commit;

CREATE TABLE UNIT_OF_MEASURE 
   ( ID NUMBER(10,0), 
 OID VARCHAR2(50 BYTE) NOT NULL, 
 LONG_DESC VARCHAR2(160 BYTE), 
 DELETED NUMBER(1,0) DEFAULT 0 NOT NULL, 
 CONSTANT_A NUMBER(10,0) NOT NULL, 
 CONSTANT_B NUMBER(10,0) NOT NULL, 
 CONSTANT_C NUMBER(10,0) NOT NULL, 
 CONSTANT_K NUMBER(10,0) NOT NULL, 
 PARENT_ID NUMBER(10, 0),
 PARENT_OID VARCHAR2(50 BYTE), 
 TRANSLATION_TEXT_ID NUMBER(10, 0),
 CLIENT_DIV_ID NUMBER(10, 0),
 TSPD_UOM_ID NUMBER(10, 0)
   )
/

insert into id_control values('tsm10','unit_of_measure',5001);
commit;

ALTER TABLE UNIT_OF_MEASURE 
  ADD CONSTRAINT UNIT_OF_MEASURE_pk PRIMARY KEY (
    id
  )
  USING INDEX
    TABLESPACE tsmsmall_indx
    PCTFREE    20
/

ALTER TABLE UNIT_OF_MEASURE
  ADD CONSTRAINT UNIT_OF_MEASURE_fk1 FOREIGN KEY (
    client_div_id
  ) REFERENCES client_div (
    id
  )
/

ALTER TABLE UNIT_OF_MEASURE
  ADD CONSTRAINT UNIT_OF_MEASURE_fk2 FOREIGN KEY (
    parent_id
  ) REFERENCES UNIT_OF_MEASURE ( id )
/

ALTER TABLE UNIT_OF_MEASURE
  ADD CONSTRAINT UNIT_OF_MEASURE_fk3 FOREIGN KEY (
    TRANSLATION_TEXT_ID
  ) REFERENCES translated_text ( id )
/

ALTER TABLE UNIT_OF_MEASURE
  ADD CONSTRAINT UNIT_OF_MEASURE_fk4 FOREIGN KEY (
    TSPD_UOM_ID
  ) REFERENCES TSPD_unit_of_measure ( id )
/

-- AS per Kelly's request on 02/05/09 in tsm10@devl
-- tsm10@d003 and tsm10@d002

ALTER TABLE PROCEDURE_DEF_EXT add (PROCEDURE_EXT_META_OID VARCHAR2(50) NOT NULL);
ALTER TABLE ODC_DEF_EXT add (PROCEDURE_EXT_META_OID VARCHAR2(50) NOT NULL);
ALTER TABLE UNLISTED_PROCEDURE_EXT add (PROCEDURE_EXT_META_OID VARCHAR2(50) NOT NULL);

ALTER TABLE PROCEDURE_DEF_EXT DROP CONSTRAINT PROCEDURE_DEF_EXT_uq1;
ALTER TABLE ODC_DEF_EXT DROP CONSTRAINT ODC_DEF_EXT_uq1;
ALTER TABLE UNLISTED_PROCEDURE_EXT DROP CONSTRAINT UNLISTED_PROCEDURE_EXT_uq1;

ALTER TABLE PROCEDURE_DEF_EXT ADD CONSTRAINT PROCEDURE_DEF_EXT_uq1 
UNIQUE (client_div_id, procedure_def_id,PROCEDURE_EXT_META_OID) USING INDEX
TABLESPACE tsmsmall_indx PCTFREE 5; 

ALTER TABLE ODC_DEF_EXT ADD CONSTRAINT ODC_DEF_EXT_uq1 
UNIQUE (client_div_id, odc_def_id,PROCEDURE_EXT_META_OID) USING INDEX
TABLESPACE tsmsmall_indx PCTFREE 5;

ALTER TABLE UNLISTED_PROCEDURE_EXT ADD CONSTRAINT UNLISTED_PROCEDURE_EXT_uq1 
UNIQUE (client_div_id, unlisted_procedure_id,PROCEDURE_EXT_META_OID) USING INDEX
TABLESPACE tsmsmall_indx PCTFREE 5;

alter table procedure_Def_ext drop column oid;
alter table ODC_DEF_EXT drop column oid;
alter table UNLISTED_PROCEDURE_EXT drop column oid;

ALTER TABLE Procedure_Ext_Meta
  ADD CONSTRAINT Procedure_Ext_Meta_fk1 FOREIGN KEY (
    client_div_id
  ) REFERENCES client_div (
    id
  )
/

ALTER TABLE PROCEDURE_DEF_EXT
  ADD CONSTRAINT PROCEDURE_DEF_EXT_fk1 FOREIGN KEY (
    client_div_id
  ) REFERENCES client_div (
    id
  )
/

ALTER TABLE PROCEDURE_DEF_EXT
  ADD CONSTRAINT PROCEDURE_DEF_EXT_fk2 FOREIGN KEY (
    PROCEDURE_DEF_ID
  ) REFERENCES PROCEDURE_DEF (
    id
  )
/

ALTER TABLE ODC_DEF_EXT
  ADD CONSTRAINT ODC_DEF_EXT_fk1 FOREIGN KEY (
    client_div_id
  ) REFERENCES client_div (
    id
  )
/

ALTER TABLE ODC_DEF_EXT
  ADD CONSTRAINT ODC_DEF_EXT_fk2 FOREIGN KEY (
    ODC_DEF_ID
  ) REFERENCES PROCEDURE_DEF (
    id
  )
/


ALTER TABLE  unlisted_procedure_ext
  ADD CONSTRAINT  unlisted_procedure_ext_fk1 FOREIGN KEY (
    client_div_id
  ) REFERENCES client_div (
    id
  )
/

ALTER TABLE unlisted_procedure_ext
  ADD CONSTRAINT unlisted_procedure_ext_fk2 FOREIGN KEY (
    UNLISTED_PROCEDURE_ID
  ) REFERENCES UNLISTED_PROCEDURE (
    id
  )
/


-- AS per Fiametta's request on 02/11/09 in tsm10@devl
-- In tsm10@d002, tsm10@d003 on 02/24/2009
ALTER TABLE unit_of_measure add(standard_oid varchar2(50));
ALTER TABLE unit_of_measure add(standard_id number(10));

-- AS per Justin's request on 02/24/09 in tsm10@devl
-- tsm10@d003 and tsm10@d002

ALTER TABLE translated_text DROP CONSTRAINT translated_text_check;
alter table translated_text add (deleted_temp number(1) DEFAULT 0 NOT NULL);
update translated_text set deleted_temp=0 WHERE deleted='FALSE';
update translated_text set deleted_temp=1 WHERE deleted='TRUE';
commit;
ALTER TABLE translated_text drop column deleted;
ALTER TABLE translated_text rename column deleted_temp to deleted;
ALTER TABLE translated_text ADD CONSTRAINT translated_text_check CHECK (deleted in (1, 0));

--Implemented upto this in tsm10@q002 on 02/26/2009 at 4:00pm

--As per Fiametta's request in tsm10@devl On 02/27/2009
--tsm10@d003 and tsm10@d002 on 02/27/2009
alter table tspd_variable_mapping drop column form_oid;
alter table tspd_variable_mapping drop column form_sequence;

--As per Fiammetta's request on 03/03/2009
ALTER TABLE tspd_study_variable drop constraint  tspd_study_variable_fk4;



--Implemented upto this in devl, d002, d003, tsm10@q002 
-- on 03/03/2009 at 12:00pm

/* Some errors in implementation
ALTER TABLE tspd_study_variable ADD CONSTRAINT tspd_study_variable_uq3 UNIQUE (
    client_div_id,
    OID
  )
  USING INDEX
    TABLESPACE tspdsmall_indx
    PCTFREE    5
/
*/

---Implemented in DEVL, D003 and D002 as per Justin's request
---On 03/12/2009
ALTER TABLE tspd_study_variable ADD(precision varchar2(10));

--Implemented upto this in tsm10@q002 
-- on 04/01/2009 at 3:00pm


--As per Kelly's request on 04/21/2009
UPDATE tspd_study_variable SET oid=acronym WHERE oid IS NULL;

--Implemented upto this in tsm10@devl,D003,D002 
-- on 04/21/2009 at 12:30pm


--As per Kelly's request on 04/30/2009
--Commented on 07/27/2009, since it was decided
--to hold on to this change for future.
--CREATE UNIQUE INDEX unlisted_procedure_uq1 ON unlisted_procedure(client_id,name,type)
--tablespace tspdsmall_indx
--    PCTFREE    5;

--Implemented upto this in tsm10@devl 
-- on 04/30/2009 at 03:30pm
--Dropped from dEVL on 07/27/09


CREATE OR REPLACE procedure deletefulltspdtrial (trialID in number, ftuserid in number)
 as
begin
INSERT INTO Audit_Hist(ID,FTUSER_ID,COMMENTS,APP_TYPE,ACTION,TARGET_NAME,
TARGET_PRIMARY_TABLE,TARGET_ID,ENTITY_TYPE,ENTITY_ID,START_DATE,
MODIFY_DATE,TSPD_ROLE) select increment_sequence('audit_hist_seq'),
ftUserID, null,'TSPD','DELETE_TRIAL', protocol_identifier,
'tspd_trial', trialID, 'tspd_trial', trialID, sysdate,sysdate, null
 from trial where id=trialid;

DELETE FROM tspd_doc_advisory WHERE  tspd_document_id IN
(SELECT id FROM Tspd_document WHERE tspd_document.trial_id = trialID);

DELETE FROM tspd_doc_comment WHERE  tspd_document_id IN
(SELECT id FROM Tspd_document WHERE tspd_document.trial_id = trialID);

DELETE FROM tspd_doc_reviewer WHERE  tspd_document_id IN
(SELECT id FROM Tspd_document WHERE tspd_document.trial_id = trialID);

DELETE FROM tspd_document_authors WHERE  tspd_document_id IN
(SELECT id FROM Tspd_document WHERE tspd_document.trial_id = trialID);

DELETE FROM tspd_document_history WHERE  tspd_document_id IN
(SELECT id FROM Tspd_document WHERE tspd_document.trial_id = trialID);

DELETE FROM tspd_diagram WHERE  icp_instance_id  IN
(SELECT id FROM icp_instance WHERE icp_instance.trial_id = trialID);

DELETE FROM tspd_document WHERE trial_id = trialID;

DELETE FROM icp_instance WHERE trial_id = trialID;

UPDATE tspd_template set CONFIGURED_BY_TRIAL_ID = null where CONFIGURED_BY_TRIAL_ID = trialID;

DELETE FROM tspd_trial WHERE trial_id = trialID;

DELETE FROM trial WHERE id = trialID
and not exists ( select 1 from picase_trial where picase_trial.trial_id = trialID)
and not exists (select 1 from cro_trial where cro_trial.trial_id = trialID);

end;
/

--Implemented upto this in tsm10@devl
-- on 05/06/2009 at 11:30am
--Upto this in D002 and d003 on 05/15/09


--As per Michael's request on devl,d002,d003 and q002 on 05/15/09
ALTER TABLE audit_hist modify(target_name varchar2(300));

--As per Kelly's request on 05/20/2009. In devl.
update tspd_variable_mapping a set a.variable_oid=(SELECT b.acronym FROM tspd_study_variable b
WHERE a.study_variable_id=b.id);
commit;

--Implemented upto this in tsm10@devl
-- on 05/20/2009 at 3:30pm
--Upto this in d002 and d003 on 05/21/2009 at 2:15pm
--Upto this in q002 on 05/26/2009 


--As per Michael's request on 06/30/2009
INSERT INTO ftgroup VALUES(36, 'Rave Study Developer');
INSERT INTO ftgroup VALUES(37, 'Rave Architect User');
commit;

--Implemented upto this in devl and q002 on 06/30/2009
--Implemented upto this in d002 and d003 on 07/01/2009


--As per Peter's request on 07/08/09
ALTER TABLE tspd_crf_form
  ADD CONSTRAINT tspd_crf_form_uk2 UNIQUE (
    oid,
    client_div_id
  )
  USING INDEX
    TABLESPACE tspdsmall_indx
    PCTFREE    5
/

--Implemented upto this in devl,d002,d003 on 07/08/2009
--Implemented upto this in q002 on 07/08/2009

create or replace
procedure deletefulltspdtrial (trialID in number, ftuserid in number)
 as
begin
INSERT INTO Audit_Hist(ID,FTUSER_ID,COMMENTS,APP_TYPE,ACTION,TARGET_NAME,
TARGET_PRIMARY_TABLE,TARGET_ID,ENTITY_TYPE,ENTITY_ID,START_DATE,
MODIFY_DATE,TSPD_ROLE) select increment_sequence('audit_hist_seq'),
ftUserID, null,'TSPD','DELETE_TRIAL', protocol_identifier,
'tspd_trial', trialID, 'tspd_trial', trialID, sysdate,sysdate, null
 from trial where id=trialid;

DELETE FROM tspd_doc_advisory WHERE  tspd_document_id IN
(SELECT id FROM Tspd_document WHERE tspd_document.trial_id = trialID);

DELETE FROM tspd_doc_comment WHERE  tspd_document_id IN
(SELECT id FROM Tspd_document WHERE tspd_document.trial_id = trialID);

DELETE FROM tspd_doc_reviewer WHERE  tspd_document_id IN
(SELECT id FROM Tspd_document WHERE tspd_document.trial_id = trialID);

DELETE FROM tspd_document_authors WHERE  tspd_document_id IN
(SELECT id FROM Tspd_document WHERE tspd_document.trial_id = trialID);

DELETE FROM tspd_document_history WHERE  tspd_document_id IN
(SELECT id FROM Tspd_document WHERE tspd_document.trial_id = trialID);

DELETE FROM tspd_diagram WHERE  icp_instance_id  IN
(SELECT id FROM icp_instance WHERE icp_instance.trial_id = trialID);

DELETE FROM dg_trial_version WHERE  tspd_document_id IN
    (SELECT id FROM Tspd_document WHERE tspd_document.trial_id = trialID);
    
DELETE FROM tspd_document WHERE trial_id = trialID;
DELETE FROM icp_instance WHERE trial_id = trialID;

UPDATE tspd_template set CONFIGURED_BY_TRIAL_ID=null,LOCKED_BY_FTUSER_ID=null
where CONFIGURED_BY_TRIAL_ID = trialID;

DELETE FROM tspd_trial WHERE trial_id = trialID;

DELETE FROM dg_trial WHERE trial_id = trialID;

DELETE FROM trial WHERE id = trialID
and not exists ( select 1 from picase_trial where picase_trial.trial_id = trialID)
and not exists (select 1 from cro_trial where cro_trial.trial_id = trialID);

end;
/

--Implemented upto this in devl,d002,d003 on 07/22/2009
--Implemented upto this in q002 on 07/23/2009


--As per Kelly's request on 07/30/2009. 
CREATE OR REPLACE TRIGGER TSPD_STUDY_VARIABLE_TRG1 
before insert on TSPD_STUDY_VARIABLE
referencing new as n old as o
for each row
begin
  If :n.oid is null then
     :n.oid := :n.acronym;
  end if;

end ;
/

ALTER TRIGGER TSPD_STUDY_VARIABLE_TRG1 ENABLE;


--Implemented upto this in devl,d002,d003 on 07/30/2009
--Implemented upto this in q002 on 07/30/2009


--As per request on 08/19/2009
ALTER TABLE TSPD_CRF_FORM drop constraint TSPD_CRF_FORM_UK1;

--Implemented upto this in devl,d002,d003 on 08/19/2009
--Implemented upto this in q002 on 08/19/2009

create database link tsm10_q002_dblink connect to tsm10 identified by welcome using 'q002';

declare
  user_id number(10);
  cnt_rec number(10);

begin

  SELECT count(*) INTO cnt_rec FROM ftuser where name='fasttrack@FTS';

  IF cnt_rec = 0 THEN
     select ID into user_id FROM ftuser where name='usr3@CDI0';
  ELSE 
     SELECT ID INTO user_id FROM ftuser WHERE name='fasttrack@FTS';
  END IF;
     
  INSERT INTO tspd_template 
  SELECT increment_sequence('tspd_template_seq'),0,LAST_UPDATED, NAME, DATA,'431.240.142', 
  user_id, VERSION, STATUS, SYSDATE, user_id, NULL, RETIRED_DATE, LOCALE, DATE_FORMAT, 
  STARTEAM_TAG, NULL, NULL, TEMPLATE_TID, 1, COMMENTS 
FROM tspd_template@tsm10_q002_dblink
WHERE template_tid=1 and client_div_id=136
and status='Testing';
end;
/

drop database link tsm10_q002_dblink;
--------------------------------
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
EXECUTE IMMEDIATE 'ALTER TABLE unit_of_measure enable constraint UNIT_OF_MEASURE_FK2';
END;
/

alter procedure deletefulltspdtrial compile;


--As per Kelly's request on 08/24/09
ALTER TABLE code_list
  ADD CONSTRAINT code_list_uk1 UNIQUE (
    client_div_id,oid
  )
  USING INDEX
    TABLESPACE tspdsmall_indx
    PCTFREE    5
/

--Implemented upto this in devl,d002,d003,q002 on 08/24/09
--Implemented upto this in q002 on 08/24/09



--As per Larry's request on 09/10/2009
ALTER TABLE tspd_document DROP CONSTRAINT td_snapshot_type_check;

ALTER TABLE tspd_document ADD CONSTRAINT td_snapshot_type_check 
CHECK (snapshot_type in ('WorkingCopy','ReviewCopy','FinalVersion','ConflictVersion','AuthorChange','DocTypeChange','Baseline','TrackChanges','Restored','Corrupted','Export','Corrotto'));

--***********************************************************
--Implemented upto this in devl,d002,d003 on 09/10/09
--Implemented upto this in q002 on 09/11/09
--Implemented upto this in q003 on 09/18/2009
--***********************************************************