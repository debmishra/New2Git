--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: investig.sql$ 
--
-- $Revision: 14$        $Date: 2/27/2008 3:16:39 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

--delete from investig1 where INCOMPLETE = 1 or sampled = 1 or
--MANAGED = 1;

--commit;


create index institution_dl_indx1 on institution(abbreviation);

update investig1 a set a.INSTITUTION_ID= (
select b.id from institution b where 
a.PICAS_INSTIT = b.abbreviation);

commit;

drop index institution_dl_indx1;

Alter table investig1 add(countryid number(10),
currencyid number(10), clientid number(10),protocolid number(10));

create index client_dl_indx1 on build_code(code);

create index investig1_dl_indx1 on investig1(client_id);

update investig1 a set a.clientid = (
select b.id from build_code b where 
a.client_id  = b.code );

commit;

drop index client_dl_indx1;
drop index investig1_dl_indx1;



update investig1 a set a.countryid = (
select b.id from country b where 
a.country_id  = b.abbreviation );

commit;

update investig1 a set a.currencyid = (
select b.id from country b where 
a.currency_id  = b.abbreviation );

commit;

create index protocol_dl_indx1 on protocol(build_code_id,picas_protocol);

create index investig1_dl_indx1 on 
investig1(clientid,protocol_id);

update investig1 a set a.protocolid = (
select b.id from protocol b where 
a.clientid = b.build_code_id and
a.protocol_id = b.picas_protocol);

commit;

drop index protocol_dl_indx1;
drop index investig1_dl_indx1;


Insert into investig (
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
from investig1 ;

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
--  14   DevTSM    1.13        2/27/2008 3:16:39 PM Debashish Mishra  
--  13   DevTSM    1.12        3/3/2005 6:38:56 AM  Debashish Mishra  
--  12   DevTSM    1.11        8/29/2003 5:11:44 PM Debashish Mishra  
--  11   DevTSM    1.10        3/6/2003 3:51:29 PM  Debashish Mishra Modified for
--       investig.facility
--  10   DevTSM    1.9         3/18/2002 7:42:16 PM Debashish Mishra  
--  9    DevTSM    1.8         3/13/2002 1:04:17 PM Debashish Mishra  
--  8    DevTSM    1.7         3/12/2002 4:40:10 PM Debashish Mishra  
--  7    DevTSM    1.6         3/8/2002 10:54:11 AM Debashish Mishra  
--  6    DevTSM    1.5         3/6/2002 7:03:22 PM  Debashish Mishra  
--  5    DevTSM    1.4         2/12/2002 12:19:56 PMDebashish Mishra  
--  4    DevTSM    1.3         2/5/2002 3:05:44 PM  Debashish Mishra  
--  3    DevTSM    1.2         2/5/2002 2:54:45 PM  Debashish Mishra  
--  2    DevTSM    1.1         1/28/2002 3:16:04 PM Debashish Mishra  
--  1    DevTSM    1.0         1/8/2002 6:37:14 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
