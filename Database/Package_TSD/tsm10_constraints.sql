--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tsm10_constraints.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:10 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
Alter table currency add constraint currency_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table currency add constraint currency_viewable_flg_check
	check(viewable_flg in (0,1));

Alter table Country add constraint country_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table country add constraint country_level_check 
	check (country_level in (1,2));

Alter table country add constraint country_virtual_flg_check 
	check (virtual_flg in (0,1));

Alter table phase add constraint phase_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;


Alter table Indmap add constraint Indmap_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table Indmap add constraint Indmap_type_check 
	check( type in ('Therapeutic Area','Indication Group',
	'Indication'));

Alter table IP_duration_factor add constraint ip_duration_factor_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table Affiliation_factor add constraint Affiliation_factor_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;
	
Alter table Affiliation_factor add constraint affiliation_type_check 
	check (type in ('IP','PAP'));

Alter table PAP_euro_overhead add constraint PAP_euro_overhead_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table PAP_euro_overhead add constraint PAP_adjusted_flg_check 
	check (adjusted_flg in (0,1));

Alter table IP_duration add constraint IP_duration_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table IP_weight add constraint IP_weight_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table IP_weight add constraint IW_affiliation_check 
	check (affiliation in ('Affiliated','Unaffiliated','AllSites'));

Alter table IP_cpp add constraint IP_cpp_pk
	primary key (id) using index tablespace 
	tsmsmall_indx ;

Alter table IP_Business_factors add constraint IP_Business_factors_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table procedure_def add constraint procedure_def_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table procedure_def add constraint TSMPROC_obsolete_flg_check 
	check (obsolete_flg in (0,1));

Alter table procedure_def add constraint proc_def_proc_level_check
	check(procedure_level in 
('Hour','Visit','Patient','Site','Study','PatientOrVisit','PatientOrSite','Other'));

Alter table procedure_def add constraint procedure_def_hide_check
	check (hide in (0,1));

Alter table procedure_def add constraint pd_foxpro_flg_check
	check(foxpro_flg in (0,1));

Alter table region add constraint region_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table region add constraint region_type_check
	check(type in ('Metro','Region','State','Country'));


Alter table Institution add constraint Institution_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table Institution add constraint inst_affiliation_check 
	check (affiliation in ('Affiliated','Unaffiliated'));

Alter table Institution add constraint inst_Umbrella_flg_check 
	check(Umbrella_flg in (0,1));

Alter table Institution add constraint inst_Queriable_check 
	check(Queriable in (0,1));

Alter table odc_def add constraint odc_def_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table odc_def add constraint odc_def_obsolete_check 
	check(obsolete_flg in (0,1));

Alter table odc_def add constraint odc_def_proc_level_check
	check(procedure_level in 
('Hour','Visit','Patient','Site','Study','PatientOrVisit','PatientOrSite','Other'));

Alter table odc_def add constraint odc_def_hide_check 
	check (hide in(0,1));

Alter table odc_def add constraint od_foxpro_flg_check
	check(foxpro_flg in (0,1));

Alter table mapper add constraint mapper_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table build_tag add constraint build_tag_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table client_div add constraint client_div_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table client_div add constraint cd_def_budget_type_check
	check( def_budget_type in 
	('Industry Cost','Per Patient Budget','Per Visit Budget','Modeled Budget'));

Alter table client_div add constraint client_div_uq1 
	unique (client_div_identifier) using index tablespace
	tsmsmall_indx pctfree 25;

Alter table client_div add constraint cd_use_own_cnv_flg_check
	check(use_own_cnv_flg in (0,1));

Alter table client_div add constraint cd_def_price_range_check
	check(def_price_range in ('Low','Med','High','Co_Med','Custom','G50'));

Alter table client_div add constraint cd_g50_col_enabled_check
	check(g50_col_enabled in (0,1));

Alter table client_div add constraint cd_allow_create_unlisted_check
	check(allow_create_unlisted in (0,1));

Alter table client_div add constraint cd_messaging_opt_check 
	check(messaging_opt in (0,1,2));

