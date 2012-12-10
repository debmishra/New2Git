#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: c:\tsm\Database\dbadmin\stby\util\cold_backup_prod.ksh$ 
#
# $Revision: 1$        $Date: 4/18/2011 8:06:46 AM$
#
#
# Description:  cold backup of the production database
#
#############################################################
 
. /etc/profile

ORACLE_SID=prod;export ORACLE_SID
ORACLE_USER=backup_user
ORACLE_PWD=`get_pwd $ORACLE_USER`

#Check for the day to decide the destination directory for the backup

# if [[ $(date +%a) = Mon || $(date +%a) = Wed || $(date +%a) = Fri ]]
#   then
#     dest_dir=/work/orabackup/prod/mwf
# else
     dest_dir=/work/orabackup/prod/tts
     dest_dir2=/work/orabackup/prod/tts2

# fi

sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF  >/export/home/oracle/util/cb_datafile
set hea off
set feedback off
set pages 0
set lin 200
select 'cp '||name||' $dest_dir/data' from v\$datafile
where not name like '%/oracle/oradata/prod/tsmlarge%';
EOF

sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF  >>/export/home/oracle/util/cb_datafile
set hea off
set feedback off
set pages 0
set lin 200
select 'cp '||name||' $dest_dir2/data' from v\$datafile
where name like '%/oracle/oradata/prod/tsmlarge%'
and not name like '%indx%';
EOF

sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF  >>/export/home/oracle/util/cb_datafile
set hea off
set feedback off
set pages 0
set lin 200
select 'cp '||name||' $dest_dir/data' from v\$datafile
where name like '%/oracle/oradata/prod/tsmlarge%'
and name like '%indx%';
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
#  1    DevTSM    1.0         4/18/2011 8:06:46 AM Debashish Mishra 
# $
# 
#############################################################
