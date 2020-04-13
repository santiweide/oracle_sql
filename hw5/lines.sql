-- 4-a
select level,last_name, salary, department_id from employees
where department_id in (select department_id from employees where last_name='Mourgos')
start with Last_name = 'Mourgos'
connect by PRIOR employee_id=manager_id;
-- 4-b
select level,employee_id, last_name, manager_id from employees
start with employee_id in 
(select employee_id from employees 
 where employee_id in (select manager_id from employees where last_name='Lorentz'))
connect by PRIOR employee_id=manager_id;
