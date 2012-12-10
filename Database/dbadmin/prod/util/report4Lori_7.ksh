#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: report4Lori_7.ksh$ 
#
# $Revision: 8$        $Date: 6/7/2011 10:05:20 PM$
#
#
# Description:  <ADD>
#
#############################################################

cd /export/home/oracle
. /etc/profile
. ./.profile

mailinglist="TrialPlanningSupport@mdsol.com"
#mailinglist="dmishra@mdsol.com"
cclist="dmishra@mdsol.com"
sender="noreply@mdsol.com"
 
export ORACLE_SID=prod
sqlplus -s tsm10/`get_pwd tsm10` <<EOF 

set pages 1000
set lin 270
set hea off
set feedback off

spool /export/home/oracle/log/PSW_Trials.csv

select '"Trial","Version","Created By","Created On","Deleted By","Deleted On"' from dual;
select distinct '"'||b.protocol_identifier||'","'||decode(d.GM_version, null,'2.x',3,'3.x')||'","'||c.name||'","'||
To_Char(a.create_date,'mm/dd/yyyy')||'","'||y.name||'","'||
To_Char(x.modify_date,'mm/dd/yyyy')||'"'
from trial_budget a, trial b, ftuser c,picase_trial d, audit_hist x, ftuser y
where
a.trial_id=b.id and b.client_div_id=(select id from client_div where client_div_identifier='PSW')
and a.delete_flg=1
AND a.creator_ftuser_id=c.id AND b.id=d.trial_id AND
a.id=x.target_id and x.action = 'auditAction.budgetDeleted' AND
y.client_div_id=(select id from client_div where client_div_identifier='PSW')
AND y.id=x.ftuser_id and x.target_primary_table='trial_budget';

select '"Project","Trial","Version","Created By","Created On"' from dual;
SELECT '"'||d.name||'","'||a.protocol_identifier||'","'||
decode(b.GM_version, null,'2.x',3,'3.x')||'","'||first_name||' '||last_name||'","'||
to_char(b.create_date,'mm/dd/yyyy')||'"'
FROM trial a, picase_trial b, ftuser c, project d
WHERE a.id=b.trial_id and a.trial_status <> 'DELETED'
AND b.CREATOR_FTUSER_ID=c.id
AND a.project_id=d.id
AND a.client_div_id=(select id from client_div where client_div_identifier='PSW')
ORDER BY create_date;

spool off

spool /export/home/oracle/log/VTX_Trials.csv
select '"Trial","Version","Created By","Created On","Deleted By","Deleted On"' from dual;
select distinct '"'||b.protocol_identifier||'","'||decode(d.GM_version, null,'2.x',3,'3.x')||'","'||c.name||'","'||
To_Char(a.create_date,'mm/dd/yyyy')||'","'||y.name||'","'||
To_Char(x.modify_date,'mm/dd/yyyy')||'"'
from trial_budget a, trial b, ftuser c,picase_trial d, audit_hist x, ftuser y
where
a.trial_id=b.id and b.client_div_id=(select id from client_div where client_div_identifier='VTX')
and a.delete_flg=1
AND a.creator_ftuser_id=c.id AND b.id=d.trial_id AND
a.id=x.target_id and x.action = 'auditAction.budgetDeleted' AND
y.client_div_id=(select id from client_div where client_div_identifier='VTX')
AND y.id=x.ftuser_id and x.target_primary_table='trial_budget';

select '"Project","Trial","Version","Created By","Created On"' from dual;
SELECT '"'||d.name||'","'||a.protocol_identifier||'","'||
decode(b.GM_version, null,'2.x',3,'3.x')||'","'||first_name||' '||last_name||'","'||
to_char(b.create_date,'mm/dd/yyyy')||'"'
FROM trial a, picase_trial b, ftuser c, project d
WHERE a.id=b.trial_id and a.trial_status <> 'DELETED'
AND b.CREATOR_FTUSER_ID=c.id
AND a.project_id=d.id
AND a.client_div_id=(select id from client_div where client_div_identifier='VTX')
ORDER BY create_date;

spool off
exit;
EOF

mv /export/home/oracle/log/PSW_Trials.csv /export/home/oracle/log/PSW_Trials_$(date +%m%d%y).csv
mv /export/home/oracle/log/VTX_Trials.csv /export/home/oracle/log/VTX_Trials_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/PSW_Trials_$(date +%m%d%y).csv | \
uuencode PSW_Trials_$(date +%m%d%y).csv | \
mailx -r $sender -s "Trials Deleted and Created in PSW" -c $cclist $mailinglist

sed "s/$/`echo \\\r`/" /export/home/oracle/log/VTX_Trials_$(date +%m%d%y).csv | \
uuencode VTX_Trials_$(date +%m%d%y).csv | \
mailx -r $sender -s "Trials Deleted and Created in VTX" -c $cclist $mailinglist



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  8    DevTSM    1.7         6/7/2011 10:05:20 PM Debashish Mishra  
#  7    DevTSM    1.6         8/11/2009 12:03:31 AMDebashish Mishra  
#  6    DevTSM    1.5         9/3/2008 11:58:50 AM Debashish Mishra  
#  5    DevTSM    1.4         2/27/2008 3:21:52 PM Debashish Mishra  
#  4    DevTSM    1.3         10/16/2007 1:46:42 PMDebashish Mishra  
#  3    DevTSM    1.2         9/6/2006 9:50:01 PM  Debashish Mishra  
#  2    DevTSM    1.1         11/16/2005 2:05:40 PMDebashish Mishra  
#  1    DevTSM    1.0         9/19/2005 4:23:59 PM Debashish Mishra 
# $
# 
#############################################################
