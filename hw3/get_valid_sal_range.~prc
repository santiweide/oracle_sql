create or replace procedure get_valid_sal_range
(p_empno in copy_emp.empno%type, p_result out varchar2) 
is
cursor cur_e is
       select job,sal from copy_emp where empno = p_empno for update;
type lower is table of number index by binary_integer;
type job_name is table of varchar2(200) index by binary_integer;
v_lower lower ;
v_job_name job_name;
begin
  v_job_name(0):='CLERK';
  v_lower(0):=1500;
  v_job_name(1):='SALES';
  v_lower(1):=2501;
  v_job_name(2):='ANALYST';
  v_lower(2):=3501;
  v_job_name(3):='MANAGER';
  v_lower(3):=4501;

  for cur_i in cur_e loop
    for v_j in 0..3 loop
      if cur_i.job = v_job_name(v_j) then
        if v_lower(v_j)<=cur_i.sal then
          p_result:='工资正常';
        else 
          p_result:='工资太低';
          update copy_emp set sal=v_lower(v_j) where current of cur_e;
        end if;
        if v_j < 3 and v_lower(v_j+1)<cur_i.sal then
          p_result:='工资太高(?)';
          --update copy_emp set sal=v_lower(v_j) where current of cur_e;  
        end if;
       end if;
     end loop;
   end loop;
end get_valid_sal_range;
/
