#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: c:\tsm\Database\dbadmin\prod\util\report4Lori_20.ksh$
#
# $Revision: 1$        $Date: 6/7/2011 10:05:59 PM$
#
#
# Description:  Monthly report for Takeda CRO contractor Users
#
#############################################################
cd /export/home/oracle
. /etc/profile
. ./.profile

#mailinglist="rweller@tpna.com,susan.berman@tgrd.com"
mailinglist="trialplanning@mdsol.com"
cclist="dmishra@mdsol.com,trialplanning@mdsol.com"
sender="noreply@mdsol.com"

export ORACLE_SID=prod
export current_date=`date`
sqlplus -s tsm10/`get_pwd tsm10` <<EOF 

set feedback off
set lin 300
set pages 1000
column login format a30
column name format a60
alter session set nls_date_format='DD-MON-YYYY HH24:MI';
set markup html on 
spool /export/home/oracle/log/report4Lori_20.html

set heading off
ttitle left 'Report run date: '_DATE' PDT' SKIP 2 -
       left bold ' CRO contractor users';
set heading on

alter session set nls_date_format='MM/DD/YYYY';

create or replace function temp_report_groups (FtuserId in number)
return varchar2 is
clientgroups varchar2(1024):=null;
cursor C1 is select a.name from client_group a, ftuser_to_client_group b
              where a.id=b.client_group_id and a.IS_CROCAS_GROUP=1 
              and b.ftuser_id=FtuserId order by 1;
begin
  for ix1 in c1 loop
      clientgroups:=clientgroups||', '||ix1.name;
   end loop;
  return(substr(clientgroups,3));
  end;
/



SELECT replace(a.NAME,'@TAK') login, a.Display_name name, temp_report_groups(a.id) groups,
max(b.modify_date) "Last Login Date",count(b.modify_date) "Total Logins"
FROM ftuser a, audit_hist b 
WHERE a.name LIKE '%TAK' 
AND a.active_crocas_user=1
AND a.id=b.ftuser_id
AND b.action='auditAction.login_succeeded'
AND b.app_type='CROCAS'
GROUP by replace(a.NAME,'@TAK'),a.Display_name,temp_report_groups(a.id)
ORDER BY NAME;


drop function temp_report_groups;

spool off
set markup html off;
exit;
EOF

cat /export/home/oracle/log/report4Lori_20.html | \
uuencode TAK_users.html | mailx -s "CRO contractor(TAK) Users" -r $sender -c $cclist $mailinglist
