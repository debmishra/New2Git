--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: version_45master_inc.sql$ 
--
-- $Revision: 4$        $Date: 2/27/2008 3:17:16 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
truncate table "&1".version_45master;
Insert into "&1".version_45master select * from tsm_stage.version_45master;
commit;

declare

 invalid_data exception;
 num_rows  number(10);

begin

  select count(*) into num_rows from "&1".version_45master;
  If num_rows = 0 then
    Raise invalid_data;
  end if;
  select count(*) into num_rows from "&1".version_45master where upper(substr(version,5,1))='Q';
   If num_rows <> 1 then
    Raise invalid_data;
  end if;  

exception

  when invalid_data then
     Raise_application_error(-20210,'Invalid data in version_45master table');


end;
/
sho err


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  4    DevTSM    1.3         2/27/2008 3:17:16 PM Debashish Mishra  
--  3    DevTSM    1.2         2/7/2007 10:28:58 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:41:12 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/18/2003 4:11:45 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
