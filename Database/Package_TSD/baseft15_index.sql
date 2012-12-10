--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: baseft15_index.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:07 PM$
--
--
-- Description:  Add indices.
--
---------------------------------------------------------------------
 
create index Trial_index1 on Trial(disease_id) 
tablespace ftsmall_indx ;
create index Protocol_Version_index1 on Protocol_Version(trial_ID) 
tablespace ftlarge_indx ;
create index Criterion_index1 on Criterion(protocol_version_ID) 
tablespace ftlarge_indx ;
create index Site_to_Trial_index1 on Site_to_Trial(trial_ID, site_ID, protocol_version_id) 
tablespace ftsmall_indx ;
create index Site_to_Trial_index2 on Site_to_Trial(site_ID) 
tablespace ftsmall_indx ;
create index HH_Device_index1 on HandHeld_Device(handheld_group_id) 
tablespace ftsmall_indx ;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:07 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:37:49 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:26:47 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
