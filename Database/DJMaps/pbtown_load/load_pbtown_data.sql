--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: load_pbtown_data.sql$ 
--
-- $Revision: 6$        $Date: 9/16/2011 2:21:51 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 

spool c:\tsm\database\djmaps\pbtown_load\load_pbtown.log

truncate table "&1".Cro_contract_to_country;
truncate table "&1".Cro_cost_to_act_detail;
delete from "&1".Cro_activity_detail;
truncate table "&1".Cro_cost_overlap;
--delete from "&1".Cro_cost;
--delete from "&1".Cro_contract;
--delete from "&1".Cro_name_master;
--delete from "&1".cro_protocol;
commit;

sho err

--select 'cro_name_master' from dual;
--@c:\tsm\database\djmaps\pbtown_load\pbtown_name_master &1
--select 'cro_contract' from dual;
--@c:\tsm\database\djmaps\pbtown_load\pbtown_contract.sql &1
--select 'cro_cost' from dual;
--@c:\tsm\database\djmaps\pbtown_load\pbtown_cost.sql &1
select 'cro_cost_overlap' from dual;
@c:\tsm\database\djmaps\pbtown_load\pbtown_cost_overlap.sql &1
select 'Cro_activity_detail' from dual;
@c:\tsm\database\djmaps\pbtown_load\pbtown_activity_detail.sql &1
select 'Cro_cost_to_act_detail' from dual;
@c:\tsm\database\djmaps\pbtown_load\pbtown_cost_to_act_detail.sql &1
select 'Cro_contract_to_country' from dual;
@c:\tsm\database\djmaps\pbtown_load\pbtown_contract_to_country.sql  &1

update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".cro_protocol) where table_name='cro_protocol';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".cro_name_master) where table_name='cro_name_master';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".cro_contract) where table_name='cro_contract';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".cro_cost) where table_name='cro_cost';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".cro_cost_overlap) where table_name='cro_cost_overlap';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".Cro_activity_detail) where table_name='cro_activity_detail';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".Cro_cost_to_act_detail) where table_name='cro_cost_to_act_detail';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".Cro_contract_to_country) where table_name='cro_contract_to_country';

commit;

spool off


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         9/16/2011 2:21:51 PM Debashish Mishra  
--  5    DevTSM    1.4         2/27/2008 3:19:52 PM Debashish Mishra  
--  4    DevTSM    1.3         3/29/2007 9:14:13 AM Debashish Mishra  
--  3    DevTSM    1.2         1/20/2007 2:28:29 PM Debashish Mishra  
--  2    DevTSM    1.1         1/4/2007 6:38:02 PM  Debashish Mishra  
--  1    DevTSM    1.0         11/10/2006 12:30:19 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------