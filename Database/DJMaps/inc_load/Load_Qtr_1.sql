--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: Load_Qtr_1.sql$ 
--
-- $Revision: 4$        $Date: 4/15/2011 3:48:19 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

spool c:\mahesh\load_45master\Load_Qtr_1_demo.log
set timing on;

select 'START TIME ---'||to_char(sysdate,'DD-MON-YYYY HH24:MI:SS') from dual;
truncate table temp_procedure;
truncate table temp_odc;
truncate table temp_overhead;
truncate table temp_ip_study_price;
truncate table temp_inst_to_company;

declare
  maxid number(10);
  num_exists number(10);
  begin
   select nvl(max(id),0)+1 into maxid from build_tag;
    Insert into build_tag values (maxid,'01-APR-2011','2011Q2');
  commit;
end;
/


sho err

------CURRENCY-----
select 'currency' from dual;

--update currency a set (a.name,a.symbol,a.cnv_rate)=(select b.name,b.symbol,b.cnv_rate from currency@db_link b where a.id=b.id);

--insert into currency select * from currency@db_link b
--where not exists (select 1 from currency a where b.id=a.id);

update currency a set (a.cnv_rate)=(select b.cnv_rate from currency@db_link b where a.id=b.id);

------COUNTRY-----
--select 'country' from dual;

--update country a set a.name=(select b.name from country@db_link b where a.id=b.id);

--insert into country select * from country@db_link b 
--where not exists (select 1 from country a where b.id=a.id);

------BUILD CODE-----
select 'build_code' from dual;

update build_code a set a.name=(select b.name from build_code@db_link b where a.id=b.id);

insert into build_code select * from build_code@db_link b 
where not exists (select 1 from build_code a where b.id=a.id);


------INDMAP-----
select 'indmap' from dual;

update indmap a set a.short_desc=(select b.short_desc from indmap@db_link b where a.id=b.id);

insert into indmap select * from indmap@db_link b 
where not exists (select 1 from indmap a where b.id=a.id);

------AFFILIATION_FACTOR-----
SELECT 'affiliation_factor' FROM dual;

UPDATE affiliation_factor a 
SET (a.affiliated_factor,a.unaffiliated_factor)=(SELECT b.affiliated_factor,b.unaffiliated_factor 
                                                 FROM affiliation_factor@db_link b 
                                                 WHERE a.id=b.id);

INSERT INTO affiliation_factor SELECT * FROM affiliation_factor@db_link b 
WHERE NOT EXISTS (SELECT 1 FROM affiliation_factor a WHERE b.id=a.id);

------IP_DURATION_FACTOR-----
SELECT 'ip_duration_factor' FROM dual;

UPDATE ip_duration_factor a 
SET (a.PHASE2_FACTOR,a.PHASE3_FACTOR,
     a.Y3PHASE2_FACTOR,a.Y3PHASE3_FACTOR)=(SELECT b.PHASE2_FACTOR,b.PHASE3_FACTOR,
                                                  b.Y3PHASE2_FACTOR,b.Y3PHASE3_FACTOR 
                                           FROM ip_duration_factor@db_link b 
                                           WHERE a.id=b.id);

INSERT INTO ip_duration_factor SELECT * FROM ip_duration_factor@db_link b 
WHERE NOT EXISTS (SELECT 1 FROM ip_duration_factor a WHERE b.id=a.id);


------IP_WEIGHT-----
SELECT 'ip_weight' FROM dual;

UPDATE ip_weight a 
SET (a.complex_minvalue, a.factor, a.minvalue)=(SELECT b.complex_minvalue, b.factor, b.minvalue 
                                                 FROM ip_weight@db_link b 
                                                 WHERE a.id=b.id);

INSERT INTO ip_weight SELECT * FROM ip_weight@db_link b 
WHERE NOT EXISTS (SELECT 1 FROM ip_weight a WHERE b.id=a.id);

------IP_CPP-----
SELECT 'ip_cpp' FROM dual;

