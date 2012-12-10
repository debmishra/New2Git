--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ip_duration_inc.sql$ 
--
-- $Revision: 4$        $Date: 2/27/2008 3:19:42 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
declare

 ip_duration_maxid number(10);
 ip_duration_exist number(3);
 cursor c1 is select phase,indication  from tsm_stage.cppyear;
 indmapid number(10);
 indmap_exist number(3);
 invalid_indmap exception;

begin

 select nvl(max(id),0)+1 into ip_duration_maxid from "&1".ip_duration;

 for ix1 in c1 loop
  
   select count(*) into indmap_exist from "&1".indmap where code=ix1.indication;
   if indmap_exist = 0 then 
     raise invalid_indmap;
   end if;   

   select id into indmapid from "&1".indmap where code = ix1.indication;

   select count(*) into ip_duration_exist from "&1".ip_duration where
   phase_id = ix1.phase and indmap_id = indmapid;

   if ip_duration_exist = 0 then
   
     Insert into "&1".ip_duration select ip_duration_maxid, phase,
     indmapid,LOW1YEAR,MID1YEAR,HIGH1YEAR,LOW2YEAR,MID2YEAR,HIGH2YEAR,
     LOW3YEAR,MID3YEAR,HIGH3YEAR from tsm_stage.cppyear where
     INDICATION= ix1.indication and phase = ix1.phase;

     ip_duration_maxid:=ip_duration_maxid+1;

   else 

     update "&1".ip_duration set (LOW1YEAR,MID1YEAR,HIGH1YEAR,LOW2YEAR,
     MID2YEAR,HIGH2YEAR,LOW3YEAR,MID3YEAR,HIGH3YEAR) = (select LOW1YEAR,
     MID1YEAR,HIGH1YEAR,LOW2YEAR,MID2YEAR,HIGH2YEAR,LOW3YEAR,MID3YEAR,
     HIGH3YEAR from tsm_stage.cppyear where INDICATION= ix1.indication and 
     phase = ix1.phase) where indmap_id = indmapid and phase_id = ix1.phase;

   end if;
 end loop;
 commit;

exception
   when invalid_indmap then
	raise_application_error(-20205,'code exists in cppyear, but not in indmap');

end;
/
sho err

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  4    DevTSM    1.3         2/27/2008 3:19:42 PM Debashish Mishra  
--  3    DevTSM    1.2         3/3/2005 6:41:44 AM  Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:14:41 PM Debashish Mishra  
--  1    DevTSM    1.0         2/19/2003 1:51:02 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
