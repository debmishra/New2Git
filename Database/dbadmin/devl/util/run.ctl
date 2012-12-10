load data
infile "/export/home/oracle/dataload/data/run.dat"
append
into table run
fields terminated by "|" optionally enclosed by '"' 
trailing nullcols
(
RUN_DATE   	"to_date(trim(:RUN_DATE), 'MM/DD/YY HH24:MI:SS')",    
NUM_USERS  	"trim(:NUM_USERS)",    
RUNDIR     	"trim(:RUNDIR)",    
COMMENTS   	"trim(:COMMENTS)",    
NUM_CPU    	"trim(:NUM_CPU)",    
CPU_TYPE   	"trim(:CPU_TYPE)",    
MEMORY     	"trim(:MEMORY)",    
NETWORK_TYPE 	"trim(:NETWORK_TYPE)",
BUILD_ID	"trim(:BUILD_ID)"
)
