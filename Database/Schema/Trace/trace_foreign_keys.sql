--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: trace_foreign_keys.sql$ 
--
-- $Revision: 9$        $Date: 2/27/2008 3:17:31 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 

Alter table drug_code add constraint drug_code_fk1 
	foreign key(client_id) references client(id);

Alter table milestone_inst add constraint milestone_inst_fk1 
	foreign key(milestone_template_id) references milestone_template(id);

Alter table milestone_inst add constraint milestone_inst_fk2 
	foreign key(trace_estimate_id) references trace_estimate(id);

Alter table project_phase add constraint project_phase_fk1 
	foreign key(start_milestone_template_id) references milestone_template(id);

Alter table project_phase add constraint project_phase_fk2 
	foreign key(end_milestone_template_id) references milestone_template(id);

Alter table rate_Set add constraint rate_Set_fk1 
	foreign key(client_div_id) references client_div(id);

Alter table rate_Set add constraint rate_Set_fk2 
	foreign key(country_id) references country(id);

Alter table role_inst add constraint role_inst_fk1 
	foreign key(role_template_id) references role_template(id);

Alter table role_inst add constraint role_inst_fk2 
	foreign key(rate_set_id) references rate_set(id);

Alter table role_inst_to_task_inst add constraint role_inst_to_task_inst_fk1 
	foreign key(role_inst_id) references role_inst(id);

Alter table role_inst_to_task_inst add constraint role_inst_to_task_inst_fk2 
	foreign key(trace_estimate_id) references trace_estimate(id);

Alter table role_inst_to_task_inst add constraint role_inst_to_task_inst_fk3 
	foreign key(role_to_task_template_id) references role_to_task_template(id);

Alter table task_group_inst add constraint task_group_inst_fk1 
	foreign key(task_group_template_id) references task_group_template(id);

Alter table task_group_inst add constraint task_group_inst_fk2 
	foreign key(trace_estimate_id) references trace_estimate(id);

Alter table task_group_inst add constraint task_group_inst_fk3 
	foreign key(locked_by_ftuser_id) references ftuser(id);

Alter table task_group_inst add constraint task_group_inst_fk4 
	foreign key(reviewer_ftuser_id) references ftuser(id);

Alter table task_inst add constraint task_inst_fk1 
	foreign key(task_template_id) references task_template(id);

Alter table task_inst add constraint task_inst_fk2 
	foreign key(trace_estimate_id) references trace_estimate(id);

Alter table task_template add constraint task_template_fk1 
	foreign key(task_group_template_id) references task_group_template(id);

Alter table task_template add constraint task_template_fk2 
	foreign key(start_milestone_template_id) references milestone_template(id);

Alter table task_template add constraint task_template_fk3 
	foreign key(end_milestone_template_id) references milestone_template(id);

Alter table role_to_task_template add constraint role_to_task_template_fk1 
	foreign key(task_template_id) references task_template(id);

Alter table role_to_task_template add constraint role_to_task_template_fk2 
	foreign key(role_template_id) references role_template(id);

Alter table trace_estimate add constraint trace_estimate_fk1 
	foreign key(trial_id) references trace_trial(trial_id);

Alter table trace_estimate add constraint trace_estimate_fk2 
	foreign key(rate_set_id) references rate_set(id);

Alter table trace_estimate add constraint trace_estimate_fk3 
	foreign key(country_id) references country(id);

Alter table trace_trial add constraint trace_trial_fk1 
	foreign key (trial_id) references trial(id);

Alter table trace_trial add constraint trace_trial_fk2 
	foreign key (creator_ftuser_id) references ftuser(id);

Alter table trace_trial add constraint trace_trial_fk3 
	foreign key (ARCHIVED_BY_ID) references ftuser(id);










exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  9    DevTSM    1.8         2/27/2008 3:17:31 PM Debashish Mishra  
--  8    DevTSM    1.7         3/3/2005 6:31:45 AM  Debashish Mishra  
--  7    DevTSM    1.6         6/25/2002 2:48:38 PM Debashish Mishra dropped
--       trace_audit_history and budget_audit_hist tables
--  6    DevTSM    1.5         6/17/2002 9:16:40 AM Debashish Mishra dropped
--       columns from role_to_task_template, task_inst, trace_estimate and
--       trace_trial
--  5    DevTSM    1.4         6/13/2002 11:52:15 AMDebashish Mishra all changes
--       after picas-e beta
--  4    DevTSM    1.3         5/17/2002 9:13:40 AM Debashish Mishra  
--  3    DevTSM    1.2         4/17/2002 3:48:00 PM Debashish Mishra  
--  2    DevTSM    1.1         4/15/2002 3:26:20 PM Debashish Mishra  
--  1    DevTSM    1.0         4/9/2002 1:59:13 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
