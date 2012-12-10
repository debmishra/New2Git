--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: trace_constraints.sql$ 
--
-- $Revision: 7$        $Date: 2/27/2008 3:17:31 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
Alter table drug_class add constraint drug_class_pk
	primary key (id) using index tablespace tsmsmall_indx
	pctfree 25;

Alter table drug_code add constraint drug_code_pk
	primary key (id) using index tablespace tsmsmall_indx
	pctfree 25;


Alter table milestone_template add constraint milestone_template_pk
	primary key (id) using index tablespace tsmsmall_indx
	pctfree 25;


Alter table milestone_inst add constraint milestone_inst_pk
	primary key (id) using index tablespace tsmsmall_indx
	pctfree 25;

Alter table project_phase add constraint project_phase_pk
	primary key (id) using index tablespace tsmsmall_indx
	pctfree 25;

Alter table rate_Set add constraint rate_set_pk
	primary key (id) using index tablespace tsmsmall_indx
	pctfree 25;

Alter table rate_set add constraint rs_default_flg_check 
	check (default_flg in (0,1));

Alter table role_template add constraint role_template_pk
	primary key (id) using index tablespace tsmsmall_indx
	pctfree 25;

Alter table role_inst add constraint role_inst_pk
	primary key (id) using index tablespace tsmsmall_indx
	pctfree 25;

Alter table role_inst add constraint role_inst_uq1 
	unique (role_template_id,rate_set_id)
	using index tablespace tsmsmall_indx pctfree 20;


Alter table role_inst_to_task_inst add constraint role_inst_to_task_inst_pk
	primary key (id) using index tablespace tsmlarge_indx
	pctfree 25;

Alter table task_group_template add constraint task_group_template_pk
	primary key (id) using index tablespace tsmsmall_indx
	pctfree 25;

Alter table task_group_inst add constraint task_group_inst_pk
	primary key (id) using index tablespace tsmsmall_indx
	pctfree 25;

Alter table task_group_inst add constraint tgi_review_status_check
	check(review_status in ('Unreviewed','Reviewed','Approved'));

Alter table task_inst add constraint task_inst_pk
	primary key (id) using index tablespace tsmlarge_indx
	pctfree 25;

Alter table task_template add constraint task_template_pk
	primary key (id) using index tablespace tsmsmall_indx
	pctfree 25;

Alter table role_to_task_template add constraint role_to_task_template_pk
	primary key (id) using index tablespace tsmsmall_indx
	pctfree 25;

Alter table trace_estimate add constraint trace_estimate_pk
	primary key (id) using index tablespace tsmsmall_indx
	pctfree 25;

Alter table trace_estimate add constraint te_ivr_flg_check 
	check(ivr_flg in (0,1));

Alter table trace_user_prefs add constraint trace_user_prefs_pk
	primary key (id) using index tablespace tsmsmall_indx
	pctfree 25;

Alter table trace_user_prefs add constraint tup_notify_author_check
	check (notify_author in (0,1));

Alter table trace_user_prefs add constraint tup_publish_warn_flg_check
	check (publish_warn_flg in (0,1));


Alter table trace_trial add constraint trace_trial_pk 
	primary key (trial_id) using index tablespace tsmsmall_indx 
	pctfree 25;

Alter table trace_trial add constraint tt_ARCHIVED_FLG_check 
 check(archived_flg in(0,1));
 








exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/27/2008 3:17:31 PM Debashish Mishra  
--  6    DevTSM    1.5         3/3/2005 6:31:44 AM  Debashish Mishra  
--  5    DevTSM    1.4         7/19/2002 3:40:01 PM Debashish Mishra added
--       trace-estimate.ivr_flg
--  4    DevTSM    1.3         7/2/2002 1:25:33 PM  Debashish Mishra Added one
--       constraint to role_inst and a temporary procedure to populate it
--  3    DevTSM    1.2         6/25/2002 2:48:38 PM Debashish Mishra dropped
--       trace_audit_history and budget_audit_hist tables
--  2    DevTSM    1.1         6/17/2002 9:16:39 AM Debashish Mishra dropped
--       columns from role_to_task_template, task_inst, trace_estimate and
--       trace_trial
--  1    DevTSM    1.0         6/4/2002 8:52:53 AM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
