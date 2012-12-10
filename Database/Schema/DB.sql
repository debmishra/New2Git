
--As per Phil's request on 08/12/2009
UPDATE country SET name='Australia' WHERE name='Australia, New Zealand';
UPDATE country SET name='India' WHERE name='India, Pakistan' and abbreviation='IND';
UPDATE country SET name='Serbia' WHERE name='Serbia and Montenegro';

update country set abbreviation='AB2' where id=122;
update country set abbreviation='AB3' where id=123;
update country set abbreviation='AB4' where id=124;
update country set abbreviation='AB5' where id=125;
update country set abbreviation='AB6' where id=126;
update country set abbreviation='AB7' where id=127;
--Implemented upto this in DEVL, D002 and D003 on 08/12/2009 


UPDATE country SET abbreviation='GHA' where name='Ghana';
UPDATE country SET abbreviation='SA' WHERE name='South America';
UPDATE country SET abbreviation='ME' WHERE name='Middle East';
UPDATE country SET abbreviation='GBL' WHERE name='Global';
UPDATE country SET abbreviation='CA' WHERE name='Central America';
UPDATE country SET abbreviation='AFR' WHERE name='Africa';
commit;
/***********************************************************/
--In DEMO on 10/07/2009 after discussion due to issues with
--2009Q4 45master dataload.
/***********************************************************/
-----------------------------
------AFTER RUN IN DEMO -----
-----------------------------



--As per Kelly's request on 09/16/2009
create or replace PROCEDURE insert_into_uom(ClientDivId IN NUMBER) AS
   v_translation_id NUMBER(10);
   v_uom_id NUMBER(10);
   v_parent_oid VARCHAR2(50);
CURSOR c IS SELECT * from tspd_unit_of_measure;
BEGIN
 EXECUTE IMMEDIATE 'ALTER TABLE unit_of_measure disable constraint UNIT_OF_MEASURE_FK2';
  FOR c1 in C LOOP
  SELECT increment_sequence('translated_text_seq') INTO v_translation_id FROM DUAL;
  INSERT INTO translated_text
  VALUES( v_translation_id,c1.short_desc, 'unit_of_measure',
          'en','US', c1.short_desc,ClientDivId,0);

--  SELECT short_desc INTO v_parent_oid FROM tspd_unit_of_measure
 -- WHERE id=c1.parent_uom_id;

  INSERT INTO unit_of_measure
  VALUES(increment_sequence('unit_of_measure_seq'),
         c1.short_desc, c1.long_desc, c1.obsolete_flg,
         1,1,0,0,c1.parent_uom_id, null,
         v_translation_id,ClientDivId,c1.id,null,null,null);
  END LOOP;

UPDATE unit_of_measure a
SET a.parent_oid=(SELECT b.short_desc FROM tspd_unit_of_measure b
              WHERE b.parent_uom_id=a.parent_id
              AND b.id = a.tspd_uom_id)
WHERE a.client_div_id=ClientDivId;

UPDATE unit_of_measure a
SET a.parent_id=(SELECT b.id FROM unit_of_measure b
                 WHERE b.tspd_uom_id=a.parent_id
                 AND b.client_div_id=ClientDivId)
WHERE a.client_div_id=ClientDivId;

UPDATE unit_of_measure SET oid=REPLACE(oid,' ','_')
WHERE oid LIKE '% %'
AND client_div_id=ClientDivId;

UPDATE unit_of_measure SET parent_oid=REPLACE(parent_oid,' ','_')
WHERE parent_oid LIKE '% %'
AND client_div_id=ClientDivId;

update unit_of_measure set oid = 'None_Item' where oid = 'None' and parent_oid = 'None';

EXECUTE IMMEDIATE 'ALTER TABLE unit_of_measure enable constraint UNIT_OF_MEASURE_FK2';

INSERT INTO unit_of_measure(id,oid,long_desc,short_desc,client_div_id,CONSTANT_A,CONSTANT_B,CONSTANT_C,CONSTANT_K) 
VALUES(increment_sequence('unit_of_measure_seq'),'Rave','Rave','Rave',ClientDivId,1,1,0,0);

END;
/
--******************************************************
--Implemented upto this in devl,d002,d003 on 09/16/2009 
--Implemented upto this in q002 on 09/17/2009 
--Implemented upto this in q003 on 09/18/2009 
--******************************************************

------------------------------------------------
----------  Addendum on 09/23/2009 -------------
------------------------------------------------
--As per Larry's request on 09/10/2009
ALTER TABLE tspd_document DROP CONSTRAINT td_snapshot_type_check;

