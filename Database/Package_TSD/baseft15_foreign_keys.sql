--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: baseft15_foreign_keys.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:07 PM$
--
--
-- Description:  Add foreign keys.
--
---------------------------------------------------------------------
 
alter table CRITERION
add constraint PROTOCOL_VERSION_FK  
foreign key(PROTOCOL_VERSION_ID)
references PROTOCOL_VERSION(ID);

alter table PROTOCOL_VERSION_TO_STAGE
add constraint PROTOCOL_VERSION_FK2 
foreign key(PROTOCOL_VERSION_ID)
references PROTOCOL_VERSION(ID);

alter table PROTOCOL_VERSION_TO_STAGE
add constraint STAGE_FK 
foreign key(STAGE_ID)
references STAGE(ID);

alter table PROTOCOL_VERSION
add constraint trial_fk 
foreign key(trial_id)
references TRIAL(ID);

alter table Trial    
add constraint DISEASE_FK2 
foreign key(DISEASE_ID)
references DISEASE(ID);

alter table Site_to_Trial    
add constraint protocol_version_fk3 
foreign key(Protocol_version_ID)
references Protocol_Version(ID);

alter table Site_to_Trial    
add constraint Site_fk 
foreign key(site_ID)
references Site(ID);

alter table Site_to_Trial    
add constraint Trial_fk2 
foreign key(trial_ID)
references Trial(ID);

alter table HandHeld_Group
add constraint Site_fk3
foreign key(site_ID)
references Site(ID);

alter table HandHeld_Device
add constraint HandHeld_Group_FK
foreign key(HandHeld_group_ID)
references HandHeld_Group(ID);

alter table HandHeld_Group_to_Disease
add constraint HandHeld_Group_FK2
foreign key(HandHeld_group_ID)
references HandHeld_Group(ID);

alter table HandHeld_Group_to_Disease
add constraint Disease_FK3
foreign key(disease_ID)
references Disease(ID);

alter table Disease_to_Stage
add constraint Disease_FK4
foreign key(disease_ID)
references Disease(ID);

alter table Disease_to_Stage
add constraint Stage_FK2
foreign key(stage_id)
references Stage(ID);

alter table Arm
add constraint Arm_FK1
foreign key (Trial_ID)
references Trial(ID);

alter table visit_type
add constraint visit_type_FK1
foreign key (Trial_ID)
references Trial(ID);

alter table visit_task
add constraint visit_task_FK1
foreign key (Trial_ID)
references Trial(ID);

alter table visit_task_to_visit_type
add constraint visit_task_to_visit_type_FK1
foreign key (visit_task_id)
references visit_task(ID);

alter table visit_task_to_visit_type
add constraint visit_task_to_visit_type_FK2
foreign key (visit_type_id)
references visit_type(ID);

alter table visit_type_to_arm
add constraint visit_type_to_arm_FK1
foreign key (visit_type_id)
references visit_type(ID);

alter table visit_type_to_arm
add constraint visit_type_to_arm_FK2
foreign key (arm_id)
references arm(ID);

alter table arm_to_protocol_version
add constraint arm_to_protocol_version_FK1
foreign key (protocol_version_id)
references protocol_version(ID);

alter table arm_to_protocol_version
add constraint arm_to_protocol_version_FK2
foreign key (arm_id)
references arm(ID);




---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:07 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:37:48 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:26:47 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
