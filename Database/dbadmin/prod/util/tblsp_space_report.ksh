#!/bin/ksh
#
#############################################################
cd /export/home/oracle
. /etc/profile
. ./.profile

mailinglist="dmishra@mdsol.com"
sender="noreply@mdsol.com"

export ORACLE_SID=$1
export current_date=`date`
#sqlplus -s system/`get_pwd system` <<EOF 
sqlplus -s / as sysdba <<EOF 

set feedback off
set lin 300
set pages 1000
alter session set nls_date_format='DD-MON-YYYY HH24:MI';
set markup html on 
spool /export/home/oracle/log/tblsp_space_report.html

set heading off
ttitle left 'Report run date: '_DATE' PDT' SKIP 2 -
       center bold 'TABLESPACE free space report';
set heading on

select a.tablespace_name, a.max_size, a.allocated_size,a.used_size, b.max_free,
decode(a.max_size,0,b.total_free,a.max_size-a.allocated_size+b.total_free) "Total Free"
from (select tablespace_name,sum(bytes)/(1024*1024) allocated_size,
sum(maxbytes)/(1024*1024) max_size, sum(user_bytes/1024/1024) used_size from dba_data_files
group by tablespace_name) a,(
select tablespace_name,sum(bytes)/(1024*1024) total_free,
max(bytes)/(1024*1024) max_free from dba_free_space
group by tablespace_name) b where
a.tablespace_name=b.tablespace_name(+)
order by "Total Free" asc;

spool off
set markup html off;
exit;
EOF

cat /export/home/oracle/log/tblsp_space_report.html | \
uuencode $1_tblsp_size.html | mailx -s "$1 database tablespace size" -r $sender $mailinglist
