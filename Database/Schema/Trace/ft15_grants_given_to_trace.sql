--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ft15_grants_given_to_trace.sql$ 
--
-- $Revision: 5$        $Date: 2/27/2008 3:17:30 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
grant select,insert, update, delete, references on protocol_version to "&1";


exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/27/2008 3:17:30 PM Debashish Mishra  
--  4    DevTSM    1.3         3/3/2005 6:31:38 AM  Debashish Mishra  
--  3    DevTSM    1.2         5/23/2002 5:25:51 PM Debashish Mishra  
--  2    DevTSM    1.1         4/15/2002 3:26:18 PM Debashish Mishra  
--  1    DevTSM    1.0         4/9/2002 1:59:13 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
