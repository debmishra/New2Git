--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ftcommon_constraints.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:08 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
Alter table application add constraint application_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 10;

Alter table application add constraint application_app_name_check 
	check(app_name in 
	('PICASE', 'TRACE','TSPD','FTADMIN'));






exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:08 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:37:54 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:26:52 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
