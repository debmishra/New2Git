--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tsm10_foreign_keys.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:10 PM$
--
--
-- Description:  create foreign keys in tsm10
--
---------------------------------------------------------------------

Alter table country add constraint country_fk1 
	foreign key (currency_id) references 
	currency(id);

Alter table country add constraint country_fk2
	foreign key (country_search_id) references 
	country(id);

alter table country add constraint COUNTRY_FK3 
	foreign key(parent_country_id) references 
	country(id);

Alter table indmap add constraint indmap_fk1
	foreign key (parent_indmap_id) references 
	indmap(id);

Alter table IP_duration_factor add constraint IP_duration_factor_fk1
	foreign key (Country_id) references 
	Country(id);

Alter table Affiliation_factor add constraint Affiliation_factor_fk1
	foreign key (Country_id) references 
	Country(id);

Alter table Affiliation_factor add constraint Affiliation_factor_fk2
	foreign key (indmap_id) references 
	indmap(id);

Alter table PAP_euro_overhead add constraint PAP_euro_overhead_fk1
	foreign key (Country_id) references 
	Country(id);

Alter table pap_euro_overhead add constraint pap_euro_overhead_fk2
	foreign key (region_id) references region(id);

Alter table IP_duration add constraint IP_duration_fk1
	foreign key (phase_id) references 
	phase(id);

Alter table IP_duration add constraint IP_duration_fk2
	foreign key (indmap_id) references 
	indmap(id);

Alter table IP_weight add constraint IP_weight_fk1
	foreign key (Country_id) references 
	Country(id);

Alter table IP_weight add constraint IP_weight_fk2
	foreign key (phase_id) references 
	phase(id);

Alter table IP_weight add constraint IP_weight_fk3
	foreign key (indmap_id) references 
	indmap(id);


Alter table IP_cpp add constraint IP_cpp_fk1
	foreign key (phase_id) references 
	phase(id);

Alter table IP_cpp add constraint IP_cpp_fk2
	foreign key (indmap_id) references 
	indmap(id);


Alter table region add constraint region_fk1
	foreign key (Country_id) references 
	Country(id);

Alter table Institution add constraint Institution_fk2
	foreign key (region_id) references 
	region(id);

Alter table Institution add constraint Institution_fk1
	foreign key (country_id) references 
	country(id);

Alter table odc_def add constraint odc_def_fk1
	foreign key (obsolete_build_tag_id) references 
	build_tag (id);

Alter table odc_def add constraint odc_def_fk2
	foreign key (added_build_tag_id) references 
	build_tag (id);

Alter table procedure_def add constraint procedure_def_fk1
	foreign key (obsolete_build_tag_id) references 
	build_tag (id);

Alter table procedure_def add constraint procedure_def_fk2
	foreign key (added_build_tag_id) references 
	build_tag (id);


Alter table mapper add constraint mapper_fk1
	foreign key (odc_def_id) references 
	odc_def(id);

Alter table mapper add constraint mapper_fk2
	foreign key (Procedure_def_id) references 
	Procedure_def(id);

Alter table client_div add constraint client_div_fk1
	foreign key (client_id) references 
	client(id);

--Alter table client_div add constraint client_div_fk2
--	foreign key (Principal_contact_id) references 
--	ftuser(id);

Alter table client_div add constraint client_div_fk3
	foreign key (def_country_id) references 
	country(id);

Alter table client_div add constraint client_div_fk4
	foreign key (def_plan_currency_id) references 
	currency(id);

Alter table client_div add constraint client_div_fk5
	foreign key (country_id) references 
	country(id);

Alter table client_div add constraint client_div_fk6
	foreign key (build_tag_id) references 
	build_tag(id);

Alter table client_div add constraint CLIENT_DIV_FK7
	foreign key(tspd_build_tag_id) references 
	build_tag(id);

Alter table client_group add constraint client_group_fk1
	foreign key (client_div_id) references 
	client_div(id);

Alter table build_tag_to_client_div add constraint build_tag_to_client_div_fk1
	foreign key (client_div_id) references 
	client_div(id);

