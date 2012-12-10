--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: procedure_to_protocol_inc.sql$ 
--
-- $Revision: 9$        $Date: 2/27/2008 3:17:13 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
create index "&1".client_dl_index_x1 on "&1".build_code(code);

create index tsm_stage.dl_index_x1
 on tsm_stage.procedure_to_protocol1(company);

update tsm_stage.procedure_to_protocol1 a set 
a.client_id = (select id from "&1".build_code b where 
b.code = a.company);

commit;

drop index "&1".client_dl_index_x1;

drop index tsm_stage.dl_index_x1;

create index tsm_stage.dl_index_x1
 on tsm_stage.procedure_to_protocol1(client_id,protocol_code);

create index "&1".dl_index_x2 on "&1".protocol(build_code_id,picas_protocol);

update tsm_stage.procedure_to_protocol1 a set a.protocol_id =
(select b.id from "&1".protocol b where b.build_code_id = a.client_id and
b.picas_protocol = a.protocol_code);

commit;

drop index "&1".client_dl_index_x1;

drop index tsm_stage.dl_index_x1;

drop index "&1".dl_index_x2;

create index tsm_stage.dl_index_x1
 on tsm_stage.procedure_to_protocol1(procedure_code);


update tsm_stage.PROCEDURE_TO_PROTOCOL1 set PROCEDURE_CODE = 'VBED*' where  PROCEDURE_CODE =  '*BED*';
commit;
update tsm_stage.PROCEDURE_TO_PROTOCOL1 set PROCEDURE_CODE = 'VDAY*' where  PROCEDURE_CODE =  '*DAY*';
commit;
update tsm_stage.PROCEDURE_TO_PROTOCOL1 set PROCEDURE_CODE = 'VPHRM' where  PROCEDURE_CODE =  '*PHRM';
commit;
update tsm_stage.PROCEDURE_TO_PROTOCOL1 set PROCEDURE_CODE = 'VREIM' where  PROCEDURE_CODE =  '*REIM';
commit;
update tsm_stage.PROCEDURE_TO_PROTOCOL1 set PROCEDURE_CODE = 'VHOTL' where  PROCEDURE_CODE =  '*HOTL';
commit;


create index "&1".dl_index2 on "&1".odc_def(picas_code);

create index "&1".dl_index3 on "&1".procedure_def(cpt_code);

Alter table tsm_stage.procedure_to_protocol1 add(
odc_def_id number(10), procedure_def_id number(10));

update tsm_stage.procedure_to_protocol1 a set
	a.odc_def_id = (select b.id from "&1".odc_def b where
	b.picas_code = a.procedure_code and not b.id in(
	select id from "&1".odc_def where procedure_level in ('Patient','Site','Visit')
	and picas_code in ( select picas_code from "&1".odc_def where procedure_level in 
	('PatientOrSite','PatientOrVisit')))); 

commit;

update tsm_stage.procedure_to_protocol1 a set
	a.procedure_def_id = (select b.id from "&1".procedure_def b where
	b.cpt_code = a.procedure_code and not b.id in(
	select id from "&1".procedure_def where procedure_level in ('Patient','Site','Visit')
	and cpt_code in ( select cpt_code from "&1".procedure_def where procedure_level in 
	('PatientOrSite','PatientOrVisit'))));

commit;

update tsm_stage.procedure_to_protocol1 set type='ODC' where
	odc_def_id is not null;

commit;

update tsm_stage.procedure_to_protocol1 set type='CLIN' where
	procedure_def_id is not null;

commit;

drop index tsm_stage.dl_index_x1;
drop index "&1".dl_index2;
drop index "&1".dl_index3;

Insert into "&1".procedure_to_protocol select
id,PROTOCOL_ID,TIMES_PERFORMED,CENTRAL_LAB_USED,
INVESTIGATOR_TIMES_PERF,TYPE,ODC_DEF_ID,PROCEDURE_DEF_ID,CLIENT_ID
from tsm_stage.procedure_to_protocol1;

COMMIT;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  9    DevTSM    1.8         2/27/2008 3:17:13 PM Debashish Mishra  
--  8    DevTSM    1.7         2/7/2007 10:28:40 PM Debashish Mishra  
--  7    DevTSM    1.6         3/3/2005 6:40:53 AM  Debashish Mishra  
--  6    DevTSM    1.5         8/29/2003 5:13:36 PM Debashish Mishra  
--  5    DevTSM    1.4         8/30/2002 12:43:14 PMDebashish Mishra Modified for
--       passing the schema name as an parameter
--  4    DevTSM    1.3         4/25/2002 2:31:53 PM Debashish Mishra  
--  3    DevTSM    1.2         4/3/2002 6:58:09 PM  Debashish Mishra  
--  2    DevTSM    1.1         3/22/2002 12:51:48 PMDebashish Mishra  
--  1    DevTSM    1.0         3/20/2002 9:24:11 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
