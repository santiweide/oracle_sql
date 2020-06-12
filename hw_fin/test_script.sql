-- test for 1
declare 
v_row dept%rowtype;
v_emp_row emp%rowtype;
cur_dept dept_man.cur_ref;
cur_emp dept_man.cur_ref;
ret integer;
begin
  /*
  if dept_man.VALID_DEPT(100) then
    dbms_output.put_line('valid');
  else dbms_output.put_line('not valid');
  end if;
  
 -- 1.2
  dept_man.get_full_deptinfo(cur_dept);
  loop
    fetch cur_dept into v_row;
    exit when cur_dept%notfound;
    dbms_output.put_line(v_row.deptno||' '||v_row.dname||' '||v_row.loc);
  end loop;
  
  -- 1.3
  dept_man.NEW_DEPT(50,'Financial','Shenzhen',ret);
  dbms_output.put_line(ret);
  
  -- 1.4
  dept_man.UPDATE_DEPT(50,'research','dallas',ret);
  dbms_output.put_line(ret);
  
  -- 1.5
  dept_man.get_empinfo(10,1,2,cur_emp);
  loop
    fetch cur_emp into v_emp_row;
    exit when cur_emp%notfound;
    dbms_output.put_line(v_emp_row.empno||' '||v_emp_row.ename||' '||v_emp_row.deptno);
  end loop;  
  dept_man.get_empinfo(10,2,2,cur_emp);
  loop
    fetch cur_emp into v_emp_row;
    exit when cur_emp%notfound;
    dbms_output.put_line(v_emp_row.empno||' '||v_emp_row.ename||' '||v_emp_row.deptno);
  end loop;  
  */
  -- 1.6
  dept_man.DELETE_DEPT(50);
  
end;
--select * from dept;
--select * from emp where deptno=10;


-- test for 2
drop table emp_jobhistory;
create table emp_jobhistory(
empno number(6),
deptno number(4),
timeon date
);
update emp set deptno = 30 where empno = 7369;
select * from emp_jobhistory;
update emp set deptno = 20 where empno = 7369;
select * from emp_jobhistory;




