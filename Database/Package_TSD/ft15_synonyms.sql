--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ft15_synonyms.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:08 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------


create synonym oracle_alert_config for "&1".oracle_alert_config;
create synonym oracle_sendmail for "&1".oracle_sendmail;
create synonym increment_sequence for "&1".increment_sequence;
create synonym audit_hist for "&1".audit_hist;
create synonym password_rule for "&1".password_rule;
create synonym client_div_to_lic_app for "&1".client_div_to_lic_app;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:08 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:37:54 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:26:52 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
