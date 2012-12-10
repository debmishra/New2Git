delete from MILESTONE_INST where trace_estimate_id in (select a.id 
from trace_estimate a, trace_trial b where a.trial_id=b.trial_id); 

delete from ROLE_INST_TO_TASK_INST where trace_estimate_id in (select a.id 
from trace_estimate a, trace_trial b where a.trial_id=b.trial_id); 

delete from TASK_GROUP_INST where trace_estimate_id in (select a.id 
from trace_estimate a, trace_trial b where a.trial_id=b.trial_id); 

delete from TASK_INST where trace_estimate_id in (select a.id 
from trace_estimate a, trace_trial b where a.trial_id=b.trial_id); 

delete from TRACE_ESTIMATE where trial_id in (select trial_id from
trace_trial);

delete from trace_trial;

delete from trial where upper(created_by) = 'TRACE';

delete from PICAS_VISIT_TO_COST_ITEM where cost_item_id in (select id
from cost_item where trial_budget_id in (select a.id
from trial_budget a, picase_trial b where a.trial_id = b.trial_id));

delete from PICAS_VISIT_TO_COST_ITEM where cost_item_id in (select id
from picas_visit where trial_budget_id in (select a.id
from trial_budget a, picase_trial b where a.trial_id = b.trial_id));

delete from BUDGET_GROUP_PERMISSION where trial_budget_id in (select a.id
from trial_budget a, picase_trial b where a.trial_id = b.trial_id);

delete from BUDGET_USER_PERMISSION where trial_budget_id in (select a.id
from trial_budget a, picase_trial b where a.trial_id = b.trial_id);

delete from COST_ITEM where trial_budget_id in (select a.id
from trial_budget a, picase_trial b where a.trial_id = b.trial_id);

delete from PICAS_VISIT where trial_budget_id in (select a.id
from trial_budget a, picase_trial b where a.trial_id = b.trial_id);

delete from trial_budget where trial_id in (select trial_id from 
picase_trial);

delete from picase_trial;

delete from tsm_trial_rollup where trial_id in (select id
from trial where upper(created_by) = 'PICASE');

delete from working_trial where trial_id in (select id
from trial where upper(created_by) = 'PICASE');

delete from trial where upper(created_by) = 'PICASE';