Alter table build_tag_to_client_div add constraint build_tag_to_client_div_fk2
	foreign key (build_tag_id) references 
	build_tag(id);

Alter table build_tag_to_client_div add constraint build_tag_to_client_div_fk3
	foreign key (released_ftuser_id) references 
	ftuser(id);

Alter table client_div_to_lic_country add constraint client_div_to_lic_country_fk1
	foreign key (client_div_id) references 
	client_div(id);

Alter table client_div_to_lic_country add constraint client_div_to_lic_country_fk2
	foreign key (country_id) references 
	country(id);

Alter table client_currency_cnv add constraint client_currency_cnv_fk1
	foreign key (client_div_id) references 
	client_div(id);

Alter table client_currency_cnv add constraint client_currency_cnv_fk3
	foreign key (to_currency_id) references 
	currency(id);

Alter table custom_set add constraint custom_set_fk1
	foreign key (client_div_id) references 
	client_div(id);

Alter table custom_set add constraint custom_set_fk2
	foreign key (ftuser_id) references 
	ftuser(id);

Alter table def_publish_groups add constraint def_publish_groups_fk1
 	foreign key (PUBLISHING_CLIENT_GROUP_ID) references client_group(id);

Alter table location_set add constraint location_set_fk1
	foreign key (client_div_id) references 
	client_div(id);

Alter table location_set add constraint location_set_fk2
	foreign key (creator_id) references 
	ftuser(id);

Alter table location_set_item add constraint location_set_item_fk1
	foreign key (location_set_id) references 
	location_set(id);

Alter table location_set_item add constraint location_set_item_fk2
	foreign key (region_id) references 
	region(id);

Alter table location_set_item add constraint location_set_item_fk3
	foreign key (country_id) references 
	country(id);

Alter table project_area add constraint project_area_fk1
	foreign key (client_div_id) references 
	client_div(id);

alter table project add constraint project_fk1 
	foreign key (client_id) references 
	client(id);

--Alter table project add constraint project_fk2
--	foreign key (project_area_id) references 
--	project_area(id);


Alter table trial_budget add constraint trial_budget_fk1
	foreign key (country_id) references 
	country(id);

Alter table trial_budget add constraint trial_budget_fk2
	foreign key (region_id) references 
	region(id);

Alter table trial_budget add constraint trial_budget_fk3
	foreign key (institution_id) references 
	institution(id);

Alter table trial_budget add constraint trial_budget_fk4
	foreign key (trial_id) references 
	picase_trial(trial_id);

Alter table trial_budget add constraint trial_budget_fk5
	foreign key (creator_ftuser_id) references 
	ftuser(id);

Alter table trial_budget add constraint trial_budget_fk6
	foreign key (locking_FTUser_id) references 
	FTUser(id);

Alter table trial_budget add constraint trial_budget_fk7
	foreign key (client_group_id) references 
	client_group(id);

Alter table trial_budget add constraint trial_budget_fk8
	foreign key (build_tag_id) references 
	build_tag(id);

Alter table trial_budget add constraint trial_budget_fk9
	foreign key (parent_trial_budget_id) references 
	trial_budget(id);

Alter table trial_budget add constraint trial_budget_fk10
	foreign key (currency_id) references 
	currency(id);

Alter table trial_budget add constraint TRIAL_BUDGET_FK11
	foreign key (LOCAL_CURRENCY_ID) references 
	currency(id);

Alter table tsm_message add constraint tsm_message_fk1
	foreign key (creator_ftuser_ID) references 
	ftuser(id);

Alter table tsm_message add constraint tsm_message_fk2
	foreign key (addressee_ftuser_ID) references 
	ftuser(id);

Alter table umbrella_orgs add constraint umbrella_orgs_fk1
	foreign key (covered_org_id) references 
	institution(id);

Alter table umbrella_orgs add constraint umbrella_orgs_fk2
	foreign key (umbrella_org_id) references 
	institution(id);

