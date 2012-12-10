--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tsm10_client_foreign_keys.sql$ 
--
-- $Revision: 14$        $Date: 1/27/2009 1:22:27 PM$
--
--
-- Description:  Foreign Key relations for a tsm client
--
---------------------------------------------------------------------

Alter table gm_trial_freq add constraint gm_trial_freq_fk1
	foreign key (PHASE_ID) references 
	"&1".PHASE(id);

Alter table gm_trial_freq add constraint gm_trial_freq_fk2
	foreign key (INDMAP_ID) references 
	"&1".INDMAP(id);

Alter table gm_proc_freq add constraint gm_proc_freq_fk1
	foreign key (PHASE_ID) references 
	"&1".PHASE(id);

Alter table gm_proc_freq add constraint gm_proc_freq_fk2
	foreign key (INDMAP_ID) references 
	"&1".INDMAP(id);

Alter table gm_proc_freq add constraint gm_proc_freq_fk3
	foreign key (MAPPER_ID) references 
	MAPPER(id);

Alter table pap_Institution_proc_cost add constraint pap_Institution_proc_cost_fk1
	foreign key (Institution_id) references 
	"&1".Institution(id);

Alter table pap_Institution_proc_cost add constraint pap_Institution_proc_cost_fk2
	foreign key (mapper_id) references 
	mapper(id);

Alter table pap_overhead add constraint pap_overhead_fk1
	foreign key (Country_id) references 
	"&1".Country(id);

Alter table pap_overhead add constraint pap_overhead_fk2
	foreign key (phase_id) references 
	"&1".phase(id);

Alter table pap_overhead add constraint pap_overhead_fk3
	foreign key (indmap_id) references 
	"&1".indmap(id);

Alter table pap_overhead add constraint pap_overhead_fk4
	foreign key (specificity) references 
	"&1".specificity(id);

Alter table institution_overhead add constraint institution_overhead_fk1
	foreign key (Institution_id) references 
	"&1".Institution(id);

Alter table PAP_clinical_proc_cost add constraint PAP_clinical_proc_cost_fk1
	foreign key (Country_id) references 
	"&1".Country(id);

Alter table PAP_clinical_proc_cost add constraint PAP_clinical_proc_cost_fk2
	foreign key (phase_id) references 
	"&1".phase(id);

Alter table PAP_clinical_proc_cost add constraint PAP_clinical_proc_cost_fk3
	foreign key (mapper_id) references 
	mapper(id);

Alter table PAP_clinical_proc_cost add constraint PAP_clinical_proc_cost_fk4
	foreign key (indmap_id) references 
	"&1".indmap(id);

Alter table PAP_clinical_proc_cost add constraint PAP_clinical_proc_cost_fk5
	foreign key (specificity) references 
	"&1".specificity(id);

Alter table IP_study_price add constraint IP_study_price_fk1
	foreign key (Country_id) references 
	"&1".Country(id);

Alter table IP_study_price add constraint IP_study_price_fk2
	foreign key (phase_id) references 
	"&1".phase(id);

Alter table IP_study_price add constraint IP_study_price_fk4
	foreign key (indmap_id) references 
	"&1".indmap(id);

Alter table mapper add constraint mapper_fk1
	foreign key (odc_def_id) references 
	"&1".odc_def(id);

Alter table mapper add constraint mapper_fk2
	foreign key (Procedure_def_id) references 
	"&1".Procedure_def(id);

Alter table MD_ODC_OH_PCT add constraint MD_ODC_OH_PCT_FK1
	foreign key (COUNTRY_ID) references 
	"&1".country(id);

Alter table MD_ODC_OH_PCT add constraint MD_ODC_OH_PCT_FK2
	foreign key (TA_ID) references 
	"&1".indmap(id);

Alter table modelled_coeff add constraint modelled_coeff_FK1
	foreign key (COUNTRY_ID) references 
	"&1".country(id);

Alter table modelled_upfence add constraint modelled_upfence_FK1
	foreign key (COUNTRY_ID) references 
	"&1".country(id);

Alter table modelled_upfence add constraint modelled_upfence_FK2
	foreign key (TA_ID) references 
	"&1".indmap(id);

Alter table modelled_standardize add constraint modelled_standardize_FK1
	foreign key (COUNTRY_ID) references 
	"&1".country(id);

Alter table modelled_cpp_fence add constraint modelled_cpp_fence_FK1
	foreign key (COUNTRY_ID) references 
	"&1".country(id);

Alter table g50_pap_overhead add constraint g50_pap_overhead_fk1
	foreign key (Country_id) references 
	"&1".Country(id);

