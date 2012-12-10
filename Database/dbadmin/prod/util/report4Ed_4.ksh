#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: report4Ed_4.ksh$ 
#
# $Revision: 8$        $Date: 6/7/2011 10:05:16 PM$
#
#
# Description:  <ADD>
#
#############################################################
cd /export/home/oracle
. /etc/profile
. ./.profile

###mailinglist="eseguine@mdsol.com lshields@mdsol.com spepe@mdsol.com mdanishefsky@mdsol.com"
mailinglist="trialplanning@mdsol.com"
#mailinglist="dmishra@fast-track.com"
cclist="dmishra@mdsol.com"
sender="noreply@mdsol.com"

export ORACLE_SID=prod
sqlplus -s tsm10/`get_pwd tsm10` <<EOF 

set heading off
set feedback off
set lin 300
set pages 1000
column name format a33
column id format a8
column user_name format a30
column last_login_date format a25
break on id
spool /export/home/oracle/log/Ed/IPTperUser.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' PDT"' from dual;
Select '"Detail Report of # of IPT created and saved by users in each Client Division"' from dual;
select '"ID","USER NAME","#IPT",' from dual;

select '"'||ID||'","'||USER_NAME||'","'||NUM_IPT||'",' from(
select c.client_div_identifier id,b.first_name||' '||b.last_name user_name,
count(*) "NUM_IPT" from ip_session a, ftuser b, client_div c where
a.client_div_id = c.id and a.creator_ftuser_id=b.id and
b.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id in (9,10)) and
c.id in (select client_div_id from client_div_to_lic_app where app_name='PICASE')
group by c.client_div_identifier, b.first_name||' '||b.last_name);

spool off
exit;
EOF

mv /export/home/oracle/log/Ed/IPTperUser.csv /export/home/oracle/log/Ed/IPTperUser_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/Ed/IPTperUser_$(date +%m%d%y).csv | \
uuencode IPTperUser_$(date +%m%d%y).csv | \
mailx -r $sender -s "Usage report - IPTperUser" -c $cclist $mailinglist

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  8    DevTSM    1.7         6/7/2011 10:05:16 PM Debashish Mishra  
#  7    DevTSM    1.6         8/11/2009 12:03:29 AMDebashish Mishra  
#  6    DevTSM    1.5         9/3/2008 11:58:49 AM Debashish Mishra  
#  5    DevTSM    1.4         2/27/2008 3:21:51 PM Debashish Mishra  
#  4    DevTSM    1.3         2/15/2007 4:48:08 PM Debashish Mishra  
#  3    DevTSM    1.2         9/6/2006 9:49:57 PM  Debashish Mishra  
#  2    DevTSM    1.1         4/17/2005 9:35:04 AM Debashish Mishra  
#  1    DevTSM    1.0         3/15/2005 7:17:01 PM Debashish Mishra 
# $
# 
#############################################################