Alter table client_group add constraint client_group_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table build_tag_to_client_div add constraint build_tag_to_client_div_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table build_tag_to_client_div add constraint bttcd_released_check 
	check(released in (0,1));

Alter table build_tag_to_client_div add constraint build_tag_to_client_div_uq1
	unique(client_div_id, build_tag_id) using index tablespace
	tsmsmall_indx pctfree 25;

Alter table client_div_to_lic_country add constraint client_div_to_lic_country_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table client_div_to_lic_country add constraint client_div_to_lic_country_uq1 
	unique(CLIENT_DIV_ID,COUNTRY_ID)
	using index tablespace tsmsmall pctfree 10;

Alter table client_currency_cnv add constraint client_currency_cnv_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table client_currency_cnv add constraint ccc_CONVERSION_RATE_check
	check (CONVERSION_RATE > 0);


Alter table custom_set add constraint custom_set_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table CUSTOM_SET add constraint custom_set_type_check
	check(type in ('ODC','CLIN','TSPD_TASK'));

Alter table custom_set add constraint custom_set_uq1
	unique (client_div_id,name) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table def_publish_groups add constraint def_publish_groups_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table def_publish_groups add constraint dpg_rw_flg_check 
 	check(rw_flg in (0,1));


Alter table location_set add constraint location_set_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table location_set add constraint ls_is_anonymous_check 
	check(is_anonymous in (0,1));

Alter table location_set_item add constraint location_set_item_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table project_area add constraint project_area_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;
	
Alter table project_area add constraint proj_area_arch_flg_check
	check( archived_flg in (0,1));

Alter table project_area add constraint pa_tsm_default_check 
	check(tsm_default in (0,1));

Alter table project add constraint project_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

--Alter table project add constraint project_uq1
--	unique (client_id, name) using index tablespace
--	tsmsmall_indx pctfree 20;

Alter table project add constraint project_arch_flg_check
	check( archived_flg in (0,1));

Alter table trial_budget add constraint trial_budget_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table trial_budget add constraint tb_specify_ODC_flg_check
	check(specify_ODC_flg in (0,1));

Alter table trial_budget add constraint tb_affiliation_check 
	check (affiliation in 
('Affiliated','Unaffiliated','Both','Hospital','ClinResearchCenter','PhysClinic','AllSites'));

Alter table TRIAL_BUDGET add constraint TB_OVERHEAD_TYPE_CHECK
	check (overhead_type in 
	('Clientdef','PicasOfficialDef','PicasAdjustedDef','Manual','G50'));

Alter table TRIAL_BUDGET add constraint TB_ODC_PCT_RANGE_CHECK
	check (odc_pct_range in ('Industry','Company','Custom','G50'));

Alter table trial_budget add constraint tb_is_published_check 
	check(is_published in (0,1));

Alter table trial_budget add constraint tb_USE_OH_IN_SCREEN_FAIL_check
	check (USE_OH_IN_SCREEN_FAILURES in (0,1));

Alter table trial_budget add constraint tb_ODC_PCT_USE_OH_FLG_check
	check (ODC_PCT_USE_OH_FLG in (0,1));

Alter table trial_budget add constraint tb_ovhd_pct_range_check
	check(overhead_pct_range in ('Low','Med','High','Co_Med','Custom','G50'));

Alter table trial_budget add constraint tb_use_modeled_price_check
	check(use_modeled_price in (0,1));

Alter table trial_budget add constraint tb_delete_flg_check 
	check (delete_flg in (0,1));

Alter table trial_budget add constraint tb_modeled_odc_pct_range_check
	check (modeled_odc_pct_range in ('Modelled', 'Manual'));

Alter table trial_budget add constraint tb_modeled_oh_type_check
	check (modeled_oh_type in ('Modelled', 'Manual'));

Alter table trial_budget add constraint tb_final_check 
	check(final in (0,1));

Alter table tsm_message add constraint tsm_message_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table tsm_message add constraint tm_dismissed_flg_check
	check( dismissed_flg in (0,1));

