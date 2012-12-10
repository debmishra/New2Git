create sequence tsm_stage.deslmst_seq;


delete from tc10.cro_language;

insert into tc10.cro_language(ID,LANGUAGE_NAME,LANGUAGE_CODE)         
select tsm_stage.deslmst_seq.nextval,trim(tl_desc),trim(TL_TSLID)
from tsm_stage.deslmst where trim(TL_TSLID) like 'T%';
commit; 

drop sequence tsm_stage.deslmst_seq;