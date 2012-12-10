. /etc/profile

ORACLE_SID=perf;export ORACLE_SID
ORACLE_USER=system
ORACLE_PWD=cdn492

     dest_dir=/orabackup/perf_cold_bkup

sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF  >>/export/home/oracle/util/cb_datafile
set hea off
set feedback off
set pages 0
set lin 200
select 'cp '||name||' $dest_dir/data' from v\$datafile;
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

/u01/app/oracle/product/10.2.0/bin/sqlplus /nolog << EOF
connect / as sysdba
shutdown immediate
exit

EOF

#copy the database files


/export/home/oracle/util/cb_datafile
/export/home/oracle/util/cb_controlfile
/export/home/oracle/util/cb_logfile
cp /u01/app/oracle/product/10.2.0/dbs/initperf.ora $dest_dir/config
cp /u01/app/oracle/product/10.2.0/dbs/spfileperf.ora $dest_dir/config
cp /u01/app/oracle/product/10.2.0/dbs/orapwperf $dest_dir/config
cp /u01/app/oracle/product/10.2.0/network/admin/tnsnames.ora $dest_dir/config
cp /u01/app/oracle/product/10.2.0/network/admin/listener.ora $dest_dir/config
mv /export/home/oracle/util/cb_datafile $dest_dir/config
mv /export/home/oracle/util/cb_controlfile $dest_dir/config
mv /export/home/oracle/util/cb_logfile $dest_dir/config