Alter table tsm_message add constraint tm_seen_flg_check
	check( dismissed_flg in (0,1));

Alter table umbrella_orgs add constraint umbrella_orgs_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table unlisted_procedure add constraint unlisted_procedure_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table unlisted_procedure add constraint up_obsolete_flg_check
	check(obsolete_flg in (0,1));

Alter table unlisted_procedure add constraint up_proc_type_check
	check(type in ('ODC','CLIN','TSPD_TASK'));

Alter table unlisted_procedure add constraint up_procedure_level_check
	check(procedure_level in ('Hour','Visit','Patient','PatientOrVisit','Site','Study','Other'));

Alter table unlisted_procedure add constraint
	up_delete_flg_check check(delete_flg in (0,1));

Alter table ftuser_to_client_group add constraint ftuser_to_client_group_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table ftuser_to_client_group add constraint 
	ftcg_dflt_group_check check(dflt_group in (0,1));

Alter table budget_group_permission add constraint budget_group_permission_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table budget_group_permission add constraint bgp_rw_flg_check
	check(rw_flg in (0,1));

Alter table budget_user_permission add constraint budget_user_permission_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table budget_user_permission add constraint bup_rw_flg_check
	check(rw_flg in (0,1));

Alter table custom_set_item add constraint custom_set_item_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table picas_visit add constraint picas_visit_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table picas_visit add constraint pv_offset_units_check
	check(offset_units in ('y','M','w','d','h','m'));

Alter table picas_visit add constraint pv_visit_type_check
	check(visit_type in ('PayPoint','ClinicalEvent','ClinicalEventCycle','Default'));

Alter table PICAS_VISIT add constraint PV_TRIAL_PHASE_CHECK check(trial_phase in 
   ('Screening','Treatment','Follow Up','Other','Withdrawal','Discontinuation'));

Alter table cost_item add constraint cost_item_pk
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 25;

Alter table cost_item add constraint cost_item_price_range_check
	check(price_range in ('Low','Med','High','Co_Med','Custom','G50'));

Alter table cost_item add constraint cost_item_overhead_pct_check 
	check (overhead_pct in (0,1));

Alter table protocol add constraint protocol_pk 
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 25;

Alter table protocol add constraint ptcl_duration_unit_check 
	check (duration_unit in ('d','w'));

Alter table protocol add constraint ptcl_CENTRAL_LAB_USED_check 
	check (CENTRAL_LAB_USED in (0,1));

Alter table protocol add constraint ptcl_ACTIVE_FLAG_check 
	check (ACTIVE_FLAG in (0,1));

Alter table protocol add constraint ptcl_GROUP1_EXT_EXISTS_check 
	check (GROUP1_EXTENSION_EXISTS in (0,1));

Alter table protocol add constraint ptcl_GROUP2_EXT_EXISTS_check 
	check (GROUP2_EXTENSION_EXISTS in (0,1));

Alter table protocol add constraint ptcl_GROUP3_EXT_EXISTS_check 
	check (GROUP3_EXTENSION_EXISTS in (0,1));

Alter table protocol add constraint ptcl_GROUP4_EXT_EXISTS_check 
	check (GROUP4_EXTENSION_EXISTS in (0,1));

Alter table protocol add constraint ptcl_GROUP5_EXT_EXISTS_check 
	check (GROUP5_EXTENSION_EXISTS in (0,1));

Alter table protocol add constraint ptcl_GROUP6_EXT_EXISTS_check 
	check (GROUP6_EXTENSION_EXISTS in (0,1));

Alter table protocol add constraint ptcl_GROUP7_EXT_EXISTS_check 
	check (GROUP7_EXTENSION_EXISTS in (0,1));

Alter table protocol add constraint ptcl_GROUP8_EXT_EXISTS_check 
	check (GROUP8_EXTENSION_EXISTS in (0,1));

Alter table protocol add constraint ptcl_GROUP9_EXT_EXISTS_check 
	check (GROUP9_EXTENSION_EXISTS in (0,1));

Alter table protocol add constraint ptcl_GROUPA_EXT_EXISTS_check 
	check (GROUPA_EXTENSION_EXISTS in (0,1));

