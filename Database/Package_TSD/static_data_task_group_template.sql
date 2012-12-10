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
-- $Revision: 3$        $Date: 2/27/2008 3:19:09 PM$
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
--  3    DevTSM    1.2         2/27/2008 3:19:09 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:38:01 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:26:57 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
