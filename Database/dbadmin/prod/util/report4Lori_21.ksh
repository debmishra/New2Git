#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: c:\tsm\Database\dbadmin\prod\util\report4Lori_21.ksh$ 
#
# $Revision: 1$        $Date: 6/7/2011 10:07:40 PM$
#
#
# Description:  <ADD>
#
#############################################################
cd /export/home/oracle
. /etc/profile
. ./.profile

mailinglist="dmishra@mdsol.com"
cclist="dmishra@mdsol.com"
sender="noreply@mdsol.com"

export ORACLE_SID=prod
sqlplus -s tsm10/`get_pwd tsm10` <<EOF 

set heading off
set feedback off
set lin 500
set pages 1000
spool /export/home/oracle/log/WAT_NEG_DAYS.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' PDT"' from dual;
Select 'WYETH - Contracting "time to negotiate" report' from dual;
select '"Negotiation Created By","Investigating institution","Investigator","Protocol","Negotiation","Created on (PST)","Wizard Completed (or negotiation sent) on(PST)","Negotiation completed on(PST)","Total days (from start of wizard to complete of negotiation)","Actual negotiation days",' from dual;
SELECT '"'||d.Display_name||'","'||y.inst_name||'","'||y.first_name||' '||y.last_name||'","'|| 
c.protocol_identifier||'","'||a.short_desc||'","'||a.create_date||'","'||a.completion_date||'","'||x.completion_date||'","'|| Round(x.completion_date-a.create_date,2)||'","'||Round(x.completion_date-a.completion_date,2)||'"'
FROM tsn_neg_to_investigator x, tsn_investigator y, tsn_negotiate a, tsn_trial b, trial c , ftuser d
WHERE x.tsn_investigator_id=y.id(+) 
and x.tsn_negotiate_id=a.id 
and a.tsn_trial_id=b.trial_id(+) 
AND b.trial_id=c.id(+) 
AND a.creator_ftuser_id=d.id(+)
AND  a.client_div_id=55 
AND x.status=0   
AND c.trial_status<>'DELETED'
ORDER BY a.short_desc,a.create_date;

spool off
exit;
EOF

sed "s/$/`echo \\\r`/" /export/home/oracle/log/WAT_NEG_DAYS.csv | \
uuencode WAT_NEG_$(date +%m%d%y).csv | \
mailx -r $sender -s "WYETH - Contracting report" -c $cclist $mailinglist

