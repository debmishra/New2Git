--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tspd_dataset_foreign_keys.sql$ 
--
-- $Revision: 8$        $Date: 2/27/2008 3:18:01 PM$
--
--
-- Description:  Foreign Key relations for a tsm client
--
---------------------------------------------------------------------
 

Alter table tspd_proc_freq add constraint tspd_proc_freq_fk1
	foreign key (PHASE_ID) references 
	"&1".PHASE(id);

Alter table tspd_proc_freq add constraint tspd_proc_freq_fk2
	foreign key (INDMAP_ID) references 
	"&1".INDMAP(id);

Alter table tspd_proc_freq add constraint tspd_proc_freq_fk3
	foreign key (MAPPER_ID) references 
	MAPPER(id);

Alter table mapper add constraint mapper_fk1
	foreign key (odc_def_id) references 
	"&1".odc_def(id);

Alter table mapper add constraint mapper_fk2
	foreign key (Procedure_def_id) references 
	"&1".Procedure_def(id);

Alter table tspd_proc_pricing add constraint tspd_proc_pricing_fk1
	foreign key (PHASE_ID) references 
	"&1".PHASE(id);

Alter table tspd_proc_pricing add constraint tspd_proc_pricing_fk2
	foreign key (INDMAP_ID) references 
	"&1".INDMAP(id);

Alter table tspd_proc_pricing add constraint tspd_proc_pricing_fk3
	foreign key (MAPPER_ID) references 
	MAPPER(id);

Alter table tspd_trial_freq add constraint tspd_trial_freq_fk1
	foreign key (PHASE_ID) references 
	"&1".PHASE(id);

Alter table tspd_trial_freq add constraint tspd_trial_freq_fk2
	foreign key (INDMAP_ID) references 
	"&1".INDMAP(id);





exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  8    DevTSM    1.7         2/27/2008 3:18:01 PM Debashish Mishra  
--  7    DevTSM    1.6         3/3/2005 6:34:46 AM  Debashish Mishra  
--  6    DevTSM    1.5         7/28/2003 2:56:45 PM Debashish Mishra Corrected a
--       typo
--  5    DevTSM    1.4         7/10/2003 9:34:28 AM Debashish Mishra Added new
--       table tspd_trial_freq
--  4    DevTSM    1.3         7/2/2003 6:01:11 PM  Debashish Mishra Added new
--       table tspd_proc_pricing
--  3    DevTSM    1.2         6/30/2003 10:28:42 AMDebashish Mishra Added grants
--       for protocol,procedure_to_protocol,protocol_to_indmap and created
--       sysnonyms, created new mapper table modified procedure_def_id to mapper_id
--       in tspd_proc_freq table
--  2    DevTSM    1.1         6/13/2003 10:01:45 AMDebashish Mishra Initial
--       creation
--  1    DevTSM    1.0         6/13/2003 8:04:38 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
