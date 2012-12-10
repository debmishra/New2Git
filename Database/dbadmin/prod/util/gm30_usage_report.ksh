#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: c:\tsm\Database\dbadmin\prod\util\gm30_usage_report.ksh$
#
# $Revision: 1$        $Date: 6/7/2011 10:12:14 PM$
#
#
# Description:  <ADD>
#
#############################################################
cd /export/home/oracle
. /etc/profile
. ./.profile

mailinglist="lshields@mdsol.com,mdanishefsky@mdsol.com"
cclist="dmishra@mdsol.com"
sender="noreply@mdsol.com"

export ORACLE_SID=prod
export current_date=`date`

sqlplus -s tsm10/`get_pwd tsm10` <<EOF

set heading off
set feedback off
set lin 300
set pages 1000

column client_div format a10

spool /export/home/oracle/log/gm30_usage_report.csv

select '" ","Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' PDT"," "' from dual;
Select '"GM30 Usage"," "' from dual;
select '"Client Division","Login Name"," Time (PST)","Comments","Action"' from dual;

SELECT '"'||x.client_div||'","'||x.name||'","'||x.modify_date||'","'||x.comments||'","'||x.action||'"'
FROM (
SELECT c.client_div_identifier client_div, b.name name, a.modify_date modify_date, a.comments comments, a.action action
FROM audit_hist a, ftuser b, client_div c
WHERE a.ftuser_id=b.id 
AND b.client_div_id = c.id 
AND a.app_type='GM30' 
AND NOT (b.name LIKE '%@FTS' OR b.name LIKE 'fasttrack%')
AND a.modify_date BETWEEN trunc(sysdate-1) AND trunc(sysdate)
ORDER BY 1,2,3
) x;

spool off
exit;
EOF

sed "s/$/`echo \\\r`/"  /export/home/oracle/log/gm30_usage_report.csv | \
uuencode gm30_usage_report.csv | mailx -s "GM30 Usage -- Daily" -r $sender -c $cclist $mailinglist
