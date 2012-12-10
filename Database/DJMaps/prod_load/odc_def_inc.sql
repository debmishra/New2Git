--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: odc_def_inc.sql$ 
--
-- $Revision: 5$        $Date: 2/27/2008 3:19:42 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
update tsm_stage.PROCDESC set "PROCEDURE" = 'VBED*' where  "PROCEDURE" =  '*BED*';
update tsm_stage.PROCDESC set "PROCEDURE" = 'VDAY*' where  "PROCEDURE" =  '*DAY*';
update tsm_stage.PROCDESC set "PROCEDURE" = 'VPHRM' where  "PROCEDURE" =  '*PHRM';
update tsm_stage.PROCDESC set "PROCEDURE" = 'VREIM' where  "PROCEDURE" =  '*REIM';
update tsm_stage.PROCDESC set "PROCEDURE" = 'VHOTL' where  "PROCEDURE" =  '*HOTL';
commit;

update tsm_stage.PROCDESC set ISPROC = 0 where "PROCEDURE" in ('#6002','#6003','#6004');
commit;


declare

 BuildTagId number(10);
 od_exist number(3);
 od_maxid number(10);
 cursor c1 is select procedure,"DESC",proctype,hide from tsm_stage.procdesc where isproc = 0 and 
 not proctype in ('PatientOrSite','PatientOrVisit');
 cursor c2 is select procedure,"DESC",proctype,hide from tsm_stage.procdesc where isproc = 0 and 
 proctype in ('PatientOrSite','PatientOrVisit');
 parent_od_maxid number(10);
 inserted_rows number(10):=0;
 updated_rows number(10):=0;
 od_need_update number(3);


