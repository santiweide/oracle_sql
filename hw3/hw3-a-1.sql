--1
declare
cursor cur_d is
       select deptno, dname from dept;
cursor cur_e (p_deptno emp.deptno%type) is
       select ename, job, hiredate from emp
       where deptno = p_deptno;     
begin 
  for cur_i in cur_d loop
    dbms_output.put_line(cur_i.deptno|| ' '|| cur_i.dname);
    for cur_j in cur_e(cur_i.deptno) loop
      dbms_output.put_line(cur_j.ename||' '||cur_j.job||' '||cur_j.hiredate);
    end loop;
  end loop;
end;