Alter table g50_pap_overhead add constraint g50_pap_overhead_fk2
	foreign key (phase_id) references 
	"&1".phase(id);

Alter table g50_pap_overhead add constraint g50_pap_overhead_fk3
	foreign key (indmap_id) references 
	"&1".indmap(id);

Alter table g50_pap_overhead add constraint g50_pap_overhead_fk4
	foreign key (specificity) references 
	"&1".specificity(id);

Alter table g50_PAP_clinical_proc_cost add constraint g50_PAP_clinical_proc_cost_fk1
	foreign key (Country_id) references 
	"&1".Country(id);

Alter table g50_PAP_clinical_proc_cost add constraint g50_PAP_clinical_proc_cost_fk2
	foreign key (phase_id) references 
	"&1".phase(id);

Alter table g50_PAP_clinical_proc_cost add constraint g50_PAP_clinical_proc_cost_fk3
	foreign key (mapper_id) references 
	mapper(id);

Alter table g50_PAP_clinical_proc_cost add constraint g50_PAP_clinical_proc_cost_fk4
	foreign key (indmap_id) references 
	"&1".indmap(id);

Alter table g50_PAP_clinical_proc_cost add constraint g50_PAP_clinical_proc_cost_fk5
	foreign key (specificity) references 
	"&1".specificity(id);

Alter table g50_IP_study_price add constraint g50_IP_study_price_fk1
	foreign key (Country_id) references 
	"&1".Country(id);

Alter table g50_IP_study_price add constraint g50_IP_study_price_fk2
	foreign key (phase_id) references 
	"&1".phase(id);

Alter table g50_IP_study_price add constraint g50_IP_study_price_fk4
	foreign key (indmap_id) references 
	"&1".indmap(id);

Alter table INDUSTRY_PAP_ODC_COST add constraint INDUSTRY_PAP_ODC_COST_fk1
	foreign key (Country_id) references 
	"&1".Country(id);

Alter table INDUSTRY_PAP_ODC_COST add constraint INDUSTRY_PAP_ODC_COST_fk2
	foreign key (phase_id) references 
	"&1".phase(id);

Alter table INDUSTRY_PAP_ODC_COST add constraint INDUSTRY_PAP_ODC_COST_fk3
	foreign key (mapper_id) references 
	mapper(id);

Alter table INDUSTRY_PAP_ODC_COST add constraint INDUSTRY_PAP_ODC_COST_fk4
	foreign key (indmap_id) references 
	"&1".indmap(id);

Alter table COMPANY_PAP_ODC_COST add constraint COMPANY_PAP_ODC_COST_fk1
	foreign key (Country_id) references 
	"&1".Country(id);

Alter table COMPANY_PAP_ODC_COST add constraint COMPANY_PAP_ODC_COST_fk2
	foreign key (phase_id) references 
	"&1".phase(id);

Alter table COMPANY_PAP_ODC_COST add constraint COMPANY_PAP_ODC_COST_fk3
	foreign key (mapper_id) references 
	mapper(id);

Alter table COMPANY_PAP_ODC_COST add constraint COMPANY_PAP_ODC_COST_fk4
	foreign key (indmap_id) references 
	"&1".indmap(id);

Alter table G50_COMPANY_PAP_ODC_COST add constraint G50_COMPANY_PAP_ODC_COST_fk1
	foreign key (Country_id) references 
	"&1".Country(id);

Alter table G50_COMPANY_PAP_ODC_COST add constraint G50_COMPANY_PAP_ODC_COST_fk2
	foreign key (phase_id) references 
	"&1".phase(id);

Alter table G50_COMPANY_PAP_ODC_COST add constraint G50_COMPANY_PAP_ODC_COST_fk3
	foreign key (mapper_id) references 
	mapper(id);

Alter table G50_COMPANY_PAP_ODC_COST add constraint G50_COMPANY_PAP_ODC_COST_fk4
	foreign key (indmap_id) references 
	"&1".indmap(id);

Alter table pap_Institution_odc_cost add constraint pap_Institution_odc_cost_fk1
	foreign key (Institution_id) references 
	"&1".Institution(id);

Alter table pap_Institution_odc_cost add constraint pap_Institution_odc_cost_fk2
	foreign key (mapper_id) references 
	mapper(id);

Alter table databld_run_prop add constraint databld_run_prop_fk1
	foreign key (databld_run_id) references
	databld_run(id);


Alter table Own_investig add constraint
	Own_investig_fk1 foreign key (country_Id) 
        references "&1".country(id) ;

Alter table Own_investig add constraint
	Own_investig_fk2 foreign key (institution_Id) 
        references "&1".institution(id) ;

Alter table Own_investig add constraint
	Own_investig_fk3 foreign key (phase_Id) 
        references "&1".phase(id) ;

