create or replace trigger trg_emp_dept
  before update on emp  
  for each row

begin
  if updating('deptno') then 
      insert into emp_jobhistory (empno, deptno ,timeon) values 
    (:NEW.empno,:NEW.deptno, sysdate);
  end if;
end trg_emp_dept;
/
