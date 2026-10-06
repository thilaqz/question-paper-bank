create table depositor (
  cname varchar2(20),
  acno  number,
  lno   varchar2(10)
);

insert into depositor values ('ramesh', 101, 'L-101');
insert into depositor values ('kauya', 102, 'L-102');
insert into depositor values ('rahul', 103, 'L-103');
insert into depositor values ('rahul', 104, 'L-104');
insert into depositor values ('rahul', 105, 'L-105');

create table borrower (
  cname varchar2(20),
  lno   varchar2(10),
  amt   number(6)
);

insert into borrower values ('ramesh', 'L-101', 10000);
insert into borrower values ('viji', 'L-102', 30000);
insert into borrower values ('rahul', 'L-103', 20000);
insert into borrower values ('rahul', 'L-104', 30000);
insert into borrower values ('rahul', 'L-105', 75000);

select cname from depositor
union
select cname from borrower;

select cname from depositor
intersect
select cname from borrower;

select cname from depositor
minus
select cname from borrower;

select cname, amt, amt / 2 as half_amt from borrower;
