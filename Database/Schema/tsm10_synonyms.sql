--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tsm10_synonyms.sql$ 
--
-- $Revision: 16$        $Date: 2/22/2008 11:56:06 AM$
--
--
-- Description:  Create synonyms in tsm10 for execution suite objects
--
---------------------------------------------------------------------
Drop synonym trial;
Drop synonym client;
Drop synonym ftuser;
Drop synonym ftgroup;
Drop synonym ft_foreign_key_info;
Drop synonym ftuser_to_ftgroup;
Drop synonym aclentries;
Drop synonym ftuser_to_aclentries;
Drop synonym ftgroup_to_aclentries;
Drop synonym usage_history;
Drop synonym trial_metrics_history;
Drop synonym sponsor;
Drop synonym exec_trial;
Drop synonym ftuser_login_history;

 
Create synonym trial for "&1".trial;
create synonym client for "&1".client;
create synonym ftuser for "&1".ftuser;
create synonym ftgroup for "&1".ftgroup;
create synonym ft_foreign_key_info for "&1".ft_foreign_key_info;
create synonym ftuser_to_ftgroup for "&1".ftuser_to_ftgroup;
create synonym aclentries for "&1".aclentries;
create synonym ftuser_to_aclentries for "&1".ftuser_to_aclentries;
create synonym ftgroup_to_aclentries for "&1".ftgroup_to_aclentries;
create synonym usage_history for "&1".usage_history;
create synonym trial_metrics_history for "&1".trial_metrics_history;
create synonym sponsor for "&1".sponsor ;
create synonym exec_trial for "&1".exec_trial ;
Create synonym ftuser_login_history for "&1".ftuser_login_history;


exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  16   DevTSM    1.15        2/22/2008 11:56:06 AMDebashish Mishra  
--  15   DevTSM    1.14        9/19/2006 12:11:50 AMDebashish Mishra   
--  14   DevTSM    1.13        3/2/2005 10:51:17 PM Debashish Mishra  
--  13   DevTSM    1.12        8/29/2003 5:17:51 PM Debashish Mishra  
--  12   DevTSM    1.11        4/7/2003 10:15:23 AM Debashish Mishra Colin's
--       ftadmin and Joel's installshield changes
--  11   DevTSM    1.10        10/24/2002 3:40:37 PMDebashish Mishra  
--  10   DevTSM    1.9         6/4/2002 8:53:36 AM  Debashish Mishra Modified for
--       constraints stuff
--  9    DevTSM    1.8         4/15/2002 3:25:48 PM Debashish Mishra  
--  8    DevTSM    1.7         3/22/2002 12:52:17 PMDebashish Mishra  
--  7    DevTSM    1.6         3/18/2002 7:42:44 PM Debashish Mishra  
--  6    DevTSM    1.5         1/7/2002 12:54:08 PM Debashish Mishra Added access
--       rights for sponsor and trial_seq
--  5    DevTSM    1.4         12/19/2001 10:50:37 AMDebashish Mishra  
--  4    DevTSM    1.3         12/11/2001 12:02:51 PMDebashish Mishra  
--  3    DevTSM    1.2         12/6/2001 5:46:32 PM Debashish Mishra  
--  2    DevTSM    1.1         11/26/2001 12:16:35 PMKelly Kingdon   added
--       ft_foreign_key_info
--  1    DevTSM    1.0         11/18/2001 6:58:43 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
