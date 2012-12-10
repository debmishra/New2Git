load data
infile "/export/home/oracle/ftdc/ftdc_concurrent_users.dat"
append
into table ftdc_concurrent_user_stat
fields terminated by " " optionally enclosed by '"' 
trailing nullcols
(
DATE_TIME     "to_date(trim(:DATE_TIME),'mm/dd/yy/hh24:mi:ss')",
CONCURRENT_USERS		"trim(:CONCURRENT_USERS)"
)
