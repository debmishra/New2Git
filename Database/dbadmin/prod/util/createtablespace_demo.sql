create tablespace ftsmall datafile '/u03/oracle/oradata/demo/ftsmall01.dbf' size 100M reuse 
autoextend on next 50m maxsize 200M
extent management local autoallocate segment space management auto;

create tablespace ftlarge datafile '/u03/oracle/oradata/demo/ftlarge01.dbf' size 100M reuse
autoextend on next 50M maxsize 500M
extent management local autoallocate segment space management auto;

create tablespace ftsmall_indx datafile '/u02/oracle/oradata/demo/ftsmall_inx01.dbf' size 100M reuse 
autoextend on next 50m maxsize 200M
extent management local autoallocate segment space management auto;

create tablespace ftlarge_indx datafile '/u02/oracle/oradata/demo/ftlarge_indx01.dbf' size 100M reuse
autoextend on next 50M maxsize 200M
extent management local autoallocate segment space management auto;


create tablespace tsmsmall datafile '/u03/oracle/oradata/demo/tsmsmall01.dbf' size 200M reuse 
autoextend on next 200m maxsize 2000M
extent management local autoallocate segment space management auto;

create tablespace tsmlarge datafile '/u03/oracle/oradata/demo/tsmlarge01.dbf' size 400M reuse
autoextend on next 200M maxsize 3000M
extent management local autoallocate segment space management auto;

create tablespace tsmsmall_indx datafile '/u02/oracle/oradata/demo/tsmsmall_indx01.dbf' size 100M reuse 
autoextend on next 100m maxsize 1000M
extent management local autoallocate segment space management auto;

create tablespace tsmlarge_indx datafile '/u02/oracle/oradata/demo/tsmlarge_indx01.dbf' size 200M reuse
autoextend on next 200M maxsize 3000M
extent management local autoallocate segment space management auto;

Create tablespace trialblob datafile '/u03/oracle/oradata/demo/trialblob01.dbf' size 100M reuse 
autoextend on next 100m maxsize 800M
extent management local autoallocate segment space management auto;

Create tablespace tspdblob datafile '/u03/oracle/oradata/demo/tspdblob01.dbf' size 200M reuse 
autoextend on next 100m maxsize 2000M
extent management local autoallocate segment space management auto;

Create tablespace tspdsmall datafile '/u02/oracle/oradata/demo/tspdsmall01.dbf' size 100M reuse 
autoextend on next 100m maxsize 2000M
extent management local autoallocate segment space management auto;

Create tablespace tspdsmall_indx datafile '/u03/oracle/oradata/demo/tspdsmall_indx01.dbf' size 100M reuse 
autoextend on next 100m maxsize 2000M
extent management local autoallocate segment space management auto;

create tablespace cropbt_data datafile '/u03/oracle/oradata/demo/cropbt01.dbf' size 50M reuse 
autoextend on next 50m maxsize 500M 
extent management local autoallocate segment space management auto;

create tablespace cropbt_indx datafile '/u02/oracle/oradata/demo/cropbt_indx01.dbf' size 50M reuse 
autoextend on next 50m maxsize 500M 
extent management local autoallocate segment space management auto;