Alter table unlisted_procedure add constraint unlisted_procedure_fk1
	foreign key (currency_id) references 
	country(id);

Alter table unlisted_procedure add constraint unlisted_procedure_fk2
	foreign key (client_id) references 
	client(id);

Alter table ftuser_to_client_group add constraint ftuser_to_client_group_fk1
	foreign key (client_group_id) references 
	client_group(id);

Alter table ftuser_to_client_group add constraint ftuser_to_client_group_fk2
	foreign key (ftuser_id) references 
	ftuser(id);

Alter table budget_group_permission add constraint budget_group_permission_fk1
	foreign key (client_group_id) references 
	client_group(id);

Alter table budget_group_permission add constraint budget_group_permission_fk2
	foreign key (trial_budget_id) references 
	trial_budget(id);

Alter table budget_user_permission add constraint budget_user_permission_fk1
	foreign key (ftuser_id) references 
	ftuser(id);

Alter table budget_user_permission add constraint budget_user_permission_fk2
	foreign key (trial_budget_id) references 
	trial_budget(id);

Alter table custom_set_item add constraint custom_set_item_fk1
	foreign key (custom_set_id) references 
	custom_set(id);

Alter table custom_set_item add constraint custom_set_item_fk2
	foreign key (odc_def_id) references 
	odc_def(id);

Alter table custom_set_item add constraint custom_set_item_fk3
	foreign key (unlisted_procedure_id) references 
	unlisted_procedure(id);

Alter table custom_set_item add constraint custom_set_item_fk4
	foreign key (procedure_def_id) references 
	procedure_def(id);


Alter table picas_visit add constraint picas_visit_fk1
	foreign key (trial_budget_id) references 
	trial_budget(id);


Alter table cost_item add constraint cost_item_fk1
	foreign key (procedure_def_id) references 
	procedure_def(id);

Alter table cost_item add constraint cost_item_fk2
	foreign key (odc_def_id) references 
	odc_def(id);

Alter table cost_item add constraint cost_item_fk3
	foreign key (unlisted_procedure_id) references 
	unlisted_procedure(id);

Alter table cost_item add constraint cost_item_fk4
	foreign key (trial_budget_id) references 
	trial_budget(id);

Alter table protocol add constraint protocol_fk1
	foreign key (country_id) references 
	country(id);

Alter table protocol add constraint protocol_fk2
	foreign key (build_code_id) references 
	build_code(id);

Alter table protocol add constraint protocol_fk3
	foreign key (phase_id) references 
	phase(id);

Alter table protocol add constraint protocol_fk4
	foreign key (phase1type_id) references 
	phase(id);

Alter table protocol add constraint protocol_fk5 
	foreign key (collection_country_id) references 
	country(id);

Alter table protocol_to_indmap add constraint protocol_to_indmap_fk1
	foreign key (protocol_id) references 
	protocol(id);

Alter table protocol_to_indmap add constraint protocol_to_indmap_fk2
	foreign key (indmap_id) references 
	indmap(id);

Alter table Investig add constraint Investig_fk1
	foreign key (protocol_id) references 
	protocol(id);

Alter table Investig add constraint Investig_fk2
	foreign key (build_code_id) references 
	build_code(id);

Alter table Investig add constraint Investig_fk3
	foreign key (COUNTRY_id) references 
	COUNTRY(id);

Alter table Investig add constraint Investig_fk4
	foreign key (payment_country_ID) references 
	COUNTRY(id);

Alter table Investig add constraint Investig_fk5
	foreign key (REGION_id) references 
	REGION(id);

Alter table Investig add constraint Investig_fk6
	foreign key (METRO_REGION_id) references 
	REGION(id);

Alter table Investig add constraint Investig_fk7
	foreign key (STATE_REGION_ID) references 
	REGION(id);

-- Alter table Investig add constraint Investig_fk8
--	foreign key (INVESTIGATOR_ID) references 
--	INVESTIGATOR(id);

Alter table Investig add constraint Investig_fk9
	foreign key (INSTITUTION_ID) references 
	INSTITUTION(id);

