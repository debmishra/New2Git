--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tsm10_indexes.sql$ 
--
-- $Revision: 12$        $Date: 2/22/2008 11:56:05 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

drop index payments_indx1; 
drop index investig_indx1;
drop index investig_indx2;
drop index protocol_to_indmap_indx1;
drop index mapper_indx1;
drop index mapper_indx2;
drop index TEMP_IP_STUDY_PRICE_indx1;
drop index TEMP_ODC_indx1;
drop index TEMP_OVERHEAD_indx1;
drop index TEMP_PROCEDURE_indx1;
drop index TEMP_PROCEDURE_indx2;
drop index price_level_indx1;

create index payments_indx1 on 
	payments(investig_id)
	tablespace tsmlarge_indx pctfree 25;

create index investig_indx1 on 
	investig(protocol_id,build_code_id,investigator_code)
	tablespace tsmlarge_indx pctfree 25;

create index investig_indx2 on 
	investig(grant_date)
	tablespace tsmlarge_indx pctfree 25;

create index protocol_to_indmap_indx1 on 
	protocol_to_indmap(protocol_id)
	tablespace tsmlarge_indx pctfree 25;

create index mapper_indx1 on 
	mapper(odc_def_id)
	tablespace tsmsmall_indx pctfree 25;

create index mapper_indx2 on 
	mapper(procedure_def_id)
	tablespace tsmsmall_indx pctfree 25;

create index TEMP_IP_STUDY_PRICE_indx1 on 
	TEMP_IP_STUDY_PRICE(country_id)
	tablespace tsmlarge_indx pctfree 25;

create index TEMP_ODC_indx1 on 
	TEMP_ODC(country_id)
	tablespace tsmlarge_indx pctfree 25;

create index TEMP_OVERHEAD_indx1 on 
	TEMP_OVERHEAD(country_id)
	tablespace tsmlarge_indx pctfree 25;

create index TEMP_PROCEDURE_indx1 on 
	TEMP_PROCEDURE(country_id)
	tablespace tsmlarge_indx pctfree 25;

create index TEMP_PROCEDURE_indx2 on 
	TEMP_PROCEDURE(mapper_id)
	tablespace tsmlarge_indx pctfree 25;

create index price_level_indx1 on
	price_level(country_id) 
	tablespace tsmsmall_indx pctfree 25;

create index procedure_protocol_indx1 on 
	procedure_to_protocol (protocol_id,build_code_id)
	tablespace tsmlarge_indx pctfree 25;

create index Indmap_index1 on 
	indmap(parent_indmap_id)
	tablespace tsmsmall_indx pctfree 20; 

create index price_level_indx2 on
	price_level(procedure_def_id)
	tablespace tsmlarge_indx pctfree 20; 

create index tspd_document_history_indx1 on 
	tspd_document_history(TSPD_DOCUMENT_ID)
	tablespace tspdsmall_indx pctfree 20;


exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  12   DevTSM    1.11        2/22/2008 11:56:05 AMDebashish Mishra  
--  11   DevTSM    1.10        9/19/2006 12:11:43 AMDebashish Mishra   
--  10   DevTSM    1.9         3/2/2005 10:51:14 PM Debashish Mishra  
--  9    DevTSM    1.8         11/16/2004 12:38:43 AMDebashish Mishra  
--  8    DevTSM    1.7         8/29/2003 5:17:49 PM Debashish Mishra  
--  7    DevTSM    1.6         3/22/2002 12:52:15 PMDebashish Mishra  
--  6    DevTSM    1.5         3/14/2002 12:14:20 PMDebashish Mishra  
--  5    DevTSM    1.4         3/8/2002 10:53:36 AM Debashish Mishra  
--  4    DevTSM    1.3         3/6/2002 7:02:52 PM  Debashish Mishra  
--  3    DevTSM    1.2         2/18/2002 5:06:45 PM Debashish Mishra  
--  2    DevTSM    1.1         12/19/2001 10:50:35 AMDebashish Mishra  
--  1    DevTSM    1.0         12/13/2001 10:48:53 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
