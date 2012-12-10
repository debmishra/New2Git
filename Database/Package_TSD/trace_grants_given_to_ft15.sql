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
-- $Revision: 3$        $Date: 2/27/2008 3:19:09 PM$
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
--  3    DevTSM    1.2         2/27/2008 3:19:09 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:38:03 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:26:59 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