ALTER TABLE tspd_document ADD CONSTRAINT td_snapshot_type_check 
CHECK (snapshot_type in ('WorkingCopy','ReviewCopy','FinalVersion','ConflictVersion','AuthorChange','DocTypeChange','Baseline','TrackChanges','Restored','Corrupted','Export','Corrotto'));

----DG---
--As per Larry's request on 09/14/2009
ALTER TABLE UNIT_OF_MEASURE add(SHORT_DESC VARCHAR2(50));
--Implemented upto this in devl,d002,d003 on 09/14/2009 


--***********************************************************
--Implemented upto this in devl,d002,d003 on 09/10/09
--Implemented upto this in q002 on 09/11/09
--Implemented upto this in q003 on 09/18/2009
--***********************************************************

--As per request on 09/21/2009
ALTER TABLE tspd_unit_of_measure ADD(oid varchar2(50));

update tspd_unit_of_measure set oid='PRU' where short_desc='PRU' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Density' where short_desc='Density' and parent_uom_id is null;
update tspd_unit_of_measure set oid='kg_m3' where short_desc='kg/m³' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='kgm3_1000' where short_desc='(kg/m³)/1000' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='U_ug' where short_desc='U/µg' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='U_mg' where short_desc='U/mg' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='U_g' where short_desc='U/g' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='U_uL' where short_desc='U/µL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='U_mL' where short_desc='U/mL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='U_dL' where short_desc='U/dL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='U_L' where short_desc='U/L' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='IU_ug' where short_desc='IU/µg' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='IU_mg' where short_desc='IU/mg' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='IU_g' where short_desc='IU/g' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='IU_uL' where short_desc='IU/µL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='IU_mL' where short_desc='IU/mL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='IU_dL' where short_desc='IU/dL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='IU_L' where short_desc='IU/L' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='T-score' where short_desc='T-score' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Z-score' where short_desc='Z-score' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='U_mm3' where short_desc='U/mm³' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='U_HPF' where short_desc='U/HPF' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='U_LPF' where short_desc='U/LPF' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Concentration' where short_desc='Concentration' and parent_uom_id is null;
update tspd_unit_of_measure set oid='ug_mL' where short_desc='µg/mL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='ug_dL' where short_desc='µg/dL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mg_mL' where short_desc='mg/mL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mg_dL' where short_desc='mg/dL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mg_L' where short_desc='mg/L' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='g_dL' where short_desc='g/dL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='g_L' where short_desc='g/L' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='ppm' where short_desc='ppm' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='ppb' where short_desc='ppb' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='M_L' where short_desc='M/L' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='M_kg' where short_desc='M/kg' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mmol_L' where short_desc='mmol/L' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mEq_L' where short_desc='mEq/L' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='ng_mL' where short_desc='ng/mL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='ng_dL' where short_desc='ng/dL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='nmol_L' where short_desc='nmol/L' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='pg_mL' where short_desc='pg/mL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='pg_dL' where short_desc='pg/dL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='pmol_L' where short_desc='pmol/L' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Misc' where short_desc='Misc' and parent_uom_id is null;
update tspd_unit_of_measure set oid='PR' where short_desc='PR' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mm_Hg' where short_desc='mm/Hg' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='perc' where short_desc='%' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Units' where short_desc='Units' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='IU' where short_desc='IU' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='pH' where short_desc='pH' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='USP' where short_desc='U.S.P.' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Light' where short_desc='Light' and parent_uom_id is null;
update tspd_unit_of_measure set oid='Motion' where short_desc='Motion' and parent_uom_id is null;
update tspd_unit_of_measure set oid='Energy_Power' where short_desc='Energy and Power' and parent_uom_id is null;
update tspd_unit_of_measure set oid='cal' where short_desc='cal' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='kcal' where short_desc='kcal' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Acoustics' where short_desc='Acoustics' and parent_uom_id is null;
update tspd_unit_of_measure set oid='dB' where short_desc='dB' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='phon' where short_desc='phon' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Radiation' where short_desc='Radiation' and parent_uom_id is null;
update tspd_unit_of_measure set oid='rad' where short_desc='rad' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mGy' where short_desc='mGy' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mrem' where short_desc='mrem' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Curie' where short_desc='Curie' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='None' where short_desc='None' and parent_uom_id is null;
update tspd_unit_of_measure set oid='None' where short_desc='None' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Other' where short_desc='Other' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Temperature' where short_desc='Temperature' and parent_uom_id is null;
update tspd_unit_of_measure set oid='F' where short_desc='°F' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='C' where short_desc='°C' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='K' where short_desc='°K' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Weight' where short_desc='Weight' and parent_uom_id is null;
update tspd_unit_of_measure set oid='kg' where short_desc='kg' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='g' where short_desc='g' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mg' where short_desc='mg' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='ug' where short_desc='µg' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='oz' where short_desc='oz' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='lb' where short_desc='lb' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='ng' where short_desc='ng' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Dimension' where short_desc='Dimension' and parent_uom_id is null;
update tspd_unit_of_measure set oid='nm' where short_desc='nm' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='nm2' where short_desc='nm²' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mm' where short_desc='mm' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mm2' where short_desc='mm²' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='cm' where short_desc='cm' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='cm2' where short_desc='cm²' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='m' where short_desc='m' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='m2' where short_desc='m²' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='inches' where short_desc='inches' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='inches2' where short_desc='inches²' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='Liquid_Flow' where short_desc='Liquid and Flow' and parent_uom_id is null;
update tspd_unit_of_measure set oid='uL' where short_desc='µL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mL' where short_desc='mL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='dL' where short_desc='dL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='L' where short_desc='L' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='uL_min' where short_desc='µL/min' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mL_min' where short_desc='mL/min' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mL_hour' where short_desc='mL/hour' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='uL_min_kg' where short_desc='µL/min/kg' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mL_min_kg' where short_desc='mL/min/kg' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mL_hour_kg' where short_desc='mL/hour/kg' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='g_mL_hour' where short_desc='g/mL/hour' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='mg_mL_hour' where short_desc='mg/mL/hour' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='ug_mL_hr' where short_desc='µg/mL/hr' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='ng_mL_hr' where short_desc='ng/mL/hr' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='pL' where short_desc='pL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='fL' where short_desc='fL' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='kg_m2' where short_desc='kg/m2' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='years' where short_desc='years' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='ddmmmyyy' where short_desc='dd mmm yyy' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='per_minute' where short_desc='per minute' and parent_uom_id is not null;
update tspd_unit_of_measure set oid='24_hr_clock' where short_desc='24 hr clock' and parent_uom_id is not null;
commit;

