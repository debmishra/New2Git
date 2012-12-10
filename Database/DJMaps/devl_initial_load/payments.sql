--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: payments.sql$ 
--
-- $Revision: 8$        $Date: 2/27/2008 3:16:42 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
Alter table payments1 add(protocolid number(10),
clientid number(10), currencyid number(10));

create index client_dl_indx1 on build_code(code);

create index payments1_dl_indx1 on 
payments1(client_id);

update payments1 a set a.clientid = (
select b.id from build_code b where 
a.client_id  = b.code);

commit;

drop index payments1_dl_indx1;

drop index client_dl_indx1;

create index protocol_dl_indx1 on protocol(build_code_id,picas_protocol);

create index payments1_dl_indx1 on 
payments1(clientid,protocol_id);

update payments1 a set a.protocolid = (
select b.id from protocol b where 
a.clientid = b.build_code_id and
a.protocol_id = b.picas_protocol);

commit;

drop index protocol_dl_indx1;
drop index payments1_dl_indx1;

create index payments1_dl_indx1 on 
payments1(procedure_code);

create index procedure_def_dl_indx1 on
procedure_def(cpt_code);

create index odc_def_dl_indx1 on
odc_def(picas_code);

update payments1 a set a.odc_def_id =
( select b.id from odc_def b where
b.picas_code = a.procedure_code);

commit;

update payments1 a set a.procedure_def_id =
( select b.id from procedure_def b where
b.cpt_code = a.procedure_code);

commit;

update payments1 set type='CLIN' where
procedure_def_id is not null;

commit;

update payments1 set type='ODC' where
odc_def_id is not null;

commit;

drop index payments1_dl_indx1;


drop index procedure_def_dl_indx1;

drop index odc_def_dl_indx1;


create index payments1_dl_indx1 on 
payments1(currency_id);


update payments1 a set a.currencyid=(
select b.id from country b where 
a.currency_id  = b.abbreviation );

drop index payments1_dl_indx1;

Alter table payments1 add(investig_id number(10));

create index payments1_temp_indx1 on 
	payments1(investigator_code,protocolid,clientid)
	tablespace tsmlarge nologging;

create index investig_temp_indx1 on 
	investig(investigator_code,protocol_id,build_code_id)
	tablespace tsmlarge nologging;

update payments1 a set a.investig_id = (select b.id from investig b 
	where b.investigator_code = a.investigator_code and
	      b.protocol_id = a.protocolid and
	      b.build_code_id = a.clientid);

commit;

drop index payments1_temp_indx1;
drop index investig_temp_indx1;


Insert into payments (ID,PROCEDURE_CODE,PAYMENT,TYPE,ODC_DEF_ID,
PROCEDURE_DEF_ID,PAYMENT_COUNTRY_ID,INVESTIG_ID )        
select
a.ID,a.PROCEDURE_CODE,       
a.PAYMENT,a.TYPE,a.odc_def_id, a.procedure_def_id, 
a.currencyid,a.INVESTIG_ID  
from   payments1 a;

commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  8    DevTSM    1.7         2/27/2008 3:16:42 PM Debashish Mishra  
--  7    DevTSM    1.6         3/3/2005 6:39:14 AM  Debashish Mishra  
--  6    DevTSM    1.5         8/29/2003 5:11:59 PM Debashish Mishra  
--  5    DevTSM    1.4         3/12/2002 4:40:12 PM Debashish Mishra  
--  4    DevTSM    1.3         2/12/2002 12:19:57 PMDebashish Mishra  
--  3    DevTSM    1.2         2/5/2002 2:54:46 PM  Debashish Mishra  
--  2    DevTSM    1.1         1/15/2002 12:30:58 PMDebashish Mishra  
--  1    DevTSM    1.0         1/8/2002 6:37:19 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
