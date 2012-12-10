drop sequence tsm_stage.cro_company_seq;
create sequence tsm_stage.cro_company_seq;
delete from tc10.cro_company;

update tsm_stage.demain2 set ma_country='Netherlands' 
where trim(ma_country)='The Netherlands';

update tsm_stage.demain2 set ma_regcoun='Netherlands' 
where trim(ma_regcoun)='The Netherlands';

update tsm_stage.demain2 set ma_country='Ireland' 
where trim(ma_country)='Republic of Ireland';

update tsm_stage.demain2 set ma_regcoun='Ireland' 
where trim(ma_regcoun)='Republic of Ireland';

update tsm_stage.demain2 set ma_country='United Kingdom' 
where trim(ma_country)='Great Britian';

update tsm_stage.demain2 set ma_regcoun='United Kingdom' 
where trim(ma_regcoun)='Great Britian';

update tsm_stage.demain2 set ma_country='United Kingdom' 
where trim(ma_country)='England';

update tsm_stage.demain2 set ma_regcoun='United Kingdom' 
where trim(ma_regcoun)='England';

update tsm_stage.demain2 set ma_country='Rumania, Romania' 
where trim(ma_country)='Romania';

update tsm_stage.demain2 set ma_regcoun='Rumania, Romania' 
where trim(ma_regcoun)='Romania';

update tsm_stage.demain2 set ma_country='' 
where trim(ma_country)='Berlin';

update tsm_stage.demain2 set ma_regcoun='' 
where trim(ma_regcoun)='Berlin';

Alter table tsm_stage.demain2 add(country_id number(10), state number(10),
regoffice_state number(10), regoffice_cty number(10));

update tsm_stage.demain2 set ma_country='United States' where trim(ma_country)='USA';
update tsm_stage.demain2 set ma_country='United Kingdom' where trim(ma_country)='UK';

update tsm_stage.demain2 set ma_regcoun='United States' where trim(ma_regcoun)='USA';
update tsm_stage.demain2 set ma_regcoun='United Kingdom' where trim(ma_regcoun)='UK';


update tsm_stage.demain2 a set a.country_id=(select b.id
from tc10.country b where upper(b.name)=upper(trim(a.ma_country)));

update tsm_stage.demain2 a set a.REGOFFICE_CTY=(select b.id
from tc10.country b where upper(b.name)=upper(trim(a.ma_regcoun)));

update tsm_stage.demain2 a set a.state=(select b.id from tc10.region b
where b.abbreviation=trim(a.ma_state) and b.country_id=a.country_id
and b.type='State') where a.ma_country='United States';

update tsm_stage.demain2 a set a.state=(select b.id from tc10.region b
where b.name=trim(a.ma_state) and b.country_id=a.country_id
and b.type='State') where a.ma_country<>'United States';

update tsm_stage.demain2 a set a.regoffice_state=(select b.id from tc10.region b
where b.abbreviation=trim(a.ma_regstat) and a.regoffice_cty=b.country_id
and b.type='State') where a.ma_regcoun='United States';

update tsm_stage.demain2 a set a.regoffice_state=(select b.id from tc10.region b
where b.name=trim(a.ma_regstat) and a.regoffice_cty=b.country_id
and b.type='State') where a.ma_regcoun<>'United States';
commit;

Insert into tc10.cro_company(ID,LAST_UPDATE,NAME,ADDR1,ADDR2,
CITY,STATE,COUNTRY_ID,ZIP,PHONE,
FAX,EMAIL,HOME_PAGE,CONTACT,DATE_FORMED,
CO_TYPE,LEGAL_FORM,REGOFFICE_NAME,REGOFFICE_ADDR1,REGOFFICE_ADDR2,
REGOFFICE_CITY,REGOFFICE_STATE,REGOFFICE_ZIP,REGOFFICE_COUNTRY_ID,REGOFFICE_EMAIL,
CRO_TYPE,LONG_DESC,CLIENT_PCT1,CLIENT_PCT2,CLIENT_PCT3,
TOTAL_STAFF,PART_TIME_STAFF,FULL_TIME_STAFF,CONTRACT_STAFF,REVENUE_LAST_YR,
PROJS_LAST_SIX_MOS,CLINICAL_STAFF,DATA_MGMT_STAFF,LAB_STAFF,MED_WRITERS_STAFF,
REGULATORY_STAFF,QA_STAFF,DEV_PACK_STAFF,TOX_STAFF,PARENT_CO_NAME,de_id,other_staff)
select tsm_stage.cro_company_seq.nextval,to_date(ma_mod,'YYYY'),
ma_name,ma_add1,ma_add2,
ma_city,state,country_id,ma_zip,ma_phone,
ma_fax,ma_email,www_home,ma_contact,ma_form,
ma_cotype,ma_legform,ma_regname,ma_regadd1,ma_regadd2,
ma_regcity,regoffice_state,ma_regzip,REGOFFICE_CTY,ma_regem,
ma_contyp,null,ma_percl1,ma_percl2,ma_percl3,
ma_staf,ma_ptstaff,ma_ftstaff,ma_ctstaff,ma_rev00,
ma_proj,tot_clin,tot_data,tot_lab,tot_med,
tot_reg,tot_qa,tot_pack,tot_tox,ma_subna,ma_id,TOT_OTHER
from tsm_stage.demain2 where upper(ma_ok)='TRUE'
and country_id is not null and ma_add1 is not null;  

