--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: study_level_service_master_inc.sql$ 
--
-- $Revision: 7$        $Date: 2/27/2008 3:17:16 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
Alter table tsm_stage.study_level_service_master1 add(
	odc_def_id number(10));


declare

 odcdef_maxid number(10);
 mapper_maxid number(10);
 cursor c1 is select rowid,picas_code from tsm_stage.STUDY_LEVEL_SERVICE_MASTER1;
 od_exist number(3);


begin

   select nvl(max(id),0)+1 into mapper_maxid from tsm10.mapper;
   select nvl(max(id),0)+1 into odcdef_maxid from tsm10.odc_def;   

 for ix1 in c1 loop

  select count(*) into od_exist from tsm10.odc_def where picas_code = ix1.picas_code;

  if od_exist = 0 then

    Insert into tsm10.odc_def (ID, PICAS_CODE, LONG_DESC, PROCEDURE_LEVEL) select
    odcdef_maxid,PICAS_CODE,LONG_DESC,'Study' from
    tsm_stage.STUDY_LEVEL_SERVICE_MASTER1 where rowid = ix1.rowid;

    Insert into tsm10.mapper values (mapper_maxid,odcdef_maxid,null);

    mapper_maxid:=mapper_maxid+1;
    odcdef_maxid:=odcdef_maxid+1;

  else

    update tsm10.odc_def set long_desc = (select long_desc from 
    tsm_stage.STUDY_LEVEL_SERVICE_MASTER1 where rowid = ix1.rowid)
    where picas_code = ix1.picas_code and procedure_level='Study';

  end if;

 end loop;
end;
/
sho err

commit;

update tsm_stage.study_level_service_master1 a set a.odc_def_id =
(select b.id from tsm10.odc_def b where b.picas_code = a.picas_code);

commit;

Insert into tsm10.study_level_service_master (id,long_desc,odc_def_id)
select id,long_desc,odc_def_id from
tsm_stage.study_level_service_master1;

commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/27/2008 3:17:16 PM Debashish Mishra  
--  6    DevTSM    1.5         2/7/2007 10:28:57 PM Debashish Mishra  
--  5    DevTSM    1.4         3/3/2005 6:41:12 AM  Debashish Mishra  
--  4    DevTSM    1.3         8/29/2003 5:13:52 PM Debashish Mishra  
--  3    DevTSM    1.2         4/3/2002 6:58:10 PM  Debashish Mishra  
--  2    DevTSM    1.1         3/22/2002 12:51:51 PMDebashish Mishra  
--  1    DevTSM    1.0         3/20/2002 9:24:25 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
