update id_control set next_id=1 where table_name='cro_rate_set';
update id_control set next_id=1 where table_name='cro_role_inst';
commit; 
Insert into cro_rate_set(ID,NAME,COUNTRY_ID,DEFAULT_FLG)
select increment_sequence('cro_rate_set_seq'),'US Industry Standards',id,1
from country where abbreviation='USA';
commit;

Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,158.08,1 from role_template where lower(name)=lower('PA_VP');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,91.52,1 from role_template where lower(name)=lower('PA_PM');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,43.68,1 from role_template where lower(name)=lower('PA_Admin');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,260,1 from role_template where lower(name)=lower('MM_VP');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),null,193.44,1 from role_template where lower(name)=lower('MM_PM'); 
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,124.8,1 from role_template where lower(name)=lower('MM_Mgr');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,43.68,1 from role_template where lower(name)=lower('MM_Admin');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,193.44,1 from role_template where lower(name)=lower('PM_VP');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,91.52,1 from role_template where lower(name)=lower('PM_PM');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,43.68,1 from role_template where lower(name)=lower('PM_Admin');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,193.44,1 from role_template where lower(name)=lower('CO_VP');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,91.52,1 from role_template where lower(name)=lower('CO_PM');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,43.68,1 from role_template where lower(name)=lower('CO_Admin');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,79.04,1 from role_template where lower(name)=lower('Snr_CRA');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,49.92,1 from role_template where lower(name)=lower('CRA');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,158.08,1 from role_template where lower(name)=lower('DM_VP');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,87.36,1 from role_template where lower(name)=lower('DM_PM');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,62.4,1 from role_template where lower(name)=lower('DM_SrDataCoord');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,52,1 from role_template where lower(name)=lower('DM_DataCoord');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,43.68,1 from role_template where lower(name)=lower('DM_Admin');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,104,1 from role_template where lower(name)=lower('DM_DataEntry');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,193.44,1 from role_template where lower(name)=lower('ST_VP');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,91.52,1 from role_template where lower(name)=lower('ST_PM');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,97.76,1 from role_template where lower(name)=lower('ST_SrStats');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,74.88,1 from role_template where lower(name)=lower('ST_Stats');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,43.68,1 from role_template where lower(name)=lower('ST_Admin');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,158.08,1 from role_template where lower(name)=lower('MW_VP');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,72.8,1 from role_template where lower(name)=lower('MW_PM');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,58.24,1 from role_template where lower(name)=lower('MW_SrMedWriter');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,49.92,1 from role_template where lower(name)=lower('MW_MedWriter');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,43.68,1 from role_template where lower(name)=lower('MW_Admin');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,193.44,1 from role_template where lower(name)=lower('RA_VP');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,91.52,1 from role_template where lower(name)=lower('RA_PM');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,74.88,1 from role_template where lower(name)=lower('RA_Auditor');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,47.84,1 from role_template where lower(name)=lower('RA_QCTech');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,43.68,1 from role_template where lower(name)=lower('RA_Admin');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,193.44,1 from role_template where lower(name)=lower('SF_VP');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,91.52,1 from role_template where lower(name)=lower('SF_PM');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,70.72,1 from role_template where lower(name)=lower('SF_SrSafety');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,60.32,1 from role_template where lower(name)=lower('SF_Safety');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,43.68,1 from role_template where lower(name)=lower('SF_Admin');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,193.44,1 from role_template where lower(name)=lower('IT_VP');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),null,95.68,1 from role_template where lower(name)=lower('IT_PM'); 
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,81.12,1 from role_template where lower(name)=lower('IT_SrProg');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,52,1 from role_template where lower(name)=lower('IT_Prog');
Insert into cro_role_inst(ID,ROLE_TEMPLATE_ID,CRO_RATE,CRO_RATE_SET_ID) select increment_sequence('cro_role_inst_seq'),id,43.68,1 from role_template where lower(name)=lower('IT_Admin');
commit;

--Deployed upto this in TSM10E@TEST on 04/09/2006 at 1pm
--Deployed upto this in TSM10T@PREV on 04/09/2006 at 1pm

update cro_role_inst set role_template_id=46 where id=5;
update cro_role_inst set role_template_id=42 where id=43;
commit;


--***********************************************************
--Deployed upto this in TSM10E@TEST on 05/01/2006 at 1pm
--Deployed upto this in TSM10T@PREV on 05/01/2006 at 1pm
--Deployed upto this in TSM10E@PREV on 06/11/2006 at 6:35pm
--Deployed upto this in TSM10G@PROD on 07/08/2006 at 5:35pm
--Deployed upto this in TSM10E@PROD on 07/16/2006 at 10:50am
--Deployed upto this in TSM10@PROD on 07/16/2006 at 10:50am
--***********************************************************

