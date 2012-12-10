--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: price_level_inc.sql$ 
--
-- $Revision: 13$        $Date: 2/27/2008 3:17:12 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
update tsm_stage.PRICELST set "PROCEDURE" = 'VBED*' where  "PROCEDURE" =  '*BED*';
update tsm_stage.PRICELST set "PROCEDURE" = 'VDAY*' where  "PROCEDURE" =  '*DAY*';
update tsm_stage.PRICELST set "PROCEDURE" = 'VPHRM' where  "PROCEDURE" =  '*PHRM';
update tsm_stage.PRICELST set "PROCEDURE" = 'VREIM' where  "PROCEDURE" =  '*REIM';
update tsm_stage.PRICELST set "PROCEDURE" = 'VHOTL' where  "PROCEDURE" =  '*HOTL';
commit;

delete from tsm_stage.pricelst where rowid not in (select min(rowid)
	from tsm_stage.pricelst group by "PROCEDURE");
COMMIT;

create index "&1".dl_indx1 on "&1".odc_def(picas_code);
create index "&1".dl_indx2 on "&1".procedure_def(cpt_code);

truncate table "&1".price_level;

drop sequence "&1".price_level_seq;
create sequence "&1".price_level_seq;

create index tsm_stage.dl_indx3 on tsm_stage.pricelst("PROCEDURE");

-- Following change was as per request of Peter on 02/11/2002 

delete from tsm_stage.pricelst where "PROCEDURE" in ('*CARD','*ENCR','*GYNE','*NURS','*OPHT','*PSYC',
	'*RADI','V1138','V1139','V1140','V1143');

commit;

 
declare

cursor c1 is select rowid,"PROCEDURE" from tsm_stage.pricelst where
	"PROCEDURE" in (select picas_code from "&1".odc_def);

cursor c2 is select rowid,"PROCEDURE" from tsm_stage.pricelst where
	"PROCEDURE" in (select cpt_code from "&1".procedure_def);

countryid number(10);
procid number(10);


begin

for ix1 in c1 loop

	select id into procid from "&1".odc_def where picas_code = ix1."PROCEDURE"
	and not id in( select id from "&1".odc_def where procedure_level in 
	('Patient','Site','Visit') and picas_code in ( select picas_code from "&1".odc_def 
	where procedure_level in ('PatientOrSite','PatientOrVisit')));


	select id into countryid from "&1".country where abbreviation = 'AUS';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', auslow, ausmed, aushigh,
	procid, null,null from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'ARI';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', arilow, arimed, arihigh,
	procid, null,plist_ari from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'BEL';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', bellow, belmed, belhigh,
	procid, null,null from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'BUL';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', bullow, bulmed, bulhigh,
	procid, null,null from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'CAN';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', canlow, canmed, canhigh,
	procid, null,null from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'DEN';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', denlow, denmed, denhigh,
	procid, null,null from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'DEU';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', deulow, deumed, deuhigh,
	procid, null,plist_deu from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'ESP';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', esplow, espmed, esphigh,
	procid, null,null from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'FIN';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', finlow, finmed, finhigh,
	procid, null,null from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'FRA';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', fralow, framed, frahigh,
	procid, null,plist_fra from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'FSU';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', fsulow, fsumed, fsuhigh,
	procid, null,null from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'HUN';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', hunlow, hunmed, hunhigh,
	procid, null,null from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'IRL';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', irelow, iremed, irehigh,
	procid, null,null from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'ISR';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', isrlow, isrmed, isrhigh,
	procid, null,null from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'ITA';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', italow, itamed, itahigh,
	procid, null,null from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'NET';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', netlow, netmed, nethigh,
	procid, null,plist_net from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'NOR';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', norlow, normed, norhigh,
	procid, null,null from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'PHC';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', phclow, phcmed, phchigh,
	procid, null,null from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'POL';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', pollow, polmed, polhigh,
	procid, null,plist_pol from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'SAF';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', saflow, safmed, safhigh,
	procid, null,null from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'SCY';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', scylow, scymed, scyhigh,
	procid, null,null from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'SWE';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', swelow, swemed, swehigh,
	procid, null,null from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'SWI';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', swilow, swimed, swihigh,
	procid, null,null from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'UK';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', uklow, ukmed, ukhigh,
	procid, null,plist_uk from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'USA';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', uslow, usmed, ushigh,
	procid, null,null from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'ARG';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', arglow, argmed, arghigh,
	procid, null,null from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'BRA';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', bralow, bramed, brahigh,
	procid, null,null from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'CHI';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', chilow, chimed, chihigh,
	procid, null,null from tsm_stage.pricelst where
	rowid = ix1.rowid;

	select id into countryid from "&1".country where abbreviation = 'MEX';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'ODC', mexlow, mexmed, mexhigh,
	procid, null,plist_mex from tsm_stage.pricelst where
	rowid = ix1.rowid;


