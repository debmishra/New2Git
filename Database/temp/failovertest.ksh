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


#phase2 starts here

#*******************
#Disable the cronjob
#*******************

/export/home/oracle/recover_stbydb.ksh

mv /arch/oracle/prod/* /arch/oracle/prod_bkp/

sqlplus /nolog  << EOF
connect / as sysdba
ALTER DATABASE ACTIVATE STANDBY DATABASE;
shutdown immediate 
startup
ALTER TABLESPACE temp ADD
TEMPFILE '/r02/oracle/oradata/prod/temp01.dbf' SIZE 40M AUTOEXTEND ON;
EOF

# After this login to smssvr1 and issue the command "pkill java"
# and login to rossvr3 and issue the command init -6


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

