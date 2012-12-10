--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_for_emulator_test.sql$ 
--
-- $Revision: 6$        $Date: 2/22/2008 11:56:00 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
Create table run (
	id  		number(10),
	run_date 	date,
	num_users 	number(5),
	rundir 		varchar2(128),
	comments 	varchar2(256),
	num_cpu 	number(1), 
	cpu_type 	number(4), 
	Memory 		number(5),
	network_type 	varchar2(20),
        build_id        varchar2(30))
        tablespace tsmsmall
        pctused 60 pctfree 25;

Alter table run add constraint run_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

create sequence run_seq;

Create table run_info (
	id  		number(10),
   	run_id 		number(10) not null,
   	user_name 	varchar2(128),
   	product 	varchar2(128),
   	action_type 	varchar2(128),
   	action_name 	varchar2(128),
   	duration   	number(10,6),
   	start_time  	date,
   	end_time   	date,
   	comments   	varchar2(256),
	client_div 	varchar2(10))
        tablespace tsmlarge
        pctused 90 pctfree 5;


Alter table run_info add constraint run_info_pk
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 5 nologging;

Alter table run_info add constraint run_fk1
	foreign key(run_id) references run(id);
			
create sequence run_info_seq;

create index run_info_indx1 on run_info(user_name,action_name)
	tablespace tsmlarge_indx pctfree 5 nologging;

create index run_info_indx2 on run_info(action_name)
	tablespace tsmlarge_indx pctfree 5 nologging;

create or replace trigger run_trg1 
before insert on run
for each row
begin
select run_seq.nextval into :new.id from dual;
end;
/

create or replace trigger run_info_trg1 
before insert on run_info
for each row
begin
select run_info_seq.nextval into :new.id from dual;
end;
/


Create table run_user (
	id  		number(10),
	run_id 		number(10) not null,
	user_name 	varchar2(128),
        user_pwd	varchar2(128),
	client_div	varchar2(10),
	product 	varchar2(128),
	scenario 	number(5), 
	run_duration 	number(8))
        tablespace tsmsmall
        pctused 60 pctfree 25;

Alter table run_user add constraint run_user_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table run_user add constraint run_user_fk1
	foreign key(run_id) references run(id);

create sequence run_user_seq;

create or replace trigger run_user_trg1 
before insert on run_user
for each row
begin
select run_user_seq.nextval into :new.id from dual;
:new.user_pwd:=null;
end;
/

create table cpu_data(
    date_time date,
    idle_cpu_1042 number(3),
    idle_cpu_1120 number(3),
    idle_cpu_1121 number(3))
    tablespace tsmsmall
    pctused 60 pctfree 25;

Alter table cpu_data add constraint cpu_data_pk
	primary key (date_time) using index tablespace 
	tsmsmall_indx pctfree 25;



---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         2/22/2008 11:56:00 AMDebashish Mishra  
--  5    DevTSM    1.4         9/19/2006 12:11:21 AMDebashish Mishra   
--  4    DevTSM    1.3         3/2/2005 10:50:55 PM Debashish Mishra  
--  3    DevTSM    1.2         7/9/2003 5:09:58 PM  Debashish Mishra  
--  2    DevTSM    1.1         3/3/2003 5:32:25 PM  Debashish Mishra Modified
--       build_id in run table from numeric to character
--  1    DevTSM    1.0         2/4/2003 6:03:34 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