UPDATE ip_cpp a 
SET (a.LOW,a.MID,a.HIGH,a.SLOPE,a.INTERCEPT,a.CLOW,a.CMID,a.CHIGH,a.CSLOPE,
     a.CINTERCEPT,a.OLOW,a.OMID,a.OHIGH,a.OSLOPE,a.OINTERCEPT,a.cpv)=(SELECT          b.LOW,b.MID,b.HIGH,b.SLOPE,b.INTERCEPT,b.CLOW,b.CMID,b.CHIGH,b.CSLOPE,
         b.CINTERCEPT,b.OLOW,b.OMID,b.OHIGH,b.OSLOPE,b.OINTERCEPT,b.cpv 
                                           FROM ip_cpp@db_link b 
                                           WHERE a.id=b.id);

INSERT INTO ip_cpp SELECT * FROM ip_cpp@db_link b 
WHERE NOT EXISTS (SELECT 1 FROM ip_cpp a WHERE b.id=a.id);

------IP_DURATION-----
SELECT 'ip_duration' FROM dual;

UPDATE ip_duration a 
SET (a.LOW1YEAR,a.MID1YEAR,a.HIGH1YEAR,a.LOW2YEAR,
     a.MID2YEAR,a.HIGH2YEAR,a.LOW3YEAR,a.MID3YEAR,a.HIGH3YEAR)=(SELECT                                   b.LOW1YEAR,b.MID1YEAR,b.HIGH1YEAR,b.LOW2YEAR,b.MID2YEAR,
                         b.HIGH2YEAR,b.LOW3YEAR,b.MID3YEAR,b.HIGH3YEAR          
                                           FROM ip_duration@db_link b 
                                           WHERE a.id=b.id);

INSERT INTO ip_duration SELECT * FROM ip_duration@db_link b 
WHERE NOT EXISTS (SELECT 1 FROM ip_duration a WHERE b.id=a.id);

------IP_BUSINESS_FACTORS-----
SELECT 'ip_business_factors' FROM dual;

UPDATE ip_business_factors a 
SET (a.id,a.ibf_order,a.factor,a.low,a.med,a.high,a.num_days)=(SELECT b.id,b.ibf_order,b.factor,b.low,b.med,b.high,b.num_days          
                                           FROM ip_business_factors@db_link b 
                                           WHERE a.id=b.id);

INSERT INTO ip_business_factors SELECT * FROM ip_business_factors@db_link b 
WHERE NOT EXISTS (SELECT 1 FROM ip_business_factors a WHERE b.id=a.id);

------REGION-----
SELECT 'region' FROM dual;

UPDATE region a 
SET (a.name,a.factor)=(SELECT b.name,b.factor 
                       FROM region@db_link b 
                       WHERE a.id=b.id)
WHERE EXISTS (SELECT 1 FROM region@db_link c WHERE c.id=a.id);

INSERT INTO region SELECT * FROM region@db_link b 
WHERE NOT EXISTS (SELECT 1 FROM region a WHERE b.id=a.id);

------INSTITUTION-----
SELECT 'institution' FROM dual;

UPDATE institution a 
SET (a.NAME,a.ZIP_CODE,a.ABBREVIATION,a.INSTADDR1,      
	 a.INSTADDR2,a.INSTADDR3,a.AFFILIATION,a.CITY,a.COUNTY,a.COMMENTS,a.FAX,a.PHONE,          
	 a.POBOX,a.PROV_TERR,a.QUERIABLE,a.TIMESUSED,a.BURDEN_PCT,a.COUNTRY_ID)=(SELECT b.NAME,b.ZIP_CODE,b.ABBREVIATION,b.INSTADDR1,      
	 b.INSTADDR2,b.INSTADDR3,b.AFFILIATION,b.CITY,b.COUNTY,b.COMMENTS,b.FAX,b.PHONE,          
	 b.POBOX,b.PROV_TERR,b.QUERIABLE,b.TIMESUSED,b.BURDEN_PCT,b.COUNTRY_ID          
                                           FROM institution@db_link b 
                                           WHERE a.id=b.id)
WHERE EXISTS (SELECT 1 FROM institution@db_link c WHERE c.id=a.id);

INSERT INTO institution SELECT * FROM institution@db_link b 
WHERE NOT EXISTS (SELECT 1 FROM institution a WHERE b.id=a.id);


