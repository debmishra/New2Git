--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: payments_inc.sql$ 
--
-- $Revision: 4$        $Date: 2/27/2008 3:19:42 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
Alter table tsm_stage.payments1 add(protocolid number(10),
clientid number(10), currencyid number(10));



create index tsm_stage.payments1_dl_indx1 on 
tsm_stage.payments1(client_id);

update tsm_stage.payments1 a set a.clientid = (
select b.id from "&1".build_code b where 
a.client_id  = b.code);

commit;

drop index tsm_stage.payments1_dl_indx1;

create index tsm_stage.payments1_dl_indx1 on 
tsm_stage.payments1(clientid,protocol_id);

update tsm_stage.payments1 a set a.protocolid = (
select b.id from "&1".protocol b where 
a.clientid = b.build_code_id and
a.protocol_id = b.picas_protocol);

commit;


drop index tsm_stage.payments1_dl_indx1;

create index tsm_stage.payments1_dl_indx1 on 
tsm_stage.payments1(procedure_code);

update tsm_stage.PAYMENTS1 set PROCEDURE_CODE = 'VBED*' where  PROCEDURE_CODE =  '*BED*';
commit;
update tsm_stage.PAYMENTS1 set PROCEDURE_CODE = 'VDAY*' where  PROCEDURE_CODE =  '*DAY*';
commit;
update tsm_stage.PAYMENTS1 set PROCEDURE_CODE = 'VPHRM' where  PROCEDURE_CODE =  '*PHRM';
commit;
update tsm_stage.PAYMENTS1 set PROCEDURE_CODE = 'VREIM' where  PROCEDURE_CODE =  '*REIM';
commit;
update tsm_stage.PAYMENTS1 set PROCEDURE_CODE = 'VHOTL' where  PROCEDURE_CODE =  '*HOTL';
commit;

update tsm_stage.payments1 a set a.odc_def_id =
( select b.id from "&1".odc_def b where
b.picas_code = a.procedure_code and not b.id in(
select id from "&1".odc_def where procedure_level in ('Patient','Site','Visit')
and picas_code in ( select picas_code from "&1".odc_def where procedure_level in 
('PatientOrSite','PatientOrVisit'))));

commit;

update tsm_stage.payments1 a set a.procedure_def_id =
( select b.id from "&1".procedure_def b where
b.cpt_code = a.procedure_code and not b.id in(
select id from "&1".procedure_def where procedure_level in ('Patient','Site','Visit')
and cpt_code in ( select cpt_code from "&1".procedure_def where procedure_level in 
('PatientOrSite','PatientOrVisit'))));

commit;

update tsm_stage.payments1 set type='CLIN' where
procedure_def_id is not null;

commit;

update tsm_stage.payments1 set type='ODC' where
odc_def_id is not null;

commit;

drop index tsm_stage.payments1_dl_indx1;

create index tsm_stage.payments1_dl_indx1 on 
tsm_stage.payments1(currency_id);


update tsm_stage.payments1 a set a.currencyid=(
select b.id from "&1".country b where 
a.currency_id  = b.abbreviation );

drop index tsm_stage.payments1_dl_indx1;

Alter table tsm_stage.payments1 add(investig_id number(10));

create index tsm_stage.payments1_temp_indx1 on 
	tsm_stage.payments1(investigator_code,protocolid,clientid);


update tsm_stage.payments1 a set a.investig_id = (select b.id from "&1".investig b 
	where b.investigator_code = a.investigator_code and
	      b.protocol_id = a.protocolid and
	      b.build_code_id = a.clientid);

commit;

drop index tsm_stage.payments1_temp_indx1;



Insert into "&1".payments (ID,PROCEDURE_CODE,PAYMENT,TYPE,ODC_DEF_ID,
PROCEDURE_DEF_ID,PAYMENT_COUNTRY_ID,INVESTIG_ID )        
select
a.ID,a.PROCEDURE_CODE,       
a.PAYMENT,a.TYPE,a.odc_def_id, a.procedure_def_id, 
a.currencyid,a.INVESTIG_ID  
from   tsm_stage.payments1 a;

commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  4    DevTSM    1.3         2/27/2008 3:19:42 PM Debashish Mishra  
--  3    DevTSM    1.2         3/3/2005 6:41:49 AM  Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:14:44 PM Debashish Mishra  
--  1    DevTSM    1.0         2/19/2003 1:51:06 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
