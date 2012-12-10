#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: cold_backup_prod.ksh$ 
#
# $Revision: 5$        $Date: 10/13/2003 9:53:32 AM$
#
#
# Description:  cold backup of the production database
#
#############################################################
 
. /etc/profile

ORACLE_SID=prod;export ORACLE_SID
ORACLE_USER=backup_user
ORACLE_PWD=`get_pwd $ORACLE_USER`

     dest_dir=/orabackup/9i_coldbackup/tts

sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF  >/export/home/oracle/util/cb_datafile
set hea off
set feedback off
set pages 0
set lin 200
select 'cp '||name||' $dest_dir/data' from v\$datafile;
EOF

sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF  >>/export/home/oracle/util/cb_datafile
set hea off
set feedback off
set pages 0
set lin 200
select 'cp '||name||' $dest_dir/data' from v\$tempfile;
EOF

sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF  >/export/home/oracle/util/cb_controlfile
set hea off
set feedback off
set pages 0
set lin 200
select 'cp '||name||' $dest_dir/control' from v\$controlfile;
EOF

sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF  >/export/home/oracle/util/cb_logfile
set hea off
set feedback off
set pages 0
set lin 200
select 'cp '||member||' $dest_dir/redolog' from v\$logfile;
EOF

chmod 755 /export/home/oracle/util/cb_datafile
chmod 755 /export/home/oracle/util/cb_controlfile
chmod 755 /export/home/oracle/util/cb_logfile

#Shutdown the database

/u01/app/oracle/product/9.2.0/bin/sqlplus /nolog << EOF
connect / as sysdba
shutdown immediate
exit

EOF

#copy the database files


/export/home/oracle/util/cb_datafile
/export/home/oracle/util/cb_controlfile
/export/home/oracle/util/cb_logfile
cp /u01/app/oracle/admin/prod/pfile/initprod.ora $dest_dir/config
cp /u01/app/oracle/product/9.2.0/network/admin/tnsnames.ora $dest_dir/config
cp /u01/app/oracle/product/9.2.0/network/admin/listener.ora $dest_dir/config
mv /export/home/oracle/util/cb_datafile $dest_dir/config
mv /export/home/oracle/util/cb_controlfile $dest_dir/config
mv /export/home/oracle/util/cb_logfile $dest_dir/config


#Startup the database

/u01/app/oracle/product/9.2.0/bin/sqlplus /nolog << EOF
connect / as sysdba
startup pfile=/u01/app/oracle/admin/prod/pfile/initprod.ora
exit

EOF

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  5    DevTSM    1.4         10/13/2003 9:53:32 AMDebashish Mishra Modified after
#       replacing hard disk in production database server
#  4    DevTSM    1.3         6/30/2003 8:58:32 AM Debashish Mishra Modified after
#       space problems in production server
#  3    DevTSM    1.2         2/25/2003 12:40:52 PMDebashish Mishra  
#  2    DevTSM    1.1         8/5/2002 1:54:52 PM  Debashish Mishra Modified for
#       implementation of audit_trail
#  1    DevTSM    1.0         8/1/2002 11:41:34 AM Debashish Mishra 
# $
# 
#############################################################
