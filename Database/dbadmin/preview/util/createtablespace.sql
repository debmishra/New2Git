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
-- $Revision: 6$        $Date: 2/27/2008 3:22:55 PM$
--
--
-- Description:  creates custom tablespaces in devl database
--
---------------------------------------------------------------------
 
create tablespace ftsmall datafile '/u03/oracle/database/prev/ftsmall01.dbf' size 40M reuse 
autoextend on next 20m maxsize 100M
extent management local uniform size 64k;

create tablespace ftlarge datafile '/u03/oracle/database/prev/ftlarge01.dbf' size 60M reuse
autoextend on next 50M maxsize 300M
extent management local uniform size 128k;

create tablespace ftsmall_indx datafile '/u02/oracle/database/prev/ftsmall_inx01.dbf' size 10M reuse 
autoextend on next 5m maxsize 30M
extent management local uniform size 64k;

create tablespace ftlarge_indx datafile '/u02/oracle/database/prev/ftlarge_indx01.dbf' size 30M reuse
autoextend on next 25M maxsize 100M
extent management local uniform size 64k;

create tablespace tsmsmall datafile '/u03/oracle/database/prev/tsmsmall01.dbf' size 80M reuse 
autoextend on next 20m maxsize 300M
extent management local uniform size 128k;

create tablespace tsmlarge datafile '/u03/oracle/database/prev/tsmlarge01.dbf' size 200M reuse
autoextend on next 50M maxsize 800M
extent management local uniform size 256k;

create tablespace tsmsmall_indx datafile '/u02/oracle/database/prev/tsmsmall_inx01.dbf' size 60M reuse 
autoextend on next 20m maxsize 300M
extent management local uniform size 64k;

create tablespace tsmlarge_indx datafile '/u02/oracle/database/prev/tsmlarge_indx01.dbf' size 150M reuse
autoextend on next 25M maxsize 600M
extent management local uniform size 128k;

Create tablespace trialblob datafile '/u02/oracle/database/prev/trialblob01.dbf' size 100M reuse 
autoextend on next 100m maxsize 800M
extent management local uniform size 256k;

Alter tablespace tsmlarge add datafile '/u03/oracle/database/prev/tsmlarge02.dbf' size 200M reuse
autoextend on next 100M maxsize 500M;

Alter tablespace tsmlarge_indx add datafile '/u02/oracle/database/prev/tsmlarge_indx02.dbf' size 200M reuse
autoextend on next 100M maxsize 500M;

Create tablespace tspdblob datafile '/u02/oracle/database/prev/tspdblob01.dbf' size 100M reuse 
autoextend on next 100m maxsize 800M
extent management local uniform size 128k;

Create tablespace tspdsmall datafile '/u02/oracle/database/prev/tspdsmall01.dbf' size 50M reuse 
autoextend on next 50m maxsize 200M
extent management local uniform size 64k;

Create tablespace tspdsmall_indx datafile '/u03/oracle/database/prev/tspdsmall_indx01.dbf' size 50M reuse 
autoextend on next 50m maxsize 500M
extent management local uniform size 64k;


Alter tablespace tsmlarge add datafile '/u03/oracle/database/prev/tsmlarge03.dbf' size 200M reuse
autoextend on next 100M maxsize 500M;

Alter tablespace tsmlarge_indx add datafile '/u02/oracle/database/prev/tsmlarge_indx03.dbf' size 200M reuse
autoextend on next 100M maxsize 500M;

create tablespace cropbt_data datafile '/u03/oracle/database/prev/cropbt01.dbf' size 200M reuse 
autoextend on next 50m maxsize 700M extent management local autoallocate segment space management auto;

create tablespace cropbt_indx datafile '/u02/oracle/database/prev/cropbt_indx01.dbf' size 100M reuse 
autoextend on next 50m maxsize 400M extent management local autoallocate segment space management auto;

create tablespace tsnsmall datafile
'/u03/oracle/database/prev/tsnsmall01.dbf' size 100m
autoextend on next 100m maxsize 1000m extent management local
segment space management auto;

create tablespace tsnsmall_indx datafile
'/u02/oracle/database/prev/tsnsmall_indx01.dbf' size 100m
autoextend on next 100m maxsize 1000m extent management local
segment space management auto;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         2/27/2008 3:22:55 PM Debashish Mishra  
--  5    DevTSM    1.4         1/9/2008 6:06:27 PM  Debashish Mishra  
--  4    DevTSM    1.3         3/1/2006 8:33:34 AM  Debashish Mishra  
--  3    DevTSM    1.2         3/3/2005 6:44:22 AM  Debashish Mishra  
--  2    DevTSM    1.1         2/28/2005 9:54:09 AM Debashish Mishra  
--  1    DevTSM    1.0         9/26/2003 4:07:12 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