Alter table protocol add constraint ptcl_inpatient_status_check 
	check (inpatient_status in ('Inpatient','Outpatient','Mixed'));

Alter table protocol add constraint ptcl_age_range_check 
	check (age_range in ('Adult','Geriatric','Mixed',
	'Any','Pediatric','Postmenopause','Unknown'));

Alter table protocol add constraint ptcl_STUDY_TYPE_check
	check (STUDY_TYPE in ('Efficacy and Safety','Safety or dose ranging',
	'Extension','Pharmacoeconomic/Health Economic','No IPT','Morbidity',
	'Non Extension','Other'));

Alter table protocol add constraint ptcl_STUDY_STRUCT_TYPE_check
	check (STUDY_STRUCT_TYPE in ('Parallel','Crossover','None',
	'Not Available','Other'));

set define off

Alter table protocol add constraint ptcl_TREATMENT_CONTROL_check
	check (TREATMENT_CONTROL in ('Placebo control','Active control',
	'Combination','Observation control','A&B','A&C','B&C','A&B&C',
	'Dose Ranging','None','Not Available','Other'));

set define on

Alter table protocol add constraint protocol_same_as_prot_check
	check (same_as_prot in (0,1));

Alter table protocol_to_indmap add constraint protocol_to_indmap_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table protocol_to_indmap add constraint pti_primary_flg_chk 
	check(primary_flg in (0,1));

Alter table Investig add constraint Investig_pk 
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 25;

Alter table Investig add constraint Investig_PRIMARY_FLAG_check 
	check (PRIMARY_FLAG in (0,1));

Alter table Investig add constraint Investig_CRO_USED_check 
	check (CRO_USED in (0,1));

Alter table Investig add constraint Investig_AFFILIATION_check
	check( affiliation in ('Affiliated','Unaffiliated'));

Alter table Investig add constraint Investig_GRANT_ADJ_CODE_check
	check( GRANT_ADJUST_CODE in ('Discount','Error','Rounding','Unknown','None'));

Alter table investig add constraint investig_incomplete_check
	check (incomplete in (0,1));

Alter table investig add constraint investig_sampled_check
	check (sampled in (0,1));

Alter table investig add constraint investig_managed_check
	check (managed in (0,1));

Alter table investig add constraint investig_facility_check
   	check(facility in 
	('Hospital','Unit','Other','No Confinement, Not Phase I','Unknown'));

Alter table medicare add constraint medicare_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table medicare add constraint medicare_PICAS_check 
	check (PICAS in (0,1));

Alter table pap_odc_pct add constraint pap_odc_pct_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table pap_odc_pct_to_indmap add constraint pap_odc_pct_to_indmap_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table payments add constraint payments_pk 
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 25;

Alter table payments add constraint payments_pymt_type_check
	check(type in ('ODC','CLIN'));

Alter table payments add constraint payments_outlier_cd_check
	check(outlier_cd in (0,1,2)); 

Alter table price_level add constraint price_level_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table price_level add constraint price_level_type_check
	check(type in ('ODC','CLIN'));


Alter table procedure_to_protocol add constraint procedure_by_protocol_pk 
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 25;

Alter table procedure_to_protocol add constraint pbp_type_check
	check(type in ('ODC','CLIN'));

Alter table report_template add constraint report_template_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table picas_visit_to_cost_item add constraint 
	picas_visit_to_cost_item_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table picas_visit_to_cost_item add constraint
	pvtci_frequency_check check( frequency >0);

Alter table ip_session add constraint ip_session_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table ip_session add constraint ip_session_affiliation_check
	check( affiliation in 
('Affiliated','Unaffiliated','Both','Hospital','ClinResearchCenter','PhysClinic','AllSites'));

Alter table ip_session add constraint ip_session_pricing_check check(pricing in 
   	('Low','Med','High','Co_Med'));


Alter table ip_session add constraint ip_session_factor_check check(factor in 
   	('SingleDose','MultipleDose','CPP_Simple','CPP_Complex','CPP','CPV'));

