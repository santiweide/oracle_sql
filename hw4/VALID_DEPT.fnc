create or replace function VALID_DEPT(p_deptno in emp.deptno%type) return BOOLEAN is
  v_cnt  number(9,0);
begin
  v_cnt := 0;
  select count(*) into v_cnt
  from dept where deptno = p_deptno;
  return((v_cnt > 0));
end VALID_DEPT;
/
