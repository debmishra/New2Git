declare
   cursor c1 is select abbreviation from tsm_stage.country2;
   currencyid number(10);
begin

   for ix1 in c1 loop
  	select currency_id into currencyid from "&1".country
        where abbreviation = ix1.abbreviation;

       if currencyid is not null then
		update "&1".currency set cnv_rate=(select
          	cnv_rate from tsm_stage.country2 
	  	where abbreviation = ix1.abbreviation) 
	        where id = currencyid;
	end if;
   end loop;
end;
/