------PROCEDURE_DEF-----
SELECT 'procedure_def' FROM dual;

UPDATE procedure_def a 
SET (a.long_desc,a.procedure_level,a.hide,a.short_desc,
     a.obsolete_flg,a.obsolete_build_tag_id,a.complexity_val)=(SELECT b.long_desc,b.procedure_level,b.hide,
                                                    b.short_desc,b.obsolete_flg, b.obsolete_build_tag_id-1, b.complexity_val           
                                           FROM procedure_def@db_link b 
                                           WHERE a.id=b.id);

INSERT INTO procedure_def(ID,CPT_CODE,LONG_DESC,OBSOLETE_FLG,PROCEDURE_LEVEL,OBSOLETE_BUILD_TAG_ID,ADDED_BUILD_TAG_ID,
                          HIDE,FOXPRO_FLG,SHORT_DESC,USAGE_RANK,COMPLEXITY_VAL) 
SELECT ID,CPT_CODE,LONG_DESC,OBSOLETE_FLG,PROCEDURE_LEVEL,OBSOLETE_BUILD_TAG_ID-1, ADDED_BUILD_TAG_ID-1,  
             HIDE,FOXPRO_FLG,SHORT_DESC,USAGE_RANK,COMPLEXITY_VAL 
FROM procedure_def@db_link b 
WHERE NOT EXISTS (SELECT 1 FROM procedure_def a WHERE b.id=a.id);

------ODC_DEF-----
SELECT 'odc_def' FROM dual;

UPDATE odc_def a 
SET (a.long_desc,a.procedure_level,a.hide,a.short_desc,
     a.obsolete_flg,a.obsolete_build_tag_id)=(SELECT b.long_desc,b.procedure_level,b.hide,b.short_desc,
                                                     b.obsolete_flg,b.obsolete_build_tag_id-1          
                                              FROM odc_def@db_link b 
                                              WHERE a.id=b.id);

INSERT INTO odc_def(ID,PICAS_CODE,LONG_DESC,OBSOLETE_FLG,PROCEDURE_LEVEL,        
       HIDE,OBSOLETE_BUILD_TAG_ID,ADDED_BUILD_TAG_ID,FOXPRO_FLG,SHORT_DESC)
SELECT ID,PICAS_CODE,LONG_DESC,OBSOLETE_FLG,PROCEDURE_LEVEL,        
       HIDE,OBSOLETE_BUILD_TAG_ID-1,ADDED_BUILD_TAG_ID-1,FOXPRO_FLG,SHORT_DESC 
FROM odc_def@db_link b 
WHERE NOT EXISTS (SELECT 1 FROM odc_def a WHERE b.id=a.id);

------MAPPER-----
SELECT 'mapper' FROM dual;

ALTER TABLE own_procedure DISABLE CONSTRAINT OWN_PROCEDURE_FK3;
ALTER TABLE own_odc DISABLE CONSTRAINT OWN_odc_FK3;

DELETE FROM mapper;

INSERT INTO mapper SELECT * FROM mapper@db_link;

ALTER TABLE own_procedure ENABLE CONSTRAINT OWN_PROCEDURE_FK3;
ALTER TABLE own_odc ENABLE CONSTRAINT OWN_odc_FK3;

------pap_odc_pct-----
SELECT 'pap_odc_pct' FROM dual;

UPDATE pap_odc_pct a 
SET (a.BASE_PCT,a.AFFILIATED_PCT,a.UNAFFILIATED_PCT,       
        a.AFF_UNAFF_PCT,a.PHASE_ONE_PCT,a.PHASE_TWOTHREE_PCT,a.PHASE_FOUR_PCT,         
        a.PHASE_ALL_PCT)=(SELECT b.BASE_PCT,b.AFFILIATED_PCT,b.UNAFFILIATED_PCT,       
        b.AFF_UNAFF_PCT,b.PHASE_ONE_PCT,b.PHASE_TWOTHREE_PCT,b.PHASE_FOUR_PCT,         
        b.PHASE_ALL_PCT FROM pap_odc_pct@db_link b WHERE a.id=b.id);

