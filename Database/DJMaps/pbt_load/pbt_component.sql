truncate table "&1".CRO_CHOICE_FACTOR;

Alter table "&1".CRO_BUDGET_INPUT disable constraint CRO_BUDGET_INPUT_FK2;
Alter table "&1".CRO_CHOICE disable constraint CRO_CHOICE_FK1;
Alter table "&1".CRO_BUDGET_INPUT disable constraint CRO_BUDGET_INPUT_FK4;

DELETE FROM "&1".CRO_CHOICE;

delete from "&1".cro_component;

alter table tsm_stage.cro_component add(CRO_CATEGORY_ID number(10),
COMPONENT_TYPE NUMBER(1));

update tsm_stage.cro_component a set a.cro_category_id = (select b.id from "&1".cro_category b
where upper(a.account)=upper(b.category_account));
delete from tsm_stage.cro_component where id is null;
update tsm_stage.cro_component a set a.component_type=1 where upper(type) like '%RADIO%';
update tsm_stage.cro_component a set a.component_type=2 where upper(type) like '%DROPDOWN%';
update tsm_stage.cro_component a set a.component_type=3 where upper(type) like '%CHECKBOX%';
update tsm_stage.cro_component a set a.component_type=4 where upper(type) like 'INPUT%';
update tsm_stage.cro_component a set a.component_type=5 where upper(type) like 'R/O INPUT%';
update tsm_stage.cro_component a set a.component_type=6 where upper(type) like '%LABEL%';
update tsm_stage.cro_component a set a.component_type=7 where upper(type) like '%FACTORED INPUT BOX%';
update tsm_stage.cro_component a set a.component_type=8 where upper(type) like 'DECIMAL INPUT BOX%';
update tsm_stage.cro_component a set a.component_type=9 where upper(type) like 'DECIMAL CALC FIELD%';


commit;


insert into "&1".cro_component (ID,CRO_CATEGORY_ID,COMPONENT_TYPE,COMPONENT_LABEL,
COMPONENT_SEQ,SHORT_DESC,SUB_CATEGORY_ID,WEIGHT,PARENT_COMPONENT_ID,DEFAULT_VAL  )
select ID,CRO_CATEGORY_ID,COMPONENT_TYPE,trim(COMPONENT_LABEL),COMPONENT_SEQ,
trim(decode(short_desc,null,COMPONENT_LABEL,short_desc)), SUB_CATEGORY_ID,WEIGHT,PARENT_COMPONENT_ID,DEFAULT_VAL
from tsm_stage.cro_component;
commit; 

