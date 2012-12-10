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
-- $Revision: 15$        $Date: 2/22/2008 11:55:23 AM$
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
--  15   DevTSM    1.14        2/22/2008 11:55:23 AMDebashish Mishra  
--  14   DevTSM    1.13        9/19/2006 12:10:49 AMDebashish Mishra   
--  13   DevTSM    1.12        3/2/2005 10:48:49 PM Debashish Mishra  
--  12   DevTSM    1.11        7/7/2003 9:05:22 AM  Debashish Mishra New grant on
--       ft_foreign_key_info from ft15 to tsm10
--  11   DevTSM    1.10        4/7/2003 10:15:19 AM Debashish Mishra Colin's
--       ftadmin and Joel's installshield changes
--  10   DevTSM    1.9         10/24/2002 3:40:33 PMDebashish Mishra  
--  9    DevTSM    1.8         4/15/2002 3:25:46 PM Debashish Mishra  
--  8    DevTSM    1.7         3/22/2002 12:52:13 PMDebashish Mishra  
--  7    DevTSM    1.6         3/18/2002 7:42:42 PM Debashish Mishra  
--  6    DevTSM    1.5         1/7/2002 12:54:08 PM Debashish Mishra Added access
--       rights for sponsor and trial_seq
--  5    DevTSM    1.4         12/19/2001 10:50:33 AMDebashish Mishra  
--  4    DevTSM    1.3         12/11/2001 12:02:47 PMDebashish Mishra  
--  3    DevTSM    1.2         12/6/2001 5:46:26 PM Debashish Mishra  
--  2    DevTSM    1.1         11/26/2001 12:16:35 PMKelly Kingdon   added
--       ft_foreign_key_info
--  1    DevTSM    1.0         11/18/2001 6:58:42 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
