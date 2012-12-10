--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: modelled_standardize.sql$ 
--
-- $Revision: 6$        $Date: 2/27/2008 3:17:10 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
Alter table tsm_stage.modelled_standardize add (country_id number(10));


update tsm_stage.modelled_standardize set country = trim(country);

Delete from tsm_stage.modelled_standardize where lower(country) = 'xcntry';
update tsm_stage.modelled_standardize set country = 'AUS' where country  = 'AUS1' ;
update tsm_stage.modelled_standardize set country = 'UK' where country  = 'UK1' ;

update tsm_stage.modelled_standardize a set a.country_id = (select b.id from "&1".country b
where b.abbreviation = a.country);

commit;

drop sequence "&1".modelled_standardize_seq;
create sequence "&1".modelled_standardize_seq;

truncate table "&1".modelled_standardize;

Insert into "&1".modelled_standardize(ID,COUNTRY_ID,TYPE,PATIENT,DURATION)
select "&1".modelled_standardize_seq.nextval,COUNTRY_ID,TYPE,PATIENT,DURATION
from tsm_stage.modelled_standardize;

commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         2/27/2008 3:17:10 PM Debashish Mishra  
--  5    DevTSM    1.4         2/7/2007 10:28:24 PM Debashish Mishra  
--  4    DevTSM    1.3         3/3/2005 6:40:41 AM  Debashish Mishra  
--  3    DevTSM    1.2         8/29/2003 5:13:27 PM Debashish Mishra  
--  2    DevTSM    1.1         9/26/2002 4:09:54 PM Debashish Mishra replaced tsm10
--       with &1
--  1    DevTSM    1.0         9/25/2002 4:14:57 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
