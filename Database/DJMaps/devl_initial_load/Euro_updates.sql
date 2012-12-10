--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: Euro_updates.sql$ 
--
-- $Revision: 5$        $Date: 2/27/2008 3:16:38 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

update study_level_service_inst a set a.service_cost = 
(select a.service_cost/b.cnv_rate_to_euro from 
local_to_euro b where b.country_id = a.payment_country_id)
where a.payment_country_id in (select country_id from local_to_euro);

commit;

create index index_1 on payments(payment_country_id);

update payments a set a.payment = 
(select a.payment/b.cnv_rate_to_euro from 
local_to_euro b where b.country_id = a.payment_country_id)
where a.payment_country_id in (select country_id from local_to_euro);

commit;
drop index index_1;


create index index_1 on investig(payment_country_id);

update investig a set (a.total_payment,a.other_fee) = 
(select a.total_payment/b.cnv_rate_to_euro,
a.other_fee/b.cnv_rate_to_euro  from 
local_to_euro b where b.country_id = a.payment_country_id)
where a.payment_country_id in (select country_id from local_to_euro);

commit;

update investig a set (a.overhead,a.irb_fee,a.fixed_fee,a.dropped_pat_fee,
a.failure_fee, a.grant_adjustment, a.lab_cost, a.grant_total) = 
(select a.overhead/b.cnv_rate_to_euro,
a.irb_fee/b.cnv_rate_to_euro,
a.fixed_fee/b.cnv_rate_to_euro,
a.dropped_pat_fee/b.cnv_rate_to_euro,
a.failure_fee/b.cnv_rate_to_euro,
a.grant_adjustment/b.cnv_rate_to_euro,
a.lab_cost/b.cnv_rate_to_euro,
a.grant_total/b.cnv_rate_to_euro  from 
local_to_euro b where b.country_id = a.payment_country_id)
where a.payment_country_id in (select country_id from local_to_euro);
 
commit;

update price_level a set (a.low_price, a.med_price, a.high_price) =
(select a.low_price/b.cnv_rate_to_euro,
a.med_price/b.cnv_rate_to_euro,
a.high_price/b.cnv_rate_to_euro from 
local_to_euro b where b.country_id = a.country_id)
where a.country_id in (select country_id from local_to_euro);

commit;



drop index index_1;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/27/2008 3:16:38 PM Debashish Mishra  
--  4    DevTSM    1.3         3/3/2005 6:38:47 AM  Debashish Mishra  
--  3    DevTSM    1.2         8/29/2003 5:11:34 PM Debashish Mishra  
--  2    DevTSM    1.1         3/14/2002 4:04:38 PM Debashish Mishra  
--  1    DevTSM    1.0         1/15/2002 12:30:30 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