Alter table medicare add constraint medicare_fk1
	foreign key (COUNTRY_id) references 
	COUNTRY(id);

Alter table pap_odc_pct add constraint pap_odc_pct_fk1
	foreign key (COUNTRY_id) references 
	COUNTRY(id);

Alter table pap_odc_pct_to_indmap add constraint pap_odc_pct_to_indmap_fk1
	foreign key (pap_odc_pct_id) references 
	pap_odc_pct(id);

Alter table pap_odc_pct_to_indmap add constraint pap_odc_pct_to_indmap_fk2
	foreign key (indmap_id) references 
	indmap(id);

Alter table payments add constraint payments_fk1
	foreign key (investig_id) references 
	investig(id);

Alter table payments add constraint payments_fk4
	foreign key (payment_country_ID) references 
	COUNTRY(id);

Alter table payments add constraint payments_fk5
	foreign key (odc_def_id) references 
	odc_def(id);

Alter table payments add constraint payments_fk6
	foreign key (procedure_def_ID) references 
	procedure_def(id);


Alter table price_level add constraint price_level_fk1
	foreign key (country_ID) references 
	COUNTRY(id);

Alter table price_level add constraint price_level_fk2
	foreign key (odc_def_ID) references 
	odc_def(id);

Alter table price_level add constraint price_level_fk3
	foreign key (procedure_def_ID) references 
	procedure_def(id);

Alter table procedure_to_protocol add constraint 
	procedure_to_protocol_fk1
	foreign key (build_code_id) references 
	build_code(id);

Alter table procedure_to_protocol add constraint 
	procedure_to_protocol_fk2
	foreign key (protocol_ID) references 
	protocol(id);

Alter table procedure_to_protocol add constraint 
	procedure_to_protocol_fk3
	foreign key (odc_def_ID) references 
	odc_def(id);

Alter table procedure_to_protocol add constraint 
	procedure_to_protocol_fk4
	foreign key (procedure_def_ID) references 
	procedure_def(id);

Alter table report_template add constraint report_template_fk1
	foreign key (odc_def_ID) references 
	odc_def(id);

Alter table report_template add constraint report_template_fk2
	foreign key (indmap_ID) references 
	indmap(id);

Alter table report_template add constraint report_template_fk3
	foreign key (phase_ID) references 
	phase(id);

Alter table picas_visit_to_cost_item add constraint 
	picas_visit_to_cost_item_fk1
	foreign key (cost_item_ID) references 
	cost_item(id);

Alter table picas_visit_to_cost_item add constraint 
	picas_visit_to_cost_item_fk2
	foreign key (picas_visit_ID) references 
	picas_visit(id);

Alter table ip_session add constraint ip_session_fk1
	foreign key (study_population_id) references 
	ip_business_factors(id);

Alter table ip_session add constraint ip_session_fk2
	foreign key (site_type_id) references 
	ip_business_factors(id);

Alter table ip_session add constraint ip_session_fk3
	foreign key (creator_ftuser_id) references 
	ftuser(id);

Alter table ip_session add constraint ip_session_fk4
	foreign key (study_duration_id) references 
	ip_business_factors(id);

Alter table ip_session add constraint ip_session_fk5
	foreign key (age_range_id) references 
	ip_business_factors(id);

Alter table ip_session add constraint ip_session_fk6
	foreign key (country_id) references 
	country(id);

Alter table ip_session add constraint ip_session_fk7
	foreign key (location_set_ID) references 
	location_set(id);

Alter table ip_session add constraint ip_session_fk8
	foreign key (phase_ID) references 
	phase(id);

Alter table ip_session add constraint ip_session_fk9
	foreign key (indmap_ID) references 
	indmap(id);

Alter table ip_session add constraint ip_session_fk10
	foreign key (project_ID) references 
	project(id);

-- Alter table ip_session add constraint ip_session_fk11
--	foreign key (study_type_ID) references 
--	study_type(id);

Alter table ip_session add constraint ip_session_fk12
	foreign key (treatment_time_id) references 
	ip_business_factors(id);

