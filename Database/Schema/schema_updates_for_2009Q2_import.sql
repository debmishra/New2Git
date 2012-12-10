--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_for_2009Q2_import.sql$ 
--
-- $Revision: 1$        $Date: 4/9/2009 2:25:17 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------


ALTER TABLE protocol add( complexity_val NUMBER(12,2) NULL);
 
ALTER TABLE procedure_def add( complexity_val NUMBER(12,2) NULL);

ALTER TABLE trial_budget add( complexity_val NUMBER(12,2) NULL);

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  1    DevTSM    1.0         4/9/2009 2:25:17 PM  Mahesh Pasupuleti 
-- $
-- 
---------------------------------------------------------------------
