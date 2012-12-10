--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: Load_ipm_data.sql$ 
--
-- $Revision: 6$        $Date: 2/27/2008 3:17:05 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

spool c:\tsm\database\djmaps\inc_load\load_ipm_data.log

select 'ipm_ph2to4_coeff' from dual;
@c:\tsm\database\djmaps\inc_load\ipm_ph2to4_coeff &1
select 'ipm_ph2to4_adj_coeff' from dual;
@c:\tsm\database\djmaps\inc_load\ipm_ph2to4_adj_coeff &1
select 'ipm_ph2to4_lkup_coeff' from dual;
@c:\tsm\database\djmaps\inc_load\ipm_ph2to4_lkup_coeff &1
select 'ipm_cpp' from dual;
@c:\tsm\database\djmaps\inc_load\ipm_cpp &1
select 'ipm_weight' from dual;
@c:\tsm\database\djmaps\inc_load\ipm_weight &1
select 'ipm_std' from dual;
@c:\tsm\database\djmaps\inc_load\ipm_std &1 

update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".ipm_ph2to4_lkup_coeff) where table_name='ipm_ph2to4_lkup_coeff';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".ipm_ph2to4_coeff) where table_name='ipm_ph2to4_coeff';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".ipm_ph2to4_adj_coeff) where table_name='ipm_ph2to4_adj_coeff';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".ipm_cpp) where table_name='ipm_cpp';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".ipm_weight) where table_name='ipm_weight';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".ipm_std) where table_name='ipm_std';
commit;

spool off

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         2/27/2008 3:17:05 PM Debashish Mishra  
--  5    DevTSM    1.4         2/7/2007 10:27:53 PM Debashish Mishra  
--  4    DevTSM    1.3         3/3/2005 6:40:17 AM  Debashish Mishra  
--  3    DevTSM    1.2         11/19/2003 12:50:13 PMDebashish Mishra Cleaned them
--       up for 1.1 patch release
--  2    DevTSM    1.1         8/29/2003 5:13:08 PM Debashish Mishra  
--  1    DevTSM    1.0         3/14/2003 6:26:20 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
