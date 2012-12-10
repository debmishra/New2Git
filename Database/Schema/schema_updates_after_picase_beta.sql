--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_after_picase_beta.sql$ 
--
-- $Revision: 29$        $Date: 2/22/2008 11:56:01 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
-- Following changes are as per the request of Kelly on 06/10/2002

alter table "&1".task_inst drop column task_group_inst_id;

create or replace procedure "&1".delete_trace_trial (trialid in number) as

begin

delete from "&1".role_inst_to_task_inst where
trace_estimate_id in (select id from "&1".trace_estimate 
where trial_id=trialid);

delete from "&1".task_inst where
trace_estimate_id in (select id from "&1".trace_estimate 
where trial_id=trialid);

delete from "&1".task_group_inst where
trace_estimate_id in (select id from "&1".trace_estimate 
where trial_id=trialid);

delete from "&1".milestone_inst where
trace_estimate_id in (select id from "&1".trace_estimate 
where trial_id=trialid);

delete from "&1".trace_estimate where trial_id=trialid;

delete from "&1".trace_trial where trial_id=trialid;

delete from "&1".trial where id=trialid;
commit;

end;
/

sho err

-- Folowing changes are as per the request of Colin on 06/11/2002 at 9:15am


Alter table "&1".client_div modify (def_overhead_pct number(12,2));

Alter table "&1".picas_visit_to_cost_item modify (frequency number(12,2));

Alter table "&1".cost_item modify (frequency number(12,2));

Alter table "&1".cost_item modify (screening_quantity number(12,2));


-- Following changes are as per the request of kelly on 06/17/2002 at 8:28 am

Alter table "&1".role_to_task_template drop column sequence;

Alter table "&1".task_inst drop column recalc_flg;

Alter table "&1".trace_estimate drop column locked_by_ftuser_id;
Alter table "&1".trace_estimate drop column locked_date;
Alter table "&1".trace_estimate drop column spons_staff_invmtg_count;
Alter table "&1".trace_estimate drop column cro_staff_invmtg_count;
Alter table "&1".trace_estimate drop column joint_staff_invmtg_count;
Alter table "&1".trace_estimate drop column joint_meeting_dur;
Alter table "&1".trace_estimate drop column published_flg;

Alter table "&1".trace_trial drop column drug_code_id;

-- Following changes are as per the request of Gary on 06/16/2002 at 11:11 am

Alter table "&1".client_div drop column locale;

Alter table "&1".client_div add(iso_lang varchar2(2));

Alter table "&1".country add(iso_country varchar2(2));

update "&1".country set iso_country = 'AU'
where abbreviation = 'AUS';

update "&1".country set iso_country = 'AT'
where abbreviation = 'ARI';

update "&1".country set iso_country = 'BE'
where abbreviation = 'BEL';

update "&1".country set iso_country = 'CA'
where abbreviation = 'CAN';

update "&1".country set iso_country = 'DK'
where abbreviation = 'DEN';

update "&1".country set iso_country = 'FI'
where abbreviation = 'FIN';

update "&1".country set iso_country = 'FR'
where abbreviation = 'FRA';

update "&1".country set iso_country = 'DE'
where abbreviation = 'DEU';

update "&1".country set iso_country = 'HU'
where abbreviation = 'HUN';

update "&1".country set iso_country = 'IE'
where abbreviation = 'IRL';

update "&1".country set iso_country = 'IL'
where abbreviation = 'ISR';

update "&1".country set iso_country = 'IT'
where abbreviation = 'ITA';

update "&1".country set iso_country = 'NL'
where abbreviation = 'NET';

update "&1".country set iso_country = 'NO'
where abbreviation = 'NOR';

update "&1".country set iso_country = 'PL'
where abbreviation = 'POL';

update "&1".country set iso_country = 'ZA'
where abbreviation = 'SAF';

update "&1".country set iso_country = 'ES'
where abbreviation = 'ESP';

update "&1".country set iso_country = 'SE'
where abbreviation = 'SWE';

update "&1".country set iso_country = 'CH'
where abbreviation = 'SWI';

update "&1".country set iso_country = 'GB'
where abbreviation = 'UK';