INSERT INTO pap_odc_pct SELECT * FROM pap_odc_pct@db_link b 
WHERE NOT EXISTS (SELECT 1 FROM pap_odc_pct a WHERE b.id=a.id);

UPDATE pap_odc_pct_to_indmap a 
SET a.indmap_pct=(SELECT b.indmap_pct 
                  FROM pap_odc_pct_to_indmap@db_link b WHERE a.id=b.id);

INSERT INTO pap_odc_pct_to_indmap SELECT * FROM pap_odc_pct_to_indmap@db_link b
WHERE NOT EXISTS (SELECT 1 FROM pap_odc_pct_to_indmap a WHERE b.id=a.id);

------PAP_EURO_OVERHEAD-----
SELECT 'pap_euro_overhead' FROM dual;

UPDATE pap_euro_overhead a 
SET (a.pct25,a.pct50,a.pct75)=(SELECT b.pct25,b.pct50,b.pct75 
                       FROM pap_euro_overhead@db_link b 
                       WHERE a.id=b.id);

INSERT INTO pap_euro_overhead SELECT * FROM pap_euro_overhead@db_link b 
WHERE NOT EXISTS (SELECT 1 FROM pap_euro_overhead a WHERE b.id=a.id);

------ADD_STUDY-----
SELECT 'add_study' FROM dual;

TRUNCATE TABLE add_study;

INSERT INTO add_study SELECT * FROM add_study@db_link;

------PROTOCOL-----
SELECT 'protocol' FROM dual;

TRUNCATE TABLE payments;
TRUNCATE TABLE procedure_to_protocol;
TRUNCATE TABLE protocol_to_indmap;

ALTER TABLE payments DISABLE CONSTRAINT payments_fk1;
TRUNCATE TABLE investig;
ALTER TABLE payments ENABLE CONSTRAINT payments_fk1;