commit;

set define off  
update tc10.cro_company set cro_type='CRO' where 
trim(cro_type)='CRO' 
or cro_type like '%Analytical CRO%'
or cro_type like '%CRO and Site Network (4)%'
or cro_type like '%CRO(Not a clinical development CRO%'
or cro_type like '%private limited company%';

update tc10.cro_company set cro_type='CRO/SMO' where 
cro_type like '%CRO/SMO%'
or cro_type like '%Hybrid SMO%'
or cro_type like '%Hybrid CRO/SMO%'
or cro_type like '%CRO, SMO%'
or cro_type like '%CRO and SMO%';

update tc10.cro_company set cro_type='Investigative Site' where 
cro_type like '%Investigative Site%'
or cro_type like '%CRO/Investigative Site%'
or cro_type like '%Investigative Site & SMO%';

update tc10.cro_company set cro_type='SMO' where
trim(CRO_type)='SMO'  
or cro_type like '%SMO/Investigative Site%';

update tc10.cro_company set cro_type='Central Lab.' where 
cro_type like '%CRO/Central Lab.%'
or cro_type like '%Central laboratory%'
or cro_type like '%Central Laboratory SVC%'
or cro_type like '%Central Lab. for Clinical Trials.%'
or cro_type like '%Central Lab for Cardio & Resp tests%'
or cro_type like '%Central Lab%';

update tc10.cro_company set cro_type='Consultant' where 
cro_type like '%Consultant%'
or cro_type like '%Consultants%'
or cro_type like '%Independent Freelance MW%'
or cro_type like '%QA Consulting%';

update tc10.cro_company set cro_type='Laboratory' where 
cro_type like '%Laboratory Research%'
or cro_type like '%GMP/GLP Testing Lab.%'
or cro_type like '%CRO/Service Laboratory%'
or cro_type like '%Contractual Research Lab and Central Lab%';

update tc10.cro_company set cro_type='Regulatory Org.' where 
cro_type like '%Regulatory Org%'
or cro_type like '%Regulatory Consultancy%'
or cro_type like '%IRB + Consulting Firm%';

update tc10.cro_company set legal_form='Corporation' where                    
trim(legal_form)='Corporation' 
or trim(legal_form)='Inc.'
or trim(legal_form)='Incorporated'
or trim(legal_form)='Private'
or trim(legal_form)='Incorporation' 
or trim(legal_form)='C-Corp' 
or trim(legal_form)='Inc' 
or trim(legal_form)='Incorporated' 
or trim(legal_form)='Private company'
or trim(legal_form) like '501 (C)%'  
or trim(legal_form)='Co.' 
or trim(legal_form)='INC' 
or trim(legal_form)='private' 
or trim(legal_form)='CRO' 
or trim(legal_form)='SMO' 
or trim(legal_form)='CRO/SMO' 
or trim(legal_form)='Public' 
or trim(legal_form)='Hospital Corporation';



update tc10.cro_company set legal_form='S-Corporation' where 
legal_form like '%S-Corporation%'
or legal_form like '%S Corp%'
or legal_form like '%S. Corp%' 
or legal_form like '%S-Corp%' 
or legal_form like '%S Corp%' 
or legal_form like '%Class S Corporation%'
or legal_form like '%Subchapter S Corp.%'
or legal_form like '%Sub S Corp%'
or legal_form like '%S Corporation%';

update tc10.cro_company set legal_form='Ltd.' where 
trim(legal_form) = 'Ltd.'
or trim(legal_form) = 'Ltd'
or trim(legal_form) = 'LTD'
or trim(legal_form) = 'LTD.'
or trim(legal_form) = 'Limited'
or trim(legal_form) like 'Private/Ltd%'
or trim(legal_form) = 'Ltd,GmbH,Kft'
or trim(legal_form) = 'Unlimited Co. in UK';

update tc10.cro_company set legal_form=trim(legal_form);

update tc10.cro_company set legal_form='LLC' where 
legal_form like '%LLC%'
or legal_form like '%Limited Liability Co.%'
or legal_form like '%Limited Liability%'
or legal_form like '%LLC.%'
or legal_form like '%Limited Company%';

update tc10.cro_company set legal_form='SA' where 
trim(legal_form) = 'SA' 
or legal_form like '%S.A.%'
or legal_form like '%Sociedad Anonima%'
or legal_form like '%Societe Anonyme (SA)%'
or legal_form like '%SA/NV%';

update tc10.cro_company set legal_form='GmbH' where 
trim(legal_form) = 'GmbH' 
or legal_form like '%Gmbh  & KG%'
or legal_form like '%GmbH  (LTD)%'
or legal_form like '%GmbH Ltd%';

update tc10.cro_company set legal_form='Non-Profit' where 
trim(legal_form) like '%Non-profit%' 
or legal_form like '%Non Profit Foundation%'
or legal_form like '%not for profit%';

