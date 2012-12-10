update id_control set next_id=(select
nvl(max(id),0)+1 from cro_ta_factor)
where table_name='cro_ta_factor';
commit;



declare

row_exists  number(1);
cursor c1 is select id from indmap where type='Therapeutic Area' and id<>0;
cursor c2 is select id from cro_category where parent_category_id 
is null and is_viewable=1;

begin

  for ix1 in c1 loop
   for ix2 in c2 loop

      select count(*) into row_exists from cro_ta_factor where 
      indmap_id=ix1.id and cro_category_id=ix2.id;
 
       if row_exists=1 then
          update cro_ta_factor set ta_factor=1 where indmap_id=ix1.id and
          cro_category_id=ix2.id and ta_factor is null;
       else
          insert into cro_ta_factor(ID,INDMAP_ID,TA_FACTOR,CRO_CATEGORY_ID) 
          select increment_sequence('cro_ta_factor_seq'),ix1.id,1,ix2.id from dual;
       end if;
   end loop;
  end loop;
end;
/
sho err

update id_control set next_id=(select
nvl(max(id),0)+1 from cro_phase_factor)
where table_name='cro_phase_factor';
commit;



declare

row_exists  number(1);
cursor c1 is select id from phase where id in (1,2,5,19);
cursor c2 is select id from cro_category where parent_category_id 
is null and is_viewable=1;

begin

  for ix1 in c1 loop
   for ix2 in c2 loop

      select count(*) into row_exists from cro_phase_factor where 
      phase_id=ix1.id and cro_category_id=ix2.id;
 
       if row_exists=1 then
          update cro_phase_factor set factor=1 where phase_id=ix1.id and
          cro_category_id=ix2.id and factor is null;
       else
          insert into cro_phase_factor(ID,phase_ID,FACTOR,CRO_CATEGORY_ID) 
          select increment_sequence('cro_phase_factor_seq'),ix1.id,1,ix2.id from dual;
       end if;
   end loop;
  end loop;
end;
/
sho err

update id_control set next_id=(select
nvl(max(id),0)+1 from cro_adjusted_salary)
where table_name='cro_adjusted_salary';
commit;



declare

row_exists  number(1);
cursor c1 is select id from country where is_pbt_viewable=1;
cursor c2 is select id from indmap where type='Therapeutic Area' and id<>0;
cursor c3 is select id from phase where id in (1,2,5,19);

begin

  for ix1 in c1 loop
   for ix2 in c2 loop
    for ix3 in c3 loop

      select count(*) into row_exists from cro_adjusted_salary where 
      country_id=ix1.id and indmap_id=ix2.id and phase_id=ix3.id and cro_job_type_id=2;
 
       if row_exists=1 then
          update cro_adjusted_salary set low_salary=100,med_salary=100,high_salary=100 where 
          country_id=ix1.id and indmap_id=ix2.id and phase_id=ix3.id and
          cro_job_type_id=2 and (low_salary is null or med_salary is null or high_salary is null);
       else
          insert into cro_adjusted_salary(ID,country_id,indmap_id,phase_ID,CRO_job_type_ID,
          low_salary, med_salary, high_salary) 
          select increment_sequence('cro_adjusted_salary_seq'),ix1.id,ix2.id,ix3.id,2,100,100,100 from dual;
       end if;
    end loop;
   end loop;
  end loop;
end;
/
sho err

update id_control set next_id=(select
nvl(max(id),0)+1 from cro_choice_factor)
where table_name='cro_choice_factor';
commit;



declare

row_exists  number(1);
cursor c2 is select id from cro_choice;
cursor c3 is select distinct cro_type from cro_choice_factor;

begin

   for ix2 in c2 loop
    for ix3 in c3 loop

      select count(*) into row_exists from cro_choice_factor where 
       cro_choice_id=ix2.id and cro_type=ix3.cro_type ;
 
       if row_exists=1 then
          update cro_choice_factor set factor=1 where 
           cro_choice_id=ix2.id and cro_type=ix3.cro_type and
          factor is null;
       else
          insert into cro_choice_factor(ID,cro_type, factor, cro_choice_id) 
          select increment_sequence('cro_choice_factor_seq'),ix3.cro_type,1,ix2.id from dual;
       end if;
    end loop;
   end loop;
end;
/
sho err

