#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: archive_audit_log.ksh$ 
#
# $Revision: 12$        $Date: 6/7/2011 10:05:13 PM$
#
#
# Description:  <ADD>
#
#############################################################
. /etc/profile


export ORACLE_SID=prod

export ORACLE_USER=backup_user
export ORACLE_PWD=`get_pwd $ORACLE_USER`


sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF

Insert into dmishra.aud_tab(SESSIONID,ENTRYID,        
STATEMENT,NTIMESTAMP#,USERID,USERHOST,TERMINAL,       
ACTION#,RETURNCODE,OBJ\$CREATOR,OBJ\$NAME,      
AUTH\$PRIVILEGES,AUTH\$GRANTEE,NEW\$OWNER,NEW\$NAME,       
SES\$ACTIONS,SES\$TID,LOGOFF\$LREAD,LOGOFF\$PREAD,   
LOGOFF\$LWRITE,LOGOFF\$DEAD,LOGOFF\$TIME,    
COMMENT\$TEXT,CLIENTID,SPARE1,SPARE2,OBJ\$LABEL,      
SES\$LABEL,PRIV\$USED,SESSIONCPU) 
select SESSIONID,ENTRYID,STATEMENT,NTIMESTAMP#,     
USERID,USERHOST,TERMINAL,ACTION#,RETURNCODE,     
OBJ\$CREATOR,OBJ\$NAME,AUTH\$PRIVILEGES,
AUTH\$GRANTEE,NEW\$OWNER,NEW\$NAME,SES\$ACTIONS,    
SES\$TID,LOGOFF\$LREAD,LOGOFF\$PREAD,LOGOFF\$LWRITE,  
LOGOFF\$DEAD,LOGOFF\$TIME,COMMENT\$TEXT,CLIENTID,       
SPARE1,SPARE2,OBJ\$LABEL,SES\$LABEL,PRIV\$USED,      
SESSIONCPU from sys.aud\$ where action# <> 100;

delete from sys.aud\$ where action# <> 100;

commit;

EOF

if [[ $(date +%a) = Sun ]]
   then

/u01/app/oracle/product/10.2.0/bin/exp USERID=$ORACLE_USER/$ORACLE_PWD \
TABLES=dmishra.aud_tab \
FILE=/orabackup/prod/audit_dump/audit_trail_prod.dmp \
LOG=/orabackup/prod/audit_dump/audit_trail_prod.log

mv /orabackup/prod/audit_dump/audit_trail_prod.dmp /orabackup/prod/audit_dump/audit_trail_prod.dmp.$(date +%m%d%y)
mv /orabackup/prod/audit_dump/audit_trail_prod.log /orabackup/prod/audit_dump/audit_trail_prod.log.$(date +%m%d%y)


sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF

truncate table dmishra.aud_tab;

EOF

fi





#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  12   DevTSM    1.11        6/7/2011 10:05:13 PM Debashish Mishra  
#  11   DevTSM    1.10        8/11/2009 12:03:24 AMDebashish Mishra  
#  10   DevTSM    1.9         2/27/2008 3:21:49 PM Debashish Mishra  
#  9    DevTSM    1.8         3/3/2005 6:44:46 AM  Debashish Mishra  
#  8    DevTSM    1.7         10/13/2004 8:01:17 AMDebashish Mishra  
#  7    DevTSM    1.6         10/13/2003 9:53:30 AMDebashish Mishra Modified after
#       replacing hard disk in production database server
#  6    DevTSM    1.5         9/9/2003 8:25:09 AM  Debashish Mishra  
#  5    DevTSM    1.4         2/25/2003 12:40:50 PMDebashish Mishra  
#  4    DevTSM    1.3         8/14/2002 1:34:42 PM Debashish Mishra  
#  3    DevTSM    1.2         8/5/2002 1:54:52 PM  Debashish Mishra Modified for
#       implementation of audit_trail
#  2    DevTSM    1.1         8/2/2002 11:31:50 AM Debashish Mishra Added the
#       truncate statement
#  1    DevTSM    1.0         8/2/2002 11:26:09 AM Debashish Mishra 
# $
# 
#############################################################