update tc10.cro_company set legal_form='University' where 
trim(legal_form) = 'University' 
or legal_form like '%University Dept%';

update tc10.cro_company set legal_form='AG' where 
trim(legal_form) = 'AG';

update tc10.cro_company set legal_form='BV' where 
trim(legal_form) = 'BV'
or trim(legal_form) like '%BV (Ltd.)%'
or trim(legal_form) like '%Besloten Vennootschap%';

update tc10.cro_company set legal_form='SARL' where 
legal_form like '%SRL%'
or legal_form like '%S.A.R.L%'
or legal_form like '%SARL%'
or legal_form like '%Sarl%'
or legal_form like '%SRL (Limited)%'
or legal_form like '%Srl%'
or legal_form like '%S.L%';

update tc10.cro_company set legal_form='AB' where 
trim(legal_form) = 'AB'
or trim(legal_form) like '%Swedish AB%';

update tc10.cro_company set legal_form='Sole Proprietorship' where 
legal_form like '%Sole Proprietorship%'
or legal_form like '%Sole Propietorship%'
or legal_form like '%Proprietorship%'
or legal_form like '%Sole trader%';

update tc10.cro_company set legal_form='Government Agency' where 
legal_form like '%Public Health Serv.%'
or legal_form like '%State Agency%'
or legal_form like '%Federal Institiution%';

update tc10.cro_company set legal_form='Charity' where 
legal_form like '%Charity%'
or legal_form like '%Registered Charity%';

update tc10.cro_company set legal_form='Partnership' where 
trim(legal_form) = 'Partnership';

update tc10.cro_company set co_type=trim(co_type);

update tc10.cro_company set co_type='Private Corporation' where 
co_type like '%Private Corporation%'
or co_type like '%Private%'
or co_type like '%private%'
or co_type like '%Private Company%'
or co_type like '%Corporation, Private%'
or co_type like '%Corporation(Private)%'
or co_type like '%Employee owned%'
or co_type like '%S Corporation%'
or co_type like '%Incorporation%';

update tc10.cro_company set co_type='Public Corporation' where 
co_type like '%Public Corporation%'
or co_type = 'Corporation'
or co_type = 'corporation'
or co_type like '%Public%'
or co_type like '%Publicly Quoted%'
or co_type like '%Publ.held%'
or co_type like '%employee owned%'
or co_type like '%Publicly quoted%';

update tc10.cro_company set co_type='Subsidiary' where 
co_type like '%Subsidiary%'
or co_type like '%Wholly Owned Subsidiary%'
or co_type like '%Wholly owned subsidiary%';

update tc10.cro_company set co_type='Non-profit' where 
co_type like '%Non-profit%' 
or co_type like '%non-profit%' 
or co_type like '%Private/non profit%' 
or co_type like '%Private/Non Profit%' 
or co_type like '%Not-for-profit%' 
or co_type like '%Charity%'
or co_type like '%Non-Profit private%' 
or co_type like '%Non-Profit%' 
or co_type like '%Non Profit%' 
or co_type like '%Charity/non-profit%' 
or co_type like '%Dept of Non-Profit Hosp%';

update tc10.cro_company set co_type='Partnership' where 
co_type like '%Partnership%'
or co_type like '%partnership%';


update tc10.cro_company set co_type='LLC' where 
co_type like '%LLC%' 
or co_type like '%L.L.C.%'
or co_type like '%LLC-Partnership%' 
or co_type like '%Limited%' 
or co_type like '%Limited Liability Company%'
or co_type like '%Co-operative%';


update tc10.cro_company set co_type='S.A.' where 
trim(co_type) = 'S.A.';

update tc10.cro_company set co_type='GmbH' where 
trim(co_type) = 'GmbH';

update tc10.cro_company set co_type='University/Academic' where
co_type like '%University/Academic%'  
or co_type like '%University (non-profit)%' 
or co_type like '%University%' 
or co_type like '%Charity/University%';


update tc10.cro_company set co_type='Ltd.' where
co_type like '%Private Ltd.%'  
or co_type like '%Private LTD%' 
or co_type like '%Private Limited%' 
or co_type like '%Private Limited (BV)%';

update tc10.cro_company set co_type='CRO' where
trim(co_type)='CRO'
or co_type like '%CRO\Consultancy%';

update tc10.cro_company set co_type='Consultant' where
trim(co_type)='Consultancy';

update tc10.cro_company set co_type='Sole Proprietor' where
co_type like '%Sole Trader/Proprietor%'  
or co_type like '%Sole Trader%' 
or co_type like '%Proprietorship%';

commit;
set define on

update tc10.cro_company a set a.total_staff=(select 
nvl(clinical_staff,0)+nvl(med_writers_staff,0)+nvl(data_mgmt_staff,0)+
nvl(qa_staff,0)+nvl(regulatory_staff,0)+nvl(tox_staff,0)+ 
nvl(dev_pack_staff,0)+ nvl(lab_staff,0)+ nvl(other_staff,0) 
from tc10.cro_company b where a.rowid=b.rowid);

commit;
