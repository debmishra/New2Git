spool IQ_database_designer_2dot6_log.txt;

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

/*The below sql position is changed to after table creation */
--As per Peter's request on 07/08/09
--  ALTER TABLE tspd_crf_form
--  ADD CONSTRAINT tspd_crf_form_uk2 UNIQUE (
--    oid,
 --   client_div_id
--  )
--  USING INDEX
--    TABLESPACE tspdsmall_indx
--    PCTFREE    5
--/

--Implemented upto this in devl,d002,d003 on 07/08/2009
--*****************************************************
--Implemented upto this in q002 on 07/08/2009
--*****************************************************

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
--***********************************************************
--Implemented upto this in devl,d002,d003 on 07/22/2009
--***********************************************************
--*** Schema Changes for Designer Gateway (DG) ***--
--*** 01/13/2009                               ***--

create table dg_trial(
id		Number(10),
trial_id	Number(10) NOT NULL,
rave_dest_id	Number(10),
create_date	date NOT NULL,
creator_ftuser_id Number(10) NOT NULL)
tablespace tspdsmall pctfree 20;

--The client_div_to_rave_dest table creation
--is placed above the foreign key creation.
--DDL position changed on 07/27
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



--/*Placed only here in the IQ script, so that run 
-- after "create table tspd_crf_form". Commented in the 
-- original location. */
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
--***********************************************************
--Implemented upto this in devl,d002,d003 on 07/13/2009 
--Implemented upto this in q002 on 07/20/2009
--***********************************************************

--As per Kelly's request on 07/17/2009
--In SQA (q002)
update dg_dest_system set dest_system_url = dest_system_url||'/RaveWebServices2.0'


----------------------------------------------------------------
---------------------------From GM3.0 below---------------------
CREATE TABLE complexity_hist (
  id          NUMBER(10,0) NOT NULL,
  phase_id NUMBER(10,0) NOT NULL,                
  indmap_id   NUMBER(10,0) NOT NULL,   
  complexity_val NUMBER(10,0) NOT NULL
)
TABLESPACE TSMLARGE pctfree 20
/

ALTER TABLE complexity_hist 
  ADD CONSTRAINT complexity_hist_pk PRIMARY KEY (
    id
  )
  USING INDEX
    TABLESPACE TSMLARGE_indx
    PCTFREE    20
/

ALTER TABLE complexity_hist
  ADD CONSTRAINT complexity_hist_fk1 FOREIGN KEY (
    phase_id
  ) REFERENCES phase (
    id
  )
/

--ALTER TABLE complexity_hist DROP CONSTRAINT complexity_hist_fk2;

ALTER TABLE complexity_hist
  ADD CONSTRAINT complexity_hist_fk2 FOREIGN KEY (
    indmap_id
  ) REFERENCES indmap (
    id
  )
/

--Modified from tsm10e to tsm10.
insert into id_control values ('tsm10','complexity_hist',1);
commit;

--Complexity_val columns already added as part of another change.
--ALTER TABLE protocol add( complexity_val NUMBER(10,0) NULL)
--/
 
--ALTER TABLE procedure_def add( complexity_val NUMBER(10,0) NULL)
--/

--As per Tonya's request on 03/05/2009
--In devl, d003 and d002.

--ALTER TABLE trial_budget add( complexity_val NUMBER(10,0) NULL)
--/

--As per Phil's request on 03/06/2009
--In devl, d003 and d002.
alter table complexity_hist modify(COMPLEXITY_VAL number(12,2));

alter table protocol modify(COMPLEXITY_VAL number(12,2));

alter table procedure_def modify(COMPLEXITY_VAL number(12,2));

ALTER TABLE trial_budget modify( complexity_val NUMBER(12,2) );

alter table tsm_trial_rollup add( hist_complexity_val NUMBER(12,2) );

--As per Tonya's's request on 03/16/2009
--In devl, d003 and d002.
alter table tsm_trial_rollup add( complexity_val NUMBER(12,2) NULL);


--As per Tonya's's request on 03/17/2009
--In devl, d003 and d002.
alter table cost_item add( trial_id NUMBER(10) );
ALTER TABLE cost_item
  ADD CONSTRAINT cost_item_fk5 FOREIGN KEY (
    trial_id
  ) REFERENCES trial (
    id
  )
/

alter table picas_visit add( trial_id NUMBER(10) );
ALTER TABLE picas_visit
  ADD CONSTRAINT picas_visit_fk2 FOREIGN KEY (
    trial_id
  ) REFERENCES trial (
    id
  )
/

--As per Tonya's's request on 03/18/2009
--In devl, d003 and d002.
alter table cost_item modify(TRIAL_BUDGET_ID null);
alter table picase_trial add(dropout_rate NUMBER(12,2) default 0 not null );
--Implemented in Q002 and Q003 on 03/23/09


