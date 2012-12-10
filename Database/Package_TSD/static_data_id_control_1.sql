--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: static_data_id_control_1.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:08 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
Insert into id_control select 'tsm10', 'add_study', nvl(max(id),0)+1 from ADD_STUDY ;
Insert into id_control select 'tsm10', 'affiliation_factor', nvl(max(id),0)+1 from AFFILIATION_FACTOR ;
Insert into id_control select 'tsm10', 'audit_hist', nvl(max(id),0)+1 from AUDIT_HIST ;
Insert into id_control select 'tsm10', 'budget_group_permission', nvl(max(id),0)+1 from BUDGET_GROUP_PERMISSION ;
Insert into id_control select 'tsm10', 'budget_user_permission', nvl(max(id),0)+1 from BUDGET_USER_PERMISSION ;
Insert into id_control select 'tsm10', 'build_code', nvl(max(id),0)+1 from BUILD_CODE ;
Insert into id_control select 'tsm10', 'build_tag', nvl(max(id),0)+1 from BUILD_TAG ;
Insert into id_control select 'tsm10', 'build_tag_to_client_div', nvl(max(id),0)+1 from BUILD_TAG_TO_CLIENT_DIV ;
Insert into id_control select 'tsm10', 'client_currency_cnv', nvl(max(id),0)+1 from CLIENT_CURRENCY_CNV ;
Insert into id_control select 'tsm10', 'client_div', nvl(max(id),0)+1 from CLIENT_DIV ;
Insert into id_control select 'tsm10', 'client_div_to_build_code', nvl(max(id),0)+1 from CLIENT_DIV_TO_BUILD_CODE ;
Insert into id_control select 'tsm10', 'client_div_to_lic_app', nvl(max(id),0)+1 from CLIENT_DIV_TO_LIC_APP ;
Insert into id_control select 'tsm10', 'client_div_to_lic_country', nvl(max(id),0)+1 from CLIENT_DIV_TO_LIC_COUNTRY ;
Insert into id_control select 'tsm10', 'client_div_to_lic_indmap', nvl(max(id),0)+1 from CLIENT_DIV_TO_LIC_INDMAP ;
Insert into id_control select 'tsm10', 'client_div_to_lic_phase', nvl(max(id),0)+1 from CLIENT_DIV_TO_LIC_PHASE ;
Insert into id_control select 'tsm10', 'client_group', nvl(max(id),0)+1 from CLIENT_GROUP ;
Insert into id_control select 'tsm10', 'cost_item', nvl(max(id),0)+1 from COST_ITEM ;
Insert into id_control select 'tsm10', 'country', nvl(max(id),0)+1 from COUNTRY ;
Insert into id_control select 'tsm10', 'currency', nvl(max(id),0)+1 from CURRENCY ;
Insert into id_control select 'tsm10', 'custom_set', nvl(max(id),0)+1 from CUSTOM_SET ;
Insert into id_control select 'tsm10', 'custom_set_item', nvl(max(id),0)+1 from CUSTOM_SET_ITEM ;
Insert into id_control select 'tsm10', 'def_publish_groups', nvl(max(id),0)+1 from DEF_PUBLISH_GROUPS ;
Insert into id_control select 'tsm10', 'drug_class', nvl(max(id),0)+1 from DRUG_CLASS ;
Insert into id_control select 'tsm10', 'drug_code', nvl(max(id),0)+1 from DRUG_CODE ;
Insert into id_control select 'tsm10', 'ftuser_to_client_group', nvl(max(id),0)+1 from FTUSER_TO_CLIENT_GROUP ;
Insert into id_control select 'tsm10', 'indmap', nvl(max(id),0)+1 from INDMAP ;
Insert into id_control select 'tsm10', 'institution', nvl(max(id),0)+1 from INSTITUTION ;
Insert into id_control select 'tsm10', 'investig', nvl(max(id),0)+1 from INVESTIG ;
Insert into id_control select 'tsm10', 'ip_business_factors', nvl(max(id),0)+1 from IP_BUSINESS_FACTORS ;
Insert into id_control select 'tsm10', 'ip_cpp', nvl(max(id),0)+1 from IP_CPP ;
Insert into id_control select 'tsm10', 'ip_duration', nvl(max(id),0)+1 from IP_DURATION ;
Insert into id_control select 'tsm10', 'ip_duration_factor', nvl(max(id),0)+1 from IP_DURATION_FACTOR ;
Insert into id_control select 'tsm10', 'ip_session', nvl(max(id),0)+1 from IP_SESSION ;
Insert into id_control select 'tsm10', 'ip_weight', nvl(max(id),0)+1 from IP_WEIGHT ;
Insert into id_control select 'tsm10', 'local_to_euro', nvl(max(id),0)+1 from LOCAL_TO_EURO ;
Insert into id_control select 'tsm10', 'location_set', nvl(max(id),0)+1 from LOCATION_SET ;
Insert into id_control select 'tsm10', 'location_set_item', nvl(max(id),0)+1 from LOCATION_SET_ITEM ;
Insert into id_control select 'tsm10', 'mapper', nvl(max(id),0)+1 from MAPPER ;
Insert into id_control select 'tsm10', 'md_odc_oh_pct', nvl(max(id),0)+1 from MD_ODC_OH_PCT ;
Insert into id_control select 'tsm10', 'medicare', nvl(max(id),0)+1 from MEDICARE ;
Insert into id_control select 'tsm10', 'milestone_inst', nvl(max(id),0)+1 from MILESTONE_INST ;
Insert into id_control select 'tsm10', 'milestone_template', nvl(max(id),0)+1 from MILESTONE_TEMPLATE ;
Insert into id_control select 'tsm10', 'modelled_coeff', nvl(max(id),0)+1 from MODELLED_COEFF ;
Insert into id_control select 'tsm10', 'modelled_inclusion', nvl(max(id),0)+1 from MODELLED_INCLUSION ;
Insert into id_control select 'tsm10', 'modelled_standardize', nvl(max(id),0)+1 from MODELLED_STANDARDIZE ;
Insert into id_control select 'tsm10', 'modelled_upfence', nvl(max(id),0)+1 from MODELLED_UPFENCE ;
Insert into id_control select 'tsm10', 'modelled_cpp_fence', nvl(max(id),0)+1 from MODELLED_CPP_FENCE ;
Insert into id_control select 'tsm10', 'odc_def', nvl(max(id),0)+1 from ODC_DEF ;
Insert into id_control select 'tsm10', 'pap_euro_overhead', nvl(max(id),0)+1 from PAP_EURO_OVERHEAD ;
Insert into id_control select 'tsm10', 'pap_odc_pct', nvl(max(id),0)+1 from PAP_ODC_PCT ;
Insert into id_control select 'tsm10', 'pap_odc_pct_to_indmap', nvl(max(id),0)+1 from PAP_ODC_PCT_TO_INDMAP ;
Insert into id_control select 'tsm10', 'payments', nvl(max(id),0)+1 from PAYMENTS ;
Insert into id_control select 'tsm10', 'phase', nvl(max(id),0)+1 from PHASE ;
Insert into id_control select 'tsm10', 'picas_visit', nvl(max(id),0)+1 from PICAS_VISIT ;
Insert into id_control select 'tsm10', 'picas_visit_set', nvl(max(id),0)+1 from PICAS_VISIT_SET ;
Insert into id_control select 'tsm10', 'picas_visit_set_item', nvl(max(id),0)+1 from PICAS_VISIT_SET_ITEM ;
Insert into id_control select 'tsm10', 'picas_visit_to_cost_item', nvl(max(id),0)+1 from PICAS_VISIT_TO_COST_ITEM ;
Insert into id_control select 'tsm10', 'price_level', nvl(max(id),0)+1 from PRICE_LEVEL ;
Insert into id_control select 'tsm10', 'procedure_def', nvl(max(id),0)+1 from PROCEDURE_DEF ;
Insert into id_control select 'tsm10', 'procedure_to_protocol', nvl(max(id),0)+1 from PROCEDURE_TO_PROTOCOL ;
Insert into id_control select 'tsm10', 'project', nvl(max(id),0)+1 from PROJECT ;
Insert into id_control select 'tsm10', 'project_area', nvl(max(id),0)+1 from PROJECT_AREA ;
Insert into id_control select 'tsm10', 'project_phase', nvl(max(id),0)+1 from PROJECT_PHASE ;
Insert into id_control select 'tsm10', 'protocol', nvl(max(id),0)+1 from PROTOCOL ;
Insert into id_control select 'tsm10', 'protocol_to_indmap', nvl(max(id),0)+1 from PROTOCOL_TO_INDMAP ;
Insert into id_control select 'tsm10', 'rate_set', nvl(max(id),0)+1 from RATE_SET ;
Insert into id_control select 'tsm10', 'region', nvl(max(id),0)+1 from REGION ;
Insert into id_control select 'tsm10', 'report_template', nvl(max(id),0)+1 from REPORT_TEMPLATE ;
Insert into id_control select 'tsm10', 'role_inst', nvl(max(id),0)+1 from ROLE_INST ;
Insert into id_control select 'tsm10', 'role_inst_to_task_inst', nvl(max(id),0)+1 from ROLE_INST_TO_TASK_INST ;
Insert into id_control select 'tsm10', 'role_template', nvl(max(id),0)+1 from ROLE_TEMPLATE ;
Insert into id_control select 'tsm10', 'role_to_task_template', nvl(max(id),0)+1 from ROLE_TO_TASK_TEMPLATE ;
Insert into id_control select 'tsm10', 'specificity', nvl(max(id),0)+1 from SPECIFICITY ;
Insert into id_control select 'tsm10', 'task_group_inst', nvl(max(id),0)+1 from TASK_GROUP_INST ;
Insert into id_control select 'tsm10', 'task_group_template', nvl(max(id),0)+1 from TASK_GROUP_TEMPLATE ;
Insert into id_control select 'tsm10', 'task_inst', nvl(max(id),0)+1 from TASK_INST ;
Insert into id_control select 'tsm10', 'task_template', nvl(max(id),0)+1 from TASK_TEMPLATE ;
Insert into id_control select 'tsm10', 'temp_inst_to_company', nvl(max(id),0)+1 from TEMP_INST_TO_COMPANY ;
Insert into id_control select 'tsm10', 'temp_ip_study_price', nvl(max(id),0)+1 from TEMP_IP_STUDY_PRICE ;
Insert into id_control select 'tsm10', 'temp_odc', nvl(max(id),0)+1 from TEMP_ODC ;
Insert into id_control select 'tsm10', 'temp_overhead', nvl(max(id),0)+1 from TEMP_OVERHEAD ;
Insert into id_control select 'tsm10', 'temp_procedure', nvl(max(id),0)+1 from TEMP_PROCEDURE ;
Insert into id_control select 'tsm10', 'trace_estimate', nvl(max(id),0)+1 from TRACE_ESTIMATE ;
Insert into id_control select 'tsm10', 'trace_user_prefs', nvl(max(id),0)+1 from TRACE_USER_PREFS ;
Insert into id_control select 'tsm10', 'trial_budget', nvl(max(id),0)+1 from TRIAL_BUDGET ;
Insert into id_control select 'tsm10', 'tsm_message', nvl(max(id),0)+1 from TSM_MESSAGE ;
Insert into id_control select 'tsm10', 'tsm_trial_rollup', nvl(max(id),0)+1 from TSM_TRIAL_ROLLUP ;
Insert into id_control select 'tsm10', 'umbrella_orgs', nvl(max(id),0)+1 from UMBRELLA_ORGS ;
Insert into id_control select 'tsm10', 'unlisted_procedure', nvl(max(id),0)+1 from UNLISTED_PROCEDURE ;
Insert into id_control select 'tsm10', 'user_pref', nvl(max(id),0)+1 from USER_PREF ;
Insert into id_control select 'tsm10', 'working_trial', nvl(max(id),0)+1 from WORKING_TRIAL ;
Insert into id_control select 'tsm10', 'client_build_progress', nvl(max(id),0)+1 from CLIENT_BUILD_PROGRESS ;
Insert into id_control select 'tsm10', 'tspd_template', nvl(max(id),0)+1 from tspd_template ;
Insert into id_control select 'tsm10', 'tspd_document', nvl(max(id),0)+1 from tspd_document ;
Insert into id_control select 'tsm10', 'icp_instance', nvl(max(id),0)+1 from icp_instance ;
Insert into id_control select 'tsm10', 'tspd_doc_reviewer', nvl(max(id),0)+1 from tspd_doc_reviewer ;
Insert into id_control select 'tsm10', 'tspd_doc_comment', nvl(max(id),0)+1 from tspd_doc_comment ;
Insert into id_control select 'tsm10', 'tspd_doc_advisory', nvl(max(id),0)+1 from tspd_doc_advisory ;
Insert into id_control select 'tsm10', 'criteria', nvl(max(id),0)+1 from criteria ;
Insert into id_control select 'tsm10', 'criteria_set', nvl(max(id),0)+1 from criteria_set ;
Insert into id_control select 'tsm10', 'criteria_set_item', nvl(max(id),0)+1 from criteria_set_item;
Insert into id_control select 'tsm10', 'password_rule', nvl(max(id),0)+1 from password_rule ;
Insert into id_control select 'tsm10', 'tspd_template_email', nvl(max(id),0)+1 from tspd_template_email;
insert into id_control select 'tsm10','tspd_lib_bucket',nvl(max(id),0) from tspd_lib_bucket;
insert into id_control select 'tsm10','tspd_lib_element',nvl(max(id),0) from tspd_lib_element;

