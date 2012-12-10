--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: institution_inc.sql$ 
--
-- $Revision: 4$        $Date: 2/27/2008 3:19:41 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
update tsm_stage.inst set state = 'OK' where upper(state) = 'OK';
commit;

drop table tsm_stage.inst1;
create table tsm_stage.inst1 as select "ID",COUNTRY,
decode(i.region,null,i.state,i.region) region, 
decode(i.region,null,decode(i.state,null,null,'State'),'Region') reg_type, 
NAME,ZIPCODE,instit,addr1,addr2,addr3,
decode(affiliation,'A','Affiliated','U','Unaffiliated') affiliation,
city,county,comments,fax,phone,pobox,prov_terr,
decode(queriable,'T',1,'F',0,queriable) queriable,
timzused,burdpct from tsm_stage.inst i;

alter table tsm_stage.inst1 add (country_id number(10), region_id number(10));

Update tsm_stage.inst1 a set a.country_id = (select b.id from "&1".country b
	where b.abbreviation = a.country);


Update tsm_stage.inst1 a set a.region_id = (select b.id from "&1".region b
        where b.abbreviation = a.region and b.country_id = a.country_id 
        and upper(b.type) = 'STATE') where upper(reg_type) = 'STATE';


update tsm_stage.inst1 set city = substr(NAME,instr(NAME,'(',-1)+1,
length(NAME)-instr(NAME,'(',-1)-1) where name like '%)' 
and city is null;

update tsm_stage.inst1 set name=substr(name,1,instr(name,'(',-1)-1)
where name like '%)';

commit;

create index tsm_stage.indx1 on tsm_stage.inst1(instit);


declare

   Inst_maxid number(10);
   inst_exist number(3);

   cursor c1 is select instit from tsm_stage.inst1;

begin

   select nvl(max(id),0)+1 into inst_maxid from "&1".institution;

   for ix1 in c1 loop

      select count(*) into inst_exist from "&1".institution where 
      abbreviation=ix1.instit;

      If inst_exist = 0 then

         insert into "&1".institution select inst_maxid,country_id,region_id,
	 name,zipcode,instit,addr1,addr2,addr3, 
	 affiliation,city,county,comments,fax,phone,
	 pobox,prov_terr,queriable,0,timzused,burdpct 
	 from tsm_stage.inst1 where instit = ix1.instit;

         inst_maxid:=inst_maxid+1;

      else

         update "&1".institution set (NAME,ZIP_CODE,ABBREVIATION,INSTADDR1,      
	 INSTADDR2,INSTADDR3,AFFILIATION,CITY,COUNTY,COMMENTS,FAX,PHONE,          
	 POBOX,PROV_TERR,QUERIABLE,TIMESUSED,BURDEN_PCT) = (select 
	 name,zipcode,instit,addr1,addr2,addr3,affiliation,city,county,
	 comments,fax,phone,pobox,prov_terr,queriable,timzused,burdpct 
	 from tsm_stage.inst1 where instit = ix1.instit) where abbreviation = ix1.instit;    

     end if;

   end loop;
   commit;
end;
/

drop index tsm_stage.indx1 ;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  4    DevTSM    1.3         2/27/2008 3:19:41 PM Debashish Mishra  
--  3    DevTSM    1.2         3/3/2005 6:41:41 AM  Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:14:38 PM Debashish Mishra  
--  1    DevTSM    1.0         2/19/2003 1:51:00 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
