create sequence tsm_stage.cro_service_type_seq;

delete from tc10.cro_service_type;

insert into tc10.cro_service_type(id,NAME,CROCAS_KEY,CRO_EXP_AREA_ID,
IS_VIEWABLE,SERVICE_SUBTYPE) 
select tsm_stage.cro_service_type_seq.nextval, dv_desc, dv_svid,
decode (substr(upper(trim(dv_svid)),1,2),'CL',1,'DS',2,'LA',3,
'MW',4,'QA',5,'OT',9,
decode(length(trim(dv_svid)),4,decode(substr(upper(trim(dv_svid)),1,2),'PT',6,'PR',6))),
decode(upper(dv_basic),'TRUE',1,'FALSE',0,trim(dv_basic)),dv_type
from tsm_stage.desvc where dv_desc is not null;
commit;


drop sequence tsm_stage.cro_service_type_seq;


