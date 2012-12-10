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
-- $Revision: 3$        $Date: 2/27/2008 3:19:11 PM$
--
--
-- Description:  Create synonyms in tsm10 for execution suite objects
--
---------------------------------------------------------------------
 
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
--  3    DevTSM    1.2         2/27/2008 3:19:11 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:38:10 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:27:05 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
