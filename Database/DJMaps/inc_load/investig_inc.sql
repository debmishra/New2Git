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
-- $Revision: 13$        $Date: 1/2/2009 11:49:27 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

--delete from investig1 where INCOMPLETE = 1 or sampled = 1 or
--MANAGED = 1;

--commit;

truncate table "&1".payments;
delete from "&1".investig;
commit;

create index "&1".institution_dl_indx1 on "&1".institution(abbreviation);

update tsm_stage.investig1 a set a.INSTITUTION_ID= (
select b.id from "&1".institution b where 
a.PICAS_INSTIT = b.abbreviation);

commit;

drop index "&1".institution_dl_indx1;

Alter table tsm_stage.investig1 add(countryid number(10),
currencyid number(10), clientid number(10),protocolid number(10));

create index "&1".client_dl_indx1 on "&1".build_code(code);

create index tsm_stage.investig1_dl_indx1 on tsm_stage.investig1(client_id);

update tsm_stage.investig1 a set a.clientid = (
select b.id from "&1".build_code b where 
a.client_id  = b.code );

commit;

drop index "&1".client_dl_indx1;
drop index tsm_stage.investig1_dl_indx1;



update tsm_stage.investig1 a set a.countryid = (
select b.id from "&1".country b where 
a.country_id  = b.abbreviation );

commit;

update tsm_stage.investig1 a set a.currencyid = (
select b.id from "&1".country b where 
a.currency_id  = b.abbreviation );

commit;

create index "&1".protocol_dl_indx1 on "&1".protocol(build_code_id,picas_protocol);

create index tsm_stage.investig1_dl_indx1 on 
tsm_stage.investig1(clientid,protocol_id);

update tsm_stage.investig1 a set a.protocolid = (
select b.id from "&1".protocol b where 
a.clientid = b.build_code_id and
a.protocol_id = b.picas_protocol);

commit;

drop index "&1".protocol_dl_indx1;
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
INCOMPLETE,sampled,managed,facility,outlier_inv)
select
ID,PROTOCOLID,TOTAL_PAYMENT,OTHER_FEE,OVERHEAD,IRB_FEE,                
FIXED_FEE,DROPPED_PAT_FEE,DROPPED_PATIENTS,FAILURE_FEE,FAILED_PATIENTS,        
GRANT_ADJUSTMENT,GRANT_ADJUST_CODE,LAB_COST,GRANT_TOTAL,            
COUNTRYID,AFFILIATION,ZIP_CODE,PATIENTS,PCT_PAID,GRANT_DATE,             
OVERHEAD_BASIS,OVERHEAD_PCT,PRIMARY_FLAG,CRO_USED,ADJ_OVRHD_PCT,          
ADJ_OTHER_PCT,BURDEN_PCT,INSTITUTION_ID,REGION_ID,METRO_REGION_ID,        
STATE_REGION_ID,INVESTIGATOR_ID,CURRENCYID,CLIENTID,no_pay,no_proc,
INCOMPLETE,sampled,managed ,facility, outlier_inv 
from tsm_stage.investig1 ;

commit;

update "&1".protocol set phase_id=-2 where phase_id=-1 and id in (
select protocol_id from "&1".investig a, "&1".build_code b where
a.build_code_id=b.id and b.code='MCR');

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
--  13   DevTSM    1.12        1/2/2009 11:49:27 AM Debashish Mishra updated for
--       outlier_inv
--  12   DevTSM    1.11        2/27/2008 3:17:06 PM Debashish Mishra  
--  11   DevTSM    1.10        2/7/2007 10:28:02 PM Debashish Mishra  
--  10   DevTSM    1.9         4/28/2006 6:22:07 AM Debashish Mishra  
--  9    DevTSM    1.8         2/2/2006 12:41:14 PM Debashish Mishra  
--  8    DevTSM    1.7         3/3/2005 6:40:24 AM  Debashish Mishra  
--  7    DevTSM    1.6         8/29/2003 5:13:12 PM Debashish Mishra  
--  6    DevTSM    1.5         5/8/2003 3:05:21 PM  Debashish Mishra Added facility
--       column back after 03q2 import
--  5    DevTSM    1.4         5/6/2003 9:36:30 AM  Debashish Mishra Fixed the
--       spelling mistake in ophthalmology
--  4    DevTSM    1.3         3/6/2003 3:51:37 PM  Debashish Mishra Modified for
--       investig.facility
--  3    DevTSM    1.2         8/30/2002 12:43:08 PMDebashish Mishra Modified for
--       passing the schema name as an parameter
--  2    DevTSM    1.1         3/22/2002 12:51:46 PMDebashish Mishra  
--  1    DevTSM    1.0         3/20/2002 9:24:07 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
