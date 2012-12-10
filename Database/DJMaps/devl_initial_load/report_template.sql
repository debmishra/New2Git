--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: report_template.sql$ 
--
-- $Revision: 4$        $Date: 2/27/2008 3:16:44 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
create index odc_def_dl_indx1 on odc_def(PICAS_CODE);

create index report_template1_dl_indx1 on
report_template1(ODCDEFID);

update report_template1 a set
a.ODC_DEF_ID = (select b.id from odc_def b where
b.PICAS_CODE = a.ODCDEFID);
commit;

Drop index odc_def_dl_indx1;

Drop index report_template1_dl_indx1;

create index indmap_dl_indx1 on indmap(CODE);

create index report_template1_dl_indx1 on
report_template1(ther_area);

update report_template1 a set a.indmap_id =
(select b.id from indmap b where b.code = a.ther_area and
b.parent_indmap_id is not null)
where length(a.ther_area) > 1;

commit;

create index indmap_dl_indx2 on indmap(parent_indmap_id);

Create index report_template1_dl_indx2 on
report_template1(area);

update report_template1 a set a.indmap_id =
(select b.id from indmap b where b.code = upper(a.area) and
b.parent_indmap_id is null)
where length(a.ther_area) = 1;

commit;

Drop index indmap_dl_indx1;

Drop index report_template1_dl_indx1;

Drop index indmap_dl_indx2;

Drop index report_template1_dl_indx2;

Insert into report_template select id,ODC_DEF_ID,
INDMAP_ID,PHASE_ID from report_template1;

commit;
---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  4    DevTSM    1.3         2/27/2008 3:16:44 PM Debashish Mishra  
--  3    DevTSM    1.2         3/3/2005 6:39:20 AM  Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:12:05 PM Debashish Mishra  
--  1    DevTSM    1.0         1/15/2002 12:30:33 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
