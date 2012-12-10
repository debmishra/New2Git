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
-- $Revision: 4$        $Date: 2/27/2008 3:19:43 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
create index tsm_stage.protocol_to_indmap1_dl_indx1 on 
tsm_stage.protocol_to_indmap1(client_id);

update tsm_stage.protocol_to_indmap1 a set a.clientid = (
select b.id from "&1".build_code b where 
a.client_id  = b.code );

commit;

drop index tsm_stage.protocol_to_indmap1_dl_indx1;


 


create index tsm_stage.protocol_to_indmap1_dl_indx1 on 
tsm_stage.protocol_to_indmap1(clientid,protocol_id);

update tsm_stage.protocol_to_indmap1 a set a.protocolid = (
select b.id from "&1".protocol b where 
a.clientid = b.build_code_id and
a.protocol_id = b.picas_protocol);

commit;


drop index tsm_stage.protocol_to_indmap1_dl_indx1;

create index tsm_stage.protocol_to_indmap1_dl_indx1 on 
tsm_stage.protocol_to_indmap1(indmap_id);

update tsm_stage.protocol_to_indmap1 a set a.indmapid = (
select b.id from "&1".indmap b where 
a.indmap_id  = b.code );

commit;

drop index tsm_stage.protocol_to_indmap1_dl_indx1;



Insert into "&1".protocol_to_indmap select 
id,protocolid,indmapid from 
tsm_stage.protocol_to_indmap1 where protocolid is not null;

commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  4    DevTSM    1.3         2/27/2008 3:19:43 PM Debashish Mishra  
--  3    DevTSM    1.2         3/3/2005 6:41:52 AM  Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:14:46 PM Debashish Mishra  
--  1    DevTSM    1.0         2/19/2003 1:51:08 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
