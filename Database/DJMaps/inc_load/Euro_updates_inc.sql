--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: Euro_updates_inc.sql$ 
--
-- $Revision: 8$        $Date: 2/27/2008 3:17:05 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

--update "&1".study_level_service_inst a set a.service_cost = 
--(select a.service_cost/b.cnv_rate_to_euro from 
--"&1".local_to_euro b where b.country_id = a.payment_country_id)
--where a.payment_country_id in (select country_id from "&1".local_to_euro);

--commit;

create index "&1".index_1 on "&1".payments(payment_country_id);

update "&1".payments a set a.payment = 
(select a.payment/b.cnv_rate_to_euro from 
"&1".local_to_euro b where b.country_id = a.payment_country_id)
where a.payment_country_id in (select country_id from "&1".local_to_euro);

commit;
drop index "&1".index_1;


create index "&1".index_1 on "&1".investig(payment_country_id);

update "&1".investig a set (a.total_payment,a.other_fee) = 
(select a.total_payment/b.cnv_rate_to_euro,
a.other_fee/b.cnv_rate_to_euro  from 
"&1".local_to_euro b where b.country_id = a.payment_country_id)
where a.payment_country_id in (select country_id from "&1".local_to_euro);

commit;

update "&1".investig a set (a.overhead,a.irb_fee,a.fixed_fee,a.dropped_pat_fee,
a.failure_fee, a.grant_adjustment, a.lab_cost, a.grant_total) = 
(select a.overhead/b.cnv_rate_to_euro,
a.irb_fee/b.cnv_rate_to_euro,
a.fixed_fee/b.cnv_rate_to_euro,
a.dropped_pat_fee/b.cnv_rate_to_euro,
a.failure_fee/b.cnv_rate_to_euro,
a.grant_adjustment/b.cnv_rate_to_euro,
a.lab_cost/b.cnv_rate_to_euro,
a.grant_total/b.cnv_rate_to_euro  from 
"&1".local_to_euro b where b.country_id = a.payment_country_id)
where a.payment_country_id in (select country_id from "&1".local_to_euro);
 
commit;

update "&1".price_level a set (a.low_price, a.med_price, a.high_price) =
(select a.low_price/b.cnv_rate_to_euro,
a.med_price/b.cnv_rate_to_euro,
a.high_price/b.cnv_rate_to_euro from 
"&1".local_to_euro b where b.country_id = a.country_id)
where a.country_id in (select country_id from "&1".local_to_euro);

commit;

update "&1".add_study a set (a.PCT25,a.PCT50,a.PCT75) = 
(select a.PCT25/b.cnv_rate_to_euro,a.PCT50/b.cnv_rate_to_euro,
a.PCT75/b.cnv_rate_to_euro  from 
"&1".local_to_euro b where b.country_id = a.payment_country_id)
where a.payment_country_id in (select country_id from "&1".local_to_euro);

drop index "&1".index_1;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  8    DevTSM    1.7         2/27/2008 3:17:05 PM Debashish Mishra  
--  7    DevTSM    1.6         7/18/2007 11:04:51 PMDebashish Mishra  
--  6    DevTSM    1.5         2/7/2007 10:27:52 PM Debashish Mishra  
--  5    DevTSM    1.4         3/3/2005 6:40:16 AM  Debashish Mishra  
--  4    DevTSM    1.3         8/29/2003 5:13:07 PM Debashish Mishra  
--  3    DevTSM    1.2         8/30/2002 12:43:03 PMDebashish Mishra Modified for
--       passing the schema name as an parameter
--  2    DevTSM    1.1         4/22/2002 3:24:25 PM Debashish Mishra Modification
--       for add_study
--  1    DevTSM    1.0         3/20/2002 9:24:03 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
