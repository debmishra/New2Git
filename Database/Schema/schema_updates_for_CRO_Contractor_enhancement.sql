--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_for_CRO_Contractor_enhancement.sql$ 
--
-- $Revision: 4$        $Date: 10/3/2008 12:31:09 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 


alter table CRO_PLAN_ESTIMATE add( 
Wiz_page_num  	Number(2),
Archive_flg 	Number(1) default 0 NOT NULL,  
Create_date	Date,
Comments 	Varchar2(4000),
Project_id 	Number(10),  
Total_cal_hours	Number(10,2));

alter table CRO_PLAN_ESTIMATE add constraint CRO_PLAN_ESTIMATE_FK11 
foreign key (project_id) references project(id);

alter table CRO_TASK_GROUP_INST add( 
selected_flg	Number(1) default 1 NOT NULL); 


--***************************************************
--Deployed in tsm10e@test upto this on 08/13/2008 at 12 noon
--Deployed in tsm10e@prev upto this on 08/20/2008 at 10:40 am
--Deployed in tsm10t@prev upto this on 08/20/2008 at 10:40 am
--Deployed in tsm10@prod  upto this on 09/14/2008
--Deployed in tsm10@demo  upto this on 09/14/2008
--Deployed in tsm10@q002  upto this on 10/03/2008
--*****************************************************


--------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  4    DevTSM    1.3         10/3/2008 12:31:09 PMMahesh Pasupuleti Modify the
--       script file.
--  3    DevTSM    1.2         8/21/2008 3:02:44 PM Mahesh Pasupuleti Add columns
--       and constraints to CRO_PLAN_ESTIMATE table.
--  2    DevTSM    1.1         8/13/2008 12:04:33 PMDebashish Mishra Moved tags for
--       SQA deployment
--  1    DevTSM    1.0         6/27/2008 6:39:27 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
