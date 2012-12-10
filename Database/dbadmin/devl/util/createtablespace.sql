--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: createtablespace.sql$ 
--
-- $Revision: 14$        $Date: 2/27/2008 3:22:33 PM$
--
--
-- Description:  creates custom tablespaces in devl database
--
---------------------------------------------------------------------
 
create tablespace ftsmall datafile '/u03/oracle/oradata/devl/ftsmall01.dbf' size 100M reuse 
autoextend on next 20m maxsize 200M
extent management local autoallocate segment space management auto;

create tablespace ftlarge datafile '/u03/oracle/oradata/devl/ftlarge01.dbf' size 100M reuse
autoextend on next 20M maxsize 200M
extent management local autoallocate segment space management auto;

create tablespace ftsmall_indx datafile '/u02/oracle/oradata/devl/ftsmall_inx01.dbf' size 50M reuse 
autoextend on next 20m maxsize 150M
extent management local autoallocate segment space management auto;

create tablespace ftlarge_indx datafile '/u02/oracle/oradata/devl/ftlarge_indx01.dbf' size 30M reuse
autoextend on next 10M maxsize 100M
extent management local autoallocate segment space management auto;


create tablespace tsmsmall datafile '/u03/oracle/oradata/devl/tsmsmall01.dbf' size 400M reuse 
autoextend on next 50m maxsize 800M
extent management local autoallocate segment space management auto;

create tablespace tsmlarge datafile '/u03/oracle/oradata/devl/tsmlarge01.dbf' size 700M reuse
autoextend on next 100M maxsize 1500M
extent management local autoallocate segment space management auto;

create tablespace tsmsmall_indx datafile '/u02/oracle/oradata/devl/tsmsmall_indx01.dbf' size 50M reuse 
autoextend on next 50m maxsize 200M
extent management local autoallocate segment space management auto;

create tablespace tsmlarge_indx datafile '/u02/oracle/oradata/devl/tsmlarge_indx01.dbf' size 600M reuse
autoextend on next 100M maxsize 1500M
extent management local autoallocate segment space management auto;

Create tablespace trialblob datafile '/u03/oracle/oradata/devl/trialblob01.dbf' size 50M reuse 
autoextend on next 50m maxsize 400M
extent management local autoallocate segment space management auto;

Create tablespace users datafile '/u03/oracle/oradata/devl/users01.dbf' size 10M reuse 
autoextend on next 10m maxsize 100M
extent management local autoallocate segment space management auto;

Create tablespace tspdblob datafile '/u03/oracle/oradata/devl/tspdblob01.dbf' size 1500M reuse 
autoextend on next 100m maxsize 2000M
extent management local autoallocate segment space management auto;

alter table tspdblob add datafile '/u03/oracle/oradata/devl/tspdblob02.dbf' size 100m reuse
autoextend on next 100m maxsize 500M;

Create tablespace tspdsmall datafile '/u02/oracle/oradata/devl/tspdsmall01.dbf' size 50M reuse 
autoextend on next 50m maxsize 200M
extent management local autoallocate segment space management auto;

Create tablespace tspdsmall_indx datafile '/u03/oracle/oradata/devl/tspdsmall_indx01.dbf' size 50M reuse 
autoextend on next 50m maxsize 200M
extent management local autoallocate segment space management auto;

create tablespace cssmall datafile '/u03/oracle/oradata/devl/cssmall01.dbf' size 10M reuse 
autoextend on next 10m maxsize 50M
extent management local autoallocate segment space management auto;

create tablespace cssmall_indx datafile '/u02/oracle/oradata/devl/cssmall_indx01.dbf' size 10M reuse 
autoextend on next 10m maxsize 50M
extent management local autoallocate segment space management auto;

create tablespace tcsmall datafile '/u03/oracle/oradata/devl/tcsmall01.dbf' size 20m reuse
autoextend on next 10m maxsize 100m 
extent management local autoallocate segment space management auto;

create tablespace tcsmall_indx datafile '/u02/oracle/oradata/devl/tcsmall_indx01.dbf' size 10m reuse
autoextend on next 10m maxsize 100m 
extent management local autoallocate segment space management auto;

create tablespace cropbt_data datafile '/u03/oracle/oradata/devl/cropbt01.dbf' size 20M reuse 
autoextend on next 20m maxsize 200M 
extent management local autoallocate segment space management auto;

create tablespace cropbt_indx datafile '/u02/oracle/oradata/devl/cropbt_indx01.dbf' size 20M reuse 
autoextend on next 20m maxsize 100M 
extent management local autoallocate segment space management auto;

create tablespace tsnsmall datafile
'/u03/oracle/oradata/devl/tsnsmall01.dbf' size 100m
autoextend on next 100m maxsize 1000m extent management local
segment space management auto;

create tablespace tsnsmall_indx datafile
'/u02/oracle/oradata/devl/tsnsmall_indx01.dbf' size 100m
autoextend on next 100m maxsize 1000m extent management local
segment space management auto;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  14   DevTSM    1.13        2/27/2008 3:22:33 PM Debashish Mishra  
--  13   DevTSM    1.12        3/19/2006 11:46:36 PMDebashish Mishra  
--  12   DevTSM    1.11        1/11/2006 12:17:20 PMDebashish Mishra  
--  11   DevTSM    1.10        5/9/2005 1:03:00 AM  Debashish Mishra  
--  10   DevTSM    1.9         4/17/2005 9:35:22 AM Debashish Mishra  
--  9    DevTSM    1.8         3/3/2005 6:42:48 AM  Debashish Mishra  
--  8    DevTSM    1.7         11/25/2003 11:01:21 AMDebashish Mishra  
--  7    DevTSM    1.6         7/16/2003 4:49:21 PM Debashish Mishra  
--  6    DevTSM    1.5         7/2/2003 5:43:45 PM  Debashish Mishra  
--  5    DevTSM    1.4         4/18/2003 8:10:16 PM Debashish Mishra  
--  4    DevTSM    1.3         3/28/2003 5:11:43 PM Debashish Mishra  
--  3    DevTSM    1.2         3/28/2003 4:06:45 PM Debashish Mishra  
--  2    DevTSM    1.1         2/28/2003 3:51:00 PM Debashish Mishra  
--  1    DevTSM    1.0         9/26/2002 4:10:17 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
