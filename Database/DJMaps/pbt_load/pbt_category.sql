create sequence tsm_stage.pbt_category_seq;
delete from "&1".cro_category;

alter table tsm_stage.category modify (account varchar2(3));
update tsm_stage.category set account='Q/R' where account='Q';
update tsm_stage.category set category='Report Management' where account='Q/R';
update tsm_stage.category a set a.info=(select a.info||' '||b.info
	from tsm_stage.category b where b.account='R') where a.account='Q/R';
commit;


insert into "&1".cro_category (ID,SHORT_DESC,
LONG_DESC,UNIT_NAME,CATEGORY_ACCOUNT,IS_VIEWABLE)
select tsm_stage.pbt_category_seq.nextval,category,info,unitname,
account,1 from tsm_stage.category where account <> 'R';
commit; 

drop sequence tsm_stage.pbt_category_seq;  

insert into "&1".cro_category(ID,SHORT_DESC,PARENT_CATEGORY_ID,LONG_DESC,
UNIT_NAME,CATEGORY_ACCOUNT,IS_VIEWABLE) values
(29,'Protocol Versions',2,'Protocol Versions',
'Protocols','5',1);

insert into "&1".cro_category(ID,SHORT_DESC,PARENT_CATEGORY_ID,LONG_DESC,
UNIT_NAME,CATEGORY_ACCOUNT,IS_VIEWABLE) values
(30,'Study Guide Versions',2,'Study Guide Versions',
'Study Guides','6',1);

insert into "&1".cro_category(ID,SHORT_DESC,PARENT_CATEGORY_ID,LONG_DESC,
UNIT_NAME,CATEGORY_ACCOUNT,IS_VIEWABLE) values
(31,'Investigator Brochures',2,'Investigator Brochures',
'Brochures','7',1);

insert into "&1".cro_category(ID,SHORT_DESC,PARENT_CATEGORY_ID,LONG_DESC,
UNIT_NAME,CATEGORY_ACCOUNT,IS_VIEWABLE) values
(32,'Informed Consent Form',3,'Informed Consent Form',
'ICF Pages','8',1);

insert into "&1".cro_category(ID,SHORT_DESC,PARENT_CATEGORY_ID,LONG_DESC,
UNIT_NAME,CATEGORY_ACCOUNT,IS_VIEWABLE) values
(33,'Case Report Form',3,'Case Report Form',
'CRF Pages','9',1);

insert into "&1".cro_category(ID,SHORT_DESC,PARENT_CATEGORY_ID,LONG_DESC,
UNIT_NAME,CATEGORY_ACCOUNT,IS_VIEWABLE) values
(34,'Patient Diaries',3,'Patient Diaries',
'Patient Diaries','10',1);

insert into "&1".cro_category(ID,SHORT_DESC,PARENT_CATEGORY_ID,LONG_DESC,
UNIT_NAME,CATEGORY_ACCOUNT,IS_VIEWABLE) values
(35,'Evaluation Visits',4,'Evaluation Visits',
'Evaluation Visits','11',1);

insert into "&1".cro_category(ID,SHORT_DESC,PARENT_CATEGORY_ID,LONG_DESC,
UNIT_NAME,CATEGORY_ACCOUNT,IS_VIEWABLE) values
(36,'Phone Visits',4,'Phone Visits',
'Phone Visits','12',1);

insert into "&1".cro_category(ID,SHORT_DESC,PARENT_CATEGORY_ID,LONG_DESC,
UNIT_NAME,CATEGORY_ACCOUNT,IS_VIEWABLE) values
(37,'Negotiation Visits',4,'Negotiation Visits',
'Negotiation Visits','13',1);

insert into "&1".cro_category(ID,SHORT_DESC,PARENT_CATEGORY_ID,LONG_DESC,
UNIT_NAME,CATEGORY_ACCOUNT,IS_VIEWABLE) values
(38,'Project Management',10,'Project Management',
'Project Site Months','14',1);

insert into "&1".cro_category(ID,SHORT_DESC,PARENT_CATEGORY_ID,LONG_DESC,
UNIT_NAME,CATEGORY_ACCOUNT,IS_VIEWABLE) values
(39,'Project Mgmt Meetings',10,'Project Mgmt Meetings',
'Project Site Months','15',1);

insert into "&1".cro_category(ID,SHORT_DESC,PARENT_CATEGORY_ID,LONG_DESC,
UNIT_NAME,CATEGORY_ACCOUNT,IS_VIEWABLE) values
(40,'Meeting Time',27,'Meeting Time',
'Total Meeting Time','16',1);

