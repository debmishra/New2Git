#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: cold_backup_prod_noDBV_NoStart.ksh$ 
#
# $Revision: 2$        $Date: 6/7/2011 10:04:10 PM$
#
#
# Description:  cold backup of the production database
#
#############################################################
 
. /etc/profile

ORACLE_SID=prod;export ORACLE_SID
ORACLE_USER=backup_user
ORACLE_PWD=`get_pwd $ORACLE_USER`

dest_dir=/orabackup/prod/tts

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

sqlplus /nolog << EOF
connect / as sysdba
shutdown immediate
exit

EOF

#copy the database files


/export/home/oracle/util/cb_datafile
/export/home/oracle/util/cb_controlfile
/export/home/oracle/util/cb_logfile
cp /u01/app/oracle/product/10.2.0/dbs/initprod.ora $dest_dir/config
cp /u01/app/oracle/product/10.2.0/dbs/spfileprod.ora $dest_dir/config
cp /u01/app/oracle/product/10.2.0/network/admin/tnsnames.ora $dest_dir/config
cp /u01/app/oracle/product/10.2.0/network/admin/listener.ora $dest_dir/config
mv /export/home/oracle/util/cb_datafile $dest_dir/config
mv /export/home/oracle/util/cb_controlfile $dest_dir/config
mv /export/home/oracle/util/cb_logfile $dest_dir/config



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  2    DevTSM    1.1         6/7/2011 10:04:10 PM Debashish Mishra  
#  1    DevTSM    1.0         8/11/2009 12:04:58 AMDebashish Mishra 
# $
# 
#############################################################
