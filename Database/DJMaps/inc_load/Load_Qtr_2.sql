--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: Load_Qtr_2.sql$ 
--
-- $Revision: 4$        $Date: 4/15/2011 3:48:20 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

spool c:\mahesh\load_45master\Load_Qtr_2_demo.log
set timing on;

select 'START TIME ---'||to_char(sysdate,'DD-MON-YYYY HH24:MI:SS') from dual;

------INVESTIG-----
SELECT 'investig' FROM dual;

INSERT INTO investig SELECT * FROM investig@db_link;

commit;

------PAYMENTS-----
SELECT 'payments' FROM dual;

INSERT INTO payments SELECT * FROM payments@db_link;

commit;

------PROTOCOL_TO_INDMAP-----
SELECT 'protocol_to_indmap' FROM dual;

TRUNCATE TABLE protocol_to_indmap;

INSERT INTO protocol_to_indmap SELECT * FROM protocol_to_indmap@db_link;


------PRICE_LEVEL-----
SELECT 'price_level' FROM dual;

TRUNCATE TABLE price_level;

INSERT INTO price_level SELECT * FROM price_level@db_link;

------DERIVED_PRICES-----
SELECT 'derived_prices' FROM dual;

TRUNCATE TABLE derived_prices;

INSERT INTO derived_prices SELECT * FROM derived_prices@db_link;

------PROCEDURE_TO_PROTOCOL-----
SELECT 'procedure_to_protocol' FROM dual;

TRUNCATE TABLE procedure_to_protocol;

INSERT INTO procedure_to_protocol SELECT * FROM procedure_to_protocol@db_link;

------REFERENCE_PRICES-----
SELECT 'reference_prices' FROM dual;

TRUNCATE TABLE reference_prices;

INSERT INTO reference_prices SELECT * FROM reference_prices@db_link;

exec temp_role_inst_update;

update id_control set next_id=(select nvl(max(id),0)+1 from country) where table_name='country';
update id_control set next_id=(select nvl(max(id),0)+1 from currency) where table_name='currency';
update id_control set next_id=(select nvl(max(id),0)+1 from build_code) where table_name='build_code';
update id_control set next_id=(select nvl(max(id),0)+1 from indmap) where table_name='indmap';
update id_control set next_id=(select nvl(max(id),0)+1 from affiliation_factor) where table_name='affiliation_factor';
update id_control set next_id=(select nvl(max(id),0)+1 from ip_duration_factor) where table_name='ip_duration_factor';
update id_control set next_id=(select nvl(max(id),0)+1 from ip_weight) where table_name='ip_weight';
update id_control set next_id=(select nvl(max(id),0)+1 from ip_cpp) where table_name='ip_cpp';
update id_control set next_id=(select nvl(max(id),0)+1 from ip_duration) where table_name='ip_duration';
update id_control set next_id=(select nvl(max(id),0)+1 from ip_business_factors) where table_name='ip_business_factors';
update id_control set next_id=(select nvl(max(id),0)+1 from region) where table_name='region';
update id_control set next_id=(select nvl(max(id),0)+1 from institution) where table_name='institution';
update id_control set next_id=(select nvl(max(id),0)+1 from procedure_def) where table_name='procedure_def';
update id_control set next_id=(select nvl(max(id),0)+1 from odc_def) where table_name='odc_def';
update id_control set next_id=(select nvl(max(id),0)+1 from mapper) where table_name='mapper';
update id_control set next_id=(select nvl(max(id),0)+1 from pap_odc_pct) where table_name='pap_odc_pct';
update id_control set next_id=(select nvl(max(id),0)+1 from pap_odc_pct_to_indmap) where table_name='pap_odc_pct_to_indmap';
update id_control set next_id=(select nvl(max(id),0)+1 from pap_euro_overhead) where table_name='pap_euro_overhead';
update id_control set next_id=(select nvl(max(id),0)+1 from add_study) where table_name='add_study';
update id_control set next_id=(select nvl(max(id),0)+1 from protocol) where table_name='protocol';
update id_control set next_id=(select nvl(max(id),0)+1 from investig) where table_name='investig';
update id_control set next_id=(select nvl(max(id),0)+1 from payments) where table_name='payments';
update id_control set next_id=(select nvl(max(id),0)+1 from protocol_to_indmap) where table_name='protocol_to_indmap';
update id_control set next_id=(select nvl(max(id),0)+1 from price_level) where table_name='price_level';
update id_control set next_id=(select nvl(max(id),0)+1 from procedure_to_protocol) where table_name='procedure_to_protocol';
update id_control set next_id=(select nvl(max(id),0)+1 from build_tag) where table_name='build_tag';

UPDATE protocol a SET earliest_grant_date = (SELECT earliest_grant_date
                                             FROM protocol@db_link b
                                             WHERE a.id=b.id);

commit;

------VERSION_45MASTER-----
SELECT 'version_45master' FROM dual;

TRUNCATE TABLE version_45master;

INSERT INTO version_45master SELECT * FROM version_45master@db_link;

commit;
select 'END TIME ---'||to_char(sysdate,'DD-MON-YYYY HH24:MI:SS') from dual;
spool off

