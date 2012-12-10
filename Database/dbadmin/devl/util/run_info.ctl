load data
infile "/export/home/oracle/dataload/data/run_info.dat"
append
into table run_info
fields terminated by "|" optionally enclosed by '"' 
trailing nullcols
(
USER_NAME 	"trim(:USER_NAME)",
CLIENT_DIV      "trim(:CLIENT_DIV)",
PRODUCT        	"trim(:PRODUCT)",
ACTION_TYPE 	"trim(:ACTION_TYPE)",
ACTION_NAME 	"trim(:ACTION_NAME)",
COMMENTS   	"trim(:COMMENTS)" ,
DURATION 	"trim(:DURATION)",       
START_TIME   	"to_date(trim(:START_TIME), 'MM/DD/YYYY HH24:MI:SS')",  
END_TIME   	"to_date(trim(:END_TIME), 'MM/DD/YYYY HH24:MI:SS')"    
)
