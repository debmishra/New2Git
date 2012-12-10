--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tsm10_drop_temp_indexes.sql$ 
--
-- $Revision: 8$        $Date: 2/27/2008 3:17:46 PM$
--
--
-- Description:  Drop indexes on temp_* tables
--
---------------------------------------------------------------------
 
drop index TEMP_IP_STUDY_PRICE_indx1;
drop index TEMP_ODC_indx1;
drop index TEMP_OVERHEAD_indx1;
drop index TEMP_PROCEDURE_indx1;
drop index TEMP_PROCEDURE_indx2;

quit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  8    DevTSM    1.7         2/27/2008 3:17:46 PM Debashish Mishra  
--  7    DevTSM    1.6         9/20/2006 11:34:14 AMDebashish Mishra remove temp13
--       references
--  6    DevTSM    1.5         9/19/2006 12:08:11 AMDebashish Mishra  removed
--       references to obsolete tables
--  5    DevTSM    1.4         3/3/2005 6:33:32 AM  Debashish Mishra   
--  4    DevTSM    1.3         3/3/2005 6:32:23 AM  Debashish Mishra  
--  3    DevTSM    1.2         10/22/2004 6:04:29 AMDebashish Mishra Added support
--       for new temp13 tables
--  2    DevTSM    1.1         8/29/2003 5:19:15 PM Debashish Mishra  
--  1    DevTSM    1.0         6/20/2003 10:21:01 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
