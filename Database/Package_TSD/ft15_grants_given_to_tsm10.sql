--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ft15_grants_given_to_tsm10.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:07 PM$
--
--
-- Description:  Grants given to tsm10 from execution suite
--
---------------------------------------------------------------------
 

Grant select,insert,update,delete,references on client to "&1";
Grant select,insert,update,delete,references on ftgroup to "&1";
Grant select,insert,update,delete,references on ftuser to "&1";
Grant select,insert,update,delete,references on trial to "&1";
Grant select,insert,update,delete,references on ft_foreign_key_info to "&1" with grant option;
Grant select,insert,update,delete,references on ftuser_to_ftgroup to "&1";
Grant select,insert,update,delete,references on aclentries to "&1";
Grant select,insert,update,delete,references on ftuser_to_aclentries to "&1";
Grant select,insert,update,delete,references on ftgroup_to_aclentries to "&1";
Grant select,insert,update,delete,references on usage_history to "&1";
Grant select,insert,update,delete,references on trial_metrics_history to "&1";
Grant select,insert,update,delete,references on sponsor to "&1";
Grant select,insert,update,delete,references on exec_trial to "&1";
Grant select,insert,update,delete,references on ftuser_login_history to "&1";

exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:07 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:37:53 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:26:50 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
