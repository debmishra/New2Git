--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tsm10_tables.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:11 PM$
--
--
-- Description:  Create tables in tsm10 schema
--
---------------------------------------------------------------------


Create table currency (
	ID number(10),
	NAME varchar2(40),
	Symbol varchar2(5),
	cnv_rate number(12,4),
	viewable_flg number(1) default 0 not null)
	tablespace tsmsmall
	pctused 60 pctfree 25;

Create table country(
	ID number(10),
	Name varchar2(80),
	abbreviation varchar2(3),
	country_level number(1) default 2 not null,
	currency_id number(10),
	country_search_id number(10),
	virtual_flg number(1) default 0 not null,
	is_viewable number(1) default 0 not null,
	fte_hours_month number(4,1) default 160,
	iso_country varchar2(2),
	parent_country_id number(10),
	geo_location varchar2(20))
	tablespace tsmsmall 
	pctused 60 pctfree 25;


Create table phase(
	ID number(10),
	short_desc varchar2(128),
	sequence number(4))
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table Indmap(
	ID number(10),
	Parent_indmap_id number(10),
	code varchar2(80),
	short_desc varchar2(256),
	Type varchar2(40),
	Execution_type varchar2(80),
	Execution_ind_id number(10))
	tablespace tsmsmall 
	pctused 60 pctfree 25;


Create table IP_duration_factor(
	ID number(10),
	Country_id number(10) not null,
	Phase2_factor number(10,5),
	Phase3_factor number(10,5),
	Y3Phase2_factor number(10,5),
	Y3Phase3_factor number(10,5))
	tablespace tsmsmall 
	pctused 60 pctfree 25;


Create table Affiliation_factor(
	ID number(10),
	Country_id number(10) not null,
	indmap_id number(10),
	type varchar2(10),
	Affiliated_factor number(10,5),
	Unaffiliated_factor number(10,5))
	tablespace tsmsmall 
	pctused 60 pctfree 25;