--As per Tonya's's request on 03/19/2009
--In devl
--To be removed and commented. Not to be implemented.
--CREATE OR REPLACE TRIGGER trial_budget_trg1 after insert on trial_budget referencing new as n old as o for each row
--
--declare
--
--v_exist1 number(10);
--invalid_budget exception;
--
--begin
--
-- Select count(*) into v_exist1 from trial_budget where country_id=:n.country_id and trial_id=:n.trial_id and delete_flg=0 and --parent_trial_budget_id is null;  if v_exist1 > 1 then
--   raise invalid_budget;
-- end if;
--
--exception
--
-- when invalid_budget then
--     Raise_application_error(-20061,'Error while storing the budget. Please contact support'); 
--end ; 
--/


--As per Phil's request on 03/26/2009
--In devl, d003 and d002.
CREATE TABLE tsm_internal_cust (
  id            NUMBER(10,0) NOT NULL,
  client_div_id NUMBER(10,0) NOT NULL,                
  customer_name VARCHAR2(1000) NOT NULL,
  deleted       NUMBER(1,0)    DEFAULT 0 NOT NULL
)
TABLESPACE TSMSMALL pctfree 20
/

ALTER TABLE tsm_internal_cust 
  ADD CONSTRAINT tsm_internal_cust_pk PRIMARY KEY (
    id
  )
  USING INDEX
    TABLESPACE TSMSMALL_indx
    PCTFREE    20
/

ALTER TABLE tsm_internal_cust
  ADD CONSTRAINT tsm_internal_cust_fk1 FOREIGN KEY (
    client_div_id
  ) REFERENCES client_div (
    id
  )
/

insert into id_control values ('tsm10e','tsm_internal_cust',1);
commit;

--to hold currency figures  
ALTER TABLE picase_trial add(expected_trial_cost NUMBER(12,2));

ALTER TABLE picase_trial add(num_subjects  NUMBER(6,0));
ALTER TABLE picase_trial add(num_visits    NUMBER(6,0));
ALTER TABLE picase_trial add(tsm_internal_cust_id  NUMBER(10,0));
ALTER TABLE picase_trial add(pediatric_flg   NUMBER(1,0) DEFAULT 0 NOT NULL);
ALTER TABLE picase_trial add(patient_type   NUMBER(1,0));
ALTER TABLE picase_trial add(patient_duration  NUMBER(6,0));
ALTER TABLE picase_trial add(patient_duration_unit NUMBER(1,0));

ALTER TABLE picase_trial ADD CONSTRAINT picase_trial_fk8 
FOREIGN KEY ( tsm_internal_cust_id ) 
REFERENCES tsm_internal_cust ( id );


--1 = inpatient, 2 = outpatient, 3 = Mixed
ALTER TABLE picase_trial 
ADD CONSTRAINT patient_type_check CHECK(patient_type    in   (1,  2, 3) ); 

--1=days, 2=weeks, 3=months, 4=years
ALTER TABLE picase_trial
ADD CONSTRAINT patient_duration_unit_check CHECK (
    patient_duration_unit    in   (1,  2, 3, 4) ); 
--Implemented upto this in DEVL, D002 and D003 on 03/27/2009

--As per Phil's request in devl, d003 and d002 on 04/15/09
ALTER TABLE picase_trial modify(patient_type  NUMBER(3,0));

ALTER TABLE picase_trial DROP CONSTRAINT patient_type_check;

--123=Inpatient,124=Outpatient,125=Mixed in the ip_business_factors table
ALTER TABLE picase_trial 
ADD CONSTRAINT patient_type_check CHECK(patient_type in (123,  124, 125));

--Implemented upto this in DEVL, D002 and D003 on 04/15/2009


--As per Tonya's request on 04/27/09
alter table picase_trial add(gm_version number(1));
alter table trial_budget add(gm_version number(1));
--Implemented upto this in DEVL, D002 and D003 on 04/27/2009

--As per Phil's request on 04/28/09

ALTER TABLE country add(country_group_id   NUMBER(10,0),
                        is_mdsol_viewable   NUMBER(1,0)   DEFAULT 0 NOT NULL);


--Implemented upto this in DEVL, D002 and D003 on 04/28/2009

alter table country rename column COUNTRY_GROUP_ID to group_country_id;

INSERT INTO country(id,NAME,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE) 
VALUES(increment_sequence('country_seq'),'Africa',1,2,0,0,0,0,1);

INSERT INTO country(id,NAME,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE) 
VALUES(increment_sequence('country_seq'),'Central America',1,2,0,0,0,0,1);

INSERT INTO country(id,NAME,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE) 
VALUES(increment_sequence('country_seq'),'Global',1,2,0,0,0,0,1);

INSERT INTO country(id,NAME,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE) 
VALUES(increment_sequence('country_seq'),'Middle East',1,2,0,0,0,0,1);

