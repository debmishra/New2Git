--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: study_level_service_master.sql$ 
--
-- $Revision: 7$        $Date: 2/27/2008 3:16:47 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
Alter table study_level_service_master1 add(
	odc_def_id number(10));


declare

 odcdef_maxid number(10);
 mapper_maxid number(10);
 cursor c1 is select rowid from STUDY_LEVEL_SERVICE_MASTER1;

begin

   select max(id)+1 into mapper_maxid from mapper;

  for ix1 in c1 loop

    select odc_def_seq.nextval into odcdef_maxid from dual;

    Insert into odc_def (ID, PICAS_CODE, LONG_DESC, PROCEDURE_LEVEL) select
    odcdef_maxid,PICAS_CODE,LONG_DESC,'Study' from
    STUDY_LEVEL_SERVICE_MASTER1 where rowid = ix1.rowid;

    Insert into mapper values (mapper_maxid,odcdef_maxid,null);

    mapper_maxid:=mapper_maxid+1;

  end loop;
end;
/
sho err

commit;

update study_level_service_master1 a set a.odc_def_id =
(select b.id from odc_def b where b.picas_code = a.picas_code);

commit;

Insert into study_level_service_master (id,long_desc,odc_def_id)
select id,long_desc,odc_def_id from
study_level_service_master1;

commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/27/2008 3:16:47 PM Debashish Mishra  
--  6    DevTSM    1.5         3/3/2005 6:39:38 AM  Debashish Mishra  
--  5    DevTSM    1.4         8/29/2003 5:12:21 PM Debashish Mishra  
--  4    DevTSM    1.3         2/18/2002 5:07:15 PM Debashish Mishra  
--  3    DevTSM    1.2         2/12/2002 12:19:59 PMDebashish Mishra  
--  2    DevTSM    1.1         1/23/2002 12:53:55 PMDebashish Mishra After changing
--       the input source to foxpro
--  1    DevTSM    1.0         1/15/2002 12:30:34 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
