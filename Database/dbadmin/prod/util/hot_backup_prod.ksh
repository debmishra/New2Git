#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: hot_backup_prod.ksh$ 
#
# $Revision: 11$        $Date: 6/7/2011 10:05:15 PM$
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
BACKUP_BASE="/orabackup/prod/hot"
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
	column TNAME format a30
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
	column TNAME format a30
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



#*********************
#Verify the hot backup
#*********************

. /etc/profile
cd ~oracle
. ./.profile

dest_dir=/orabackup/prod/hot/data02
dest_dir2=/orabackup/prod/hot/data03
log_dir=/export/home/oracle/log

email="dmishra@mdsol.com"
nopage="dmishra@mdsol.com"
pager="4156862541@vtext.com"

rm -rf $log_dir/verify_hot_backup.log

cd $dest_dir
for filename in `ls *.dbf`
do
$ORACLE_HOME/bin/dbv file=$filename blocksize=8192 >> $log_dir/verify_hot_backup.log 2>&1
done

cd $dest_dir2
for filename in `ls *.dbf`
do
$ORACLE_HOME/bin/dbv file=$filename blocksize=8192 >> $log_dir/verify_hot_backup.log 2>&1
done


if [[ `grep DBV- $log_dir/verify_hot_backup.log | wc -l` -ne 0 ]]
 then
   grep DBV- $log_dir/verify_hot_backup.log | mailx -s "Prod DBV Errors hot backup" $nopage
   echo 'DBV errors in prod hot backup' | mailx -s "Prod DBV Errors" $pager
fi

errcnt=0

for num1 in `grep 'Total Pages Failing' $log_dir/verify_hot_backup.log | cut -f2 -d: | cut -c2`
do
errcnt=`expr $errcnt + $num1`
done

for num2 in `grep 'Total Pages Marked Corrupt' $log_dir/verify_hot_backup.log | cut -f2 -d: | cut -c2`
do
errcnt=`expr $errcnt + $num2`
done

if [[ $errcnt -ne 0 ]] 
 then
   echo 'Block corruption in Prod hot backup'| mailx -s Block_corruption $email
fi




#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  11   DevTSM    1.10        6/7/2011 10:05:15 PM Debashish Mishra  
#  10   DevTSM    1.9         8/11/2009 12:03:27 AMDebashish Mishra  
#  9    DevTSM    1.8         2/27/2008 3:21:51 PM Debashish Mishra  
#  8    DevTSM    1.7         3/3/2005 6:44:56 AM  Debashish Mishra  
#  7    DevTSM    1.6         10/13/2004 8:01:24 AMDebashish Mishra  
#  6    DevTSM    1.5         1/7/2004 2:13:08 PM  Debashish Mishra Modified for
#       dbv & tsm10t
#  5    DevTSM    1.4         10/13/2003 9:53:36 AMDebashish Mishra Modified after
#       replacing hard disk in production database server
#  4    DevTSM    1.3         9/9/2003 8:25:15 AM  Debashish Mishra  
#  3    DevTSM    1.2         2/25/2003 12:40:54 PMDebashish Mishra  
#  2    DevTSM    1.1         8/5/2002 1:54:53 PM  Debashish Mishra Modified for
#       implementation of audit_trail
#  1    DevTSM    1.0         8/1/2002 11:41:35 AM Debashish Mishra 
# $
# 
#############################################################
