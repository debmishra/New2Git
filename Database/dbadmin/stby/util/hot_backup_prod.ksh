#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: c:\tsm\Database\dbadmin\stby\util\hot_backup_prod.ksh$ 
#
# $Revision: 1$        $Date: 4/18/2011 8:06:47 AM$
#
#
# Description:  Take daily hot backup of the production database
#
#############################################################
. /etc/profile
cd ~oracle
. ./.profile
date 
#******************
#Define variables
#******************

DBNAME=prod
JOBNAME="/export/home/oracle/util/hot_backup_prod.ksh"
JOBNAME_SHORT="HOT_BACKUP_PROD"
BACKUP_BASE="/work/orabackup/prod/hot"
DBBACKUP="$BACKUP_BASE/scripts/dynpar.dat"
TSLIST="$BACKUP_BASE/scripts/tslist.dat"
BACKUPDIR="$BACKUP_BASE/data"
BACKUPDIR1="$BACKUP_BASE/data01"
BACKUPDIR2="$BACKUP_BASE/data02"
BACKUPDIR3="$BACKUP_BASE/data03"
BACKUPCTL="$BACKUP_BASE/ctl"
CKSUM="/bin/cksum"
CMP="/bin/cmp"
ARC="/arch/oracle/prod/donotdelete"
ARCOLD="$BACKUP_BASE/archive"
ARCERR="${JOBNAME_SHORT} : fatal error in archivelog copy"
CKSUM_VALUE_WAR="${JOBNAME_SHORT} : Warning in cksum value comparison"
CKSUM_VALUE_ERR="${JOBNAME_SHORT} : fatal error in cksum value comparison"
CKSUM_SIZE_ERR="${JOBNAME_SHORT} :  fatal error in cksum size comparison"
DIFFERR="${JOBNAME_SHORT} : fatal error in archive cksum comparison"
CMP_ERR="${JOBNAME_SHORT} : fatal error during cmp"
DB_USER=backup_user
DB_PWD=`get_pwd $DB_USER`
THISNODE=`uname -n`

# Initialize this variable to some tablespace name which is not existing in the database
CURRENT_TS="CURRENT"

#node specific logic

if [ "$THISNODE" = "rossvr4" ] 
  then TMP=/tmp
fi

#***********************************
#Check the current status of oracle
#***********************************

STATUS=`ps -fu oracle | grep $DBNAME | grep ora_ | grep -v grep`

if [ $? != 0 ];then
   echo "${JOBNAME_SHORT} : Error - database is not online "
   echo "${JOBNAME_SHORT} : process listing is to follow ... "
   echo "${JOBNAME_SHORT} : ps -fu oracle | grep $DBNAME | grep ora_ | grep -v grep"
   ps -fu oracle | grep $DBNAME | grep ora_ | grep -v grep
   echo "${JOBNAME_SHORT} : exiting. "
   exit
fi


#*********************************
#build the dynamic parameter files
#*********************************

echo "${JOBNAME_SHORT} : building dynamic parameter file. "
sqlplus -s $DB_USER/$DB_PWD > $DBBACKUP <<EOF
	set pagesize 0
	set linesize 2048
	set heading off
	set feedback off
	column TNAME format a20
	column FNAME format a80
        select tablespace_name TNAME, file_name FNAME,
          ' $BACKUPDIR'||substr(file_name,instr(translate(file_name,'1234567890','0000000000'),'0'),
                  instr(file_name,'/',1,2)-instr(translate(file_name,'1234567890','0000000000'),'0'))
          from sys.dba_data_files order by tablespace_name,file_name;
        exit
EOF
DYNSIZE=`ls -al $DBBACKUP|awk '{print $5}'`

if [ $DYNSIZE = 0 ]; then
	echo "${JOBNAME_SHORT} : fatal error during backup file creation : Backup aborting."
	echo "${JOBNAME_SHORT} : cat $DBBACKUP "
	cat $DBBACKUP
	exit
fi

echo "${JOBNAME_SHORT} : building list of tablespaces. "
sqlplus -s $DB_USER/$DB_PWD > $TSLIST <<EOF
	set pagesize 0
	set linesize 2048
	set heading off
	set feedback off
	column TNAME format a20
	column FNAME format a80
        select tablespace_name TNAME  from sys.dba_tablespaces where contents <> 'TEMPORARY' ;
        exit
EOF
cat $TSLIST

#***************************
#Delete the old backup files
#***************************


echo "${JOBNAME_SHORT} : Deleting the previous backup.... "

