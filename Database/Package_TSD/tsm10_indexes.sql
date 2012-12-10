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
-- $Revision: 3$        $Date: 2/27/2008 3:19:10 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

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
--  3    DevTSM    1.2         2/27/2008 3:19:10 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:38:08 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:27:03 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