Alter table ip_session add constraint ip_session_fk13
	foreign key (inpatient_status_id) references 
	ip_business_factors(id); 

Alter table ip_session add constraint ip_session_fk14 
	foreign key(client_id)	references 
	client(id);

Alter table ip_session add constraint ip_session_fk15 
	foreign key(client_div_id) references 
	client_div(id);

Alter table ip_session add constraint ip_session_fk16 
	foreign key(project_area_id) references 
	project_area(id);

Alter table ip_session add constraint ip_session_fk17
 	foreign key (GRP_LOCAL_CURRENCY_ID) references 
	currency(id);

Alter table tsm_trial_rollup add constraint tsm_trial_rollup_fk1
	foreign key (trial_ID) references 
	trial(id);

Alter table temp_procedure add constraint temp_procedure_fk1
	foreign key (indmap_id) references 
	indmap(id);

Alter table temp_procedure add constraint temp_procedure_fk2
	foreign key (country_id) references 
	country(id);

Alter table temp_procedure add constraint temp_procedure_fk3
	foreign key (build_code_id) references 
	build_code(id);

Alter table temp_procedure add constraint temp_procedure_fk4
	foreign key (currency_id) references 
	country(id);

Alter table temp_procedure add constraint temp_procedure_fk5
	foreign key (phase_id) references 
	phase(id);

Alter table temp_procedure add constraint temp_procedure_fk6
	foreign key (mapper_id) references 
	mapper(id);

Alter table temp_procedure add constraint temp_procedure_fk7
	foreign key (institution_ID) references 
	institution(id);

Alter table temp_procedure add constraint temp_procedure_fk8
	foreign key (ta_indmap_id) references 
	indmap(id);

Alter table temp_procedure add constraint temp_procedure_fk9
	foreign key (indgroup_indmap_id) references 
	indmap(id);

Alter table temp_odc add constraint temp_odc_fk1
	foreign key (indmap_id) references 
	indmap(id);

Alter table temp_odc add constraint temp_odc_fk2
	foreign key (country_id) references 
	country(id);

Alter table temp_odc add constraint temp_odc_fk3
	foreign key (build_code_id) references 
	build_code(id);

Alter table temp_odc add constraint temp_odc_fk4
	foreign key (currency_id) references 
	country(id);

Alter table temp_odc add constraint temp_odc_fk5
	foreign key (phase_id) references 
	phase(id);

Alter table temp_odc add constraint temp_odc_fk6
	foreign key (mapper_id) references 
	mapper(id);

Alter table temp_odc add constraint temp_odc_fk7
	foreign key (institution_ID) references 
	institution(id);

Alter table temp_odc add constraint temp_odc_fk8
	foreign key (protocol_ID) references 
	protocol(id);

Alter table temp_odc add constraint temp_odc_fk9
	foreign key (ta_indmap_id) references 
	indmap(id);

Alter table temp_odc add constraint temp_odc_fk10
	foreign key (indgroup_indmap_id) references 
	indmap(id);

Alter table temp_overhead add constraint temp_overhead_fk1
	foreign key (indmap_id) references 
	indmap(id);

Alter table temp_overhead add constraint temp_overhead_fk2
	foreign key (country_id) references 
	country(id);

Alter table temp_overhead add constraint temp_overhead_fk3
	foreign key (build_code_id) references 
	build_code(id);

Alter table temp_overhead add constraint temp_overhead_fk4
	foreign key (phase_id) references 
	phase(id);

Alter table temp_overhead add constraint temp_overhead_fk5
	foreign key (institution_ID) references 
	institution(id);

Alter table temp_overhead add constraint temp_overhead_fk6
	foreign key (protocol_ID) references 
	protocol(id);

Alter table temp_overhead add constraint temp_overhead_fk7
	foreign key (ta_indmap_id) references 
	indmap(id);

Alter table temp_overhead add constraint temp_overhead_fk8
	foreign key (indgroup_indmap_id) references 
	indmap(id);

