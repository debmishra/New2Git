load data
infile "/export/home/oracle/dataload/data/run_user.dat"
append
into table run_user
fields terminated by "|" optionally enclosed by '"' 
trailing nullcols
(
USER_NAME 	"trim(:USER_NAME)",
USER_PWD        "trim(:USER_PWD)",
CLIENT_DIV      "trim(:CLIENT_DIV)",
PRODUCT        	"trim(:PRODUCT)",
SCENARIO 	"trim(:SCENARIO)",
RUN_DURATION 	"trim(:RUN_DURATION)"
)