CREATE OR REPLACE PROCEDURE insert_into_uom(ClientDivId IN NUMBER) AS
   v_translation_id NUMBER(10);
   v_uom_id NUMBER(10);
   v_parent_oid VARCHAR2(50);
   v_none_id number(10);
   v_none_oid varchar2(50);
   CURSOR c1 IS SELECT * from tspd_unit_of_measure a where a.parent_uom_id is null and trim(lower(a.short_desc)) <> 'other'
                and not exists (select 1 from unit_of_measure b where b.tspd_uom_id=a.id and b.client_div_id=ClientDivId)  ;

   cursor c3 is select id,uom_id from TSPD_study_variable where client_div_id=ClientDivId 
                and uom_id in (select id from tspd_unit_of_measure);

begin

-- Start the outer loop for parent rows

   for ix1 in c1 loop

       	SELECT increment_sequence('translated_text_seq') INTO v_translation_id FROM DUAL;
 	INSERT INTO translated_text (ID,ITEM_OID,OWNER_TABLE,LANGUAGE,REGION,TEXT,CLIENT_DIV_ID,DELETED)        
  		VALUES( v_translation_id,ix1.oid, 'unit_of_measure',
          	'en',null, ix1.short_desc,ClientDivId,0);
     
        SELECT increment_sequence('unit_of_measure_seq') INTO v_uom_id FROM DUAL;
	INSERT INTO unit_of_measure(ID,OID,LONG_DESC,DELETED,CONSTANT_A,CONSTANT_B,CONSTANT_C,
		CONSTANT_K,PARENT_ID,PARENT_OID,TRANSLATION_TEXT_ID,CLIENT_DIV_ID,TSPD_UOM_ID,
		STANDARD_OID,STANDARD_ID,SHORT_DESC) VALUES (v_uom_id,ix1.oid,ix1.long_desc, 
		ix1.obsolete_flg,1,1,0,0,null, null,v_translation_id,ClientDivId,ix1.id,null,
		null,ix1.short_desc);

     declare
         cursor c2 is select * from tspd_unit_of_measure where parent_uom_id = ix1.id and trim(lower(short_desc)) <> 'other';

     begin

-- Start the inner loop for child rows for a given parent from outer loop

        for ix2 in c2 loop

       		SELECT increment_sequence('translated_text_seq') INTO v_translation_id FROM DUAL;
 		INSERT INTO translated_text (ID,ITEM_OID,OWNER_TABLE,LANGUAGE,REGION,TEXT,CLIENT_DIV_ID,DELETED)        
  			VALUES( v_translation_id,ix2.oid, 'unit_of_measure','en',null, ix2.short_desc,ClientDivId,0);     

		INSERT INTO unit_of_measure(ID,OID,LONG_DESC,DELETED,CONSTANT_A,CONSTANT_B,CONSTANT_C,
			CONSTANT_K,PARENT_ID,PARENT_OID,TRANSLATION_TEXT_ID,CLIENT_DIV_ID,TSPD_UOM_ID,
			STANDARD_OID,STANDARD_ID,SHORT_DESC) select increment_sequence('unit_of_measure_seq'),
			ix2.oid,ix2.long_desc,ix2.obsolete_flg,1,1,0,0,v_uom_id,ix1.oid,v_translation_id,
			ClientDivId,ix2.id,null,null,ix2.short_desc from dual;
       end loop;
     end;
   end loop;

