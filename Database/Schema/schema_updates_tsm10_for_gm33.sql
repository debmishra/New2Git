-- Following chnages are per Tonya's request on 8/11/2011 

Alter table cost_item add(
 custom_price NUMBER(16,4),
 currency_id NUMBER(10));

Alter table cost_item modify price number(16,4);

Alter table cost_item add constraint cost_item_fk6
	foreign key (currency_id) references currency(id);

update cost_item set custom_price=price where price_range='Custom';

update cost_item a set a.currency_id=(select c.planning_currency_id from
 trial_budget b, trial c where c.id=b.trial_id and b.id=a.trial_budget_id) 
 where price_range='Custom';

commit;
commit;

--*********************************************
--updated upto this in Q002 on 8/16/2011 at 2pm 
--updated upto this in Q005 on 8/16/2011 at 2pm 
--updated upto this in Q006 on 8/17/2011 at 3pm
--*********************************************

ALTER TABLE picas_visit_to_cost_item
  ADD CONSTRAINT picas_visit_to_cost_item_uq1 UNIQUE (
    picas_visit_id,
    cost_item_id,
    temp_cost_item_id
  ) using index tablespace TSMLARGE_INDX pctfree 5;