insert into "&1".cro_category(ID,SHORT_DESC,PARENT_CATEGORY_ID,LONG_DESC,
UNIT_NAME,CATEGORY_ACCOUNT,IS_VIEWABLE) values
(41,'Travel Time',27,'Travel Time',
'Total Travel Time','17',1);

commit;         


update "&1".cro_category set unit_name='Country'  where category_account='A';
update "&1".cro_category set unit_name='Study Docs'  where category_account='C';
update "&1".cro_category set unit_name='Patient Docs'  where category_account='D';
update "&1".cro_category set unit_name='Study Prep'  where category_account='E';
update "&1".cro_category set unit_name='Inv Meetings'  where category_account='F';
update "&1".cro_category set unit_name='Initiation Days'  where category_account='G';
update "&1".cro_category set unit_name='Monitor Days'  where category_account='H';
update "&1".cro_category set unit_name='Close-out Days'  where category_account='I';
update "&1".cro_category set unit_name='Site Months'  where category_account='J';
update "&1".cro_category set unit_name='Project Months'  where category_account='K';
update "&1".cro_category set unit_name='CRF Pages'  where category_account='L';
update "&1".cro_category set unit_name='CRF Pages'  where category_account='M';
update "&1".cro_category set unit_name='Databases'  where category_account='N';
update "&1".cro_category set unit_name='Tables'  where category_account='O';
update "&1".cro_category set unit_name='Statistics'  where category_account='P';
update "&1".cro_category set unit_name='Reports'  where category_account='Q/R';
update "&1".cro_category set unit_name='Manuscripts'  where category_account='S';
update "&1".cro_category set unit_name='Reg Audits'  where category_account='T';
update "&1".cro_category set unit_name='Completed Pts'  where category_account='U';
update "&1".cro_category set unit_name='Study Months'  where category_account='B';
update "&1".cro_category set unit_name='Trainings'  where category_account='W';

commit;

alter table "&1".cro_category add category_seq number(2);

update  "&1".cro_category set category_seq =1 where category_account='A';
update  "&1".cro_category set category_seq =2 where category_account='C';
update  "&1".cro_category set category_seq =3 where category_account='D';
update  "&1".cro_category set category_seq =4 where category_account='E';
update  "&1".cro_category set category_seq =5 where category_account='F';
update  "&1".cro_category set category_seq =6 where category_account='W';
update  "&1".cro_category set category_seq =7 where category_account='G';
update  "&1".cro_category set category_seq =8 where category_account='H';
update  "&1".cro_category set category_seq =9 where category_account='I';
update  "&1".cro_category set category_seq =10 where category_account='J';
update  "&1".cro_category set category_seq =11 where category_account='B';
update  "&1".cro_category set category_seq =12 where category_account='K';
update  "&1".cro_category set category_seq =13 where category_account='L';
update  "&1".cro_category set category_seq =14 where category_account='M';
update  "&1".cro_category set category_seq =15 where category_account='N';
update  "&1".cro_category set category_seq =16 where category_account='O';
update  "&1".cro_category set category_seq =17 where category_account='P';
update  "&1".cro_category set category_seq =18 where category_account='Q/R';
update  "&1".cro_category set category_seq =19 where category_account='S';
update  "&1".cro_category set category_seq =20 where category_account='T';
update  "&1".cro_category set category_seq =21 where category_account='U';
COMMIT;


update "&1".cro_category set short_desc='Central Travel',Unit_name='Site Trip',
            Is_viewable=0 where category_account='X';
update "&1".cro_category set short_desc='Regional Travel',Unit_name='Site Trip',
            Is_viewable=0 where category_account='Y';

declare
maxid  number(10);
begin

select nvl(max(id),0)+1 into maxid from "&1".cro_category;
insert into "&1".cro_category (ID,SHORT_DESC,UNIT_NAME,CATEGORY_ACCOUNT,IS_VIEWABLE)
            values (maxid,'Local Travel','Site Trip','Z',0);
update "&1".id_control set next_id=maxid+1 where table_name='cro_category';
end;
/

commit;


update "&1".cro_category set is_loadable=is_viewable;
update "&1".cro_category set is_loadable=0 where category_account in ('X','Y','Z');

commit;

update "&1".cro_category set long_desc=replace(long_desc,chr(13));
commit;

