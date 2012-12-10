INSERT INTO client 
VALUES(0,'Dummy TSM client for trial.projectid not null constraint',null,8,'DUMMY','This application contains confidential information that may not be accessed or disclosed to anyone other than individuals who are currently under contract to perform clinical trial services. The information contained in this application may not be used for any purpose other than the conduct of clinical investigations.','DUMMY',null);

INSERT INTO client_div VALUES(-1,0,'Client_0',24,1,0,'Per Visit Budget','CDI-1',null,
24,29,0,'Med',0,null,0,1,'REF','SC','REF',1,25,'Entering',1,'PUSH',1,10,20,0,1,1,2,29,1,0,3,0,-1);

INSERT INTO tsm10.client_div VALUES(-1,0,'Client_0',24,1,0,'Per Visit Budget','CDI-1',null,
24,29,0,'Med',0,null,0,1,'REF','SC','REF',1,25,'Entering',1,10,'PUSH',1,20,0,1,1,2,29,1,0,3,0,-1);

alter table procedure_def_ext modify(value varchar2(4000));

create database link dblink_mp_q003 connect to tsm10 identified by abc using 'q003';

INSERT INTO procedure_Def_ext select * from procedure_Def_ext@dblink_mp_q003;
INSERT INTO procedure_ext_meta select * from procedure_ext_meta@dblink_mp_q003;

drop database link dblink_mp_q003;