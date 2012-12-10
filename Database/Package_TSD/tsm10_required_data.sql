--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tsm10_required_data.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:10 PM$
--
--
-- Description:  Required data in tsm10
--
---------------------------------------------------------------------

desc currency
Insert into currency values (0,'Dummy',null,null,0);


Insert into country(id,name) values(0,'Dummy Country');

Insert into client_div(id,client_id,name,def_country_id,def_plan_currency_id,
	def_budget_type,client_div_identifier) values (0,0,'Fast Track Systems Inc.',
	0,0,'Industry Cost','FTS');

Insert into project_area values(0,0,'Dummy Area',0,sysdate,1);

Insert into project values (0,'Dummy Project',0,sysdate,0);

insert into indmap (id,code,short_desc,type) 
	values (0,'All','All','Therapeutic Area');


commit;


insert into specificity values (1, 'GSP');
insert into specificity values (2, 'GP');
insert into specificity values (3, 'TSP');
insert into specificity values (4, 'TP');
insert into specificity values (5, 'G');
insert into specificity values (6, 'T');
insert into specificity values (7, 'SP');
insert into specificity values (8, 'P');
insert into specificity values (9, 'A');
insert into specificity values (10, 'D');
insert into specificity values (11, 'SITE');
commit;

  INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES (
      increment_sequence('tspd_template_email_seq'), 
      'CLOSE_SNAPSHOT_DATE_AND_TIME', 
      'Protocol <protocol id> / <snapshot name> document closed for review',
'The <protocol id> / <snapshot name> protocol has been closed for further review.  
The review was due <review due date> at <review due time>.  If you have not yet
completed your review and have additional comments please notify me directly.'
      ); 
  
  INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES (
      increment_sequence('tspd_template_email_seq'), 
      'CLOSE_SNAPSHOT_DATE', 
      'Protocol <protocol id> / <snapshot name> document closed for review',
'The <protocol id> / <snapshot name> protocol has been closed for further review.
The review was due <review due date>.  If you have not yet completed your 
review and have additional comments please notify me directly.'
      ); 

  INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES (
      increment_sequence('tspd_template_email_seq'), 
      'CLOSE_SNAPSHOT', 
      'Protocol <protocol id> / <snapshot name> document closed for review',
'The <protocol id> / <snapshot name> protocol has been closed for further review.
If you have not yet completed your review and have additional comments please 
notify me directly.'
      ); 


INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES (
       increment_sequence('tspd_template_email_seq'),
      'REVIEW_NONFINAL_SNAPSHOT',
      'Protocol <protocol id> / <snapshot name> document posted for your review',
'The <protocol id> / <snapshot name> protocol has been posted for your review.
Please log into TrialSpace Designer to review and add your comments.  
Once your review is complete, please submit and sign your review.  
If you are unable to complete your review you may re-assign the 
review to another reviewer.');

  INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES (
      increment_sequence('tspd_template_email_seq'),
      'SUBMIT_REVIEW',
      'Review submitted for protocol <protocol id> / <snapshot name>',
'<reviewer display name> has submitted a review for protocol <protocol id> / <snapshot name>
Review Status: <completion status> / <review status>
Notes: <review notes>');


INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'USER_TRIAL_ROLE_DELETED',
  'Change in roles for protocol <protocol id>',
  '<user being deleted> has been deleted as <user role> from protocol <protocol id>.');

INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'USER_TRIAL_ROLE_ADDED',
  'Change in roles for protocol <protocol id>',
  '<user being added> has been added as <user role> to protocol <protocol id>.');

INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'USER_TRIAL_ROLE_REPLACED',
  'Change in roles for protocol <protocol id>',
  '<user being added> has been added as <user role> to protocol <protocol id>.  <user being replaced> has been replaced as <user role>.');


INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'REASSIGN_AUTHOR',
  'Change in authorship for protocol <protocol id>',
  'Authorship of protocol <protocol id> has been reassigned to <new author>.');

INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'REASSIGN_REVIEWER',
  'Change in reviewer for protocol <protocol id> / <snapshot name>',
  '<reviewer being added> has been added as reviewer to protocol <protocol id> / <snapshot name>.  <reviewer being replaced> has been replaced as reviewer.');



INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'REVIEW_CC',
  'Protocol <protocol id> / <snapshot name>',
'The <protocol id> / <snapshot name> protocol is available for your review.  
You will find it attached to this message in PDF format.');

INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'FINAL_SNAPSHOT',
  'Final protocol <protocol id> created', 
'The final <protocol id> protocol has been created.  You will find it attached 
to this message in PDF format.');


INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'REVIEWER_REMINDER',
  'Protocol <protocol id> / <snapshot name> document will be closed for review in <# days> days',
