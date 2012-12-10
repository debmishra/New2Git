--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: derived_price_inc.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:17:06 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
update tsm_stage.derived_price1 set cntry='VNM' where cntry='VTM';
commit;

update tsm_stage.derived_price1 set country_id=null;
commit;
update tsm_stage.derived_price1 set prc_def_id=null;
commit;
update tsm_stage.derived_price1 set odc_def_id=null;
commit;

--insert into tsm_stage.derived_price1("PROCEDURE",CNTRY,PCT25,PCT50,PCT75) 
--select "PROCEDURE",'FSU',PCT25,PCT50,PCT75 from tsm_stage.derived_price1
--where CNTRY='RIA';

--insert into tsm_stage.derived_price1("PROCEDURE",CNTRY,PCT25,PCT50,PCT75) 
--select "PROCEDURE",'SCY',PCT25,PCT50,PCT75 from tsm_stage.derived_price1
--where CNTRY='YUG';

--insert into tsm_stage.derived_price1("PROCEDURE",CNTRY,PCT25,PCT50,PCT75) 
--select "PROCEDURE",'BUL',PCT25,PCT50,PCT75 from tsm_stage.derived_price1
--where CNTRY='BLG';

--insert into tsm_stage.derived_price1("PROCEDURE",CNTRY,PCT25,PCT50,PCT75) 
--select "PROCEDURE",'PHC',PCT25,PCT50,PCT75 from tsm_stage.derived_price1
--where CNTRY='CZE';
--commit;

update tsm_stage.derived_price1 a set a.country_id=(select b.id from
"&1".country b where b.abbreviation=a.cntry) where a.country_id is null;
commit;

update tsm_stage.DERIVED_PRICE1 set "PROCEDURE" = 'VBED*' where  "PROCEDURE" =  '*BED*';
update tsm_stage.DERIVED_PRICE1 set "PROCEDURE" = 'VDAY*' where  "PROCEDURE" =  '*DAY*';
update tsm_stage.DERIVED_PRICE1 set "PROCEDURE" = 'VPHRM' where  "PROCEDURE" =  '*PHRM';
update tsm_stage.DERIVED_PRICE1 set "PROCEDURE" = 'VREIM' where  "PROCEDURE" =  '*REIM';
update tsm_stage.DERIVED_PRICE1 set "PROCEDURE" = 'VHOTL' where  "PROCEDURE" =  '*HOTL';
commit;

update tsm_stage.derived_price1 a set a.PRC_DEF_ID=(select b.id from
"&1".procedure_def b where b.cpt_code=a."PROCEDURE");
commit;

declare

odc_exists number(4);
cursor c1 is select "PROCEDURE" from tsm_stage.derived_price1 where prc_def_id is null;
proc_not_found exception;

begin

 for ix1 in c1 loop
   select count(*) into odc_exists from "&1".odc_def where picas_code=ix1."PROCEDURE";
 
   if odc_exists=1 then

      update tsm_stage.derived_price1 a set a.odc_def_id=(select b.id from
      "&1".odc_def b where b.picas_code=a."PROCEDURE") where a."PROCEDURE"=ix1."PROCEDURE";

   elsif odc_exists=0 then

      raise proc_not_found;

   else
       declare
	 cursor c2 is select id from "&1".odc_def where picas_code=ix1."PROCEDURE";      
       begin
         for ix2 in c2 loop
           insert into tsm_stage.derived_price1 ("PROCEDURE",prc_def_id, odc_def_id,
	   country_id, cntry,pct25,pct50,pct75) select "PROCEDURE", null, ix2.id,
	   country_id, cntry,pct25,pct50,pct75 from tsm_stage.derived_price1 where
	   "PROCEDURE"=ix1."PROCEDURE" and odc_def_id is null;
         end loop;
           delete from tsm_stage.derived_price1 where "PROCEDURE"=ix1."PROCEDURE" 
           and odc_def_id is null;
       end;
   end if;
 end loop;
exception

   when proc_not_found then
      raise_application_error(-200107,'Procedure neither found in procedure_def nor in odc_def');
end ;
/
commit;

Alter table tsm_stage.derived_price1 add(type varchar2(20));
update tsm_stage.derived_price1 set type='ODC' where odc_def_id is not null;
update tsm_stage.derived_price1 set type='PROC' where prc_def_id is not null;
commit;

drop sequence "&1".derived_prices_seq;
create sequence "&1".derived_prices_seq;

truncate table "&1".derived_prices;

insert into "&1".derived_prices (ID,COUNTRY_ID,LOW_PRICE,MED_PRICE,HIGH_PRICE,
TYPE,PROCEDURE_DEF_ID,ODC_DEF_ID) select "&1".derived_prices_seq.nextval,COUNTRY_ID,
PCT25,PCT50,PCT75,TYPE,PRC_DEF_ID,ODC_DEF_ID from tsm_stage.derived_price1;
commit;

drop sequence "&1".derived_prices_seq;
            





---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:17:06 PM Debashish Mishra  
--  2    DevTSM    1.1         2/7/2007 10:28:00 PM Debashish Mishra  
--  1    DevTSM    1.0         2/2/2006 12:41:30 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
