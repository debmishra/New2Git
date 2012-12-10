--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: pbtown_cost_to_act_detail.sql$ 
--
-- $Revision: 7$        $Date: 9/22/2011 3:42:25 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------


drop sequence tsm_stage.cro_cost_to_act_detail_seq;
create sequence tsm_stage.cro_cost_to_act_detail_seq;

insert into "&1".cro_cost_to_act_detail (ID,CRO_COST_ID,CRO_ACTIVITY_DETAIL_ID ,NUMERIC_INPUT,ITEM_SEQ )
  select   tsm_stage.cro_cost_to_act_detail_seq.nextval,a.id, b.id, null, 1 
    from tsm_stage.cro_cost1 a, "&1".tsm_stage.cro_activity_detail b
    where a.cro_category_id is not null and a.cro_category_id = b.cro_category_id  and b.sub_id = 1 and b.input = 0
    and a.item1 = b.choice_id;

commit;

insert into "&1".cro_cost_to_act_detail (ID,CRO_COST_ID,CRO_ACTIVITY_DETAIL_ID ,NUMERIC_INPUT,ITEM_SEQ )
  select   tsm_stage.cro_cost_to_act_detail_seq.nextval,a.id, b.id, a.item1, 1 
    from tsm_stage.cro_cost1 a, "&1".tsm_stage.cro_activity_detail b
    where a.cro_category_id is not null and a.cro_category_id = b.cro_category_id  and b.sub_id = 1 and b.input = 1;
commit;             

insert into "&1".cro_cost_to_act_detail (ID,CRO_COST_ID,CRO_ACTIVITY_DETAIL_ID ,NUMERIC_INPUT,ITEM_SEQ )
  select   tsm_stage.cro_cost_to_act_detail_seq.nextval,a.id, b.id, null, 2 
    from tsm_stage.cro_cost1 a, "&1".tsm_stage.cro_activity_detail b
    where a.cro_category_id is not null and a.cro_category_id = b.cro_category_id  and b.sub_id = 2 and b.input = 0
    and a.item2 = b.choice_id;
commit;

insert into "&1".cro_cost_to_act_detail (ID,CRO_COST_ID,CRO_ACTIVITY_DETAIL_ID ,NUMERIC_INPUT,ITEM_SEQ )
  select   tsm_stage.cro_cost_to_act_detail_seq.nextval,a.id, b.id, a.item2, 2 
    from tsm_stage.cro_cost1 a, "&1".tsm_stage.cro_activity_detail b
    where a.cro_category_id is not null and a.cro_category_id = b.cro_category_id  and b.sub_id = 2 and b.input = 1;
commit;             

insert into "&1".cro_cost_to_act_detail (ID,CRO_COST_ID,CRO_ACTIVITY_DETAIL_ID ,NUMERIC_INPUT,ITEM_SEQ )
  select   tsm_stage.cro_cost_to_act_detail_seq.nextval,a.id, b.id, null, 3 
    from tsm_stage.cro_cost1 a, "&1".tsm_stage.cro_activity_detail b
    where a.cro_category_id is not null and a.cro_category_id = b.cro_category_id  and b.sub_id = 3 and b.input = 0
    and a.item3 = b.choice_id;
commit;             

insert into "&1".cro_cost_to_act_detail (ID,CRO_COST_ID,CRO_ACTIVITY_DETAIL_ID ,NUMERIC_INPUT,ITEM_SEQ )
  select   tsm_stage.cro_cost_to_act_detail_seq.nextval,a.id, b.id, a.item3, 3 
    from tsm_stage.cro_cost1 a, "&1".tsm_stage.cro_activity_detail b
    where a.cro_category_id is not null and a.cro_category_id = b.cro_category_id  and b.sub_id = 3 and b.input = 1;
commit;             

insert into "&1".cro_cost_to_act_detail (ID,CRO_COST_ID,CRO_ACTIVITY_DETAIL_ID ,NUMERIC_INPUT,ITEM_SEQ )
  select   tsm_stage.cro_cost_to_act_detail_seq.nextval,a.id, b.id, null, 4 
    from tsm_stage.cro_cost1 a, "&1".tsm_stage.cro_activity_detail b
    where a.cro_category_id is not null and a.cro_category_id = b.cro_category_id  and b.sub_id = 4 and b.input = 0
    and a.item4 = b.choice_id;
commit;             

insert into "&1".cro_cost_to_act_detail (ID,CRO_COST_ID,CRO_ACTIVITY_DETAIL_ID ,NUMERIC_INPUT,ITEM_SEQ )
  select   tsm_stage.cro_cost_to_act_detail_seq.nextval,a.id, b.id, a.item4, 4 
    from tsm_stage.cro_cost1 a, "&1".tsm_stage.cro_activity_detail b
    where a.cro_category_id is not null and a.cro_category_id = b.cro_category_id  and b.sub_id = 4 and b.input = 1;
commit;             

insert into "&1".cro_cost_to_act_detail (ID,CRO_COST_ID,CRO_ACTIVITY_DETAIL_ID ,NUMERIC_INPUT,ITEM_SEQ )
  select   tsm_stage.cro_cost_to_act_detail_seq.nextval,a.id, b.id, null, 5 
    from tsm_stage.cro_cost1 a, "&1".tsm_stage.cro_activity_detail b
    where a.cro_category_id is not null and a.cro_category_id = b.cro_category_id  and b.sub_id = 5 and b.input = 0
    and a.item5 = b.choice_id;
