--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: c:\tsm\Database\Schema_for_gm_client\tsm10_client_synonyms.sql$ 
--
-- $Revision: 8$        $Date: 3/18/2011 4:33:25 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
drop synonym affiliation_factor;
drop synonym build_tag;
drop synonym country;
drop synonym client_currency_cnv;
drop synonym indmap;
drop synonym institution;
drop synonym ip_business_factors;
drop synonym ip_cpp;
drop synonym ip_duration;
drop synonym ip_duration_factor;
drop synonym pap_euro_overhead;
drop synonym ip_weight;
drop synonym odc_def;
drop synonym phase;
drop synonym procedure_def;
drop synonym region;
drop synonym umbrella_orgs;
drop synonym pap_odc_pct;
drop synonym currency;
drop synonym specificity;
drop synonym ft_foreign_key_info;
drop synonym build_code;
drop synonym protocol;
drop synonym protocol_to_indmap;

create synonym affiliation_factor for "&1".affiliation_factor;
create synonym build_tag for "&1".build_tag;
create synonym country for "&1".country;
create synonym client_currency_cnv for "&1".client_currency_cnv;
create synonym indmap for "&1".indmap;
create synonym institution for "&1".institution;
create synonym ip_business_factors for "&1".ip_business_factors;
create synonym ip_cpp for "&1".ip_cpp;
create synonym ip_duration for "&1".ip_duration;
create synonym ip_duration_factor for "&1".ip_duration_factor;
create synonym pap_euro_overhead for "&1".pap_euro_overhead;
create synonym ip_weight for "&1".ip_weight;
create synonym odc_def for "&1".odc_def;
create synonym phase for "&1".phase;
create synonym procedure_def for "&1".procedure_def;
create synonym region for "&1".region;
create synonym umbrella_orgs for "&1".umbrella_orgs;
create synonym pap_odc_pct for "&1".pap_odc_pct;
create synonym currency for "&1".currency;
create synonym specificity for "&1".specificity;
create synonym ft_foreign_key_info for "&1".ft_foreign_key_info;
create synonym build_code for "&1".build_code;
create synonym protocol for "&1".protocol;
create synonym protocol_to_indmap for "&1".protocol_to_indmap;

exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  8    DevTSM    1.7         3/18/2011 4:33:25 PM Mahesh Pasupuleti Include
--       changes for protocol_to_indmap
--  7    DevTSM    1.6         2/27/2008 3:17:45 PM Debashish Mishra  
--  6    DevTSM    1.5         9/19/2006 12:08:10 AMDebashish Mishra  removed
--       references to obsolete tables
--  5    DevTSM    1.4         3/3/2005 6:33:30 AM  Debashish Mishra   
--  4    DevTSM    1.3         3/3/2005 6:32:21 AM  Debashish Mishra  
--  3    DevTSM    1.2         7/23/2004 3:16:31 AM Debashish Mishra Added
--       ft_foreign_key_info synonym and new columns in pap_clinical_proc_cost
--  2    DevTSM    1.1         8/29/2003 5:19:14 PM Debashish Mishra  
--  1    DevTSM    1.0         6/13/2003 8:02:43 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