update "&1".country set iso_country = 'US'
where abbreviation = 'USA';

update "&1".country set iso_country = 'AR'
where abbreviation = 'ARG';

update "&1".country set iso_country = 'CL'
where abbreviation = 'CHI';

update "&1".country set iso_country = 'GR'
where abbreviation = 'GCE';

update "&1".country set iso_country = 'HK'
where abbreviation = 'HKG';

update "&1".country set iso_country = 'IS'
where abbreviation = 'ICE';

update "&1".country set iso_country = 'ID'
where abbreviation = 'INS';

update "&1".country set iso_country = 'JP'
where abbreviation = 'JAP';

update "&1".country set iso_country = 'LV'
where abbreviation = 'LAT';

update "&1".country set iso_country = 'LU'
where abbreviation = 'LUX';

update "&1".country set iso_country = 'MY'
where abbreviation = 'MIA';

update "&1".country set iso_country = 'MX'
where abbreviation = 'MEX';

update "&1".country set iso_country = 'MA'
where abbreviation = 'MOR';

update "&1".country set iso_country = 'PT'
where abbreviation = 'POR';

update "&1".country set iso_country = 'SG'
where abbreviation = 'SIN';

update "&1".country set iso_country = 'TW'
where abbreviation = 'TAI';

update "&1".country set iso_country = 'TH'
where abbreviation = 'THA';

update "&1".country set iso_country = 'TR'
where abbreviation = 'TUR';

update "&1".country set iso_country = 'HR'
where abbreviation = 'CRO';

update "&1".country set iso_country = 'CZ'
where abbreviation = 'CZE';

update "&1".country set iso_country = 'EE'
where abbreviation = 'EST';

update "&1".country set iso_country = 'LT'
where abbreviation = 'LIT';

update "&1".country set iso_country = 'NZ'
where abbreviation = 'NZE';

update "&1".country set iso_country = 'RO'
where abbreviation = 'RUM';

update "&1".country set iso_country = 'RU'
where abbreviation = 'RIA';

update "&1".country set iso_country = 'SK'
where abbreviation = 'SVK';

update "&1".country set iso_country = 'SI'
where abbreviation = 'SLO';

update "&1".country set iso_country = 'BA'
where abbreviation = 'BOS';

update "&1".country set iso_country = 'PH'
where abbreviation = 'PHI';

update "&1".country set iso_country = 'NG'
where abbreviation = 'NIG';

update "&1".country set iso_country = 'DZ'
where abbreviation = 'ALG';

update "&1".country set iso_country = 'BR'
where abbreviation = 'BRA';

update "&1".country set iso_country = 'BG'
where abbreviation = 'BLG';

update "&1".country set iso_country = 'CN'
where abbreviation = 'CHN';

update "&1".country set iso_country = 'CO'
where abbreviation = 'COL';

update "&1".country set iso_country = 'CR'
where abbreviation = 'CRA';

update "&1".country set iso_country = 'EG'
where abbreviation = 'EGY';

update "&1".country set iso_country = 'SV'
where abbreviation = 'ELS';

update "&1".country set iso_country = 'GT'
where abbreviation = 'GUA';

update "&1".country set iso_country = 'IN'
where abbreviation = 'IND';

update "&1".country set iso_country = 'KW'
where abbreviation = 'KUW';

update "&1".country set iso_country = 'LB'
where abbreviation = 'LEB';

update "&1".country set iso_country = 'LI'
where abbreviation = 'LIE';

update "&1".country set iso_country = 'MT'
where abbreviation = 'MAL';

update "&1".country set iso_country = 'MC'
where abbreviation = 'MON';

update "&1".country set iso_country = 'PK'
where abbreviation = 'PAK';

update "&1".country set iso_country = 'PA'
where abbreviation = 'PAN';

update "&1".country set iso_country = 'PR'
where abbreviation = 'PRT';

update "&1".country set iso_country = 'BY'
where abbreviation = 'RBL';

update "&1".country set iso_country = 'SA'
where abbreviation = 'SAU';

update "&1".country set iso_country = 'TN'
where abbreviation = 'TUN';

