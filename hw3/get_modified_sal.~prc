create or replace procedure get_modified_sal
(p_empno in emp.empno%type, p_msal out number) 
is
v_dur  number(9,0);
begin
  select sal*1.1,months_between(sysdate,hiredate) into p_msal,v_dur
  from emp where empno = p_empno;
  if v_dur > 60 then
    p_msal:=p_msal+3000;
  end if;
end get_modified_sal;
/
