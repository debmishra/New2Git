#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: load_emul_data.ksh$ 
#
# $Revision: 4$        $Date: 2/27/2008 3:18:16 PM$
#
#
# Description:  <ADD>
#
#############################################################
 
export load_ctl_dir=/export/home/oracle/dataload
export ORA_HOME=/export/home/oracle/orabase/product/9.0.1

rm -rf $load_ctl_dir/data/*

cp run.dat $load_ctl_dir/data/

$ORA_HOME/bin/sqlldr \
CONTROL=$load_ctl_dir/control/run.ctl, LOG=$load_ctl_dir/log/run.log, \
BAD=$load_ctl_dir/bad/run.bad, \
USERID=emul/welcome@devl 

runid1=`sqlplus -s emul/welcome@devl << EOF
set echo off
set feedback off
set hea off

select max(id) from run;
exit;
EOF`

runid=`echo $runid1`


sqlplus -s emul/welcome@devl << EOF
Alter table run_info modify(run_id null);
EOF


for filename in `ls *.perf`
do
cat $filename >> $load_ctl_dir/data/run_info.dat
done

$ORA_HOME/bin/sqlldr \
CONTROL=$load_ctl_dir/control/run_info.ctl, LOG=$load_ctl_dir/log/run_info.log, \
BAD=$load_ctl_dir/bad/run_info.bad, \
USERID=emul/welcome@devl 


sqlplus -s emul/welcome@devl << EOF

update run_info set run_id = $runid where run_id is null;
Alter table run_info modify(run_id not null);
EOF



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  4    DevTSM    1.3         2/27/2008 3:18:16 PM Debashish Mishra  
#  3    DevTSM    1.2         3/3/2005 6:36:01 AM  Debashish Mishra  
#  2    DevTSM    1.1         8/29/2003 5:19:46 PM Debashish Mishra  
#  1    DevTSM    1.0         2/4/2003 6:03:59 PM  Debashish Mishra 
# $
# 
#############################################################