update "&1".country set iso_country = 'AE'
where abbreviation = 'UAE';

update "&1".country set iso_country = 'UY'
where abbreviation = 'UGY';

update "&1".country set iso_country = 'UA'
where abbreviation = 'UKR';

update "&1".country set iso_country = 'VE'
where abbreviation = 'VEN';

update "&1".country set iso_country = 'YU'
where abbreviation = 'YUG';

update "&1".country set iso_country = 'HN'
where abbreviation = 'HON';

update "&1".country set iso_country = 'CY'
where abbreviation = 'CYP';

commit;


-- Following changes are as per the request of Kelly on 06/25/2002 at 14:33

drop table "&1".TRACE_AUDIT_HISTORY;

-- Following changes are as per the request of Kelly on 06/25/2002 at 14:33

drop table "&1".budget_audit_hist;

-- Following chnages are as per the request of Kelly on 07/01/2002 at 13:40

Alter table "&1".role_inst add constraint role_inst_uq1 
unique (role_template_id,rate_set_id)
using index tablespace tsmsmall_indx pctfree 20;




create or replace procedure "&1".temp_role_inst_update as 

rs_exist number(10);
rs_maxid number(10);
ri_maxid number(10);
countryid number(10);
ratesetid number(10);

cursor c1 is select id from client_div;

begin

select nvl(max(id),0)+1 into rs_maxid from rate_set;
select nvl(max(id),0)+1 into ri_maxid from role_inst;

select id into countryid from country where abbreviation = 'USA';


for ix1 in c1 loop

 select count(*) into rs_exist from rate_set where client_div_id = ix1.id;

 if rs_exist = 0 then

   Insert into rate_set(ID,NAME,CLIENT_DIV_ID,COUNTRY_ID,DEFAULT_FLG)
   values(rs_maxid,'Industry Standards',ix1.id,countryid,1);
   
   ratesetid:=rs_maxid;
   rs_maxid:=rs_maxid+1;

   	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,1,152,250,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,2,250,250,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,3,186,250,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,4,186,250,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,5,152,250,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,6,186,250,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,7,152,250,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,8,186,250,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,10,186,250,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,11,88,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,12,88,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,13,84,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,14,88,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,15,70,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,16,88,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,17,88,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,18,88,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,19,76,120,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,20,48,100,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,21,42,60,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,22,42,60,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,23,42,60,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,24,42,60,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,25,42,60,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,26,42,60,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,27,42,60,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,28,42,60,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,29,60,120,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,30,50,100,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,47,120,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,32,94,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,33,72,100,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,34,56,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,35,48,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,36,72,100,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,37,46,100,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,38,68,120,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,39,58,100,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,40,78,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,41,50,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,42,92,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,43,42,60,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,46,186,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,44,42,60,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,45,186,250,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,48,100,60,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;
 end if;

end loop;

commit;

end;
/

exec "&1".temp_role_inst_update


-- Following changes are done as per the request of Nancy on 07/09/2002 at 12:53
-- This is for Picase ECR35 deleting budget

Alter table "&1".trial_budget add(delete_flg number(1) default 0 not null);

Alter table "&1".trial_budget add constraint tb_delete_flg_check check(
delete_flg in (0,1));

-- Following changes are as as per te verbal request of Jeff on 07/09/2002 at 14:51

CREATE OR REPLACE TRIGGER
"&2".ftuser_name_check_trg1
before insert or update on "&2".ftuser
referencing new as n old as o
for each row


declare
extension_v ftuser.name%type;
site_id_cnt  number(20);
client_id_cnt  number(20);
client_div_id_cnt number(10);
Invalid_site_id exception;
Invalid_client_id exception;
invalid_ftuser exception;
invalid_client_div_id exception;

