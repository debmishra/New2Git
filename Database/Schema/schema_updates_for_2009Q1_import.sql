--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_for_2009Q1_import.sql$ 
--
-- $Revision: 1$        $Date: 1/2/2009 12:13:24 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------


alter table investig add outlier_inv number(1) default 0 not null;

alter table investig add constraint investig_outlier_inv_check check(outlier_inv in (0,1));


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  1    DevTSM    1.0         1/2/2009 12:13:24 PM Mahesh Pasupuleti 
-- $
-- 
---------------------------------------------------------------------
