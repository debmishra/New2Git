--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_for_2004Q2_import.sql$ 
--
-- $Revision: 5$        $Date: 2/22/2008 11:56:01 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

Alter table local_to_euro modify (cnv_rate_to_euro number(14,6));

update local_to_euro set cnv_rate_to_euro =13.7603 where 
country_id=(select id from country where abbreviation='ARI');

update local_to_euro set cnv_rate_to_euro =40.3399 where 
country_id=(select id from country where abbreviation='BEL');

update local_to_euro set cnv_rate_to_euro =5.94573 where 
country_id=(select id from country where abbreviation='FIN');

update local_to_euro set cnv_rate_to_euro =6.55957 where 
country_id=(select id from country where abbreviation='FRA');

update local_to_euro set cnv_rate_to_euro =1.95583 where 
country_id=(select id from country where abbreviation='DEU');

update local_to_euro set cnv_rate_to_euro =.787564 where 
country_id=(select id from country where abbreviation='IRL');

update local_to_euro set cnv_rate_to_euro =1936.27 where 
country_id=(select id from country where abbreviation='ITA');

update local_to_euro set cnv_rate_to_euro =2.20371 where 
country_id=(select id from country where abbreviation='NET');

update local_to_euro set cnv_rate_to_euro =166.386 where 
country_id=(select id from country where abbreviation='ESP');

insert into local_to_euro select increment_sequence('local_to_euro_seq'),
id,340.75 from country where abbreviation='GCE';

insert into local_to_euro select increment_sequence('local_to_euro_seq'),
id,200.482 from country where abbreviation='POR';

insert into local_to_euro select increment_sequence('local_to_euro_seq'),
id,40.3399 from country where abbreviation='LUX';

commit;




---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/22/2008 11:56:01 AMDebashish Mishra  
--  4    DevTSM    1.3         9/19/2006 12:11:30 AMDebashish Mishra   
--  3    DevTSM    1.2         3/2/2005 10:51:04 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2004 11:00:32 AM Debashish Mishra  
--  1    DevTSM    1.0         2/25/2004 2:46:53 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
