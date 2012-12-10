--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: investig_inc.sql$ 
--
-- $Revision: 5$        $Date: 2/27/2008 3:19:41 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

--delete from investig1 where INCOMPLETE = 1 or sampled = 1 or
--MANAGED = 1;

--commit;



update tsm_stage.investig1 a set a.INSTITUTION_ID= (
select b.id from "&1".institution b where 
a.PICAS_INSTIT = b.abbreviation);

commit;



Alter table tsm_stage.investig1 add(countryid number(10),
currencyid number(10), clientid number(10),protocolid number(10));



create index tsm_stage.investig1_dl_indx1 on tsm_stage.investig1(client_id);

update tsm_stage.investig1 a set a.clientid = (
select b.id from "&1".build_code b where 
a.client_id  = b.code );

commit;


drop index tsm_stage.investig1_dl_indx1;



update tsm_stage.investig1 a set a.countryid = (
select b.id from "&1".country b where 
a.country_id  = b.abbreviation );

commit;

update tsm_stage.investig1 a set a.currencyid = (
select b.id from "&1".country b where 
a.currency_id  = b.abbreviation );

commit;



create index tsm_stage.investig1_dl_indx1 on 
tsm_stage.investig1(clientid,protocol_id);

update tsm_stage.investig1 a set a.protocolid = (
select b.id from "&1".protocol b where 
a.clientid = b.build_code_id and
a.protocol_id = b.picas_protocol);

commit;

drop index tsm_stage.investig1_dl_indx1;


Insert into "&1".investig (
ID,PROTOCOL_ID,TOTAL_PAYMENT,OTHER_FEE,              
OVERHEAD,IRB_FEE,FIXED_FEE,DROPPED_PAT_FEE,        
DROPPED_PATIENTS,FAILURE_FEE,FAILED_PATIENTS,GRANT_ADJUSTMENT,       
GRANT_ADJUST_CODE,LAB_COST,GRANT_TOTAL,COUNTRY_ID,             
AFFILIATION,ZIP_CODE,PATIENTS,PCT_PAID,GRANT_DATE,OVERHEAD_BASIS,         
OVERHEAD_PCT,PRIMARY_FLAG,CRO_USED,ADJ_OVRHD_PCT,ADJ_OTHER_PCT,          
BURDEN_PCT,INSTITUTION_ID,REGION,METRO,STATE,
INVESTIGATOR_CODE,PAYMENT_COUNTRY_ID,build_code_ID,no_pay,no_proc,
INCOMPLETE,sampled,managed,facility)
select
ID,PROTOCOLID,TOTAL_PAYMENT,OTHER_FEE,OVERHEAD,IRB_FEE,                
FIXED_FEE,DROPPED_PAT_FEE,DROPPED_PATIENTS,FAILURE_FEE,FAILED_PATIENTS,        
GRANT_ADJUSTMENT,GRANT_ADJUST_CODE,LAB_COST,GRANT_TOTAL,            
COUNTRYID,AFFILIATION,ZIP_CODE,PATIENTS,PCT_PAID,GRANT_DATE,             
OVERHEAD_BASIS,OVERHEAD_PCT,PRIMARY_FLAG,CRO_USED,ADJ_OVRHD_PCT,          
ADJ_OTHER_PCT,BURDEN_PCT,INSTITUTION_ID,REGION_ID,METRO_REGION_ID,        
STATE_REGION_ID,INVESTIGATOR_ID,CURRENCYID,CLIENTID,no_pay,no_proc,
INCOMPLETE,sampled,managed,facility
from tsm_stage.investig1 ;

commit;

-- Update investig set affiliation='Both' where affiliation is null;

-- commit;
-- Following changes are as per request of Kelly on 03/05/2002

--update investig set grant_adjustment = 0 where
--grant_adjustment is null or grant_adjustment = -1;

--commit;

--update investig set GRANT_TOTAL = 0 where GRANT_TOTAL is null;
--commit;
--update investig set failure_fee= 0 where failure_fee is null;
--commit;
--update investig set LAB_COST=0 where lab_COST is null;
--commit;
--update investig set irb_fee=0 where irb_fee is null;
--commit;
--update investig set fixed_fee=0 where fixed_fee is null;
--commit;

--update investig set INCOMPLETE = 0 where incomplete is null;
--commit;

--update investig set sampled = 0 where sampled is null;
--commit;

--update investig set managed = 0 where managed is null;
--commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/27/2008 3:19:41 PM Debashish Mishra  
--  4    DevTSM    1.3         3/3/2005 6:41:42 AM  Debashish Mishra  
--  3    DevTSM    1.2         8/29/2003 5:14:38 PM Debashish Mishra  
--  2    DevTSM    1.1         3/6/2003 3:51:46 PM  Debashish Mishra Modified for
--       investig.facility
--  1    DevTSM    1.0         2/19/2003 1:51:01 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
