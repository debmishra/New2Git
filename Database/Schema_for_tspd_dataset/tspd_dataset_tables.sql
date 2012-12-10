--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: c:\tsm\Database\Schema_for_tspd_dataset\tspd_dataset_tables.sql$ 
--
-- $Revision: 13$        $Date: 10/14/2010 10:44:12 AM$
--
--
-- Description:  Creates tables and primary keys for a tspd dataset
--
---------------------------------------------------------------------


drop table tspd_trial_freq;
drop table mapper;
drop table tspd_proc_freq;

Create table tspd_proc_freq(
	ID			NUMBER(10),
	PHASE_ID                NUMBER(10) NOT NULL,
	INDMAP_ID               NUMBER(10) NOT NULL,
	MAPPER_ID        	NUMBER(10) NOT NULL,
	PROC_CNT                NUMBER(10) NOT NULL,
	TRIAL_CNT               NUMBER(10) NOT NULL,
	YEARS_BACK              NUMBER(2) NOT NULL,
	USAGE_CNT               NUMBER(10) default 0 NOT NULL,
	USAGE_PROC              NUMBER(10) default 0 NOT NULL,
        MIN_USAGE_CNT           NUMBER(10) DEFAULT 0 NOT NULL,
        MAX_USAGE_CNT           NUMBER(10) DEFAULT 0 NOT NULL)
	tablespace tspdsmall 
	pctused 60 pctfree 25;

Alter table tspd_proc_freq add constraint tspd_proc_freq_pk
	primary key (id) using index tablespace 
	tspdsmall_indx pctfree 25;

Create table mapper(
	id number(10),
	odc_def_id number(10),
	Procedure_def_id number(10))
	tablespace tspdsmall 
	pctused 60 pctfree 25;

Alter table mapper add constraint mapper_pk
	primary key (id) using index tablespace 
	tspdsmall_indx pctfree 25;

Create table tspd_proc_pricing(
	id number(10),
	phase_id number(10),
	indmap_id number(10),
	mapper_id number(10),
	pct50 number(10),
	cnt	number(6),
	YEARS_BACK  NUMBER(2) NOT NULL)
	tablespace tspdsmall 
	pctused 60 pctfree 25;

Alter table tspd_proc_pricing add constraint tspd_proc_pricing_pk
	primary key (id) using index tablespace 
	tspdsmall_indx pctfree 25;


Create table tspd_trial_freq(
	id number(10),
	indmap_id number(10)  NOT NULL,
	phase_id number(10)  NOT NULL,
	trial_cnt number(10)  NOT NULL,
	total_cnt number(10)  NOT NULL,
	years_back number(2)  NOT NULL)
	tablespace tspdsmall 
	pctused 60 pctfree 25;

Alter table tspd_trial_freq add constraint tspd_trial_freq_pk
	primary key (id) using index tablespace 
	tspdsmall_indx pctfree 25;


exit;


--------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  13   DevTSM    1.12        10/14/2010 10:44:12 AMMahesh Pasupuleti Added two
--       columns to tspd_proc_freq table
--  12   DevTSM    1.11        2/27/2008 2:18:01 PM Debashish Mishra  
--  11   DevTSM    1.10        3/2/2006 11:55:12 AM Fiammetta Castaldi remove a
--       blank line that does not work from command line
--  10   DevTSM    1.9         2/16/2006 9:40:07 AM Fiammetta Castaldi added
--       USAGE_PROC to average usage count
--  9    DevTSM    1.8         2/1/2006 10:37:03 AM Debashish Mishra Added
--       tspd_proc_freq.usage_cnt
--  8    DevTSM    1.7         3/3/2005 5:34:48 AM  Debashish Mishra  
--  7    DevTSM    1.6         7/28/2003 1:46:45 PM Debashish Mishra changed the
--       column name from prot_cnt to trial_cnt
--  6    DevTSM    1.5         7/10/2003 1:05:10 PM Debashish Mishra modified
--       tspd_proc_pricing.pct50  and dropped tspd_proc_freq.freq 
--  5    DevTSM    1.4         7/10/2003 8:34:30 AM Debashish Mishra Added new
--       table tspd_trial_freq
--  4    DevTSM    1.3         7/3/2003 9:52:35 AM  Debashish Mishra Added
--       tspd_proc_pricing.years_back
--  3    DevTSM    1.2         7/2/2003 5:01:13 PM  Debashish Mishra Added new
--       table tspd_proc_pricing
--  2    DevTSM    1.1         6/30/2003 9:28:43 AM Debashish Mishra Added grants
--       for protocol,procedure_to_protocol,protocol_to_indmap and created
--       sysnonyms, created new mapper table modified procedure_def_id to mapper_id
--       in tspd_proc_freq table
--  1    DevTSM    1.0         6/13/2003 7:04:40 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
