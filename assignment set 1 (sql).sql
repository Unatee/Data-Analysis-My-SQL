create database assignment;
use assignment;
show tables;
insert into countries values ("china",1382,"Beijing");
select * from countries;
insert into countries values ("India",1326,"Delhi"),
("United States",324,"Washington D.C.");
insert into countries values ("Indonesia",260,"Jakarta"),("Brazil",209,"Brasilia"),("Pakistan",193,"Islamabad"),("Nigeria",187,"Abuja"),
("Bangladesh",163,"Dhaka"),("Russia",143,"Moscow"),("Mexico",128,"Mexico City"),("Japan",126,"Tokyo"),("Philippines",102,"Manila"),("Ethiopia",101,"Addis Ababa"),("Vietnam",94,"Hanoi"),("Egypt",93,"Cairo"),("Germany",81,"Berlin"),("Iran",80,"Tehran"),("Turkey",79,"Ankara"),("Congo",79,"Kinshasa"),("France",64,"Paris"),("United Kingdom",65,"London"),
("Italy",60,"Rome"),("South Africa",55,"Pretoria"),("Myanmar",54,"Naypyidaw");
insert into countries values (" Australia",1126,"canberra");
select * from countries;
set sql_safe_updates=0;
update countries set capital="New Delhi" where capital="Delhi";
rename table countries to big_countries;
select * from big_countries;
CREATE TABLE Product(product_Id int primary key, product_name varchar(255) not null unique,supplier_id int unique);
CREATE TABLE Suppliers(supplier_Id int primary key unique, supplier_name varchar(255),location varchar (255), 
foreign key (supplier_id) references product(supplier_id)on update cascade on delete cascade);
CREATE TABLE Stock(Id int primary key, product_Id int,balance_stock int,foreign key (product_Id) references product(Product_id)on update cascade on delete cascade);
select * from stock;
desc table stock;
insert into product values (110,"laptop",1104); 
insert into product values (111,"phone",1105),(112,"bag",1106),(113,"shoe",1107);
insert into suppliers values (1104,"pen","nirmal"),(1105,"book","nizambad"),(1106,"pencil","adilabad"),(1107,"rome","hyd");
insert into stock values (1111,110,540),(1112,111,550),(1113,112,570),(1114,113,580);
alter table suppliers modify supplier_name varchar(255) unique not null;
select * from emp;
alter table emp add deptno int; 
update emp set deptno=20 where emp_no%2=0 ;
update emp set deptno=30 where emp_no%3=0 ;
update emp set deptno=40 where emp_no%4=0 ;
update emp set deptno=50 where emp_no%5=0 ;
update emp set deptno=10 where emp_no%2 and 3 and 4 and 5<>0;
alter table emp modify column emp_no int not null primary key;
create unique index u_index on emp(emp_no);
show index from emp;
create view emp_sal as select emp_no,first_name,last_name,salary from emp order by salary desc;







