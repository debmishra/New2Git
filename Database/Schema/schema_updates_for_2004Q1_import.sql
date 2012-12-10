--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_for_2004Q1_import.sql$ 
--
-- $Revision: 4$        $Date: 2/22/2008 11:56:01 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

Alter table payments add(outlier_cd number(1) default 0 not null);
Alter table payments add constraint payments_outlier_cd_check
	check(outlier_cd in (0,1,2)); 




---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  4    DevTSM    1.3         2/22/2008 11:56:01 AMDebashish Mishra  
--  3    DevTSM    1.2         9/19/2006 12:11:30 AMDebashish Mishra   
--  2    DevTSM    1.1         3/2/2005 10:51:04 PM Debashish Mishra  
--  1    DevTSM    1.0         11/18/2003 4:12:21 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
