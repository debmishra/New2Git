--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: country2.sql$ 
--
-- $Revision: 9$        $Date: 2/27/2008 3:16:39 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
update country2 set name = substr(name,2) where name like 'a%';

commit;

declare

maxid number(10);

cursor c1 is select abbreviation,name from country2 where abbreviation not in(
	select nvl(abbreviation,'AAA') from country);

begin

  select max(id)+1 into maxid from country;

  for ix1 in c1 loop 

      Insert into country(id,name,abbreviation) values 
      (maxid,ix1.name,ix1.abbreviation);
  
      maxid:=maxid+1;

  end loop;

/*      Insert into country(id,abbreviation) values (maxid,'BRA');
      maxid:=maxid+1;
      Insert into country(id,abbreviation) values (maxid,'CHN');
      maxid:=maxid+1;
      Insert into country(id,abbreviation) values (maxid,'COL');
      maxid:=maxid+1;
      Insert into country(id,abbreviation) values (maxid,'CRA');
      maxid:=maxid+1;
      Insert into country(id,abbreviation) values (maxid,'EGY');
      maxid:=maxid+1;
      Insert into country(id,abbreviation) values (maxid,'ELS');
      maxid:=maxid+1;
      Insert into country(id,abbreviation) values (maxid,'GUA');
      maxid:=maxid+1;
      Insert into country(id,abbreviation) values (maxid,'HON');
      maxid:=maxid+1;
      Insert into country(id,abbreviation) values (maxid,'IND');
      maxid:=maxid+1;
      Insert into country(id,abbreviation) values (maxid,'KUW');
      maxid:=maxid+1;
      Insert into country(id,abbreviation) values (maxid,'LIE');
      maxid:=maxid+1;
      Insert into country(id,abbreviation) values (maxid,'MAL');
      maxid:=maxid+1;
      Insert into country(id,abbreviation) values (maxid,'MON');
      maxid:=maxid+1;
      Insert into country(id,abbreviation) values (maxid,'PAK');
      maxid:=maxid+1;
      Insert into country(id,abbreviation) values (maxid,'PAN');
      maxid:=maxid+1;
      Insert into country(id,abbreviation) values (maxid,'PRT');
      maxid:=maxid+1;
      Insert into country(id,abbreviation) values (maxid,'RBL');
      maxid:=maxid+1;
      Insert into country(id,abbreviation) values (maxid,'SAU');
      maxid:=maxid+1;
      Insert into country(id,abbreviation) values (maxid,'TUN');
      maxid:=maxid+1;
      Insert into country(id,abbreviation) values (maxid,'UAE');
      maxid:=maxid+1;
      Insert into country(id,abbreviation) values (maxid,'UGY');
      maxid:=maxid+1;
      Insert into country(id,abbreviation) values (maxid,'UKR');
      maxid:=maxid+1;
      Insert into country(id,abbreviation) values (maxid,'VEN');
      maxid:=maxid+1;
      Insert into country(id,abbreviation) values (maxid,'YUG'); */

  commit;

end;
/



declare

  currencyid number(10);
  maxid number(10);

