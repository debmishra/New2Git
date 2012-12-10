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
# $Revision: 2$        $Date: 6/7/2011 10:04:11 PM$
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
        echo "Standby db failed. Synchronization problem" | mailx -s STBY_FAILED dmishra@mdsol.com
        sleep 1
        echo "Standby failed" | mailx -s STBY_FAILED 4156862541@vtext.com
        touch /u01/app/oracle/admin/prod/stbymailsent
        exit 0
    fi
 fi

elif [[ $num11 -eq 0 ]]
   then

    if [[ -f /u01/app/oracle/admin/prod/stbyrecoverymailsent ]]
      then
        echo "Standby recovery not attempted. Synchronization problem" | mailx -s STBY_NOT_RECOVERED dmishra@mdsol.com
        exit 1
    else 
        echo "Standby recovery not attempted. Synchronization problem" | mailx -s STBY_NOT_RECOVERED dmishra@mdsol.com
        sleep 1
#        echo "Standby not recovered" | mailx -s STBY_NOT_RECOVERED 4156862541@vtext.com
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
        grep -v grep | mailx -s STBY_ORA_ERR dmishra@mdsol.com
        
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
#  2    DevTSM    1.1         6/7/2011 10:04:11 PM Debashish Mishra  
#  1    DevTSM    1.0         8/11/2009 12:04:24 AMDebashish Mishra 
# $
# 
#############################################################