INSERT INTO country(id,NAME,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE) 
VALUES(increment_sequence('country_seq'),'South America',1,2,0,0,0,0,1);

INSERT INTO country(id,NAME,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE) 
VALUES(increment_sequence('country_seq'),'Ghana',1,2,0,0,0,0,1);

--COUNTRY_FK4 doesnt exist, hence commented 07/27/2009.
--alter table country drop constraint COUNTRY_FK4;

UPDATE country 
set GROUP_COUNTRY_ID=(select id FROM country 
                             WHERE name='Global')
where name<>'Global'
AND id in (122,123,125,126);

UPDATE country 
set GROUP_COUNTRY_ID=(select id FROM country 
                             WHERE name='Europe')
WHERE name in ('Western Europe','Eastern Europe');
update country set GROUP_COUNTRY_ID=null where name='Global';
commit;
UPDATE COUNTRY set group_country_id=124,is_mdsol_viewable=1 WHERE name='Africa';
UPDATE COUNTRY set group_country_id=122,is_mdsol_viewable=1 WHERE name='Algeria';
UPDATE COUNTRY set group_country_id=126,is_mdsol_viewable=1 WHERE name='Argentina';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Australia';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Austria';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Bangladesh';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Belarus';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Belgium';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Bosnia and Herzegovina';
UPDATE COUNTRY set group_country_id=126,is_mdsol_viewable=1 WHERE name='Brazil';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Bulgaria';
UPDATE COUNTRY set group_country_id=115,is_mdsol_viewable=1 WHERE name='Canada';
UPDATE COUNTRY set group_country_id=124,is_mdsol_viewable=1 WHERE name='Central America';
UPDATE COUNTRY set group_country_id=126,is_mdsol_viewable=1 WHERE name='Chile';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='China';
UPDATE COUNTRY set group_country_id=126,is_mdsol_viewable=1 WHERE name='Colombia';
UPDATE COUNTRY set group_country_id=123,is_mdsol_viewable=1 WHERE name='Costa Rica';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Croatia';
UPDATE COUNTRY set group_country_id=125,is_mdsol_viewable=1 WHERE name='Cyprus';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Czech Republic';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Denmark';
UPDATE COUNTRY set group_country_id=123,is_mdsol_viewable=1 WHERE name='Dominican Republic';
UPDATE COUNTRY set group_country_id=116,is_mdsol_viewable=1 WHERE name='Eastern Europe';
UPDATE COUNTRY set group_country_id=126,is_mdsol_viewable=1 WHERE name='Ecuador';
UPDATE COUNTRY set group_country_id=122,is_mdsol_viewable=1 WHERE name='Egypt';
UPDATE COUNTRY set group_country_id=123,is_mdsol_viewable=1 WHERE name='El Salvador';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Estonia';
UPDATE COUNTRY set group_country_id=124,is_mdsol_viewable=1 WHERE name='Europe';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Finland';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='France';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Georgia';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Germany';
UPDATE COUNTRY set group_country_id=122,is_mdsol_viewable=1 WHERE name='Ghana';
UPDATE COUNTRY set group_country_id=124,is_mdsol_viewable=1 WHERE name='Global';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Greece';
UPDATE COUNTRY set group_country_id=123,is_mdsol_viewable=1 WHERE name='Guatemala';
UPDATE COUNTRY set group_country_id=123,is_mdsol_viewable=1 WHERE name='Honduras';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Hong Kong';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Hungary';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Iceland';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='India';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Indonesia';
UPDATE COUNTRY set group_country_id=125,is_mdsol_viewable=1 WHERE name='Iran';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Ireland';
UPDATE COUNTRY set group_country_id=125,is_mdsol_viewable=1 WHERE name='Israel';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Italy';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Japan';
UPDATE COUNTRY set group_country_id=122,is_mdsol_viewable=1 WHERE name='Kenya';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Latvia';
UPDATE COUNTRY set group_country_id=125,is_mdsol_viewable=1 WHERE name='Lebanon';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Lithuania';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Luxembourg';
UPDATE COUNTRY set group_country_id=122,is_mdsol_viewable=1 WHERE name='Malawi';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Malaysia';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Malta';
UPDATE COUNTRY set group_country_id=123,is_mdsol_viewable=1 WHERE name='Mexico';
UPDATE COUNTRY set group_country_id=124,is_mdsol_viewable=1 WHERE name='Middle East';
UPDATE COUNTRY set group_country_id=122,is_mdsol_viewable=1 WHERE name='Morocco';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Netherlands';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='New Zealand';
UPDATE COUNTRY set group_country_id=124,is_mdsol_viewable=1 WHERE name='North America';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Norway';
UPDATE COUNTRY set group_country_id=124,is_mdsol_viewable=1 WHERE name='Pacific Asia';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Pakistan';
UPDATE COUNTRY set group_country_id=123,is_mdsol_viewable=1 WHERE name='Panama';
UPDATE COUNTRY set group_country_id=126,is_mdsol_viewable=1 WHERE name='Peru';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Philippines';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Poland';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Portugal';
UPDATE COUNTRY set group_country_id=123,is_mdsol_viewable=1 WHERE name='Puerto Rico';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Romania';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Russia';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Serbia';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Singapore';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Slovakia';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Slovenia';
UPDATE COUNTRY set group_country_id=122,is_mdsol_viewable=1 WHERE name='South Africa';
UPDATE COUNTRY set group_country_id=124,is_mdsol_viewable=1 WHERE name='South America';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='South Korea';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Spain';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Sweden';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Switzerland';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Taiwan';
UPDATE COUNTRY set group_country_id=122,is_mdsol_viewable=1 WHERE name='Tanzania';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Thailand';
UPDATE COUNTRY set group_country_id=122,is_mdsol_viewable=1 WHERE name='Tunisia';
UPDATE COUNTRY set group_country_id=125,is_mdsol_viewable=1 WHERE name='Turkey';
UPDATE COUNTRY set group_country_id=122,is_mdsol_viewable=1 WHERE name='Uganda';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Ukraine';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='United Kingdom';
UPDATE COUNTRY set group_country_id=115,is_mdsol_viewable=1 WHERE name='United States';
UPDATE COUNTRY set group_country_id=126,is_mdsol_viewable=1 WHERE name='Uruguay';
UPDATE COUNTRY set group_country_id=126,is_mdsol_viewable=1 WHERE name='Venezuela';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Vietnam';
UPDATE COUNTRY set group_country_id=116,is_mdsol_viewable=1 WHERE name='Western Europe';
UPDATE COUNTRY set group_country_id=122,is_mdsol_viewable=1 WHERE name='Zambia';
update country set GROUP_COUNTRY_ID=null where name='Global';
commit;

