#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: failover_ph3.ksh$ 
#
# $Revision: 4$        $Date: 2/27/2008 3:18:13 PM$
#
#
# Description:  <ADD>
#
#############################################################
 
#phase3 starts here

sqlplus /nolog << EOF
conn / as sysdba
shutdown immediate
EOF

rm /r02/oracle/oradata/prod/temp01.dbf
rm /arch/oracle/prod/* 
mv /arch/oracle/prod_bkp/* /arch/oracle/prod/


# move back the data files

mv /r02/oracle/oradata/prod/system01.dbf.bkp  /r02/oracle/oradata/prod/system01.dbf
mv /r02/oracle/oradata/prod/undotbs01.dbf.bkp  /r02/oracle/oradata/prod/undotbs01.dbf
mv /r02/oracle/oradata/prod/cwmlite01.dbf.bkp  /r02/oracle/oradata/prod/cwmlite01.dbf
mv /r02/oracle/oradata/prod/drsys01.dbf.bkp  /r02/oracle/oradata/prod/drsys01.dbf
mv /r03/oracle/oradata/prod/ftsmall01.dbf.bkp  /r03/oracle/oradata/prod/ftsmall01.dbf
mv /r03/oracle/oradata/prod/ftlarge01.dbf.bkp  /r03/oracle/oradata/prod/ftlarge01.dbf
mv /r02/oracle/oradata/prod/ftsmall_inx01.dbf.bkp  /r02/oracle/oradata/prod/ftsmall_inx01.dbf
mv /r02/oracle/oradata/prod/ftlarge_indx01.dbf.bkp  /r02/oracle/oradata/prod/ftlarge_indx01.dbf
mv /r03/oracle/oradata/prod/tsmsmall01.dbf.bkp  /r03/oracle/oradata/prod/tsmsmall01.dbf
mv /r03/oracle/oradata/prod/tsmlarge01.dbf.bkp  /r03/oracle/oradata/prod/tsmlarge01.dbf
mv /r02/oracle/oradata/prod/tsmsmall_inx01.dbf.bkp  /r02/oracle/oradata/prod/tsmsmall_inx01.dbf
mv /r02/oracle/oradata/prod/tsmlarge_indx01.dbf.bkp  /r02/oracle/oradata/prod/tsmlarge_indx01.dbf
mv /r02/oracle/oradata/prod/trialblob01.dbf.bkp  /r02/oracle/oradata/prod/trialblob01.dbf

# move back control files
  
mv /u01/app/oracle/oradata/prod/control01.ctl.bkp  /u01/app/oracle/oradata/prod/control01.ctl
mv /r02/oracle/oradata/prod/control02.ctl.bkp  /r02/oracle/oradata/prod/control02.ctl
mv /r03/oracle/oradata/prod/control03.ctl.bkp  /r03/oracle/oradata/prod/control03.ctl

# move back init files
  
mv /u01/app/oracle/admin/prod/pfile/initprod.ora.bkp  /u01/app/oracle/admin/prod/pfile/initprod.ora

#move back redo files
  
mv /r03/oracle/oradata/prod/redo3a.log.bkp  /r03/oracle/oradata/prod/redo3a.log
mv /u01/app/oracle/oradata/prod/redo3b.log.bkp  /u01/app/oracle/oradata/prod/redo3b.log
mv /r02/oracle/oradata/prod/redo2a.log.bkp  /r02/oracle/oradata/prod/redo2a.log
mv /r03/oracle/oradata/prod/redo2b.log.bkp  /r03/oracle/oradata/prod/redo2b.log
mv /u01/app/oracle/oradata/prod/redo1a.log.bkp  /u01/app/oracle/oradata/prod/redo1a.log
mv /r02/oracle/oradata/prod/redo1b.log.bkp  /r02/oracle/oradata/prod/redo1b.log

sqlplus /nolog << EOF
connect / as sysdba
startup nomount
Alter database mount standby database;
EOF

#*******************
#Enable the cronjob
#*******************


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  4    DevTSM    1.3         2/27/2008 3:18:13 PM Debashish Mishra  
#  3    DevTSM    1.2         3/3/2005 6:35:45 AM  Debashish Mishra  
#  2    DevTSM    1.1         8/29/2003 5:19:40 PM Debashish Mishra  
#  1    DevTSM    1.0         6/4/2002 10:05:18 AM Debashish Mishra 
# $
# 
#############################################################
