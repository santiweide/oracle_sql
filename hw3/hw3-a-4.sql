-- create table copy_emp as select * from emp;
--alter table copy_emp drop column stars;
--alter table copy_emp add stars varchar2(20);
declare
cursor cur_p is
       select sal, round(sal/1000) len from copy_emp
       for update of sal nowait;
begin
  for cur_i in cur_p loop
    for i in 1..cur_i.len loop
        update copy_emp set stars = stars||'*'
        where current of cur_p;
    end loop;
  end loop;
end;

--select * from copy_emp;
