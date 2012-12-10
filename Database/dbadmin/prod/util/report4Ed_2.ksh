#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: report4Ed_2.ksh$ 
#
# $Revision: 8$        $Date: 6/7/2011 10:05:16 PM$
#
#
# Description:  <ADD>
#
#############################################################
cd /export/home/oracle
. /etc/profile
. ./.profile

###mailinglist="eseguine@mdsol.com lshields@mdsol.com spepe@mdsol.com mdanishefsky@mdsol.com"
mailinglist="trialplanning@mdsol.com"
#mailinglist="dmishra@fast-track.com"
cclist="dmishra@mdsol.com"
sender="noreply@mdsol.com"

export ORACLE_SID=prod
sqlplus -s tsm10/`get_pwd tsm10` <<EOF 

set heading off
set feedback off
set lin 300
set pages 1000
column name format a33
column id format a8
column user_name format a30
column last_login_date format a25
break on id
spool /export/home/oracle/log/Ed/UserDetails.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' PDT"' from dual;
Select '"Detail Report of Users in each Client Division"' from dual;

select '"ID","User Name","#LOGIN","LAST LOGIN DATE",' from dual;
SELECT '"'||b.client_div_identifier||'","'||a.First_name||' '||a.Last_name||'","'||c.num_login||'","'||
to_char(a.last_login_date,'mm/dd/yy hh24:mi')||'",' 
FROM ftuser a,client_div b, 
(select ftuser_id, count(*) num_login from ftuser_login_history group by ftuser_id) c
WHERE a.client_div_id = b.id and a.id=c.ftuser_id(+) and
a.id in (select ftuser_id from ftuser_to_client_group) and
a.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id in (9,10)) and
b.id in (select client_div_id from client_div_to_lic_app where app_name='PICASE')
ORDER BY b.client_div_identifier;

spool off
exit;
EOF



mv /export/home/oracle/log/Ed/UserDetails.csv /export/home/oracle/log/Ed/UserDetails_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/Ed/UserDetails_$(date +%m%d%y).csv | \
uuencode UserDetails_$(date +%m%d%y).csv | \
mailx -r $sender -s "Usage report - UserDetails" -c $cclist $mailinglist

