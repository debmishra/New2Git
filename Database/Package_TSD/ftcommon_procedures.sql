--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ftcommon_procedures.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:08 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
create or replace procedure lock_ftuser
(schemaname in varchar2, username in varchar2, lock_value in number)
as
mysql_stmt varchar2(200);
table_name varchar2(70);
begin
table_name:=schemaname||'.ftuser';
mysql_stmt:='Update '||table_name||' set locked=:1 where name=:2';
execute immediate mysql_stmt using lock_value, username;
commit;
end;
/
sho err

create or replace procedure FailedLoginAttempts
(schemaname in varchar2, username in varchar2)
as
mysql_stmt varchar2(200);
table_name varchar2(70);

begin

table_name:=schemaname||'.ftuser';
mysql_stmt:='Update '||table_name||' set failed_login_attempts=nvl(failed_login_attempts,0)+1 where name=:1';
execute immediate mysql_stmt using username;

commit;
end;
/
sho err





exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:08 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:37:55 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:26:52 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
