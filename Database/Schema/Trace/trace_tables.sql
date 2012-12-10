--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: trace_tables.sql$ 
--
-- $Revision: 18$        $Date: 2/27/2008 3:17:32 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

drop table trace_user_prefs;
drop table trace_estimate;
drop table role_inst_to_task_inst;
drop table task_inst;
drop table role_template_to_task_template;
drop table task_template;
drop table task_group_inst;
drop table task_group_template;
drop table role_inst;
drop table role_template;
drop table rate_set;
drop table project_phase;
drop table milestone_inst;
drop table milestone_template;
drop table drug_code;
drop table drug_class;

Create table drug_class(
	id number(10),
	name varchar2(256) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table drug_code(
	id number(10),
	client_id number(10),
	name varchar2(256) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table milestone_template(
	id number(10),
	name varchar2(256) not null,
	sequence number(4))
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table milestone_inst(
	id number(10),
	milestone_template_id number(10) not null,
	milestone_date date,
	trace_estimate_id number(10) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table project_phase(
	id number(10),
	start_milestone_template_id number(10) not null,
	end_milestone_template_id number(10) not null,
	name varchar2(64) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table rate_Set(
	id number(10),
	name varchar2(64) not null,
	effective_start_date date,
	effective_end_date date,
	client_div_id number(10),
	country_id number(10),
	default_flg number(1) default 0 not null,
	fte_hours_month number(4,1) default 160 not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table role_template(
	id number(10),
	name varchar2(64),
	category varchar2(20),
	sequence number(4))
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table role_inst(
	id number(10),
	role_template_id number(10),
	salary_rate number(12,2),
	cro_rate number(12,2),
	rate_set_id number(10),
	alias  varchar2 (64))
	tablespace tsmsmall 
	pctused 60 pctfree 25;


Create table role_inst_to_task_inst(
	id number(10),
	role_inst_id number(10),
	calc_hours number(12,2),
	adj_hours number(12,2),
	comments varchar2(128),
	trace_estimate_id number(10),
	role_to_task_template_id number(10))
	tablespace tsmlarge 
	pctused 60 pctfree 25;


Create table task_group_template(
	id number(10),
	name varchar2(64),
	sequence number(4))
	tablespace tsmsmall 
	pctused 60 pctfree 25;


Create table task_group_inst(
	id number(10),
	task_group_template_id number(10) not null,
	locked_by_ftuser_id number(10),
	locked_date Date,
	review_status varchar2(20),
	trace_estimate_id number(10),
	reviewer_ftuser_id number(10))
	tablespace tsmsmall 
	pctused 60 pctfree 25;


Create table task_inst(
	id number(10),
	task_template_id number(10),
	trace_estimate_id number(10))
	tablespace tsmlarge 
	pctused 60 pctfree 25;


Create table task_template(
	id number(10),
	name varchar2(256),
	sequence number(4),
	task_group_template_id number(10),
	start_milestone_template_id number(10),
	end_milestone_template_id number(10))
	tablespace tsmsmall 
	pctused 60 pctfree 25;


Create table role_to_task_template(
	id number(10),
	task_template_id number(10),
	role_template_id number(10),
	calculation_name varchar2(64))
	tablespace tsmsmall 
	pctused 60 pctfree 25;


Create table trace_estimate(
	id number(10),
	trial_id number(10) not null,
	rate_set_id number(10),
	country_id number(10),
	site_count number(5),
	patients_enrolled number(5),
	patients_screened number(5),
	patients_complete number(5),
	qual_site_visits number(5),
	init_site_visits number(5),
	routine_site_visits number(5),
	closeout_site_visits number(5),
	qual_visit_hours number(12,2),
	init_visit_hours number(12,2),
	routine_visit_hours number(12,2),
	closeout_visit_hours number(12,2),
	travel_hours_visit number(12,2),
	visit_prep_hours number(12,2),
	patient_crf_pages number(5),
	query_page_pct number(5,2),
	unique_crf_pages number(5),
	vendor_count number(5),
	investig_payment_count number(5),
	lab_report_count number(5),
	other_report_count number(5),
	sae_count number(5),
	cost_internal number(12,2),
	cost_external number(12,2),
	total_adj_fte_hours number(12,2),
	pct_complete number(12,2),
	pct_pending number(12,2),
	calc_version number(6),
	design_shells number(5),
	inv_mtg_count number(5),
	inv_mtg_hours number(12,2),
	ivr_flg number(1) default 1 not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Create table trace_user_prefs(
	id number(10),
	notify_author number(1) default 0 not null,
	publish_warn_flg number(1) default 0 not null)
	tablespace tsmsmall
	pctused 60 pctfree 25;


Create table trace_trial(
	Trial_ID	NUMBER(10) NOT NULL,	 
	ARCHIVED_DATE	DATE,		
	ARCHIVED_BY_ID	NUMBER(10),		
	CREATOR_FTUSER_ID	NUMBER(10),	
	CREATE_DATE	DATE,		
	PUBLISH_DATE	DATE,		
	nickname	VARCHAR(256),
	FULL_TITLE      VARCHAR2(1024),
	SHORT_TITLE     VARCHAR2(256),
	ARCHIVED_FLG NUMBER(1) default 0 not null)		
	tablespace tsmsmall 
	pctused 60 pctfree 25;












exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  18   DevTSM    1.17        2/27/2008 3:17:32 PM Debashish Mishra  
--  17   DevTSM    1.16        3/3/2005 6:31:47 AM  Debashish Mishra  
--  16   DevTSM    1.15        7/24/2002 9:34:43 AM Debashish Mishra Added
--       rate_set.fte_hours_month
--  15   DevTSM    1.14        7/22/2002 11:33:27 AMDebashish Mishra
--       trace_estimate.ivr_flg modified to default 1 not null
--  14   DevTSM    1.13        7/22/2002 9:32:18 AM Debashish Mishra modified
--       trace_estimate.query_page_pct to number(5,2)
--  13   DevTSM    1.12        7/19/2002 3:40:01 PM Debashish Mishra added
--       trace-estimate.ivr_flg
--  12   DevTSM    1.11        6/25/2002 2:48:39 PM Debashish Mishra dropped
--       trace_audit_history and budget_audit_hist tables
--  11   DevTSM    1.10        6/17/2002 9:16:40 AM Debashish Mishra dropped
--       columns from role_to_task_template, task_inst, trace_estimate and
--       trace_trial
--  10   DevTSM    1.9         6/13/2002 11:52:15 AMDebashish Mishra all changes
--       after picas-e beta
--  9    DevTSM    1.8         6/4/2002 8:52:43 AM  Debashish Mishra Modified for
--       constraints stuff
--  8    DevTSM    1.7         5/23/2002 5:25:53 PM Debashish Mishra  
--  7    DevTSM    1.6         5/17/2002 9:13:40 AM Debashish Mishra  
--  6    DevTSM    1.5         5/15/2002 9:45:37 AM Debashish Mishra  
--  5    DevTSM    1.4         4/25/2002 2:31:00 PM Debashish Mishra  
--  4    DevTSM    1.3         4/22/2002 3:27:53 PM Debashish Mishra  
--  3    DevTSM    1.2         4/17/2002 3:48:01 PM Debashish Mishra  
--  2    DevTSM    1.1         4/15/2002 3:26:22 PM Debashish Mishra  
--  1    DevTSM    1.0         4/9/2002 1:59:15 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
