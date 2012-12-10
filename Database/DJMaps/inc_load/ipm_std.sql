--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ipm_std.sql$ 
--
-- $Revision: 5$        $Date: 2/27/2008 3:17:09 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
update tsm_stage.ipm_std set geographical_location = trim(geographical_location);
update tsm_stage.ipm_std set country_group = trim(country_group);

delete from tsm_stage.ipm_std where country_group = 'xcntry';

update tsm_stage.ipm_std set geographical_location = 'CAN' 
where geographical_location = 'CANX' ;
update tsm_stage.ipm_std set geographical_location = 'USA' 
where geographical_location = 'USAX' ;
update tsm_stage.ipm_std set geographical_location = 'EEU' 
where geographical_location = 'EEUX' ;
update tsm_stage.ipm_std set geographical_location = 'WEU' 
where geographical_location = 'WEUX' ;

drop sequence tsm_stage.ipm_std_seq;
create sequence tsm_stage.ipm_std_seq;

truncate table "&1".ipm_std;

Insert into "&1".ipm_std select tsm_stage.ipm_std_seq.nextval,
GEOGRAPHICAL_LOCATION,COUNTRY_GROUP,PHASE,MEAN_CPP,MEAN_CPV,
STD_CPP,STD_CPV from tsm_stage.ipm_std;

commit;




---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/27/2008 3:17:09 PM Debashish Mishra  
--  4    DevTSM    1.3         2/7/2007 10:28:15 PM Debashish Mishra  
--  3    DevTSM    1.2         3/3/2005 6:40:36 AM  Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:13:22 PM Debashish Mishra  
--  1    DevTSM    1.0         3/14/2003 6:26:32 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
