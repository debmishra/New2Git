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
-- $Revision: 14$        $Date: 9/3/2008 11:58:45 AM$
--
--
-- Description:  create custom tablespaces in production database
--
---------------------------------------------------------------------
 
create tablespace ftsmall datafile '/r03/oracle/oradata/prod/ftsmall01.dbf' size 100M reuse 
autoextend on next 50m maxsize 300M
extent management local uniform size 128k;

create tablespace ftlarge datafile '/r03/oracle/oradata/prod/ftlarge01.dbf' size 300M reuse
autoextend on next 50M maxsize 500M
extent management local uniform size 512k;

create tablespace ftsmall_indx datafile '/r02/oracle/oradata/prod/ftsmall_inx01.dbf' size 80M reuse 
autoextend on next 40m maxsize 200M
extent management local uniform size 64k;

create tablespace ftlarge_indx datafile '/r02/oracle/oradata/prod/ftlarge_indx01.dbf' size 100M reuse
autoextend on next 50M maxsize 200M
extent management local uniform size 128k;


create tablespace tsmsmall datafile '/r03/oracle/oradata/prod/tsmsmall01.dbf' size 200M reuse 
autoextend on next 50m maxsize 300M
extent management local uniform size 128k;

create tablespace tsmlarge datafile '/r03/oracle/oradata/prod/tsmlarge01.dbf' size 400M reuse
autoextend on next 100M maxsize 800M
extent management local uniform size 512k;

create tablespace tsmsmall_indx datafile '/r02/oracle/oradata/prod/tsmsmall_inx01.dbf' size 100M reuse 
autoextend on next 50m maxsize 300M
extent management local uniform size 64k;

create tablespace tsmlarge_indx datafile '/r02/oracle/oradata/prod/tsmlarge_indx01.dbf' size 300M reuse
autoextend on next 100M maxsize 600M
extent management local uniform size 128k;


Create tablespace trialblob datafile '/r02/oracle/oradata/prod/trialblob01.dbf' size 100M reuse 
autoextend on next 100m maxsize 800M
extent management local uniform size 256k;


Alter tablespace tsmlarge add datafile '/r03/oracle/oradata/prod/tsmlarge02.dbf' size 400M reuse
autoextend on next 100M maxsize 800M;

Alter tablespace tsmlarge_indx add datafile '/r02/oracle/oradata/prod/tsmlarge_indx02.dbf' size 400M reuse
autoextend on next 100M maxsize 800M;




Create tablespace tspdblob datafile '/r02/oracle/oradata/prod/tspdblob01.dbf' size 100M reuse 
autoextend on next 100m maxsize 800M
extent management local uniform size 128k;

Create tablespace tspdsmall datafile '/r02/oracle/oradata/prod/tspdsmall01.dbf' size 100M reuse 
autoextend on next 50m maxsize 500M
extent management local uniform size 64k;

Create tablespace tspdsmall_indx datafile '/r03/oracle/oradata/prod/tspdsmall_indx01.dbf' size 100M reuse 
autoextend on next 50m maxsize 500M
extent management local uniform size 64k;

Alter tablespace tsmlarge add datafile '/r03/oracle/oradata/prod/tsmlarge03.dbf' size 100M reuse
autoextend on next 100M maxsize 200M;

Alter tablespace tsmlarge_indx add datafile '/r02/oracle/oradata/prod/tsmlarge_indx03.dbf' size 100M reuse
autoextend on next 100M maxsize 200M;

Alter tablespace tsmlarge add datafile '/r03/oracle/oradata/prod/tsmlarge04.dbf' size 100M reuse
autoextend on next 100M maxsize 200M;

Alter tablespace tsmlarge add datafile '/r03/oracle/oradata/prod/tsmlarge05.dbf' size 100M reuse
autoextend on next 100M maxsize 2000M;

Alter tablespace tsmlarge_indx add datafile '/r02/oracle/oradata/prod/tsmlarge_indx04.dbf' size 100M reuse
autoextend on next 100M maxsize 2000M;

Alter tablespace tsmlarge_indx add datafile '/r02/oracle/oradata/prod/tsmlarge_indx05.dbf' size 100M reuse
autoextend on next 100M maxsize 2000M;


