Create table tspd_locked_object (
CLIENT_DIV_ID	NUMBER(10),
KEY_ID		VARCHAR2(256),
FTUSER_ID	NUMBER(10) not null,
LOCKED		NUMBER(1) Default 1 not null)
tablespace tspdsmall;

Alter table tspd_locked_object add constraint tspd_locked_object_pk 
	primary key (CLIENT_DIV_ID,KEY_ID)  using index tablespace 
        tspdsmall_indx;

Alter table tspd_locked_object
  add constraint tspd_locked_object_fk1 foreign key (client_div_id) 
  references client_div (id);

Alter table tspd_locked_object
  add constraint tspd_locked_object_fk2 foreign key (ftuser_id) 
  references ftuser (id);

Alter table tspd_locked_object
  add constraint tspd_locked_object_chk check(
  locked in (0,1));