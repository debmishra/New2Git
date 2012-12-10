--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: country.sql$ 
--
-- $Revision: 7$        $Date: 2/27/2008 3:16:39 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
update country set country_level =  2;

update country set country_level =  1 where
Abbreviation in ('USA','CAN');



Insert into currency (id ) select id  from
country where id <> 0;
 
update country set currency_id = id where id <> 0;

update country set virtual_flg = 1 where abbreviation = 'FSU';

commit;

declare 
	curr_maxid number(10);
  begin
	select max(id)+1 into curr_maxid from currency;

	Insert into currency (id, name,symbol,cnv_rate) 
	values(curr_maxid, 'EURO','EUR',1.1226);
end ;
/

commit;

drop SEQUENCE local_to_euro_seq;
CREATE SEQUENCE local_to_euro_seq;

Insert into local_to_euro select local_to_euro_seq.nextval,id,40.3399
	from country where upper(name) = 'BELGIUM';
Insert into local_to_euro select local_to_euro_seq.nextval,id,1.9558
	from country where upper(name) = 'GERMANY';
Insert into local_to_euro select local_to_euro_seq.nextval,id,166.386
	from country where upper(name) = 'SPAIN';
Insert into local_to_euro select local_to_euro_seq.nextval,id,6.5596
	from country where upper(name) = 'FRANCE';
Insert into local_to_euro select local_to_euro_seq.nextval,id,0.7876
	from country where upper(name) = 'IRELAND';
Insert into local_to_euro select local_to_euro_seq.nextval,id,1936.27
	from country where upper(name) = 'ITALY';
Insert into local_to_euro select local_to_euro_seq.nextval,id,2.2037
	from country where upper(name) = 'NETHERLANDS';
Insert into local_to_euro select local_to_euro_seq.nextval,id,13.7603
	from country where upper(name) = 'AUSTRIA';
Insert into local_to_euro select local_to_euro_seq.nextval,id,5.9457
	from country where upper(name) = 'FINLAND';


update country set currency_id = (select id from currency 
where name = 'EURO') where id in (select country_id from 
local_to_euro);

update country set country_search_id = (select id from country
where abbreviation='FSU') where abbreviation in('POL','HUN',
'PHC','SCY','BUL','FSU');

commit;

Declare
   country_maxid number(10);

    begin

 	select max(id)+1 into country_maxid from country;

	Insert into country values (country_maxid,'South and Central America',
	'SCA',2,null,null,1,1);

	country_maxid := country_maxid +1 ;

	Insert into country values (country_maxid,'Eastern European',
	'EAE',2,null,null,1,1);
	
	commit;
end;
/


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/27/2008 3:16:39 PM Debashish Mishra  
--  6    DevTSM    1.5         3/3/2005 6:38:52 AM  Debashish Mishra  
--  5    DevTSM    1.4         8/29/2003 5:11:39 PM Debashish Mishra  
--  4    DevTSM    1.3         1/23/2002 12:53:45 PMDebashish Mishra After changing
--       the input source to foxpro
--  3    DevTSM    1.2         1/17/2002 12:18:35 PMDebashish Mishra  
--  2    DevTSM    1.1         1/16/2002 12:41:03 PMDebashish Mishra currency
--       related overhauling
--  1    DevTSM    1.0         1/8/2002 6:37:12 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
