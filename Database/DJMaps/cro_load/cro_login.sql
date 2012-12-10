insert into tc10.cro_login(id,name,password,LAST_UPDATED,CRO_COMPANY_ID)
select PASSWORD-24000,name,password,sysdate,password-24000 from
tsm_stage.cro_login;

update tc10.cro_login set name=substr(name,1,length(name)-1)
where name like '%.';

update tc10.cro_login set name='ProvaRD' where name='Prova RD';

commit;