-- Insert "OTHER" row with None as Parent

 select id,oid into v_none_id,v_none_oid from unit_of_measure where client_div_id=ClientDivId and parent_id is null 
   	and trim(lower(short_desc))='none';

 SELECT increment_sequence('translated_text_seq') INTO v_translation_id FROM DUAL;
 INSERT INTO translated_text (ID,ITEM_OID,OWNER_TABLE,LANGUAGE,REGION,TEXT,CLIENT_DIV_ID,DELETED)        
  	VALUES( v_translation_id,'Other', 'unit_of_measure','en',null,'Other',ClientDivId,0);     

 INSERT INTO unit_of_measure(ID,OID,LONG_DESC,DELETED,CONSTANT_A,CONSTANT_B,CONSTANT_C,
	CONSTANT_K,PARENT_ID,PARENT_OID,TRANSLATION_TEXT_ID,CLIENT_DIV_ID,TSPD_UOM_ID,
	STANDARD_OID,STANDARD_ID,SHORT_DESC) select increment_sequence('unit_of_measure_seq'),
	'Other','Other',0,1,1,0,0,v_none_id,v_none_oid,v_translation_id,
	ClientDivId,null,null,null,'Other' from dual;

-- Insert special "RAVE" row

 SELECT increment_sequence('translated_text_seq') INTO v_translation_id FROM DUAL;
 INSERT INTO translated_text (ID,ITEM_OID,OWNER_TABLE,LANGUAGE,REGION,TEXT,CLIENT_DIV_ID,DELETED)        
  	VALUES( v_translation_id,'Rave', 'unit_of_measure','en',null,'Rave',ClientDivId,0);     

 INSERT INTO unit_of_measure(ID,OID,LONG_DESC,DELETED,CONSTANT_A,CONSTANT_B,CONSTANT_C,
	CONSTANT_K,PARENT_ID,PARENT_OID,TRANSLATION_TEXT_ID,CLIENT_DIV_ID,TSPD_UOM_ID,
	STANDARD_OID,STANDARD_ID,SHORT_DESC) select increment_sequence('unit_of_measure_seq'),
	'Rave','Rave',0,1,1,0,0,null,null,v_translation_id,
	ClientDivId,null,null,null,'Rave' from dual;

-- Update the None child to None_item

 select id into v_uom_id from unit_of_measure where client_div_id=ClientDivId and 
        trim(lower(short_desc))='none' and Parent_id is not null;
 update unit_of_measure set oid='None_Item', short_desc='None_Item', long_desc='None_Item' where id=v_uom_id;

-- update tspd_study_variable for new uom_id's if any

  for ix3 in c3 loop      
	update tspd_study_variable a set (a.UOM_ID,a.UOM_SHORT_DESC) = (select b.id,b.oid from unit_of_measure b 
	where b.tspd_uom_id=ix3.uom_id and b.client_div_id=ClientDivId) where a.id=ix3.id;
  end loop;
end;
/
sho err;

--Implemented upto this in devl on 09/21/2009
--Implemented upto this in q002 on 09/21/2009
--Implemented upto this in d002,d003 on 09/23/2009
--Implemented upto this in q003 on 09/23/2009

Create or replace trigger tspd_study_variable_trg1
before insert or update of uom_id on tspd_study_variable
referencing new as n old as o
for each row
declare

v_exists number(2);
invalid_uom exception;

begin
 
 if :n.uom_id is not null then
  select count(*) into v_exists from tspd_unit_of_measure where id=:n.uom_id;

  if v_exists <> 1 then
       select count(*) into v_exists from unit_of_measure where client_div_id=:n.client_div_id
       and id=:n.uom_id;
    if v_exists <> 1 then
 raise invalid_uom;
    end if;
  end if;
 end if; 
exception

   when invalid_uom then
 Raise_application_error(-20502,'Invalid UOM_ID. Please contact support');
end;
/
sho err;

--Implemented upto this in devl on 09/23/2009
--Implemented upto this in q002 on 09/23/2009
--Implemented upto this in d002,d003 on 09/23/2009
--Implemented upto this in q003 on 09/23/2009
