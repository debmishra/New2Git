#!/bin/ksh
. /etc/profile
cd ~oracle
. ./.profile

export ORACLE_SID=devl
export dbconnect=ftdc/welcome

echo "Report Date: "`date`
echo " "
echo "User Data"
echo "========="
echo " "

echo "Total # of prod users: "`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select total_prod_users from ftdc_daily_stat 
where date_time = (select max(date_time) from ftdc_daily_stat);
EOF`

echo "Total # of FTS users in prod: "`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select fts_prod_users from ftdc_daily_stat 
where date_time = (select max(date_time) from ftdc_daily_stat);
EOF`

echo "Total # of non-prod users in prod servers: "`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select total_non_prod_users from ftdc_daily_stat 
where date_time = (select max(date_time) from ftdc_daily_stat);
EOF`

echo "Total # of non-prod FTS users in prod servers: "`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select total_non_prod_fts_users from ftdc_daily_stat 
where date_time = (select max(date_time) from ftdc_daily_stat);
EOF`

echo "Total # of users added to prod in last 7 days: "`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select a.total_prod_users-b.total_prod_users from
(select total_prod_users from ftdc_daily_stat  
where date_time = (select max(date_time) from ftdc_daily_stat)) a,
(select total_prod_users from ftdc_daily_stat  
where trunc(date_time) = (select trunc(max(date_time)-7) from ftdc_daily_stat)) b;
EOF`

echo "Total # of users added to non-prod environments in prod server in last 7 days: "`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select a.total_non_prod_users-b.total_non_prod_users from
(select total_non_prod_users from ftdc_daily_stat  
where date_time = (select max(date_time) from ftdc_daily_stat)) a,
(select total_non_prod_users from ftdc_daily_stat  
where trunc(date_time) = (select trunc(max(date_time)-7) from ftdc_daily_stat)) b;
EOF`

echo " "
echo "Note: Non-prod users in prod servers are because of training and demo environment"
echo " "

echo " "
echo "Concurrent Users"
echo "================"
echo " "
maxusers=`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select max(concurrent_users) from FTDC_CONCURRENT_USER_STAT
where date_time between trunc(sysdate-7) and trunc(sysdate);
EOF`

echo "Maximum number of concurrent users in last 7 days: `echo $maxusers`"

