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
-- $Revision: 7$        $Date: 2/22/2008 11:55:25 AM$
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
--  7    DevTSM    1.6         2/22/2008 11:55:25 AMDebashish Mishra  
--  6    DevTSM    1.5         9/19/2006 12:11:00 AMDebashish Mishra   
--  5    DevTSM    1.4         3/2/2005 10:48:54 PM Debashish Mishra  
--  4    DevTSM    1.3         1/26/2005 7:00:38 AM Debashish Mishra  
--  3    DevTSM    1.2         4/8/2004 4:09:28 PM  Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:15:46 PM Debashish Mishra  
--  1    DevTSM    1.0         9/16/2002 3:46:46 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
