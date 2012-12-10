--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ipm_cpp.sql$ 
--
-- $Revision: 5$        $Date: 2/27/2008 3:17:07 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
update tsm_stage.ipm_cpp set indcode = trim(indcode);

delete from tsm_stage.ipm_cpp where upper(indcode) = 'INDCODE';

drop sequence tsm_stage.ipm_cpp_seq;
create sequence tsm_stage.ipm_cpp_seq;

truncate table "&1".ipm_cpp;

Insert into "&1".ipm_cpp select tsm_stage.ipm_cpp_seq.nextval,a.phase,
b.id, a.low, a.med, a.high,a.clow, a.cmed, a.chigh,a.olow, a.omed, a.ohigh,
a.cpv,decode(a.status,'I','Inpatient','O','Outpatient') from tsm_stage.ipm_cpp a,
"&1".indmap b where b.code = a.indcode;

commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/27/2008 3:17:07 PM Debashish Mishra  
--  4    DevTSM    1.3         2/7/2007 10:28:07 PM Debashish Mishra  
--  3    DevTSM    1.2         3/3/2005 6:40:29 AM  Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:13:16 PM Debashish Mishra  
--  1    DevTSM    1.0         3/14/2003 6:00:21 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
