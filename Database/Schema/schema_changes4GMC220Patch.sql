ALTER TABLE tsn_neg_to_cost_item ADD(sqty NUMBER(6,2) );
ALTER TABLE tsn_neg_to_investigator ADD(is_fixed_sf_cost NUMBER(1) default 1 not null,
                                        use_oh_in_screen_failure NUMBER(1) default 0 not null );
