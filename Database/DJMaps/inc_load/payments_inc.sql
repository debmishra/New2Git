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
-- $Revision: 11$        $Date: 2/27/2008 3:17:12 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
Alter table tsm_stage.payments1 add(protocolid number(10),
clientid number(10), currencyid number(10));

create index "&1".client_dl_indx1 on "&1".build_code(code);

create index tsm_stage.payments1_dl_indx1 on 
tsm_stage.payments1(client_id);

update tsm_stage.payments1 a set a.clientid = (
select b.id from "&1".build_code b where 
a.client_id  = b.code);

commit;

drop index tsm_stage.payments1_dl_indx1;

drop index "&1".client_dl_indx1;

create index "&1".protocol_dl_indx1 on "&1".protocol(build_code_id,picas_protocol);

create index tsm_stage.payments1_dl_indx1 on 
tsm_stage.payments1(clientid,protocol_id);

update tsm_stage.payments1 a set a.protocolid = (
select b.id from "&1".protocol b where 
a.clientid = b.build_code_id and
a.protocol_id = b.picas_protocol);

commit;

drop index "&1".protocol_dl_indx1;
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


create index "&1".procedure_def_dl_indx1 on
"&1".procedure_def(cpt_code);

create index "&1".odc_def_dl_indx1 on
"&1".odc_def(picas_code);

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


drop index "&1".procedure_def_dl_indx1;

drop index "&1".odc_def_dl_indx1;


create index tsm_stage.payments1_dl_indx1 on 
tsm_stage.payments1(currency_id);


update tsm_stage.payments1 a set a.currencyid=(
select b.id from "&1".country b where 
a.currency_id  = b.abbreviation );

drop index tsm_stage.payments1_dl_indx1;

Alter table tsm_stage.payments1 add(investig_id number(10));

create index tsm_stage.payments1_temp_indx1 on 
	tsm_stage.payments1(investigator_code,protocolid,clientid)
	tablespace tsmlarge nologging;

create index "&1".investig_temp_indx1 on 
	"&1".investig(investigator_code,protocol_id,build_code_id)
	tablespace tsmlarge nologging;

update tsm_stage.payments1 a set a.investig_id = (select b.id from "&1".investig b 
	where b.investigator_code = a.investigator_code and
	      b.protocol_id = a.protocolid and
	      b.build_code_id = a.clientid);

commit;

drop index tsm_stage.payments1_temp_indx1;
drop index "&1".investig_temp_indx1;


Insert into "&1".payments (ID,PROCEDURE_CODE,PAYMENT,TYPE,ODC_DEF_ID,
PROCEDURE_DEF_ID,PAYMENT_COUNTRY_ID,INVESTIG_ID, OUTLIER_CD,checked )        
select
a.ID,a.PROCEDURE_CODE,       
a.PAYMENT,a.TYPE,a.odc_def_id, a.procedure_def_id, 
a.currencyid,a.INVESTIG_ID,a.OUTLIER_CD,a.checked  
from   tsm_stage.payments1 a;

commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  11   DevTSM    1.10        2/27/2008 3:17:12 PM Debashish Mishra  
--  10   DevTSM    1.9         2/7/2007 10:28:37 PM Debashish Mishra  
--  9    DevTSM    1.8         3/3/2005 6:40:51 AM  Debashish Mishra  
--  8    DevTSM    1.7         10/19/2004 10:15:36 PMDebashish Mishra  
--  7    DevTSM    1.6         2/24/2004 12:26:07 PMDebashish Mishra Modified for
--       outlier_cd import
--  6    DevTSM    1.5         8/29/2003 5:13:34 PM Debashish Mishra  
--  5    DevTSM    1.4         8/30/2002 12:43:13 PMDebashish Mishra Modified for
--       passing the schema name as an parameter
--  4    DevTSM    1.3         4/25/2002 2:31:52 PM Debashish Mishra  
--  3    DevTSM    1.2         4/3/2002 6:58:08 PM  Debashish Mishra  
--  2    DevTSM    1.1         3/22/2002 12:51:47 PMDebashish Mishra  
--  1    DevTSM    1.0         3/20/2002 9:24:10 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
