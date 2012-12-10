--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: protocol_to_indmap.sql$ 
--
-- $Revision: 7$        $Date: 2/27/2008 3:16:43 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
create index client_dl_indx1 on build_code(code);

create index protocol_to_indmap1_dl_indx1 on 
protocol_to_indmap1(client_id);

update protocol_to_indmap1 a set a.clientid = (
select b.id from build_code b where 
a.client_id  = b.code );

commit;

drop index protocol_to_indmap1_dl_indx1;

drop index client_dl_indx1;
 
create index protocol_dl_indx1 on protocol(build_code_id,picas_protocol);

create index protocol_to_indmap1_dl_indx1 on 
protocol_to_indmap1(clientid,protocol_id);

update protocol_to_indmap1 a set a.protocolid = (
select b.id from protocol b where 
a.clientid = b.build_code_id and
a.protocol_id = b.picas_protocol);

commit;

drop index protocol_dl_indx1;
drop index protocol_to_indmap1_dl_indx1;

create index indmap_dl_indx1 on indmap(code);

create index protocol_to_indmap1_dl_indx1 on 
protocol_to_indmap1(indmap_id);

update protocol_to_indmap1 a set a.indmapid = (
select b.id from indmap b where 
a.indmap_id  = b.code );

commit;

drop index protocol_to_indmap1_dl_indx1;

drop index indmap_dl_indx1;

Insert into protocol_to_indmap select 
id,protocolid,indmapid from 
protocol_to_indmap1 where protocolid is not null;

commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/27/2008 3:16:43 PM Debashish Mishra  
--  6    DevTSM    1.5         3/3/2005 6:39:19 AM  Debashish Mishra  
--  5    DevTSM    1.4         8/29/2003 5:12:04 PM Debashish Mishra  
--  4    DevTSM    1.3         2/12/2002 12:19:59 PMDebashish Mishra  
--  3    DevTSM    1.2         2/7/2002 3:10:14 PM  Debashish Mishra  
--  2    DevTSM    1.1         1/23/2002 12:53:53 PMDebashish Mishra After changing
--       the input source to foxpro
--  1    DevTSM    1.0         1/8/2002 6:37:20 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
