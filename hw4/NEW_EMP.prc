create or replace procedure NEW_EMP(
p_no in emp.empno%type default EMPLOYEES_SEQ.NEXTVAL, 
p_name in emp.ename%type default EMPLOYEES_SEQ.NEXTVAL,
p_hiredate in emp.hiredate%type default to_date(EMPLOYEES_SEQ.NEXTVAL,'YYYY'),
p_job in emp.job%type default 'SA_REP',
p_sal in emp.sal%type default 1000,
p_comm in emp.comm%type default 0,
p_deptno in emp.deptno%type default 30
) is
v_valid  boolean;
e_no_dept exception;
pragma exception_init(e_no_dept,-20202);
begin
  v_valid := valid_dept(p_deptno);
  if v_valid then
    insert into copy_emp (empno, ename, job, hiredate, sal, comm, deptno) 
    values (p_no, p_name, p_job, p_hiredate,p_sal,p_comm,p_deptno);
  elsif not v_valid then
    raise e_no_dept;
  end if;
exception
  when e_no_dept then 
    -- dbms_output.put_line('insertion failed: no such deptno');
    raise_application_error(-20202,'insertion failed: no such deptno');
end NEW_EMP;
/
