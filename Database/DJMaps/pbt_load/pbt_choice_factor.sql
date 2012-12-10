drop sequence tsm_stage.pbt_choice_factor_seq;
drop sequence tsm_stage.cro_choice_factor_seq;
drop sequence tsm_stage.cro_choice_seq;
create sequence tsm_stage.pbt_choice_factor_seq;
create sequence tsm_stage.cro_choice_factor_seq;
create sequence tsm_stage.cro_choice_seq;

delete from tsm_stage.pbt_choice where cro_component_id is null;

drop table tsm_stage.pbt_choice_factor;

create table tsm_stage.pbt_choice_factor(
ID 			NUMBER(10),
COUNTRY_ID 		NUMBER(10),
CRO_TYPE 		NUMBER(1),
CRO_COMPONENT_ID 	NUMBER(10),
FACTOR 			NUMBER(12,6),
CHOICE_LABEL 		VARCHAR2(256),
short_desc 		VARCHAR2(256));

alter table tsm_stage.pbt_choice_factor add (
     account varchar2(3),c_item varchar2(16),choice varchar2(16),
     sequence number(2), low_range varchar2(16), high_range varchar2(16)  );

declare

cursor c1 is select distinct country_id,size_cro from tsm_stage.bgmaster
             where country_id is not null;

begin

 for ix1 in c1 loop

  Insert into tsm_stage.pbt_choice_factor(ID,COUNTRY_ID,
  CRO_TYPE,CRO_COMPONENT_ID,FACTOR,CHOICE_LABEL,account,
  c_item,choice,sequence, low_range, high_range,short_desc) 
  select tsm_stage.pbt_choice_factor_seq.nextval,ix1.country_id,
  ix1.size_cro,cro_component_id,null,choice_label,account,
  c_item,choice,sequence,low_range, high_range,short_desc from tsm_stage.pbt_choice;
 end loop;
 commit;
end ;
/
sho err
          

update tsm_stage.pbt_choice_factor a set a.factor=(select
factor from tsm_stage.bgmaster b where 
a.cro_type=b.size_cro and 
a.country_id=b.country_id and
a.account=b.account and
a.c_item=to_char(b.c_item) and
a.CHOICE=to_char(b.CHOICE))
where trim(upper(a.c_item)) <> 'NONE';
 

update tsm_stage.pbt_choice_factor set factor=1 
where factor is null;
commit;

truncate table "&1".cro_choice_factor;
delete from "&1".cro_choice;

declare

  cursor c1 is select distinct CRO_COMPONENT_ID,CHOICE_LABEL,sequence,low_range,high_range,short_desc 
  from tsm_stage.pbt_choice_factor; 
  CroChoiceId number(10);

begin

  for ix1 in c1 loop 
     select tsm_stage.cro_choice_seq.nextval into CroChoiceId from dual;
     insert into "&1".cro_choice(ID,CRO_COMPONENT_ID,CHOICE_LABEL,SHORT_DESC, sequence,low_range,high_range)
     values (CroChoiceId, ix1.CRO_COMPONENT_ID, trim(ix1.CHOICE_LABEL), 
     trim(Decode(ix1.SHORT_DESC,null,'NONE',ix1.SHORT_DESC)),ix1.sequence,ix1.low_range, ix1.high_range);
  
     declare
        cursor c2 is select rowid from tsm_stage.pbt_choice_factor
              where CRO_COMPONENT_ID=ix1.CRO_COMPONENT_ID and
              CHOICE_LABEL=ix1.CHOICE_LABEL;
     begin
        for ix2 in c2 loop
         insert into "&1".cro_choice_factor(ID,COUNTRY_ID,
  	   CRO_TYPE,FACTOR,CRO_CHOICE_ID)
         select tsm_stage.cro_choice_factor_seq.nextval,COUNTRY_ID, CRO_TYPE,
          FACTOR,CroChoiceId from tsm_stage.pbt_choice_factor where
          rowid=ix2.rowid;
        end loop;
     end;
  end loop;
commit;
end;
/
     
Alter table "&1".CRO_CHOICE enable constraint CRO_CHOICE_FK1;
Alter table "&1".CRO_BUDGET_INPUT enable constraint CRO_BUDGET_INPUT_FK2;  
Alter table "&1".CRO_BUDGET_INPUT enable constraint CRO_BUDGET_INPUT_FK4; 


drop sequence tsm_stage.pbt_choice_factor_seq;
drop table tsm_stage.pbt_choice_factor;
drop sequence tsm_stage.cro_choice_factor_seq;
drop sequence tsm_stage.cro_choice_seq;
