--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: migrate2GM1dot3.sql$ 
--
-- $Revision: 13$        $Date: 2/27/2008 3:17:43 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
update trial_budget set num_entered_patients=num_patients where
trial_id in (select id from trial where client_div_id=&1);

update trial_budget set num_enrolled_patients= 
decode(screen_failure_pct,null,num_entered_patients,
round(num_entered_patients*(1-(screen_failure_pct/100)))) where
trial_id in (select id from trial where client_div_id=&1);

Update picas_visit set trial_phase='Discontinuation' where
trial_phase='Other' and trial_budget_id in (select a.id from 
trial_budget a, trial b where a.trial_id=b.id and 
b.client_div_id=&1);

update ftuser_to_client_group set dflt_group=1 where id in (
select min(id) from ftuser_to_client_group group by ftuser_id)
and ftuser_id in (select id from ftuser where client_div_id=&1);

commit;

declare

 cursor c1 is select id,location_set_id from ip_session where
 client_div_id=&1;

begin

  delete from ip_session_detail where ip_session_id in (
  select a.id from ip_session a, location_set_item b, location_set c
  where a.location_set_id=c.id and
  b.location_set_id=c.id and a.client_div_id=&1) ;

 for ix1 in c1 loop

  insert into ip_session_detail(id,ip_session_id,country_id) select
  increment_sequence('ip_session_detail_seq'),ix1.id,country_id from
  location_set_item where location_set_id=ix1.location_set_id;

 end loop;
 commit;
end;
/
sho err



---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  13   DevTSM    1.12        2/27/2008 3:17:43 PM Debashish Mishra  
--  12   DevTSM    1.11        9/19/2006 12:08:01 AMDebashish Mishra  removed
--       references to obsolete tables
--  11   DevTSM    1.10        3/3/2005 6:33:26 AM  Debashish Mishra   
--  10   DevTSM    1.9         3/3/2005 6:32:17 AM  Debashish Mishra  
--  9    DevTSM    1.8         8/20/2004 12:58:52 PMDebashish Mishra Modified the
--       script to delete rows from ip_session_detail table before inserting new
--       rows into it.
--  8    DevTSM    1.7         8/20/2004 10:39:35 AMDebashish Mishra moved the
--       script to this new location
--  7    DevTSM    1.6         7/19/2004 1:20:47 PM Debashish Mishra  
--  6    DevTSM    1.5         7/16/2004 12:48:26 PMDebashish Mishra modified
--       formula for percentage
--  5    DevTSM    1.4         7/16/2004 10:28:37 AMDebashish Mishra Modified the
--       script to calculate trial_budget.num_enrolled_patient
--  4    DevTSM    1.3         6/1/2004 9:59:44 AM  Debashish Mishra Added the
--       script to migrate a ip_session into ip_session_detail
--  3    DevTSM    1.2         2/20/2004 4:54:26 PM Debashish Mishra  
--  2    DevTSM    1.1         2/12/2004 10:41:35 AMDebashish Mishra  
--  1    DevTSM    1.0         2/2/2004 10:53:33 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