Alter table temp_inst_to_company add constraint 
	temp_inst_to_company_fk1
	foreign key (institution_ID) references 
	institution(id);

Alter table temp_inst_to_company add constraint 
	temp_inst_to_company_fk2
	foreign key (build_code_ID) references 
	build_code(id);

Alter table temp_inst_to_company add constraint 
	temp_inst_to_company_fk3
	foreign key (phase_id) references 
	phase(id);

Alter table temp_inst_to_company add constraint 
	temp_inst_to_company_fk4
	foreign key (ta_indmap_id) references 
	indmap(id);

Alter table temp_inst_to_company add constraint 
	temp_inst_to_company_fk5
	foreign key (country_id) references 
	country(id);

Alter table temp_ip_study_price add constraint temp_ip_study_price_fk1
	foreign key (indmap_id) references 
	indmap(id);

Alter table temp_ip_study_price add constraint temp_ip_study_price_fk2
	foreign key (country_id) references 
	country(id);

Alter table temp_ip_study_price add constraint temp_ip_study_price_fk3
	foreign key (build_code_id) references 
	build_code(id);

Alter table temp_ip_study_price add constraint temp_ip_study_price_fk4
	foreign key (phase_id) references 
	phase(id);

Alter table temp_ip_study_price add constraint temp_ip_study_price_fk5
	foreign key (ta_indmap_id) references 
	indmap(id);

Alter table temp_ip_study_price add constraint temp_ip_study_price_fk6
	foreign key (indgroup_indmap_id) references 
	indmap(id);

Alter table temp_ip_study_price add constraint temp_ip_study_price_fk7
	foreign key (phase1type_id) references 
	phase(id);

Alter table local_to_euro add constraint local_to_euro_fk1
	foreign key (country_id) references 
	country(id);

Alter table client_div_to_lic_phase add constraint client_div_to_lic_phase_fk1
	foreign key (client_div_id) references 
	client_div(id);

Alter table client_div_to_lic_phase add constraint client_div_to_lic_phase_fk2
	foreign key (phase_id) references 
	phase(id);

Alter table client_div_to_lic_indmap add constraint client_div_to_lic_indmap_fk1
	foreign key (client_div_id) references 
	client_div(id);

Alter table client_div_to_lic_indmap add constraint client_div_to_lic_indmap_fk2
	foreign key (indmap_id) references 
	indmap(id);

Alter table client_div_to_build_code add constraint client_div_to_build_code_fk1
	foreign key (client_div_id) references 
	client_div(id);

Alter table client_div_to_build_code add constraint client_div_to_build_code_fk2
	foreign key (build_code_id) references 
	build_code(id);

Alter table picas_visit_set add constraint picas_visit_set_fk1
	foreign key (client_div_id) references client_div(id);

Alter table picas_visit_set add constraint picas_visit_set_fk2
	foreign key (creator_id) references ftuser(id);

Alter table picas_visit_set_item add constraint picas_visit_set_item_fk1
	foreign key (picas_visit_set_id) references picas_visit_set(id);

Alter table working_trial add constraint working_trial_fk1
	foreign key (trial_id) references trial(id);

Alter table working_trial add constraint working_trial_fk2
	foreign key (ftuser_id) references ftuser(id);

Alter table picase_trial add constraint picase_trial_fk1 
	foreign key (trial_id) references trial(id);

Alter table picase_trial add constraint picase_trial_fk2 
	foreign key (creator_ftuser_id) references ftuser(id);

Alter table picase_trial add constraint picase_trial_fk3 
	foreign key (ARCHIVED_BY_ID) references ftuser(id);

Alter table picase_trial add constraint picase_trial_fk4 
	foreign key (PRICE_CMP_PHASE_ID) references phase(id);

Alter table picase_trial add constraint PICASE_TRIAL_FK5 
	foreign key (PUBLISH_CLIENT_GROUP_ID) references client_group(id);

Alter table picase_trial add constraint PICASE_TRIAL_FK6 
	foreign key (study_duration_id) references ip_business_factors(id);