create tablespace perfstat datafile '/r03/oracle/oradata/prod/perfstat01.dbf' size 80M reuse
autoextend on next 20M maxsize 200M
extent management local uniform size 64k;

create tablespace cssmall datafile '/r03/oracle/oradata/prd2/cssmall01.dbf' size 50M reuse 
autoextend on next 50m maxsize 500M
extent management local uniform size 32k;


create tablespace cssmall_indx datafile '/r02/oracle/oradata/prd2/cssmall_indx01.dbf' size 20M reuse 
autoextend on next 20m maxsize 200M
extent management local uniform size 32k;

Alter tablespace tsmlarge add datafile '/r03/oracle/oradata/prod/tsmlarge06.dbf' size 100M reuse
autoextend on next 100M maxsize 200M;

Alter tablespace tsmlarge_indx add datafile '/r02/oracle/oradata/prod/tsmlarge_indx06.dbf' size 100M reuse
autoextend on next 100M maxsize 200M;

create tablespace GM_TRAIN_BUILD_DATA01 datafile '/r02/oracle/oradata/prod/gm_train_build_data01_01.dbf' size 600M reuse 
extent management local autoallocate segment space management auto;
Alter tablespace GM_TRAIN_BUILD_DATA01 add datafile '/r02/oracle/oradata/prod/gm_train_build_data01_02.dbf' size 600M reuse;
Alter tablespace GM_TRAIN_BUILD_DATA01 add datafile '/r02/oracle/oradata/prod/gm_train_build_data01_03.dbf' size 600M reuse;
Alter tablespace GM_TRAIN_BUILD_DATA01 add datafile '/r02/oracle/oradata/prod/gm_train_build_data01_04.dbf' size 600M reuse;

create tablespace GM_TRAIN_BUILD_INDX01 datafile '/r03/oracle/oradata/prod/gm_train_build_indx01_01.dbf' size 600M reuse 
extent management local autoallocate segment space management auto;
Alter tablespace GM_TRAIN_BUILD_INDX01 add datafile '/r03/oracle/oradata/prod/gm_train_build_indx01_02.dbf' size 600M reuse;
Alter tablespace GM_TRAIN_BUILD_INDX01 add datafile '/r03/oracle/oradata/prod/gm_train_build_indx01_03.dbf' size 600M reuse;
Alter tablespace GM_TRAIN_BUILD_INDX01 add datafile '/r03/oracle/oradata/prod/gm_train_build_indx01_04.dbf' size 600M reuse;

create tablespace tsnsmall datafile
'/r03/oracle/oradata/prod/tsnsmall01.dbf' size 100m
autoextend on next 100m maxsize 1000m extent management local
segment space management auto;

create tablespace tsnsmall_indx datafile
'/r02/oracle/oradata/prod/tsnsmall_indx01.dbf' size 100m
autoextend on next 100m maxsize 1000m extent management local
segment space management auto;




---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  14   DevTSM    1.13        9/3/2008 11:58:45 AM Debashish Mishra  
--  13   DevTSM    1.12        2/27/2008 3:21:50 PM Debashish Mishra  
--  12   DevTSM    1.11        11/16/2005 2:05:39 PMDebashish Mishra  
--  11   DevTSM    1.10        9/12/2005 11:25:27 AMDebashish Mishra  
--  10   DevTSM    1.9         4/17/2005 9:35:02 AM Debashish Mishra  
--  9    DevTSM    1.8         3/3/2005 6:44:51 AM  Debashish Mishra  
--  8    DevTSM    1.7         2/28/2005 9:54:24 AM Debashish Mishra  
--  7    DevTSM    1.6         10/13/2004 8:01:21 AMDebashish Mishra  
--  6    DevTSM    1.5         9/12/2004 3:19:45 AM Debashish Mishra  
--  5    DevTSM    1.4         8/4/2004 2:39:19 PM  Debashish Mishra  
--  4    DevTSM    1.3         12/26/2003 4:21:34 PMDebashish Mishra  
--  3    DevTSM    1.2         12/18/2003 6:18:39 PMDebashish Mishra  
--  2    DevTSM    1.1         7/30/2003 4:43:30 PM Debashish Mishra  
--  1    DevTSM    1.0         7/2/2003 5:44:13 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