'The <protocol id> / <snapshot name> protocol will be closed for your review in 
<# days> days.  Your review has not yet been completed.  Please log in to the 
TrialSpace Designer to review and add your comments.  Once your review is 
complete, please submit and sign your reivew.  If you are unable to complete 
your review you may re-assign the review to another reviewer.');

commit;


Insert into ipm_geographical_location select id,'ARG','EEUX' from country where abbreviation = 'ARG';
Insert into ipm_geographical_location select id,'ARI','WEUX' from country where abbreviation = 'ARI';
Insert into ipm_geographical_location select id,'AUS1','CANX' from country where abbreviation = 'AUS';
Insert into ipm_geographical_location select id,'AUS1','CANX' from country where abbreviation = 'NZE';
Insert into ipm_geographical_location select id,'BEL','WEUX' from country where abbreviation = 'BEL';
Insert into ipm_geographical_location select id,'BRA','EEUX' from country where abbreviation = 'BRA';
Insert into ipm_geographical_location select id,'BUL','EEUX' from country where abbreviation = 'BLG';
Insert into ipm_geographical_location select id,'BUL','EEUX' from country where abbreviation = 'RUM';
Insert into ipm_geographical_location select id,'CAN','CANX' from country where abbreviation = 'CAN';
Insert into ipm_geographical_location select id,'CHI','EEUX' from country where abbreviation = 'CHI';
Insert into ipm_geographical_location select id,'DEU','WEUX' from country where abbreviation = 'DEU';
Insert into ipm_geographical_location select id,'FRA','WEUX' from country where abbreviation = 'FRA';
Insert into ipm_geographical_location select id,'FSU','EEUX' from country where abbreviation = 'RIA';
Insert into ipm_geographical_location select id,'FSU','EEUX' from country where abbreviation = 'EST';
Insert into ipm_geographical_location select id,'FSU','EEUX' from country where abbreviation = 'LAT';
Insert into ipm_geographical_location select id,'FSU','EEUX' from country where abbreviation = 'LIT';
Insert into ipm_geographical_location select id,'HUN','EEUX' from country where abbreviation = 'HUN';
Insert into ipm_geographical_location select id,'ISR','EEUX' from country where abbreviation = 'ISR';
Insert into ipm_geographical_location select id,'ITA','WEUX' from country where abbreviation = 'ITA';
Insert into ipm_geographical_location select id,'MEX','EEUX' from country where abbreviation = 'MEX';
Insert into ipm_geographical_location select id,'NET','WEUX' from country where abbreviation = 'NET';
Insert into ipm_geographical_location select id,'PHC','EEUX' from country where abbreviation = 'CZE';
Insert into ipm_geographical_location select id,'PHC','EEUX' from country where abbreviation = 'SLO';
Insert into ipm_geographical_location select id,'POL','EEUX' from country where abbreviation = 'POL';
Insert into ipm_geographical_location select id,'SAF','EEUX' from country where abbreviation = 'SAF';
Insert into ipm_geographical_location select id,'SCAN','WEUX' from country where abbreviation = 'SWE';
Insert into ipm_geographical_location select id,'SCAN','WEUX' from country where abbreviation = 'NOR';
Insert into ipm_geographical_location select id,'SCAN','WEUX' from country where abbreviation = 'DEN';
Insert into ipm_geographical_location select id,'SCAN','WEUX' from country where abbreviation = 'FIN';
Insert into ipm_geographical_location select id,'SCY','EEUX' from country where abbreviation = 'YUG';
Insert into ipm_geographical_location select id,'SCY','EEUX' from country where abbreviation = 'SVK';
Insert into ipm_geographical_location select id,'SCY','EEUX' from country where abbreviation = 'CRO';
Insert into ipm_geographical_location select id,'SWI','WEUX' from country where abbreviation = 'SWI';
Insert into ipm_geographical_location select id,'UK1','WEUX' from country where abbreviation = 'UK';
Insert into ipm_geographical_location select id,'UK1','WEUX' from country where abbreviation = 'IRL';
Insert into ipm_geographical_location select id,'USA','USAX' from country where abbreviation = 'USA';
Insert into ipm_geographical_location select id,'BUL','EEUX' from country where abbreviation = 'BUL';
Insert into ipm_geographical_location select id,'PHC','EEUX' from country where abbreviation = 'PHC';
Insert into ipm_geographical_location select id,'FSU','EEUX' from country where abbreviation = 'FSU';
Insert into ipm_geographical_location select id,'SCY','EEUX' from country where abbreviation = 'SCY';
Insert into ipm_geographical_location select id,'SCY','EEUX' from country where abbreviation = 'ESP';

commit;


Insert into id_control values('tsm10','oracle_alert_config',1);
Insert into oracle_alert_config select increment_sequence('oracle_alert_config_seq'),
	'UserLocked','dmishra@fast-track.com',
	'Info- FastTrack application user has been locked',null from dual;
Insert into id_control values('tsm10','tspd_document_history',1);
commit;




exit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:10 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:38:09 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:27:04 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
