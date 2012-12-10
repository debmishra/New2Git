--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tsm10_grants_given_to_clients.sql$ 
--
-- $Revision: 16$        $Date: 2/22/2008 11:56:04 AM$
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


exit;



---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  16   DevTSM    1.15        2/22/2008 11:56:04 AMDebashish Mishra  
--  15   DevTSM    1.14        9/19/2006 12:11:42 AMDebashish Mishra   
--  14   DevTSM    1.13        3/2/2005 10:51:13 PM Debashish Mishra  
--  13   DevTSM    1.12        8/29/2003 5:17:47 PM Debashish Mishra  
--  12   DevTSM    1.11        10/17/2002 4:09:55 PMDebashish Mishra bugs fixed
--  11   DevTSM    1.10        9/25/2002 4:13:16 PM Debashish Mishra 3 new tables.
--       modelled_inclusion, modelled_standardize ad modelled_upfence
--  10   DevTSM    1.9         9/23/2002 12:16:10 PMDebashish Mishra MOdified to
--       include two new table in client schema and schema name changes related to
--       tsmclient0 schema
--  9    DevTSM    1.8         5/10/2002 1:47:11 PM Debashish Mishra Modified to
--       include special grants for tsmclient0
--  8    DevTSM    1.7         5/10/2002 11:59:17 AMDebashish Mishra Modified for
--       client_div and client_div_to_lic_country grants
--  7    DevTSM    1.6         4/4/2002 5:19:01 PM  Debashish Mishra  
--  6    DevTSM    1.5         2/27/2002 12:47:15 PMDebashish Mishra client rights
--       for currency table
--  5    DevTSM    1.4         1/4/2002 4:26:00 PM  Debashish Mishra  
--  4    DevTSM    1.3         12/13/2001 10:48:14 AMDebashish Mishra  
--  3    DevTSM    1.2         12/6/2001 5:46:30 PM Debashish Mishra  
--  2    DevTSM    1.1         11/26/2001 2:04:33 PMKelly Kingdon   added
--       institution_id to investig and changed IP_euro_overhead to
--       PAP_euro_overhead.
--  1    DevTSM    1.0         11/19/2001 6:12:37 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
