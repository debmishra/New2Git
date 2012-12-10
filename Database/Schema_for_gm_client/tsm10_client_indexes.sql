--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tsm10_client_indexes.sql$ 
--
-- $Revision: 7$        $Date: 6/28/2011 10:15:37 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

create index INDUSTRY_PAP_ODC_COST_index1 on
INDUSTRY_PAP_ODC_COST(country_id,mapper_id,phase_id,indmap_id)
tablespace tsmlarge_indx pctfree 20;

create index company_PAP_ODC_COST_index1 on
company_PAP_ODC_COST(country_id,mapper_id,phase_id,indmap_id)
tablespace tsmlarge_indx pctfree 20;

create index gm_proc_freq_indx1 on
gm_proc_freq (mapper_id,indmap_id,phase_id)
tablespace tsmlarge_indx pctfree 5;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         6/28/2011 10:15:37 AMDebashish Mishra Added index
--       for gm_proc_freq
--  6    DevTSM    1.5         2/27/2008 3:17:45 PM Debashish Mishra  
--  5    DevTSM    1.4         9/19/2006 12:08:09 AMDebashish Mishra  removed
--       references to obsolete tables
--  4    DevTSM    1.3         3/3/2005 6:33:29 AM  Debashish Mishra   
--  3    DevTSM    1.2         3/3/2005 6:32:20 AM  Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:19:13 PM Debashish Mishra  
--  1    DevTSM    1.0         6/13/2003 8:02:42 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------