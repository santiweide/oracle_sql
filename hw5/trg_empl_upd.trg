create or replace trigger trg_empl_upd
  before update on emp  
  for each row
declare
e_less exception;
e_more exception;
e_no exception;
pragma exception_init(e_less,-20202);
pragma exception_init(e_more,-20203);
pragma exception_init(e_no,-20204);
begin
  if :new.sal <= :old.sal then
    raise e_less;
  elsif :new.sal > :old.sal*1.1 then
    raise e_more;
  elsif :old.deptno = 10 then
    raise e_no;
  else dbms_output.put_line('����Ĺ��ʱ䶯');
  end if;
exception
  when e_less then
    raise_application_error(-20202,'�¹���̫����');
  when e_more then
    raise_application_error(-20203,'�¹���̫����');
  when e_no then
    raise_application_error(-20204,'���ܸ�10�Ų��ż�н');
end trg_empl_upd;
/
