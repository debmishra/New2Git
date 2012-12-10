--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ft15_schema_changes_for_trace.sql$ 
--
-- $Revision: 4$        $Date: 2/27/2008 3:17:30 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
Alter table ftuser add(active_tsm_user number(1) default 0 not null);

Alter table ftuser add constraint ftuser_active_tsm_user_check
	check (active_tsm_user in (0,1));


Alter table trial add (
	nickname varchar2(40), 
	drug_code_id number(10),
	drug_class_id number(10),
	trace_archived number(1) default 0 not null,
	trace_archived_date date,
	trace_locked_by_id number(10),
	trace_author_id number(10),
	trace_create_date date,
	trace_audit_history_id number(10));


Alter table trial add constraint trial_fk8 
	foreign key(drug_code_id) references tsm10.drug_code(id);

Alter table trial add constraint trial_fk9 
	foreign key(drug_class_id) references tsm10.drug_class(id);
			
Alter table trial add constraint trial_fk10 
	foreign key(trace_locked_by_id) references ftuser(id);

Alter table trial add constraint trial_fk11 
	foreign key(trace_author_id) references ftuser(id);

Alter table trial add constraint trial_fk12 
	foreign key(trace_audit_history_id) references tsm10.trace_audit_history(id);



---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  4    DevTSM    1.3         2/27/2008 3:17:30 PM Debashish Mishra  
--  3    DevTSM    1.2         3/3/2005 6:31:39 AM  Debashish Mishra  
--  2    DevTSM    1.1         4/15/2002 3:26:18 PM Debashish Mishra  
--  1    DevTSM    1.0         4/9/2002 1:59:13 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
