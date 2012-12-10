create tablespace ftsmall datafile '/u03/oracle/database/test/ftsmall01.dbf' size 100M reuse 
autoextend on next 20m maxsize 200M
extent management local uniform size 64k;

create tablespace ftlarge datafile '/u03/oracle/database/test/ftlarge01.dbf' size 200M reuse
autoextend on next 100M maxsize 1024M
extent management local uniform size 256k;

create tablespace ftsmall_indx datafile '/u02/oracle/database/test/ftsmall_inx01.dbf' size 50M reuse 
autoextend on next 25m maxsize 200M
extent management local uniform size 64k;

create tablespace ftlarge_indx datafile '/u02/oracle/database/test/ftlarge_indx01.dbf' size 100M reuse
autoextend on next 50M maxsize 600M
extent management local uniform size 128k;


create tablespace tsmsmall datafile '/u03/oracle/database/test/tsmsmall01.dbf' size 100M reuse 
autoextend on next 20m maxsize 300M
extent management local uniform size 128k;

create tablespace tsmlarge datafile '/u03/oracle/database/test/tsmlarge01.dbf' size 400M reuse
autoextend on next 100M maxsize 800M
extent management local uniform size 512k;

create tablespace tsmsmall_indx datafile '/u02/oracle/database/test/tsmsmall_inx01.dbf' size 100M reuse 
autoextend on next 20m maxsize 300M
extent management local uniform size 64k;

create tablespace tsmlarge_indx datafile '/u02/oracle/database/test/tsmlarge_indx01.dbf' size 300M reuse
autoextend on next 100M maxsize 600M
extent management local uniform size 128k;

Create tablespace trialblob datafile '/u02/oracle/database/test/trialblob01.dbf' size 100M reuse 
autoextend on next 100m maxsize 800M
extent management local uniform size 256k;

Create tablespace tspdblob datafile '/u02/oracle/database/test/tspdblob01.dbf' size 100M reuse 
autoextend on next 100m maxsize 800M
extent management local uniform size 128k;

Create tablespace tspdsmall datafile '/u02/oracle/database/test/tspdsmall01.dbf' size 50M reuse 
autoextend on next 50m maxsize 200M
extent management local uniform size 64k;

Create tablespace tspdsmall_indx datafile '/u03/oracle/database/test/tspdsmall01.dbf' size 50M reuse 
autoextend on next 50m maxsize 500M
extent management local uniform size 64k;

Alter tablespace tsmlarge add datafile '/u03/oracle/database/test/tsmlarge02.dbf' 
size 100M reuse autoextend on next 100M maxsize 500M;

Alter tablespace tsmlarge_indx add datafile '/u02/oracle/database/test/tsmlarge_indx02.dbf' 
size 100M reuse autoextend on next 100M maxsize 500M;

create tablespace tcsmall datafile '/u02/oracle/database/test/tcsmall01.dbf' 
size 100m autoextend on next 50m maxsize 300m extent management local
autoallocate segment space management auto;

create tablespace tcsmall_indx datafile '/u03/oracle/database/test/tcsmall_indx01.dbf'
size 50m autoextend on next 50m maxsize 300m extent management local
autoallocate segment space management auto;


create tablespace cropbt_data datafile '/u03/oracle/database/test/cropbt01.dbf' size 200M reuse 
autoextend on next 50m maxsize 700M extent management local autoallocate segment space management auto;

create tablespace cropbt_indx datafile '/u02/oracle/database/test/cropbt_indx01.dbf' size 100M reuse 
autoextend on next 50m maxsize 400M extent management local autoallocate segment space management auto;

create tablespace cssmall datafile '/u03/oracle/database/test/cssmall01.dbf' size 40M reuse 
autoextend on next 20m maxsize 200M extent management local autoallocate segment space management auto;

create tablespace cssmall_indx datafile '/u02/oracle/database/test/cssmall_indx01.dbf' size 20M reuse 
autoextend on next 20m maxsize 100M extent management local 
autoallocate segment space management auto;

create tablespace GM_build_data datafile '/u03/oracle/database/test/GM_build_data01.dbf' size 100M reuse 
autoextend on next 100m maxsize 600M extent management local 
uniform size 256k;

create tablespace GM_build_indx datafile '/u02/oracle/database/test/GM_build_indx01.dbf' size 100M reuse 
autoextend on next 100m maxsize 600M extent management local 
uniform size 128k;

create tablespace tsnsmall datafile
'/u03/oracle/database/test/tsnsmall01.dbf' size 100m
autoextend on next 100m maxsize 1000m extent management local
segment space management auto;

create tablespace tsnsmall_indx datafile
'/u02/oracle/database/test/tsnsmall_indx01.dbf' size 100m
autoextend on next 100m maxsize 1000m extent management local
segment space management auto;
