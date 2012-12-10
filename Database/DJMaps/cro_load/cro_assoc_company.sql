drop sequence tsm_stage.cro_assoc_company_seq;
create sequence tsm_stage.cro_assoc_company_seq;
delete from tc10.cro_assoc_company;

alter table tsm_stage.desubsid modify SB_COUNTRY varchar2(40);

update tsm_stage.desubsid set sb_country='United States' 
where trim(sb_country)='USA';
update tsm_stage.desubsid set sb_country='United Kingdom' 
where trim(sb_country) in ('UK','Europe','England','Scotland');

update tsm_stage.desubsid set sb_country='Argentina'
where trim(sb_country) in ('Aregentina','Republica Argentina');

update tsm_stage.desubsid set sb_country='Singapore' 
where trim(sb_country) in ('Asian','Asia','Rep. of Singapore');

update tsm_stage.desubsid set sb_country='Russia' 
where trim(sb_country) in ('Georgia/Europe','UK/Russia','Georgia','Belarus');

update tsm_stage.desubsid set sb_country='Australia' 
where trim(sb_country) = 'Austrialia';

update tsm_stage.desubsid set sb_country='Brazil' 
where trim(sb_country) = 'Brasil';

update tsm_stage.desubsid set sb_country='France' 
where trim(sb_country) in ('FRA','Madagascar');

update tsm_stage.desubsid set sb_country='Israel'
where trim(sb_country) = 'Isreal';

update tsm_stage.desubsid set sb_country='Ireland'
where trim(sb_country) in ('Northern Ireland','Republic of Ireland');

update tsm_stage.desubsid set sb_country='China'
where trim(sb_country) = 'P.R. China';

update tsm_stage.desubsid set sb_country= 'Rumania, Romania'
where trim(sb_country) = 'Romania';

update tsm_stage.desubsid set sb_country= 'Netherlands'
where trim(sb_country) in ('The Netherlands');

update tsm_stage.desubsid set sb_country= 'Taiwan'
where trim(sb_country) like 'Taiwan%' ;

update tsm_stage.desubsid set sb_country= 'Czech Republic, Slovakia'
where trim(sb_country) = 'Slovakia' ;


Alter table tsm_stage.desubsid add(
parent_company_id number(10), 
country_id number(10), 
state number(10));


update tsm_stage.desubsid a set a.country_id=(select b.id
from tc10.country b where upper(b.name)=upper(trim(a.sb_country)));

update tsm_stage.desubsid a set a.state=(select b.id from tc10.region b
where b.abbreviation=trim(a.sb_state) and b.country_id=a.country_id
and b.type='State') where a.sb_country='United States';

update tsm_stage.desubsid a set a.state=(select b.id from tc10.region b
where b.name=trim(a.sb_state) and b.country_id=a.country_id
and b.type='State') where a.sb_country<>'United States';

update tsm_stage.desubsid a set a.parent_company_id = (select b.id 
from tc10.cro_company b where trim(b.de_id)=trim(a.sb_id));


commit;

Insert into tc10.cro_assoc_company(ID,CRO_COMPANY_ID,NAME,
ADDRESS1,ADDRESS2,CITY,STATE,COUNTRY_ID,ZIP,PHONE,EMAIL,FAX,
HOME_PAGE,CONTACT_NAME,ASSOC_TYPE,LAST_UPDATED)
select tsm_stage.cro_assoc_company_seq.nextval,parent_COMPANY_ID,
sb_name,sb_add1,sb_add2,
sb_city,state,country_id,sb_zip,sb_phone,
sb_email,sb_fax,sb_page,sb_contact,sb_code,sysdate
from tsm_stage.desubsid where /* upper(sb_crocas)='TRUE'*/
parent_company_id is not null 
and trim(sb_country) is not null;  

commit;


       