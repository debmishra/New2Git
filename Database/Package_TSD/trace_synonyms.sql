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
-- $Revision: 3$        $Date: 2/27/2008 3:19:10 PM$
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
--  3    DevTSM    1.2         2/27/2008 3:19:10 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:38:04 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:27:00 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
