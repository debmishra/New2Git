--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ft15_grants_given_to_ftcommon.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:07 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
grant select on ftuser to "&1";
grant select on ftgroup to "&1";
grant select on ftuser_to_ftgroup to "&1";
grant update (locked) on ftuser to "&1";
grant update (failed_login_attempts) on ftuser to "&1";





exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:07 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:37:52 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:26:50 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
