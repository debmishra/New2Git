--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tsm10_client_grants_given.sql$ 
--
-- $Revision: 13$        $Date: 1/27/2009 1:22:28 PM$
--
--
-- Description:  Grants given by a tsm10 client to tsm10
--
---------------------------------------------------------------------
Grant select,insert,update,delete on institution_overhead to "&1";
Grant select,insert,update,delete on pap_Institution_proc_cost to "&1";
Grant select,insert,update,delete on pap_overhead to "&1";
Grant select,insert,update,delete on PAP_clinical_proc_cost to "&1";
Grant select,insert,update,delete on ip_study_price to "&1";
Grant select,insert,update,delete on mapper to "&1";

Grant select,insert,update,delete on PAP_OVERHEAD_ODC to "&1";
Grant select,insert,update,delete on PAP_OVERHEAD_OVERHEAD to "&1";
Grant select,insert,update,delete on PAP_OVERHEAD_PCT_PAID to "&1";

Grant select,insert,update,delete on md_odc_oh_pct to "&1";
Grant select,insert,update,delete on modelled_coeff to "&1";
Grant select,insert,update,delete on modelled_inclusion to "&1";
Grant select,insert,update,delete on modelled_upfence to "&1";
Grant select,insert,update,delete on modelled_standardize to "&1";
Grant select,insert,update,delete on modelled_cpp_fence to "&1";

Grant select,insert,update,delete on g50_pap_overhead to "&1";
Grant select,insert,update,delete on g50_PAP_clinical_proc_cost to "&1";
Grant select,insert,update,delete on g50_ip_study_price to "&1";

Grant select,insert,update,delete on COMPANY_PAP_ODC_COST to "&1";
Grant select,insert,update,delete on INDUSTRY_PAP_ODC_COST to "&1";

Grant select,insert,update,delete on g50_COMPANY_PAP_ODC_COST to "&1";
Grant select,insert,update,delete on pap_Institution_odc_cost to "&1";
Grant select,insert,update,delete on data_by_year to "&1";
Grant select,insert,update,delete on databld_run  to "&1";
Grant select,insert,update,delete on databld_run_prop  to "&1";
Grant select,insert,update,delete on id_control to "&1";

Grant select,insert,update,delete on own_procedure to "&1";
Grant select,insert,update,delete on own_odc to "&1";
Grant select,insert,update,delete on own_site to "&1";
Grant select,insert,update,delete on own_protocol to "&1";
Grant select,insert,update,delete on own_investig to "&1";

Grant select,insert,update,delete on gm_proc_freq to "&1";
Grant select,insert,update,delete on gm_trial_freq to "&1";

exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  13   DevTSM    1.12        1/27/2009 1:22:28 PM Mahesh Pasupuleti As per
--       Changes by Phil.
--  12   DevTSM    1.11        2/27/2008 3:17:45 PM Debashish Mishra  
--  11   DevTSM    1.10        4/3/2007 3:05:13 PM  Debashish Mishra removed
--       own_search_set references
--  10   DevTSM    1.9         4/3/2007 2:04:07 PM  Debashish Mishra Updated for GM
--       OWN build
--  9    DevTSM    1.8         12/11/2006 10:55:03 AMDebashish Mishra  
--  8    DevTSM    1.7         10/9/2006 1:57:24 PM Debashish Mishra  
--  7    DevTSM    1.6         9/19/2006 12:08:08 AMDebashish Mishra  removed
--       references to obsolete tables
--  6    DevTSM    1.5         3/3/2005 6:33:29 AM  Debashish Mishra   
--  5    DevTSM    1.4         3/3/2005 6:32:20 AM  Debashish Mishra  
--  4    DevTSM    1.3         8/2/2004 1:31:58 PM  Debashish Mishra new table
--       data_by_year
--  3    DevTSM    1.2         3/3/2004 10:54:58 AM Debashish Mishra Added new
--       table pap_institution_odc_cost
--  2    DevTSM    1.1         7/2/2003 5:43:10 PM  Debashish Mishra  
--  1    DevTSM    1.0         6/13/2003 8:02:41 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
