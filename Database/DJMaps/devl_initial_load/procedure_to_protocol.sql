--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: procedure_to_protocol.sql$ 
--
-- $Revision: 7$        $Date: 2/27/2008 3:16:43 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
create index client_dl_index_x1 on build_code(code);

create index dl_index_x1
 on procedure_to_protocol1(company);

update procedure_to_protocol1 a set 
a.client_id = (select id from build_code b where 
b.code = a.company);

commit;

drop index client_dl_index_x1;

drop index dl_index_x1;

create index dl_index_x1
 on procedure_to_protocol1(client_id,protocol_code);

create index dl_index_x2 on protocol(build_code_id,picas_protocol);

update procedure_to_protocol1 a set a.protocol_id =
(select b.id from protocol b where b.build_code_id = a.client_id and
b.picas_protocol = a.protocol_code);

commit;

drop index client_dl_index_x1;

drop index dl_index_x1;

drop index dl_index_x2;

create index dl_index_x1
 on procedure_to_protocol1(procedure_code);

create index dl_index2 on odc_def(picas_code);

create index dl_index3 on procedure_def(cpt_code);

Alter table procedure_to_protocol1 add(
odc_def_id number(10), procedure_def_id number(10));

update procedure_to_protocol1 a set
	a.odc_def_id = (select b.id from odc_def b where
	b.picas_code = a.procedure_code); 

commit;


update procedure_to_protocol1 a set
	a.procedure_def_id = (select b.id from procedure_def b where
	b.cpt_code = a.procedure_code);

commit;

update procedure_to_protocol1 set type='ODC' where
	odc_def_id is not null;

commit;

update procedure_to_protocol1 set type='CLIN' where
	procedure_def_id is not null;

commit;

drop index dl_index_x1;
drop index dl_index2;
drop index dl_index3;

Insert into procedure_to_protocol select
id,PROTOCOL_ID,TIMES_PERFORMED,CENTRAL_LAB_USED,
INVESTIGATOR_TIMES_PERF,TYPE,ODC_DEF_ID,PROCEDURE_DEF_ID,CLIENT_ID
from procedure_to_protocol1;

COMMIT;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/27/2008 3:16:43 PM Debashish Mishra  
--  6    DevTSM    1.5         3/3/2005 6:39:17 AM  Debashish Mishra  
--  5    DevTSM    1.4         8/29/2003 5:12:02 PM Debashish Mishra  
--  4    DevTSM    1.3         2/12/2002 12:19:58 PMDebashish Mishra  
--  3    DevTSM    1.2         2/5/2002 2:54:47 PM  Debashish Mishra  
--  2    DevTSM    1.1         1/23/2002 12:53:52 PMDebashish Mishra After changing
--       the input source to foxpro
--  1    DevTSM    1.0         1/15/2002 12:30:32 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
