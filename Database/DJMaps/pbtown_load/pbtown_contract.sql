--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: pbtown_contract.sql$ 
--
-- $Revision: 6$        $Date: 2/27/2008 3:19:52 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

alter table tsm_stage.cro_contract1 add cro_name_master_id number(10);
alter table tsm_stage.cro_contract1 add protocol_id number(10);
alter table tsm_stage.cro_contract1 add currency_id number(10);
alter table tsm_stage.cro_contract1 add indmap_id number(10);
alter table tsm_stage.cro_contract1 add country_id number(10);
alter table tsm_stage.cro_contract1 add s_country_id number(10);
alter table tsm_stage.cro_contract1 add ta_code varchar2(80);
alter table tsm_stage.cro_contract1 add client_div_id number(10);

update tsm_stage.cro_contract1 a set cro_name_master_id = 
  ( select id from "&1".cro_name_master b where b.cro_name = a.cro);

commit;

alter table tsm_stage.cro_contract1 add build_code_id number(10);

update tsm_stage.cro_contract1 set build_code_id=(select id from "&1".build_code
where "&1".build_code.code=tsm_stage.cro_contract1.sponsor);

commit;

create sequence tsm_stage.cro_protocol_seq;
insert into "&1".cro_protocol 
select tsm_stage.cro_protocol_seq.nextval, build_code_id, protocol
from (select distinct build_code_id, protocol from tsm_stage.cro_contract1);
commit;
drop sequence tsm_stage.cro_protocol_seq;

update tsm_stage.cro_contract1 a set a.protocol_id =
  (select id from "&1".cro_protocol b where b.cro_protocol = a.protocol and
  nvl(b.build_code_id,99999999999)=nvl(a.build_code_id,9999999999));
commit;

update tsm_stage.cro_contract1 a set a.currency_id = (select currency_id 
 from "&1".country b where b.abbreviation = a.curr);
commit;
update tsm_stage.cro_contract1 set ta_code = 'CARDIOVASCULAR' where TA = 'A';
update tsm_stage.cro_contract1 set ta_code = 'GASTROINTESTINAL' where TA = 'B';
update tsm_stage.cro_contract1 set ta_code = 'CENTRAL NERVOUS SYSTEM' where TA = 'C';
update tsm_stage.cro_contract1 set ta_code = 'ANTI-INFECTIVE' where TA = 'D';
update tsm_stage.cro_contract1 set ta_code = 'ONCOLOGY' where TA = 'E';
update tsm_stage.cro_contract1 set ta_code = 'IMMUNOMODULATION' where TA = 'F';
update tsm_stage.cro_contract1 set ta_code = 'DERMATOLOGY' where TA = 'H';
update tsm_stage.cro_contract1 set ta_code = 'ENDOCRINE' where TA = 'I';
update tsm_stage.cro_contract1 set ta_code = 'PHARMACOKINETIC' where TA = 'K';
update tsm_stage.cro_contract1 set ta_code = 'HEMATOLOGY' where TA = 'L';
update tsm_stage.cro_contract1 set ta_code = 'OPHTHALMOLOGY' where TA = 'M';
update tsm_stage.cro_contract1 set ta_code = 'GENITOURINARY SYSTEM' where TA = 'N';
update tsm_stage.cro_contract1 set ta_code = 'RESPIRATORY SYSTEM' where TA = 'O';
update tsm_stage.cro_contract1 set ta_code = 'PAIN AND ANESTHESIA' where TA = 'P';
update tsm_stage.cro_contract1 set ta_code = 'DEVICES AND DIAGNOSTICS' where TA = 'Q';
update tsm_stage.cro_contract1 set ta_code = 'UNKNOWN THERAPEUTIC AREA' where TA = '-1';

commit;

update tsm_stage.cro_contract1 a set a.indmap_id = 
  (select id from "&1".indmap b where a.ta_code = b.code and b.type = 'Therapeutic Area');
commit;

update tsm_stage.cro_contract1 a set a.country_id =
  ( select id from "&1".country b where b.abbreviation = a.cntry);
commit;

update tsm_stage.cro_contract1 a set a.s_country_id =
  ( select id from "&1".country b where b.abbreviation = a.s_cntry);
commit;

update tsm_stage.cro_contract1 set client_div_id=(select id from "&1".client_div
where "&1".client_div.client_div_identifier=tsm_stage.cro_contract1.sponsor);

commit;

insert into "&1".cro_contract(ID,CRO_NAME_MASTER_ID,CRO_SIZE,CONTRACT,CLIENT_DIV_ID,          
BUILD_CODE_ID,COMMENTS,PROTOCOL_ID,INDMAP_ID,COUNTRY_ID,S_COUNTRY_ID,PROJECT_ID,PHASE_ID,STATUS,                 
PHASE1TYPE_ID,PENROLLMN,DAYORWEEK,LAB,TOTALVISIT,LABVISIT,DURATION,INDAYS,PSCREEN,                
PENROLLED,PCOMPLET,PEVALUAB,STARTDATE,ENDDATE,CURRENCY_ID,AMOUNT,INITIAL_VAL,PCTPAID,               
OVERHEADPCT,OVERHEADBAS,ENTDATE,OVRHEADAMT,OVERHEADOVL,TITLE,SITEMON,HRLYRATES,DISCOUNT,               
INVFEES,DRUG) select id,cro_name_master_id,CRO_SIZE,CONTRACT, CLIENT_DIV_ID,                   
BUILD_CODE_ID,COMMENTS,PROTOCOL_ID,INDMAP_ID,COUNTRY_ID,S_COUNTRY_ID,null,PHASE_ID,STATUS,
PHASE1TYPE_ID,PENROLLMN,DAYORWEEK,LAB,TOTALVISIT,LABVISIT,DURATION,INDAYS,PSCREEN,
PENROLLED,PCOMPLET,PEVALUAB,STARTDATE,ENDDATE,CURRENCY_ID,AMOUNT,INITIAL_VAL,PCTPAID,
OVRHEADPCT,OVRHEADBAS,ENTDATE,OVRHEADAMT,OVRHEADOVL,TITLE,SITEMON,nvl(HRLYRATES,0),DISCOUNT,
INVFEES,DRUG from tsm_stage.cro_contract1;
commit;

update "&1".cro_contract a set a.amount = 
(select a.amount/b.cnv_rate_to_euro from 
"&1".local_to_euro b where b.country_id = a.country_id)
where a.country_id in (select country_id from "&1".local_to_euro)
and a.amount > 0;

update "&1".cro_contract a set a.initial_val = 
(select a.initial_val/b.cnv_rate_to_euro from 
"&1".local_to_euro b where b.country_id = a.country_id)
where a.country_id in (select country_id from "&1".local_to_euro)
and a.initial_val > 0;
commit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         2/27/2008 3:19:52 PM Debashish Mishra  
--  5    DevTSM    1.4         3/29/2007 9:14:13 AM Debashish Mishra  
--  4    DevTSM    1.3         2/15/2007 6:02:59 PM Debashish Mishra updated for
--       euro data
--  3    DevTSM    1.2         11/10/2006 12:29:44 PMDebashish Mishra  
--  2    DevTSM    1.1         10/2/2006 10:06:59 PMDebashish Mishra  
--  1    DevTSM    1.0         9/28/2006 12:13:29 PMDebashish Mishra 
-- $
-- 
--------------------------------------------------------------------

