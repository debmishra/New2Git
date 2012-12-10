--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: pbtown_cost.sql$ 
--
-- $Revision: 7$        $Date: 2/27/2008 3:19:53 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 


alter table tsm_stage.cro_cost1 add cro_contract_id number(10);
alter table tsm_stage.cro_cost1 add cro_category_id number(10);
alter table tsm_stage.cro_cost1 add build_code_id number(10);

delete from tsm_stage.cro_cost1 where account in ('B','W');

update tsm_stage.cro_cost1 set account='B' where account='ZA';
update tsm_stage.cro_cost1 set account='W' where account='ZB';
commit;


update tsm_stage.cro_cost1 a set a.cro_category_id=
  (select b.id from "&1".cro_category b where b.category_account=a.account); 
commit;

update tsm_stage.cro_cost1 a set a.build_code_id=
  (select b.id from "&1".build_code b where b.code=a.sponsor); 
commit;

update tsm_stage.cro_cost1 a set a.cro_contract_id=
  (select b.id from "&1".cro_contract b where 
  nvl(b.build_code_id,99999999999)=nvl(a.build_code_id,99999999999) and b.contract=a.contract);
commit;


insert into "&1".cro_cost (id,CRO_CONTRACT_ID,CRO_CATEGORY_ID,COST,OVERLAP)
 select id,CRO_CONTRACT_ID,CRO_CATEGORY_ID,COST,nvl(OVERLAP,0) from tsm_stage.cro_cost1 where cro_category_id is not null;
commit;
 
update "&1".cro_cost a set a.cost = 
(select a.cost/b.cnv_rate_to_euro from 
"&1".local_to_euro b, "&1".cro_contract c 
where b.country_id = c.country_id and c.id=a.cro_contract_id) 
where exists (select 1 from 
"&1".local_to_euro b, "&1".cro_contract c
where a.cro_contract_id=c.id and c.country_id=b.country_id)
and a.cost > 0;
commit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/27/2008 3:19:53 PM Debashish Mishra  
--  6    DevTSM    1.5         3/29/2007 9:14:14 AM Debashish Mishra  
--  5    DevTSM    1.4         2/15/2007 6:03:00 PM Debashish Mishra updated for
--       euro data
--  4    DevTSM    1.3         1/4/2007 6:38:03 PM  Debashish Mishra  
--  3    DevTSM    1.2         11/10/2006 12:29:45 PMDebashish Mishra  
--  2    DevTSM    1.1         10/2/2006 10:07:00 PMDebashish Mishra  
--  1    DevTSM    1.0         9/28/2006 12:13:30 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