begin

 select nvl(max(id),0) into BuildTagId from "&1".build_tag;
 select nvl(max(id),0)+1 into od_maxid from "&1".odc_def;

 for ix1 in c1 loop

   select count(*) into od_exist from "&1".odc_def where
   picas_code = ix1.procedure;

   If od_exist = 0 then

       Insert into "&1".odc_def select od_maxid,
       PROCEDURE,"DESC",0,proctype,hide,null,BuildTagId from 
       tsm_stage.procdesc where isproc = 0  and procedure = ix1.procedure;

       od_maxid:=od_maxid+1;
       inserted_rows:=inserted_rows+1;

   Else
 
      select count(*) into od_need_update from "&1".odc_def where
      picas_code = ix1.procedure and long_desc = ix1."DESC" and 
      procedure_level = ix1.proctype and hide=ix1.hide;

      If od_need_update = 0 then

        update "&1".odc_def set (long_desc,procedure_level,hide) = (select
        "DESC",proctype,hide from tsm_stage.procdesc where isproc = 0  and 
        procedure = ix1.procedure) where picas_code = ix1.procedure;
        
        updated_rows:=updated_rows+1;

      End if;

   End if;
 End loop;

 for ix2 in c2 loop 

   select count(*) into od_exist from "&1".odc_def where
   picas_code = ix2.procedure and procedure_level = ix2.proctype;
  
  If od_exist = 0 then

       Insert into "&1".odc_def select od_maxid,
       PROCEDURE,"DESC",0,proctype,hide,null,BuildTagId from 
       tsm_stage.procdesc where isproc = 0  and procedure = ix2.procedure;

       parent_od_maxid:=od_maxid;
       od_maxid:=od_maxid+1;

       inserted_rows:=inserted_rows+1;

       If ix2.proctype = 'PatientOrSite' then

          Insert into "&1".odc_def select od_maxid,
          PROCEDURE,"DESC",0,'Patient',hide,null,BuildTagId from 
          tsm_stage.procdesc where isproc = 0  and procedure = ix2.procedure;         

          Insert into "&1".odc_def_mapper(odc_def_id,parent_odc_def_id) 
	  values (od_maxid,parent_od_maxid);

          od_maxid:=od_maxid+1;
          inserted_rows:=inserted_rows+1;

          Insert into "&1".odc_def select od_maxid,
          PROCEDURE,"DESC",0,'Site',hide,null,BuildTagId from 
          tsm_stage.procdesc where isproc = 0  and procedure = ix2.procedure;         

          Insert into "&1".odc_def_mapper(odc_def_id,parent_odc_def_id) 
	  values (od_maxid,parent_od_maxid);

          od_maxid:=od_maxid+1;
          inserted_rows:=inserted_rows+1;

       Elsif ix2.proctype = 'PatientOrVisit' then

          Insert into "&1".odc_def select od_maxid,
          PROCEDURE,"DESC",0,'Patient',hide,null,BuildTagId from 
          tsm_stage.procdesc where isproc = 0  and procedure = ix2.procedure;         

          Insert into "&1".odc_def_mapper(odc_def_id,parent_odc_def_id) 
	  values (od_maxid,parent_od_maxid);

          od_maxid:=od_maxid+1;
          inserted_rows:=inserted_rows+1;

          Insert into "&1".odc_def select od_maxid,
          'V'||substr(PROCEDURE,2),"DESC",0,'Visit',hide,null,BuildTagId from 
          tsm_stage.procdesc where isproc = 0  and procedure = ix2.procedure;         

          Insert into "&1".odc_def_mapper(odc_def_id,parent_odc_def_id) 
	  values (od_maxid,parent_od_maxid);

          od_maxid:=od_maxid+1;
          inserted_rows:=inserted_rows+1;

       End if;

    Else


      select count(*) into od_need_update from "&1".odc_def where
      picas_code = ix2.procedure and long_desc = ix2."DESC" and 
      procedure_level = ix2.proctype and hide=ix2.hide;

      If od_need_update = 0 then


         update "&1".odc_def set (long_desc,procedure_level,hide) = (select
         "DESC",proctype,hide from tsm_stage.procdesc where isproc = 0  and 
         procedure = ix2.procedure) where picas_code = ix2.procedure and 
         procedure_level=ix2.proctype ;

         updated_rows:=updated_rows+1;

         If ix2.proctype = 'PatientOrSite' then

            update "&1".odc_def set (long_desc,hide) = (select
            "DESC",hide from tsm_stage.procdesc where isproc = 0  and 
            procedure = ix2.procedure) where picas_code = ix2.procedure and 
            procedure_level in ('Patient','Site') ;

            updated_rows:=updated_rows+2;

         Elsif  ix2.proctype = 'PatientOrVisit' then

            update "&1".odc_def set (long_desc,hide) = (select
            "DESC",hide from tsm_stage.procdesc where isproc = 0  and 
            procedure = ix2.procedure) where picas_code = ix2.procedure and 
            procedure_level in ('Patient') ;


            update "&1".odc_def set (long_desc,hide) = (select
            "DESC",hide from tsm_stage.procdesc where isproc = 0  and 
            procedure = ix2.procedure) where picas_code = 'V'||substr(ix2.procedure,2) and 
            procedure_level in ('Visit') ;

            updated_rows:=updated_rows+2;

         End if;
       End if;
    End if;
   End loop;

 update "&1".odc_def set (obsolete_flg,obsolete_build_tag_id) = (select 1,BuildTagId 
 from dual) where picas_code not in (select procedure from tsm_stage.procdesc where isproc = 0)
 and not picas_code like 'SL%';

 Insert into "&1".data_load_history(table_name,num_inserted,num_updated) values 
 ('Odc_def',inserted_rows,updated_rows);

 commit;
end;
/
sho err

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/27/2008 3:19:42 PM Debashish Mishra  
--  4    DevTSM    1.3         3/3/2005 6:41:47 AM  Debashish Mishra  
--  3    DevTSM    1.2         7/9/2003 5:10:39 PM  Debashish Mishra  
--  2    DevTSM    1.1         5/29/2003 5:40:08 PM Debashish Mishra Modified for
--       GM1.1
--  1    DevTSM    1.0         2/19/2003 1:51:04 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
