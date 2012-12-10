drop sequence tsm_stage.study_seq;

create sequence tsm_stage.study_seq;

alter table tsm_stage.study add(indmap_id number(10), 
phase_id number(10),cro_exp_Area_id number(10), cro_company_id number(10),
sub_phase_id number(10));

update tsm_stage.study a set a.indmap_id=(select b.id from tc10.indmap b where
b.code=a.indcode);

update tsm_stage.study a set a.phase_id=(select b.id from tc10.phase b where
upper(b.short_desc)=upper('phase'||trim(a.phase)));

update tsm_stage.study a set a.cro_exp_Area_id=
decode(studytype,'CL',1,'DP',2,'AN',3,'MW',4,'QA',5,'RG',6,'DP',8,'OT',9);

update tsm_stage.study a set a.cro_company_id=(select b.id from tc10.cro_company b 
where b.de_id=a.id);
commit;


update tsm_stage.study set phase_id=-1, sub_phase_id=null where trim(phase) is null;
update tsm_stage.study set phase_id=1, sub_phase_id=null where phase='         I';
update tsm_stage.study set phase_id=1, sub_phase_id=null where phase='        I';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='        II';
update tsm_stage.study set phase_id=1, sub_phase_id=null where phase='       I';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase='      III';
update tsm_stage.study set phase_id=19, sub_phase_id=3 where phase='      IIIa';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase='     III';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='   II';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='  II';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase='  III';
update tsm_stage.study set phase_id=19, sub_phase_id=3 where phase='  IIIa';
update tsm_stage.study set phase_id=19, sub_phase_id=4 where phase='  IIIb';
update tsm_stage.study set phase_id=5, sub_phase_id=null where phase='  IV';
update tsm_stage.study set phase_id=1, sub_phase_id=null where phase=' I';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase=' II';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase=' II-III';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase=' III';
update tsm_stage.study set phase_id=19, sub_phase_id=3 where phase=' IIIa';
update tsm_stage.study set phase_id=19, sub_phase_id=4 where phase=' IIIb';
update tsm_stage.study set phase_id=5, sub_phase_id=null where phase=' IV';
update tsm_stage.study set phase_id=1, sub_phase_id=null where phase='1';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='11';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase='111';
update tsm_stage.study set phase_id=-1, sub_phase_id=null where phase='224';
update tsm_stage.study set phase_id=-1, sub_phase_id=null where phase='30';
update tsm_stage.study set phase_id=-1, sub_phase_id=null where phase='600';
update tsm_stage.study set phase_id=-1, sub_phase_id=null where phase='Device';
update tsm_stage.study set phase_id=1, sub_phase_id=null where phase='I';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase='I - III';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='I, II';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase='I, II, III';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='I, II\IIa';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='I,II';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='I,II IIa';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='I,II,IIa';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='I,II/IIa';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='I,II\IIa';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='I-II';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase='I-III';
update tsm_stage.study set phase_id=19, sub_phase_id=4 where phase='I-IIIb';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='I-IIa';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase='I-IIa-III';
update tsm_stage.study set phase_id=5, sub_phase_id=null where phase='I-IV';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='I/II';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase='I/II/III';
update tsm_stage.study set phase_id=5, sub_phase_id=null where phase='I/II/IV';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase='I/III';
update tsm_stage.study set phase_id=5, sub_phase_id=null where phase='I/III/IV';
update tsm_stage.study set phase_id=19, sub_phase_id=3 where phase='I/IIIa';
update tsm_stage.study set phase_id=19, sub_phase_id=4 where phase='I/IIIb';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='I/IIa';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase='I/IIb/III';
update tsm_stage.study set phase_id=5, sub_phase_id=null where phase='I/IV';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='I12';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='II';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='II,IIa';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase='II,IIa,III';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase='II-III';
update tsm_stage.study set phase_id=19, sub_phase_id=3 where phase='II-IIIb';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='II-IIa';
update tsm_stage.study set phase_id=5, sub_phase_id=null where phase='II-IV';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase='II/ III';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='II/II';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase='II/III';
update tsm_stage.study set phase_id=5, sub_phase_id=null where phase='II/III/IV';
update tsm_stage.study set phase_id=19, sub_phase_id=3 where phase='II/IIIb';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='II/IIa';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase='II/IIa,III';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='II/IIb';
update tsm_stage.study set phase_id=5, sub_phase_id=null where phase='II/IV';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='II/Iia';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase='III';
update tsm_stage.study set phase_id=5, sub_phase_id=null where phase='III, IV';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase='III,IIIb';
update tsm_stage.study set phase_id=5, sub_phase_id=null where phase='III,IV';
update tsm_stage.study set phase_id=5, sub_phase_id=null where phase='III-IV';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase='III/IIIb';
update tsm_stage.study set phase_id=5, sub_phase_id=null where phase='III/IV';
update tsm_stage.study set phase_id=19, sub_phase_id=4 where phase='IIIB';
update tsm_stage.study set phase_id=5, sub_phase_id=null where phase='IIII/IV';
update tsm_stage.study set phase_id=19, sub_phase_id=4 where phase='III\IIIb';
update tsm_stage.study set phase_id=19, sub_phase_id=3 where phase='IIIa';
update tsm_stage.study set phase_id=5, sub_phase_id=null where phase='IIIa-IV';
update tsm_stage.study set phase_id=19, sub_phase_id=4 where phase='IIIb';
update tsm_stage.study set phase_id=5, sub_phase_id=null where phase='IIIb-IV';
update tsm_stage.study set phase_id=5, sub_phase_id=null where phase='IIIb/IV';
update tsm_stage.study set phase_id=5, sub_phase_id=null where phase='IIIbIV';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase='II\III';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='II\IIa';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase='II\IIa,III';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='IIa';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase='IIa/III';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='IIb';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase='IIb, III';
update tsm_stage.study set phase_id=19, sub_phase_id=null where phase='IIb/III';
update tsm_stage.study set phase_id=5, sub_phase_id=null where phase='IV';
update tsm_stage.study set phase_id=5, sub_phase_id=null where phase='IV/Outcome';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='I\II';
update tsm_stage.study set phase_id=1, sub_phase_id=null where phase='Ia/b';
update tsm_stage.study set phase_id=1, sub_phase_id=null where phase='Ia\b';
update tsm_stage.study set phase_id=1, sub_phase_id=null where phase='Ib';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='Ib/II';
update tsm_stage.study set phase_id=5, sub_phase_id=null where phase='Iv';
update tsm_stage.study set phase_id=5, sub_phase_id=null where phase='Outcomes';
--update tsm_stage.study set phase_id=?, sub_phase_id=null where phase='PMS';
update tsm_stage.study set phase_id=-1, sub_phase_id=null where phase='Preclinica';
update tsm_stage.study set phase_id=-1, sub_phase_id=null where phase='Registry';
update tsm_stage.study set phase_id=-1, sub_phase_id=null where phase='V';
update tsm_stage.study set phase_id=1, sub_phase_id=null where phase='ii';
update tsm_stage.study set phase_id=2, sub_phase_id=null where phase='iii';
commit;

update tsm_stage.study set compl_year='1999' where compl_year='2099';
update tsm_stage.study set compl_year=null where compl_year='open';
update tsm_stage.study set compl_year=null where compl_year='curr';
update tsm_stage.study set compl_year=null where to_number(compl_year) < 1950;
update tsm_stage.study set compl_year=null where to_number(compl_year) > 2050;
commit;

delete from tc10.cro_study;
commit;

insert into tc10.cro_study(ID,CRO_COMPANY_ID,PROJECT_NAME,
INDMAP_ID,PHASE_ID,NUM_SUBJECTS,NUM_SITES,START_DATE,
YEAR_COMPLETED,NUM_SIMILAR_STUDIES,CRO_EXP_AREA_ID,de_id,sub_phase_id,de_studyid)         
select tsm_stage.study_seq.nextval,cro_company_id,DRUGTYPE,indmap_id,
phase_id,subject,centers,"START",
trunc(to_date(to_number(compl_year)+1,'YYYY'),'YYYY')-1,
similaproj, cro_exp_area_id,trim(id),sub_phase_id,trim(studyid) from tsm_stage.study
where cro_company_id is not null;
commit; 

drop sequence tsm_stage.study_seq;