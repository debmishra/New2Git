--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: currency_inc.sql$ 
--
-- $Revision: 4$        $Date: 2/27/2008 3:19:41 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
-- can be directly inserted into tsm10 from build_code1
-- No initial step required


declare

   cursor c1 is select cv_ccode from tsm_stage.currency1 where
   cv_ccode not in ('ARI','BEL','FIN','FRA','DEU','IRL','ITA','NET','ESP',
		    'BUL','FSU','PHC','SCY','SCA');
   invalid_cntry exception;
   country_exist number(5);
   currencyid number(10);
   currency_maxid number(10);

begin

   select nvl(max(id),0)+1 into currency_maxid from "&1".currency;

   for ix1 in c1 loop

        select count(*) into country_exist from "&1".country
	where abbreviation = ix1.cv_ccode;

        if country_exist = 0 then 
          raise invalid_cntry;
        end if; 

  	select currency_id into currencyid from "&1".country
        where abbreviation = ix1.cv_ccode;

        if currencyid is null then  
	  Insert into "&1".currency(id,symbol,cnv_rate) select
          currency_maxid,cv_symbol,cv_cnvrate from tsm_stage.currency1
          where cv_ccode = ix1.cv_ccode;

          update "&1".country set currency_id = currency_maxid
          where abbreviation = ix1.cv_ccode;

          currency_maxid:=currency_maxid+1;
        else
	  update "&1".currency set (symbol,cnv_rate)=(select
          cv_symbol,cv_cnvrate from tsm_stage.currency1 
	  where cv_ccode = ix1.cv_ccode) where id = currencyid;
	end if;

   end loop;

            
   select currency_id into currencyid from "&1".country where abbreviation = 'EUR';

   update "&1".country set currency_id = currencyid where
   abbreviation in ('ARI','BEL','FIN','FRA','DEU','IRL','ITA','NET','ESP'); 

   select currency_id into currencyid from "&1".country where abbreviation = 'USA';

   update "&1".country set currency_id = currencyid where
   abbreviation in ('BUL','FSU','PHC','SCY','SCA');

  commit;

exception

   when invalid_cntry then
	raise_application_error(-20201,'Country exists in currency1, but not in country table');
end;
/
sho err



-- Following lines are added by Debashish on 01/20/2003 to add more country references to currency table

declare

   cursor c1 is select abbreviation,cnv_rate from tsm_stage.country2 where cnv_rate is not null;
   invalid_cntry exception;
   country_exist number(5);
   currencyid number(10);
   currency_maxid number(10);
   usacurrencyid number(10);
   eurocurrencyid number(10);

begin

   select nvl(max(id),0)+1 into currency_maxid from "&1".currency;
   select currency_id into usacurrencyid from "&1".country where abbreviation = 'USA';
   select currency_id into eurocurrencyid from "&1".country where abbreviation = 'EUR';

   for ix1 in c1 loop

        select count(*) into country_exist from "&1".country
	where abbreviation = ix1.abbreviation;

        if country_exist = 0 then 
          raise invalid_cntry;
        end if; 

        if ix1.cnv_rate = 1 then 
          update "&1".country set currency_id = usacurrencyid where abbreviation = ix1.abbreviation ;
 
        else

  	  select currency_id into currencyid from "&1".country
          where abbreviation = ix1.abbreviation; 

         if currencyid is null then  
	    Insert into "&1".currency(id,cnv_rate) values (currency_maxid,ix1.cnv_rate) ;

            update "&1".country set currency_id = currency_maxid
            where abbreviation = ix1.abbreviation;

            currency_maxid:=currency_maxid+1;
          else
	    update "&1".currency set cnv_rate=ix1.cnv_rate where id = currencyid 
            and id not in (usacurrencyid,eurocurrencyid) ;
	  end if;
        end if;
   end loop;



exception

   when invalid_cntry then
	raise_application_error(-20202,'Country exists in country2, but not in country table');
end;
/
sho err

commit;

-- End of the code changes don on 01/20/2003


update "&1".currency set name='Australian dollar' where id = 
	(select currency_id from "&1".country where abbreviation='AUS');
 
update "&1".currency set name='Canadian dollar' where id = 
	(select currency_id from "&1".country where abbreviation='CAN');

update "&1".currency set name='Danish krone' where id = 
	(select currency_id from "&1".country where abbreviation='DEN');

update "&1".currency set name='Forint' where id = 
	(select currency_id from "&1".country where abbreviation='HUN');

update "&1".currency set name='Israeli shekel' where id = 
	(select currency_id from "&1".country where abbreviation='ISR');

update "&1".currency set name='Norwegian krone' where id = 
	(select currency_id from "&1".country where abbreviation='NOR');

update "&1".currency set name='Zloty' where id = 
	(select currency_id from "&1".country where abbreviation='POL');

update "&1".currency set name='Rand' where id = 
	(select currency_id from "&1".country where abbreviation='SAF');

update "&1".currency set name='Swedish krona' where id = 
	(select currency_id from "&1".country where abbreviation='SWE');

update "&1".currency set name='Swiss franc' where id = 
	(select currency_id from "&1".country where abbreviation='SWI');

update "&1".currency set name='British pound' where id = 
	(select currency_id from "&1".country where abbreviation='UK');

update "&1".currency set name='US-Dollar' where id = 
	(select currency_id from "&1".country where abbreviation='USA');

update "&1".currency set name='EURO' where id = 
	(select currency_id from "&1".country where abbreviation='EUR');

commit;

--update "&1".currency set symbol = '¤' where name = 'EURO';
update "&1".currency set symbol = '£' where name = 'British pound';
update "&1".currency set symbol = '€' where name = 'EURO';


commit;


declare

  currency_nextid number(10);

 begin

  select nvl(max(id),0)+1 into currency_nextid from "&1".currency;
  update "&1".id_control set next_id = currency_nextid where
  upper(table_name) = 'CURRENCY';
end;
/
sho err
commit;
 



---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  4    DevTSM    1.3         2/27/2008 3:19:41 PM Debashish Mishra  
--  3    DevTSM    1.2         3/3/2005 6:41:40 AM  Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:14:36 PM Debashish Mishra  
--  1    DevTSM    1.0         2/19/2003 1:50:59 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

