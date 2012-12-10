--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tsm10_client_tables.sql$ 
--
-- $Revision: 38$        $Date: 1/27/2009 1:22:28 PM$
--
--
-- Description:  Creates tables and primary keys for a tsm client
--
---------------------------------------------------------------------

drop table own_procedure;
drop table own_odc;
drop table own_site;
drop table own_protocol;
drop table own_investig;

drop table id_control;
drop table databld_run_prop;
drop table databld_run;
drop table data_by_year;
drop table pap_institution_odc_cost;
drop table g50_COMPANY_PAP_ODC_COST;
drop table COMPANY_PAP_ODC_COST;
drop table INDUSTRY_PAP_ODC_COST;

drop table g50_pap_clinical_proc_cost;
drop table g50_ip_study_price;
drop table g50_pap_overhead;
drop table modelled_cpp_fence;
drop table modelled_inclusion;
drop table modelled_upfence;
drop table modelled_standardize;
drop table md_odc_oh_pct;
drop table modelled_coeff;
Drop table IP_study_price;
Drop table PAP_clinical_proc_cost;
Drop table institution_overhead;
Drop table pap_overhead;
Drop table pap_Institution_proc_cost;
drop table mapper;
drop table gm_proc_freq;
drop table gm_trial_freq;


Create table gm_trial_freq(
	id number(10),
	indmap_id number(10)  NOT NULL,
	phase_id number(10)  NOT NULL,
	trial_cnt number(10)  NOT NULL,
	total_cnt number(10)  NOT NULL,
	years_back number(2)  NOT NULL)
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Alter table gm_trial_freq add constraint gm_trial_freq_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Create table gm_proc_freq(
	ID			NUMBER(10),
	PHASE_ID                NUMBER(10) NOT NULL,
	INDMAP_ID               NUMBER(10) NOT NULL,
	MAPPER_ID        	NUMBER(10) NOT NULL,
	PROC_CNT                NUMBER(10) NOT NULL,
	TRIAL_CNT               NUMBER(10) NOT NULL,
	YEARS_BACK              NUMBER(2) NOT NULL,
	USAGE_CNT               NUMBER(10) default 0 NOT NULL,
	USAGE_PROC              NUMBER(10) default 0 NOT NULL)
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Alter table gm_proc_freq add constraint gm_proc_freq_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Create table mapper(
	id number(10),
	odc_def_id number(10),
	Procedure_def_id number(10))
	tablespace tsmsmall 
	pctused 60 pctfree 5;

Alter table mapper add constraint mapper_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 5;


Create table pap_Institution_proc_cost(
	id number(10),
	Institution_id number(10),
	mapper_id number(10),
	pct50 number(16,2),
	pct_ids varchar2(100))
	tablespace tsmlarge 
	pctused 60 pctfree 5;

Alter table pap_Institution_proc_cost add constraint pap_Institution_proc_cost_pk
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 5;

Alter table pap_institution_proc_cost add constraint
	pap_institution_proc_cost_uq1 
	unique(institution_id,mapper_id)
	using index tablespace tsmlarge_indx pctfree 5;

Create table pap_overhead(
	id number(10),
	Country_id number(10),
	phase_id number(10) not null,
        indmap_id number(10) not null,
        company_ovrhd_p50 number(16,2),
	company_odc_p50 number(16,2),
	ofc_ovrhd_p25 number(16,2),
	ofc_ovrhd_p50 number(16,2),
	ofc_ovrhd_p75 number(16,2),
	adj_ovrhd_p25 number(16,2),
	adj_ovrhd_p50 number(16,2),
	adj_ovrhd_p75 number(16,2),
	affiliation varchar2(20) not null,
	odc_p50 number(16,2),
	company_pct_paid_p50 number(16,2),
	pct_paid_p50 number(16,2),
        specificity number(10),
	adj_ovrhd_pct_ids varchar2(100),
	ofc_ovrhd_pct_ids varchar2(100),
	pct_paid_pct_ids varchar2(100),
	odc_pct_ids varchar2(100),
	company_ovrhd_pct_ids varchar2(100),
	company_odc_pct_ids varchar2(100),
        company_pct_paid_pct_ids varchar2(100))
	tablespace tsmlarge 
	pctused 60 pctfree 5;

