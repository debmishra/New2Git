conn tsm10t/****@????


truncate table tsm10t.working_trial;
truncate table tsm10t.picas_visit_to_cost_item;
delete from tsm10t.picas_visit;
delete from tsm10t.cost_item;
commit;
truncate table TSM10T.BUDGET_GROUP_PERMISSION;
truncate table TSM10T.BUDGET_USER_PERMISSION;
delete from tsm10t.trial_budget;
delete from tsm10t.picase_trial;
commit;
truncate table TSM10T.tsm_trial_rollup;
truncate table TSM10T.task_inst;
truncate table TSM10T.task_group_inst;
truncate table TSM10T.role_inst_to_task_inst;
truncate table TSM10T.milestone_inst;
delete from tsm10t.trace_estimate;
delete from tsm10t.trace_trial;
commit;
delete from ft15t.trial;
commit;
truncate table tsm10t.build_tag_to_client_div;
delete from ft15t.ftuser_to_aclentries;
delete from tsm10t.ftuser_to_ftgroup where ftuser_id not in (1,2,103,104);
commit;
truncate table tsm10t.user_pref;
truncate table tsm10t.ip_session;
truncate table tsm10t.client_div_to_lic_app;
truncate table tsm10t.ftuser_to_client_group;
truncate table tsm10t.audit_hist;
truncate table tsm10t.LOCATION_SET_ITEM;
delete from tsm10t.location_set;
commit;
truncate table tsm10t.PICAS_VISIT_SET_ITEM;
delete from tsm10t.PICAS_VISIT_SET;
commit;
truncate table tsm10t.CUSTOM_SET_ITEM;
delete from tsm10t.CUSTOM_SET;
commit;
truncate table tsm10t.tsm_message;
delete from ftuser where id not in (1,2,103,104);
commit;
truncate table tsm10t.CLIENT_CURRENCY_CNV;
delete from tsm10t.role_inst where rate_set_id <> 1;
delete from tsm10t.rate_set where id <> 1;
commit;
delete from tsm10t.project_area;
commit;
truncate table tsm10t.client_div_to_lic_phase;
truncate table tsm10t.client_div_to_lic_indmap;
truncate table tsm10t.client_div_to_lic_country;
truncate table tsm10t.client_div_to_build_code;
truncate table tsm10t.client_build_progress;
truncate table tsm10t.build_tag_to_client_div;
delete from tsm10t.client_group;
commit;
delete from tsm10t.client_div;