Create table PAP_euro_overhead(
	id number(10),
	country_id number(10) not null,
	adjusted_flg number(1) default 0 not null,
	pct25 number(12,2),
	pct50 number(12,2),
	pct75 number(12,2),
	region_id number(10))
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table IP_duration(
	ID number(10),
	phase_id number(10),
	indmap_id number(10) not null,
	low1year number(12,2),
	mid1year number(12,2),
	high1year number(12,2),
	low2year number(12,2),
	mid2year number(12,2),
	high2year number(12,2),
	low3year number(12,2),
	mid3year number(12,2),
	high3year number(12,2))
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table IP_weight(
	id number(10),
	country_id number(10) not null,
	phase_id number(10) not null,
	indmap_id number(10) not null,
	Affiliation varchar2(20),
	complex_minvalue number(12,2),
	factor number(10,5) not null,
	minvalue number(12,2) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table IP_cpp(
	id number(10),
	phase_id number(10) not null,
	indmap_id number(10) not null,
	low number(12,2),
	mid number(12,2),
	high number(12,2),
	slope number(12,2),
	intercept number(12,2),
	clow number(12,2),
	cmid number(12,2),	 
	chigh number(12,2),
	cslope number(12,2),
	cintercept number(12,2),
	olow number(12,2),
	omid number(12,2),	 
	ohigh number(12,2),
	oslope number(12,2),
	ointercept number(12,2),
	cpv number(12,2),
	patient_status varchar2(20))
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table IP_Business_factors(
	id number(10),
	Type varchar2(40) not null,
	IBF_Order number(3),
	Factor number(10,5) not null,
	Short_desc varchar2(80),
	low number(10,6),
	med number(10,6),
	high number(10,6),
	num_days number(5))
	tablespace tsmsmall 
	pctused 60 pctfree 25;


Create table procedure_def(
	id number(10),
	cpt_code varchar2(80) not null,
	long_desc varchar2(256),
	obsolete_flg number(1) default 0 not null,
	procedure_level varchar2(20) not null,		
	obsolete_build_tag_id  number(10),
	added_build_tag_id  number(10),
        hide number(1) default 0 not null,
	foxpro_flg number(1) default 1 not null,
	short_desc varchar2(256))
	tablespace tsmsmall 
	pctused 60 pctfree 25;


Create table region(
	id number(10),
        country_id number(10) not null,
	Abbreviation varchar2(40),
	type varchar2(40) not null,
	name varchar2(128),
	Factor number(10,5) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;


Create table Institution(
	id number(10),
	country_id number(10) not null,
	region_id number(10),
	name varchar2(256),
	zip_code varchar2(32),
	Abbreviation varchar2(30),
	InstAddr1 varchar2(128),
	InstAddr2 varchar2(128),
	InstAddr3 varchar2(128),
	Affiliation varchar2(20),
	City varchar2(60),
	County varchar2(60),
	Comments varchar2(256),
	Fax varchar2(50),
	Phone varchar2(50),
	PoBox varchar2(35),
	Prov_Terr varchar2(50),
	Queriable number(1) default 0 not null,
	Umbrella_flg number(1) default 0 not null,
	TimesUsed number(4),
        burden_pct number(12,2) default 0)
	tablespace tsmsmall 
	pctused 60 pctfree 25;

create table odc_def(
	id number(10),
	Picas_code varchar2(80) not null,
	long_desc varchar2(256),
	obsolete_flg number(1) default 0 not null,
	procedure_level varchar2(20) not null,
	hide number(1) default 0 not null,		
	obsolete_build_tag_id  number(10),
	added_build_tag_id  number(10),
	foxpro_flg number(1) default 1 not null,
	short_desc varchar2(256))
	tablespace tsmsmall 
	pctused 60 pctfree 25;


Create table mapper(
	id number(10),
	odc_def_id number(10),
	Procedure_def_id number(10))
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table build_tag(
	id number(10),
	tag_date date not null,
	comments varchar2(256))
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table client_div(
	ID number(10),
	client_ID number(10) not null,
	name varchar2(128) not null,
	def_country_ID number(10) not null,
	def_plan_currency_ID number(10) not null,
	def_overhead_pct number(12,2),
	def_budget_type varchar2(40) not null,
	client_div_identifier varchar2(20) not null,
	starting_view varchar2(20),
	country_id number(10),
	build_tag_id number(10),
	use_own_cnv_flg number(1) default 0 not null,
	def_price_range varchar2(20) default 'Med' not null,
	logon_timeout_secs number(5) default 0 not null,
	iso_lang varchar2(2),
	using_webstart NUMBER(1) default 1 not null,
	g50_col_enabled number(1) default 0 not null,
	g50_hdng varchar2(5),
	g50_spec_hdng varchar2(5),
	g50_pcklst_desc	varchar2(10),
	allow_create_unlisted number (1) default 0 not null,
	tspd_build_tag_id NUMBER(10),
	def_input_pref varchar2(40) default 'Entering',
	messaging_opt number(1) default 1 not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table client_group(
	ID number(10),
	client_div_ID number(10) not null,
	name varchar2(80) not null,
        long_desc varchar2(255))
	tablespace tsmsmall 
	pctused 60 pctfree 25;


Create table build_tag_to_client_div(
	id number(10),
	client_div_id number(10) not null,
	build_tag_id number(10) not null,
	released number(1) default 0 not null,
	released_date date,	
	released_ftuser_id number(10))
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table client_div_to_lic_country(
	id number(10),
	client_div_id number(10) not null,
	country_id number(10) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table client_currency_cnv(
	id number(10),
	client_div_id number(10) not null,
	to_currency_id number(10) not null,
	conversion_rate number(10,5),
	conversion_date date not null,
	to_currency_symbol varchar2(20))
	tablespace tsmsmall 
	pctused 60 pctfree 25;


Create table custom_set(
	id number(10),
	name varchar2(80) not null,
	create_dt date not null,
	client_div_id number(10) not null,
	type varchar2(10) not null,
	ftuser_id number(10) not null,
	VERSION_TIMESTAMP NUMBER(10) default 1)
	tablespace tsmsmall 
	pctused 60 pctfree 25;


Create table def_publish_groups(
	id number(10),
	PUBLISHING_CLIENT_GROUP_ID number(10) not null,
        PUBLISH_TO_CLIENT_GROUP_ID number(10) not null,
        RW_FLG number(1) default 0 not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;


Create table location_set(
	id number(10),
	client_div_id number(10) not null,
	creator_id number(10) not null,
	create_dt date not null,
	name varchar2(80),
	IS_ANONYMOUS number(1) default 0 not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;


Create table location_set_item(
	id number(10),
	location_set_id number(10) not null,
	region_id number(10),
	country_id number(10) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;


Create table project_area(
	id number(10),
	client_div_id number(10) not null,
	name varchar2(128) not null,
	archived_flg number(1) default 0 not null,
	archived_date date,
	tsm_default number(1) default 0 not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;


Create table project(
	id number(10),
	name varchar2(128) not null,
	archived_flg number(1) default 0 not null,
	archived_date date,
	client_id number(10) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table trial_budget(
	ID number(10),
	country_ID number(10) not null,
	region_ID number(10),
	institution_ID number(10),
	trial_ID number(10) not null,
	creator_ftuser_ID number(10) not null,
	client_group_ID number(10) ,
	locking_FTUser_ID number(10),
	affiliation varchar2(20) not null,
	overhead_pct number(12,2),
	odc_pct number(12,2),
	specify_ODC_flg  number(1) default 0 not null,
	initial_payment_pct number(12,2),
	num_sites number(4),
	num_patients number (6),
	screen_failure_pct number(12,2),
	create_date date not null,
	parent_trial_budget_id number(10),
	sequence number(4),
	currency_id number(10),
	overhead_type varchar2(20),
	lock_date date,
	build_tag_id number(10),
	avg_cpp_low number(10),
	avg_cpp_med number(10),
	avg_cpp_high number(10),
	avg_cpp_company number(10),
	avg_cpp_selected number(10),
	total_cost number(10),
	adjusted_overhead_pct number(3),
	odc_pct_range varchar2(20),
	total_cost_local number(10),
	avg_cpp_selected_local number(10),
	is_published number(1) default 0 not null,
	USE_OH_IN_SCREEN_FAILURES  NUMBER (1) default 1 not null,
	ODC_PCT_USE_OH_FLG number(1) default 1 not null,
	OVERHEAD_PCT_RANGE varchar2(20) not null,
	DROPOUT_RATE_PCT NUMBER(12,2) default 0 not null,
	cpp_modeled  NUMBER(10),
	use_modeled_price number(1) default 0 not null,
	modeled_odc_pct number(12,2),
	modeled_oh_pct number(12,2),
	modeled_odc_pct_range varchar2(40),   
	modeled_oh_type varchar2(40),
	avg_cpp_g50 number(10),
	num_entered_patients number(6),
	num_enrolled_patients number(6),
	total_cost_pvb number(10),
	total_cost_pvb_local number(10),
	local_currency_id number(10))
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table tsm_message(
	ID number(10),
	message_text varchar2(1024),
	creator_ftuser_ID number(10) not null,
	addressee_ftuser_ID number(10) not null,
	message_date date not null,
	dismissed_flg number(1) default 0 not null,
	seen_flg number(1) default 0 not null,
	message_header varchar2(128) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table umbrella_orgs(
	ID number(10),
	covered_org_id number(10) not null,
	umbrella_org_id number(10) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table unlisted_procedure(
	ID number(10),
	name varchar2(128) not null,
	long_desc varchar2(1024),
	type varchar2(10) not null,
	obsolete_flg number(1) default 0 not null,
	obsolete_date date,
	price number(12,2),
	currency_ID number(10) not null,
	client_id number(10) not null,
	procedure_level varchar2(20),
	VERSION_TIMESTAMP NUMBER(10) default 1,
	low number(12,2),
	mid number(12,2),
	high number(12,2),
	delete_flg number(1))
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table ftuser_to_client_group(
	ID number(10),
	client_group_id number(10) not null,
	ftuser_id number(10) not null,
	dflt_group number(1))
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table budget_group_permission(
	ID number(10),
	trial_budget_id number(10) not null,
	client_group_id number(10) not null,
	rw_flg number(1) default 0 not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table budget_user_permission(
	ID number(10),
	trial_budget_id number(10) not null,
	ftuser_id number(10) not null,
	rw_flg number(1) default 0 not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table custom_set_item(
	ID number(10),
	custom_set_id number(10) not null,
	unlisted_procedure_id number(10),
	odc_def_id number(10),
	procedure_def_id number(10),
	price number(12,2),
	short_desc varchar2(128),
	long_desc varchar2(1024))
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table picas_visit(
	ID number(10),
	trial_budget_ID number(10),
	visit_order number(4) not null,
	name varchar2(256) not null,
	offset_from_induction number(5),
	offset_units varchar2(1) not null,
	visit_type varchar2(40) not null,
	num_patients number(6),
	trial_phase varchar2(40) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table cost_item(
	ID number(10),
	trial_budget_ID number(10) not null,
	unlisted_procedure_ID number(10),
	frequency number(12,2),
	overhead_pct number(1) default 0 not null,
	price number(12,2),
	odc_def_id number(10),
	procedure_def_id number(10),
	price_range varchar2(20) default 'Med' not null,
	display_order number(3),
	temp_id number(10),
	required_specificity varchar2(10) default 'GSP' not null,
	priced_specificity varchar2(10),
	screening_quantity number(12,2),
	required_co_specificity VARCHAR2(10) default 'GSP' not null,
	priced_co_specificity VARCHAR2(10),
	required_g50_specificity VARCHAR2(10) default 'GSP' not null,
	priced_g50_specificity VARCHAR2(10))
	tablespace tsmlarge 
	pctused 60 pctfree 25;


create table protocol( 
	ID number(10),
	COUNTRY_ID number(10) not null,
	DE_INTERNAL_ID varchar2(20),
	PICAS_PROTOCOL varchar2(50),
	COMMENTS varchar2(256),
	PHASE_ID number(10) not null,
	PHASE1TYPE_ID number(10),
	DOSING varchar2(1),
	INPATIENT_STATUS varchar2(20),
	AGE_RANGE varchar2(20),
	INPATIENT_DAYS number(5),
	TOTAL_CONFINEMENT number(5),
	HOURS_CONFINED number(5),
	ADMIN_ROUTE varchar2(1),
	TOTAL_VISIT number(5),
	STUDY_TYPE varchar2(40),
	STUDY_BLIND_TYPE varchar2(40),
	DURATION number(5),
	DURATION_UNIT varchar2(1),
	CENTRAL_LAB_USED number(1),
	ENTRY_DATE date,
	ACTIVE_FLAG number(1) default 0 not null,
	COMPLETED_PATIENTS number(5),
	RANDOMIZED_FLAG varchar2(1),
	TREATMENT_CYCLE_CNT number(5),
	STUDY_STRUCT_TYPE varchar2(40),
	NUM_TREATMENTS number(5),
	SCREEN_DAYS number(5),
	GROUP1_PRETREAT_DAYS number(5),
	GROUP1_TREAT_DAYS number(5),
	GROUP1_POST_TREAT_DAYS number(5),
	GROUP2_TREAT_DAYS number(5),
	GROUP2_POST_TREAT_DAYS number(5),
	GROUP3_TREAT_DAYS number(5),
	GROUP3_POST_TREAT_DAYS number(5),
	GROUP4_TREAT_DAYS number(5),
	GROUP4_POST_TREAT_DAYS number(5),
	GROUP5_TREAT_DAYS number(5),
	GROUP5_POST_TREAT_DAYS number(5),
	GROUP6_TREAT_DAYS number(5),
	GROUP6_POST_TREAT_DAYS number(5),
	GROUP7_TREAT_DAYS number(5),
	GROUP7_POST_TREAT_DAYS number(5),
	GROUP8_TREAT_DAYS number(5),
	GROUP8_POST_TREAT_DAYS number(5),
	GROUP9_TREAT_DAYS number(5),
	GROUP9_POST_TREAT_DAYS number(5),
	GROUPA_TREAT_DAYS number(5),
	GROUPA_POST_TREAT_DAYS number(5),
	GROUP1_EXTENSION_EXISTS number(1),
	GROUP2_EXTENSION_EXISTS number(1),
	GROUP3_EXTENSION_EXISTS number(1),
	GROUP4_EXTENSION_EXISTS number(1),
	GROUP5_EXTENSION_EXISTS number(1),
	GROUP6_EXTENSION_EXISTS number(1),
	GROUP7_EXTENSION_EXISTS number(1),
	GROUP8_EXTENSION_EXISTS number(1),
	GROUP9_EXTENSION_EXISTS number(1),
	GROUPA_EXTENSION_EXISTS number(1),
	CENT_LAB_CONTRACT_EXISTS number(1),
	CRO_LAB_CONTRACT_EXISTS number(1),
	CENT_LAB_PRICE_MODEL varchar2(1),
	EXTENSION_EXISTS number(1),
	TREATMENT_CONTROL varchar2(40),
	build_code_id number(10) not null,
	protocol_family_id varchar2(64),
	collection_country_id number(10),
	same_as_prot number(1),
	title varchar2(4000),
	earliest_grant_date date)
	tablespace tsmlarge 
	pctused 60 pctfree 25;



Create table protocol_to_indmap(
	id number(10),
	protocol_id number(10) not null,
	indmap_id number(10) not null,
	primary_flg number(1))
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table Investig(
	ID number(10),
	PROTOCOL_ID number(10) not null,
	TOTAL_PAYMENT number(12,2),
	OTHER_FEE number(12,2),
	OVERHEAD number(12,2),
	IRB_FEE number(12,2),
	FIXED_FEE number(12,2),
	DROPPED_PAT_FEE number(12,2),
	DROPPED_PATIENTS number(5),
	FAILURE_FEE number(12,2),
	FAILED_PATIENTS number(5),
	GRANT_ADJUSTMENT number(12,2),
	GRANT_ADJUST_CODE varchar2(20),
	LAB_COST number(12,2),
	GRANT_TOTAL number(12,2),
	COUNTRY_ID number(10) not null,
	AFFILIATION varchar2(20),
	ZIP_CODE varchar2(20),
	REGION_ID number(10),
	METRO_REGION_ID number(10),
	STATE_REGION_ID number(10),
	PATIENTS number(5),
	PCT_PAID number(12,2),
	GRANT_DATE DATE,
	OVERHEAD_BASIS varchar2(1),
	OVERHEAD_PCT number(12,2),
	PRIMARY_FLAG number(1) default 0 not null,
	CRO_USED number(1),
	adj_ovrhd_pct number(12,2),
	adj_other_pct number(12,2),
	burden_pct number(12,2),
	institution_id number(10),
	region varchar2(10),
	metro varchar2(10),
	state varchar2(10),
	investigator_code varchar2(35),
	payment_country_id number(10),
	build_code_id number(10) not null,
	no_pay number(8),
	no_proc number(8),
	INCOMPLETE number(1),
	sampled number(1),
	managed number(1),
	facility varchar2(40))
	tablespace tsmlarge 
	pctused 60 pctfree 25;

Create table medicare(
	id number(10),
	country_id number(10),
	mdicare_proc Varchar2(5),
	mmedium number(5),
	PICAS NUMBER(1) default 0 not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;


create table pap_odc_pct(
	id number(10),
	country_id number(10),
	BASE_PCT number(7,2),
	AFFILIATED_PCT number(7,2),
	UNAFFILIATED_PCT number(7,2),
	AFF_UNAFF_PCT number(7,2),
	PHASE_ONE_PCT number(7,2),
	PHASE_TWOTHREE_PCT number(7,2),
	PHASE_FOUR_PCT number(7,2),
	PHASE_ALL_PCT number(7,2))
	tablespace tsmsmall 
	pctused 60 pctfree 25;

create table pap_odc_pct_to_indmap(
	id number(10),
	pap_odc_pct_id number(10),
	indmap_id number(10),
	indmap_pct number(7,2))
	tablespace tsmsmall 
	pctused 60 pctfree 25;

create table payments(
	id number(10),
	procedure_code varchar2(80) not null,
	payment number(12,2),
	type varchar2(10) not null,
	odc_def_id number(10),
	procedure_def_id number(10),
	payment_country_id number(10) not null,
	investig_id number(10) not null,
	outlier_cd number(1) default 0 not null,
	CHECKED varchar2(20))
	tablespace tsmlarge 
	pctused 60 pctfree 25;


Create table price_level(
	id number(10),
	country_id number(10),
	type varchar2(10),
	low_price number(12,2),
	med_price number(12,2),
	high_price number(12,2),
	odc_def_id number(10),
	procedure_def_id number(10),
	plist number(16,4))
	tablespace tsmsmall 
	pctused 60 pctfree 25;


Create table procedure_to_protocol(
	id number(10),
	protocol_id number(10) not null,
	times_performed number(7,2),
	central_lab_used number(1) ,
	investigator_times_perf number(7,2),
	type varchar2(10),
	odc_def_id number(10),
	procedure_def_id number(10),
	build_code_id number(10) not null)
	tablespace tsmlarge 
	pctused 60 pctfree 25;

Create table report_template(
	id number(10),
	odc_def_id number(10),
	indmap_id number(10),
	phase_id number(10))
	tablespace tsmsmall 
	pctused 60 pctfree 25;



Create table picas_visit_to_cost_item(
	id number(10),
	cost_item_id number(10),
	picas_visit_id number(10) not null,
	frequency number(12,2) not null,
	temp_cost_item_id number(10))
	tablespace tsmsmall
	pctused 60 pctfree 25;

create table ip_session(
	id number(10),
	study_type_id number(10),
	study_population_id number(10),
	country_id number(10),
	location_set_id number(10) ,
	site_type_id number(10),
	age_range_id number(10),
	affiliation varchar2(20) default 'Both',
	phase_id number(10),
	indmap_id number(10),
	project_id number(10),
	cost_per_visit number(12,2),
	cost_per_patient number(12,2),
	creator_ftuser_id number(10),
	ip_session_name varchar2(256),
	num_patients number(6),
	archived_flg number(1) default 0 not null,
        treatment_time_id number(10),
	inpatient_status_id number(10),
	study_duration_id number(10),
	client_id number(10), 
	client_div_id number(10), 
	project_area_id number(10),
	comments varchar2(4000),
	factor VARCHAR2(30),
	pricing VARCHAR2(10))
	tablespace tsmsmall
	pctused 60 pctfree 25;


Create table tsm_trial_rollup(
	ID NUMBER(10),
	TRIAL_ID NUMBER(10) NOT NULL,
	COST_PER_PATIENT number(12,2),	
	COST_PER_VISIT number(12,2),	
	TOTAL_COST number(12,2),
	num_sites number(4),
	num_patients number(6),
	total_cost_pvb number(10))
	tablespace tsmsmall
	pctused 60 pctfree 25;	


create table temp_procedure(
	id number(10),
	indmap_id number(10),
	country_id number(10),
	currency_id number(10),
	grant_date date,
	payment number(16,2),
	phase_id number(10),
	mapper_id number(10),
	institution_id number(10),
	build_code_id number(10) not null,
	primary_flg number(1) default 0 not null,
	ta_indmap_id number(10),
	indgroup_indmap_id number(10),
	active_flg number(1) default 0 not null,
	payments_id number(10),
	entry_date date,
	Primary_indication_flg number(1) default 1 not null)
	tablespace tsmsmall
	pctused 60 pctfree 25;	


Create table temp_odc(
	id number(10),
	active_flg number(1) default 0 not null,
	indmap_id number(10),
	country_id number(10),
	protocol_id number(10),
	currency_id number(10),
	cpp number(16,2),
	cpv number(16,2),
	cpgv number(16,2),
	institution_id number(10),
	payment number(16,2),
	phase_id number(10),
	mapper_id number(10),
	build_code_id number(10) not null,
	ta_indmap_id number(10),
	indgroup_indmap_id number(10),
	payments_id number(10))
	tablespace tsmsmall
	pctused 60 pctfree 25;	

	
Create table temp_overhead(
	id number(10),
	adj_other_pct number(16,2),
	adj_ovrhd_pct number(16,2),
	affiliation varchar2(20),
	indmap_id number(10),
	country_id number(10),
	protocol_id number(10),
	grant_date date,
	institution_id number(10),
	ovrhd_basis varchar2(80),
	ovrhd_pct number(16,2),
	pct_paid number(16,2),
	phase_id number(10),
	zip_code varchar2(20),
	build_code_id number(10) not null,
	adj18mo_flg number(1) default 0 not null,
	primary_flg number(1) default 0 not null,
	ta_indmap_id number(10),
	indgroup_indmap_id number(10),
	active_flg number(1) default 0 not null,
	investig_id number(10))
	tablespace tsmsmall
	pctused 60 pctfree 25;	

Create table temp_inst_to_company(
	id number(10),
	institution_id number(10),
	build_code_id number(10) not null,
	phase_id number(10),
	ta_indmap_id number(10), 
	country_id number(10))
	tablespace tsmsmall
	pctused 60 pctfree 25;	

create table temp_ip_study_price (
	id number(10),
	indmap_id number(10),
	country_id number(10),
	cpp number(16,2),
	cpv number(16,2),
	phase_id number(10),
	build_code_id number(10) not null,
	ta_indmap_id number(10),
	indgroup_indmap_id number(10),
	investig_id number(10),
	active_flg number(1) default 0 not null,
	phase1type_ID number(10))
	tablespace tsmsmall
	pctused 60 pctfree 25;

Create table local_to_euro (
	id number(10),	
	country_id number(10),
	cnv_rate_to_euro number(10,4))
	tablespace tsmsmall
	pctused 60 pctfree 25;

create table client_div_to_lic_phase(
	id number(10),
	client_div_id number(10) not null,
	phase_id number(10) not null)
	tablespace tsmsmall
	pctused 60 pctfree 25;

Create table client_div_to_lic_indmap(
	id number(10),
	client_div_id number(10) not null,
	indmap_id number(10) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table build_code(
	id number(10),	
	code varchar2(4),	
	name varchar2(128))
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table client_div_to_build_code(
	id number(10),
	client_div_id number(10) not null,
	build_code_id number(10) not null,
	primary_flg number(1) default 1 not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;

create or replace view indmap_de_view
	as select a.code Ther_area, b.code ind_group, c.code indication, 
	decode(c.short_desc,null,b.short_desc,c.short_desc) short_desc from
	(select id,code,short_desc from indmap where type='Therapeutic Area') a, 
	(select id,parent_indmap_id,code,short_desc from indmap where type='Indication Group') b, 
	(select id,parent_indmap_id,code,short_desc from indmap where type='Indication') c where
	c.parent_indmap_id(+) = b.id and
	b.parent_indmap_id = a.id order by a.code,b.code,c.code;

CREATE TABLE PICAS_VISIT_SET(
	ID NUMBER(10,0) NOT NULL,
	CLIENT_DIV_ID NUMBER(10,0) NOT NULL,
	CREATOR_ID NUMBER(10,0) NOT NULL,
	CREATE_DT DATE NOT NULL,
	NAME VARCHAR2(80))
	tablespace tsmsmall
	pctused 60 pctfree 25;


CREATE TABLE PICAS_VISIT_SET_ITEM(
	ID NUMBER(10) NOT NULL,
	PICAS_VISIT_SET_ID NUMBER(10) NOT NULL,
        VISIT_ORDER NUMBER(4) NOT NULL,
	NAME VARCHAR2(256) NOT NULL,
	OFFSET_FROM_INDUCTION NUMBER(5),
	OFFSET_UNITS VARCHAR2(1) NOT NULL,
	VISIT_TYPE VARCHAR2(40) NOT NULL,
	NUM_PATIENTS NUMBER(6),
	TRIAL_PHASE VARCHAR2(40) NOT NULL)
	tablespace tsmsmall
	pctused 60 pctfree 25;


CREATE TABLE working_trial (
	id NUMBER(10),
	trial_id number(10),
	ftuser_id number(10),
        working_trial blob)
        tablespace tsmsmall 
        pctused 80 pctfree 10  
        lob (working_trial) STORE AS working_trial_blob (
	TABLESPACE trialblob 
	disable storage in row
	CHUNK 16k 
        PCTVERSION 20 
        NOCACHE LOGGING); 


CREATE TABLE SPECIFICITY
	(ID NUMBER(10,0) NOT NULL,
	SPECIFICITY CHAR(4) not null)
	tablespace tsmsmall
	pctused 60 pctfree 25;



Create table picase_trial(
	Trial_ID	NUMBER(10) not null,
	ARCHIVED_DATE	DATE,
	ARCHIVED_BY_ID	NUMBER(10),
	ARCHIVED_FLG	NUMBER(1) default 0 not null,
	CREATOR_FTUSER_ID	NUMBER(10),
	CREATE_DATE	DATE,
	BUDGET_TYPE	VARCHAR2(40),
	PUBLISH_DATE	DATE,
	PRICE_CMP_PHASE_ID NUMBER(10),
	publish_client_group_id number(10),
	study_duration_id number(10),
	inpatient_status_id number(10),
   	price_cmp_indmap_id number(10,0))
	tablespace tsmsmall 
	pctused 60 pctfree 25;



Create table odc_def_mapper (
	odc_def_id number(10) not null,
	parent_odc_def_id number(10) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;


Create table add_study(
	id number(10),
	country_id number(10),
	odc_def_id number(10),
	payment_country_id number(10),
	pct25 number(5),
	pct50 number(5),
	pct75 number(5))
	tablespace tsmsmall 
	pctused 60 pctfree 25;


Create table data_load_history(
	table_name varchar2(30) not null,
	load_date date default sysdate not null,
	num_inserted number(10),
	num_updated number(10))
	tablespace tsmsmall
	pctused 70 pctfree 15;


Create table audit_hist(
	id number(10),
	modify_date date not null,
	ftuser_id number(10) not null,
	comments varchar2(4000),
	app_type varchar2(50) not null,
	action varchar2(50) not null,
	target_name varchar2(50),
	target_primary_table varchar2(50) not null,
	target_id number(10) not null,
	entity_type varchar2(50) not null,
	entity_id number(10) not null,
	start_date date,
	tspd_role varchar2(50))
	tablespace tsmlarge pctused 60 pctfree 20;


Create table client_div_to_lic_app(
	id number(10),
	client_div_id number(10),
	app_name varchar2(50),
	license_exp_date date,
	principal_contact_id  number(10),
	version varchar2(30),
	frontend_version  varchar2(30),
	patch_available NUMBER(1) default 0 not null,
	patch_version VARCHAR2(30),
	Alert_email varchar2(100))
	tablespace tsmsmall pctused 65 pctfree 20;

Create table User_Pref(
	ID number(10),
	ftuser_id number(10),
	app_type varchar2(50),  
	name  varchar2(50),
	value varchar2(50))
	tablespace tsmsmall pctused 65 pctfree 20;


create or replace view indmap_de_view as 
	select a.code Ther_area, b.code ind_group, c.code indication,
        decode(c.short_desc,null,b.short_desc,c.short_desc) short_desc from
        (select id,code,short_desc from indmap where type='Therapeutic Area') a,
        (select id,parent_indmap_id,code,short_desc from indmap where type='Indication Group') b,
        (select id,parent_indmap_id,code,short_desc from indmap where type='Indication') c where
        c.parent_indmap_id(+) = b.id and
        b.parent_indmap_id = a.id order by a.code,b.code,c.code;


create table modelled_coeff (
	id number (10),
	country_id number (10) not null,
	coeff_type varchar2(7) not null,
	coeff_value varchar2(20),
	cross_coeff_type varchar2(7),
	cross_coeff_value varchar2(20),
	coeff number(20,12))
	tablespace tsmsmall 
	pctused 60 pctfree 20;

Create table md_odc_oh_pct
	(id number (10),
	country_id number (10) not null, 
	ta_id number(10) not null, 
	oh_pct number(20,12) ,
	odc_pct number(20,12))
	tablespace tsmsmall 
	pctused 60 pctfree 20;

create table modelled_inclusion (
	id number (10),
 	coeff_type varchar2(7) not null,
	coeff_value varchar2(20))
	tablespace tsmsmall 
	pctused 60 pctfree 20;

Create table modelled_upfence(
	id number(10),
	country_id number(10) not null,
	ta_id number(10) not null,
	upfence number(20,12) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 20;

Create table modelled_standardize(
	id number(10),
	country_id number(10), 
	type varchar2(10) not null,
	patient number(10) not null,
	duration number(20,12) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 20;

create table id_control(
	table_owner varchar2(40),
	table_name varchar2(40),
	next_id number(10) not null)
	tablespace tsmsmall
	pctused 80 pctfree 10;

create table modelled_cpp_fence (
	id number (10),
 	country_id number (10) not null,
	cpp_low number(20,12) not null,
	cpp_high number(20,12)not null)
	tablespace tsmsmall 
	pctused 60 pctfree 20;

create table client_build_progress (
	id number(10),
	client_div_id number(10) not null,
	build_start date,
	build_end date,
	error number(1) default 0 not null)
        tablespace tsmsmall
        pctused 70 pctfree 20;

create table version_45master (
	version varchar2(6)) 
	tablespace tsmsmall
	pctused 80 pctfree 10;

create table tspd_template (
	id	NUMBER(10),
	client_div_id	NUMBER(10) NOT NULL,
	last_updated	DATE NOT NULL,
	name	VARCHAR2(80)	NOT NULL,
	data	BLOB,
	software_version varchar(20),
	updated_by_ftuser_id number(10),
	version varchar2(50),
	status varchar2(20) default 'Testing',
	create_date date default sysdate,
	creator_ftuser_id number(10),
	released_date date,
	retired_date date,
	locale varchar2(20),
	date_format varchar2(30),
	starteam_tag varchar(30))
	tablespace tspdblob 
	pctused 65 pctfree 20;

create or replace view tspd_template_noblob as
	select id,client_div_id,last_updated,name,
	SOFTWARE_VERSION, UPDATED_BY_FTUSER_ID,VERSION,
	STATUS,CREATE_DATE,CREATOR_FTUSER_ID,RELEASED_DATE,
	RETIRED_DATE,starteam_tag from tspd_template;

create table tspd_trial (
	trial_id	NUMBER(10),
	tspd_template_id NUMBER(10) NOT NULL,
	creator_ftuser_id NUMBER(10) NOT NULL,
	owner_ftuser_id	NUMBER(10) NOT NULL,
	create_date	DATE default sysdate NOT NULL,
	short_title	VARCHAR2(256),	
	full_title	VARCHAR2(1024),	
	short_desc	VARCHAR2(256),	
	full_desc	VARCHAR2(1024),	
	indication_desc	VARCHAR2(1024),	
	study_type	VARCHAR2(80),	
	study_countries	VARCHAR2(1024),	
	planned_sites	NUMBER(5),
	build_tag_id 	NUMBER(10) not null,
	client_support_access_allowed number(1) default 0 not null)
	tablespace tspdsmall 
	pctused 65 pctfree 20;

create table icp_instance (
	id	NUMBER(10),
	trial_id	NUMBER(10),
	last_updated	DATE,
	version_timestamp	NUMBER(10),
	data	BLOB,
	snapshot_type VARCHAR2(80) default 'WorkingCopy' not null,
	icp_type varchar2(80))
	tablespace tspdblob 
	pctused 65 pctfree 20;

create or replace view icp_instance_noblob as
	select id,trial_id,last_updated,
	version_timestamp,snapshot_type,icp_type 
	from icp_instance;	

create table tspd_document (
	id	NUMBER(10),
	trial_id	NUMBER(10)	NOT NULL,
	document_type	VARCHAR2(80)	NOT NULL,
	document_name	VARCHAR2(256),
	author_ftuser_id	NUMBER(10)	NOT NULL,
	create_date	DATE	NOT NULL,
	last_updated	DATE	NOT NULL,
	version_timestamp	NUMBER(10)	NOT NULL,
	data	BLOB,	
	snapshot_type	VARCHAR2(80),	
	snapshot_name	VARCHAR2(256),	
	snapshot_notes	VARCHAR2(1024),	
	review_by_date	DATE,	
	review_by_time	VARCHAR2(80),	
	amend_to_tspd_document_id	NUMBER(10),	
	icp_instance_id	NUMBER(10)	NOT NULL,
	snapshot_status	VARCHAR2(80),
	document_notes  VARCHAR2(1024),
	snapshot_create_date date,
	soa_tbl_format blob,
	review_reminder_days number(2) default 0 not null,
	amend_name VARCHAR2(256),
	last_cookie number(10),
	software_version varchar(20),
	locale varchar2(20),
	date_format varchar2(30))
	tablespace tspdblob 
	pctused 65 pctfree 20;

create or replace view TSPD_DOCUMENT_NOBLOB as
	select id,trial_id,document_type,document_name,
	author_ftuser_id,create_date,last_updated,
	version_timestamp,snapshot_type,snapshot_name,
	snapshot_notes, review_by_date,review_by_time,
	amend_to_tspd_document_id,icp_instance_id,
	snapshot_status,document_notes,snapshot_create_date,
	REVIEW_REMINDER_DAYS,AMEND_NAME,LAST_COOKIE,
	SOFTWARE_VERSION,locale,date_format from tspd_document;



create table tspd_doc_reviewer(
	id	NUMBER(10),
	ftuser_id	NUMBER(10)	NOT NULL,
	tspd_document_id	NUMBER(10)	NOT NULL,
	review_status	VARCHAR2(80) default 'NotReviewed',	
	completion_status	VARCHAR2(80) default 'Incomplete',	
	review_notes	VARCHAR2(1024),	
	user_status	VARCHAR2(80) default 'Active',
	VERSION_TIMESTAMP NUMBER(10) default 1)	
	tablespace tspdsmall 
	pctused 65 pctfree 20;

create table tspd_doc_comment(
	id	NUMBER(10),
	comments	VARCHAR2(4000),
	WORD_RANGE_START  NUMBER(10),
	WORD_RANGE_END NUMBER(10),
	CREATE_DATE DATE,
	TSPD_DOCUMENT_ID NUMBER(10),
	ftuser_id number(10) not null,
	hide_flg number(1) default 1 not null)
	tablespace tspdsmall 
	pctused 65 pctfree 20;

create table tspd_doc_advisory(
	id	NUMBER(10),
	tspd_document_id	NUMBER(10)	NOT NULL,
	status	VARCHAR2(80)	NOT NULL,
	reason_for_close	VARCHAR2(1024),	
	advisory_object	VARCHAR2(2048)	NOT NULL,
	advisoryid varchar2(512))
	tablespace tspdsmall 
	pctused 65 pctfree 20;

create table criteria(
	id	NUMBER(10),
	client_div_id	NUMBER(10)	NOT NULL,
	type	VARCHAR2(80)	NOT NULL,
	short_desc	VARCHAR2(256),	
	long_desc	VARCHAR2(2048),
	rationale	VARCHAR2(2048),
	other_desc VARCHAR2(256),
	classifier varchar2(128),
	other_classifier_desc VARCHAR2(256))	
	tablespace tspdsmall 
	pctused 65 pctfree 20;

create table criteria_set(
	id	NUMBER(10),
	name	VARCHAR2(80)	NOT NULL,
	create_date	DATE	NOT NULL,
	client_div_id	NUMBER(10)	NOT NULL,
	ftuser_id	NUMBER(10)	NOT NULL,
	VERSION_TIMESTAMP NUMBER(10) default 1)
	tablespace tspdsmall 
	pctused 65 pctfree 20;

create table criteria_set_item(
	id	NUMBER(10),
	criteria_set_id	NUMBER(10)	NOT NULL,
	criteria_id	NUMBER(10)	NOT NULL)
	tablespace tspdsmall 
	pctused 65 pctfree 20;

create table password_rule(
	id	NUMBER(10),
	client_div_id	NUMBER(10)	NOT NULL,
	username_min_chars	NUMBER(3) default 0	NOT NULL,
	username_max_chars	NUMBER(3) default 0	NOT NULL,
	password_min_chars	NUMBER(3) default 0	NOT NULL,
	password_max_chars	NUMBER(3) default 0	NOT NULL,
	password_has_numeric	NUMBER(1) default 0	NOT NULL,
	password_valid_days	NUMBER(5) default 0 	NOT NULL,
	password_ntfy_user_days 	NUMBER(5) default 0	NOT NULL,
	password_allow_reuse_days	NUMBER(5) default 0	NOT NULL,
	LOCKOUT_INACTIVITY_DAYS number(5) default 0 not null,
	LOCKOUT_LOGIN_ATTEMPTS number(5) default 0 not null)
	tablespace tspdsmall 
	pctused 65 pctfree 20;

create table TSPD_TEMPLATE_EMAIL(
	id	NUMBER(10),
	client_div_id	NUMBER(10),
	TEMPLATE_NAME  	VARCHAR2(30) NOT NULL,
	SUBJECT	VARCHAR2(256) NOT NULL,	
	MESSAGE_TEXT 	VARCHAR2(4000))	
	tablespace tspdsmall 
	pctused 65 pctfree 20;

create table tspd_lib_bucket(
	ID	NUMBER(10),
	NAME	VARCHAR2(255) not null,
	CREATE_DATE	DATE not null,
	CLIENT_DIV_ID	NUMBER(10),
	LAST_UPDATED	DATE not null,
	VERSION_TIMESTAMP NUMBER(10))
	tablespace tspdsmall 
	pctused 70 pctfree 20;

create table tspd_lib_element(
	ID			NUMBER(10),
	TSPD_LIB_BUCKET_ID	NUMBER(10) NOT NULL,
	NAME			VARCHAR2(255),
	CREATE_DATE		DATE NOT NULL,
	CONTENT_TYPE		varchar2(20),
	CREATOR_FTUSER_ID	NUMBER(10),
	CONTENT_SUBTYPE		varchar2(20),
	FILENAME		VARCHAR2(255),
	DATA			BLOB,
	tooltip 		varchar2(256),
	filepath 		varchar2(256),
	inline_data 		varchar2(2048))
	tablespace tspdblob
	pctused 70 pctfree 20;

create or replace view tspd_lib_element_noblob as
	select ID,TSPD_LIB_BUCKET_ID,NAME,CREATE_DATE,CONTENT_TYPE,
	CREATOR_FTUSER_ID,CONTENT_SUBTYPE,FILENAME,TOOLTIP,
	FILEPATH,INLINE_DATA from tspd_lib_element;

create table tspd_template_history (
	id	NUMBER(10),
        history_date    date not null,
        tspd_template_id number(10) not null,
	client_div_id	NUMBER(10) NOT NULL,
	last_updated	DATE NOT NULL,
	name	VARCHAR2(80)	NOT NULL,
	data	BLOB,
	SOFTWARE_VERSION VARCHAR2(20),
	UPDATED_BY_FTUSER_ID NUMBER(10),
	VERSION VARCHAR2(50),
	STATUS VARCHAR2(20),
	CREATE_DATE DATE,
	CREATOR_FTUSER_ID NUMBER(10),
	RELEASED_DATE DATE,
	RETIRED_DATE DATE)
	tablespace tspdblob 
	pctused 65 pctfree 20;

create or replace view tspd_template_history_noblob 
	as select ID,HISTORY_DATE,TSPD_TEMPLATE_ID ,CLIENT_DIV_ID,
	LAST_UPDATED,NAME,SOFTWARE_VERSION,UPDATED_BY_FTUSER_ID,VERSION,
	STATUS,CREATE_DATE,CREATOR_FTUSER_ID,RELEASED_DATE,RETIRED_DATE 
	from tspd_template_history;

Create table IPM_geographical_location (
	country_id number(10),
	country_group varchar2(40),
	geographical_location varchar2(10))
	tablespace tsmsmall 
	pctused 60 pctfree 20;

create table IPM_ph2to4_coeff (
	id number (10),
	geographical_location varchar2(10),
	INPATIENT_STATUS  VARCHAR2(20),
	cpp_cpv varchar2(3),
	coeff_type varchar2(20) not null,
	coeff_value varchar2(40),
	cross_coeff_type varchar2(20),
	cross_coeff_value varchar2(40),
	coeff number(20,12))
	tablespace tsmsmall 
	pctused 60 pctfree 20;

Create table IPM_cpp(
	id number(10),
	phase_id number(10) not null,
	indmap_id number(10) not null,
	low number(12,2),
	mid number(12,2),
	high number(12,2),
	clow number(12,2),
	cmid number(12,2),	 
	chigh number(12,2),
	olow number(12,2),
	omid number(12,2),	 
	ohigh number(12,2),
	cpv number(12,2),
	patient_status varchar2(20))
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table IPM_weight(
	id number(10),
	country_id number(10) not null,
	phase_id number(10) not null,
	indmap_id number(10) not null,
	Affiliation varchar2(20),
	complex_minvalue number(12,2),
	minvalue number(12,2) not null,
	inpatient_status varchar2(20))
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table IPM_std(
	id number(10),
	geographical_location varchar2(10),
	country_group varchar2(40),
	phase_id number(10) not null,
	mean_cpp number(20,10),
	mean_cpv number(20,10),
	std_cpp number(20,10),
	std_cpv number(20,10))
	tablespace tsmsmall 
	pctused 60 pctfree 25;	

create table ipm_ph2to4_adj_coeff(
	id number (10),
	geographical_location varchar2(10),
	INPATIENT_STATUS  VARCHAR2(20),
	cpp_cpv varchar2(7),
	coeff_type varchar2(20) not null,
	coeff_value varchar2(40),
	coeff number(20,12))
	tablespace tsmsmall 
	pctused 60 pctfree 20;

create table ipm_ph2to4_adj_country_ratio(
	id number (10),
	country_id number(10),
	geographical_location varchar2(10),
	p2 number(20,12),
	p3 number(20,12),
	y3p2 number(20,12),
	y3p3 number(20,12))
	tablespace tsmsmall 
	pctused 60 pctfree 20;

create table ipm_ph2to4_lkup_coeff(
	id number (10),
	country_id number(10) not null, 
	phase_id number(10) not null,
	indmap_id number(10) not null,
	pct25 number(20,12) not null,
	pct50 number(20,12) not null,
	pct75 number(20,12) not null,
	duration number(6,2) not null,
	cpp_cpv varchar2(10) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 20;


create table oracle_alert_config(
	id	number(10),
	alert_event	varchar2(128),
	email_recipient	varchar2(512),
	email_subject	varchar2(128),
	email_text	varchar2(1024))
	tablespace tspdsmall
	pctused 65 pctfree 20;

create table tspd_document_history (
	ID				number(10),
	HISTORY_DATE	 		date NOT NULL,
	TSPD_DOCUMENT_ID		NUMBER(10) NOT NULL,
	TRIAL_ID                        NUMBER(10) NOT NULL,
	DOCUMENT_TYPE                   VARCHAR2(80) NOT NULL,
	DOCUMENT_NAME                   VARCHAR2(256),
	AUTHOR_FTUSER_ID                NUMBER(10) NOT NULL,
	CREATE_DATE                     DATE NOT NULL,
	LAST_UPDATED                    DATE NOT NULL,
	VERSION_TIMESTAMP               NUMBER(10) NOT NULL,
	DATA                            BLOB,
	SNAPSHOT_TYPE                   VARCHAR2(80),
	SNAPSHOT_NAME                   VARCHAR2(256),
	SNAPSHOT_NOTES                  VARCHAR2(1024),
	REVIEW_BY_DATE                  DATE,
	REVIEW_BY_TIME                  VARCHAR2(80),
	AMEND_TO_TSPD_DOCUMENT_ID       NUMBER(10),
	ICP_INSTANCE_ID                 NUMBER(10) NOT NULL,
	SNAPSHOT_STATUS                 VARCHAR2(80),
	DOCUMENT_NOTES                  VARCHAR2(1024),
	SNAPSHOT_CREATE_DATE            DATE,
	SOA_TBL_FORMAT                  BLOB,
	REVIEW_REMINDER_DAYS            NUMBER(2) NOT NULL,
	AMEND_NAME                      VARCHAR2(256),
	LAST_COOKIE                     NUMBER(10),
	SOFTWARE_VERSION                VARCHAR2(20))
	tablespace tspdblob 
	pctused 65 pctfree 20;

create or replace view tspd_document_history_noblob as select
	ID,HISTORY_DATE,TSPD_DOCUMENT_ID,TRIAL_ID,DOCUMENT_TYPE,
	DOCUMENT_NAME,AUTHOR_FTUSER_ID,CREATE_DATE,LAST_UPDATED,
	VERSION_TIMESTAMP,SNAPSHOT_TYPE,SNAPSHOT_NAME,SNAPSHOT_NOTES,
	REVIEW_BY_DATE,REVIEW_BY_TIME,AMEND_TO_TSPD_DOCUMENT_ID,
	ICP_INSTANCE_ID,SNAPSHOT_STATUS,DOCUMENT_NOTES,SNAPSHOT_CREATE_DATE,
	REVIEW_REMINDER_DAYS,AMEND_NAME,LAST_COOKIE,
	SOFTWARE_VERSION from tspd_document_history;

CREATE TABLE ip_session_detail (
	id number(10,0) NOT NULL,
	ip_session_id number(10,0) NOT NULL,
	country_id NUMBER(10,0) NOT NULL,
	num_patients NUMBER(10,0),
	num_visits number(10))
	TABLESPACE tsmsmall
	PCTUSED 60 PCTFREE 25;



exit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:11 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:38:11 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:27:05 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