UPDATE protocol a SET (a.COUNTRY_ID,a.DE_INTERNAL_ID,a.COMMENTS,                       
        a.PHASE_ID,a.PHASE1TYPE_ID,a.DOSING,a.INPATIENT_STATUS,a.AGE_RANGE,a.INPATIENT_DAYS,a.TOTAL_CONFINEMENT,                         a.HOURS_CONFINED,a.ADMIN_ROUTE,a.TOTAL_VISIT,a.STUDY_TYPE,
        a.STUDY_BLIND_TYPE,a.DURATION,a.DURATION_UNIT,a.CENTRAL_LAB_USED,a.ENTRY_DATE,
        a.ACTIVE_FLAG,a.COMPLETED_PATIENTS,a.RANDOMIZED_FLAG,a.TREATMENT_CYCLE_CNT,
        a.STUDY_STRUCT_TYPE,a.NUM_TREATMENTS,a.SCREEN_DAYS,
        a.GROUP1_PRETREAT_DAYS,a.GROUP1_TREAT_DAYS,a.GROUP1_POST_TREAT_DAYS,
        a.GROUP2_TREAT_DAYS,a.GROUP2_POST_TREAT_DAYS,
        a.GROUP3_TREAT_DAYS,a.GROUP3_POST_TREAT_DAYS,
        a.GROUP4_TREAT_DAYS,a.GROUP4_POST_TREAT_DAYS,a.GROUP5_TREAT_DAYS,
        a.GROUP5_POST_TREAT_DAYS,a.GROUP6_TREAT_DAYS,a.GROUP6_POST_TREAT_DAYS,
        a.GROUP7_TREAT_DAYS,a.GROUP7_POST_TREAT_DAYS,a.GROUP8_TREAT_DAYS,
        a.GROUP8_POST_TREAT_DAYS,a.GROUP9_TREAT_DAYS,a.GROUP9_POST_TREAT_DAYS,
        a.GROUPA_TREAT_DAYS,a.GROUPA_POST_TREAT_DAYS,a.GROUP1_EXTENSION_EXISTS,
        a.GROUP2_EXTENSION_EXISTS,a.GROUP3_EXTENSION_EXISTS,a.GROUP4_EXTENSION_EXISTS,
        a.GROUP5_EXTENSION_EXISTS,a.GROUP6_EXTENSION_EXISTS,a.GROUP7_EXTENSION_EXISTS,
        a.GROUP8_EXTENSION_EXISTS,a.GROUP9_EXTENSION_EXISTS,a.GROUPA_EXTENSION_EXISTS,
        a.CENT_LAB_CONTRACT_EXISTS,a.CRO_LAB_CONTRACT_EXISTS,a.CENT_LAB_PRICE_MODEL,
        a.EXTENSION_EXISTS,a.TREATMENT_CONTROL,a.DRUG,a.TITLE,a.COMPLEXITY_VAL)=(SELECT b.COUNTRY_ID,         b.DE_INTERNAL_ID,b.COMMENTS,
        b.PHASE_ID,b.PHASE1TYPE_ID,b.DOSING,b.INPATIENT_STATUS,b.AGE_RANGE,b.INPATIENT_DAYS,
        b.TOTAL_CONFINEMENT,b.HOURS_CONFINED,b.ADMIN_ROUTE,b.TOTAL_VISIT,b.STUDY_TYPE,
        b.STUDY_BLIND_TYPE,b.DURATION,b.DURATION_UNIT,b.CENTRAL_LAB_USED,b.ENTRY_DATE,
        b.ACTIVE_FLAG,b.COMPLETED_PATIENTS,b.RANDOMIZED_FLAG,b.TREATMENT_CYCLE_CNT,
        b.STUDY_STRUCT_TYPE,b.NUM_TREATMENTS,b.SCREEN_DAYS,
        b.GROUP1_PRETREAT_DAYS,b.GROUP1_TREAT_DAYS,b.GROUP1_POST_TREAT_DAYS,
        b.GROUP2_TREAT_DAYS,b.GROUP2_POST_TREAT_DAYS,
        b.GROUP3_TREAT_DAYS,b.GROUP3_POST_TREAT_DAYS,
        b.GROUP4_TREAT_DAYS,b.GROUP4_POST_TREAT_DAYS,b.GROUP5_TREAT_DAYS,
        b.GROUP5_POST_TREAT_DAYS,b.GROUP6_TREAT_DAYS,b.GROUP6_POST_TREAT_DAYS,
        b.GROUP7_TREAT_DAYS,b.GROUP7_POST_TREAT_DAYS,b.GROUP8_TREAT_DAYS,
        b.GROUP8_POST_TREAT_DAYS,b.GROUP9_TREAT_DAYS,b.GROUP9_POST_TREAT_DAYS,
        b.GROUPA_TREAT_DAYS,b.GROUPA_POST_TREAT_DAYS,b.GROUP1_EXTENSION_EXISTS,
        b.GROUP2_EXTENSION_EXISTS,b.GROUP3_EXTENSION_EXISTS,b.GROUP4_EXTENSION_EXISTS,
        b.GROUP5_EXTENSION_EXISTS,b.GROUP6_EXTENSION_EXISTS,b.GROUP7_EXTENSION_EXISTS,
        b.GROUP8_EXTENSION_EXISTS,b.GROUP9_EXTENSION_EXISTS,b.GROUPA_EXTENSION_EXISTS,
        b.CENT_LAB_CONTRACT_EXISTS,b.CRO_LAB_CONTRACT_EXISTS,b.CENT_LAB_PRICE_MODEL,
        b.EXTENSION_EXISTS,b.TREATMENT_CONTROL,b.DRUG,b.TITLE,b.COMPLEXITY_VAL  
        FROM protocol@db_link b 
        WHERE b.id=a.id)
WHERE EXISTS (SELECT 1 FROM protocol@db_link c WHERE c.id=a.id);

INSERT INTO protocol SELECT * FROM protocol@db_link b 
WHERE NOT EXISTS (SELECT 1 FROM protocol a WHERE b.id=a.id);

DELETE FROM protocol  
WHERE id NOT IN (SELECT id FROM protocol@db_link );

commit;

select 'END TIME ---'||to_char(sysdate,'DD-MON-YYYY HH24:MI:SS') from dual;

spool off;