if [ -f $BACKUPDIR1/*.dbf ] ; then rm $BACKUPDIR1/*.dbf ; fi
if [ -f $BACKUPDIR2/*.dbf ] ; then rm $BACKUPDIR2/*.dbf ; fi
if [ -f $BACKUPDIR3/*.dbf ] ; then rm $BACKUPDIR3/*.dbf ; fi
if [ -f $BACKUPCTL/*.ctl ] ; then rm $BACKUPCTL/*.ctl ; fi

#**********************************************************
#Begin actual backup and put the tablespaces in backup mode
#**********************************************************

echo "${JOBNAME_SHORT} : Starting hot backup using $DBBACKUP "

sqlplus /nolog << EOF
connect / as sysdba
select * from v\$BACKUP;
exit
EOF

cat $TSLIST | while read TABLESPACE
 do
sqlplus /nolog << EOF
connect / as sysdba
alter tablespace $TABLESPACE end backup;
exit
EOF
 done

cat $DBBACKUP | while read TABLESPACE FILE DIR
  do
   if [ $CURRENT_TS = "CURRENT" ]; then
sqlplus /nolog << EOF
connect / as sysdba
alter tablespace $TABLESPACE begin backup;
exit
EOF
  fi

  if [ $CURRENT_TS != `eval echo \$TABLESPACE` ]; then

sqlplus /nolog << EOF
connect / as sysdba
alter tablespace $CURRENT_TS end backup;
exit
EOF
    CURRENT_TS=`eval echo \$TABLESPACE`
sqlplus /nolog << EOF
connect / as sysdba
alter tablespace $TABLESPACE begin backup;
exit
EOF

  fi

#*******************************************************
#copy the database file, verify sizes, do checksums etc.
#*******************************************************

BACKUPDIR=`eval echo \$DIR`
echo "${JOBNAME_SHORT} : cp $FILE $BACKUPDIR "
cp $FILE $BACKUPDIR
STATUS=$?
if [ "$STATUS" != 0 ]; then
  echo "${JOBNAME_SHORT} : error during file copy $FILE "
fi

DATAFILE=`basename $FILE`
echo "${JOBNAME_SHORT} : $CKSUM $FILE $BACKUPDIR/$DATAFILE "
$CKSUM $FILE $BACKUPDIR/$DATAFILE
CKSUM_OUT=`$CKSUM $FILE $BACKUPDIR/$DATAFILE`
echo $CKSUM_OUT | read VALUE1 SIZE1 NAME1 VALUE2 SIZE2 NAME2

if [ "$VALUE1" != "$VALUE2" ]; then
   echo "$CKSUM_VALUE_WAR"
fi
if [ "$SIZE1" != "$SIZE2" ]; then
   echo "$CKSUM_SIZE_ERR"
fi

done


#*********************************
#Check the hot backup status again
#*********************************

sqlplus /nolog << EOF
connect / as sysdba
select * from v\$BACKUP;
exit
EOF

cat $TSLIST | while read TABLESPACE
 do
sqlplus /nolog << EOF
connect / as sysdba
alter tablespace $TABLESPACE end backup;
exit
EOF
 done



#*******************
#Backup control file
#*******************

echo "${JOBNAME_SHORT} : backing up controlfile to $BACKUPCTL/${DBNAME}_control01.ctl "

sqlplus /nolog << EOF
connect / as sysdba
alter database backup controlfile to '$BACKUPCTL/${DBNAME}_control01.ctl';
alter system switch logfile;
exit
EOF

sleep 120

if [ -f $ARCOLD/*.arc ]; then
  echo "   "
  echo "${JOBNAME_SHORT} : Delete previous backuparchive logs... "
#  ls -l $ARCOLD/*.arc
  for I in $ARCOLD/*.arc
   do
#     ls -l $I
     ARCNAME=`basename $I`
#     rm $ARCOLD/$ARCNAME
     STATUS="$?"
     if [ $STATUS != 0 ];then
        echo "${JOBNAME_SHORT} : error deleting old archive log : $ARCOLD/$ARCNAME "
     fi
   done
else echo "   "
     echo "${JOBNAME_SHORT} : No old archivelogs to delete. "
fi

if [ -f $ARC/*.arc ]; then
   echo "   "
   echo "${JOBNAME_SHORT} : copying archivelogs... "
   for I in $ARC/*.arc
     do
#       ls -l $I
       ARCNAME=`basename $I`
       echo "${JOBNAME_SHORT} : cp $ARC/$ARCNAME $ARCOLD"
       cp $ARC/$ARCNAME $ARCOLD
       STATUS="$?"
       if [ "$STATUS" != 0 ]; then
         echo "$ARCERR"
       fi
       echo "${JOBNAME_SHORT} : $CMP $ARC/$ARCNAME $ARCOLD/$ARCNAME"
       $CMP $ARC/$ARCNAME $ARCOLD/$ARCNAME
       STATUS="$?"
       if [ "$STATUS" != 0 ]; then
         echo "$CMP_ERR"
         echo "${JOBNAME_SHORT} : Archive log deletion skipped"
       else 
         echo "${JOBNAME_SHORT} : $CKSUM $ARC/$ARCNAME $ARCOLD/$ARCNAME"
         $CKSUM $ARC/$ARCNAME $ARCOLD/$ARCNAME
         CKSUM_OUT=`$CKSUM $ARC/$ARCNAME $ARCOLD/$ARCNAME`
         echo $CKSUM_OUT | read VALUE1 SIZE1 NAME1 VALUE2 SIZE2 NAME2
           if [ "$VALUE1" != "$VALUE2" -o "$SIZE1" != "$SIZE2" ]; then
             echo "$DIFFERR"
             echo "${JOBNAME_SHORT} : Archive log deletion skipped"
           else
#             rm $ARC/$ARCNAME
             if [ $? != 0 ]; then
               echo "${JOBNAME_SHORT} : Archive deletion failed"
             fi
           fi
       fi
    done
else echo "${JOBNAME_SHORT} : found no archives to copy. "
fi
date

echo "Hot backup completed"



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  1    DevTSM    1.0         4/18/2011 8:06:47 AM Debashish Mishra 
# $
# 
#############################################################