commit;             

insert into "&1".cro_cost_to_act_detail (ID,CRO_COST_ID,CRO_ACTIVITY_DETAIL_ID ,NUMERIC_INPUT,ITEM_SEQ )
  select   tsm_stage.cro_cost_to_act_detail_seq.nextval,a.id, b.id, a.item5, 5 
    from tsm_stage.cro_cost1 a, "&1".tsm_stage.cro_activity_detail b
    where a.cro_category_id is not null and a.cro_category_id = b.cro_category_id  and b.sub_id = 5 and b.input = 1;
commit;             

insert into "&1".cro_cost_to_act_detail (ID,CRO_COST_ID,CRO_ACTIVITY_DETAIL_ID ,NUMERIC_INPUT,ITEM_SEQ )
  select   tsm_stage.cro_cost_to_act_detail_seq.nextval,a.id, b.id, null, 6 
    from tsm_stage.cro_cost1 a, "&1".tsm_stage.cro_activity_detail b
    where a.cro_category_id is not null and a.cro_category_id = b.cro_category_id  and b.sub_id = 6 and b.input = 0
    and a.item6 = b.choice_id;
commit;             

insert into "&1".cro_cost_to_act_detail (ID,CRO_COST_ID,CRO_ACTIVITY_DETAIL_ID ,NUMERIC_INPUT,ITEM_SEQ )
  select   tsm_stage.cro_cost_to_act_detail_seq.nextval,a.id, b.id, a.item6, 6 
    from tsm_stage.cro_cost1 a, "&1".tsm_stage.cro_activity_detail b
    where a.cro_category_id is not null and a.cro_category_id = b.cro_category_id  and b.sub_id = 6 and b.input = 1;
commit;             


insert into "&1".cro_cost_to_act_detail (ID,CRO_COST_ID,CRO_ACTIVITY_DETAIL_ID ,NUMERIC_INPUT,ITEM_SEQ )
  select   tsm_stage.cro_cost_to_act_detail_seq.nextval,a.id, b.id, null, 7 
    from tsm_stage.cro_cost1 a, "&1".tsm_stage.cro_activity_detail b
    where a.cro_category_id is not null and a.cro_category_id = b.cro_category_id  and b.sub_id = 7 and b.input = 0
    and a.item7 = b.choice_id;
commit;             

insert into "&1".cro_cost_to_act_detail (ID,CRO_COST_ID,CRO_ACTIVITY_DETAIL_ID ,NUMERIC_INPUT,ITEM_SEQ )
  select   tsm_stage.cro_cost_to_act_detail_seq.nextval,a.id, b.id, a.item7, 7 
    from tsm_stage.cro_cost1 a, "&1".tsm_stage.cro_activity_detail b
    where a.cro_category_id is not null and a.cro_category_id = b.cro_category_id  and b.sub_id = 7 and b.input = 1;
commit;             


insert into "&1".cro_cost_to_act_detail (ID,CRO_COST_ID,CRO_ACTIVITY_DETAIL_ID ,NUMERIC_INPUT,ITEM_SEQ ) 
select   tsm_stage.cro_cost_to_act_detail_seq.nextval,a.id, b.id, null, 8 
    from tsm_stage.cro_cost1 a, "&1".tsm_stage.cro_activity_detail b
    where a.cro_category_id is not null and a.cro_category_id = b.cro_category_id  and b.sub_id = 8 and b.input = 0
    and a.item8 = b.choice_id;
commit;             

insert into "&1".cro_cost_to_act_detail (ID,CRO_COST_ID,CRO_ACTIVITY_DETAIL_ID ,NUMERIC_INPUT,ITEM_SEQ )
  select   tsm_stage.cro_cost_to_act_detail_seq.nextval,a.id, b.id, a.item8, 8 
    from tsm_stage.cro_cost1 a, "&1".tsm_stage.cro_activity_detail b
    where a.cro_category_id is not null and a.cro_category_id = b.cro_category_id  and b.sub_id = 8 and b.input = 1;
commit; 

--insert into "&1".cro_cost_to_act_detail (ID,CRO_COST_ID,CRO_ACTIVITY_DETAIL_ID ,NUMERIC_INPUT,ITEM_SEQ )
--  select   tsm_stage.cro_cost_to_act_detail_seq.nextval,a.id, null, a.item8, 8 
--    from tsm_stage.cro_cost1 a
--    where a.cro_category_id is not null and a.item8 > 0;
--commit;             


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         9/22/2011 3:42:25 PM Debashish Mishra  
--  6    DevTSM    1.5         2/27/2008 3:19:53 PM Debashish Mishra  
--  5    DevTSM    1.4         1/4/2007 6:38:03 PM  Debashish Mishra  
--  4    DevTSM    1.3         11/14/2006 10:34:51 AMDebashish Mishra Removed data
--       import for item_seq=8
--  3    DevTSM    1.2         11/10/2006 12:29:46 PMDebashish Mishra  
--  2    DevTSM    1.1         10/2/2006 10:07:01 PMDebashish Mishra  
--  1    DevTSM    1.0         9/28/2006 12:13:30 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------









 