--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tsm10_grants_given_to_ft15.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:10 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
grant select,references on project to "&1";
grant select,references on indmap to "&1";
grant select,references on phase to "&1";
grant select,references on client_div to "&1";
grant select,references on currency to "&1";
grant select,references on client_div to "&1";
grant select,references on project_area to "&1";
grant execute on oracle_sendmail to "&1";
grant select on oracle_alert_config to "&1";
grant execute on increment_sequence to "&1";
grant select,insert,update,delete on audit_hist to "&1";
grant select,insert,update,delete on password_rule to "&1";
grant select,insert,update,delete on client_div_to_lic_app to "&1";



exit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:10 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:38:07 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:27:02 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
