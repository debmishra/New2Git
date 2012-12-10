#!/bin/ksh
#
# Description:  Backup production database parameter files
#
#############################################################
 
. /etc/profile

ORACLE_SID=prod;export ORACLE_SID
ORACLE_USER=backup_user
ORACLE_PWD=`get_pwd $ORACLE_USER`

dest_dir=/orabackup/prod/weekly_backup_files

rm /orabackup/prod/weekly_backup_files/controlfile_prod_bkup.ctl

sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF 
set hea off
set feedback off
set pages 0
set lin 200
ALTER DATABASE BACKUP CONTROLFILE TO '/orabackup/prod/weekly_backup_files/controlfile_prod_bkup.ctl';
EOF

cp /u01/app/oracle/product/10.2.0/dbs/initprod.ora $dest_dir/config
cp /u01/app/oracle/product/10.2.0/dbs/spfileprod.ora $dest_dir/config
cp /u01/app/oracle/product/10.2.0/network/admin/tnsnames.ora $dest_dir/config
cp /u01/app/oracle/product/10.2.0/network/admin/listener.ora $dest_dir/config

email="dmishra@mdsol.com 4156862541@vtext.com"
nopage="dmishra@mdsol.com"
pager="4156862541@vtext.com"