begin

 If :n.name like '%@%' then

    extension_v:=substr(:n.name,instr(:n.name,'@')+1);

    If :n.site_id is not null then

        select count(*) into  site_id_cnt from site where site_identifier = extension_v;

        If site_id_cnt <1 then
           Raise Invalid_site_id;
        end if;
    elsif :n.client_id is not null and :n.client_div_id is null then

        select count(*) into client_id_cnt from client where client_identifier = extension_v;

        If client_id_cnt <1 then
           Raise Invalid_client_id;
        end if; 

    elsif :n.client_div_id is not null then

        select count(*) into client_div_id_cnt from "&1".client_div where client_div_identifier = extension_v;

        If client_div_id_cnt <1 then
           Raise Invalid_client_div_id;
        end if;


   end if;


 end if;

 If :n.site_id is not null and :n.client_id is not null then
    Raise invalid_ftuser;
 end if;


 If trim(:n.display_name) is null then
   :n.display_name:=initcap(:n.first_name)||' '||initcap(:n.last_name);
 end if;

Exception

  When Invalid_site_id then
       Raise_application_error(-20006,'Invalid site identifier attached with name');

  when Invalid_client_id then
       Raise_application_error(-20020,'Invalid client identifier attached with name');

  when Invalid_ftuser then
       Raise_application_error(-20042,'Both site_id and client_id can not exist together');

  when Invalid_client_div_id then
       Raise_application_error(-20102,'Invalid client division identifier attached with name');


end;
/
sho err


-- Following changes are as per the request of Kelly on 07/10/2002 at 15:50

update "&1".role_to_task_template set calculation_name = 'NO_OP'  where id=9;

update "&1".role_to_task_template set calculation_name = 'PA_ADMIN_GRANT_ADMIN' where id=10;

commit;

-- Following changes are as per the request of Kelly on 07/10/2002 at 16:12

Insert into "&1".role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (598,34, 2, 'MM_VP_INVESTIGATOR_MEET');

Insert into "&1".role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (599,34, 29, 'DM_SDC_INVESTIGATOR_MEET');

update "&1".role_to_task_template set calculation_name='NO_OP' where id=161;

commit;

-- Following changes are as per the request of Kelly on 07/12/2002 at 14:30 

Create table "&1".User_Pref(
	ID number(10),
	ftuser_id number(10),
	app_type varchar2(50),  
	name  varchar2(50),
	value varchar2(50))
	tablespace tsmsmall 
	pctused 65 pctfree 20;

Alter table "&1".User_Pref add constraint User_Pref_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table "&1".User_Pref add constraint up_app_type_check 
	check (app_type in ('DASHBOARD', 'PICASE', 'TRACE'));

Alter table "&1".User_Pref add constraint User_Pref_fk1
	foreign key (ftuser_id) references 
	"&1".ftuser(id);

create sequence "&1".user_pref_seq;



Insert into "&1".user_pref select "&1".user_pref_seq.nextval,ftuser_id,'PICASE',
'tree_pane_state',tree_pane_state from "&1".user_preferences;

Insert into "&1".user_pref select "&1".user_pref_seq.nextval,ftuser_id,'PICASE',
'sort_type',sort_type from "&1".user_preferences;

Insert into "&1".user_pref select "&1".user_pref_seq.nextval,ftuser_id,'PICASE',
'ta_filter',ta_filter from "&1".user_preferences;

Insert into "&1".user_pref select "&1".user_pref_seq.nextval,ftuser_id,'PICASE',
'phase_filter',phase_filter from "&1".user_preferences;

Insert into "&1".user_pref select "&1".user_pref_seq.nextval,ftuser_id,'PICASE',
'trial_filter',trial_filter from "&1".user_preferences;

Insert into "&1".user_pref select "&1".user_pref_seq.nextval,ftuser_id,'PICASE',
'budget_filter',budget_filter from "&1".user_preferences;

Insert into "&1".user_pref select "&1".user_pref_seq.nextval,ftuser_id,'PICASE',
'show_warning',reset_warning from "&1".user_preferences;

commit;


-- Following changes are per the discussions with Kelly on 07/12/2002 at 15:50


Alter table "&2".trial drop constraint trial_created_by_check;

Alter table "&2".trial add constraint trial_created_by_check check(
	created_by in ('DASHBOARD', 'PICASE', 'TRACE'));

-- Following changes are per the discussions with Kelly on 07/12/2002 at 16:10

