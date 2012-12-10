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
-- $Revision: 4$        $Date: 2/22/2008 11:55:25 AM$
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






exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  4    DevTSM    1.3         2/22/2008 11:55:25 AMDebashish Mishra  
--  3    DevTSM    1.2         9/19/2006 12:11:00 AMDebashish Mishra   
--  2    DevTSM    1.1         3/2/2005 10:48:54 PM Debashish Mishra  
--  1    DevTSM    1.0         4/8/2004 4:09:53 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