end loop ;

commit;

for ix2 in c2 loop

	select id into procid from "&1".procedure_def where cpt_code = ix2."PROCEDURE" 
	and not id in(select id from "&1".procedure_def where procedure_level in 
	('Patient','Site','Visit') and cpt_code in ( select cpt_code from "&1".procedure_def 
	where procedure_level in ('PatientOrSite','PatientOrVisit')));


	select id into countryid from "&1".country where abbreviation = 'AUS';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', auslow, ausmed, aushigh,
	null,procid,null from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'ARI';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', arilow, arimed, arihigh,
	null,procid,plist_ari from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'BEL';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', bellow, belmed, belhigh,
	null,procid,null from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'BUL';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', bullow, bulmed, bulhigh,
	null,procid,null from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'CAN';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', canlow, canmed, canhigh,
	null,procid,null from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'DEN';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', denlow, denmed, denhigh,
	null,procid,null from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'DEU';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', deulow, deumed, deuhigh,
	null,procid,plist_deu from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'ESP';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', esplow, espmed, esphigh,
	null,procid,null from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'FIN';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', finlow, finmed, finhigh,
	null,procid,null from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'FRA';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', fralow, framed, frahigh,
	null,procid,plist_fra from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'FSU';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', fsulow, fsumed, fsuhigh,
	null,procid,null from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'HUN';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', hunlow, hunmed, hunhigh,
	null,procid,null from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'IRL';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', irelow, iremed, irehigh,
	null,procid,null from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'ISR';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', isrlow, isrmed, isrhigh,
	null,procid,null from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'ITA';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', italow, itamed, itahigh,
	null,procid,null from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'NET';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', netlow, netmed, nethigh,
	null,procid,plist_net from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'NOR';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', norlow, normed, norhigh,
	null,procid,null from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'PHC';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', phclow, phcmed, phchigh,
	null,procid,null from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'POL';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', pollow, polmed, polhigh,
	null,procid,plist_pol from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'SAF';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', saflow, safmed, safhigh,
	null,procid,null from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'SCY';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', scylow, scymed, scyhigh,
	null,procid,null from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'SWE';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', swelow, swemed, swehigh,
	null,procid,null from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'SWI';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', swilow, swimed, swihigh,
	null,procid,null from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'UK';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', uklow, ukmed, ukhigh,
	null,procid,plist_uk from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'USA';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', uslow, usmed, ushigh,
	null,procid,null from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'ARG';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', arglow, argmed, arghigh,
	null,procid,null from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'BRA';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', bralow, bramed, brahigh,
	null,procid,null from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'CHI';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', chilow, chimed, chihigh,
	null,procid,null from tsm_stage.pricelst where
	rowid = ix2.rowid;

	select id into countryid from "&1".country where abbreviation = 'MEX';

        Insert into "&1".price_level select 
	"&1".price_level_seq.nextval, countryid, 'CLIN', mexlow, mexmed, mexhigh,
	null,procid,plist_mex from tsm_stage.pricelst where
	rowid = ix2.rowid;



end loop ;

commit;

end;
/
sho err


drop index "&1".dl_indx1;
drop index "&1".dl_indx2;
drop index tsm_stage.dl_indx3;

update "&1".price_level set LOW_PRICE = null where low_price = 0;
update "&1".price_level set MED_PRICE = null where MED_PRICE = 0;
update "&1".price_level set HIGH_PRICE = null where HIGH_PRICE = 0;

commit;

delete from "&1".price_level where 
nvl(LOW_PRICE,0) = 0 and nvl(MED_PRICE,0) = 0 
and nvl(HIGH_PRICE,0) = 0;

