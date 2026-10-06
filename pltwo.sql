create table employee (
  empid  number,
  ename  varchar2(20),
  salary number(6)
);

insert into employee values (1, 'ravi', 5000);
insert into employee values (2, 'meena', 6000);
insert into employee values (3, 'karthi', 4500);
insert into employee values (4, 'vijay', 7000);
insert into employee values (5, 'radha', 5500);

commit;

select * from employee;

set serveroutput on;

create or replace function totemp return number is
  c number;
begin
  select count(*) into c from employee;
  return c;
end;
/

declare
  t number;
begin
  t := totemp();
  dbms_output.put_line('total employee: ' || t);
end;
/

declare
  v_sal employee.salary%type;
begin
  select salary into v_sal from employee
  where empid = &empid;
  dbms_output.put_line('salary: ' || v_sal);
exception
  when no_data_found then
    dbms_output.put_line('no employee found with that id');
  when others then
    dbms_output.put_line('some other error occurred');
end;
/

create or replace trigger emp_audit
after insert on employee
for each row
begin
  dbms_output.put_line('new employee inserted: ' || :new.empid || ' ' || :new.ename ||
                       ' at ' || to_char(sysdate, 'dd-mm-yyyy hh24:mi:ss'));
end;
/

insert into employee values (6, 'siva', 6500);

commit;

select * from employee;
