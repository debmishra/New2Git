--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: c:\tsm\Database\Schema_for_gm_client\tsm10_grants_given_to_clients.sql$ 
--
-- $Revision: 9$        $Date: 3/18/2011 4:33:25 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
grant select,references on affiliation_factor to "&1";
grant select,references on build_tag to "&1";
grant select,references on country to "&1";
grant select,references on client_currency_cnv to "&1";
grant select,references on indmap to "&1";
grant select,references on institution to "&1";
grant select,references on ip_business_factors to "&1";
grant select,references on ip_cpp to "&1";
grant select,references on ip_duration to "&1";
grant select,references on ip_duration_factor to "&1";
grant select,references on pap_euro_overhead to "&1";
grant select,references on ip_weight to "&1";
grant select,references on mapper to "&1";
grant select,references on odc_def to "&1";
grant select,references on phase to "&1";
grant select,references on procedure_def to "&1";
grant select,references on ip_duration_factor to "&1";
grant select,references on region to "&1";
grant select,references on umbrella_orgs to "&1";
grant select,references on pap_odc_pct to "&1";
grant select,references on currency to "&1";
grant select,references on specificity to "&1";
grant select,references on modelled_coeff to "&1";
grant select,references on md_odc_oh_pct to "&1";
grant select,references on modelled_inclusion to "&1";
grant select,references on modelled_upfence to "&1";
grant select,references on modelled_standardize to "&1";
grant select,references on modelled_cpp_fence to "&1";
grant select,references on ft_foreign_key_info to "&1";
grant select,references on build_code to "&1";
grant select,references on protocol to "&1";
grant select,references on derived_prices to "&1";
grant select,references on protocol_to_indmap "&1";

exit;



---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  9    DevTSM    1.8         3/18/2011 4:33:25 PM Mahesh Pasupuleti Include
--       changes for protocol_to_indmap
--  8    DevTSM    1.7         2/27/2008 3:17:46 PM Debashish Mishra  
--  7    DevTSM    1.6         9/20/2006 11:31:20 AMDebashish Mishra  
--  6    DevTSM    1.5         9/19/2006 12:08:12 AMDebashish Mishra  removed
--       references to obsolete tables
--  5    DevTSM    1.4         3/3/2005 6:33:32 AM  Debashish Mishra   
--  4    DevTSM    1.3         3/3/2005 6:32:23 AM  Debashish Mishra  
--  3    DevTSM    1.2         7/23/2004 3:16:32 AM Debashish Mishra Added
--       ft_foreign_key_info synonym and new columns in pap_clinical_proc_cost
--  2    DevTSM    1.1         8/29/2003 5:19:15 PM Debashish Mishra  
--  1    DevTSM    1.0         6/13/2003 9:35:41 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
