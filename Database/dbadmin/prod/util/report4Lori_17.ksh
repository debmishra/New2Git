#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: report4Lori_17.ksh$ 
#
# $Revision: 4$        $Date: 6/7/2011 10:05:19 PM$
#
#
# Description:  <ADD>
#
#############################################################
cd /export/home/oracle
. /etc/profile
. ./.profile

mailinglist="dmishra@mdsol.com"
#mailinglist="lshields@fast-track.com"
cclist="dmishra@mdsol.com"
sender="noreply@mdsol.com"

export ORACLE_SID=prod
sqlplus -s tsm10/`get_pwd tsm10` <<EOF 



create function temp_report17_budget_country (TrialId in number)
return varchar2 is
cntrylist varchar2(1024):=null;
cursor C1 is select a.abbreviation abv from country a, trial_budget b
             where a.id=b.country_id and b.trial_id=TrialId and b.delete_flg=0 order by 1;
begin
 for ix1 in c1 loop
    cntrylist:=cntrylist||','||ix1.abv;
 end loop;
return(substr(cntrylist,2));
end;
/
sho err

create function temp_report17_IP_country (IPSessionId in number)
return varchar2 is
cntrylist varchar2(1024):=null;
cursor C1 is select a.abbreviation abv from country a, ip_session_detail b
             where a.id=b.country_id and b.ip_session_id=IPSessionId order by 1;
begin
 for ix1 in c1 loop
    cntrylist:=cntrylist||','||ix1.abv;
 end loop;
return(substr(cntrylist,2));
end;
/
sho err


create function temp_report17_trial_status (TrialId in number)
return varchar2 is
trialstatus varchar2(1024):=null;
pub_trial number(10);
unpub_trial number(10);
WizardPageFlg number(1);
begin
 
select count(*) into pub_trial from trial_budget where is_published=1 and trial_id=TrialId and delete_flg=0;
select count(*) into unpub_trial from trial_budget where is_published=0 and trial_id=TrialId and delete_flg=0;

If pub_trial > 0 and unpub_trial > 0 then
  trialstatus:='Partially Published';
elsif pub_trial = 0 and unpub_trial > 0 then
  trialstatus:='Unpublished';
elsif pub_trial > 0 and unpub_trial = 0 then
  trialstatus:='All Published';
end if;

Select wizard_page_flg into WizardPageFlg from trial where id=TrialId;

 if WizardPageFlg = 0 then
   trialstatus:='Incomplete';
 end if;

return trialstatus;
end;
/
sho err
set heading off
set feedback off
set lin 300
set pages 1000

spool /export/home/oracle/log/VTX_trials.csv

select 'Name,Status,Phase,Sites,Subjects,Cost per Pt.,Grant Toal,w Dropouts,Author,Countries' from dual;

Select Name||','||Status||','||Phase||','||Sites||','||Subjects||','||cpp||','||tot||','||tot_pvb||','||Author||',"'||Countries||'"'
from
(select a.protocol_identifier name,temp_report17_trial_status(a.id) status,e.short_desc phase,c.num_sites Sites,
c.num_patients subjects,c.cost_per_patient cpp,c.total_cost tot, c.total_cost_pvb tot_pvb, 
Initcap(d.last_name)||' '||upper(substr(d.first_name,1,1)) author,
temp_report17_budget_country(a.id) countries
from trial a, picase_trial b, tsm_trial_rollup c, ftuser d, phase e,client_div f
where a.id=b.trial_id and b.trial_id=c.trial_id(+) and b.creator_ftuser_id=d.id(+)
and a.phase_id=e.id(+) and a.client_div_id=f.id and f.client_div_identifier='VTX'
union all
select ip_session_name,'Investigator Planning',y.short_desc,null,null,null,null,null, 
Initcap(z.last_name)||' '||upper(substr(z.first_name,1,1)),temp_report17_IP_country(x.id)
from ip_session x, phase y, ftuser z, client_div cd  where x.phase_id=y.id and x.creator_ftuser_id=z.id
AND x.client_div_id=cd.id AND  cd.client_div_identifier='VTX'
order by 1);




set heading on

spool off

drop function temp_report17_trial_status;
drop function temp_report17_budget_country;
drop function temp_report17_IP_country;

exit;
EOF

mv /export/home/oracle/log/VTX_trials.csv /export/home/oracle/log/VTX_trials_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/VTX_trials_$(date +%m%d%y).csv | \
uuencode VTX_trials_$(date +%m%d%y).csv | \
mailx -r $sender -s "VTX Trials" -c $cclist $mailinglist


