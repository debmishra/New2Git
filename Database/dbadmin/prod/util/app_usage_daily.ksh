#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: c:\tsm\Database\dbadmin\prod\util\app_usage_daily.ksh$
#
# $Revision: 1$        $Date: 6/7/2011 10:06:12 PM$
#
#
# Description:  <ADD>
#
#############################################################
cd /export/home/oracle
. /etc/profile
. ./.profile

mailinglist="trialplanning@mdsol.com,spepe@mdsol.com"
cclist="dmishra@mdsol.com"
sender="noreply@mdsol.com"

export ORACLE_SID=prod
export current_date=`date`

sqlplus -s tsm10/`get_pwd tsm10` <<EOF

set heading off
set feedback off
set lin 300
set pages 1000

column application format a30
column client_div format a10
column modify_date format a40

spool /export/home/oracle/log/app_usage_daily.csv

select '" ","Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' PDT"," "' from dual;
Select '"Application Usage"," "' from dual;
select '"Application","Client Division","Login Name"," Time (PST)","Comments","Action"' from dual;

SELECT '"'||x.application||'","'||x.client_div||'","'||x.name||'","'||to_char(x.modify_date,'dd-Mon-YYYY hh24:mi:ss')||'","'||x.comments||'","'||x.action||'"'
FROM (
SELECT decode(a.app_type,'GMOWN','GM Analysis','PBTOWN','CRO Contractor Analysis','PICASE','GM 2.0',
'TSN','GM Contracting','GM30','GM3.0','CROCAS','CRO Contractor' ) application, 
c.client_div_identifier client_div,b.NAME name, a.modify_date modify_date,
 a.comments comments, a.action action
FROM audit_hist a, ftuser b, client_div c
WHERE a.ftuser_id=b.id AND b.client_div_id = c.id AND  
a.app_type in ('GMOWN','PBTOWN','PICASE','TSN','GM30','CROCAS')  AND 
NOT (b.NAME LIKE '%@FTS' OR b.NAME LIKE '%@MDT' OR b.NAME LIKE '%@FTM' OR b.NAME LIKE 'fasttrack%')
And a.modify_date between trunc(sysdate-1) and trunc(sysdate)
ORDER BY 1,2,3,4 
) x;

spool off
exit;
EOF

sed "s/$/`echo \\\r`/"  /export/home/oracle/log/app_usage_daily.csv | \
uuencode app_usage_daily.csv | mailx -s "Applications Usage -- Daily" -r $sender -c $cclist $mailinglist
