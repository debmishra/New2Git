
-- As per request from Craig on 03/31/2011

INSERT INTO local_to_euro VALUES(increment_sequence('local_to_euro_seq'),53,30.126000);

alter table country add(ISO_3166  VARCHAR2(3));
alter table country add(ISO_4217  VARCHAR2(3));

-- AS SYSTEM USER

conn system;

update tsm10.country a 
SET (a.iso_3166,a.iso_4217)=(SELECT b.iso_3166,b.iso_4217 
                              FROM TSM_STAGE.country2 b WHERE b.abbreviation=a.abbreviation);

--Implemented upto this in devl on xx/xx/2011
--Implemented upto this in q003 on 04/05/2011
--Implemented upto this in prod on 04/12/2011
--Implemented upto this in demo on 04/15/2011


UPDATE country SET currency_id=10 WHERE id=53;
--********************************************
--Implemented upto this in devl on xx/xx/2011
--Implemented upto this in q003 on 04/05/2011
--Implemented upto this in q004 on 05/18/2011
--Implemented upto this in prod on ??
--Implemented upto this in demo on ??
--Implemented upto this in perf on 6/6/2011
--********************************************

