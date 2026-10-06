create table department (deptid number, deptname varchar2(20));

insert into department values (1, 'HR');
insert into department values (2, 'IT');
insert into department values (3, 'sales');
insert into department values (4, 'finance');

create table employee (empid number, ename varchar2(20), deptid number, salary number(6));

insert into employee values (101, 'ravi', 1, 3000);
insert into employee values (102, 'meena', 2, 5000);
insert into employee values (103, 'karthi', 2, 4500);
insert into employee values (104, 'siva', 3, 2800);

select employee.ename, department.deptname
from employee inner join department
on employee.deptid = department.deptid;

select d.deptname, e.ename
from department d left outer join employee e
on d.deptid = e.deptid;

select d.deptname, e.ename
from employee e right outer join department d
on e.deptid = d.deptid;

select d.deptname, e.ename
from department d full outer join employee e
on d.deptid = e.deptid;

select e.empid, e.ename, d.deptname
from employee e, department d
where e.deptid = d.deptid;

select d.deptname, count(*) as emp_count
from employee e join department d
on e.deptid = d.deptid
group by d.deptname
having count(*) > 1;
