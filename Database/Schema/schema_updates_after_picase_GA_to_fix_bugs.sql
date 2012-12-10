--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_after_picase_GA_to_fix_bugs.sql$ 
--
-- $Revision: 9$        $Date: 2/22/2008 11:56:01 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
-- Following changes are made to fix some bugs in GM client build as per Kelly on 01/20/2003

Alter table "&1".currency modify (cnv_rate number(12,4));

update "&1".country set currency_id = null where abbreviation = 'RUM';
commit;

Alter table temp_odc modify (CPP number(16,2),CPV number(16,2),   
			     CPGV number(16,2),PAYMENT number(16,2));
Alter table temp_ip_study_price modify (CPP number(16,2),CPV number(16,2));
Alter table temp_procedure modify (PAYMENT number(16,2));
Alter table temp_overhead modify (ADJ_OTHER_PCT number(16,2), ADJ_OVRHD_PCT number(16,2), 
                                OVRHD_PCT number(16,2),PCT_PAID number(16,2));

--****************************************************************************
-- Implemented in qa,prev,production upto this point 
-- Implemented in tsm10e@test upto this point on 03/06/2003
--****************************************************************************

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  9    DevTSM    1.8         2/22/2008 11:56:01 AMDebashish Mishra  
--  8    DevTSM    1.7         9/19/2006 12:11:28 AMDebashish Mishra   
--  7    DevTSM    1.6         3/2/2005 10:51:01 PM Debashish Mishra  
--  6    DevTSM    1.5         8/29/2003 5:17:43 PM Debashish Mishra  
--  5    DevTSM    1.4         3/6/2003 6:53:54 PM  Debashish Mishra  
--  4    DevTSM    1.3         2/19/2003 1:48:16 PM Debashish Mishra  
--  3    DevTSM    1.2         2/4/2003 6:03:20 PM  Debashish Mishra  
--  2    DevTSM    1.1         1/20/2003 4:37:53 PM Debashish Mishra Modified
--       temp_* table columns to number(16,2)
--  1    DevTSM    1.0         1/20/2003 3:36:07 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
