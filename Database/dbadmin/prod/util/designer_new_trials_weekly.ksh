#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: c:\tsm\Database\dbadmin\prod\util\designer_new_trials_weekly.ksh$
#
# $Revision: 1$        $Date: 6/7/2011 10:06:38 PM$
#
#
# Description:  <ADD>
#
#############################################################
cd /export/home/oracle
. /etc/profile
. ./.profile

mailinglist="designerservices@mdsol.com"
cclist="dmishra@mdsol.com"
sender="noreply@mdsol.com"

export ORACLE_SID=prod
export current_date=`date`

sqlplus -s tsm10/`get_pwd tsm10` <<EOF

set heading off
set feedback off
set lin 300
set pages 1000

column client_div format a33
column trial format a50
column created_by format a33
column created_on format a40

spool /export/home/oracle/log/designer_new_trials_weekly.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' PDT"' from dual;
Select '"Designer New Trials Created Last Week"' from dual;
select '"Client Division","Trial","Created By","Created On"' from dual;

SELECT '"'||x.client_div||'","'||x.trial||'","'||x.created_by||'","'||x.created_on||'"'
FROM (
SELECT d.client_div_identifier client_div, a.protocol_identifier trial,
 b.first_name||' '||b.last_name created_by, To_Char(c.create_date,'MM/DD/YYYY HH24:MI') created_on
FROM trial a,ftuser b, tspd_trial c,client_div d
WHERE a.client_div_id=d.id 
and a.id=c.trial_id 
and c.creator_ftuser_id=b.id  
AND c.create_date BETWEEN SYSDATE-7 AND SYSDATE
ORDER BY 1,3
) x;

spool off
exit;
EOF

sed "s/$/`echo \\\r`/"  /export/home/oracle/log/designer_new_trials_weekly.csv | \
uuencode designer_new_trials_weekly.csv | mailx -s "Designer New Trials -- Weekly" -r $sender -c $cclist $mailinglist

