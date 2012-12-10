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
-- $Revision: 1$        $Date: 12/3/2003 3:22:54 PM$
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




---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  1    DevTSM    1.0         12/3/2003 3:22:54 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
