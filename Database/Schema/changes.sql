-- changes for 10/23 build

alter table icp_instance add (icp_type varchar2(80) null);

Alter table icp_instance drop constraint II_SNAPSHOT_TYPE_CHECK;

Alter table icp_instance add constraint INSTANCE_ICP_TYPE_CHECK 
	check (icp_type in (
	'WorkingCopy','Frozen'));
	commit;

  update icp_instance set icp_type='WorkingCopy' where snapshot_type='WorkingCopy';
  update icp_instance set icp_type='Frozen' where snapshot_type='FinalVersion';
  commit;

  delete tspd_template_email ;
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
