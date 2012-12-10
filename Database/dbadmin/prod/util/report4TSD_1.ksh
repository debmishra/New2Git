#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: report4TSD_1.ksh$ 
#
# $Revision: 3$        $Date: 6/7/2011 10:05:20 PM$
#
#
# Description:  <ADD>
#
#############################################################
cd /export/home/oracle
. /etc/profile
. ./.profile

mailinglist="designerservices@mdsol.com"
#mailinglist="dmishra@mdsol.com"
cclist="dmishra@mdsol.com"
sender="noreply@mdsol.com"

export ORACLE_SID=prod
sqlplus -s tsm10/`get_pwd tsm10` <<EOF 

set feedback off
set lin 300
set pages 1000
set heading off

spool /export/home/oracle/log/Report4TSD_1_prod.txt

select 'client'||','||'Identifier'||','||'Version'||','||'Build'||','||'License Expires'||','||'Optional Patch'
from dual;

select '"'||a.name||'",'||a.client_div_identifier||','||c.frontend_version||','||c.version||','||
to_char(c.license_exp_date,'mm-dd-yyyy')||','||decode(patch_available,1,patch_version,0,'None')
from client_div a, client_div_to_lic_app c
where
a.id=c.client_div_id and
c.app_name = 'TSPD'
order by a.client_div_identifier;

set heading on
spool off

exit;
EOF

cat /export/home/oracle/log/Report4TSD_1_prod.txt|grep -v ^$|mailx -s "TSD production client build report" -r $sender -c $cclist $mailinglist

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  3    DevTSM    1.2         6/7/2011 10:05:20 PM Debashish Mishra  
#  2    DevTSM    1.1         8/11/2009 12:03:31 AMDebashish Mishra  
#  1    DevTSM    1.0         9/3/2008 12:02:16 PM Debashish Mishra 
# $
# 
#############################################################
