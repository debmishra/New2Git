#!/bin/ksh
touch /tmp/mp_test1.txt
rcp /tmp/mp_test1.txt rossvr41:/tmp/
if [[ $? -gt 0 ]]
then
   echo "Archival copy failed" | mailx -s "Archival copy failed" "mpasupuleti@mdsol.com 5105011758@txt.att.net"
fi

