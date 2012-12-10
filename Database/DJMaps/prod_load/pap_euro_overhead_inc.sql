--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: pap_euro_overhead_inc.sql$ 
--
-- $Revision: 4$        $Date: 2/27/2008 3:19:42 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
-- can be directly inserted into tsm10 from build_code1
-- No initial step required
-- Not dealing with france data for update (unable to identify rows uniquely)

Alter table tsm_stage.euroover add(region_id number(10));
update tsm_stage.euroover a set a.region_id = (select b.id from "&1".region b
	where b.abbreviation = 'PAR') where upper(a.paris) = 'I';

commit;


declare

 cursor c1 is select distinct ABR,typeoh,nvl(region_id,0) regionid from tsm_stage.euroover;
 pap_euro_overhead_exist number(3);
 countryid number(10);
 country_exist number(3);
 pap_euro_overhead_maxid number(10);
 invalid_country exception;

begin
  
 select nvl(max(id),0)+1 into pap_euro_overhead_maxid from
 "&1".pap_euro_overhead;

 for ix1 in c1 loop

  select count(*) into country_exist from "&1".country where abbreviation = ix1.abr;
  If country_exist=0 then
   raise invalid_country;
  end if;

  select id into countryid from "&1".country where abbreviation = ix1.abr;

  select count(*) into pap_euro_overhead_exist from "&1".pap_euro_overhead
  where country_id = countryid and adjusted_flg = decode(upper(ix1.typeoh),'A',1,'O',0) 
  and nvl(region_id,0) = ix1.regionid ;

  If pap_euro_overhead_exist = 0 then

        Insert into "&1".pap_euro_overhead select pap_euro_overhead_maxid,countryid,
        decode(upper(ix1.typeoh),'A',1,'O',0),
        decode(e.PCT25,'n/a',null,'-1',null,e.PCT25),
	decode(e.PCT50,'n/a',null,'-1',null,e.PCT50),
	decode(e.PCT75,'n/a',null,'-1',null,e.PCT75),region_id from tsm_stage.euroover e where 
	e.abr = ix1.abr and e.typeoh =  ix1.typeoh and nvl(e.region_id,0) = ix1.regionid ; 
       
	pap_euro_overhead_maxid:=pap_euro_overhead_maxid+1;

  else

         update "&1".pap_euro_overhead set (pct25,pct50,pct75) = 
	 (select decode(PCT25,'n/a',null,'-1',null,PCT25),
	 decode(PCT50,'n/a',null,'-1',null,PCT50),
	 decode(PCT75,'n/a',null,'-1',null,PCT75) from tsm_stage.euroover where
         abr=ix1.abr and typeoh =  ix1.typeoh and nvl(region_id,0) = ix1.regionid) 
         where country_id = countryid and adjusted_flg = decode(upper(ix1.typeoh),'A',1,'O',0)
         and nvl(region_id,0) = ix1.regionid;
       
  end if;
      
 end loop;
exception
  when invalid_country then
    Raise_application_error(-20202,'Country not found in country table');


end;
/

commit;
---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  4    DevTSM    1.3         2/27/2008 3:19:42 PM Debashish Mishra  
--  3    DevTSM    1.2         3/3/2005 6:41:48 AM  Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:14:43 PM Debashish Mishra  
--  1    DevTSM    1.0         2/19/2003 1:51:05 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
