--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: modelled_cpp_fence.sql$ 
--
-- $Revision: 6$        $Date: 2/27/2008 3:17:09 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
Alter table tsm_stage.modelled_cpp_fence add(country_id number(10));

delete from tsm_stage.modelled_cpp_fence where country = 'xcntry';

update tsm_stage.modelled_cpp_fence set cpp_low = trim(cpp_low);
update tsm_stage.modelled_cpp_fence set cpp_high = trim(cpp_high);
update tsm_stage.modelled_cpp_fence set country = trim(country);

commit;

Insert into tsm_stage.modelled_cpp_fence(country,cpp_high,cpp_low)
select 'SWE',cpp_high,cpp_low from tsm_stage.modelled_cpp_fence
where country = 'SCAN';
Insert into tsm_stage.modelled_cpp_fence(country,cpp_high,cpp_low)
select 'NOR',cpp_high,cpp_low from tsm_stage.modelled_cpp_fence
where country = 'SCAN';
Insert into tsm_stage.modelled_cpp_fence(country,cpp_high,cpp_low)
select 'DEN',cpp_high,cpp_low from tsm_stage.modelled_cpp_fence
where country = 'SCAN';
Insert into tsm_stage.modelled_cpp_fence(country,cpp_high,cpp_low)
select 'FIN',cpp_high,cpp_low from tsm_stage.modelled_cpp_fence
where country = 'SCAN';

update tsm_stage.modelled_cpp_fence a set a.country_id = (select
b.id from "&1".country b where b.abbreviation = a.country) where
a.country <> 'SCAN';

commit;

truncate table "&1".modelled_cpp_fence;
drop sequence "&1".modelled_cpp_fence_seq;
create sequence "&1".modelled_cpp_fence_seq;

Insert into "&1".modelled_cpp_fence(id,country_id,cpp_low,cpp_high)
select "&1".modelled_cpp_fence_seq.nextval,country_id,cpp_low,cpp_high
from tsm_stage.modelled_cpp_fence where country <> 'SCAN';

commit;






---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         2/27/2008 3:17:09 PM Debashish Mishra  
--  5    DevTSM    1.4         2/7/2007 10:28:19 PM Debashish Mishra  
--  4    DevTSM    1.3         3/3/2005 6:40:40 AM  Debashish Mishra  
--  3    DevTSM    1.2         8/29/2003 5:13:25 PM Debashish Mishra  
--  2    DevTSM    1.1         10/22/2002 12:11:25 PMDebashish Mishra Bugs fixed
--  1    DevTSM    1.0         10/17/2002 4:09:14 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
