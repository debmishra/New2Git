insert into local_to_euro select increment_sequence('local_to_euro_seq'),
id,239.64 from country where abbreviation='SLO';
commit;

alter table add_study modify (PCT25 NUMBER(10),
PCT50  NUMBER(10),PCT75  NUMBER(10));

select OWNER,CONSTRAINT_NAME from all_constraints
where R_OWNER='TSM10' and R_CONSTRAINT_NAME='MAPPER_PK' and
OWNER <> 'TSM10';

--alter table own_odc drop constraint OWN_ODC_FK3;

--alter table own_odc add constraint OWN_ODC_FK3
--foreign key (mapper_id) references mapper(id);

--alter table own_procedure drop constraint OWN_procedure_FK3;

--alter table own_procedure add constraint OWN_procedure_FK3
--foreign key (mapper_id) references mapper(id);

--alter table TSM10_34.TEMP_OVERHEAD disable constraint TEMP_OVERHEAD_FK6;
--alter table TSM10_34.TEMP_ODC disable constraint TEMP_ODC_FK8;

update country set currency_id=(select id from currency 
where upper(NAME)='EURO') where abbreviation='SLO';

update odc_def set procedure_level='Site' where picas_code='#1124';
commit;

