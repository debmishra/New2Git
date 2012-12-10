--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: procedure_def_inc.sql$ 
--
-- $Revision: 5$        $Date: 2/27/2008 3:19:43 PM$
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
 pd_exist number(3);
 pd_maxid number(10);
 cursor c1 is select procedure,"DESC",proctype from tsm_stage.procdesc where isproc <> 0 and
 not proctype in ('PatientOrSite','PatientOrVisit');
 cursor c2 is select procedure,"DESC",proctype from tsm_stage.procdesc where isproc <> 0 and 
 proctype in ('PatientOrSite','PatientOrVisit');
 inserted_rows number(10):=0;
 updated_rows number(10):=0;
 pd_need_update number(3);

begin

 select nvl(max(id),0) into BuildTagId from "&1".build_tag;

 select nvl(max(id),0)+1 into pd_maxid from "&1".procedure_def;

 for ix1 in c1 loop

   select count(*) into pd_exist from "&1".procedure_def where
   cpt_code = ix1.procedure;

   If pd_exist = 0 then

       Insert into "&1".procedure_def select pd_maxid,
       PROCEDURE,"DESC",0,proctype,null,BuildTagId,hide from tsm_stage.procdesc where
       isproc <> 0  and procedure = ix1.procedure;

       pd_maxid:=pd_maxid+1;

       inserted_rows:=inserted_rows+1;
   Else

       select count(*) into pd_need_update from "&1".procedure_def where
       cpt_code = ix1.procedure and long_desc = ix1."DESC" and procedure_level = ix1.proctype;

       If pd_need_update = 0 then

         update "&1".procedure_def set (long_desc,procedure_level,hide) = (select
         "DESC",proctype,hide from tsm_stage.procdesc where isproc <> 0  and 
         procedure = ix1.procedure) where cpt_code = ix1.procedure;

         updated_rows:=updated_rows+1;

       End if;

   End if;
 End loop;

 for ix2 in c2 loop 

   select count(*) into pd_exist from "&1".procedure_def where
   cpt_code = ix2.procedure and procedure_level = ix2.proctype;
  
  If pd_exist = 0 then

       Insert into "&1".procedure_def select pd_maxid,
       PROCEDURE,"DESC",0,proctype,null,BuildTagId,hide from tsm_stage.procdesc where
       isproc <> 0  and procedure = ix2.procedure;

       pd_maxid:=pd_maxid+1;

       inserted_rows:=inserted_rows+1;

       If ix2.proctype = 'PatientOrSite' then

          Insert into "&1".procedure_def select pd_maxid,
          PROCEDURE,"DESC",0,'Patient',null,BuildTagId,hide from tsm_stage.procdesc where
          isproc <> 0  and procedure = ix2.procedure;       

          pd_maxid:=pd_maxid+1;
          inserted_rows:=inserted_rows+1;

          Insert into "&1".procedure_def select pd_maxid,
          PROCEDURE,"DESC",0,'Site',null,BuildTagId,hide from tsm_stage.procdesc where
          isproc <> 0  and procedure = ix2.procedure;          

          pd_maxid:=pd_maxid+1;
          inserted_rows:=inserted_rows+1;

       Elsif ix2.proctype = 'PatientOrVisit' then

          Insert into "&1".procedure_def select pd_maxid,
          PROCEDURE,"DESC",0,'Patient',null,BuildTagId,hide from tsm_stage.procdesc where
          isproc <> 0  and procedure = ix2.procedure;       

          pd_maxid:=pd_maxid+1;
          inserted_rows:=inserted_rows+1;

          Insert into "&1".procedure_def select pd_maxid,
          PROCEDURE,"DESC",0,'Visit',null,BuildTagId,hide from tsm_stage.procdesc where
          isproc <> 0  and procedure = ix2.procedure;          

          pd_maxid:=pd_maxid+1;
          inserted_rows:=inserted_rows+1;

       End if;

  Else

       select count(*) into pd_need_update from "&1".procedure_def where
       cpt_code = ix2.procedure and long_desc = ix2."DESC" and procedure_level = ix2.proctype;

       If pd_need_update = 0 then

         update "&1".procedure_def set (long_desc,hide) = (select
         "DESC",hide from tsm_stage.procdesc where isproc <> 0  and 
         procedure = ix2.procedure) where cpt_code = ix2.procedure and 
         procedure_level=ix2.proctype ;

         updated_rows:=updated_rows+1;

         If ix2.proctype = 'PatientOrSite' then

            update "&1".procedure_def set (long_desc,hide) = (select
            "DESC",hide from tsm_stage.procdesc where isproc <> 0  and 
            procedure = ix2.procedure) where cpt_code = ix2.procedure and 
            procedure_level in ('Patient','Site') ;

            updated_rows:=updated_rows+2;

         Elsif  ix2.proctype = 'PatientOrVisit' then


            update "&1".procedure_def set (long_desc,hide) = (select
            "DESC",hide from tsm_stage.procdesc where isproc <> 0  and 
            procedure = ix2.procedure) where cpt_code = ix2.procedure and 
            procedure_level in ('Patient','Visit') ;

            updated_rows:=updated_rows+2;

         End if;

       End if;
  End if;
 End loop;

 select count(*) into pd_exist from "&1".procedure_def where
 cpt_code = '70539';

   If pd_exist = 0 then

       Insert into "&1".procedure_def values (pd_maxid,
       '70539',null,1,sysdate,null,'Other',1);

       pd_maxid:=pd_maxid+1;
       inserted_rows:=inserted_rows+1;

   End if;

 select count(*) into pd_exist from "&1".procedure_def where
 cpt_code = '92025';

   If pd_exist = 0 then

       Insert into "&1".procedure_def values (pd_maxid,
       '92025',null,1,sysdate,null,'Other',1);

       pd_maxid:=pd_maxid+1;
       inserted_rows:=inserted_rows+1;

   End if;

 update "&1".procedure_def set (obsolete_flg,obsolete_build_tag_id) = (select 1,BuildTagId 
 from dual) where cpt_code not in (select procedure from tsm_stage.procdesc where isproc <> 0);

 Insert into "&1".data_load_history(table_name,num_inserted,num_updated) values 
 ('Procedure_def',inserted_rows,updated_rows);

 commit;
end;
/
sho err

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/27/2008 3:19:43 PM Debashish Mishra  
--  4    DevTSM    1.3         3/3/2005 6:41:50 AM  Debashish Mishra  
--  3    DevTSM    1.2         7/9/2003 5:10:40 PM  Debashish Mishra  
--  2    DevTSM    1.1         5/29/2003 5:40:08 PM Debashish Mishra Modified for
--       GM1.1
--  1    DevTSM    1.0         2/19/2003 1:51:07 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
