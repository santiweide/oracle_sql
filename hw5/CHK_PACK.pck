create or replace package CHK_PACK is

  -- Author  : HUWJ
  -- Created : 2020/4/10 12:00:08
  -- Purpose : 过程CHK_HIREDATE用来检查一个员工的雇佣日期是否在范围内;过程CHK_DEPT_MGR用来检查某一员工的部门和经理信息
  
  -- Public constant declarations
  threshold constant number := 50;
  -- Public function and procedure declarations
  procedure CHK_HIREDATE(p_empno in emp.empno%type, p_ret out boolean,p_log out varchar2);
  procedure CHK_DEPT_MGR(p_empno in emp.empno%type, p_mgr in emp.mgr%type,p_ret out boolean);
end CHK_PACK;
/
create or replace package body CHK_PACK is

  -- Function and procedure implementations
  procedure CHK_HIREDATE(p_empno in emp.empno%type, p_ret out boolean,p_log out varchar2) is
    v_date date;
  begin
    p_ret:=false;
    p_log:='check passed';
    select hiredate into v_date
    from emp where empno = p_empno;
    if nvl(v_date,sysdate)=sysdate then
      p_log := 'check failed:date is null';
    elsif v_date>add_months(sysdate,3) then
      p_log:='check failed:date is future';
    elsif v_date < add_months(sysdate,threshold*-12) then
      p_log:='check failed:date is ancient';
    else
      p_ret:=true;
    end if;
  end CHK_HIREDATE;
  
  procedure CHK_DEPT_MGR(p_empno in emp.empno%type, p_mgr in emp.mgr%type,p_ret out boolean) is
   v_mgr  emp.mgr%type;
  begin
    p_ret:=false;
    select mgr into v_mgr from emp where empno = p_empno
    and deptno in (select deptno from emp where empno = p_empno); -- 检查经理和员工是否在一个部门工作
    if nvl(p_empno,1)!=1 and v_mgr=p_mgr then
      p_ret:=true;
    end if;
  end CHK_DEPT_MGR;

end CHK_PACK;
/
