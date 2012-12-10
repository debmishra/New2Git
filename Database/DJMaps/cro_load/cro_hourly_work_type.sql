insert into tc10.cro_hourly_work_type (work_type,id) values ('Medical Writing',1);
insert into tc10.cro_hourly_work_type (work_type,id) values ('CRAs',2);
insert into tc10.cro_hourly_work_type (work_type,id) values ('Management',3);
insert into tc10.cro_hourly_work_type (work_type,id) values ('Adminstrative Support',4);
insert into tc10.cro_hourly_work_type (work_type,id) values ('Data Entry',5);
insert into tc10.cro_hourly_work_type (work_type,id) values ('Clinical Data Review',6);
insert into tc10.cro_hourly_work_type (work_type,id) values ('MDs',7);
insert into tc10.cro_hourly_work_type (work_type,id) values ('Programmers',8);
insert into tc10.cro_hourly_work_type (work_type,id) values ('Database Managers',9);
insert into tc10.cro_hourly_work_type (work_type,id) values ('Statisticians',10);
insert into tc10.cro_hourly_work_type (work_type,id) values ('Regulatory Affairs',11);
insert into tc10.cro_hourly_work_type (work_type,id) values ('QC/QA Personnel',12);
insert into tc10.cro_hourly_work_type (work_type,id) values ('Business Affairs',13);
--insert into tc10.cro_hourly_work_type (work_type,id) values ('Media Buyer',14);
--insert into tc10.cro_hourly_work_type (work_type,id) values ('Media Analyst',15);
commit;

create sequence tsm_stage.hourrate_seq start with 14;

declare

cursor c1 is select distinct class from tsm_stage.hourrate where 
not (class is null or class=-1 or class=14 or class=15);

begin

 for ix1 in c1 loop

    declare

       cursor c2 is select distinct descript from tsm_stage.hourrate where
       class=ix1.class and descript is not null;
    begin
       
       for ix2 in c2 loop

       insert into tc10.cro_hourly_work_type(id,work_type, parent_work_type_id)
       values (tsm_stage.hourrate_seq.nextval,ix2.descript,ix1.class);

    end loop;
    end;
end loop;
end;
/
drop sequence tsm_stage.hourrate_seq;

