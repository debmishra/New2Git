#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: failover_ph1.ksh$ 
#
# $Revision: 4$        $Date: 2/27/2008 3:18:13 PM$
#
#
# Description:  <ADD>
#
#############################################################
 
#*******************
#Disable the cronjob
#*******************

# shutdown the database

sqlplus /nolog << EOF
connect / as sysdba
shutdown immediate
EOF


# copy data files

cp /r02/oracle/oradata/prod/system01.dbf  /r02/oracle/oradata/prod/system01.dbf.bkp
cp /r02/oracle/oradata/prod/undotbs01.dbf  /r02/oracle/oradata/prod/undotbs01.dbf.bkp
cp /r02/oracle/oradata/prod/cwmlite01.dbf  /r02/oracle/oradata/prod/cwmlite01.dbf.bkp
cp /r02/oracle/oradata/prod/drsys01.dbf  /r02/oracle/oradata/prod/drsys01.dbf.bkp
cp /r03/oracle/oradata/prod/ftsmall01.dbf  /r03/oracle/oradata/prod/ftsmall01.dbf.bkp
cp /r03/oracle/oradata/prod/ftlarge01.dbf  /r03/oracle/oradata/prod/ftlarge01.dbf.bkp
cp /r02/oracle/oradata/prod/ftsmall_inx01.dbf  /r02/oracle/oradata/prod/ftsmall_inx01.dbf.bkp
cp /r02/oracle/oradata/prod/ftlarge_indx01.dbf  /r02/oracle/oradata/prod/ftlarge_indx01.dbf.bkp
cp /r03/oracle/oradata/prod/tsmsmall01.dbf  /r03/oracle/oradata/prod/tsmsmall01.dbf.bkp
cp /r03/oracle/oradata/prod/tsmlarge01.dbf  /r03/oracle/oradata/prod/tsmlarge01.dbf.bkp
cp /r02/oracle/oradata/prod/tsmsmall_inx01.dbf  /r02/oracle/oradata/prod/tsmsmall_inx01.dbf.bkp
cp /r02/oracle/oradata/prod/tsmlarge_indx01.dbf  /r02/oracle/oradata/prod/tsmlarge_indx01.dbf.bkp
cp /r02/oracle/oradata/prod/trialblob01.dbf  /r02/oracle/oradata/prod/trialblob01.dbf.bkp

# copy control files

cp /u01/app/oracle/oradata/prod/control01.ctl  /u01/app/oracle/oradata/prod/control01.ctl.bkp
cp /r02/oracle/oradata/prod/control02.ctl  /r02/oracle/oradata/prod/control02.ctl.bkp
cp /r03/oracle/oradata/prod/control03.ctl  /r03/oracle/oradata/prod/control03.ctl.bkp

# copy init file

cp /u01/app/oracle/admin/prod/pfile/initprod.ora  /u01/app/oracle/admin/prod/pfile/initprod.ora.bkp

# copy redologs

cp /r03/oracle/oradata/prod/redo3a.log  /r03/oracle/oradata/prod/redo3a.log.bkp
cp /u01/app/oracle/oradata/prod/redo3b.log  /u01/app/oracle/oradata/prod/redo3b.log.bkp
cp /r02/oracle/oradata/prod/redo2a.log  /r02/oracle/oradata/prod/redo2a.log.bkp
cp /r03/oracle/oradata/prod/redo2b.log  /r03/oracle/oradata/prod/redo2b.log.bkp
cp /u01/app/oracle/oradata/prod/redo1a.log  /u01/app/oracle/oradata/prod/redo1a.log.bkp
cp /r02/oracle/oradata/prod/redo1b.log  /r02/oracle/oradata/prod/redo1b.log.bkp


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
#  3    DevTSM    1.2         3/3/2005 6:35:42 AM  Debashish Mishra  
#  2    DevTSM    1.1         8/29/2003 5:19:39 PM Debashish Mishra  
#  1    DevTSM    1.0         6/4/2002 10:05:18 AM Debashish Mishra 
# $
# 
#############################################################