Alter table pap_overhead add constraint pap_overhead_pk
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 5;

Alter table pap_overhead add constraint po_affiliation_check 
	check (affiliation in ('Affiliated','Unaffiliated','Both','AllSites'));

Alter table pap_overhead add constraint
	pap_overhead_uq1 
	unique(country_id,affiliation,indmap_id,phase_id)
	using index tablespace tsmlarge_indx pctfree 5;


Create table institution_overhead(
	id number(10),
	institution_id number(10),
	ofc_ovrhd_p25 number(16,2),
	ofc_ovrhd_p50 number(16,2),
	ofc_ovrhd_p75 number(16,2),
	adj_ovrhd_p25 number(16,2),
	adj_ovrhd_p50 number(16,2),
	adj_ovrhd_p75 number(16,2),
	ovrhd_base_pct number(16,2),
	Experience_count number(5),
	pct_paid_p50 number(16,2),
	ovrhd_18mo_p50 number(16,2),
	ofc_ovrhd_pct_ids  varchar2(100),
        adj_ovrhd_pct_ids  varchar2(100),
        ovrhd_base_pct_ids varchar2(100),
        pct_paid_pct_ids   varchar2(100),
        ovrhd_18mo_pct_ids  varchar2(100))
	tablespace tsmlarge 
	pctused 60 pctfree 5;

Alter table institution_overhead add constraint institution_overhead_pk
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 5;

Alter table institution_overhead add constraint
	institution_overhead_uq1 
	unique(institution_id)
	using index tablespace tsmlarge_indx pctfree 5;


Create table PAP_clinical_proc_cost(
	id number(10),
	Country_id number(10),
	indmap_id number(10) not null,
	Phase_id number(10) not null,
	mapper_id number(10),
	pct25 number(16,2),
	pct50 number(16,2),
	pct75 number(16,2),
	company_pct50 number(16,2),
	de_price  number(1) default 0 not null,
	co_exp_cnt number(5),
	other_exp_cnt number(5),
	specificity number(10),
	ind_year number(10),
	ind_unused_cnt number(10),
	co_year number(10),
	co_unused_cnt number(10),
	level2_skip_flg number(1) default 0 not null,
	Ind_entry_year number(10),
	num_companies number(10),
	company_pct25 NUMBER(16,2),
    	company_pct75 NUMBER(16,2),
	industry_pct_ids varchar2(100),
	company_pct_ids  varchar2(100))
	tablespace tsmlarge 
	pctused 70 pctfree 5;

Alter table PAP_clinical_proc_cost add constraint PAP_clinical_proc_cost_pk
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 5;	

Alter table PAP_clinical_proc_cost add constraint PCPC_de_price_check 
	check (de_price in (0,1));

Alter table PAP_clinical_proc_cost add constraint PCPC_level2_skip_flg_check 
	check (level2_skip_flg in (0,1));

Alter table pap_clinical_proc_cost add constraint
	pap_clinical_proc_cost_uq1 
	unique(country_id,mapper_id,phase_id,indmap_id)
	using index tablespace tsmlarge_indx pctfree 5;

Create table IP_study_price(
	id number(10),
	country_id number(10) not null,
	indmap_id number(10) not null,
	phase_id number(10) not null,
	pct25 number(16,2),
	pct50 number(16,2),
	pct75 number(16,2),
	company_pct50 number(16,2),
	de_price number(1) default 0 not null,
	cpp_flg number(1) default 0 not null,
	co_cpp_exp_cnt number(5),
	other_cpp_exp_cnt number(5),
	industry_pct_ids varchar2(100),
	co_pct_ids varchar2(100))
	tablespace tsmlarge 
	pctused 60 pctfree 5;

Alter table IP_study_price add constraint IP_study_price_pk
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 5;

Alter table IP_study_price add constraint ISP_de_price_check 
	check (de_price in (0,1));

Alter table IP_study_price add constraint ISP_cpp_flg_check 
	check (cpp_flg in (0,1));

Alter table ip_study_price add constraint
	ip_study_price_uq1 
	unique(country_id,indmap_id,phase_id,cpp_flg)
	using index tablespace tsmlarge_indx pctfree 5;


