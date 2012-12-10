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
-- $Revision: 1$        $Date: 12/3/2003 3:22:51 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
grant select,references on drug_class to "&1";
grant select,references on drug_code to "&1";
--grant select,references on trace_audit_history to "&1";







---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  1    DevTSM    1.0         12/3/2003 3:22:51 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
