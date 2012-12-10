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
-- $Revision: 4$        $Date: 2/22/2008 11:55:24 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

drop synonym oracle_alert_config;
drop synonym oracle_sendmail;
drop synonym increment_sequence;
drop synonym audit_hist;
create synonym password_rule
create synonym client_div_to_lic_app;


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
--  4    DevTSM    1.3         2/22/2008 11:55:24 AMDebashish Mishra  
--  3    DevTSM    1.2         9/19/2006 12:10:51 AMDebashish Mishra   
--  2    DevTSM    1.1         3/2/2005 10:48:51 PM Debashish Mishra  
--  1    DevTSM    1.0         1/26/2005 7:01:14 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
