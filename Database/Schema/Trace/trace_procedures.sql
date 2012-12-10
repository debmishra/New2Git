--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: trace_procedures.sql$ 
--
-- $Revision: 5$        $Date: 2/27/2008 3:17:31 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
create or replace procedure delete_trace_trial (trialid in number) as

begin

delete from role_inst_to_task_inst where
trace_estimate_id in (select id from trace_estimate 
where trial_id=trialid);

delete from task_inst where
trace_estimate_id in (select id from trace_estimate 
where trial_id=trialid);

delete from task_group_inst where
trace_estimate_id in (select id from trace_estimate 
where trial_id=trialid);

delete from milestone_inst where
trace_estimate_id in (select id from trace_estimate 
where trial_id=trialid);

delete from trace_estimate where trial_id=trialid;

delete from trace_trial where trial_id=trialid;

delete from trial where id=trialid;
commit;

end;
/

sho err

create or replace procedure temp_role_inst_update as 

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









exit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/27/2008 3:17:31 PM Debashish Mishra  
--  4    DevTSM    1.3         3/3/2005 6:31:46 AM  Debashish Mishra  
--  3    DevTSM    1.2         7/11/2002 4:31:50 PM Debashish Mishra Modified for
--       deleted tables after beta
--  2    DevTSM    1.1         7/2/2002 1:25:33 PM  Debashish Mishra Added one
--       constraint to role_inst and a temporary procedure to populate it
--  1    DevTSM    1.0         6/13/2002 11:51:51 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
