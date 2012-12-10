#!/bin/ksh
. /etc/profile

if [[ `ps -ef | grep ora_pmon_prod| grep -v grep | wc -l` -ne 1 ]]
 then
   echo "Production database is down" | mailx -s "Prod DB down" "dmishra@mdsol.com"
   echo "Production database is down" | mailx -s "Prod DB down" "4156862541@vtext.com"
fi
 
if [[ `ps -ef | grep ora_pmon_pr| grep -v grep | wc -l` -gt 0 ]]
 then
   echo "Listener is up and running fine" 
else
   echo "Production listener is down" | mailx -s "Prod Listener down" "dmishra@mdsol.com"
   echo "Production listener is down" | mailx -s "Prod Listener down" "4156862541@vtext.com"
fi

exit 1
