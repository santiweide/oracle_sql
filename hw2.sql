--3-2
select empno, ename, sal, sal*1.15 "New Salary" from emp;
--3-4
select empno, ename, sal, sal*1.15 "New Salary",sal*0.15 "Increase" from emp;
--3-5
select InitCap(ename), length(ename) Length from emp
where substr(ename,1,1)='J' or
substr(ename,1,1)='A' or substr(ename,1,1)='M'
order by ename;
-- 3-6
select ename, round(months_between(sysdate,hiredate)) MONTHS_WORKED from emp
order by MONTHS_WORKED;
--3-7
select ename||' earns $'||sal||' monthly but wants '||3*sal||'.' "Dream Salaries" from emp
--3-8
select ename, lpad(sal,15,'$') from emp;
--3-9
select ename, hiredate, to_char(next_day(add_months(hiredate,6),'星期一'),'Day','NLS_DATE_LANGUAGE=AMERICAN')
||', the '||to_char(next_day(add_months(hiredate,6),'星期一'),'ddspth','NLS_DATE_LANGUAGE=AMERICAN')||' of '
||to_char(next_day(add_months(hiredate,6),'星期一'),'Month','NLS_DATE_LANGUAGE=AMERICAN')||','||
to_char(next_day(add_months(hiredate,6),'星期一'),'yyyy','NLS_DATE_LANGUAGE=AMERICAN')
 REVIEW from emp;
--3-10
select ename, hiredate, to_char(hiredate,'DAY','NLS_DATE_LANGUAGE=AMERICAN') "DAY" from emp 
order by mod(to_number(to_char(hiredate,'D'))+5,7);
--3-11
select ename, nvl(to_char(comm),'No Commission') COMM from emp;
--3-12
select ename||' '||regexp_replace(to_char(sal*12),'.','*') EMPLOYEES_AND_THEIR_SALARIES from emp
order by sal desc;
--3-13
select job, decode(job,'AD_PRES','A','ST_MAN','B','IT_PROG','C','SA_REP','D','ST_CLERK','E','0') G from emp;
--3-14
select job, 
(case job  
when 'AD_PRES' then 'A' 
when 'ST_MAN' then 'B' 
when 'IT_PROG' then 'C' 
when 'SA_REP' then 'D' 
when 'ST_CLERK' then 'E' 
else '0' end) from emp;
-- 2-a
-- create table copy_emp as select * from emp;
-- 2-a-1
select * from copy_emp;
update copy_emp set sal=sal*1.1 where ename like 'A%' or ename like 'S%';
update copy_emp set sal=sal+500 where job = 'SALESMAN';
--2-a-2
update copy_emp set job='MANAGER' where job='CLERK' and hiredate <= all 
(select hiredate from emp);
--2-b-1
declare 
v_year  number(4,0):=200;
v_ret   varchar2(200);
begin
  if mod(v_year,4)=0 and mod(v_year,100)!=0 then
    v_ret:= '是闰年';
  else
    if mod(v_year,400)=0 then
        v_ret:= '是闰年';
    else
        v_ret:= '不是闰年';
    end if;
  end if;
  dbms_output.put_line(v_ret);
end;
--2-b-2
declare
v_ename emp.ename%type:='MILLER';
v_sal   number(9,2);
v_salInfo  varchar2(200);
begin
  select sal into v_sal
  from emp where ename=v_ename;
  if v_sal < 1000 then v_salInfo:='POOR';
  elsif v_sal<2000 then v_salInfo:='MEDIUM';
  elsif v_sal < 3000 then v_salInfo:='GOOD';
  elsif v_sal < 4000 then v_salInfo:='VERY GOOD';
  else v_salInfo:='EXCELLENT';
  end if;
  dbms_output.put_line(v_salInfo);
end;









