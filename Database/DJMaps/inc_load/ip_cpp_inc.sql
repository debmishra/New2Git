--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ip_cpp_inc.sql$ 
--
-- $Revision: 7$        $Date: 2/27/2008 3:17:07 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

update tsm_stage.cpp set cintercept=ointercept where intercept is null and ointercept>0;
update tsm_stage.cpp set slope=oslope where  intercept is null and ointercept>0;
update tsm_stage.cpp set cslope=oslope where  intercept is null and ointercept>0;
update tsm_stage.cpp set low=olow where  intercept is null and ointercept>0;
update tsm_stage.cpp set clow=olow where  intercept is null and ointercept>0;
update tsm_stage.cpp set med=omed where  intercept is null and ointercept>0;
update tsm_stage.cpp set cmed=omed where  intercept is null and ointercept>0;
update tsm_stage.cpp set high=ohigh where  intercept is null and ointercept>0;
update tsm_stage.cpp set chigh=ohigh where  intercept is null and ointercept>0;
update tsm_stage.cpp set intercept=ointercept where  intercept is null and ointercept>0;
update tsm_stage.cpp set intercept=ointercept where cintercept is null and ointercept>0;
update tsm_stage.cpp set slope=oslope where  cintercept is null and ointercept>0;
update tsm_stage.cpp set cslope=oslope where cintercept is null and ointercept>0;
update tsm_stage.cpp set low=olow where  cintercept is null and ointercept>0;
update tsm_stage.cpp set clow=olow where  cintercept is null and ointercept>0;
update tsm_stage.cpp set med=omed where  cintercept is null and ointercept>0;
update tsm_stage.cpp set cmed=omed where  cintercept is null and ointercept>0;
update tsm_stage.cpp set high=ohigh where  cintercept is null and ointercept>0;
update tsm_stage.cpp set chigh=ohigh where  cintercept is null and ointercept>0;
update tsm_stage.cpp set cintercept=ointercept where  cintercept is null and ointercept>0;
update tsm_stage.cpp set slope=cslope where  intercept is null and ointercept is null and cintercept>0;
update tsm_stage.cpp set low=clow where  intercept is null and ointercept is null and cintercept>0;
update tsm_stage.cpp set med=cmed where  intercept is null and ointercept is null and cintercept>0;
update tsm_stage.cpp set high=chigh where  intercept is null and ointercept is null and cintercept>0;
update tsm_stage.cpp set intercept=cintercept where intercept is null and ointercept is null and cintercept>0;
update tsm_stage.cpp set cslope=slope where  cintercept is null and ointercept is null and intercept>0;
update tsm_stage.cpp set clow=low where  cintercept is null and ointercept is null and intercept>0;
update tsm_stage.cpp set cmed=med where  cintercept is null and ointercept is null and intercept>0;
update tsm_stage.cpp set chigh=high where  cintercept is null and ointercept is null and intercept>0;
update tsm_stage.cpp set cintercept=intercept where cintercept is null and ointercept is null and intercept>0;

commit;



declare

 ip_cpp_maxid number(10);
 ip_cpp_exist number(3);
 cursor c1 is select phase,indcode, status from tsm_stage.cpp;
 indmapid number(10);
 indmap_exist number(3);
 invalid_indmap exception;

begin

 select nvl(max(id),0)+1 into ip_cpp_maxid from "&1".ip_cpp;

 for ix1 in c1 loop
  
   select count(*) into indmap_exist from "&1".indmap where code=ix1.indcode
   and parent_indmap_id is not null;
   if indmap_exist = 0 then 
     raise invalid_indmap;
   end if;   

   select id into indmapid from "&1".indmap where code = ix1.indcode
   and parent_indmap_id is not null;

   select count(*) into ip_cpp_exist from "&1".ip_cpp where indmap_id = indmapid and
   phase_id = ix1.phase and patient_status = decode(ix1.status,
   'I','Inpatient','O','Outpatient');

   If ip_cpp_exist = 0 then 

     insert into "&1".ip_cpp select ip_cpp_maxid,phase,indmapid,LOW,
     MED,HIGH,SLOPE,INTERCEPT,CLOW,CMED,CHIGH,CSLOPE,CINTERCEPT,
     OLOW,OMED,OHIGH,OSLOPE,OINTERCEPT,cpv,
     decode(status,'I','Inpatient','O','Outpatient')
     from tsm_stage.cpp where indcode = ix1.indcode and phase=ix1.phase and
     status= ix1.status ;
    
     ip_cpp_maxid:=ip_cpp_maxid+1;

   else

     update "&1".ip_cpp set (LOW,MID,HIGH,SLOPE,INTERCEPT,CLOW,CMID,CHIGH,CSLOPE,
     CINTERCEPT,OLOW,OMID,OHIGH,OSLOPE,OINTERCEPT,cpv) = (select LOW,MED,HIGH,
     SLOPE,INTERCEPT,CLOW,CMED,CHIGH,CSLOPE,CINTERCEPT,OLOW,OMED,OHIGH,OSLOPE,
     OINTERCEPT,cpv from tsm_stage.cpp where indcode = ix1.indcode and phase=ix1.phase and
     status= ix1.status) where indmap_id = indmapid and phase_id = ix1.phase and
     patient_status=decode(ix1.status,'I','Inpatient','O','Outpatient');
   
   end if;

  end loop;
  commit;

exception
   when invalid_indmap then
	raise_application_error(-20204,'code exists in cpp, but not in indmap');

end;
/
sho err





---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/27/2008 3:17:07 PM Debashish Mishra  
--  6    DevTSM    1.5         2/7/2007 10:28:03 PM Debashish Mishra  
--  5    DevTSM    1.4         3/3/2005 6:40:26 AM  Debashish Mishra  
--  4    DevTSM    1.3         8/29/2003 5:13:14 PM Debashish Mishra  
--  3    DevTSM    1.2         8/30/2002 12:43:09 PMDebashish Mishra Modified for
--       passing the schema name as an parameter
--  2    DevTSM    1.1         4/17/2002 3:48:19 PM Debashish Mishra  
--  1    DevTSM    1.0         3/20/2002 9:24:08 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
