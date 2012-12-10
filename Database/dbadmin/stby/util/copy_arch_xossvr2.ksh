#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: c:\tsm\Database\dbadmin\stby\util\copy_arch_xossvr2.ksh$ 
#
# $Revision: 1$        $Date: 4/18/2011 8:06:47 AM$
#
#
# Description:  <ADD>
#
#############################################################

#!/bin/ksh

. /etc/profile
cd ~oracle
. ./.profile

export ORACLE_SID=prod

if [[ -f /u01/app/oracle/admin/prod/copy_in_progress ]]
 then
   echo "Previous copy of logs not completed. Long data transfer time. Will try it again after 15 minutes" | mailx -s COPY_SLOW mpasupuleti@mdsol.com
   exit 1
fi
 
touch /u01/app/oracle/admin/prod/copy_in_progress

sqlplus -s backup_user/`get_pwd backup_user`  << EOF
Alter system switch logfile;
exit;
EOF

sleep 2
mv /arch/oracle/prod/*.log /arch/oracle/prod/temp/
rcp /arch/oracle/prod/temp/*.log xossvr2:/arch/oracle/prod/

if [[ $? -gt 0 ]]
then
   echo "Archival copy failed. Please check logfile" | mailx -s "Archival copy failed" "mpasupuleti@mdsol.com 5105011758@tmomail.net"
fi

sleep 10
mv /arch/oracle/prod/temp/*.log /orabackup/prod/hot/archive/

rm /u01/app/oracle/admin/prod/copy_in_progress

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  1    DevTSM    1.0         4/18/2011 8:06:47 AM Debashish Mishra 
# $
# 
#############################################################
