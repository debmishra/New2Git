#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: c:\tsm\Database\dbadmin\prod\util\report4MaryAnn_1.ksh$
#
# $Revision: 1$        $Date: 6/7/2011 10:08:08 PM$
#
#
# Description:  <ADD>
#
#############################################################
cd /export/home/oracle
. /etc/profile
. ./.profile

mailinglist="trialplanning@mdsol.com"
cclist="dmishra@mdsol.com"
#mailinglist="dmishra@mdsol.com"
sender="noreply@mdsol.com"

export ORACLE_SID=prod
export current_date=`date`

sqlplus -s tsm10/`get_pwd tsm10` <<EOF

set heading off
set feedback off
set lin 300
set pages 1000

spool /export/home/oracle/log/gm_medidata_integration.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' PDT"," "' from dual;
Select '"Grants Manager and IMedidata User Integration status"' from dual;
select '"Client Division","GM User Name","First name","Last name","Display Name","Email","Converted email forImedidata","Converted?","Imedidata User ID","Logged in from ImEdidata?"' from dual;

SELECT '"'||b.client_div_identifier||'","'||a.NAME||'","'||a.First_name||'","'||a.Last_name||'","'||a.Display_name||'","'||
a.email||'","'||a.Imed_name||'","'||Decode(a.imed_name,NULL,'No','Yes')||'","'||
a.Imed_id||'","'||Decode(a.imed_id, NULL,'No','Yes')||'"'
FROM ftuser a, client_div b  
WHERE a.client_div_id=b.id and b.id IN (SELECT client_div_id FROM client_div_to_lic_app 
WHERE license_exp_date > SYSDATE AND app_name IN ('PICASE','GM30') )
ORDER BY 1;

spool off
exit;
EOF

sed "s/$/`echo \\\r`/"  /export/home/oracle/log/gm_medidata_integration.csv | \
uuencode gm_medidata_integration.csv | mailx -s " GM Imedidata user integration -- Daily" -r $sender -c $cclist $mailinglist
