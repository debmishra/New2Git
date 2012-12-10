if test $# -lt 6
then echo "Usage: grant_permissions.ksh <table_name> <masterschema> <passwd> <clientschema> <passwd> <connect_string>"
exit
fi

sqlplus -s $2/$3@$6 << EOF
grant select,references on $1 to $4;
exit;
EOF

sqlplus -s $4/$5@$6 << EOF
drop synonym $1;
create synonym $1 for $2.$1;
exit;
EOF