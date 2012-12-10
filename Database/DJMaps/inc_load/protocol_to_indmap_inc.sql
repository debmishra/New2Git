--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: protocol_to_indmap_inc.sql$ 
--
-- $Revision: 7$        $Date: 2/27/2008 3:17:13 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
create index "&1".client_dl_indx1 on "&1".build_code(code);

create index tsm_stage.protocol_to_indmap1_dl_indx1 on 
tsm_stage.protocol_to_indmap1(client_id);

update tsm_stage.protocol_to_indmap1 a set a.clientid = (
select b.id from "&1".build_code b where 
a.client_id  = b.code );

commit;

drop index tsm_stage.protocol_to_indmap1_dl_indx1;

drop index "&1".client_dl_indx1;
 
create index "&1".protocol_dl_indx1 on "&1".protocol(build_code_id,picas_protocol);

create index tsm_stage.protocol_to_indmap1_dl_indx1 on 
tsm_stage.protocol_to_indmap1(clientid,protocol_id);

update tsm_stage.protocol_to_indmap1 a set a.protocolid = (
select b.id from "&1".protocol b where 
a.clientid = b.build_code_id and
a.protocol_id = b.picas_protocol);

commit;

drop index "&1".protocol_dl_indx1;
drop index tsm_stage.protocol_to_indmap1_dl_indx1;

create index "&1".indmap_dl_indx1 on "&1".indmap(code);

create index tsm_stage.protocol_to_indmap1_dl_indx1 on 
tsm_stage.protocol_to_indmap1(indmap_id);

update tsm_stage.protocol_to_indmap1 a set a.indmapid = (
select b.id from "&1".indmap b where 
a.indmap_id  = b.code );

commit;

drop index tsm_stage.protocol_to_indmap1_dl_indx1;

drop index "&1".indmap_dl_indx1;

Insert into "&1".protocol_to_indmap select 
id,protocolid,indmapid,decode(primary_flg,'F',0,'T',1) from 
tsm_stage.protocol_to_indmap1 where protocolid is not null;

commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/27/2008 3:17:13 PM Debashish Mishra  
--  6    DevTSM    1.5         2/7/2007 10:28:41 PM Debashish Mishra  
--  5    DevTSM    1.4         3/3/2005 6:40:54 AM  Debashish Mishra  
--  4    DevTSM    1.3         8/29/2003 5:13:37 PM Debashish Mishra  
--  3    DevTSM    1.2         8/30/2002 12:43:15 PMDebashish Mishra Modified for
--       passing the schema name as an parameter
--  2    DevTSM    1.1         3/22/2002 12:51:48 PMDebashish Mishra  
--  1    DevTSM    1.0         3/20/2002 9:24:12 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
