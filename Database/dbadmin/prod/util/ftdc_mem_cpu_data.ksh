#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: ftdc_mem_cpu_data.ksh$ 
#
# $Revision: 8$        $Date: 6/7/2011 10:05:15 PM$
#
#
# Description:  <ADD>
#
#############################################################
 
. /etc/profile
cd ~oracle
. ./.profile

export ORACLE_SID=prod

ftdc_dir=/export/home/oracle/ftdc
ORA_HOME=/u01/app/oracle/product/10.2.0
DB_USER=dmishra
DB_PWD=`get_pwd $DB_USER`

sarfile1=`$ORA_HOME/bin/sqlplus -s $DB_USER/$DB_PWD << EOF
set echo off
set feedback off
set hea off

select '/var/adm/sa/sa'||to_char(sysdate-1,'dd') from dual;
exit;
EOF`

sarfile=`echo $sarfile1`

rsh smssvr1 sar -f $sarfile | awk '{print $1,$5}'|grep -v Average|grep -v %idle|grep -v SunOS | grep -v 00:00: > $ftdc_dir/smssvr1_cpu
rsh smssvr1 sar -g -f $sarfile | awk '{print $1,$5}'|grep -v Average|grep -v pgscan|grep -v SunOS | grep -v 00:00: > $ftdc_dir/smssvr1_mem
sar -f $sarfile | awk '{print $1,$5}'|grep -v Average|grep -v %idle|grep -v SunOS | grep -v 00:00: > $ftdc_dir/smssvr2_cpu
sar -g -f $sarfile | awk '{print $1,$5}'|grep -v Average|grep -v pgscan|grep -v SunOS | grep -v 00:00: > $ftdc_dir/smssvr2_mem

paste $ftdc_dir/smssvr1_cpu $ftdc_dir/smssvr1_mem | awk '{print $1,$2,$4}' > $ftdc_dir/smssvr1_cpu_mem.dat
paste $ftdc_dir/smssvr2_cpu $ftdc_dir/smssvr2_mem | awk '{print $1,$2,$4}' > $ftdc_dir/smssvr2_cpu_mem.dat

used_space=0
free_space=0

for used in `df -k | grep -v "/tmp" | grep -v "/arch" | grep -v used | awk '{print $3}'`
do
used_space=`expr $used_space + $used`
done
export used_space

for free in `df -k | grep -v "/tmp" | grep -v "/arch" | grep -v used | awk '{print $4}'`
do
free_space=`expr $free_space + $free`
done
export free_space

sqlplus -s $DB_USER/$DB_PWD << EOF > $ftdc_dir/ftdc_daily_stat.dat
set hea off
set feedback off
set lin 1000
set pages 0
select to_char(sysdate,'mm/dd/yyyy/hh24:mi:ss')||'|'||a.cnt||'|'||d.cnt||'|'||(b.cnt+c.cnt)||'|'||(e.cnt+f.cnt)||'|'||g.cnt||'|'||j.cnt||'|'||(h.cnt+i.cnt)||'|'||(k.cnt+l.cnt)||'|'||round($used_space/(1024*1024),2)||'|'||round($free_space/(1024*1024),2) daily_stat
from
(select count(*) cnt from tsm10.ftuser) a,
(select count(*) cnt from tsm10e.ftuser) b,
(select count(*) cnt from tsm10d.ftuser) c,
(select count(*) cnt from tsm10.ftuser where client_div_id = 0) d,
(select count(*) cnt from tsm10e.ftuser where client_div_id = 0) e,
(select count(*) cnt from tsm10d.ftuser where client_div_id = 0) f,
(select count(*) cnt from tsm10.trial where created_by in('PICASE','TRACE')) g,
(select count(*) cnt from tsm10e.trial where created_by in('PICASE','TRACE')) h,
(select count(*) cnt from tsm10d.trial where created_by in('PICASE','TRACE')) i,
(select count(*) cnt from tsm10.trial where client_div_id = 0 and  created_by in('PICASE','TRACE')) j,
(select count(*) cnt from tsm10e.trial where client_div_id = 0 and  created_by in('PICASE','TRACE')) k,
(select count(*) cnt from tsm10d.trial where client_div_id = 0 and  created_by in('PICASE','TRACE')) l;
EOF



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  8    DevTSM    1.7         6/7/2011 10:05:15 PM Debashish Mishra  
#  7    DevTSM    1.6         8/11/2009 12:03:27 AMDebashish Mishra  
#  6    DevTSM    1.5         2/27/2008 3:21:50 PM Debashish Mishra  
#  5    DevTSM    1.4         3/3/2005 6:44:55 AM  Debashish Mishra  
#  4    DevTSM    1.3         10/13/2004 8:01:23 AMDebashish Mishra  
#  3    DevTSM    1.2         10/13/2003 9:53:35 AMDebashish Mishra Modified after
#       replacing hard disk in production database server
#  2    DevTSM    1.1         9/9/2003 8:25:15 AM  Debashish Mishra  
#  1    DevTSM    1.0         5/21/2003 3:15:29 PM Debashish Mishra 
# $
# 
#############################################################