echo "Number of Minutes at the above mentioned usage level:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from FTDC_CONCURRENT_USER_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) 
and concurrent_users = $maxusers ;
EOF`

echo "Average number of concurrent users in last 7 days: "`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select round(avg(concurrent_users),2) from FTDC_CONCURRENT_USER_STAT
where date_time between trunc(sysdate-7) and trunc(sysdate);
EOF`


echo " "
echo "Trial Data"
echo "=========="
echo " "

echo "Total # of prod trials: "`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select total_prod_Trials from ftdc_daily_stat 
where date_time = (select max(date_time) from ftdc_daily_stat);
EOF`

echo "Total # of FTS trials in prod: "`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select fts_prod_Trials from ftdc_daily_stat 
where date_time = (select max(date_time) from ftdc_daily_stat);
EOF`

echo "Total # of Non-Prod trials in prod servers: "`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select total_non_prod_trials from ftdc_daily_stat 
where date_time = (select max(date_time) from ftdc_daily_stat);
EOF`

echo "Total # of Non-Prod FTS trials in prod servers: "`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select total_non_prod_fts_trials from ftdc_daily_stat 
where date_time = (select max(date_time) from ftdc_daily_stat);
EOF`

echo "Total # of trials added to prod in last 7 days: "`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select a.total_prod_trials-b.total_prod_trials from
(select total_prod_trials from ftdc_daily_stat  
where date_time = (select max(date_time) from ftdc_daily_stat)) a,
(select total_prod_trials from ftdc_daily_stat  
where trunc(date_time) = (select trunc(max(date_time)-7) from ftdc_daily_stat)) b;
EOF`

echo "Total # of trials added to non-prod environments in prod server in last 7 days: "`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select a.total_non_prod_trials-b.total_non_prod_trials from
(select total_non_prod_trials from ftdc_daily_stat  
where date_time = (select max(date_time) from ftdc_daily_stat)) a,
(select total_non_prod_trials from ftdc_daily_stat  
where trunc(date_time) = (select trunc(max(date_time)-7) from ftdc_daily_stat)) b;
EOF`

echo " "
echo "CPU/Memory/DiskSpace/T1 Usage"
echo "============================="
echo " "
echo "Note: CPU/Memory data is collected every minute (avg of last minute)"
echo " "
echo "Application Server in last 7 days"
echo "================================="

echo "Number of times CPU usage exceeded 10% capacity:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR1_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and cpu_idle_time < 90;
EOF`
echo "Number of times CPU usage exceeded 20% capacity:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR1_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and cpu_idle_time < 80;
EOF`
echo "Number of times CPU usage exceeded 30% capacity:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR1_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and cpu_idle_time < 70;
EOF`
echo "Number of times CPU usage exceeded 40% capacity:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR1_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and cpu_idle_time < 60;
EOF`
echo "Number of times CPU usage exceeded 50% capacity:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR1_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and cpu_idle_time < 50;
EOF`
echo "Number of times CPU usage exceeded 60% capacity:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR1_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and cpu_idle_time < 40;
EOF`
echo "Number of times CPU usage exceeded 70% capacity:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR1_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and cpu_idle_time < 30;
EOF`
echo "Number of times CPU usage exceeded 80% capacity:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR1_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and cpu_idle_time < 20;
EOF`
echo "Number of times CPU usage exceeded 90% capacity:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR1_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and cpu_idle_time < 10;
EOF`
echo "Number of times CPU usage exceeded 95% capacity:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR1_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and cpu_idle_time < 5;
EOF`
echo " "
echo "Number of times memory page scan rate exceeded 10 pages/second:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR1_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and scan_rate > 10;
EOF`
echo "Number of times memory page scan rate exceeded 20 pages/second:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR1_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and scan_rate > 20;
EOF`
echo "Number of times memory page scan rate exceeded 50 pages/second:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR1_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and scan_rate > 50;
EOF`
echo "Number of times memory page scan rate exceeded 100 pages/second:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR1_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and scan_rate > 100;
EOF`
echo "Number of times memory page scan rate exceeded 200 pages/second:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR1_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and scan_rate > 200;
EOF`
echo "Number of times memory page scan rate exceeded 500 pages/second:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR1_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and scan_rate > 500;
EOF`
echo "Number of times memory page scan rate exceeded 1000 pages/second:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR1_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and scan_rate > 1000;
EOF`
echo "Number of times memory page scan rate exceeded 2000 pages/second:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR1_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and scan_rate > 2000;
EOF`
echo "Number of times memory page scan rate exceeded 5000 pages/second:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR1_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and scan_rate > 5000;
EOF`

echo " "
echo "Database Server in last 7 days"
echo "=============================="

