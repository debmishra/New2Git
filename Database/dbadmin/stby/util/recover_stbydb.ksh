#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: recover_stbydb.ksh$ 
#
# $Revision: 13$        $Date: 4/18/2011 8:06:35 AM$
#
#
# Description:  Script that runs every 15 minutes to apply archived logs to stby db
#
#############################################################
 
#!/bin/ksh

. /etc/profile
cd ~oracle
. ./.profile

export ORACLE_SID=prod

email="dmishra@mdsol.com mpasupuleti@mdsol.com"
pager="4156862541@vtext.com 5105011758@tmomail.net"

sqlplus /nolog << EOF 
connect / as sysdba
recover automatic standby database;
exit;
EOF

num10=`grep ORA-00289 /export/home/oracle/log/recover_stbydb.log | grep /arch/oracle/prod/arch_1 | wc -l`
num11=`echo $num10`

if [[ $num11 -gt 1 ]]
  then

    num12=`grep ORA-00289 /export/home/oracle/log/recover_stbydb.log | grep /arch/oracle/prod/arch_1 | tail -2 | head -1 | \
    awk -F/ '{print $5}' | awk -F. '{print $1}' | awk -F_ '{print $3}'`
    num13=`grep ORA-00289 /export/home/oracle/log/recover_stbydb.log | grep /arch/oracle/prod/arch_1 | tail -1 | \
    awk -F/ '{print $5}' | awk -F. '{print $1}' | awk -F_ '{print $3}'`

    num14=`echo $num12`
    num15=`echo $num13`

 if [[ $num14 = $num15 ]]
  then
    if [[ -f /u01/app/oracle/admin/prod/stbymailsent ]]
      then
        exit 0
      else 
        if [[ `date '+%H'` -gt 6 && `date '+%H'` -lt 20 ]]
        then
          echo "Standby db failed. Synchronization problem" | mailx -s STBY_FAILED $email
          sleep 1 
          echo "Standby failed" | mailx -s STBY_FAILED $pager
          touch /u01/app/oracle/admin/prod/stbymailsent
          exit 0
        else
          echo "Standby db failed. Synchronization problem" | mailx -s STBY_FAILED $email
        fi
    fi
 fi

elif [[ $num11 -eq 0 ]]
   then

    if [[ -f /u01/app/oracle/admin/prod/stbyrecoverymailsent ]]
      then
        echo "Standby recovery not attempted. Synchronization problem" | mailx -s STBY_NOT_RECOVERED $email
        exit 1
    else 
        echo "Standby recovery not attempted. Synchronization problem" | mailx -s STBY_NOT_RECOVERED $email
        sleep 1
#        echo "Standby not recovered" | mailx -s STBY_NOT_RECOVERED $pager
        touch /u01/app/oracle/admin/prod/stbyrecoverymailsent
        exit 1
    fi

fi

num16=`grep ORA- /export/home/oracle/log/recover_stbydb.log | grep -v ORA-00289 | grep -v ORA-00279 | \
grep -v ORA-00280 | grep -v ORA-00278 | grep -v ORA-00308 | grep -v ORA-27037 | grep -v grep | wc -l`
num17=`echo $num16`

if [[ $num17 -gt 0 ]]
  then

    if [[ -f /u01/app/oracle/admin/prod/stbyoraerrmailsent ]]
      then
        rm /u01/app/oracle/admin/prod/stbyoraerrmailsent
    else  
        grep ORA- /export/home/oracle/log/recover_stbydb.log | grep -v ORA-00289 | grep -v ORA-00279 | \
        grep -v ORA-00280 | grep -v ORA-00278 | grep -v ORA-00308 | grep -v ORA-27037 | \
        grep -v grep | mailx -s STBY_ORA_ERR -r dmishra@mdsol.com mpasupuleti@mdsol.com
        
        touch /u01/app/oracle/admin/prod/stbyoraerrmailsent
    fi
fi


if [[ -f /u01/app/oracle/admin/prod/stbymailsent ]]
then
 rm /u01/app/oracle/admin/prod/stbymailsent
fi

if [[ -f /u01/app/oracle/admin/prod/stbyrecoverymailsent ]]
then
 rm /u01/app/oracle/admin/prod/stbyrecoverymailsent
fi  


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  13   DevTSM    1.12        4/18/2011 8:06:35 AM Debashish Mishra  
#  12   DevTSM    1.11        3/3/2005 6:46:22 AM  Debashish Mishra  
#  11   DevTSM    1.10        7/14/2003 5:10:27 PM Debashish Mishra  
#  10   DevTSM    1.9         7/2/2003 5:43:30 PM  Debashish Mishra  
#  9    DevTSM    1.8         6/10/2003 1:44:22 PM Debashish Mishra Added more
#       error handling statements to the script 
#  8    DevTSM    1.7         2/25/2003 12:41:33 PMDebashish Mishra  
#  7    DevTSM    1.6         2/11/2003 6:47:17 PM Debashish Mishra  
#  6    DevTSM    1.5         1/27/2003 2:38:50 PM Debashish Mishra Modified to
#       run the copy process from production database server
#  5    DevTSM    1.4         1/13/2003 11:24:11 AMDebashish Mishra  
#  4    DevTSM    1.3         12/30/2002 5:41:34 PMDebashish Mishra Modified for
#       better monitoring of stby
#  3    DevTSM    1.2         10/31/2002 5:04:14 PMDebashish Mishra  
#  2    DevTSM    1.1         10/24/2002 3:39:56 PMDebashish Mishra  
#  1    DevTSM    1.0         8/1/2002 11:41:58 AM Debashish Mishra 
# $
# 
#############################################################
