--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: static_data_id_control_2.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:08 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
Insert into id_control select 'ft15', 'aclentries', nvl(max(id),0)+1 from ACLENTRIES ;
Insert into id_control select 'ft15', 'client', nvl(max(id),0)+1 from CLIENT ;
Insert into id_control select 'ft15', 'ftgroup', nvl(max(id),0)+1 from FTGROUP ;
Insert into id_control select 'ft15', 'ftgroup_to_aclentries', nvl(max(id),0)+1 from FTGROUP_TO_ACLENTRIES ;
Insert into id_control select 'ft15', 'ftuser', nvl(max(id),0)+1 from FTUSER ;
Insert into id_control select 'ft15', 'ftuser_to_aclentries', nvl(max(id),0)+1 from FTUSER_TO_ACLENTRIES ;
Insert into id_control select 'ft15', 'ftuser_to_ftgroup', nvl(max(id),0)+1 from FTUSER_TO_FTGROUP ;
Insert into id_control select 'ft15', 'ft_foreign_key_info', nvl(max(id),0)+1 from FT_FOREIGN_KEY_INFO ;
Insert into id_control select 'ft15', 'protocol_version', nvl(max(id),0)+1 from PROTOCOL_VERSION ;
Insert into id_control select 'ft15', 'sponsor', nvl(max(id),0)+1 from SPONSOR ;
Insert into id_control select 'ft15', 'trial', nvl(max(id),0)+1 from TRIAL ;
Insert into id_control select 'ft15', 'trial_metrics_history', nvl(max(id),0)+1 from TRIAL_METRICS_HISTORY ;
Insert into id_control select 'ft15', 'usage_history', nvl(max(id),0)+1 from USAGE_HISTORY ;

commit;




exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:08 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:37:57 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:26:54 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
