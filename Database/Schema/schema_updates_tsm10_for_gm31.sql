--As per Frank's request on 03/29/2010

ALTER TABLE picase_trial ADD(hidden_trial_flg  NUMBER(1,0)    DEFAULT 0 NOT NULL);


--Implemented upto this in devl,d002,d003 on 03/29/10

INSERT INTO ip_business_factors(id,type,ibf_order,factor,short_desc) VALUES(335,'Ph2+sites',1,1,'AllSites');
INSERT INTO ip_business_factors(id,type,ibf_order,factor,short_desc)  VALUES(336,'Ph2+sites',2,1,'Affiliated');
INSERT INTO ip_business_factors(id,type,ibf_order,factor,short_desc)  VALUES(337,'Ph2+sites',3,1,'Unaffiliated');


alter table ip_session add(GM_VERSION NUMBER(4,2));

--******************************************************
--Implemented upto this in devl,d002,d003,d004,d005 on 09/03/2010
--Implemented upto this in q005 on 09/03/2010
--Implemented upto this in q003 on 09/07/2010
--Implemented upto this in perf on 09/14/2010
--Implemented upto this in demo on 11/03/2010
--Implemented upto this in q004 on 11/05/2010
--Implemented upto this in q002 on 03/15/2011
--******************************************************