Alter table tsm_trial_rollup add constraint tsm_trial_rollup_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table temp_procedure add constraint temp_procedure_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table temp_procedure add constraint tp_primary_flg_check 
	check(primary_flg in (0,1));

alter table temp_procedure add constraint tp_active_flg_check
check(active_flg in (0,1));

Alter table temp_odc add constraint temp_odc_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table temp_odc add constraint temp_odc_active_check 
	check (active_flg in (0,1));

Alter table temp_overhead add constraint temp_overhead_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table temp_overhead add constraint temp_ovrhd_affiliation_check
	check( affiliation in ('Affiliated','Unaffiliated','Both'));

Alter table temp_overhead add constraint 
	temp_ovrhd_adj18mo_flg_check
	check (adj18mo_flg in (0,1));

Alter table temp_overhead add constraint to_primary_flg_check
	check( primary_flg in(0,1));

alter table temp_overhead add constraint to_active_flg_check
check(active_flg in (0,1));

Alter table temp_inst_to_company add constraint 
	temp_inst_to_company_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table temp_ip_study_price add constraint 
	temp_ip_study_price_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table temp_ip_study_price add constraint 
	tisp_active_flg_check
	check (active_flg in (0,1));

Alter table local_to_euro add constraint 
	local_to_euro_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table client_div_to_lic_phase add constraint 
	client_div_to_lic_phase_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table client_div_to_lic_indmap add constraint client_div_to_lic_indmap_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table build_code add constraint build_code_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table client_div_to_build_code add constraint clientdiv_to_build_code_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table client_div_to_build_code add constraint cdtbc_primary_flg_check 
	check ( primary_flg in (0,1));


Alter table picas_visit_set add constraint picas_visit_set_pk
	primary key (id) using index tablespace tsmsmall_indx
	pctfree 20;

Alter table picas_visit_set_item add constraint picas_visit_set_item_pk
	primary key (id) using index tablespace tsmsmall_indx
	pctfree 20;


Alter table picas_visit_set_item add constraint PVS_OFFSET_UNITS_CHECK  
	CHECK (offset_units in ('y','M','w','d','h','m'));

alter table PICAS_VISIT_SET_ITEM add constraint
	PVS_TRIAL_PHASE_CHECK check(trial_phase in
('Screening','Treatment','Follow Up','Other','Withdrawal','Discontinuation'));

Alter table picas_visit_set_item add constraint PVS_VISIT_TYPE_CHECK
	CHECK (visit_type in ('PayPoint','ClinicalEvent','ClinicalEventCycle','Default'));

Alter table working_trial add constraint working_trial_pk
	primary key (id) using index tablespace tsmsmall_indx
	pctfree 10;

Alter table working_trial add constraint working_trial_uq1
	unique (trial_id, ftuser_id) using index tablespace
	tsmsmall_indx pctfree 20;

Alter table SPECIFICITY add constraint SPECIFICITY_pk
	primary key (id) using index tablespace tsmsmall_indx
	pctfree 20;


Alter table picase_trial add constraint picase_trial_pk 
	primary key (trial_id) using index tablespace tsmsmall_indx 
	pctfree 25;

Alter table picase_trial add constraint pt_budget_type_check
	check(budget_type in 
	('Industry Cost', 'Per Patient Budget','Per Visit Budget','Modeled Budget'));

Alter table picase_trial add constraint pt_ARCHIVED_FLG_check
	check(ARCHIVED_FLG in (0,1));


Alter table odc_def_mapper add constraint  odc_def_mapper_pk
	primary key (odc_def_id, parent_odc_def_id) 
	using index tablespace tsmsmall pctfree 20;

Alter table add_study add constraint add_study_pk
	primary key (id) using index tablespace tsmsmall_indx
	pctfree 20;

Alter table data_load_history add constraint data_load_history_pk
	primary key (table_name,load_date) using index tablespace
	tsmsmall_indx pctfree 15;


Alter table audit_hist add constraint audit_hist_pk
	primary key (id) using index tablespace tsmlarge_indx
	pctfree 20;

