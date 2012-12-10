update country set is_pbt_viewable=0 where abbreviation in 
('BGD','ECU','IRN','KEN','MWI','TZA','UGA','ZMB');

delete from cro_client_div_to_lic_country where 
client_div_id in (select id from client_div where client_div_identifier='SFA') and
country_id in (select id from country where abbreviation in 
('BGD','ECU','IRN','KEN','MWI','TZA','UGA','ZMB'));

commit;

