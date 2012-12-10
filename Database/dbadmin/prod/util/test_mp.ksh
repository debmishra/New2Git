cd /export/home/oracle
. /etc/profile
. ./.profile

mailinglist="5105011758@txt.att.net"
cclist="5105011758@txt.att.net"

echo "Test" | mailx -s "Test sms" $cclist $mailinglist
