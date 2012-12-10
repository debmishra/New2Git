#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: copy_stby_logs.ksh$ 
#
# $Revision: 8$        $Date: 6/7/2011 10:05:14 PM$
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
   echo "Previous copy of logs not completed. Long data transfer time. Will try it again after 15 minutes" | mailx -s COPY_SLOW "dmishra@mdsol.com"
   exit 1
fi
 
touch /u01/app/oracle/admin/prod/copy_in_progress

sqlplus -s backup_user/`get_pwd backup_user`  << EOF
Alter system switch logfile;
exit;
EOF

sleep 2
##mp##mv /arch/oracle/prod/*.log /arch/oracle/prod/temp/

if [[ `date +%H` -gt 20 ]]
then
rsh -l oracle rossvr4 "ls -ltr /arch/oracle/prod/arch_*.log | tail -1 | cut -f3 -d'_'" > /tmp/rossvr4_prod_seq.lst
else
rsh -l oracle rossvr4 "~/util/get_standby_logseq.ksh" > /tmp/rossvr4_prod_seq.lst
fi

standby_logseq_cnt=`cat /tmp/rossvr4_prod_seq.lst | grep [0-9] | cut -f 2`

cd /arch/oracle/prod/
for i in `ls arch_1_*.log`
do
file_logseq=`echo $i| cut -f3 -d'_'`
if [[ $file_logseq -gt $standby_logseq_cnt ]]
then
   cp $i temp/$i
fi
done

rcp /arch/oracle/prod/temp/*.log rossvr4:/arch/oracle/prod/

if [[ $? -gt 0 ]]
then
   echo "Archival copy failed. Please check logfile" | mailx -s "Archival copy failed" "4156862541@vtext.com dmishra@mdsol.com"
fi

sleep 10
mv /arch/oracle/prod/temp/*.log /orabackup/prod/hot/archive/
##mp##rm /arch/oracle/prod/temp/*.log

rm /u01/app/oracle/admin/prod/copy_in_progress

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  8    DevTSM    1.7         6/7/2011 10:05:14 PM Debashish Mishra  
#  7    DevTSM    1.6         8/11/2009 12:03:26 AMDebashish Mishra  
#  6    DevTSM    1.5         2/27/2008 3:21:50 PM Debashish Mishra  
#  5    DevTSM    1.4         3/3/2005 6:44:49 AM  Debashish Mishra  
#  4    DevTSM    1.3         10/13/2004 8:01:21 AMDebashish Mishra  
#  3    DevTSM    1.2         10/13/2003 9:53:33 AMDebashish Mishra Modified after
#       replacing hard disk in production database server
#  2    DevTSM    1.1         7/14/2003 5:10:36 PM Debashish Mishra  
#  1    DevTSM    1.0         2/25/2003 12:40:41 PMDebashish Mishra 
# $
# 
#############################################################
