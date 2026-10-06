create table employee_nested (
  empid  number,
  ename  varchar2(20),
  dept   varchar2(20),
  salary number(6)
);

insert into employee_nested values (1, 'ravi', 'HR', 3000);
insert into employee_nested values (2, 'meena', 'IT', 5000);
insert into employee_nested values (3, 'karthi', 'IT', 4500);
insert into employee_nested values (4, 'siva', 'sales', 2500);
insert into employee_nested values (5, 'vijay', 'HR', 3500);

select ename from employee_nested
where dept in (select dept from employee_nested where dept = 'IT');

select ename from employee_nested
where dept not in (select dept from employee_nested where dept = 'HR');

select e1.ename from employee_nested e1
where exists (select * from employee_nested e2
              where e2.dept = e1.dept and e2.empid != e1.empid);

select e1.ename from employee_nested e1
where not exists (select * from employee_nested e2
                  where e2.dept = e1.dept and e2.empid = e1.empid);

select ename, salary,
       (select max(salary) from employee_nested) - salary as gap_from_max
from employee_nested;

select * from (select ename, salary from employee_nested where salary > 300)
where salary < 5000;

select ename from employee_nested
where salary = (select max(salary) from employee_nested);
