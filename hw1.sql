/*
因为是scott用户下的emp表，因此题目中的字段名称、内容和表中不太一样；
按照题目查询deptno等的数值的话，我这里emp表中并不能查到内容。但是测试的时候有用自己的数值测试到。
下面的答案呈现的是按照题目要求的查询内容。
*/
-- 1-9
select unique job from emp;
-- 1-11
select ename||', '||job "Employee and Title" from emp ;
-- 1-12
-- select * from emp
select empno||' ,'||ename||' ,'||job||' ,'||mgr||' ,'||hiredate||' ,'|| sal||' ,'||comm||' ,'||deptno The_OUTPUT from emp;
-- 2-4
select ename, job, hiredate from emp
where hiredate>to_date('1998-02-20','yyyy-mm-dd') and hiredate < to_date('1998-03-01','yyyy-mm-dd')
order by hiredate asc;
-- 2-8
select ename, job from emp where nvl(mgr,1)=1;
-- 2-11
select ename from emp where ename like '%a%' and ename like '%e%';
-- 2-12
select ename, job, sal from emp 
where job = 'ST_CLERK' or job = 'SA_REP' and 
sal != 2500 and sal != 3500 and sal != 7000;
-- 4-2
select unique job, dept.loc 
from emp join dept on emp.deptno = dept.deptno
where emp.deptno = 30 or emp.deptno=90;
-- 4-5
select ename, job, emp.deptno, dname
from emp join dept on emp.deptno = dept.deptno
where dept.loc='TORONTO';
-- 4-10
select ename, hiredate from emp e1
where exists (
select hiredate from emp e2
where ename='DAVIES' and e2.hiredate < e1.hiredate
);
-- 4-11
select e1.ename Employee, e1.hiredate "Emp Hired", e2.ename "Manager", e2.hiredate "Mgr Hired"
from emp e1 join emp e2 on e1.mgr = e2.empno
where e1.hiredate < e2.hiredate;
-- 5-6
select job, count(*) from emp 
group by job;
-- 5-7
select count(unique mgr) as "Number of Managers" from emp;
-- 5-9
select mgr, sal from emp
where sal in (
select min(sal) from emp where nvl(mgr,1)!=1 group by mgr) 
and sal >= 6000
order by sal desc;
-- 5-10
select d1.dname "Name", loc "Location", cnt "Number of People" ,sals "Salary"
from dept d1 join(
select dname,count(*) cnt, sum(sal) sals
from dept join emp on dept.deptno = emp.deptno
group by dept.dname) t 
on d1.dname = t.dname;
-- 5-11
select * from (select count(*) from emp) TOTAL natural join (
select count(*) "1987" from emp
where to_char(hiredate,'YYYY') = 1995
group by to_char(hiredate,'YYYY')) natural join (
select count(*) "1980" from emp
where to_char(hiredate,'YYYY') = 1996
group by to_char(hiredate,'YYYY')) natural join (
select count(*) "1982" from emp
where to_char(hiredate,'YYYY') = 1997
group by to_char(hiredate,'YYYY'))  natural join (
select count(*) "1981" from emp
where to_char(hiredate,'YYYY') = 1998
group by to_char(hiredate,'YYYY'));

-- 5-12
select t.job, t1.sal "Dept 20", t2.sal "Dept 50",t3.sal "Dept 80",t4.sal "Dept 90" tot "Total"  from 
(select job,sum(sal) tot from emp
group by job) t 
left join
(select job, sal, deptno from emp
where deptno = 20) t1 on t.job = t1.job
left join
(select job, sal, deptno from emp
where deptno = 50) t2 on t.job = t2.job and t1.job = t2.job
left join
(select job, sal, deptno from emp
where deptno = 80) t3 on t.job = t3.job and t1.job = t3.job and t2.job = t3.job
left join
(select job, sal, deptno from emp
where deptno = 90) t4 on t.job = t4.job and t1.job = t4.job and t2.job = t4.job and t3.job = t4.job;
-- 6-4
select ename, deptno, job from emp
where exists (select * from dept where loc = 1700 and dept.deptno = emp.deptno);
-- 6-5
select ename, sal from emp e
where exists(select * from emp m where m.empno = e.mgr and m.ename='KING');
-- 6-6
select deptno, ename, job from emp
where exists (select * from dept where dept.deptno = emp.deptno and dept.dname = 'EXECUTIVE');
-- 6-7
select empno, ename, sal from emp 
where sal > all (select avg(sal)from emp)
and deptno in (select deptno from emp where ename like '%u%');
