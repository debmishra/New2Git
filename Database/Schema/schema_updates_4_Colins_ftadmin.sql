--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_4_Colins_ftadmin.sql$ 
--
-- $Revision: 11$        $Date: 2/22/2008 11:56:00 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
-- Following changes are made as per the request of Colin on 02/07/2003

conn ft15/******@?????

Grant select,insert,update,delete,references on ftuser_login_history to TSM10;

conn tsm10/******@?????

Drop synonym ftuser_login_history;
 
Create synonym ftuser_login_history for ft15.ftuser_login_history;

-- Following chnages are as per the request of Colin/Nadine on 02/04/2003 

conn dmishra/*****@?????

Create user ftadmin identified by welcome default tablespace tsmsmall
temporary tablespace temp;

Grant connect,resource to ftadmin;

grant connect,resource, alter any procedure, create any index, create any procedure, 
create any sequence,create any synonym, create any table, create any trigger, 
create any view, delete any table, drop any index, drop any procedure, 
drop any sequence, drop any synonym, drop any table, drop any trigger, drop any view, 
drop user, create user, execute any procedure, insert any table, select any sequence,
select any table, update any table,grant any privilege, grant any role to ftadmin;

--IMPORTANT*****Most important thing is after this, login to the oracle unix server
--IMPORTANT*****connect as / and execute "grant select on sys.v_$session to ftadmin;" 

conn tsm10/*****@??????

--Implemented upto this in tsm10@test on 02/07/2003
--Implemented upto this in tsm10e@test on 03/06/2003


create table client_build_progress (
	id number(10),
	client_div_id number(10) not null,
	build_start date,
	build_end date,
	error number(1) default 0 not null)
        tablespace tsmsmall
        pctused 70 pctfree 20;

Alter table client_build_progress add constraint client_build_progress_pk
	primary key (id) using index tablespace tsmsmall_indx pctfree 20;

Alter table client_build_progress add constraint client_build_progress_fk1
	foreign key(client_div_id) references client_div(id);

Insert into id_control values('tsm10','client_build_progress',1);
commit;


--***************************************************************
--Implemented upto this in tsm10@test on 03/21/2003
--Implemented upto this in tsm10e@test on 03/21/2003
--Implemented upto this in tsm10p@prev on 03/24/2003
--Implemented upto this in tsm10e@prev on 03/26/2003
--Implemented upto this in tsm10,tsm10e,tsm10ed@prod on 03/28/2003
--****************************************************************






---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  11   DevTSM    1.10        2/22/2008 11:56:00 AMDebashish Mishra  
--  10   DevTSM    1.9         9/19/2006 12:11:24 AMDebashish Mishra   
--  9    DevTSM    1.8         3/2/2005 10:50:57 PM Debashish Mishra  
--  8    DevTSM    1.7         8/29/2003 5:17:41 PM Debashish Mishra  
--  7    DevTSM    1.6         3/28/2003 4:06:24 PM Debashish Mishra  
--  6    DevTSM    1.5         3/27/2003 4:56:46 PM Debashish Mishra  
--  5    DevTSM    1.4         3/26/2003 10:04:17 AMDebashish Mishra  
--  4    DevTSM    1.3         3/21/2003 4:49:32 PM Debashish Mishra New table
--       added
--  3    DevTSM    1.2         3/21/2003 12:41:42 PMDebashish Mishra  
--  2    DevTSM    1.1         3/6/2003 6:53:53 PM  Debashish Mishra  
--  1    DevTSM    1.0         2/19/2003 1:48:30 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
