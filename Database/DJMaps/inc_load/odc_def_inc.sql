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
-- $Revision: 17$        $Date: 2/27/2008 3:17:11 PM$
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
 cursor c1 is select procedure,"DESC",proctype,hide,short_desc from tsm_stage.procdesc where isproc = 0 and 
 not proctype in ('PatientOrSite','PatientOrVisit');
 cursor c2 is select procedure,"DESC",proctype,hide,short_desc from tsm_stage.procdesc where isproc = 0 and 
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
       PROCEDURE,"DESC",0,proctype,hide,null,BuildTagId,1,short_desc from 
       tsm_stage.procdesc where isproc = 0  and procedure = ix1.procedure;

       od_maxid:=od_maxid+1;
       inserted_rows:=inserted_rows+1;

   Else
 
      select count(*) into od_need_update from "&1".odc_def where
      picas_code = ix1.procedure and long_desc = ix1."DESC" and 
      procedure_level = ix1.proctype and hide=ix1.hide and
      short_desc = ix1.short_desc;

      If od_need_update = 0 then

        update "&1".odc_def set (long_desc,procedure_level,hide,short_desc) = (select
        "DESC",proctype,hide,short_desc from tsm_stage.procdesc where isproc = 0  and 
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
       PROCEDURE,"DESC",0,proctype,hide,null,BuildTagId,1,short_desc from 
       tsm_stage.procdesc where isproc = 0  and procedure = ix2.procedure;

       parent_od_maxid:=od_maxid;
       od_maxid:=od_maxid+1;

       inserted_rows:=inserted_rows+1;

       If ix2.proctype = 'PatientOrSite' then

          Insert into "&1".odc_def select od_maxid,
          PROCEDURE,"DESC",0,'Patient',hide,null,BuildTagId,1,short_desc from 
          tsm_stage.procdesc where isproc = 0  and procedure = ix2.procedure;         

          Insert into "&1".odc_def_mapper(odc_def_id,parent_odc_def_id) 
	  values (od_maxid,parent_od_maxid);

          od_maxid:=od_maxid+1;
          inserted_rows:=inserted_rows+1;

          Insert into "&1".odc_def select od_maxid,
          PROCEDURE,"DESC",0,'Site',hide,null,BuildTagId,1,short_desc from 
          tsm_stage.procdesc where isproc = 0  and procedure = ix2.procedure;         

          Insert into "&1".odc_def_mapper(odc_def_id,parent_odc_def_id) 
	  values (od_maxid,parent_od_maxid);

          od_maxid:=od_maxid+1;
          inserted_rows:=inserted_rows+1;

       Elsif ix2.proctype = 'PatientOrVisit' then

          Insert into "&1".odc_def select od_maxid,
          PROCEDURE,"DESC",0,'Patient',hide,null,BuildTagId,1,short_desc from 
          tsm_stage.procdesc where isproc = 0  and procedure = ix2.procedure;         

          Insert into "&1".odc_def_mapper(odc_def_id,parent_odc_def_id) 
	  values (od_maxid,parent_od_maxid);

          od_maxid:=od_maxid+1;
          inserted_rows:=inserted_rows+1;

          Insert into "&1".odc_def select od_maxid,
          'V'||substr(PROCEDURE,2),"DESC",0,'Visit',hide,null,BuildTagId,0,short_desc from 
          tsm_stage.procdesc where isproc = 0  and procedure = ix2.procedure;         

          Insert into "&1".odc_def_mapper(odc_def_id,parent_odc_def_id) 
	  values (od_maxid,parent_od_maxid);

          od_maxid:=od_maxid+1;
          inserted_rows:=inserted_rows+1;

       End if;

    Else


      select count(*) into od_need_update from "&1".odc_def where
      picas_code = ix2.procedure and long_desc = ix2."DESC" and 
      procedure_level = ix2.proctype and hide=ix2.hide and
      short_desc = ix2.short_desc;

      If od_need_update = 0 then


         update "&1".odc_def set (long_desc,procedure_level,hide,short_desc) = (select
         "DESC",proctype,hide,short_desc from tsm_stage.procdesc where isproc = 0  and 
         procedure = ix2.procedure) where picas_code = ix2.procedure and 
         procedure_level=ix2.proctype ;

         updated_rows:=updated_rows+1;

         If ix2.proctype = 'PatientOrSite' then

            update "&1".odc_def set (long_desc,hide,short_desc) = (select
            "DESC",hide,short_desc from tsm_stage.procdesc where isproc = 0  and 
            procedure = ix2.procedure) where picas_code = ix2.procedure and 
            procedure_level in ('Patient','Site') ;

            updated_rows:=updated_rows+2;

         Elsif  ix2.proctype = 'PatientOrVisit' then

            update "&1".odc_def set (long_desc,hide,short_desc) = (select
            "DESC",hide,short_desc from tsm_stage.procdesc where isproc = 0  and 
            procedure = ix2.procedure) where picas_code = ix2.procedure and 
            procedure_level in ('Patient') ;


            update "&1".odc_def set (long_desc,hide,short_desc) = (select
            "DESC",hide,short_desc from tsm_stage.procdesc where isproc = 0  and 
            procedure = ix2.procedure) where picas_code = 'V'||substr(ix2.procedure,2) and 
            procedure_level in ('Visit') ;

            updated_rows:=updated_rows+2;

         End if;
       End if;
    End if;
   End loop;

-- update "&1".odc_def set (obsolete_flg,obsolete_build_tag_id) = (select 1,BuildTagId 
-- from dual) where picas_code not in (select procedure from tsm_stage.procdesc where isproc = 0)
-- and not picas_code like 'SL%';

-- The updated statement above has been commented above by Debashish on 07-10-2003
-- to import data into prod and not import the bug found and ***shouted*** by Renata Knichnicka  
-- on 07-03-2003. The update statement below is a temporary fix for the time being, but the 
-- procedure above need to be fixed as a permanent fix before the August 2003 import. 
-- Too scary to touch the procedure above now without going thro the QA process.

-- Its fixed on 07/25/2003 by Debashish


 update "&1".odc_def set  obsolete_flg = 1 
 where picas_code not in (select procedure from tsm_stage.procdesc where isproc = 0)
 and not picas_code like 'SL%' and  foxpro_flg = 1 and obsolete_flg <> 1 ;

 update "&1".odc_def set obsolete_build_tag_id = (select BuildTagId from dual) where
 obsolete_flg = 1 and obsolete_build_tag_id is null;

 Insert into "&1".data_load_history(table_name,num_inserted,num_updated) values 
 ('Odc_def',inserted_rows,updated_rows);

 commit;
end;
/
sho err

declare
 gottobezero exception;
 cnt  number(10);
begin
  select count(*) into cnt from "&1".odc_def where lower(procedure_level)='other' and
  hide=0 and obsolete_flg=0;
  If cnt > 0 then
    Raise gottobezero;
  end if;
exception
  when gottobezero then
     Raise_application_error(-20208,'STOP! STOP! Procedure level for ODC can not be Other while its not hidden and not obsolete!');
end;
/
sho err

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  17   DevTSM    1.16        2/27/2008 3:17:11 PM Debashish Mishra  
--  16   DevTSM    1.15        11/8/2007 10:21:13 PMDebashish Mishra  
--  15   DevTSM    1.14        2/7/2007 10:28:28 PM Debashish Mishra  
--  14   DevTSM    1.13        3/26/2006 10:38:29 AMDebashish Mishra  
--  13   DevTSM    1.12        3/3/2005 6:40:42 AM  Debashish Mishra  
--  12   DevTSM    1.11        6/15/2004 10:11:04 AMDebashish Mishra Added
--       short_des
--  11   DevTSM    1.10        7/30/2003 4:44:04 PM Debashish Mishra  
--  10   DevTSM    1.9         7/16/2003 4:48:54 PM Debashish Mishra  
--  9    DevTSM    1.8         7/9/2003 5:10:31 PM  Debashish Mishra  
--  8    DevTSM    1.7         5/29/2003 5:39:30 PM Debashish Mishra  
--  7    DevTSM    1.6         10/17/2002 4:08:50 PMDebashish Mishra bugs fixed
--  6    DevTSM    1.5         8/30/2002 12:43:11 PMDebashish Mishra Modified for
--       passing the schema name as an parameter
--  5    DevTSM    1.4         5/6/2002 8:03:52 AM  Debashish Mishra  
--  4    DevTSM    1.3         4/25/2002 2:31:51 PM Debashish Mishra  
--  3    DevTSM    1.2         4/22/2002 3:24:26 PM Debashish Mishra Modification
--       for add_study
--  2    DevTSM    1.1         4/3/2002 6:58:07 PM  Debashish Mishra  
--  1    DevTSM    1.0         3/20/2002 9:24:09 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
