--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: price_level.sql$ 
--
-- $Revision: 9$        $Date: 2/27/2008 3:16:42 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 

create index dl_indx1 on odc_def(picas_code);
create index dl_indx2 on procedure_def(cpt_code);


drop sequence price_level_seq;
create sequence price_level_seq;

create index dl_indx3 on pricelst("PROCEDURE");

-- Following change was as per request of Peter on 02/11/2002 

delete from pricelst where "PROCEDURE" in ('*CARD','*ENCR','*GYNE','*NURS','*OPHT','*PSYC',
	'*RADI','V1138','V1139','V1140','V1143');

commit;

create or replace procedure temp_load_pricelst as 
 

cursor c1 is select rowid,"PROCEDURE" from pricelst where
	"PROCEDURE" in (select picas_code from odc_def);

cursor c2 is select rowid,"PROCEDURE" from pricelst where
	"PROCEDURE" in (select cpt_code from procedure_def);

countryid country.id%type;
procid odc_def.id%type;


begin

for ix1 in c1 loop

	select id into procid from odc_def where picas_code = ix1."PROCEDURE";


	select id into countryid from country where abbreviation = 'AUS';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'ODC', auslow, ausmed, aushigh,
	procid, null from pricelst where
	rowid = ix1.rowid;

	select id into countryid from country where abbreviation = 'ARI';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'ODC', arilow, arimed, arihigh,
	procid, null from pricelst where
	rowid = ix1.rowid;

	select id into countryid from country where abbreviation = 'BEL';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'ODC', bellow, belmed, belhigh,
	procid, null from pricelst where
	rowid = ix1.rowid;

	select id into countryid from country where abbreviation = 'BUL';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'ODC', bullow, bulmed, bulhigh,
	procid, null from pricelst where
	rowid = ix1.rowid;

	select id into countryid from country where abbreviation = 'CAN';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'ODC', canlow, canmed, canhigh,
	procid, null from pricelst where
	rowid = ix1.rowid;

	select id into countryid from country where abbreviation = 'DEN';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'ODC', denlow, denmed, denhigh,
	procid, null from pricelst where
	rowid = ix1.rowid;

	select id into countryid from country where abbreviation = 'DEU';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'ODC', deulow, deumed, deuhigh,
	procid, null from pricelst where
	rowid = ix1.rowid;

	select id into countryid from country where abbreviation = 'ESP';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'ODC', esplow, espmed, esphigh,
	procid, null from pricelst where
	rowid = ix1.rowid;

	select id into countryid from country where abbreviation = 'FIN';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'ODC', finlow, finmed, finhigh,
	procid, null from pricelst where
	rowid = ix1.rowid;

	select id into countryid from country where abbreviation = 'FRA';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'ODC', fralow, framed, frahigh,
	procid, null from pricelst where
	rowid = ix1.rowid;

	select id into countryid from country where abbreviation = 'FSU';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'ODC', fsulow, fsumed, fsuhigh,
	procid, null from pricelst where
	rowid = ix1.rowid;

	select id into countryid from country where abbreviation = 'HUN';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'ODC', hunlow, hunmed, hunhigh,
	procid, null from pricelst where
	rowid = ix1.rowid;

	select id into countryid from country where abbreviation = 'IRL';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'ODC', irelow, iremed, irehigh,
	procid, null from pricelst where
	rowid = ix1.rowid;

	select id into countryid from country where abbreviation = 'ISR';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'ODC', isrlow, isrmed, isrhigh,
	procid, null from pricelst where
	rowid = ix1.rowid;

	select id into countryid from country where abbreviation = 'ITA';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'ODC', italow, itamed, itahigh,
	procid, null from pricelst where
	rowid = ix1.rowid;

	select id into countryid from country where abbreviation = 'NET';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'ODC', netlow, netmed, nethigh,
	procid, null from pricelst where
	rowid = ix1.rowid;

	select id into countryid from country where abbreviation = 'NOR';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'ODC', norlow, normed, norhigh,
	procid, null from pricelst where
	rowid = ix1.rowid;

	select id into countryid from country where abbreviation = 'PHC';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'ODC', phclow, phcmed, phchigh,
	procid, null from pricelst where
	rowid = ix1.rowid;

	select id into countryid from country where abbreviation = 'POL';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'ODC', pollow, polmed, polhigh,
	procid, null from pricelst where
	rowid = ix1.rowid;

	select id into countryid from country where abbreviation = 'SAF';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'ODC', saflow, safmed, safhigh,
	procid, null from pricelst where
	rowid = ix1.rowid;

	select id into countryid from country where abbreviation = 'SCY';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'ODC', scylow, scymed, scyhigh,
	procid, null from pricelst where
	rowid = ix1.rowid;

	select id into countryid from country where abbreviation = 'SWE';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'ODC', swelow, swemed, swehigh,
	procid, null from pricelst where
	rowid = ix1.rowid;

	select id into countryid from country where abbreviation = 'SWI';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'ODC', swilow, swimed, swihigh,
	procid, null from pricelst where
	rowid = ix1.rowid;

	select id into countryid from country where abbreviation = 'UK';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'ODC', uklow, ukmed, ukhigh,
	procid, null from pricelst where
	rowid = ix1.rowid;

	select id into countryid from country where abbreviation = 'USA';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'ODC', uslow, usmed, ushigh,
	procid, null from pricelst where
	rowid = ix1.rowid;

end loop ;

commit;

