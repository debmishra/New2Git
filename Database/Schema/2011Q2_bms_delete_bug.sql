
CREATE TABLE cost_item_history (
  id                       NUMBER(10)  NOT NULL,
  trial_budget_id          NUMBER(10)  NULL,
  unlisted_procedure_id    NUMBER(10)  NULL,
  frequency                NUMBER(12,2)  NULL,
  overhead_pct             NUMBER(1)   DEFAULT 0 NOT NULL,
  price                    NUMBER(12,2)  NULL,
  odc_def_id               NUMBER(10)  NULL,
  procedure_def_id         NUMBER(10)  NULL,
  price_range              VARCHAR2(20)  DEFAULT 'Med' NOT NULL,
  display_order            NUMBER(3)   NULL,
  temp_id                  NUMBER(10)  NULL,
  required_specificity     VARCHAR2(10)  DEFAULT 'GSP' NOT NULL,
  priced_specificity       VARCHAR2(10)  NULL,
  screening_quantity       NUMBER(12,2)  NULL,
  required_co_specificity  VARCHAR2(10)  DEFAULT 'GSP' NOT NULL,
  priced_co_specificity    VARCHAR2(10)  NULL,
  required_g50_specificity VARCHAR2(10)  DEFAULT 'GSP' NOT NULL,
  priced_g50_specificity   VARCHAR2(10)  NULL,
  long_desc                VARCHAR2(256) NULL,
  trial_id                 NUMBER(10)  NULL,
  temp_frequency           NUMBER(12,2)  NULL,
  modify_date		   date default sysdate)
  TABLESPACE tsmlarge PCTFREE   1;

CREATE TABLE pvtci_history (
  id                NUMBER(10) NOT NULL,
  cost_item_id      NUMBER(10),
  picas_visit_id    NUMBER(10) NOT NULL,
  frequency         NUMBER(12,2) NOT NULL,
  temp_cost_item_id NUMBER(10),
  Deleted_by	    varchar2(40),
  modify_date	    date default sysdate)
  tablespace tsmlarge PCTFREE 1;


CREATE OR REPLACE TRIGGER cost_item_trg3
before delete on cost_item
referencing new as n old as o
for each row

begin

insert into cost_item_history (
 id,trial_budget_id,unlisted_procedure_id,frequency,overhead_pct,
 price,odc_def_id,procedure_def_id,price_range,display_order,
 temp_id,required_specificity,priced_specificity,screening_quantity,
 required_co_specificity,priced_co_specificity,required_g50_specificity,
 priced_g50_specificity,long_desc,trial_id,temp_frequency)
values( 
 :o.id,:o.trial_budget_id,:o.unlisted_procedure_id,:o.frequency,:o.overhead_pct,
 :o.price,:o.odc_def_id,:o.procedure_def_id,:o.price_range,:o.display_order,
 :o.temp_id,:o.required_specificity,:o.priced_specificity,:o.screening_quantity,
 :o.required_co_specificity,:o.priced_co_specificity,:o.required_g50_specificity,
 :o.priced_g50_specificity,:o.long_desc,:o.trial_id,:o.temp_frequency);

insert into pvtci_history (id,cost_item_id,picas_visit_id,frequency,
temp_cost_item_id,Deleted_by) select id,cost_item_id,picas_visit_id,frequency,
temp_cost_item_id,'Cost Item Trigger' from 
picas_visit_to_cost_item where cost_item_id = :o.id;
 

delete from picas_visit_to_cost_item where cost_item_id = :o.id;
end;
/

CREATE OR REPLACE TRIGGER picas_visit_to_cost_item_trg1
before delete on picas_visit_to_cost_item
referencing new as n old as o
for each row
begin
 insert into pvtci_history 
 (id,cost_item_id,picas_visit_id,frequency,temp_cost_item_id,Deleted_by) 
 values (:o.id,:o.cost_item_id,:o.picas_visit_id,:o.frequency,:o.temp_cost_item_id,'Direct delete');

end;
/