create or replace view pap_overhead_overhead as
	select id, country_id, phase_id, indmap_id,
	company_ovrhd_p50, ofc_ovrhd_p25,
	ofc_ovrhd_p50, ofc_ovrhd_p75,
	adj_ovrhd_p25, adj_ovrhd_p50, adj_ovrhd_p75, specificity
	from pap_overhead
	where adj_ovrhd_p50 is not null;

create or replace view pap_overhead_odc as
	select id, country_id, phase_id, indmap_id,
	company_odc_p50, odc_p50
	from pap_overhead
	where odc_p50 is not null;

create or replace view pap_overhead_pct_paid as
	select id, country_id, phase_id, indmap_id,
	company_pct_paid_p50,
	pct_paid_p50
	from pap_overhead
	where pct_paid_p50 is not null;

create table modelled_coeff (
	id number (10),
	country_id number (10) not null,
	coeff_type varchar2(7) not null,
	coeff_value varchar2(20),
	cross_coeff_type varchar2(7),
	cross_coeff_value varchar2(20),
	coeff number(20,12))
	tablespace tsmsmall 
	pctused 60 pctfree 5;

Alter table modelled_coeff add constraint modelled_coeff_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 5;

Create table md_odc_oh_pct
	(id number (10),
	country_id number (10) not null, 
	ta_id number(10) not null, 
	oh_pct number(20,12) ,
	odc_pct number(20,12))
	tablespace tsmsmall 
	pctused 60 pctfree 5;

Alter table MD_ODC_OH_PCT add constraint MD_ODC_OH_PCT_PK 
	primary key(ID) using index tablespace tsmsmall_indx 
	pctfree 5 ;

create table modelled_inclusion (
	id number (10),
 	coeff_type varchar2(7) not null,
	coeff_value varchar2(20))
	tablespace tsmsmall 
	pctused 60 pctfree 5;

Alter table modelled_inclusion add constraint modelled_inclusion_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 5;

