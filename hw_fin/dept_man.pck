create or replace package dept_man is

  -- Author  : HU WANJING
  -- Created : 2020/6/11 20:50:36
  -- Purpose : manage the department
  
  -- Public type declarations
    type cur_ref is ref cursor;

  -- Public function and procedure declarations
    -- 1.1 函数：验证部门编号是否有效
    function VALID_DEPT(p_deptno in emp.deptno%type) return BOOLEAN;
    -- 1.2 过程：查询当前所有部门信息，返回指针
    procedure get_full_deptinfo(p_cur out dept_man.cur_ref);
    -- 1.3 
    procedure NEW_DEPT(p_deptno in dept.deptno%type, p_dname in dept.dname%type,p_loc in dept.loc%type,p_ret out integer);
    -- 1.4 
    procedure UPDATE_DEPT(p_deptno in dept.deptno%type, p_dname in dept.dname%type,p_loc in dept.loc%type,p_ret out integer);
    -- 1.5
    procedure GET_EMPINFO(p_deptno in dept.deptno%type,p_pageno in integer,p_pagesize in integer,p_cur out cur_ref);
    -- 1.6 
    procedure DELETE_DEPT(p_deptno in dept.deptno%type);
end dept_man;
/
create or replace package body dept_man is

-- 1.1
function VALID_DEPT(p_deptno in emp.deptno%type) return BOOLEAN is
  v_cnt  number(9,0);
begin
  v_cnt := 0;
  select count(*) into v_cnt
  from dept where deptno = p_deptno;
  return((v_cnt > 0));
end VALID_DEPT;

-- 1.2
procedure get_full_deptinfo(p_cur out dept_man.cur_ref) is
begin
  open p_cur for select * from dept;
end get_full_deptinfo;

-- 1.3
procedure NEW_DEPT(
p_deptno in dept.deptno%type, 
p_dname in dept.dname%type,
p_loc in dept.loc%type,
p_ret out integer
) is
v_valid  boolean;
begin
  -- 检查是不是一个存在了的部门编号
  v_valid := valid_dept(p_deptno);
  if not v_valid then
    insert into dept (deptno, dname, loc) 
    values (p_deptno, p_dname, p_loc);
    p_ret := p_deptno;
  else p_ret:=-1;
  end if;
end NEW_DEPT;

-- 1.4 
procedure UPDATE_DEPT(
p_deptno in dept.deptno%type, 
p_dname in dept.dname%type,
p_loc in dept.loc%type,
p_ret out integer
) is
v_valid  boolean;
begin
  -- 检查是不是一个存在了的部门编号,存在就修改并返回部门编号，不存在就返回-1
  v_valid := valid_dept(p_deptno);
  if v_valid then
    update dept set dname=p_dname, loc = p_loc where deptno = p_deptno;
    p_ret := p_deptno;
  else p_ret:=-1;
  end if;
end UPDATE_DEPT;

-- 1.5
procedure GET_EMPINFO(
p_deptno in dept.deptno%type,
p_pageno in integer,
p_pagesize in integer,
p_cur out cur_ref
) is
begin
  open p_cur for
       select empno,ename,job,mgr,hiredate,sal,comm, deptno  from (
              select rownum as rowno, t.* from emp t
              where t.deptno = p_deptno
              and rownum <= p_pageno*p_pagesize
       ) t2
       where t2.rowno >= (p_pageno-1)*p_pagesize+1;
end GET_EMPINFO;

-- 1.6 delete department
procedure DELETE_DEPT(p_deptno in dept.deptno%type) is
v_emp_cnt  integer;
e_has_emp exception;
pragma exception_init(e_has_emp,-20202);
begin
  select count(*) into v_emp_cnt from dept 
  where deptno = p_deptno and exists( 
        select * from emp where emp.deptno = dept.deptno
  );
  -- 检查是不是一个存在了员工的部门的部门编号
  if v_emp_cnt=0 then
    delete from dept where deptno = p_deptno;
  elsif v_emp_cnt > 0 then
    raise e_has_emp;
  end if;
exception
  when e_has_emp then 
    -- dbms_output.put_line('insertion failed: no such deptno');
    raise_application_error(-20202,'部门下已经存在员工，不能删除部门');
end DELETE_DEPT;

end dept_man;
/