commit;

delete from "&1".price_level where country_id in
(select id from "&1".country where abbreviation in ('USA','CAN'));

commit;


-- Following four insert statements are added as per the request of Kelly on 10/24/2002 at 13:00

Insert into "&1".price_level select "&1".price_level_seq.nextval,c.id,'CLIN',
	a.uspct25,a.uspct50,a.uspct75,null,b.id,null 
	from tsm_stage.procdesc a,"&1".procedure_def b, "&1".country c 
	where a.procedure = b.cpt_code and
	c.abbreviation = 'USA' and
	a.isproc <> 0 and
	a.hide = 0 and
	nvl(a.uspct25,0)+nvl(a.uspct50,0)+nvl(a.uspct75,0) > 0;

Insert into "&1".price_level select "&1".price_level_seq.nextval,c.id,'CLIN',
	a.canpct25,a.canpct50,a.canpct75,null,b.id,null  
	from tsm_stage.procdesc a,"&1".procedure_def b, "&1".country c 
	where a.procedure = b.cpt_code and
	c.abbreviation = 'CAN' and
	a.isproc <> 0 and
	a.hide = 0 and
	nvl(a.canpct25,0)+nvl(a.canpct50,0)+nvl(a.canpct75,0) > 0;

Insert into "&1".price_level select "&1".price_level_seq.nextval,c.id,'ODC',
	a.uspct25,a.uspct50,a.uspct75,b.id,null,null  
	from tsm_stage.procdesc a,"&1".odc_def b, "&1".country c 
	where a.procedure = b.picas_code and
	c.abbreviation = 'USA' and
	a.isproc = 0 and
	a.hide = 0 and
	nvl(a.uspct25,0)+nvl(a.uspct50,0)+nvl(a.uspct75,0) > 0;

Insert into "&1".price_level select "&1".price_level_seq.nextval,c.id,'ODC',
	a.canpct25,a.canpct50,a.canpct75,b.id,null,null 
	from tsm_stage.procdesc a,"&1".odc_def b, "&1".country c 
	where a.procedure = b.picas_code and
	c.abbreviation = 'CAN' and
	a.isproc = 0 and
	a.hide = 0 and
	nvl(a.canpct25,0)+nvl(a.canpct50,0)+nvl(a.canpct75,0) > 0;

commit;

declare

 gottobezero exception;
 cnt  number(10);

begin

  select count(*) into cnt from tsm_stage.pricelst where not "PROCEDURE" in
  (select picas_code from "&1".odc_def union select cpt_code from "&1".procedure_def);

  If cnt > 0 then
    Raise gottobezero;
  end if;

exception

  when gottobezero then
     Raise_application_error(-20207,'Unreferenced procedures in pricelst.dbf');
end;
/
sho err


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  13   DevTSM    1.12        2/27/2008 3:17:12 PM Debashish Mishra  
--  12   DevTSM    1.11        2/7/2007 10:28:38 PM Debashish Mishra  
--  11   DevTSM    1.10        3/3/2005 6:40:51 AM  Debashish Mishra  
--  10   DevTSM    1.9         8/29/2003 5:13:35 PM Debashish Mishra  
--  9    DevTSM    1.8         10/28/2002 10:58:25 AMDebashish Mishra Skipped USA
--       and CAN rows from pricelst.dbf
--  8    DevTSM    1.7         10/24/2002 3:40:26 PMDebashish Mishra Added data
--       from procmstr.dbf
--  7    DevTSM    1.6         8/30/2002 12:43:13 PMDebashish Mishra Modified for
--       passing the schema name as an parameter
--  6    DevTSM    1.5         5/10/2002 1:20:11 PM Debashish Mishra  
--  5    DevTSM    1.4         4/25/2002 2:31:52 PM Debashish Mishra  
--  4    DevTSM    1.3         4/3/2002 6:58:08 PM  Debashish Mishra  
--  3    DevTSM    1.2         3/28/2002 12:03:36 PMDebashish Mishra  
--  2    DevTSM    1.1         3/22/2002 12:51:47 PMDebashish Mishra  
--  1    DevTSM    1.0         3/20/2002 9:24:11 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