Alter table "&1".audit_hist modify (COMMENTS varchar2(4000));

-- Following changes are as per the request of mmeyer on 07/15/2002 at 13:31

Alter table "&1".trial_budget add(DROPOUT_RATE_PCT NUMBER(12,2) default 0 not null);


-- Following changes are as per the request of Kelly on 07/17/2002 at 12:30

drop table "&1".user_preferences;


-- Following changes are as per the request of Kelly on 07/19/2002 at 15:30

Alter table "&1".trace_estimate add(ivr_flg number(1) default 1 not null);

Alter table "&1".trace_estimate add constraint te_ivr_flg_check
check(ivr_flg in (0,1));

-- Following changes are as per the request of Kelly on 07/22/2002 at 9:25

create table "&1".temp_trace_estimate as select id,QUERY_PAGE_PCT from "&1".trace_estimate;
update "&1".trace_estimate set query_PAGE_PCT = null;
Alter table "&1".trace_estimate modify(QUERY_PAGE_PCT number(5,2));
update "&1".trace_estimate a set a.QUERY_PAGE_PCT = (select b.QUERY_PAGE_PCT
from "&1".temp_trace_estimate b where b.id=a.id);
commit;
drop table "&1".temp_trace_estimate;

-- Following changes are as per the request of Kelly on 07/24/2002 at 9:11 

Alter table "&1".rate_set add (fte_hours_month number(4,1) default 160 not null);


-- Following changes are as per the request of Peter on 08/07/2002

update "&1".role_to_task_template set calculation_name = 'NO_OP' where ID = 11;
update "&1".role_to_task_template set calculation_name = 'MM_MGR_MMON' where ID = 12;

update "&1".role_to_task_template set calculation_name = 'NO_OP' where ID = 15;
update "&1".role_to_task_template set calculation_name = 'MM_MGR_REV_LAB' where ID = 16;

update "&1".role_to_task_template set calculation_name = 'NO_OP' where ID = 22;
update "&1".role_to_task_template set calculation_name = 'MM_MGR_INTERP_TEST' where ID = 23;

update "&1".role_to_task_template set calculation_name = 'NO_OP' where ID = 18;
update "&1".role_to_task_template set calculation_name = 'MM_MGR_REV_OTHER_TEST' where ID = 19;
update "&1".role_to_task_template set calculation_name = 'STAT_STAT_PLAN' where ID = 248;
update "&1".role_to_task_template set calculation_name = 'STAT_SRSTAT_ANALYSIS' where ID = 257;

insert into "&1".task_template (ID, NAME, SEQUENCE, TASK_GROUP_TEMPLATE_ID, 
START_MILESTONE_TEMPLATE_ID, END_MILESTONE_TEMPLATE_ID) 
VALUES(122, 'QueryResolution', 12, 4, 2, 6);

insert into "&1".task_template (ID, NAME, SEQUENCE, TASK_GROUP_TEMPLATE_ID, 
START_MILESTONE_TEMPLATE_ID, END_MILESTONE_TEMPLATE_ID) 
VALUES(123, 'DocumentCollection', 3, 1, 1, 5);

update "&1".task_template set sequence = 13 where id = 38;
update "&1".task_template set sequence = 14 where id = 91;
update "&1".task_template set sequence = 15 where id = 92;
update "&1".task_template set sequence = 16 where id = 93;
update "&1".task_template set sequence = 17 where id = 94;
update "&1".task_template set sequence = 18 where id = 95;
update "&1".task_template set sequence = 19 where id = 96;
update "&1".task_template set sequence = 20 where id = 97;


update "&1".task_template set sequence = 4 where id = 71;
update "&1".task_template set sequence = 5 where id = 72;
update "&1".task_template set sequence = 6 where id = 73;
update "&1".task_template set sequence = 7 where id = 74;
update "&1".task_template set sequence = 8 where id = 75;
update "&1".task_template set sequence = 9 where id = 76;

