
GRANT UPDATE (name,email,imed_name,imed_id,imed_key) ON ftuser TO ftcommon;


--******************************************************
--Implemented upto this in devl,d002,d003,d004,d005 on 09/28/2010
--Implemented upto this in q002,q005 on 09/28/2010
--******************************************************

CREATE UNIQUE INDEX FTUSER_INDX2
ON ftuser (CASE WHEN client_div_id is not null AND imed_id is not null 
THEN client_div_id||'-'||imed_id ELSE NULL END)
/

--******************************************************
--Implemented upto this in Q002 on 10/04/2010
--Implemented upto this in Q003 on 11/03/2010
--Implemented upto this in Q004 on 11/05/2010
--Implemented upto this in perf on 11/15/2010
--******************************************************



