--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: baseft15_sequence.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:07 PM$
--
--
-- Description:  Create sequences.
--
---------------------------------------------------------------------


create sequence CRITERION_SEQ;
create sequence DISEASE_SEQ;
create sequence PROTOCOL_VERSION_SEQ;
create sequence SITE_SEQ;
create sequence STAGE_SEQ;
create sequence TRIAL_SEQ;
create sequence SITE_TO_TRIAL_SEQ;
create sequence HANDHELD_GROUP_SEQ;
create sequence HANDHELD_DEVICE_SEQ;
create sequence visit_task_to_visit_type_seq;
create sequence visit_type_to_arm_seq;
create sequence arm_to_protocol_version_seq;
create sequence visit_task_seq;
create sequence visit_type_seq;
create sequence arm_seq;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:07 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:37:50 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:26:48 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
