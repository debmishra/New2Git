--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tsm10_grants_given_to_ft15.sql$ 
--
-- $Revision: 10$        $Date: 2/22/2008 11:56:04 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
grant select,references on project to "&1";
grant select,references on indmap to "&1";
grant select,references on phase to "&1";
grant select,references on client_div to "&1";
grant select,references on currency to "&1";
grant select,references on client_div to "&1";
grant select,references on project_area to "&1";
grant execute on oracle_sendmail to "&1";
grant select on oracle_alert_config to "&1";
grant execute on increment_sequence to "&1";
grant select,insert,update,delete on audit_hist to "&1";




exit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  10   DevTSM    1.9         2/22/2008 11:56:04 AMDebashish Mishra  
--  9    DevTSM    1.8         9/19/2006 12:11:42 AMDebashish Mishra   
--  8    DevTSM    1.7         3/2/2005 10:51:13 PM Debashish Mishra  
--  7    DevTSM    1.6         11/16/2004 12:38:41 AMDebashish Mishra  
--  6    DevTSM    1.5         8/29/2003 5:17:48 PM Debashish Mishra  
--  5    DevTSM    1.4         3/18/2002 7:42:44 PM Debashish Mishra  
--  4    DevTSM    1.3         12/19/2001 3:43:34 PMDebashish Mishra  
--  3    DevTSM    1.2         12/19/2001 10:50:35 AMDebashish Mishra  
--  2    DevTSM    1.1         12/6/2001 5:46:30 PM Debashish Mishra  
--  1    DevTSM    1.0         11/18/2001 6:58:43 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
