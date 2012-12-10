--Only if indmap has two records for 585.4 delete the one with TYPE='Indication'.
--delete from indmap where id=1507 and code='585.4';

update indmap set Type='Indication' where code='585.4';
update indmap set parent_indmap_id=(select id from indmap where code='NEPHRITIS')
WHERE code='585.4';

commit;

ALTER TABLE REFERENCE_PRICES modify(INTL_CODE varchar2(15));

--DELETE FROM region 
--WHERE name IN ('Not Given','Entered In Error','Armed Forces Pacific');

DELETE FROM institution WHERE region_id in (select id from region 
      where name in ('Not Given','Entered In Error','Armed Forces Europe','Armed Forces Pacific','Guam'));

DELETE FROM region 
WHERE name IN ('Not Given','Entered In Error','Armed Forces Europe','Armed Forces Pacific','Guam');


select region_id FROM institution WHERE region_id in (select id from region 
      where name in ('Not Given','Entered In Error','Armed Forces Europe','Armed Forces Pacific','Guam'));
commit;

