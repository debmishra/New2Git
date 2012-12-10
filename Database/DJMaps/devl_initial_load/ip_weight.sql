--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ip_weight.sql$ 
--
-- $Revision: 6$        $Date: 2/27/2008 3:16:40 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
drop sequence ip_weight_seq;
create sequence ip_weight_seq;

Insert into ip_weight select ip_weight_seq.nextval,
c.id,cp.phase,i.id,cp.affiliation,cp.complex_minvalue,
cp.factor,cp.minvalue from
country c, cppwt cp, indmap i where
cp.country=c.abbreviation and
cp.ther_area=i.de_code(+);

commit;

declare

countryid number(10);

begin

 select id into countryid from country where abbreviation = 'EAE';

	declare

	cursor c1 is select id from ip_weight where country_id=countryid;
	countryid2 number(10);

	begin

	for ix1 in c1 loop

	select id into countryid2 from country where abbreviation='POL';
	Insert into ip_weight select ip_weight_seq.nextval,countryid2,
	phase_id,indmap_id,affiliation, complex_minvalue, factor, minvalue
	from ip_weight where id=ix1.id;

	select id into countryid2 from country where abbreviation='HUN';
	Insert into ip_weight select ip_weight_seq.nextval,countryid2,
	phase_id,indmap_id,affiliation, complex_minvalue, factor, minvalue
	from ip_weight where id=ix1.id;

	select id into countryid2 from country where abbreviation='PHC';
	Insert into ip_weight select ip_weight_seq.nextval,countryid2,
	phase_id,indmap_id,affiliation, complex_minvalue, factor, minvalue
	from ip_weight where id=ix1.id;

	select id into countryid2 from country where abbreviation='SCY';
	Insert into ip_weight select ip_weight_seq.nextval,countryid2,
	phase_id,indmap_id,affiliation, complex_minvalue, factor, minvalue
	from ip_weight where id=ix1.id;

	select id into countryid2 from country where abbreviation='BUL';
	Insert into ip_weight select ip_weight_seq.nextval,countryid2,
	phase_id,indmap_id,affiliation, complex_minvalue, factor, minvalue
	from ip_weight where id=ix1.id;

	select id into countryid2 from country where abbreviation='FSU';
	Insert into ip_weight select ip_weight_seq.nextval,countryid2,
	phase_id,indmap_id,affiliation, complex_minvalue, factor, minvalue
	from ip_weight where id=ix1.id;
	
        end loop;
	end;

end;
/

commit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         2/27/2008 3:16:40 PM Debashish Mishra  
--  5    DevTSM    1.4         3/3/2005 6:39:02 AM  Debashish Mishra  
--  4    DevTSM    1.3         8/29/2003 5:11:49 PM Debashish Mishra  
--  3    DevTSM    1.2         2/7/2002 3:10:10 PM  Debashish Mishra  
--  2    DevTSM    1.1         1/28/2002 3:16:05 PM Debashish Mishra  
--  1    DevTSM    1.0         1/8/2002 6:37:17 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------