Create table modelled_upfence(
	id number(10),
	country_id number(10) not null,
	ta_id number(10) not null,
	upfence number(20,12) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 5;

Alter table modelled_upfence add constraint modelled_upfence_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 5;

Create table modelled_standardize(
	id number(10),
	country_id number(10), 
	type varchar2(10) not null,
	patient number(10) not null,
	duration number(20,12) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 5;

Alter table modelled_standardize add constraint modelled_standardize_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 5;

Alter table modelled_standardize add constraint ms_type_check check(
	type in ('LOCATION','SCALE','ADD','MULT','N'));


create table modelled_cpp_fence (
	id number (10),
 	country_id number (10) not null,
	cpp_low number(20,12) not null,
	cpp_high number(20,12)not null)
	tablespace tsmsmall 
	pctused 60 pctfree 5;

Alter table modelled_cpp_fence add constraint modelled_cpp_fence_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 5;



Create table g50_PAP_clinical_proc_cost(
	id number(10),
	Country_id number(10),
	indmap_id number(10) not null,
	Phase_id number(10) not null,
	mapper_id number(10),
	pct25 number(16,2),
	pct50 number(16,2),
	pct75 number(16,2),
	company_pct50 number(16,2),
	de_price  number(1) default 0 not null,
	co_exp_cnt number(5),
	other_exp_cnt number(5),
	specificity number(10),
	ind_year number(10),
	ind_unused_cnt number(10),
	co_year number(10),
	co_unused_cnt number(10),
	level2_skip_flg number(1) default 0 not null,
	Ind_entry_year number(10),
	num_companies number(10),
	company_pct25 NUMBER(16,2),
    	company_pct75 NUMBER(16,2),
	industry_pct_ids varchar2(100),
	company_pct_ids  varchar2(100))
	tablespace tsmlarge 
	pctused 70 pctfree 5;

Alter table g50_PAP_clinical_proc_cost add constraint g50_PAP_clinical_proc_cost_pk
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 5;	

Alter table g50_PAP_clinical_proc_cost add constraint g50_PCPC_de_price_check 
	check (de_price in (0,1));

Alter table g50_pap_clinical_proc_cost add constraint
	g50_pap_clinical_proc_cost_uq1 
	unique(country_id,mapper_id,phase_id,indmap_id)
	using index tablespace tsmlarge_indx pctfree 5;

Create table g50_IP_study_price(
	id number(10),
	country_id number(10) not null,
	indmap_id number(10) not null,
	phase_id number(10) not null,
	pct25 number(16,2),
	pct50 number(16,2),
	pct75 number(16,2),
	company_pct50 number(16,2),
	de_price number(1) default 0 not null,
	cpp_flg number(1) default 0 not null,
	co_cpp_exp_cnt number(5),
	other_cpp_exp_cnt number(5),
	industry_pct_ids varchar2(100),
	co_pct_ids varchar2(100))
	tablespace tsmlarge 
	pctused 60 pctfree 5;

Alter table g50_IP_study_price add constraint g50_IP_study_price_pk
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 5;

Alter table g50_IP_study_price add constraint g50_ISP_de_price_check 
	check (de_price in (0,1));

Alter table g50_IP_study_price add constraint g50_ISP_cpp_flg_check 
	check (cpp_flg in (0,1));

Alter table g50_ip_study_price add constraint
	g50_ip_study_price_uq1 
	unique(country_id,indmap_id,phase_id,cpp_flg)
	using index tablespace tsmlarge_indx pctfree 5;


Create table g50_pap_overhead(
	id number(10),
	Country_id number(10),
	phase_id number(10) not null,
        indmap_id number(10) not null,
        company_ovrhd_p50 number(16,2),
	company_odc_p50 number(16,2),
	ofc_ovrhd_p25 number(16,2),
	ofc_ovrhd_p50 number(16,2),
	ofc_ovrhd_p75 number(16,2),
	adj_ovrhd_p25 number(16,2),
	adj_ovrhd_p50 number(16,2),
	adj_ovrhd_p75 number(16,2),
	affiliation varchar2(20) not null,
	odc_p50 number(16,2),
	company_pct_paid_p50 number(16,2),
	pct_paid_p50 number(16,2),
        specificity number(10),
	adj_ovrhd_pct_ids varchar2(100),
	ofc_ovrhd_pct_ids varchar2(100),
	pct_paid_pct_ids varchar2(100),
	odc_pct_ids varchar2(100),
	company_ovrhd_pct_ids varchar2(100),
	company_odc_pct_ids varchar2(100),
        company_pct_paid_ids varchar2(100))
	tablespace tsmlarge 
	pctused 60 pctfree 5;

Alter table g50_pap_overhead add constraint g50_pap_overhead_pk
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 5;

Alter table g50_pap_overhead add constraint g50_po_affiliation_check 
	check (affiliation in ('Affiliated','Unaffiliated','Both','AllSites'));

Alter table g50_pap_overhead add constraint
	g50_pap_overhead_uq1 
	unique(country_id,affiliation,indmap_id,phase_id)
	using index tablespace tsmlarge_indx pctfree 5;


CREATE TABLE INDUSTRY_PAP_ODC_COST(
	ID NUMBER(10),
	COUNTRY_ID NUMBER(10),
	INDMAP_ID NUMBER(10) NOT NULL,
	PHASE_ID NUMBER(10) NOT NULL,
	MAPPER_ID NUMBER(10),
	PRICE_TYPE VARCHAR2(6) NOT NULL,
	PRICE_P25 NUMBER(16,2),
	PRICE_P50 NUMBER(16,2),
	PRICE_P75 NUMBER(16,2),
	SPECIFICITY NUMBER(10),
	YEAR NUMBER(10),
	USED_CNT NUMBER(10),
	UNUSED_CNT NUMBER(5),
	Num_companies NUMBER(10),
	Entry_year NUMBER(10),
	pct_ids varchar2(100))
	tablespace tsmlarge 
	pctused 60 pctfree 5;

Alter table INDUSTRY_PAP_ODC_COST add constraint INDUSTRY_PAP_ODC_COST_pk
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 5;

Alter table INDUSTRY_PAP_ODC_COST add constraint IPOC_price_type_check 
	check (PRICE_TYPE in ('CPP','VISIT','GLOBAL'));

CREATE TABLE COMPANY_PAP_ODC_COST(
	ID NUMBER(10,0) NOT NULL,
	COUNTRY_ID NUMBER(10,0),
	INDMAP_ID NUMBER(10,0) NOT NULL,
	PHASE_ID NUMBER(10,0) NOT NULL,
	MAPPER_ID NUMBER(10,0),
	PRICE_TYPE VARCHAR2(6) NOT NULL,
	PRICE_P50 NUMBER(16,2),
	SPECIFICITY NUMBER(10),
	YEAR NUMBER(10),
	USED_CNT NUMBER(10),
	UNUSED_CNT NUMBER(5),
	price_p25 NUMBER(16,2),
    	price_p75 NUMBER(16,2),
	pct_ids varchar2(100))
	tablespace tsmlarge 
	pctused 60 pctfree 5;

Alter table COMPANY_PAP_ODC_COST add constraint COMPANY_PAP_ODC_COST_pk
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 5;


Alter table COMPANY_PAP_ODC_COST add constraint CPOC_price_type_check 
	check (PRICE_TYPE in ('CPP','VISIT','GLOBAL'));

CREATE TABLE G50_COMPANY_PAP_ODC_COST(
	ID NUMBER(10,0) NOT NULL,
	COUNTRY_ID NUMBER(10,0),
	INDMAP_ID NUMBER(10,0) NOT NULL,
	PHASE_ID NUMBER(10,0) NOT NULL,
	MAPPER_ID NUMBER(10,0),
	PRICE_TYPE VARCHAR2(6) NOT NULL,
	PRICE_P50 NUMBER(16,2),
	SPECIFICITY NUMBER(10),
	YEAR NUMBER(10),
	USED_CNT NUMBER(10),
	UNUSED_CNT NUMBER(5),
	price_p25 NUMBER(16,2),
    	price_p75 NUMBER(16,2),
	pct_ids varchar2(100))
	tablespace tsmlarge 
	pctused 60 pctfree 5;

Alter table G50_COMPANY_PAP_ODC_COST add constraint G50_COMPANY_PAP_ODC_COST_pk
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 5;


Alter table G50_COMPANY_PAP_ODC_COST add constraint GCPOC_price_type_check 
	check (PRICE_TYPE in ('CPP','VISIT','GLOBAL'));

Create table pap_Institution_odc_cost(
	id number(10),
	Institution_id number(10),
	mapper_id number(10),
	pct50 number(16,2),
	price_type varchar2(10),
	pct_ids varchar2(100))
	tablespace tsmlarge 
	pctused 60 pctfree 5;

Alter table pap_Institution_odc_cost add constraint pap_Institution_odc_cost_pk
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 5;

Alter table pap_institution_odc_cost add constraint
	pap_institution_odc_cost_uq1 
	unique(institution_id,mapper_id)
	using index tablespace tsmlarge_indx pctfree 5;

Alter table pap_institution_odc_cost add constraint pioc_price_type_check 
	check( price_type in ('CPP', 'VISIT', 'GLOBAL' ));


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
	pctused 60 pctfree 5;

Alter table data_by_year add constraint data_by_year_pk
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 5;


create table databld_run (
	id 	      	 NUMBER(10)  NOT NULL,
	run_date	 DATE          NOT NULL,
	tables   	 VARCHAR2(100) NOT NULL)
	tablespace tsmlarge
	pctused 60 pctfree 5;

Alter table databld_run add constraint databld_run_pk
  	primary key(id) using index tablespace
	tsmlarge_indx pctfree 5;


create table databld_run_prop (
 	id	  	     NUMBER(10)  NOT NULL,
	databld_run_id       NUMBER(10)  NOT NULL,
	prop_name 	     VARCHAR2(50)  NOT NULL,
	prop_val   	     VARCHAR2(100) NOT NULL)
	tablespace tsmlarge
	pctused 60 pctfree 5;

Alter table databld_run_prop add constraint databld_run_prop_pk
	primary key(id) using index tablespace 
	tsmlarge_indx pctfree 5;

create table id_control (
	table_owner                                VARCHAR2(40) NOT NULL,
	table_name                                 VARCHAR2(40) NOT NULL,
	next_id                                    NUMBER(10) NOT NULL)
	tablespace tsmlarge
	pctused 60 pctfree 5;



create table own_investig(
ID		Number(10),
protocol_code	varchar2(50) not null,
Investig_code	varchar2(35) not null,
Country_Id	Number(10) not null,
Country_code	varchar2(3),
Country_name	varchar2(256),
Currency_id	Number(10) not null,
plan_Curr_id	Number(10),
institution_id	Number(10),
Phase		varchar2(30),
Phase_id	Number(10) not null,
Indmap_id	Number(10) not null,
Ind_desc	varchar2(256),
Ta_desc		varchar2(256),
Ta_indmap_id	Number(10) not null,
Drug		varchar2(50),
CPP		Number(16,2),
CPP_PLAN		Number(16,2),
CPV		Number(16,2),
CPV_PLAN		Number(16,2),
CppUS		Number(16,2),
CpvUS		Number(16,2),
Grant_date	Date,
Pct_paid	Number(6,2),
Build_code_id	Number(10) not null ,
adj_ovrhd_pct	Number(6,2),
Inst_name	varchar2(256),
Inst_country_id	Number(10),
Inst_country_name	varchar2(256),
Inst_zip_code	varchar2(32),
grant_total 	number(12),
state 		varchar2(30),
CITY 		varchar2(60), 
AFFILIATION 	varchar2(20))
tablespace tsmsmall pctfree 5;


Alter table Own_investig add constraint Own_investig_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 5;


create table 	own_protocol(
ID			Number(10),
Protocol_code		varchar2(50) not null,
Phase_id		Number(10) not null,
Phase			varchar2(35),
Ind_desc		varchar2(256),
Indmap_id		Number(10) not null,
Ta_indmap_id		Number(10) not null,
Ta_desc			varchar2(256),
Drug			varchar2(50),
overhead_pct		Number(4),
pct_paid		Number(4),
num_inv			Number(4),
CPPUS			Number(16,2),
CPVUS			Number(16,2),
CPP_PLAN			Number(16,2),
CPV_PLAN			Number(16,2),
plan_curr_id		Number(10),
Build_code_id		Number(10) not null)
tablespace tsmsmall pctfree 5;

Alter table Own_protocol add constraint Own_protocol_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 5;


create table 	own_site(
ID		Number(10),
institution_id	Number(10) NOT NULL,
name		varchar2(256),
Country_id	Number(10),
Country_name	varchar2(256),
Country_code	varchar2(10),
Zip_code	Character(32),
overhead_pct25  Number(4),
overhead_pct50  Number(4),
overhead_pct75  Number(4),
pct_paid	Number(4),
num_inv		Number(4),
CPPUS		Number(10,2),
CPvUS		Number(10,2),
CPP_plan		Number(10,2),
CPv_plan		Number(10,2),
plan_curr_id	Number(10),
latest_overhead		Number(4),
latest_ovrhead_date	Date,
Build_code_id	Number(10) not null,
state 		varchar2(30),
CITY 		varchar2(60), 
AFFILIATION 	varchar2(20))
tablespace tsmsmall pctfree 5;

Alter table own_site add constraint own_site_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 5;

create table 	own_procedure(
ID		Number(10),
currency_id	Number(10) not null,
mapper_id	Number(10) not null,
CPV		Number(16,2),
CpvUS		Number(16,2),
CPV_PLAN	Number(16,2),
protocol_CPV		Number(16,2),
protocol_CPV_US		Number(16,2),
Build_code_id	Number(10) not null,
Cpt_code	Character(80),
Long_desc	Character(256),
investig_code varchar2(35),
protocol_code varchar2(50),
plan_curr_id number(10))
tablespace tsmsmall pctfree 5;

Alter table own_procedure add constraint own_procedure_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 5;

create table 	own_odc(
ID		Number(10),
currency_id	Number(10) not null,
plan_curr_id	Number(10),
mapper_id	Number(10) not null,
CPP		Number(16,2),
CppUS		Number(16,2),
CPP_plan		Number(16,2),
protocol_CPP		Number(16,2),
protocol_CPP_US		Number(16,2),
CPV		Number(16,2),
CpvUS		Number(16,2),
CPV_plan		Number(16,2),
protocol_CPV		Number(16,2),
protocol_CPV_US		Number(16,2),
Build_code_id	Number(10) not null,
picas_code	varchar2(80),
Long_desc	varchar2(256),
investig_code varchar2(35),
protocol_code varchar2(50))
tablespace tsmsmall pctfree 5;

Alter table own_odc add constraint own_odc_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 5;

insert into id_control values ('tsm10', 'gm_trial_freq', 1);
commit;

insert into id_control values ('tsm10', 'gm_proc_freq', 1);
commit;

insert into id_control values ('tsm10', 'mapper', 1);
commit;

insert into id_control values ('tsm10', 'pap_institution_proc_cost', 1);
commit;

insert into id_control values ('tsm10', 'pap_overhead', 1);
commit;

insert into id_control values ('tsm10', 'institution_overhead', 1);
commit;

insert into id_control values ('tsm10', 'pap_clinical_proc_cost', 1);
commit;

insert into id_control values ('tsm10', 'ip_study_price', 1);
commit;

insert into id_control values ('tsm10', 'g50_pap_clinical_proc_cost', 1);
commit;

insert into id_control values ('tsm10', 'g50_ip_study_price', 1);
commit;

insert into id_control values ('tsm10', 'g50_pap_overhead', 1);
commit;

insert into id_control values ('tsm10', 'industry_pap_odc_cost', 1);
commit;

insert into id_control values ('tsm10', 'company_pap_odc_cost', 1);
commit;

insert into id_control values ('tsm10', 'g50_company_pap_odc_cost', 1);
commit;

insert into id_control values ('tsm10', 'pap_institution_odc_cost', 1);
commit;

insert into id_control values ('tsm10', 'data_by_year', 1);
commit;

insert into id_control values ('tsm10', 'databld_run', 1);
commit;

insert into id_control values ('tsm10', 'databld_run_prop', 1);
commit;

insert into id_control values ('tsm10', 'own_investig', 1);
commit;

insert into id_control values ('tsm10', 'own_protocol', 1);
commit;

insert into id_control values ('tsm10', 'own_site', 1);
commit;

insert into id_control values ('tsm10', 'own_procedure', 1);
commit;

insert into id_control values ('tsm10', 'own_odc', 1);
commit;

create or replace function 
increment_build_sequence(seq_name varchar2, increment_by number default 1)
return number is
pragma autonomous_transaction;
last_num number(10);
next_seq number(10);
alt_seq_stmt varchar2(256);
begin
select last_number into last_num from user_sequences where sequence_name=upper(seq_name);
next_seq:=last_num+increment_by;
alt_seq_stmt:='drop sequence '||seq_name;
execute immediate (alt_seq_stmt);
alt_seq_stmt:='create sequence '||seq_name||' start with '||next_seq;
execute immediate (alt_seq_stmt);
return(last_num);
end;
/


create or replace function Increment_sequence (seq_name in varchar2,
increment_by in number default 1)  return number is
pragma autonomous_transaction;

start_value number(10);

begin

select next_id into start_value from id_control where 
table_name = lower(substr(seq_name,1,length(seq_name)-4))
for update;

update id_control set next_id = next_id+increment_by where 
table_name = lower(substr(seq_name,1,length(seq_name)-4));

commit;
return(start_value);

end;
/

exit;


--------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  38   DevTSM    1.37        1/27/2009 1:22:28 PM Mahesh Pasupuleti As per
--       Changes by Phil.
--  37   DevTSM    1.36        2/27/2008 3:17:45 PM Debashish Mishra  
--  36   DevTSM    1.35        5/29/2007 2:58:46 PM Phil Servedio   Put back 2
--       columns in own_investig.
--  35   DevTSM    1.34        5/7/2007 2:34:29 PM  Debashish Mishra schema chnage
--       request from tonya on 05/07/2007
--  34   DevTSM    1.33        5/1/2007 4:54:31 PM  Debashish Mishra New GMOWN
--       columns
--  33   DevTSM    1.32        4/3/2007 3:05:14 PM  Debashish Mishra removed
--       own_search_set references
--  32   DevTSM    1.31        4/3/2007 2:04:08 PM  Debashish Mishra Updated for GM
--       OWN build
--  31   DevTSM    1.30        12/11/2006 10:55:04 AMDebashish Mishra  
--  30   DevTSM    1.29        11/2/2006 10:40:21 AMDebashish Mishra  
--  29   DevTSM    1.28        10/23/2006 2:32:34 PMDebashish Mishra  
--  28   DevTSM    1.27        10/23/2006 11:12:20 AMDebashish Mishra  
--  27   DevTSM    1.26        10/20/2006 1:42:46 PMDebashish Mishra  
--  26   DevTSM    1.25        10/10/2006 11:13:11 AMDebashish Mishra  
--  25   DevTSM    1.24        10/9/2006 1:57:24 PM Debashish Mishra  
--  24   DevTSM    1.23        10/6/2006 4:01:02 PM Debashish Mishra  
--  23   DevTSM    1.22        10/5/2006 1:19:01 PM Debashish Mishra  
--  22   DevTSM    1.21        9/19/2006 12:08:10 AMDebashish Mishra  removed
--       references to obsolete tables
--  21   DevTSM    1.20        7/13/2005 1:36:10 PM Debashish Mishra  
--  20   DevTSM    1.19        7/13/2005 10:12:55 AMDebashish Mishra added default
--       value to the increment_sequence
--  19   DevTSM    1.18        7/13/2005 9:43:07 AM Debashish Mishra New procedure
--       increment_build_sequence
--  18   DevTSM    1.17        5/24/2005 10:40:23 PMDebashish Mishra Added new
--       columns to (g50)&pap_clinical_proc_cost & (g50) company_pap_odc_cost
--  17   DevTSM    1.16        3/21/2005 7:20:21 AM Debashish Mishra Modified
--       pctfree of all tables
--  16   DevTSM    1.15        3/3/2005 6:33:31 AM  Debashish Mishra   
--  15   DevTSM    1.14        3/3/2005 6:32:22 AM  Debashish Mishra  
--  14   DevTSM    1.13        8/24/2004 9:21:40 AM Debashish Mishra New column
--       pap_clinical_proc_cost.num_companies
--  13   DevTSM    1.12        8/17/2004 9:18:31 AM Debashish Mishra Added
--       data_by_year.clin_type
--  12   DevTSM    1.11        8/16/2004 11:41:35 AMDebashish Mishra New columns
--       added and migration scripts are also updated.
--  11   DevTSM    1.10        8/16/2004 11:01:38 AMDebashish Mishra Added two new
--       columns to indistry_pap_odc_cost and one new column to
--       pap_clinical_proc_cost
--  10   DevTSM    1.9         8/11/2004 9:40:40 AM Debashish Mishra Added new
--       columns to g50_company_odc_cost and g50_pap_clinical_proc_cost 
--  9    DevTSM    1.8         8/11/2004 9:09:44 AM Debashish Mishra added new
--       columns to company_pap_odc_cost & industry_pap_odc_cost
--  8    DevTSM    1.7         8/4/2004 2:49:56 PM  Debashish Mishra updated
--       data_by_year table
--  7    DevTSM    1.6         8/2/2004 1:32:00 PM  Debashish Mishra new table
--       data_by_year
--  6    DevTSM    1.5         7/27/2004 9:22:07 AM Debashish Mishra made
--       level2_skip_flg column in pap_clin_proc_cost as default 0 not null
--  5    DevTSM    1.4         7/23/2004 3:16:32 AM Debashish Mishra Added
--       ft_foreign_key_info synonym and new columns in pap_clinical_proc_cost
--  4    DevTSM    1.3         3/3/2004 3:43:00 PM  Debashish Mishra Added
--       pap_institution_odc_cost.price_type
--  3    DevTSM    1.2         3/3/2004 10:55:00 AM Debashish Mishra Added new
--       table pap_institution_odc_cost
--  2    DevTSM    1.1         7/2/2003 5:43:13 PM  Debashish Mishra  
--  1    DevTSM    1.0         6/13/2003 8:02:43 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
