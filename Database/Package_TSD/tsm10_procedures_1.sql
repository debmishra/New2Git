--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tsm10_procedures_1.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:10 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

create or replace function Increment_sequence (seq_name in varchar2,
increment_by in number default 1)  return number is
pragma autonomous_transaction;

start_value number(10);

begin

select next_id into start_value from id_control where 
table_name = lower(substr(seq_name,1,length(seq_name)-4))
for update;

update id_control set next_id = next_id+increment_by where 
table_name = lower(substr(seq_name,1,length(seq_name)-4));

commit;
return(start_value);

end;
/

create or replace procedure delete_tspd_trial(
trialid in number) 
is

begin

delete from tspd_doc_comment where tspd_document_id in 
(select a.id from tspd_document a where a.trial_id=trialid); 

delete from tspd_doc_reviewer where tspd_document_id in 
(select a.id from tspd_document a where a.trial_id=trialid);


delete from tspd_doc_advisory where tspd_document_id in 
(select a.id from tspd_document a where a.trial_id=trialid);

delete from tspd_document where trial_id=trialid;
 

delete from icp_instance where trial_id=trialid;

delete from tspd_trial where trial_id=trialid;

delete from trial where created_by = 'TSPD' and id=trialid;
 
commit;
end;
/

Create or replace procedure oracle_sendmail(ftrecipient in varchar2, ftsubject in varchar2, 
ftmessage in varchar2)
is
  c utl_smtp.connection;
 
  PROCEDURE send_header(name IN VARCHAR2, header IN VARCHAR2) AS
  BEGIN
    utl_smtp.write_data(c, name || ': ' || header || utl_tcp.CRLF);
  END;
 
BEGIN
  c := utl_smtp.open_connection('localhost');
  utl_smtp.helo(c, 'fast-track.com');
  utl_smtp.mail(c, 'none@fast-track.com');
  utl_smtp.rcpt(c, ftrecipient);
  utl_smtp.open_data(c);
  send_header('From',    '"FT Alert" <none@fast-track.com>');
  send_header('To',      ftrecipient);
  send_header('Subject', ftsubject);
  utl_smtp.write_data(c, utl_tcp.CRLF || ftmessage);
  utl_smtp.close_data(c);
  utl_smtp.quit(c);
EXCEPTION
  WHEN utl_smtp.transient_error OR utl_smtp.permanent_error THEN
    BEGIN
      utl_smtp.quit(c);
    EXCEPTION
      WHEN utl_smtp.transient_error OR utl_smtp.permanent_error THEN
        NULL; -- When the SMTP server is down or unavailable, we don't have
              -- a connection to the server. The quit call will raise an
              -- exception that we can ignore.
    END;
    raise_application_error(-20107,
      'Oracle failed to send mail due to the following error: ' || sqlerrm);
END;
/
sho err

exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:10 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:38:08 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:27:03 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