--Implemented upto this in Q002 on 05/04/2009


--As per Tonya's request on 05/01/2009
ALTER TABLE picase_trial ADD(target_enrolled_patients        NUMBER(6));
ALTER TABLE picase_trial ADD(target_screened_patients        NUMBER(6));
--Implemented upto this in DEVL, D002 and D003 on 05/01/2009


--As per Tonya's request on 05/20/2009
ALTER TABLE trial_budget ADD(TOTAL_COST_NO_OH  NUMBER(10), TOTAL_COST_NO_OH_LOCAL NUMBER(10));
--Implemented upto this in DEVL, D002 and D003 on 05/20/2009


--As per Tonya's request on 05/27/2009
ALTER TABLE trial_budget ADD(Fixed_scr_fail_cost NUMBER(10,2),
                             Is_fixed_scr_fail_cost  NUMBER(1) DEFAULT 0 NOT NULL); 

--Implemented upto this in DEVL, D002 and D003 on 05/27/2009
--Implemented upto this in q002 on 05/28/2009


--As per Tonya's request on 06/11/2009
ALTER TABLE trial_budget ADD(is_cost_add_to_trial NUMBER(1) DEFAULT 1 NOT NULL);

--Implemented upto this in DEVL, D002 and D003 on 06/11/2009
--Implemented upto this in q002 on 06/25/2009


--As per Tonya's request on 07/06/2009
ALTER TABLE cost_item ADD(temp_frequency NUMBER(12,2));

--Implemented upto this in DEVL, D002 and D003 on 07/06/2009

--As per Tonya's request on 07/10/2009
ALTER TABLE picase_trial MODIFY(GM_VERSION NUMBER(4,2));
ALTER TABLE trial_budget MODIFY(GM_VERSION NUMBER(4,2));

--In q002 on 07/13/2009
--In devl, d002, d003 on 07/14/2009
CREATE INDEX COST_ITEM_INDX2 ON COST_ITEM(TRIAL_ID) 
TABLESPACE TSMLARGE_INDX ;
/***********************************************************/
--Implemented upto this in DEVL, D002 and D003 on 07/10/2009 
--Index created in development on 07/14/2009
--Implemented upto this in q002 on 07/13/2009
--Implemented upto this in prev on 07/14/2009
/***********************************************************/

--As per Tonya's request on 07/17/2009
ALTER TABLE trial_budget ADD(total_cost_pvb_no_oh NUMBER(10),total_cost_pvb_no_oh_local NUMBER(10));
/***********************************************************/
--Implemented upto this in DEVL, D002 and D003 on 07/20/2009 
/***********************************************************/


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
--***********************************************************
--Implemented upto this in devl,d002,d003 on 07/30/2009
--Implemented upto this in q002 on 07/30/2009
--***********************************************************

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

spool off;