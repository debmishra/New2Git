--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: client.sql$ 
--
-- $Revision: 7$        $Date: 2/27/2008 3:16:38 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------


DROP TABLE tsm_stage.client;

create table tsm_stage.client as select id,name,client_identifier,
	client_acronym,de_acronym from ft15.client where
	upper(name) like '%AMGEN%' or id=0;

update client1 set name ='Pharmacia Corporation-2' where
name = 'Pharmacia Corporation' and de_acronym = 'UPJ';

commit;

declare

  clientid number(10);

  cursor c1 is select rowid from client1 where 
  not upper(name) like '%AMGEN%';

begin

 select max(id)+1 into clientid from client;

  for ix1 in c1 loop

    Insert into client (ID,NAME,CLIENT_IDENTIFIER,
    CLIENT_ACRONYM,DE_ACRONYM) select 
    clientid,NAME,DE_ACRONYM,DE_ACRONYM,DE_ACRONYM from
    client1 where rowid = ix1.rowid ;

    clientid:=clientid+1;

  end loop;
/*
    Insert into client(ID,NAME,CLIENT_IDENTIFIER,
    CLIENT_ACRONYM,DE_ACRONYM) values 
    (clientid,'Alcon Labs','ALC','ALC','ALC');

    clientid:=clientid+1;

    Insert into client(ID,NAME,CLIENT_IDENTIFIER,
    CLIENT_ACRONYM,DE_ACRONYM) values 
    (clientid,'Anica Research','ANK','ANK','ANK');

    clientid:=clientid+1;

    Insert into client(ID,NAME,CLIENT_IDENTIFIER,
    CLIENT_ACRONYM,DE_ACRONYM) values 
    (clientid,'Genta','GTA','GTA','GTA');

    clientid:=clientid+1;

    Insert into client(ID,NAME,CLIENT_IDENTIFIER,
    CLIENT_ACRONYM,DE_ACRONYM) values 
    (clientid,'Merck phase IV','MK4','MK4','MK4');

    clientid:=clientid+1; */

    Insert into client(ID,NAME,CLIENT_IDENTIFIER,
    CLIENT_ACRONYM,DE_ACRONYM) values 
    (clientid,'Unknown','UNK','UNK','UNK');


end;
/

commit;

update client set de_acronym = 'AMG' 
where upper(name) like '%AMGEN%';



commit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/27/2008 3:16:38 PM Debashish Mishra  
--  6    DevTSM    1.5         3/3/2005 6:38:51 AM  Debashish Mishra  
--  5    DevTSM    1.4         8/29/2003 5:11:38 PM Debashish Mishra  
--  4    DevTSM    1.3         1/24/2002 6:33:54 PM Debashish Mishra  
--  3    DevTSM    1.2         1/23/2002 12:53:44 PMDebashish Mishra After changing
--       the input source to foxpro
--  2    DevTSM    1.1         1/15/2002 12:30:55 PMDebashish Mishra  
--  1    DevTSM    1.0         1/8/2002 6:37:12 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