commit;    
update id_control set next_id=(select
nvl(max(id),0)+1 from cro_category_factor)
where table_name='cro_category_factor';
commit;

declare

row_exists  number(1);
cursor c1 is select id from country  where is_pbt_viewable=1;
cursor c2 is select id from cro_category where parent_category_id 
is null and category_account in ('X','Y','Z');
cursor c3 is select distinct cro_type from cro_category_factor where cro_type in (1,2);

lowprice number(10,4):=1;
medprice number(10,4):=3;
highprice number(10,4):=5;

begin

  for ix1 in c1 loop
   for ix2 in c2 loop
    for ix3 in c3 loop

      select count(*) into row_exists from cro_category_factor where 
      country_id=ix1.id and cro_category_id=ix2.id and cro_type=ix3.cro_type;
 
       if row_exists>=1 then
          update cro_category_factor set LOW_PRICE=lowprice, MED_PRICE=medprice, 
                                HIGH_PRICE=highprice, MEAN_PRICE=0
          where country_id=ix1.id and cro_category_id=ix2.id and cro_type=ix3.cro_type and
          LOW_PRICE is null and MED_PRICE is null and HIGH_PRICE is null and MEAN_PRICE is null;
       else
          insert into cro_category_factor(ID,COUNTRY_ID,CRO_CATEGORY_ID,CRO_TYPE,LOW_PRICE,
          MED_PRICE,HIGH_PRICE,MEAN_PRICE) 
          select increment_sequence('cro_category_factor_seq'),ix1.id,ix2.id,ix3.cro_type,
          lowprice,medprice,highprice,0 from dual;
       end if;

     lowprice:=lowprice+1;
     medprice:=medprice+1;
     highprice:=highprice+1;
    
   end loop;
  end loop;
 end loop;
 
end;
/
sho err



declare

row_exists  number(1);
cursor c1 is select id from country  where is_pbt_viewable=1;
cursor c2 is select id from cro_category where parent_category_id 
is null and is_viewable=1 and category_account not in ('X','Y','Z');
cursor c3 is select distinct cro_type from cro_category_factor;

begin

  for ix1 in c1 loop
   for ix2 in c2 loop
    for ix3 in c3 loop

      select count(*) into row_exists from cro_category_factor where 
      country_id=ix1.id and cro_category_id=ix2.id and cro_type=ix3.cro_type;
 
       if row_exists>=1 then
          update cro_category_factor set LOW_PRICE=1, MED_PRICE=1, HIGH_PRICE=1, MEAN_PRICE=100
          where country_id=ix1.id and cro_category_id=ix2.id and cro_type=ix3.cro_type and
          LOW_PRICE is null and MED_PRICE is null and HIGH_PRICE is null and MEAN_PRICE is null;
       else
          insert into cro_category_factor(ID,COUNTRY_ID,CRO_CATEGORY_ID,CRO_TYPE,LOW_PRICE,
          MED_PRICE,HIGH_PRICE,MEAN_PRICE) 
          select increment_sequence('cro_category_factor_seq'),ix1.id,ix2.id,ix3.cro_type,
          1,1,1,100 from dual;
       end if;
   end loop;
  end loop;
 end loop;
 
end;
/
sho err

update id_control set next_id=(select
nvl(max(id),0)+1 from cro_choice_factor)
where table_name='cro_choice_factor';
commit;



declare

row_exists  number(1);
cursor c1 is select a.id from country a where a.is_pbt_viewable=1;
cursor c2 is select id from cro_choice;
cursor c3 is select distinct cro_type from cro_choice_factor;

begin

  for ix1 in c1 loop
   for ix2 in c2 loop
    for ix3 in c3 loop

      select count(*) into row_exists from cro_choice_factor where 
      country_id=ix1.id and cro_choice_id=ix2.id and cro_type=ix3.cro_type ;
 
       if row_exists=1 then
          update cro_choice_factor set factor=1 where 
          country_id=ix1.id and cro_choice_id=ix2.id and cro_type=ix3.cro_type and
          factor is null;
       else
          insert into cro_choice_factor(ID,country_id,cro_type, factor, cro_choice_id) 
          select increment_sequence('cro_choice_factor_seq'),ix1.id,ix3.cro_type,1,ix2.id from dual;
       end if;
    end loop;
   end loop;
  end loop;
end;
/
sho err

commit;    