for ix2 in c2 loop

	select id into procid from procedure_def where cpt_code = ix2."PROCEDURE";


	select id into countryid from country where abbreviation = 'AUS';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'CLIN', auslow, ausmed, aushigh,
	null,procid from pricelst where
	rowid = ix2.rowid;

	select id into countryid from country where abbreviation = 'ARI';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'CLIN', arilow, arimed, arihigh,
	null,procid from pricelst where
	rowid = ix2.rowid;

	select id into countryid from country where abbreviation = 'BEL';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'CLIN', bellow, belmed, belhigh,
	null,procid from pricelst where
	rowid = ix2.rowid;

	select id into countryid from country where abbreviation = 'BUL';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'CLIN', bullow, bulmed, bulhigh,
	null,procid from pricelst where
	rowid = ix2.rowid;

	select id into countryid from country where abbreviation = 'CAN';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'CLIN', canlow, canmed, canhigh,
	null,procid from pricelst where
	rowid = ix2.rowid;

	select id into countryid from country where abbreviation = 'DEN';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'CLIN', denlow, denmed, denhigh,
	null,procid from pricelst where
	rowid = ix2.rowid;

	select id into countryid from country where abbreviation = 'DEU';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'CLIN', deulow, deumed, deuhigh,
	null,procid from pricelst where
	rowid = ix2.rowid;

	select id into countryid from country where abbreviation = 'ESP';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'CLIN', esplow, espmed, esphigh,
	null,procid from pricelst where
	rowid = ix2.rowid;

	select id into countryid from country where abbreviation = 'FIN';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'CLIN', finlow, finmed, finhigh,
	null,procid from pricelst where
	rowid = ix2.rowid;

	select id into countryid from country where abbreviation = 'FRA';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'CLIN', fralow, framed, frahigh,
	null,procid from pricelst where
	rowid = ix2.rowid;

	select id into countryid from country where abbreviation = 'FSU';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'CLIN', fsulow, fsumed, fsuhigh,
	null,procid from pricelst where
	rowid = ix2.rowid;

	select id into countryid from country where abbreviation = 'HUN';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'CLIN', hunlow, hunmed, hunhigh,
	null,procid from pricelst where
	rowid = ix2.rowid;

	select id into countryid from country where abbreviation = 'IRL';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'CLIN', irelow, iremed, irehigh,
	null,procid from pricelst where
	rowid = ix2.rowid;

	select id into countryid from country where abbreviation = 'ISR';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'CLIN', isrlow, isrmed, isrhigh,
	null,procid from pricelst where
	rowid = ix2.rowid;

	select id into countryid from country where abbreviation = 'ITA';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'CLIN', italow, itamed, itahigh,
	null,procid from pricelst where
	rowid = ix2.rowid;

	select id into countryid from country where abbreviation = 'NET';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'CLIN', netlow, netmed, nethigh,
	null,procid from pricelst where
	rowid = ix2.rowid;

	select id into countryid from country where abbreviation = 'NOR';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'CLIN', norlow, normed, norhigh,
	null,procid from pricelst where
	rowid = ix2.rowid;

	select id into countryid from country where abbreviation = 'PHC';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'CLIN', phclow, phcmed, phchigh,
	null,procid from pricelst where
	rowid = ix2.rowid;

	select id into countryid from country where abbreviation = 'POL';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'CLIN', pollow, polmed, polhigh,
	null,procid from pricelst where
	rowid = ix2.rowid;

	select id into countryid from country where abbreviation = 'SAF';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'CLIN', saflow, safmed, safhigh,
	null,procid from pricelst where
	rowid = ix2.rowid;

	select id into countryid from country where abbreviation = 'SCY';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'CLIN', scylow, scymed, scyhigh,
	null,procid from pricelst where
	rowid = ix2.rowid;

	select id into countryid from country where abbreviation = 'SWE';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'CLIN', swelow, swemed, swehigh,
	null,procid from pricelst where
	rowid = ix2.rowid;

	select id into countryid from country where abbreviation = 'SWI';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'CLIN', swilow, swimed, swihigh,
	null,procid from pricelst where
	rowid = ix2.rowid;

	select id into countryid from country where abbreviation = 'UK';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'CLIN', uklow, ukmed, ukhigh,
	null,procid from pricelst where
	rowid = ix2.rowid;

	select id into countryid from country where abbreviation = 'USA';

        Insert into price_level select 
	price_level_seq.nextval, countryid, 'CLIN', uslow, usmed, ushigh,
	null,procid from pricelst where
	rowid = ix2.rowid;

end loop ;

commit;

end;
/
sho err

exec temp_load_pricelst

drop index dl_indx1;
drop index dl_indx2;
drop index dl_indx3;

update price_level set LOW_PRICE = null where low_price = 0;
update price_level set MED_PRICE = null where MED_PRICE = 0;
update price_level set HIGH_PRICE = null where HIGH_PRICE = 0;

commit;

delete from price_level where 
nvl(LOW_PRICE,0) = 0 and nvl(MED_PRICE,0) = 0 
and nvl(HIGH_PRICE,0) = 0;

commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  9    DevTSM    1.8         2/27/2008 3:16:42 PM Debashish Mishra  
--  8    DevTSM    1.7         3/3/2005 6:39:16 AM  Debashish Mishra  
--  7    DevTSM    1.6         8/29/2003 5:12:01 PM Debashish Mishra  
--  6    DevTSM    1.5         3/22/2002 4:40:19 PM Debashish Mishra  
--  5    DevTSM    1.4         3/18/2002 7:42:21 PM Debashish Mishra  
--  4    DevTSM    1.3         3/8/2002 10:54:12 AM Debashish Mishra  
--  3    DevTSM    1.2         2/12/2002 12:19:57 PMDebashish Mishra  
--  2    DevTSM    1.1         1/23/2002 12:53:51 PMDebashish Mishra After changing
--       the input source to foxpro
--  1    DevTSM    1.0         1/15/2002 12:30:32 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
