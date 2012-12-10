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
-- $Revision: 1$        $Date: 12/3/2003 3:22:50 PM$
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


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  1    DevTSM    1.0         12/3/2003 3:22:50 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
