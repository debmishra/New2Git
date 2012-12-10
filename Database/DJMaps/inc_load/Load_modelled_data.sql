--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: Load_modelled_data.sql$ 
--
-- $Revision: 5$        $Date: 2/27/2008 3:17:05 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

spool c:\tsm\database\djmaps\inc_load\load_modelled_data.log

 
select 'modelled_coeff' from dual;
@c:\tsm\database\djmaps\inc_load\modelled_coeff &1
select 'modelled_inclusion' from dual;
@c:\tsm\database\djmaps\inc_load\modelled_inclusion &1
select 'modelled_standardize' from dual;
@c:\tsm\database\djmaps\inc_load\modelled_standardize &1
select 'modelled_cpp_fence' from dual;
@c:\tsm\database\djmaps\inc_load\modelled_cpp_fence &1
select 'md_odc_oh_pct' from dual;
@c:\tsm\database\djmaps\inc_load\md_odc_oh_pct &1


spool off

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/27/2008 3:17:05 PM Debashish Mishra  
--  4    DevTSM    1.3         2/7/2007 10:27:54 PM Debashish Mishra  
--  3    DevTSM    1.2         3/3/2005 6:40:18 AM  Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:13:08 PM Debashish Mishra  
--  1    DevTSM    1.0         10/28/2002 1:59:05 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
