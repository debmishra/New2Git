load data
infile "/export/home/oracle/ftdc/smssvr1_cpu_mem.dat"
append
into table smssvr1_cpu_mem_stat
fields terminated by " " optionally enclosed by '"' 
trailing nullcols
(
DATE_TIME     "to_date(to_char(sysdate-1,'mm/dd/yyyy/')||trim(:DATE_TIME),'mm/dd/yyyy/hh24:mi:ss')", 
CPU_IDLE_TIME "trim(:CPU_IDLE_TIME)",   
SCAN_RATE "trim(:SCAN_RATE)" 
)
