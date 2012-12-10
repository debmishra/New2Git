conn tsm10/kra8gpwl@prod 

drop table all_cons_columns;
drop table all_constraints;
drop table all_objects;

create table all_constraints as select OWNER,
CONSTRAINT_NAME,CONSTRAINT_TYPE,TABLE_NAME,R_OWNER,
R_CONSTRAINT_NAME,DELETE_RULE,STATUS,DEFERRABLE,
DEFERRED,VALIDATED,GENERATED,BAD,RELY,LAST_CHANGE,
INDEX_OWNER,INDEX_NAME,INVALID,VIEW_RELATED            
from all_constraints;

create table all_cons_columns as select * from all_cons_columns;
create table all_objects as select * from all_objects; 

create index all_constraints_indx1 on all_constraints(table_name, owner, constraint_name);
create index all_cons_columns_indx1 on all_cons_columns(table_name, owner, constraint_name);
create index all_objects_indx1 on all_objects(object_name);

grant select on tsm10.all_cons_columns to tsm10e, tsm10g;
grant select on tsm10.all_constraints to tsm10e, tsm10g;
grant select on tsm10.all_objects to tsm10e, tsm10g;

conn tsm10e/kra8gpwl@prod

drop synonym all_cons_columns;
drop synonym all_constraints;
drop synonym all_objects;

create synonym all_cons_columns for tsm10.all_cons_columns;
create synonym all_constraints for tsm10.all_constraints;
create synonym all_objects for tsm10.all_objects;

conn tsm10g/kra8gpwl@prod


drop synonym all_cons_columns;
drop synonym all_constraints;
drop synonym all_objects;

create synonym all_cons_columns for tsm10.all_cons_columns;
create synonym all_constraints for tsm10.all_constraints;
create synonym all_objects for tsm10.all_objects;

disc
cl buff
