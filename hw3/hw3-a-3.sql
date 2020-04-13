declare 
v_deptno_1  dept.deptno%type:=10;
v_deptno_2  dept.deptno%type:=20;
cursor cur_e(d1 dept.deptno%type, d2 dept.deptno%type) is
       select ename, sal from emp where deptno = d1 or deptno = d2;
begin
  for cur_i in cur_e(v_deptno_1,v_deptno_2) loop
    dbms_output.put_line(cur_i.ename||' '||cur_i.sal);
  end loop;
end;