Alter table audit_hist add constraint AUDIT_HIST_APP_TYPE_CHECK
	check ( app_type in 
	('DASHBOARD','PICASE','TRACE','TSPD','FTADMIN'));


Alter table client_div_to_lic_app add constraint 
	client_div_to_lic_app_pk primary key (id)
	using index tablespace tsmsmall_indx pctfree 20;

Alter table client_div_to_lic_app add constraint cdtla_app_name_check check ( 
	app_name in ('DASHBOARD', 'PICASE', 'TRACE', 'TSPD'));


Alter table client_div_to_lic_app add constraint 
	client_div_to_lic_app_uq1 unique (client_div_id, app_name)
	using index tablespace tsmsmall_indx pctfree 20;

Alter table User_Pref add constraint User_Pref_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table user_pref add constraint UP_APP_TYPE_CHECK
	check ( app_type in 
	('DASHBOARD','PICASE','TRACE','TSPD','FTADMIN'));

Alter table modelled_coeff add constraint modelled_coeff_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 20;

Alter table MD_ODC_OH_PCT add constraint MD_ODC_OH_PCT_PK 
	primary key(ID) using index tablespace tsmsmall_indx 
	pctfree 20 ;

Alter table modelled_inclusion add constraint modelled_inclusion_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 20;

Alter table modelled_upfence add constraint modelled_upfence_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 20;

Alter table modelled_standardize add constraint modelled_standardize_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 20;

Alter table modelled_standardize add constraint ms_type_check check(
	type in ('LOCATION','SCALE','ADD','MULT','N'));

Alter table id_control add constraint id_control_pk
	primary key (table_owner,table_name) using index tablespace
	tsmsmall_indx pctfree 10;

Alter table id_control add constraint id_control_uq1
	unique (table_name) using index tablespace 
	tsmsmall_indx pctfree 10;

Alter table modelled_cpp_fence add constraint modelled_cpp_fence_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 20;

Alter table client_build_progress add constraint client_build_progress_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 20;

Alter table tspd_template add constraint tspd_template_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table tspd_template add constraint tt_status_check
	check(status in ('Testing','Released','Retired'));

Alter table tspd_template add constraint TSPD_TEMPLATE_UQ1
	unique(client_div_id, name, version ) using
	index tablespace tspdsmall_indx pctfree 20;

