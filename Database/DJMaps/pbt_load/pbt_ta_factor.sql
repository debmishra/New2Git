drop sequence tsm_stage.pbt_ta_factor_seq;
create sequence tsm_stage.pbt_ta_factor_seq;
delete from "&1".cro_ta_factor;

alter table tsm_stage.pbt_ta_factor add(indmap_id number(10));

update tsm_stage.pbt_ta_factor set ta_desc='IMMUNOMODULATION'
 where ta_desc='Immuno-modulation/Anti-inflammatory';

update tsm_stage.pbt_ta_factor a set a.indmap_id = (select b.id from "&1".indmap b
where upper(b.code)=upper(a.TA_DESC) and b.TYPE = 'Therapeutic Area');


insert into "&1".cro_ta_factor
select tsm_stage.pbt_ta_factor_seq.nextval,indmap_id, pbt_fact, null from
tsm_stage.pbt_ta_factor where indmap_id is not null;
commit;

drop sequence tsm_stage.pbt_ta_factor_seq;