Alter table picase_trial add constraint PICASE_TRIAL_FK7 
	foreign key (inpatient_status_id) references ip_business_factors(id);

Alter table odc_def_mapper add constraint odc_def_mapper_fk1 
	foreign key (odc_def_id) references odc_def(id);

Alter table odc_def_mapper add constraint odc_def_mapper_fk2
	foreign key(parent_odc_def_id) references odc_def(id);

Alter table add_study add constraint add_study_fk1 
	foreign key (country_id) references country(id);

Alter table add_study add constraint add_study_fk2 
	foreign key (odc_def_id) references odc_def(id);

Alter table add_study add constraint add_study_fk3 
	foreign key (payment_country_id) references country(id);

Alter table audit_hist add constraint audit_hist_fk1 
	foreign key (ftuser_id) references ftuser(id);

Alter table client_div_to_lic_app add constraint client_div_to_lic_app_fk1 
	foreign key (client_div_id) references client_div(id);

Alter table client_div_to_lic_app add constraint client_div_to_lic_app_fk2 
	foreign key (principal_contact_id) references ftuser(id);

Alter table User_Pref add constraint User_Pref_fk1
	foreign key (ftuser_id) references ftuser(id);

Alter table MD_ODC_OH_PCT add constraint MD_ODC_OH_PCT_FK1
	foreign key (COUNTRY_ID) references country(id);

Alter table MD_ODC_OH_PCT add constraint MD_ODC_OH_PCT_FK2
	foreign key (TA_ID) references indmap(id);

Alter table modelled_coeff add constraint modelled_coeff_FK1
	foreign key (COUNTRY_ID) references country(id);

Alter table modelled_upfence add constraint modelled_upfence_FK1
	foreign key (COUNTRY_ID) references country(id);

Alter table modelled_upfence add constraint modelled_upfence_FK2
	foreign key (TA_ID) references indmap(id);

Alter table modelled_standardize add constraint modelled_standardize_FK1
	foreign key (COUNTRY_ID) references country(id);

Alter table modelled_cpp_fence add constraint modelled_cpp_fence_FK1
	foreign key (COUNTRY_ID) references country(id);

Alter table client_build_progress add constraint client_build_progress_fk1
	foreign key(client_div_id) references client_div(id);

Alter table tspd_template add constraint tspd_template_fk1
	foreign key (client_div_id) references client_div(id);

Alter table tspd_template add constraint tspd_template_fk2 
	foreign key (updated_by_ftuser_id) references ftuser(id);

Alter table tspd_template add constraint tspd_template_fk3
	foreign key(creator_ftuser_id) references ftuser(id);

Alter table tspd_trial add constraint tspd_trial_fk1
	foreign key (TRIAL_ID) references trial(id);

Alter table tspd_trial add constraint tspd_trial_fk2
	foreign key (tspd_template_id) references tspd_template(id);

Alter table tspd_trial add constraint tspd_trial_fk3
	foreign key (creator_ftuser_id) references ftuser(id);

Alter table tspd_trial add constraint tspd_trial_fk4
	foreign key (owner_ftuser_id) references ftuser(id);

Alter table tspd_trial add constraint tspd_trial_fk5
	foreign key (build_tag_id) references build_tag(id);

Alter table icp_instance add constraint icp_instance_fk1
	foreign key (TRIAL_ID) references tspd_trial(trial_id);

Alter table tspd_document add constraint tspd_document_fk1
	foreign key (TRIAL_ID) references tspd_trial(trial_id);

Alter table tspd_document add constraint tspd_document_fk2
	foreign key (author_ftuser_id) references ftuser(id);

Alter table tspd_document add constraint tspd_document_fk3
	foreign key (icp_instance_id) references icp_instance(id);	

Alter table tspd_document add constraint tspd_document_fk4
	foreign key (amend_to_tspd_document_id) references tspd_document(id);

Alter table tspd_doc_reviewer add constraint tspd_doc_reviewer_fk1
	foreign key (tspd_document_id) references tspd_document(id);

Alter table tspd_doc_reviewer add constraint tspd_doc_reviewer_fk2
	foreign key (ftuser_id) references ftuser(id);

