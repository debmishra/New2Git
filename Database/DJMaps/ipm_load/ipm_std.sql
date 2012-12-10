truncate table "&1".ipm_std;


Insert into "&1".ipm_std
select ID,GEOGRAPHICAL_LOCATION,COUNTRY_GROUP,PHASE_ID,
MEAN_CPP,MEAN_CPV,STD_CPP,STD_CPV 
from tsm_stage.ipm_std ;
commit;
