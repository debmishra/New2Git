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
-- $Revision: 22$        $Date: 4/9/2009 2:28:54 PM$
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
 cursor c1 is select procedure,"DESC",proctype,short_desc,hide from tsm_stage.procdesc where isproc <> 0 and
 not proctype in ('PatientOrSite','PatientOrVisit');
 cursor c2 is select procedure,"DESC",proctype,short_desc,hide from tsm_stage.procdesc where isproc <> 0 and 
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
       PROCEDURE,"DESC",0,proctype,null,BuildTagId,hide,1,short_desc,null,null from tsm_stage.procdesc where
       isproc <> 0  and procedure = ix1.procedure;

       pd_maxid:=pd_maxid+1;

       inserted_rows:=inserted_rows+1;
   Else

       select count(*) into pd_need_update from "&1".procedure_def where
       cpt_code = ix1.procedure and long_desc = ix1."DESC" and procedure_level = ix1.proctype and
       short_desc=ix1.short_desc and hide=ix1.hide;

       If pd_need_update = 0 then

         update "&1".procedure_def set (long_desc,procedure_level,hide,short_desc) = (select
         "DESC",proctype,hide,short_desc from tsm_stage.procdesc where isproc <> 0  and 
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
       PROCEDURE,"DESC",0,proctype,null,BuildTagId,hide,1,short_desc,null,null from tsm_stage.procdesc where
       isproc <> 0  and procedure = ix2.procedure;

       pd_maxid:=pd_maxid+1;

       inserted_rows:=inserted_rows+1;

       If ix2.proctype = 'PatientOrSite' then

          Insert into "&1".procedure_def select pd_maxid,
          PROCEDURE,"DESC",0,'Patient',null,BuildTagId,hide,1,short_desc,null,null from tsm_stage.procdesc where
          isproc <> 0  and procedure = ix2.procedure;       

          pd_maxid:=pd_maxid+1;
          inserted_rows:=inserted_rows+1;

          Insert into "&1".procedure_def select pd_maxid,
          PROCEDURE,"DESC",0,'Site',null,BuildTagId,hide,1,short_desc,null,null from tsm_stage.procdesc where
          isproc <> 0  and procedure = ix2.procedure;          

          pd_maxid:=pd_maxid+1;
          inserted_rows:=inserted_rows+1;

       Elsif ix2.proctype = 'PatientOrVisit' then

          Insert into "&1".procedure_def select pd_maxid,
          PROCEDURE,"DESC",0,'Patient',null,BuildTagId,hide,1,short_desc,null,null from tsm_stage.procdesc where
          isproc <> 0  and procedure = ix2.procedure;       

          pd_maxid:=pd_maxid+1;
          inserted_rows:=inserted_rows+1;

          Insert into "&1".procedure_def select pd_maxid,
          PROCEDURE,"DESC",0,'Visit',null,BuildTagId,hide,1,short_desc,null,null from tsm_stage.procdesc where
          isproc <> 0  and procedure = ix2.procedure;          

          pd_maxid:=pd_maxid+1;
          inserted_rows:=inserted_rows+1;

       End if;

  Else

       select count(*) into pd_need_update from "&1".procedure_def where
       cpt_code = ix2.procedure and long_desc = ix2."DESC" and procedure_level = ix2.proctype and
       short_desc=ix2.short_desc;

       If pd_need_update = 0 then

         update "&1".procedure_def set (long_desc,hide,short_desc) = (select
         "DESC",hide,short_desc from tsm_stage.procdesc where isproc <> 0  and 
         procedure = ix2.procedure) where cpt_code = ix2.procedure and 
         procedure_level=ix2.proctype and hide=ix2.hide;

         updated_rows:=updated_rows+1;

         If ix2.proctype = 'PatientOrSite' then

            update "&1".procedure_def set (long_desc,hide,short_desc) = (select
            "DESC",hide,short_desc from tsm_stage.procdesc where isproc <> 0  and 
            procedure = ix2.procedure) where cpt_code = ix2.procedure and 
            procedure_level in ('Patient','Site') ;

            updated_rows:=updated_rows+2;

         Elsif  ix2.proctype = 'PatientOrVisit' then


            update "&1".procedure_def set (long_desc,hide,short_desc) = (select
            "DESC",hide,short_desc from tsm_stage.procdesc where isproc <> 0  and 
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
       '70539',null,1,sysdate,null,'Other',1,0,null,null,null);

       pd_maxid:=pd_maxid+1;
       inserted_rows:=inserted_rows+1;

   End if;

 select count(*) into pd_exist from "&1".procedure_def where
 cpt_code = '92025';

   If pd_exist = 0 then

       Insert into "&1".procedure_def values (pd_maxid,
       '92025',null,1,sysdate,null,'Other',1,0,null,null,null);

       pd_maxid:=pd_maxid+1;
       inserted_rows:=inserted_rows+1;

   End if;

 update "&1".procedure_def set obsolete_flg = 1
 where cpt_code not in (select procedure from tsm_stage.procdesc where isproc <> 0)
 and foxpro_flg=1 and obsolete_flg <> 1 and hide <>1;

 update "&1".procedure_def set obsolete_build_tag_id = (select BuildTagId from dual) where
 obsolete_flg = 1 and obsolete_build_tag_id is null and hide <>1;

 Insert into "&1".data_load_history(table_name,num_inserted,num_updated) values 
 ('Procedure_def',inserted_rows,updated_rows);

 commit;
end;
/
sho err

update "&1".procedure_def set obsolete_flg=0 where hide=1;
commit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  22   DevTSM    1.21        4/9/2009 2:28:54 PM  Mahesh Pasupuleti Include
--       changes for complexity values.
--  21   DevTSM    1.20        2/27/2008 3:17:12 PM Debashish Mishra  
--  20   DevTSM    1.19        11/8/2007 10:21:14 PMDebashish Mishra  
--  19   DevTSM    1.18        2/15/2007 4:47:14 PM Debashish Mishra  
--  18   DevTSM    1.17        2/7/2007 10:28:39 PM Debashish Mishra  
--  17   DevTSM    1.16        4/28/2006 6:22:08 AM Debashish Mishra  
--  16   DevTSM    1.15        3/26/2006 10:38:30 AMDebashish Mishra  
--  15   DevTSM    1.14        11/4/2005 9:46:31 AM Debashish Mishra  
--  14   DevTSM    1.13        3/3/2005 6:40:53 AM  Debashish Mishra  
--  13   DevTSM    1.12        2/28/2005 9:55:37 AM Debashish Mishra  
--  12   DevTSM    1.11        8/31/2004 9:44:35 AM Debashish Mishra  
--  11   DevTSM    1.10        6/15/2004 10:11:04 AMDebashish Mishra Added
--       short_des
--  10   DevTSM    1.9         7/30/2003 4:44:04 PM Debashish Mishra  
--  9    DevTSM    1.8         7/16/2003 4:48:54 PM Debashish Mishra  
--  8    DevTSM    1.7         7/9/2003 5:10:32 PM  Debashish Mishra  
--  7    DevTSM    1.6         5/29/2003 5:39:31 PM Debashish Mishra  
--  6    DevTSM    1.5         10/17/2002 4:08:51 PMDebashish Mishra bugs fixed
--  5    DevTSM    1.4         8/30/2002 12:43:14 PMDebashish Mishra Modified for
--       passing the schema name as an parameter
--  4    DevTSM    1.3         5/6/2002 8:03:53 AM  Debashish Mishra  
--  3    DevTSM    1.2         4/25/2002 2:31:53 PM Debashish Mishra  
--  2    DevTSM    1.1         4/3/2002 6:58:09 PM  Debashish Mishra  
--  1    DevTSM    1.0         3/20/2002 9:24:11 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
