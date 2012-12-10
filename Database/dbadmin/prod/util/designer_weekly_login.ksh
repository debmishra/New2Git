#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: c:\tsm\Database\dbadmin\prod\util\designer_weekly_login.ksh$
#
# $Revision: 1$        $Date: 6/7/2011 10:06:54 PM$
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
column username format a30
column action format a50
column timestamp format a60

spool /export/home/oracle/log/designer_all_logged_1week.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' PDT"' from dual;
Select '"Report of all Designer Logins in last week"' from dual;
select '"Client Division","User","Action","Timestamp"' from dual;

SELECT '"'||x.client_div||'","'||x.Username||'","'||x.action||'","'||x.timestamp||'"'
FROM (
SELECT a.client_div_identifier client_div,b.first_name||' '||b.last_name Username,
       c.action Action, To_Char(c.modify_date,'MM/DD/YYYY HH24:MI') timestamp
FROM audit_hist c, ftuser b, client_div a 
WHERE c.ftuser_id=b.id 
AND b.client_div_id=a.id and
c.app_type='TSPD' 
AND c.modify_date BETWEEN SYSDATE -7 AND SYSDATE
ORDER BY  a.client_div_identifier, b.first_name||' '||b.last_name,c.modify_date 
) x;

spool off

exit;
EOF

sed "s/$/`echo \\\r`/" /export/home/oracle/log/designer_all_logged_1week.csv | \
uuencode designer_weekly_login.csv | \
mailx -r $sender -s "Designer Weekly Login Report" -c $cclist $mailinglist
