create table marksheet (
  rno     number,
  name    varchar2(20),
  m1      number,
  m2      number,
  m3      number,
  total   number,
  average number,
  result  varchar2(20)
);

insert into marksheet values (1, 'ravi', 60, 70, 80, null, null, null);
insert into marksheet values (2, 'meena', 30, 40, 50, null, null, null);
insert into marksheet values (3, 'karthi', 90, 85, 95, null, null, null);
insert into marksheet values (4, 'radha', 55, 65, 75, null, null, null);
insert into marksheet values (5, 'siva', 35, 45, 55, null, null, null);

commit;

set serveroutput on;

declare
  cursor stud is select * from marksheet;
  r   marksheet%rowtype;
  tot number;
  avg number;
  res varchar2(10);
begin
  open stud;
  loop
    fetch stud into r;
    exit when stud%notfound;

    tot := r.m1 + r.m2 + r.m3;
    avg := tot / 3;

    if r.m1 < 40 or r.m2 < 40 or r.m3 < 40 then
      res := 'fail';
    else
      res := 'pass';
    end if;

    update marksheet
    set total = tot, average = avg, result = res
    where rno = r.rno;
  end loop;
  close stud;
  commit;
end;
/

select * from marksheet;
