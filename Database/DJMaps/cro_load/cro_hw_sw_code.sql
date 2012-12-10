create sequence tsm_stage.decommst_seq;

alter table tc10.cro_hw_sw_code modify(
hw_sw_type null);

delete from tc10.cro_hw_sw_code;

insert into tc10.cro_hw_sw_code(ID,CROCAS_KEY,NAME,IS_VIEWABLE)         
select tsm_stage.decommst_seq.nextval,CM_COMID,CM_DESC,
decode(CM_BASIC,'T',1,'F',0)
from tsm_stage.decommst where cm_comid is not null;
commit; 

update tc10.cro_hw_sw_code set hw_sw_type =2
where CROCAS_KEY like 'SS%';
update tc10.cro_hw_sw_code set hw_sw_type =1
where not CROCAS_KEY like 'SS%' and 
CROCAS_KEY like 'S%';
update tc10.cro_hw_sw_code set hw_sw_type =0
where CROCAS_KEY like 'H%';
commit;

alter table tc10.cro_hw_sw_code modify(
hw_sw_type not null);


drop sequence tsm_stage.decommst_seq;