load data
infile "/export/home/oracle/ftdc/t1usage.dat"
append
into table t1usage_stat
fields terminated by "," optionally enclosed by '"' 
trailing nullcols
(
DATE_TIME     "to_date(trim(:DATE_TIME),'mm/dd/yy hh24:mi')",
IN_KBITS	"trim(:IN_KBITS)",
OUT_KBITS	"trim(:OUT_KBITS)"
)
