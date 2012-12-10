#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: report4Lori_18.ksh$ 
#
# $Revision: 2$        $Date: 6/7/2011 10:04:11 PM$
#
#
# Description:  <ADD>
#
#############################################################
cd /export/home/oracle
. /etc/profile
. ./.profile

mailinglist="mdanishefsky@mdsol.com,jdolfi@mdsol.com"
cclist="dmishra@mdsol.com"
sender="noreply@mdsol.com"

export ORACLE_SID=prod
export current_date=`date`
sqlplus -s tsm10/`get_pwd tsm10` <<EOF 

set feedback off
set lin 300
set pages 1000
column name format a33
column display_name format a40
alter session set nls_date_format='DD-MON-YYYY HH24:MI';
set markup html on 
spool /export/home/oracle/log/report4Lori_18.html

set heading off
ttitle left 'Report run date: '_DATE' PDT' SKIP 2 -
       center bold 'Wyeth Client/Data admin, GM-Analysis and GM-Contracting Users';
set heading on

SELECT c.display_name "Name",  c.name "LoginId",
       MAX(DECODE(c.ftgroup_id,11,'Client Admin')) "GM-P Client Admin",
       MAX(DECODE(c.ftgroup_id,24,'Data Admin')) "GM-P Data Admin",
       MAX(DECODE(c.ftgroup_id,34,'GMOwn User')) "GM-A User", 
       MAX(DECODE(c.ftgroup_id,30,'TSN Admin')) "GM-C Admin"          ,
       MAX(DECODE(c.ftgroup_id,31,'TSN Negotiator')) "GM-C Negotiator", 
       MAX(DECODE(c.ftgroup_id,32,'TSN Contact')) "GM-C Contact"
FROM (SELECT a.ftuser_id, a.ftgroup_id, b.display_name, b.name
      FROM ftuser_to_ftgroup a, ftuser b
      WHERE a.ftgroup_id IN (11,24,30,31,32,34)
      AND a.ftuser_id=b.id
      AND b.client_div_id=55
      AND b.name NOT LIKE 'fasttrack%'
     ) c
GROUP BY c.name,  c.display_name
order by c.display_name;

spool off
set markup html off;
exit;
EOF

cat /export/home/oracle/log/report4Lori_18.html | \
uuencode WYETH_users.html | mailx -s "Wyeth Client/Data admin, GM-Analysis and GM-Contracting Users" -r $sender -c $cclist $mailinglist
