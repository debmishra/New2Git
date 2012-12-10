--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: Schema_updates_for_Aug03_import.sql$ 
--
-- $Revision: 6$        $Date: 2/22/2008 11:55:21 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
update odc_def set foxpro_flg = 0 where picas_code in ('V1110','V1111','V1113');
update procedure_def set foxpro_flg = 0 where cpt_code in ('70539','92025');

commit;

Alter table protocol_to_indmap add (primary_flg number(1));
Alter table protocol_to_indmap add constraint pti_primary_flg_chk check(
	primary_flg in (0,1));

Alter table protocol add(earliest_grant_date date);

Alter table price_level add(plist number(16,4));

truncate table temp_procedure;
truncate table temp_odc;
truncate table temp_overhead;
truncate table temp_ip_study_price;
truncate table temp_inst_to_company;

truncate table payments;
truncate table procedure_to_protocol;
truncate table protocol_to_indmap;
delete from investig;
commit;
Delete from protocol;
truncate table price_level;

delete from indmap where lower(type) = 'indication' and parent_indmap_id is null;
commit;

create table version_45master (version varchar2(6)) 
tablespace tsmsmall
pctused 80 pctfree 10;
insert into version_45master values ('2003Q3');
commit;



---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         2/22/2008 11:55:21 AMDebashish Mishra  
--  5    DevTSM    1.4         9/19/2006 12:10:38 AMDebashish Mishra   
--  4    DevTSM    1.3         3/2/2005 10:48:40 PM Debashish Mishra  
--  3    DevTSM    1.2         9/9/2003 8:23:53 AM  Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:15:27 PM Debashish Mishra  
--  1    DevTSM    1.0         8/26/2003 4:39:36 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
