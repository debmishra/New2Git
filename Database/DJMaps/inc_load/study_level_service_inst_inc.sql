--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: study_level_service_inst_inc.sql$ 
--
-- $Revision: 6$        $Date: 2/27/2008 3:17:16 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
create index tsm10.client_dl_index_x1 on tsm10.build_code(code);

create index tsm_stage.dl_index_x1
 on tsm_stage.study_level_service_inst1(company);

update tsm_stage.study_level_service_inst1 a set 
a.client_id = (select id from tsm10.build_code b where 
b.code = a.company);

commit;

drop index tsm10.client_dl_index_x1;

drop index tsm_stage.dl_index_x1;

create index tsm_stage.dl_index_x1
 on tsm_stage.study_level_service_inst1(client_id,code);

create index tsm10.dl_index_x2 on tsm10.protocol(build_code_id,picas_protocol);

update tsm_stage.study_level_service_inst1 a set a.protocol_id =
(select b.id from tsm10.protocol b where b.build_code_id = a.client_id and
b.picas_protocol = a.code);

commit;

drop index tsm_stage.dl_index_x1;

drop index tsm10.dl_index_x2;

update tsm_stage.study_level_service_inst1 a set a.country_id =
(select b.id from tsm10.country b where b.abbreviation = a.country);

commit;

update tsm_stage.study_level_service_inst1 a set a.currency_id =
(select b.id from tsm10.country b where b.abbreviation = a.currency);

commit;

update tsm_stage.study_level_service_inst1 set 
STUDYLEVELSERVICEMASTERID = 'SL006' where
STUDYLEVELSERVICEMASTERID = 'TRANS';

commit;

update tsm_stage.study_level_service_inst1 a set 
a.study_level_service_master_id =
(select b.id from tsm_stage.study_level_service_master1 b where 
b.picas_code = a.STUDYLEVELSERVICEMASTERID);

commit;


Insert into tsm10.study_level_service_inst select ID,STUDY_LEVEL_SERVICE_MASTER_ID,
PROTOCOL_ID,COUNTRY_ID,SERVICE_COST,CURRENCY_ID,CLIENT_ID
from  tsm_stage.study_level_service_inst1 where country_id is not null;               

commit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         2/27/2008 3:17:16 PM Debashish Mishra  
--  5    DevTSM    1.4         2/7/2007 10:28:57 PM Debashish Mishra  
--  4    DevTSM    1.3         3/3/2005 6:41:12 AM  Debashish Mishra  
--  3    DevTSM    1.2         8/29/2003 5:13:51 PM Debashish Mishra  
--  2    DevTSM    1.1         3/22/2002 12:51:51 PMDebashish Mishra  
--  1    DevTSM    1.0         3/20/2002 9:24:24 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
