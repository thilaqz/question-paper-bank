create table studentinfo(
  rno     number,
  name    varchar2(20),
  address varchar2(20),
  amount  number(6)
);

insert into studentinfo values (101,'siva','ammapet',4000);
insert into studentinfo values (102,'raja','poondi',3000);
insert into studentinfo values (103,'deva','poondi',null);
insert into studentinfo values (104,'swedha','ammapet',2500);
insert into studentinfo values (105,'ravi','chennai',1500);
insert into studentinfo values (106,'radha','erode',1000);

select name from studentinfo;

select rno, name from studentinfo;

select * from studentinfo where address = 'ammapet';

select * from studentinfo where address = 'ammapet' and amount > 3000;

select * from studentinfo where address = 'ammapet' or amount < 2000;

select * from studentinfo where not address = 'chennai';

select * from studentinfo order by name asc;

select * from studentinfo order by amount desc;

select name from studentinfo where address like '%amma%';

select name from studentinfo where address like '%di';

select name from studentinfo where address like '____';

select * from studentinfo where amount is null;

select name as student_name, address as area from studentinfo;

select distinct address from studentinfo;

select name, upper(address) as upper_address from studentinfo;
