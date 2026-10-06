create table employee (
  empid  number,
  ename  varchar2(20),
  salary number(6)
);

insert into employee values (1, 'ravi', 5000);
insert into employee values (2, 'meena', 4000);
insert into employee values (3, 'karthi', 4500);
insert into employee values (4, 'vijay', 5500);
insert into employee values (5, 'radha', 3000);

select * from employee;

commit;

savepoint sp1;

insert into employee values (6, 'siva', 6000);

rollback to sp1;

alter table employee add dept varchar2(20);

update employee set dept = 'IT' where empid in (1, 2);

update employee set dept = 'HR' where empid = 3;

update employee set dept = 'finance' where empid = 4;

update employee set dept = 'sales' where empid = 5;

select * from employee;

alter table employee drop column dept;

create view view_high_salary as
select empid, ename from employee where salary > 4500;

select * from view_high_salary;

drop view view_high_salary;

truncate table employee;

drop table employee;
