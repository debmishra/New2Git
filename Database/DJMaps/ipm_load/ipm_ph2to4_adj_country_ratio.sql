alter table tsm_stage.ipm_ph2to4_adj_country_ratio add (country_id number(10));

update tsm_stage.ipm_ph2to4_adj_country_ratio a set a.country_id=
(select b.id from "&1".country b where b.abbreviation=a.cntry);

commit;

truncate table "&1".ipm_ph2to4_adj_country_ratio;

create sequence tsm_stage.ipm_pacr_seq;

Insert into "&1".ipm_ph2to4_adj_country_ratio
select tsm_stage.ipm_pacr_seq.nextval,                            
COUNTRY_ID,GEOGRAPHICAL_LOCATION,
P2,P3,Y3P2,Y3P3 from 
tsm_stage.ipm_ph2to4_adj_country_ratio;
commit;

drop sequence tsm_stage.ipm_pacr_seq;