Alter table tspd_doc_comment add constraint tspd_doc_comment_fk1
	foreign key (ftuser_id) references ftuser(id);

Alter table tspd_doc_comment add constraint tspd_doc_comment_fk2 
	foreign key (TSPD_DOCUMENT_ID) references TSPD_DOCUMENT(ID);

Alter table tspd_doc_comment add constraint tspd_doc_comment_fk3
	foreign key (ftuser_id,TSPD_DOCUMENT_ID) 
	references tspd_doc_reviewer(ftuser_id,TSPD_DOCUMENT_ID);	

Alter table tspd_doc_advisory add constraint tspd_doc_advisory_fk1
	foreign key (tspd_document_id) references tspd_document(id);

Alter table criteria add constraint criteria_fk1
	foreign key (client_div_id) references client_div(id);
	
Alter table criteria_set add constraint criteria_set_fk1
	foreign key (client_div_id) references client_div(id);
	
Alter table criteria_set add constraint criteria_set_fk2
	foreign key (ftuser_id) references ftuser(id);

Alter table criteria_set_item add constraint criteria_set_item_fk1
	foreign key (criteria_id) references criteria(id);
	
Alter table criteria_set_item add constraint criteria_set_item_fk2
	foreign key (criteria_set_id) references criteria_set(id);

Alter table password_rule add constraint password_rule_fk1
	foreign key (client_div_id) references client_div(id);

Alter table TSPD_TEMPLATE_EMAIL add constraint TSPD_TEMPLATE_EMAIL_fk1
	foreign key (client_div_id) references client_div(id);

Alter table tspd_lib_bucket add constraint tspd_lib_bucket_fk1
	foreign key (client_div_id) references client_div(id);

Alter table tspd_lib_element add constraint tspd_lib_element_fk1
	foreign key (TSPD_LIB_BUCKET_ID) references TSPD_LIB_BUCKET(id);

Alter table tspd_lib_element add constraint tspd_lib_element_fk2
	foreign key (CREATOR_FTUSER_ID) references FTUSER(id);

Alter table tspd_template_history add constraint tspd_template_history_fk1
	foreign key (client_div_id) references client_div(id);

Alter table IPM_geographical_location add constraint IPM_geographical_location_fk1
	foreign key (country_id) references country(id);

Alter table IPM_cpp add constraint IPM_cpp_fk1
	foreign key (phase_id) references phase(id);

Alter table IPM_cpp add constraint IPM_cpp_fk2
	foreign key (indmap_id) references indmap(id);

Alter table IPM_weight add constraint IPM_weight_fk1
	foreign key (Country_id) references Country(id);

Alter table IPM_weight add constraint IPM_weight_fk2
	foreign key (phase_id) references phase(id);

Alter table IPM_weight add constraint IPM_weight_fk3
	foreign key (indmap_id) references indmap(id);

Alter table IPM_std add constraint IPM_std_fk1
	foreign key (phase_id) references phase(id);

Alter table ipm_ph2to4_adj_country_ratio add constraint ipm_ph2_adj_country_ratio_fk1
	foreign key (country_id) references country(id);

Alter table ipm_ph2to4_lkup_coeff add constraint ipm_ph2to4_lkup_coeff_fk1
	foreign key (country_id) references country(id);

Alter table ipm_ph2to4_lkup_coeff add constraint ipm_ph2to4_lkup_coeff_fk2
	foreign key (phase_id) references phase(id);

Alter table ipm_ph2to4_lkup_coeff add constraint ipm_ph2to4_lkup_coeff_fk3
	foreign key (indmap_id) references indmap(id);

ALTER TABLE ip_session_detail ADD CONSTRAINT ip_session_detail_fk1
	foreign KEY(ip_session_id) REFERENCES ip_session(id);

ALTER TABLE ip_session_detail ADD CONSTRAINT ip_session_detail_fk2
	foreign KEY(country_id) REFERENCES country(id);
















exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:10 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:38:06 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:27:02 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