echo "Number of times CPU usage exceeded 10% capacity:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR2_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and cpu_idle_time < 90;
EOF`
echo "Number of times CPU usage exceeded 20% capacity:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR2_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and cpu_idle_time < 80;
EOF`
echo "Number of times CPU usage exceeded 30% capacity:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR2_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and cpu_idle_time < 70;
EOF`
echo "Number of times CPU usage exceeded 40% capacity:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR2_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and cpu_idle_time < 60;
EOF`
echo "Number of times CPU usage exceeded 50% capacity:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR2_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and cpu_idle_time < 50;
EOF`
echo "Number of times CPU usage exceeded 60% capacity:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR2_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and cpu_idle_time < 40;
EOF`
echo "Number of times CPU usage exceeded 70% capacity:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR2_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and cpu_idle_time < 30;
EOF`
echo "Number of times CPU usage exceeded 80% capacity:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR2_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and cpu_idle_time < 20;
EOF`
echo "Number of times CPU usage exceeded 90% capacity:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR2_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and cpu_idle_time < 10;
EOF`
echo "Number of times CPU usage exceeded 95% capacity:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR2_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and cpu_idle_time < 5;
EOF`
echo " "
echo "Number of times memory page scan rate exceeded 10 pages/second:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR2_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and scan_rate > 10;
EOF`
echo "Number of times memory page scan rate exceeded 20 pages/second:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR2_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and scan_rate > 20;
EOF`
echo "Number of times memory page scan rate exceeded 50 pages/second:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR2_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and scan_rate > 50;
EOF`
echo "Number of times memory page scan rate exceeded 100 pages/second:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR2_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and scan_rate > 100;
EOF`
echo "Number of times memory page scan rate exceeded 200 pages/second:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR2_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and scan_rate > 200;
EOF`
echo "Number of times memory page scan rate exceeded 500 pages/second:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR2_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and scan_rate > 500;
EOF`
echo "Number of times memory page scan rate exceeded 1000 pages/second:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR2_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and scan_rate > 1000;
EOF`
echo "Number of times memory page scan rate exceeded 2000 pages/second:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR2_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and scan_rate > 2000;
EOF`
echo "Number of times memory page scan rate exceeded 5000 pages/second:"`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from SMSSVR2_CPU_MEM_STAT 
where date_time between trunc(sysdate-7) and trunc(sysdate) and scan_rate > 5000;
EOF`

echo " "
echo "Used Diskspace in Database server (in GB): "`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select USED_DB_DISKSPACE_GB from ftdc_daily_stat 
where date_time = (select max(date_time) from ftdc_daily_stat);
EOF`
echo "Free Diskspace in Database server (in GB): "`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select FREE_DB_DISKSPACE_GB from ftdc_daily_stat 
where date_time = (select max(date_time) from ftdc_daily_stat);
EOF`

echo " "
echo "T1 bandwidth Usage(upload+download) in last 7 days"
echo "================================="
echo "Note: Data collected in approx. 5 minute interval"
echo " "

echo "Maximum T1 usage (in kbit):" `sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select max(in_kbits+out_kbits) from t1usage_stat
where date_time between trunc(sysdate-7) and trunc(sysdate) ;
EOF`
echo "Average T1 usage (in kbit):" `sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select avg(in_kbits+out_kbits) from t1usage_stat
where date_time between trunc(sysdate-7) and trunc(sysdate) ;
EOF`
echo " "
echo "Number of times T1 usage exceeded 0.2 Mbps: "`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from t1usage_stat
where date_time between trunc(sysdate-7) and trunc(sysdate)  and
(in_kbits+out_kbits)/1024 > .2;
EOF`
echo "Number of times T1 usage exceeded 0.4 Mbps: "`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from t1usage_stat
where date_time between trunc(sysdate-7) and trunc(sysdate)  and
(in_kbits+out_kbits)/1024 > .4;
EOF`
echo "Number of times T1 usage exceeded 0.6 Mbps: "`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from t1usage_stat
where date_time between trunc(sysdate-7) and trunc(sysdate)  and
(in_kbits+out_kbits)/1024 > .6;
EOF`
echo "Number of times T1 usage exceeded 0.8 Mbps: "`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from t1usage_stat
where date_time between trunc(sysdate-7) and trunc(sysdate)  and
(in_kbits+out_kbits)/1024 > .8;
EOF`
echo "Number of times T1 usage exceeded 1.0 Mbps: "`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from t1usage_stat
where date_time between trunc(sysdate-7) and trunc(sysdate)  and
(in_kbits+out_kbits)/1024 > 1;
EOF`
echo "Number of times T1 usage exceeded 1.2 Mbps: "`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from t1usage_stat
where date_time between trunc(sysdate-7) and trunc(sysdate)  and
(in_kbits+out_kbits)/1024 > 1.2;
EOF`
echo "Number of times T1 usage exceeded 1.4 Mbps: "`sqlplus -s $dbconnect << EOF
set feedback off
set pages 0
set hea off
select count(*) from t1usage_stat
where date_time between trunc(sysdate-7) and trunc(sysdate)  and
(in_kbits+out_kbits)/1024 > 1.4;
EOF`
echo " "
