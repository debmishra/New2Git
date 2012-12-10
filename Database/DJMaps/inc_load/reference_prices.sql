--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: reference_prices.sql$ 
--
-- $Revision: 5$        $Date: 8/5/2008 12:56:47 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
alter table tsm_stage.reference_prices1 add procedure_def_id    number(10);
alter table tsm_stage.reference_prices1 add build_code_id     number(10);
alter table tsm_stage.reference_prices1 add country_id     number(10);

update tsm_stage.reference_prices1 a set procedure_def_id = 
     (select b.id from "&1".procedure_def b where trim(a.procedure) = b.cpt_code);

update tsm_stage.reference_prices1 a set country_id = 
     (select b.id from "&1".country b where a.country = b.abbreviation);

update tsm_stage.reference_prices1 a set build_code_id = 
     (select b.id from "&1".build_code b where b.code = 'MCR');
--where a.country_id=24;

commit;

truncate table "&1".reference_prices;

insert into "&1".reference_prices (ID,PROCEDURE_DEF_ID,PAYMENT,COUNTRY_ID ,BUILD_CODE_ID, INTL_CODE) 
  select ID,PROCEDURE_DEF_ID,PAYMENT,COUNTRY_ID,BUILD_CODE_ID,INTL_CODE               
  from tsm_stage.reference_prices1;
--  where procedure_def_id is not null;
commit;
---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         8/5/2008 12:56:47 PM Debashish Mishra  
--  4    DevTSM    1.3         2/27/2008 3:17:13 PM Debashish Mishra  
--  3    DevTSM    1.2         1/25/2008 4:17:56 AM Debashish Mishra  
--  2    DevTSM    1.1         2/15/2007 4:47:15 PM Debashish Mishra  
--  1    DevTSM    1.0         12/4/2006 3:29:54 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
          