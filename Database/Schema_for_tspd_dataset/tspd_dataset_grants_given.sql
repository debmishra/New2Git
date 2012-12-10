--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tspd_dataset_grants_given.sql$ 
--
-- $Revision: 7$        $Date: 2/27/2008 3:18:01 PM$
--
--
-- Description:  Grants given by a tspd_dataset to tsm10
--
---------------------------------------------------------------------

Grant select,insert,update,delete on tspd_proc_freq to "&1";
Grant select,insert,update,delete on mapper to "&1";
Grant select,insert,update,delete on tspd_proc_pricing to "&1";
Grant select,insert,update,delete on tspd_trial_freq to "&1";
Grant select on tspd_proc_pricing_seq to "&1";

exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/27/2008 3:18:01 PM Debashish Mishra  
--  6    DevTSM    1.5         8/16/2006 1:45:37 PM Debashish Mishra Added a new
--       grant for sequence
--  5    DevTSM    1.4         3/3/2005 6:34:46 AM  Debashish Mishra  
--  4    DevTSM    1.3         7/10/2003 9:34:29 AM Debashish Mishra Added new
--       table tspd_trial_freq
--  3    DevTSM    1.2         7/2/2003 6:01:11 PM  Debashish Mishra Added new
--       table tspd_proc_pricing
--  2    DevTSM    1.1         6/30/2003 10:28:42 AMDebashish Mishra Added grants
--       for protocol,procedure_to_protocol,protocol_to_indmap and created
--       sysnonyms, created new mapper table modified procedure_def_id to mapper_id
--       in tspd_proc_freq table
--  1    DevTSM    1.0         6/13/2003 8:04:39 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