update id_control set NEXT_ID=10000 where lower(table_name) = 'tspd_template';
insert into id_control select 'tsm10','shared_tspd_template',nvl(max(id),0)+1 from tspd_template;

insert into id_control select 'tsm10','tspd_template_history',nvl(max(id),0) from tspd_template_history;
insert into id_control select 'tsm10','ipm_ph2to4_coeff',nvl(max(id),0) from ipm_ph2to4_coeff;
insert into id_control select 'tsm10','ipm_cpp',nvl(max(id),0) from ipm_cpp;
insert into id_control select 'tsm10','ipm_weight',nvl(max(id),0) from ipm_weight;
insert into id_control select 'tsm10','ipm_std',nvl(max(id),0) from ipm_std;
insert into id_control select 'tsm10','ipm_ph2to4_adj_coeff',nvl(max(id),0) from ipm_ph2to4_adj_coeff;
insert into id_control select 'tsm10','ipm_ph2to4_adj_country_ratio',nvl(max(id),0) from ipm_ph2to4_adj_country_ratio;
insert into id_control select 'tsm10','ipm_ph2to4_lkup_coeff',nvl(max(id),0) from ipm_ph2to4_lkup_coeff;
insert into id_control select 'tsm10','oracle_alert_config',nvl(max(id),0) from oracle_alert_config;



commit;




exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:08 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:37:57 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:26:54 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
