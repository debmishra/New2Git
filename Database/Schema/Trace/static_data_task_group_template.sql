--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: static_data_task_group_template.sql$ 
--
-- $Revision: 5$        $Date: 2/27/2008 3:17:31 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
--select 'Insert into task_group_template (ID,NAME,SEQUENCE) values
--('||ID||','||decode(name,null,'null',
--''''||name||'''')||','||decode(SEQUENCE,null,'null',SEQUENCE)||');'
--from task_group_template;

Insert into task_group_template (ID,NAME,SEQUENCE) values
(1,'ProjAdmin',1);

Insert into task_group_template (ID,NAME,SEQUENCE) values
(2,'MedMngment',2);

Insert into task_group_template (ID,NAME,SEQUENCE) values
(3,'ProjMngment',3);

Insert into task_group_template (ID,NAME,SEQUENCE) values
(4,'ClinOps',4);

Insert into task_group_template (ID,NAME,SEQUENCE) values
(5,'DataMngment',5);

Insert into task_group_template (ID,NAME,SEQUENCE) values
(6,'Stats',6);

Insert into task_group_template (ID,NAME,SEQUENCE) values
(7,'MedWriting',7);

Insert into task_group_template (ID,NAME,SEQUENCE) values
(8,'RegAffairs',8);

Insert into task_group_template (ID,NAME,SEQUENCE) values
(9,'Safety',9);

Insert into task_group_template (ID,NAME,SEQUENCE) values
(10,'IT',10);




exit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/27/2008 3:17:31 PM Debashish Mishra  
--  4    DevTSM    1.3         3/3/2005 6:31:43 AM  Debashish Mishra  
--  3    DevTSM    1.2         4/26/2002 4:59:37 PM Debashish Mishra Modified for
--       the name changes
--  2    DevTSM    1.1         4/15/2002 3:26:20 PM Debashish Mishra  
--  1    DevTSM    1.0         3/12/2002 4:39:39 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
