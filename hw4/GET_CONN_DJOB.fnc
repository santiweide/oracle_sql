create or replace function GET_CONN_DJOB return varchar2 is
cursor cur_p is
       select distinct job from emp;
v_ret varchar2(200);
begin
  v_ret:='';
  for cur_i in cur_p loop
    v_ret := v_ret || cur_i.job || ' ';
  end loop;
  return v_ret;
end GET_CONN_DJOB;
/