begin

  select max(id) into maxid from currency;

  select currency_id into currencyid from country where abbreviation = 'USA';

  If currencyid is not null then
	Update currency set (name,symbol,cnv_rate) = (select 'US-Dollar','USD',1 from dual)
        where id=currencyid;
        Update country set currency_id = currencyid where abbreviation in
	('BUL','RUM','PHC','FSU');
  else 
        Insert into currency values (maxid,'US-Dollar','USD',1);
        Update country set currency_id = maxid where abbreviation in
	('BUL','RUM','PHC','FSU','USA');
        maxid:=maxid+1;  
  end if;

  select currency_id into currencyid from country where abbreviation = 'AUS';

  If currencyid is not null then
	Update currency set (name,symbol) = (select 'Australian dollar','AUD' from dual)
        where id=currencyid;
  else
        Insert into currency values (maxid,'Australian dollar','AUD',null);
        Update country set currency_id = maxid where abbreviation = 'AUS';
        maxid:=maxid+1;
  end if;

  select currency_id into currencyid from country where abbreviation = 'CAN';

  If currencyid is not null then
	Update currency set (name,symbol) = (select 'Canadian dollar','CAD' from dual)
        where id=currencyid;
  else
        Insert into currency values (maxid,'Canadian dollar','CAD',null);
        Update country set currency_id = maxid where abbreviation = 'CAN';
        maxid:=maxid+1;
  end if;

  select currency_id into currencyid from country where abbreviation = 'DEN';

  If currencyid is not null then
	Update currency set (name,symbol) = (select 'Danish krone','DKK' from dual)
        where id=currencyid;
  else
        Insert into currency values (maxid,'Danish krone','DKK',null);
        Update country set currency_id = maxid where abbreviation = 'DEN';
        maxid:=maxid+1;
  end if;

  select currency_id into currencyid from country where abbreviation = 'HUN';

  If currencyid is not null then
	Update currency set (name,symbol) = (select 'Forint','HUF' from dual)
        where id=currencyid;
  else
        Insert into currency values (maxid,'Forint','HUF',null);
        Update country set currency_id = maxid where abbreviation = 'HUN';
        maxid:=maxid+1;
  end if;

  select currency_id into currencyid from country where abbreviation = 'ISR';

  If currencyid is not null then
	Update currency set (name,symbol) = (select 'Israeli shekel','ILS' from dual)
        where id=currencyid;
  else
        Insert into currency values (maxid,'Israeli shekel','ILS',null);
        Update country set currency_id = maxid where abbreviation = 'ISR';
        maxid:=maxid+1;
  end if;

  select currency_id into currencyid from country where abbreviation = 'NOR';

  If currencyid is not null then
	Update currency set (name,symbol) = (select 'Norwegian krone','NOK' from dual)
        where id=currencyid;
  else
        Insert into currency values (maxid,'Norwegian krone','NOK',null);
        Update country set currency_id = maxid where abbreviation = 'NOR';
        maxid:=maxid+1;
  end if;

  select currency_id into currencyid from country where abbreviation = 'POL';

  If currencyid is not null then
	Update currency set (name,symbol) = (select 'Zloty','PLN' from dual)
        where id=currencyid;
  else
        Insert into currency values (maxid,'Zloty','PLN',null);
        Update country set currency_id = maxid where abbreviation = 'POL';
        maxid:=maxid+1;
  end if;

  select currency_id into currencyid from country where abbreviation = 'SAF';

  If currencyid is not null then
	Update currency set (name,symbol) = (select 'Rand','ZAR' from dual)
        where id=currencyid;
  else
        Insert into currency values (maxid,'Rand','ZAR',null);
        Update country set currency_id = maxid where abbreviation = 'SAF';
        maxid:=maxid+1;
  end if;

  select currency_id into currencyid from country where abbreviation = 'SWE';

  If currencyid is not null then
	Update currency set (name,symbol) = (select 'Swedish krona','SEK' from dual)
        where id=currencyid;
  else
        Insert into currency values (maxid,'Swedish krona','SEK',null);
        Update country set currency_id = maxid where abbreviation = 'SWE';
        maxid:=maxid+1;
  end if;

  select currency_id into currencyid from country where abbreviation = 'SWI';

  If currencyid is not null then
	Update currency set (name,symbol) = (select 'Swiss franc','CHF' from dual)
        where id=currencyid;
  else
        Insert into currency values (maxid,'Swiss franc','CHF',null);
        Update country set currency_id = maxid where abbreviation = 'SWI';
        maxid:=maxid+1;
  end if;

  select currency_id into currencyid from country where abbreviation = 'UK';

  If currencyid is not null then
	Update currency set (name,symbol) = (select 'British pound','GBP' from dual)
        where id=currencyid;
  else
        Insert into currency values (maxid,'British pound','GBP',null);
        Update country set currency_id = maxid where abbreviation = 'UK';
        maxid:=maxid+1;
  end if;

commit;

end;
/

update country set is_viewable = 1 where abbreviation in ('USA','BUL','RUM','PHC','FSU',
'AUS','CAN','DEN','HUN','ISR','NOR','POL','SAF','SWE','SWI','UK','ARI','BEL','FIN','FRA',
'DEU','IRL','ITA','NET','ESP');

commit;

Update currency set cnv_rate = 1 where id = (select currency_id from 
country where abbreviation = 'USA');


Update currency a set a.cnv_rate = (select b.cnv_rate from country2 b, country c
where b.abbreviation = c.abbreviation and c.currency_id = a.id and 
a.symbol not in ('EUR','USD'));

commit;


update country set country_level =  2 where country_level  is null;
update country set virtual_flg =  0 where virtual_flg  is null;
update country set is_viewable =  0 where is_viewable  is null;

commit;

Update country set is_viewable = 1 where name = 'Yugoslavia, Slovenia, Croatia';

update country set is_viewable = 0 where abbreviation in ('SCA','EAE');

commit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  9    DevTSM    1.8         2/27/2008 3:16:39 PM Debashish Mishra  
--  8    DevTSM    1.7         3/3/2005 6:38:52 AM  Debashish Mishra  
--  7    DevTSM    1.6         8/29/2003 5:11:40 PM Debashish Mishra  
--  6    DevTSM    1.5         2/21/2002 3:32:26 PM Debashish Mishra  
--  5    DevTSM    1.4         2/1/2002 11:06:19 AM Debashish Mishra Set the
--       active_flag for yugoslovia,croatia,slovania 
--  4    DevTSM    1.3         1/23/2002 12:53:45 PMDebashish Mishra After changing
--       the input source to foxpro
--  3    DevTSM    1.2         1/17/2002 12:18:36 PMDebashish Mishra  
--  2    DevTSM    1.1         1/16/2002 12:41:04 PMDebashish Mishra currency
--       related overhauling
--  1    DevTSM    1.0         1/8/2002 6:37:13 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
