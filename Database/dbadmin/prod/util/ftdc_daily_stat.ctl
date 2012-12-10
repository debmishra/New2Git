load data
infile "/export/home/oracle/ftdc/ftdc_daily_stat.dat"
append
into table ftdc_daily_stat
fields terminated by "|" optionally enclosed by '"' 
trailing nullcols
(
DATE_TIME     "to_date(trim(:DATE_TIME),'mm/dd/yyyy/hh24:mi:ss')", 
TOTAL_PROD_USERS 		"trim(:TOTAL_PROD_USERS)",              
FTS_PROD_USERS                  "trim(:FTS_PROD_USERS)",
TOTAL_NON_PROD_USERS            "trim(:TOTAL_NON_PROD_USERS)",
TOTAL_NON_PROD_FTS_USERS        "trim(:TOTAL_NON_PROD_FTS_USERS)",
TOTAL_PROD_TRIALS               "trim(:TOTAL_PROD_TRIALS)",
FTS_PROD_TRIALS                 "trim(:FTS_PROD_TRIALS)",
TOTAL_NON_PROD_TRIALS           "trim(:TOTAL_NON_PROD_TRIALS)",
TOTAL_NON_PROD_FTS_TRIALS       "trim(:TOTAL_NON_PROD_FTS_TRIALS)",
USED_DB_DISKSPACE_GB            "trim(:USED_DB_DISKSPACE_GB)",
FREE_DB_DISKSPACE_GB            "trim(:FREE_DB_DISKSPACE_GB)"
)
