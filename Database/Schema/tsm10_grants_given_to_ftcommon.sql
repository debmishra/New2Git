--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tsm10_grants_given_to_ftcommon.sql$ 
--
-- $Revision: 8$        $Date: 2/22/2008 11:56:05 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
grant select on client_div to "&1";
grant select on ftuser_to_client_group to "&1";
grant select on CLIENT_DIV_TO_LIC_APP to "&1";
grant select on password_rule to "&1";
grant select on password_rule to "&1";
grant select on client_div_to_lic_app to "&1";






exit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  8    DevTSM    1.7         2/22/2008 11:56:05 AMDebashish Mishra  
--  7    DevTSM    1.6         9/19/2006 12:11:43 AMDebashish Mishra   
--  6    DevTSM    1.5         3/2/2005 10:51:14 PM Debashish Mishra  
--  5    DevTSM    1.4         11/16/2004 12:38:42 AMDebashish Mishra  
--  4    DevTSM    1.3         4/8/2004 4:09:34 PM  Debashish Mishra  
--  3    DevTSM    1.2         8/29/2003 5:17:48 PM Debashish Mishra  
--  2    DevTSM    1.1         9/23/2002 11:34:17 AMDebashish Mishra  
--  1    DevTSM    1.0         9/12/2002 9:06:16 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
