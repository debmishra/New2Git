#!/bin/ksh
. /etc/profile

email="dmishra@mdsol.com mpasupuleti@mdsol.com"
pager="4156862541@vtext.com 5105011758@tmomail.net"

if [[ `ps -ef | grep ora_pmon_pr| grep -v grep | wc -l` -ne 1 ]]
 then
   echo "Production database is down" | mailx -s "Stby DB down" $email
   echo "Production database is down" | mailx -s "Stby DB down" $pager
fi

exit 1
