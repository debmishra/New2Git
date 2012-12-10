--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: study_level_service_inst.sql$ 
--
-- $Revision: 7$        $Date: 2/27/2008 3:16:47 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
create index client_dl_index_x1 on build_code(code);

create index dl_index_x1
 on study_level_service_inst1(company);

update study_level_service_inst1 a set 
a.client_id = (select id from build_code b where 
b.code = a.company);

commit;

drop index client_dl_index_x1;

drop index dl_index_x1;

create index dl_index_x1
 on study_level_service_inst1(client_id,code);

create index dl_index_x2 on protocol(build_code_id,picas_protocol);

update study_level_service_inst1 a set a.protocol_id =
(select b.id from protocol b where b.build_code_id = a.client_id and
b.picas_protocol = a.code);

commit;

drop index dl_index_x1;

drop index dl_index_x2;

update study_level_service_inst1 a set a.country_id =
(select b.id from country b where b.abbreviation = a.country);

commit;

update study_level_service_inst1 a set a.currency_id =
(select b.id from country b where b.abbreviation = a.currency);

commit;

update study_level_service_inst1 set 
STUDYLEVELSERVICEMASTERID = 'SL006' where
STUDYLEVELSERVICEMASTERID = 'TRANS';

commit;

update study_level_service_inst1 a set 
a.study_level_service_master_id =
(select b.id from study_level_service_master1 b where 
b.picas_code = a.STUDYLEVELSERVICEMASTERID);

commit;


Insert into study_level_service_inst select ID,STUDY_LEVEL_SERVICE_MASTER_ID,
PROTOCOL_ID,COUNTRY_ID,SERVICE_COST,CURRENCY_ID,CLIENT_ID
from  study_level_service_inst1 where country_id is not null;               

commit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/27/2008 3:16:47 PM Debashish Mishra  
--  6    DevTSM    1.5         3/3/2005 6:39:37 AM  Debashish Mishra  
--  5    DevTSM    1.4         8/29/2003 5:12:20 PM Debashish Mishra  
--  4    DevTSM    1.3         2/12/2002 12:19:59 PMDebashish Mishra  
--  3    DevTSM    1.2         2/5/2002 2:54:48 PM  Debashish Mishra  
--  2    DevTSM    1.1         1/23/2002 12:53:55 PMDebashish Mishra After changing
--       the input source to foxpro
--  1    DevTSM    1.0         1/15/2002 12:30:34 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
