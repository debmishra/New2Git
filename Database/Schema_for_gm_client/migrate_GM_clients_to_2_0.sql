--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: migrate_GM_clients_to_2_0.sql$ 
--
-- $Revision: 5$        $Date: 2/27/2008 3:17:44 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

alter table company_pap_odc_cost add(
price_p25   NUMBER(16,2),
price_p75   NUMBER(16,2));

alter table pap_clinical_proc_cost add(
company_pct25   NUMBER(16,2),
company_pct75   NUMBER(16,2));

alter table g50_company_pap_odc_cost add(
price_p25   NUMBER(16,2),
price_p75   NUMBER(16,2));

alter table g50_pap_clinical_proc_cost add(
company_pct25   NUMBER(16,2),
company_pct75   NUMBER(16,2));



exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/27/2008 3:17:44 PM Debashish Mishra  
--  4    DevTSM    1.3         9/19/2006 12:08:03 AMDebashish Mishra  removed
--       references to obsolete tables
--  3    DevTSM    1.2         8/3/2005 6:12:46 AM  Debashish Mishra  
--  2    DevTSM    1.1         7/22/2005 7:58:58 PM Debashish Mishra Added new
--       columns to G50_ tables
--  1    DevTSM    1.0         7/13/2005 2:09:15 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
