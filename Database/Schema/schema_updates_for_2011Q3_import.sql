
update currency set viewable_flg = 0 where id in (67,56,17,40,18);
Insert into currency(id,name,symbol,cnv_rate,viewable_flg,iso_4217)
values (235,'Eritrean Nakfa','ERN',15.1,0,'ERN');
update country set iso_4217='ERN' where abbreviation='ERI';
Update country set iso_4217='USD' where abbreviation='TLS';
commit;

--more updates:

update country set currency_id=235 where abbreviation='ERI' and id=173;
update country set currency_id=1 where abbreviation='TLS' and id=264;
update country set currency_id=10 where abbreviation='EST' and id=48;
update country set ISO_4217='EUR' where abbreviation='EST' and id=48;
insert into local_to_euro values (17,48,15.6466);
Update odc_def set obsolete_flg=0, obsolete_build_tag_id=null where
picas_code in ('*INDR','*IRBF','*TRAN','*LABF','*PSET','*PMTN','*PCLO');
commit;

--*********************************************
--Deployed upto this in Devl, Q003, Prod, Demo
--**********************************************