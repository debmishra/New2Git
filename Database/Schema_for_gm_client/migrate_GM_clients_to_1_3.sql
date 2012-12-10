--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: migrate_GM_clients_to_1_3.sql$ 
--
-- $Revision: 11$        $Date: 2/27/2008 3:17:44 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
Create table pap_Institution_odc_cost(
	id number(10),
	Institution_id number(10),
	mapper_id number(10),
	pct50 number(16,2),
	price_type varchar2(10))
	tablespace tsmlarge 
	pctused 60 pctfree 25;

Alter table pap_Institution_odc_cost add constraint pap_Institution_odc_cost_pk
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 25;

Alter table pap_institution_odc_cost add constraint
	pap_institution_odc_cost_uq1 
	unique(institution_id,mapper_id)
	using index tablespace tsmlarge_indx pctfree 20;

Alter table pap_institution_odc_cost add constraint pioc_price_type_check 
	check( price_type in ('CPP', 'VISIT', 'GLOBAL' ));


Alter table pap_Institution_odc_cost add constraint pap_Institution_odc_cost_fk1
	foreign key (Institution_id) references 
	"&1".Institution(id);

Alter table pap_Institution_odc_cost add constraint pap_Institution_odc_cost_fk2
	foreign key (mapper_id) references 
	mapper(id);

Grant select,insert,update,delete on pap_Institution_odc_cost to "&1";

create sequence pap_Institution_odc_cost_seq;

create table data_by_year(
  	ID 		NUMBER(10),
  	procset_type 	VARCHAR2(10) NOT NULL,
  	dataset_type 	VARCHAR2(10) not NULL,
  	spec 		NUMBER(2)  not NULL,
  	country		VARCHAR2(10) not NULL,  
  	year		VARCHAR2(10) not NULL,
  	cnt		NUMBER(10) not NULL,
	clin_type 	varchar2(10) not NULL)
	tablespace tsmsmall 
	pctused 60 pctfree 15;

Alter table data_by_year add constraint data_by_year_pk
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 25;


create sequence data_by_year_seq;


Alter table pap_clinical_proc_cost add(
	ind_year number(10),
	ind_unused_cnt number(10),
	co_year number(10),
	co_unused_cnt number(10),
	level2_skip_flg number(1) default 0 not null,
	Ind_entry_year number(10),
	num_companies number(10));

Alter table PAP_clinical_proc_cost add constraint PCPC_level2_skip_flg_check 
	check (level2_skip_flg in (0,1));


Alter table Industry_pap_odc_cost add(
	YEAR NUMBER(10),
	USED_CNT NUMBER(10),
	UNUSED_CNT NUMBER(10),
	Num_companies NUMBER(10),
	Entry_year NUMBER(10));

Alter table company_pap_odc_cost add(
	YEAR NUMBER(10),
	USED_CNT NUMBER(10),
	UNUSED_CNT NUMBER(10));

Alter table g50_company_pap_odc_cost add(
	YEAR NUMBER(10),
	USED_CNT NUMBER(10),
	UNUSED_CNT NUMBER(10));

Alter table g50_pap_clinical_proc_cost add(
	ind_year number(10),
	ind_unused_cnt number(10),
	co_year number(10),
	co_unused_cnt number(10),
	level2_skip_flg number(1) default 0 not null,
	Ind_entry_year number(10),
	num_companies number(10));



exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  11   DevTSM    1.10        2/27/2008 3:17:44 PM Debashish Mishra  
--  10   DevTSM    1.9         9/19/2006 12:08:02 AMDebashish Mishra  removed
--       references to obsolete tables
--  9    DevTSM    1.8         3/3/2005 6:33:27 AM  Debashish Mishra   
--  8    DevTSM    1.7         3/3/2005 6:32:18 AM  Debashish Mishra  
--  7    DevTSM    1.6         9/2/2004 12:57:18 PM Debashish Mishra Added
--       data_by_year table to the migration script
--  6    DevTSM    1.5         8/24/2004 9:21:40 AM Debashish Mishra New column
--       pap_clinical_proc_cost.num_companies
--  5    DevTSM    1.4         8/16/2004 11:41:35 AMDebashish Mishra New columns
--       added and migration scripts are also updated.
--  4    DevTSM    1.3         7/27/2004 1:49:51 PM Debashish Mishra Added
--       level2_skip_flg to pap_clinical_proc_cost
--  3    DevTSM    1.2         7/27/2004 1:42:10 PM Debashish Mishra Added four new
--       columns to pap_clinical_proc_cost
--  2    DevTSM    1.1         6/10/2004 9:26:44 AM Debashish Mishra added exit at
--       the end as it will be called from a shell script
--  1    DevTSM    1.0         6/10/2004 9:21:22 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
