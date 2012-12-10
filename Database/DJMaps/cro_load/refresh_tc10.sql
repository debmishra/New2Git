--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: refresh_tc10.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:21:06 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
Alter table CRO_HOURLY_WAGE disable constraint CRO_HOURLY_WAGE_FK4;
execute dbms_snapshot.refresh('CURRENCY')
Alter table CRO_HOURLY_WAGE enable constraint CRO_HOURLY_WAGE_FK4;

Alter table CRO_COMPANY disable constraint CRO_COMPANY_FK2;
Alter table CRO_COMPANY disable constraint CRO_COMPANY_FK1;
Alter table CRO_COUNTRY_INDICATION disable constraint CRO_COUNTRY_INDICATION_FK2;
Alter table CRO_COUNTRY_PHASE disable constraint CRO_COUNTRY_PHASE_FK2;
Alter table CRO_COUNTRY_SERVICE disable constraint CRO_COUNTRY_SERVICE_FK2;
Alter table CRO_COUNTRY_STAFFING disable constraint CRO_COUNTRY_STAFFING_FK2;
Alter table CRO_HOURLY_WAGE disable constraint CRO_HOURLY_WAGE_FK3;
Alter table CRO_STUDY_COUNTRY disable constraint CRO_STUDY_COUNTRY_FK3;
execute dbms_snapshot.refresh('COUNTRY')
Alter table CRO_COMPANY disable constraint CRO_COMPANY_FK2;
Alter table CRO_COMPANY disable constraint CRO_COMPANY_FK1;
Alter table CRO_COUNTRY_INDICATION disable constraint CRO_COUNTRY_INDICATION_FK2;
Alter table CRO_COUNTRY_PHASE disable constraint CRO_COUNTRY_PHASE_FK2;
Alter table CRO_COUNTRY_SERVICE disable constraint CRO_COUNTRY_SERVICE_FK2;
Alter table CRO_COUNTRY_STAFFING disable constraint CRO_COUNTRY_STAFFING_FK2;
Alter table CRO_HOURLY_WAGE disable constraint CRO_HOURLY_WAGE_FK3;
Alter table CRO_STUDY_COUNTRY disable constraint CRO_STUDY_COUNTRY_FK3;

Alter table CRO_STUDY disable constraint CRO_STUDY_FK2;
Alter table cro_country_indication disable constraint cro_country_indication_fk5;
execute dbms_snapshot.refresh('INDMAP')
Alter table CRO_STUDY enable constraint CRO_STUDY_FK2;
Alter table cro_country_indication enable constraint cro_country_indication_fk5;


Alter table CRO_COUNTRY_PHASE disable constraint CRO_COUNTRY_PHASE_FK3;
Alter table CRO_STUDY disable constraint CRO_STUDY_FK3;
execute dbms_snapshot.refresh('PHASE')
Alter table CRO_COUNTRY_PHASE enable constraint CRO_COUNTRY_PHASE_FK3;
Alter table CRO_STUDY enable constraint CRO_STUDY_FK3;

execute dbms_snapshot.refresh('REGION')


update id_control set next_id =
(select nvl(max(id),0)+1 from CRO_ASSOC_COMPANY)
where upper(table_name)='CRO_ASSOC_COMPANY';

update id_control set next_id =
(select nvl(max(id),0)+1 from CRO_COMPANY)
where upper(table_name)='CRO_COMPANY';

update id_control set next_id =
(select nvl(max(id),0)+1 from CRO_COUNTRY_INDICATION)
where upper(table_name)='CRO_COUNTRY_INDICATION';

update id_control set next_id =
(select nvl(max(id),0)+1 from CRO_COUNTRY_PHASE)
where upper(table_name)='CRO_COUNTRY_PHASE';

update id_control set next_id =
(select nvl(max(id),0)+1 from CRO_COUNTRY_SERVICE)
where upper(table_name)='CRO_COUNTRY_SERVICE';

update id_control set next_id =
(select nvl(max(id),0)+1 from CRO_COUNTRY_STAFFING)
where upper(table_name)='CRO_COUNTRY_STAFFING';

update id_control set next_id =
(select nvl(max(id),0)+1 from CRO_EXP_AREA)
where upper(table_name)='CRO_EXP_AREA';

update id_control set next_id =
(select nvl(max(id),0)+1 from CRO_HOURLY_WAGE)
where upper(table_name)='CRO_HOURLY_WAGE';

update id_control set next_id =
(select nvl(max(id),0)+1 from CRO_HOURLY_WORK_TYPE)
where upper(table_name)='CRO_HOURLY_WORK_TYPE';

update id_control set next_id =
(select nvl(max(id),0)+1 from CRO_HW_SW_CODE)
where upper(table_name)='CRO_HW_SW_CODE';

update id_control set next_id =
(select nvl(max(id),0)+1 from CRO_HW_SW_USED)
where upper(table_name)='CRO_HW_SW_USED';

update id_control set next_id =
(select nvl(max(id),0)+1 from CRO_LANGUAGE)
where upper(table_name)='CRO_LANGUAGE';

update id_control set next_id =
(select nvl(max(id),0)+1 from CRO_LOGIN)
where upper(table_name)='CRO_LOGIN';

update id_control set next_id =
(select nvl(max(id),0)+1 from CRO_MED_WRITING_TRANS)
where upper(table_name)='CRO_MED_WRITING_TRANS';

update id_control set next_id =
(select nvl(max(id),0)+1 from CRO_OTHER_HW_SW_CODE)
where upper(table_name)='CRO_OTHER_HW_SW_CODE';

update id_control set next_id =
(select nvl(max(id),0)+1 from CRO_SERVICE_TYPE)
where upper(table_name)='CRO_SERVICE_TYPE';

update id_control set next_id =
(select nvl(max(id),0)+1 from CRO_STUDY)
where upper(table_name)='CRO_STUDY';

update id_control set next_id =
(select nvl(max(id),0)+1 from CRO_STUDY_COUNTRY)
where upper(table_name)='CRO_STUDY_COUNTRY';

update id_control set next_id =
(select nvl(max(id),0)+1 from CRO_STUDY_SERVICE)
where upper(table_name)='CRO_STUDY_SERVICE';


commit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:21:06 PM Debashish Mishra  
--  2    DevTSM    1.1         9/9/2005 3:19:58 PM  Debashish Mishra  
--  1    DevTSM    1.0         8/5/2005 8:30:47 AM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