Alter table Own_investig add constraint
	Own_investig_fk4 foreign key (currency_Id) 
        references "&1".currency(id) ;

Alter table Own_investig add constraint
	Own_investig_fk5 foreign key (indmap_Id) 
        references "&1".indmap(id) ;

Alter table Own_investig add constraint
	Own_investig_fk6 foreign key (ta_indmap_Id) 
        references "&1".indmap(id) ;

Alter table Own_investig add constraint
	Own_investig_fk7 foreign key (Inst_country_id) 
        references "&1".country(id) ;

Alter table Own_investig add constraint
	Own_investig_fk8 foreign key (build_code_id) 
        references "&1".build_code(id) ;

Alter table Own_investig add constraint
	Own_investig_fk9 foreign key (plan_curr_Id) 
        references "&1".currency(id) ;

Alter table own_protocol add constraint
	Own_protocol_fk1 foreign key (Phase_Id) 
        references "&1".Phase(id) ;

Alter table own_protocol add constraint
	Own_protocol_fk2 foreign key (indmap_Id)
        references "&1".indmap(id) ;

Alter table own_protocol add constraint
	Own_protocol_fk3 foreign key (ta_indmap_Id) 
        references "&1".indmap(id) ;

Alter table own_protocol add constraint
	Own_protocol_fk4 foreign key (build_code_id) 
        references "&1".build_code(id) ;

Alter table Own_protocol add constraint
	Own_protocol_fk5 foreign key (plan_curr_Id) 
        references "&1".currency(id) ;

Alter table own_site add constraint
	own_site_fk1 foreign key (institution_Id) 
        references "&1".institution(id) ;

Alter table own_site add constraint
	own_site_fk2 foreign key (Country_Id) 
        references "&1".Country(id) ;

Alter table own_site add constraint
	own_site_fk3 foreign key (Build_code_Id) 
        references "&1".Build_code(id) ;

Alter table Own_site add constraint
	Own_site_fk4 foreign key (plan_curr_Id) 
        references "&1".currency(id) ;

Alter table own_procedure add constraint
	own_procedure_fk1 foreign key (currency_Id) 
        references "&1".currency(id) ;

Alter table own_procedure add constraint
	own_procedure_fk2 foreign key (Build_code_Id) 
        references "&1".Build_code(id) ;

Alter table own_procedure add constraint
	own_procedure_fk3 foreign key (mapper_Id) 
        references mapper(id) ;

Alter table Own_procedure add constraint
	Own_procedure_fk4 foreign key (plan_curr_Id) 
        references "&1".currency(id) ;

Alter table own_odc add constraint
	own_odc_fk1 foreign key (currency_Id) 
        references "&1".currency(id) ;

Alter table own_odc add constraint
	own_odc_fk2 foreign key (Build_code_Id) 
        references "&1".Build_code(id) ;

Alter table own_odc add constraint
	own_odc_fk3 foreign key (mapper_Id) 
        references mapper(id) ;

Alter table Own_odc add constraint
	Own_odc_fk4 foreign key (plan_curr_Id) 
        references "&1".currency(id) ;

exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  14   DevTSM    1.13        1/27/2009 1:22:27 PM Mahesh Pasupuleti As per
--       Changes by Phil.
--  13   DevTSM    1.12        2/27/2008 3:17:44 PM Debashish Mishra  
--  12   DevTSM    1.11        7/18/2007 11:05:15 PMDebashish Mishra  
--  11   DevTSM    1.10        4/3/2007 4:54:49 PM  Debashish Mishra  
--  10   DevTSM    1.9         4/3/2007 3:05:10 PM  Debashish Mishra removed
--       own_search_set references
--  9    DevTSM    1.8         4/3/2007 2:04:02 PM  Debashish Mishra Updated for GM
--       OWN build
--  8    DevTSM    1.7         12/11/2006 10:55:00 AMDebashish Mishra  
--  7    DevTSM    1.6         10/9/2006 1:57:19 PM Debashish Mishra  
--  6    DevTSM    1.5         9/19/2006 12:08:04 AMDebashish Mishra  removed
--       references to obsolete tables
--  5    DevTSM    1.4         3/3/2005 6:33:28 AM  Debashish Mishra   
--  4    DevTSM    1.3         3/3/2005 6:32:19 AM  Debashish Mishra  
--  3    DevTSM    1.2         3/3/2004 10:54:57 AM Debashish Mishra Added new
--       table pap_institution_odc_cost
--  2    DevTSM    1.1         7/2/2003 5:43:09 PM  Debashish Mishra  
--  1    DevTSM    1.0         6/13/2003 8:02:41 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