Alter table tspd_trial add constraint tspd_trial_pk
	primary key (trial_id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table tspd_trial add constraint tt_study_type_check 
	check(study_type in ('MultipleCenters','SingleCenter','Other')); 

Alter table tspd_trial add constraint tt_clnt_sprt_allwd_check check(
	client_support_access_allowed in (0,1));

Alter table icp_instance add constraint icp_instance_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;	

Alter table icp_instance add constraint icp_instance_icp_type_check
	check(icp_type in ('WorkingCopy','Frozen'));

alter table icp_instance add constraint ii_snapshot_type_check
	check(snapshot_type in ('WorkingCopy','ReviewCopy','FinalVersion','ConflictVersion'));

Alter table tspd_document add constraint tspd_document_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table tspd_document add constraint td_document_type_check
	check(document_type in ('Protocol','StudyGuide'));

Alter table tspd_document add constraint td_snapshot_type_check 
	check (snapshot_type in (
	'WorkingCopy','ReviewCopy','FinalVersion','ConflictVersion','AuthorChange'));

Alter table tspd_document add constraint td_snapshot_status_check
	check(snapshot_status in ('Open','Closed','Final'));

Alter table tspd_doc_reviewer add constraint tspd_doc_reviewer_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table tspd_doc_reviewer add constraint tspd_doc_reviewer_uq1
	unique (ftuser_id,tspd_document_id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table tspd_doc_reviewer add constraint tdr_review_status_check
	check(review_status in ('Approved','ApprovedWithRevisions','NotApproved','NotReviewed'));

Alter table tspd_doc_reviewer add constraint tdr_completion_status_check
	check(completion_status in ('Complete','Partial','Incomplete'));

Alter table tspd_doc_reviewer add constraint tdr_user_status_check
	check(user_status in ('Active','Removed'));

Alter table tspd_doc_comment add constraint tspd_doc_comment_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table tspd_doc_comment add constraint tdc_hide_flg_check 
	check(hide_flg in (0,1));

Alter table tspd_doc_advisory add constraint tspd_doc_advisory_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table tspd_doc_advisory add constraint tda_status_check
	check(status in ('Open','Closed'));	

Alter table criteria add constraint criteria_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table CRITERIA add constraint CRITERIA_TYPE_CHECK check(
	TYPE in ('Inclusion','Exclusion','NotDefined','Undifferentiated','other'));


Alter table criteria_set add constraint criteria_set_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table criteria_set  add constraint criteria_set_uq1
	unique (CLIENT_DIV_ID,NAME) using index tablespace 
	tsmsmall_indx pctfree 15;

Alter table criteria_set_item add constraint criteria_set_item_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table password_rule add constraint password_rule_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table password_rule add constraint password_rule_uq1
	unique (client_div_id) using index tablespace tspdsmall_indx
	pctfree 20;

Alter table TSPD_TEMPLATE_EMAIL add constraint TSPD_TEMPLATE_EMAIL_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table tspd_lib_bucket add constraint tspd_lib_bucket_pk
	primary key (id) using index tablespace tspdsmall_indx
	pctfree 20;

Alter table tspd_lib_element add constraint tspd_lib_element_pk
	primary key (id) using index tablespace tspdsmall_indx
	pctfree 20;

Alter table tspd_lib_element add constraint tle_content_type_check
	check (content_type in ('Inline','Text','MSWord','Image'));

Alter table tspd_lib_element add constraint tle_content_subtype_check
	check (content_subtype in ('PNG','JPG','BMP','GIF'));

Alter table tspd_template_history add constraint tspd_template_history_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table IPM_geographical_location add constraint IPM_geographical_location_pk
	primary key (country_id) using index tablespace tsmsmall_indx
	pctfree 20;

Alter table IPM_ph2to4_coeff add constraint IPM_ph2to4_coeff_pk
	primary key (id) using index tablespace 
	tsmsmall_indx ;

Alter table IPM_ph2to4_coeff add constraint IPC_ph2to4_coeff_type_check
	check (coeff_type in 
	( 'AFFILIATION','COUNTRY GROUP','DURATION','TA','INDGRP','IPT COMPLEX','PHASE','YEAR'));


Alter table IPM_cpp add constraint IPM_cpp_pk
	primary key (id) using index tablespace 
	tsmsmall_indx ;

Alter table IPM_weight add constraint IPM_weight_pk
	primary key (id) using index tablespace 
	tsmsmall_indx ;

Alter table IPM_std add constraint IPM_std_pk
	primary key (id) using index tablespace 
	tsmsmall_indx ;

Alter table ipm_ph2to4_adj_coeff add constraint ipm_ph2to4_adj_coeff_pk
	primary key (id) using index tablespace 
	tsmsmall_indx ;

Alter table ipm_ph2to4_adj_coeff add constraint ipac_coeff_type_check
	check (coeff_type in ('LOCATION','INDGRP','PHASE','DURATION'));


Alter table ipm_ph2to4_adj_country_ratio add constraint ipm_ph2_adj_country_ratio_pk
	primary key (id) using index tablespace 
	tsmsmall_indx ;	

Alter table ipm_ph2to4_lkup_coeff add constraint ipm_ph2to4_lkup_coeff_pk
	primary key (id) using index tablespace 
	tsmsmall_indx ;	

Alter table oracle_alert_config add constraint oracle_alert_config_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table oracle_alert_config add constraint oracle_alert_config_uq1
	unique (alert_event) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table tspd_document_history add constraint tspd_document_history_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

ALTER TABLE ip_session_detail ADD CONSTRAINT ip_session_detail_pk
	PRIMARY KEY (id) using INDEX TABLESPACE
	tsmsmall_indx PCTFREE 25;











exit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:10 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:38:05 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:27:01 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
