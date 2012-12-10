--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tspd_dataset_sequences.sql$ 
--
-- $Revision: 6$        $Date: 2/27/2008 3:18:01 PM$
--
--
-- Description:  Drops and creates sequences for a tsm10 client
--
---------------------------------------------------------------------

drop sequence tspd_proc_freq_seq;
drop sequence tspd_proc_pricing_seq;
drop sequence tspd_trial_freq_seq;

create sequence tspd_proc_freq_seq;
create sequence tspd_proc_pricing_seq;
create sequence tspd_trial_freq_seq;

exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         2/27/2008 3:18:01 PM Debashish Mishra  
--  5    DevTSM    1.4         3/3/2005 6:34:47 AM  Debashish Mishra  
--  4    DevTSM    1.3         7/10/2003 9:34:30 AM Debashish Mishra Added new
--       table tspd_trial_freq
--  3    DevTSM    1.2         7/2/2003 6:01:12 PM  Debashish Mishra Added new
--       table tspd_proc_pricing
--  2    DevTSM    1.1         6/13/2003 10:01:46 AMDebashish Mishra Initial
--       creation
--  1    DevTSM    1.0         6/13/2003 8:04:40 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
