#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: monitor_stbydb.ksh$ 
#
# $Revision: 7$        $Date: 4/18/2011 8:06:35 AM$
#
#
# Description:  <ADD>
#
#############################################################
 
. /etc/profile
cd ~oracle
. ./.profile

email="dmishra@mdsol.com mpasupuleti@mdsol.com"
pager="4156862541@vtext.com 5105011758@tmomail.net"

num=`grep -i ORA-00600 /export/home/oracle/log/recover_stbydb.log | wc -l`
num1=`echo $num`

if [[ $num1 -gt 0 ]] 
 then
   if [[ -f /u01/app/oracle/admin/prod/ora600mailsent ]]
     then
       exit 0
    else
      echo "Standby db failed. Internal Error ORA-00600" | mailx -s ORA600STBYDB $email
      echo "Standby failed" | mailx -s ORA600STBYDB $pager
      touch /u01/app/oracle/admin/prod/ora600mailsent
      exit 0
    fi
fi

if [[ -f /u01/app/oracle/admin/prod/ora600mailsent ]]
then
 rm /u01/app/oracle/admin/prod/ora600mailsent
fi

cat /export/home/oracle/log/recover_stbydb.log >> /export/home/oracle/log/recover_stbydb.log.old
rm /export/home/oracle/log/recover_stbydb.log
if [[ $(date +%d) = 15 ]] 
  then
     mv /export/home/oracle/log/recover_stbydb.log.old /export/home/oracle/log/recover_stbydb.log.old2
fi


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  7    DevTSM    1.6         4/18/2011 8:06:35 AM Debashish Mishra  
#  6    DevTSM    1.5         3/3/2005 6:46:22 AM  Debashish Mishra  
#  5    DevTSM    1.4         12/26/2003 4:24:50 PMDebashish Mishra  
#  4    DevTSM    1.3         2/25/2003 12:41:32 PMDebashish Mishra  
#  3    DevTSM    1.2         1/13/2003 11:24:11 AMDebashish Mishra  
#  2    DevTSM    1.1         12/30/2002 5:41:34 PMDebashish Mishra Modified for
#       better monitoring of stby
#  1    DevTSM    1.0         10/30/2002 4:07:36 PMDebashish Mishra 
# $
# 
#############################################################
