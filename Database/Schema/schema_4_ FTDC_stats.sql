--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_4_ FTDC_stats.sql$ 
--
-- $Revision: 7$        $Date: 2/22/2008 11:55:59 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
create table smssvr1_cpu_mem_stat(
	date_time date,
	data_duration number(5),
	cpu_idle_time number(3),
	scan_rate number(10,2))
	tablespace tsmlarge
	pctused 90 pctfree 5;

Alter table smssvr1_cpu_mem_stat add constraint smssvr1_cpu_mem_stat_pk
	primary key (date_time) using index tablespace tsmlarge_indx
	pctfree 5;

create table smssvr2_cpu_mem_stat(
	date_time date,
	data_duration number(5),
	cpu_idle_time number(3),
	scan_rate number(10,2))
	tablespace tsmlarge
	pctused 50 pctfree 5;

Alter table smssvr2_cpu_mem_stat add constraint smssvr2_cpu_mem_stat_pk
	primary key (date_time) using index tablespace tsmlarge_indx
	pctfree 5;

create table ftdc_daily_stat(
	date_time date,
	Total_prod_users number(5),
	FTS_prod_users number(5),
	Total_non_prod_users number(5),
	Total_non_prod_FTS_users number(5),
	Total_prod_trials number(5),
	FTS_prod_trials number(5),
	Total_non_prod_trials number(5),
	Total_non_prod_FTS_trials number(5),
	used_DB_diskspace_GB number(12,2),
	free_DB_diskspace_GB number(12,2))
	tablespace tsmsmall
	pctused 90 pctfree 5;

Alter table ftdc_daily_stat add constraint ftdc_daily_stat_pk
	primary key (date_time) using index tablespace tsmsmall_indx
	pctfree 5;

create table T1usage_stat(
	date_time date,
	in_kbits number(5),
	out_kbits number(5))
	tablespace tsmlarge
	pctused 90 pctfree 5;

Alter table T1usage_stat add constraint T1usage_stat_pk
	primary key (date_time) using index tablespace tsmlarge_indx
	pctfree 5;

create table FTDC_concurrent_user_stat(
	date_time date,
	concurrent_users number(5))
	tablespace tsmlarge
	pctused 90 pctfree 5; 

Alter table FTDC_concurrent_user_stat add constraint FTDC_concurrent_user_stat_pk
	primary key (date_time) using index tablespace tsmlarge_indx
	pctfree 5;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/22/2008 11:55:59 AMDebashish Mishra  
--  6    DevTSM    1.5         9/19/2006 12:11:20 AMDebashish Mishra   
--  5    DevTSM    1.4         3/2/2005 10:50:55 PM Debashish Mishra  
--  4    DevTSM    1.3         8/29/2003 5:17:40 PM Debashish Mishra  
--  3    DevTSM    1.2         5/21/2003 3:11:23 PM Debashish Mishra  
--  2    DevTSM    1.1         5/20/2003 1:35:27 PM Debashish Mishra  
--  1    DevTSM    1.0         5/20/2003 9:59:35 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
