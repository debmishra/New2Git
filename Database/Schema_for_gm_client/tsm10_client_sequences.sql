--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tsm10_client_sequences.sql$ 
--
-- $Revision: 12$        $Date: 1/27/2009 1:22:28 PM$
--
--
-- Description:  Drops and creates sequences for a tsm10 client
--
---------------------------------------------------------------------

drop sequence PAP_clinical_proc_cost_seq;
drop sequence institution_overhead_seq;
drop sequence pap_overhead_seq;
drop sequence pap_Institution_proc_cost_seq;
drop sequence ip_study_price_seq;
drop sequence mapper_seq;

drop sequence modelled_coeff_seq;
drop sequence md_odc_oh_pct_seq;
drop sequence modelled_inclusion_seq;
drop sequence modelled_upfence_seq;
drop sequence modelled_standardize_seq;
drop sequence modelled_cpp_fence_seq;
drop sequence g50_PAP_clinical_proc_cost_seq;
drop sequence g50_pap_overhead_seq;
drop sequence g50_ip_study_price_seq;
drop sequence COMPANY_PAP_ODC_COST_seq;
drop sequence INDUSTRY_PAP_ODC_COST_seq;
drop sequence g50_COMPANY_PAP_ODC_COST_seq;
drop sequence pap_Institution_odc_cost_seq;
drop sequence DATA_BY_YEAR_seq;

drop sequence own_procedure_seq;
drop sequence own_odc_seq;
drop sequence own_site_seq;
drop sequence own_protocol_seq;
drop sequence own_investig_seq;

drop sequence gm_proc_freq_seq;
drop sequence gm_trial_freq_seq;

create sequence PAP_clinical_proc_cost_seq;
create sequence institution_overhead_seq;
create sequence pap_overhead_seq;
create sequence pap_Institution_proc_cost_seq;
create sequence ip_study_price_seq;
create sequence mapper_seq;
create sequence modelled_coeff_seq;
Create sequence md_odc_oh_pct_seq;
Create sequence modelled_inclusion_seq;
Create sequence modelled_upfence_seq;
Create sequence modelled_standardize_seq;
Create sequence modelled_cpp_fence_seq;
Create sequence g50_PAP_clinical_proc_cost_seq;
Create sequence g50_pap_overhead_seq;
Create sequence g50_ip_study_price_seq;
Create sequence COMPANY_PAP_ODC_COST_seq;
Create sequence INDUSTRY_PAP_ODC_COST_seq;
Create sequence g50_COMPANY_PAP_ODC_COST_seq;
create sequence pap_Institution_odc_cost_seq;
create sequence DATA_BY_YEAR_seq;

create sequence own_procedure_seq;
create sequence own_odc_seq;
create sequence own_site_seq;
create sequence own_protocol_seq;
create sequence own_investig_seq;

create sequence gm_proc_freq_seq;
create sequence gm_trial_freq_seq;


exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  12   DevTSM    1.11        1/27/2009 1:22:28 PM Mahesh Pasupuleti As per
--       Changes by Phil.
--  11   DevTSM    1.10        2/27/2008 3:17:45 PM Debashish Mishra  
--  10   DevTSM    1.9         4/3/2007 3:05:13 PM  Debashish Mishra removed
--       own_search_set references
--  9    DevTSM    1.8         4/3/2007 2:04:07 PM  Debashish Mishra Updated for GM
--       OWN build
--  8    DevTSM    1.7         12/11/2006 10:55:03 AMDebashish Mishra  
--  7    DevTSM    1.6         9/19/2006 12:08:09 AMDebashish Mishra  removed
--       references to obsolete tables
--  6    DevTSM    1.5         3/3/2005 6:33:30 AM  Debashish Mishra   
--  5    DevTSM    1.4         3/3/2005 6:32:21 AM  Debashish Mishra  
--  4    DevTSM    1.3         8/2/2004 1:31:59 PM  Debashish Mishra new table
--       data_by_year
--  3    DevTSM    1.2         3/3/2004 10:54:59 AM Debashish Mishra Added new
--       table pap_institution_odc_cost
--  2    DevTSM    1.1         7/2/2003 5:43:12 PM  Debashish Mishra  
--  1    DevTSM    1.0         6/13/2003 8:02:42 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
