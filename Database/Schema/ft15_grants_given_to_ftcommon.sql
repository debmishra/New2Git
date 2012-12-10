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
-- $Revision: 9$        $Date: 2/22/2008 11:55:23 AM$
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
--  9    DevTSM    1.8         2/22/2008 11:55:23 AMDebashish Mishra  
--  8    DevTSM    1.7         9/19/2006 12:10:49 AMDebashish Mishra   
--  7    DevTSM    1.6         3/2/2005 10:48:49 PM Debashish Mishra  
--  6    DevTSM    1.5         11/16/2004 12:38:29 AMDebashish Mishra  
--  5    DevTSM    1.4         4/8/2004 4:09:26 PM  Debashish Mishra  
--  4    DevTSM    1.3         8/29/2003 5:15:41 PM Debashish Mishra  
--  3    DevTSM    1.2         9/23/2002 11:34:17 AMDebashish Mishra  
--  2    DevTSM    1.1         9/12/2002 9:05:54 AM Debashish Mishra New views in
--       ftcommon
--  1    DevTSM    1.0         8/20/2002 12:47:52 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
