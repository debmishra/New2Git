#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: designer_usage_report.ksh$
#
# $Revision: 2$        $Date: 6/7/2011 10:04:10 PM$
#
#
# Description:  <ADD>
#
#############################################################
cd /export/home/oracle
. /etc/profile
. ./.profile

mailinglist="designerservices@mdsol.com,mcherry@mdsol.com"
cclist="dmishra@mdsol.com"
sender="noreply@mdsol.com"

export ORACLE_SID=prod
export current_date=`date`
sqlplus -s tsm10/`get_pwd tsm10` <<EOF 

set feedback off
set lin 300
set pages 1000
column email format a50
column client_list format a50
alter session set nls_date_format='DD-MON-YYYY HH24:MI';
set markup html on 
spool /export/home/oracle/log/designer_usage_report.html

set heading off
ttitle left 'Report run date: '_DATE' PDT' SKIP 2 -
       left bold ' Designer Quarterly Usage';
set heading on

select email, cnt,
 substr(SYS_CONNECT_BY_PATH(client_divisions, ','),2) client_list
 from
 (
 select client_divisions, email,
 count(*) OVER ( partition by email ) cnt,
 ROW_NUMBER () OVER ( partition by email order by client_divisions) seq
 from (
 select a.email email,b.client_div_identifier client_divisions
 from ftuser a, client_div b, client_div_to_lic_app c
 where a.client_div_id=b.id
 and b.id=c.client_div_id
 and c.license_exp_date > sysdate
 and c.app_name='TSPD'
 and a.active_tspd_user=1
 and a.last_login_date between trunc(add_months(sysdate,-3),'Q') and trunc(sysdate,'Q')
 and a.email is not null
 ) dur )
 where seq=cnt
 start with seq=1
 connect by prior seq+1=seq and prior email=email
 order by cnt desc;

spool off
set markup html off;
exit;
EOF

cat /export/home/oracle/log/designer_usage_report.html | \
uuencode designer_usage.html | mailx -s "Designer Usage Report" -r $sender -c $cclist $mailinglist
