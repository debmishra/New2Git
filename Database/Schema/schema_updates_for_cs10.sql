--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_for_cs10.sql$ 
--
-- $Revision: 3$        $Date: 2/22/2008 11:56:03 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

alter table COUNTRY add constraint COUNTRY_pk primary
key(id) using index tablespace cssmall_indx pctfree 15;

alter table CURRENCY add constraint CURRENCY_pk primary
key(id) using index tablespace cssmall_indx pctfree 15;

alter table DEGREE add constraint DEGREE_pk primary
key(id) using index tablespace cssmall_indx pctfree 15;

alter table DOC_MAIN add constraint DOC_MAIN_pk primary
key(id) using index tablespace cssmall_indx pctfree 15;

alter table DOC_PROC add constraint DOC_PROC_pk primary
key(id) using index tablespace cssmall_indx pctfree 15;

alter table EXP_AREA add constraint EXP_AREA_pk primary
key(id) using index tablespace cssmall_indx pctfree 15;

alter table EXP_PHASE add constraint EXP_PHASE_pk primary
key(id) using index tablespace cssmall_indx pctfree 15;

alter table EXP_TA add constraint EXP_TA_pk primary
key(id) using index tablespace cssmall_indx pctfree 15;

alter table PATIENT_STATUS add constraint PATIENT_STATUS_pk primary
key(id) using index tablespace cssmall_indx pctfree 15;

alter table PERSON add constraint PERSON_pk primary
key(id) using index tablespace cssmall_indx pctfree 15;

alter table PROCEDURE_DEF add constraint PROCEDURE_DEF_pk primary
key(id) using index tablespace cssmall_indx pctfree 15;

alter table RES_AGE add constraint RES_AGE_pk primary
key(id) using index tablespace cssmall_indx pctfree 15;

alter table SETTING add constraint SETTING_pk primary
key(id) using index tablespace cssmall_indx pctfree 15;

alter table STATE add constraint STATE_pk primary
key(id) using index tablespace cssmall_indx pctfree 15;

alter table SUFFIX add constraint SUFFIX_pk primary
key(id) using index tablespace cssmall_indx pctfree 15;

alter table TIME add constraint TIME_pk primary
key(id) using index tablespace cssmall_indx pctfree 15;

alter table TIME_UNIT add constraint TIME_UNIT_pk primary
key(id) using index tablespace cssmall_indx pctfree 15;


Alter table country add constraint country_fk1 foreign key(currency_id)
references currency(id);


create sequence COUNTRY_seq start with 252;
create sequence CURRENCY_seq start with 81;
create sequence DEGREE_seq start with 12;
create sequence DOC_MAIN_seq start with 2607;
create sequence DOC_PROC_seq start with 2;
create sequence EXP_AREA_seq start with 9;
create sequence EXP_PHASE_seq start with 5;
create sequence EXP_TA_seq start with 16;
create sequence PATIENT_STATUS_seq start with 3;
create sequence PERSON_seq start with 8;
create sequence PROCEDURE_DEF_seq start with 21;
create sequence RES_AGE_seq start with 6;
create sequence SETTING_seq start with 10;
create sequence STATE_seq start with 57;
create sequence SUFFIX_seq start with 8;
create sequence TIME_seq start with 10;
create sequence TIME_UNIT_seq start with 3;
create sequence doc_main_doc_id_seq start with 482254;




---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/22/2008 11:56:03 AMDebashish Mishra  
--  2    DevTSM    1.1         9/19/2006 12:11:34 AMDebashish Mishra   
--  1    DevTSM    1.0         8/19/2005 6:24:49 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
