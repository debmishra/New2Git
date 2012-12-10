--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: trace_synonyms.sql$ 
--
-- $Revision: 6$        $Date: 2/27/2008 3:17:32 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
Drop synonym protocol_version;


create synonym protocol_version for "&1".protocol_version;








exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         2/27/2008 3:17:32 PM Debashish Mishra  
--  5    DevTSM    1.4         3/3/2005 6:31:47 AM  Debashish Mishra  
--  4    DevTSM    1.3         6/4/2002 8:52:42 AM  Debashish Mishra Modified for
--       constraints stuff
--  3    DevTSM    1.2         5/23/2002 5:25:53 PM Debashish Mishra  
--  2    DevTSM    1.1         4/15/2002 3:26:22 PM Debashish Mishra  
--  1    DevTSM    1.0         4/9/2002 1:59:14 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
