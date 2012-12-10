--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: trace_grants_given_to_ft15.sql$ 
--
-- $Revision: 6$        $Date: 2/27/2008 3:17:31 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
grant select,references on drug_class to "&1";
grant select,references on drug_code to "&1";
--grant select,references on trace_audit_history to "&1";





exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         2/27/2008 3:17:31 PM Debashish Mishra  
--  5    DevTSM    1.4         3/3/2005 6:31:46 AM  Debashish Mishra  
--  4    DevTSM    1.3         7/11/2002 4:31:50 PM Debashish Mishra Modified for
--       deleted tables after beta
--  3    DevTSM    1.2         5/23/2002 5:25:52 PM Debashish Mishra  
--  2    DevTSM    1.1         4/15/2002 3:26:21 PM Debashish Mishra  
--  1    DevTSM    1.0         4/9/2002 1:59:14 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