insert into "&1".role_to_task_template (ID, TASK_TEMPLATE_ID, ROLE_TEMPLATE_ID, CALCULATION_NAME) 
values (600, 122, 20, 'CO_CRA_QUERY_RES');
insert into "&1".role_to_task_template (ID, TASK_TEMPLATE_ID, ROLE_TEMPLATE_ID, CALCULATION_NAME) 
values (601, 122, 4, 'NO_OP');
insert into "&1".role_to_task_template (ID, TASK_TEMPLATE_ID, ROLE_TEMPLATE_ID, CALCULATION_NAME) 
values (602, 122, 12, 'NO_OP');
insert into "&1".role_to_task_template (ID, TASK_TEMPLATE_ID, ROLE_TEMPLATE_ID, CALCULATION_NAME) 
values (603, 122, 43, 'NO_OP');
insert into "&1".role_to_task_template (ID, TASK_TEMPLATE_ID, ROLE_TEMPLATE_ID, CALCULATION_NAME) 
values (604, 123, 1, 'NO_OP');
insert into "&1".role_to_task_template (ID, TASK_TEMPLATE_ID, ROLE_TEMPLATE_ID, CALCULATION_NAME) 
values (605, 123, 11, 'NO_OP');
insert into "&1".role_to_task_template (ID, TASK_TEMPLATE_ID, ROLE_TEMPLATE_ID, CALCULATION_NAME) 
values (606, 123, 19, 'NO_OP');
insert into "&1".role_to_task_template (ID, TASK_TEMPLATE_ID, ROLE_TEMPLATE_ID, CALCULATION_NAME) 
values (607, 123, 20, 'PA_CRA_DOC_COLLECT');
insert into "&1".role_to_task_template (ID, TASK_TEMPLATE_ID, ROLE_TEMPLATE_ID, CALCULATION_NAME) 
values (608, 123, 21, 'NO_OP');


commit;

-- Following changes are for the ftcommon related chnages on 08/20/2002
-- and will fail if proper grants has not been given to ftcommon from ft15 schema's.

-- In case of problem run the following manually after loggin into 
-- each ft15 schema
-- grant select on ftuser to ftcommon;
-- grant select on ftgroup to ftcommon;
-- grant select on ftuser_to_ftgroup to ftcommon;

create or replace view ftcommon.ftuser as select 
ID,NAME||'@tsm10' name ,PASSWORD,SITE_ID,STARTING_SCREEN,LAST_PASSWORD_UPDATE,
FIRST_NAME,LAST_NAME,LAST_LOGIN_DATE,PRIMARY_TA_ID,ADDRESS_LINE_1,
ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,WORK_PHONE,
HOME_PHONE,FAX,MOBILE_PHONE,EMAIL,PREFERRED_CONTACT,TITLE,
CLIENT_ID,CLIENT_DIV_ID,DISPLAY_NAME,ACTIVE_TRACE_USER,
ACTIVE_TSM_USER,'tsm10' environment from ft15.ftuser;

create or replace view ftcommon.ftgroup as select
id, name,'tsm10' environment from ft15.ftgroup;


create or replace view ftcommon.ftuser_to_ftgroup as select
id,ftuser_id,ftgroup_id,'tsm10' environment from 
ft15.ftuser_to_ftgroup;



-- Following chnages are as per the request of Joel on 08/20/2002


Alter table "&1".picase_trial add(study_duration_id number(10),
			     inpatient_status_id number(10));

Alter table "&1".picase_trial add constraint PICASE_TRIAL_FK6 
	foreign key (study_duration_id) references "&1".ip_business_factors(id);
Alter table "&1".picase_trial add constraint PICASE_TRIAL_FK7 
	foreign key (inpatient_status_id) references "&1".ip_business_factors(id);

Alter table "&1".picase_trial drop constraint pt_budget_type_check;
Alter table "&1".picase_trial add constraint pt_budget_type_check
	check(budget_type in 
	('Industry Cost', 'Per Patient Budget','Per Visit Budget','Modeled Budget'));

Alter table "&1".trial_budget add(cpp_modeled  NUMBER(10),
			     use_modeled_price number(1) default 0 not null);
Alter table "&1".trial_budget add constraint tb_use_modeled_price_check
	check(use_modeled_price in (0,1));
			     

