delete from IPM_PH2TO4_LKUP_COEFF where indmap_id in
(select id from indmap where code='DEV12');

delete from indmap where code='DEV12';

update procedure_def set obsolete_flg=0 where cpt_code='83090';

update procedure_def set obsolete_flg=1 where cpt_code in (
'*BNP*','75552','75552-26','*C4N8','86586','32000','FT001','99371');
insert into local_to_euro select increment_sequence('local_to_euro_seq'),
id,0.585274 from country where abbreviation='CYP';
insert into local_to_euro select increment_sequence('local_to_euro_seq'),
id,0.429300 from country where abbreviation='MAL';
commit;

update indmap set short_desc=
'Other Cardiac Dysrhythmia: Pacemaker, Defibrillator, Bradycardia'
where CODE='427.89';

commit;

create table own_client_div_to_build_window(
ID number(10), 
client_div_id 	number(10),           
num_yrs_back   NUMBER(2))
tablespace tsmsmall pctfree 5;

Alter table own_client_div_to_build_window add constraint
own_client_div_to_build_win_pk primary key(id)
using index tablespace tsmsmall_indx pctfree 5;

Alter table own_client_div_to_build_window add constraint
own_client_div_to_bld_win_fk1 foreign key(client_div_id)
references client_div (id);

Insert into id_control values ('tsm10','own_client_div_to_build_window',1);
commit;

Insert into own_client_div_to_build_window
select increment_sequence('own_client_div_to_build_window_seq'),
id,7 from client_div where client_div_identifier in
('FTS','FTM','BMS','AZA','MDT');
commit;

delete from OWN_INVESTIG where protocol_code in ('D1040C00002AUSA','D1040C00002BUSA','D1448C00010USA',
'D144CC00004USA','D6702C0001USA','D1536C00001AUSA');
delete from OWN_PROTOCOL where protocol_code in ('D1040C00002AUSA','D1040C00002BUSA','D1448C00010USA',
'D144CC00004USA','D6702C0001USA','D1536C00001AUSA');
delete from OWN_PROCEDURE  where protocol_code in ('D1040C00002AUSA','D1040C00002BUSA','D1448C00010USA',
'D144CC00004USA','D6702C0001USA','D1536C00001AUSA');
delete from OWN_ODC where protocol_code in ('D1040C00002AUSA','D1040C00002BUSA','D1448C00010USA',
'D144CC00004USA','D6702C0001USA','D1536C00001AUSA'); 
delete from own_site where build_code_id=176 and institution_id not in (
select institution_id from own_investig where build_code_id=176);

commit;

create index cost_item_indx1 on cost_item (trial_budget_id)
 tablespace tsmlarge_indx pctfree 20;

create index picas_visit_to_cost_item_indx1 on
 picas_visit_to_cost_item (cost_item_id) tablespace tsmlarge_indx pctfree 20;

create index picas_visit_indx1 on picas_visit (trial_budget_id)
 tablespace tsmlarge_indx pctfree 20;

create index picas_visit_to_cost_item_indx2 on
 picas_visit_to_cost_item (picas_visit_id) tablespace tsmlarge_indx pctfree 20;

create index picas_visit_to_cost_item_indx2 on
 picas_visit_to_cost_item (picas_visit_id) tablespace tsmlarge_indx pctfree 20;

create index budget_group_permission_indx1 on budget_group_permission (trial_budget_id)
 tablespace tsmlarge_indx pctfree 20;

create index tsm_trial_rollup_indx1 on tsm_trial_rollup (trial_id)
 tablespace tsmlarge_indx pctfree 20;

create index trial_budget_indx1 on trial_budget (trial_id)
 tablespace tsmlarge_indx pctfree 20;

create or replace procedure delete_gm_budgets (Trialid in number)
as
begin
delete from picas_visit_to_cost_item a  where exists (select 1 from picas_visit b, trial_budget c
 where b.id=a.picas_visit_id and b.trial_budget_id=c.id and c.trial_id=TrialId);
delete from picas_visit_to_cost_item a  where exists (select 1 from cost_item b, trial_budget c
 where b.id=a.cost_item_id and b.trial_budget_id=c.id and c.trial_id=TrialId);
delete from cost_item a where exists (select 1 from trial_budget b 
 where a.trial_budget_id=b.id and b.trial_id=Trialid);
delete from picas_visit a where exists (select 1 from trial_budget b 
 where a.trial_budget_id=b.id and b.trial_id=Trialid); 
delete from budget_group_permission a where exists (select 1 from trial_budget b 
 where a.trial_budget_id=b.id and b.trial_id=Trialid); 
delete from tsm_trial_rollup where trial_id=Trialid;  
delete from trial_budget where trial_id=Trialid;

commit;
end;
/