Alter table "&1".client_div drop constraint cd_def_budget_type_check;
Alter table "&1".client_div add constraint cd_def_budget_type_check
	check( def_budget_type in 
	('Industry Cost','Per Patient Budget','Per Visit Budget','Modeled Budget'));
















---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  29   DevTSM    1.28        2/22/2008 11:56:01 AMDebashish Mishra  
--  28   DevTSM    1.27        9/19/2006 12:11:29 AMDebashish Mishra   
--  27   DevTSM    1.26        3/2/2005 10:51:01 PM Debashish Mishra  
--  26   DevTSM    1.25        8/29/2003 5:17:43 PM Debashish Mishra  
--  25   DevTSM    1.24        8/20/2002 3:05:19 PM Debashish Mishra Modified for
--       picas-eu
--  24   DevTSM    1.23        8/20/2002 12:47:35 PMDebashish Mishra Changes for
--       multiple product and schema support
--  23   DevTSM    1.22        8/16/2002 11:14:05 AMDebashish Mishra Modified
--       calculation_name in role_to_task_template for id=19
--  22   DevTSM    1.21        8/7/2002 12:13:20 PM Debashish Mishra  
--  21   DevTSM    1.20        8/7/2002 12:04:51 PM Debashish Mishra Implemented
--       changes in trace static data for Peter
--  20   DevTSM    1.19        7/24/2002 9:34:35 AM Debashish Mishra Added
--       rate_set.fte_hours_month
--  19   DevTSM    1.18        7/22/2002 11:33:35 AMDebashish Mishra
--       trace_estimate.ivr_flg modified to default 1 not null
--  18   DevTSM    1.17        7/22/2002 9:34:01 AM Debashish Mishra modified
--       trace_estimate.query_page_pct to number(5,2)
--  17   DevTSM    1.16        7/19/2002 3:39:52 PM Debashish Mishra added
--       trace-estimate.ivr_flg
--  16   DevTSM    1.15        7/17/2002 12:44:13 PMDebashish Mishra dropped table
--       user_preferences
--  15   DevTSM    1.14        7/15/2002 1:35:37 PM Debashish Mishra  
--  14   DevTSM    1.13        7/12/2002 4:13:23 PM Debashish Mishra Modified
--       audit_hist.comments to varchar2(4000)
--  13   DevTSM    1.12        7/12/2002 3:53:22 PM Debashish Mishra Modified
--       constraint in trial.created_by
--  12   DevTSM    1.11        7/12/2002 3:41:19 PM Debashish Mishra New table
--       user_pref
--  11   DevTSM    1.10        7/10/2002 4:16:42 PM Debashish Mishra
--       Updates/inserts into role_to_task_template
--  10   DevTSM    1.9         7/9/2002 3:05:19 PM  Debashish Mishra Modified
--       trigger in ftuser table to update display name only when its null
--  9    DevTSM    1.8         7/9/2002 1:26:44 PM  Debashish Mishra added
--       trial_budget.delete_flg for picas-e ECR35 
--  8    DevTSM    1.7         7/2/2002 1:27:52 PM  Debashish Mishra Added one
--       constraint to role_inst and a temporary procedure to populate it
--  7    DevTSM    1.6         7/1/2002 11:32:07 AM Debashish Mishra Name change
--       for FSU
--  6    DevTSM    1.5         6/25/2002 2:48:18 PM Debashish Mishra dropped
--       trace_audit_history and budget_audit_hist tables
--  5    DevTSM    1.4         6/18/2002 9:41:54 AM Debashish Mishra updates for
--       country.iso_country
--  4    DevTSM    1.3         6/18/2002 8:47:04 AM Debashish Mishra Changes in
--       client_div and country for iso_lang and iso_country codes
--  3    DevTSM    1.2         6/17/2002 10:58:22 AMDebashish Mishra name changed
--       from former soviet union block to Lithuania, Latvia, Estonia, Russia
--  2    DevTSM    1.1         6/17/2002 9:16:50 AM Debashish Mishra dropped
--       columns from role_to_task_template, task_inst, trace_estimate and
--       trace_trial
--  1    DevTSM    1.0         6/13/2002 11:51:39 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
