/*Creating a new database */
CREATE database AUGUST;
/*using the database august */
USE AUGUST;
/*Create a table customers in the database august*/

CREATE TABLE CUSTOMERS (
    ID INT(5),
    Name VARCHAR(20),
    Email VARCHAR(25),
    Age INT(3),
    Gender VARCHAR(8)
);

/* Delete a table */
DROP TABLE CUSTOMERS;

CREATE TABLE CUSTOMERS (
    ID INT NOT NULL auto_increment,
    Name VARCHAR(20) NOT NULL,
    Email VARCHAR(25) NOT NULL,
    Age INT,
    Gender VARCHAR(8),
    primary key (ID)
);
/*Show the table description*/
DESC customers;

/* ALTER Command */
/* add a new column */
ALTER TABLE customers ADD DOB date;
DESC customers;

/*Delete a column from a database*/
ALTER TABLE customers DROP Age;
DESC customers;

/*Modifying a column*/
ALTER TABLE customers MODIFY Email varchar(30);
DESC customers;

/***************************************************/
/*INSERT Command - DML*/
INSERT into customers (ID,Name,Email,Gender,DOB) values (1,'Anshu','anshu@xyz.com','Male','20200505');
SELECT * from customers;

/*OR */
INSERT into customers values (2,'John','john@xyz.com','Male','20000505');

/*OR */
INSERT into customers (Name,Email,Gender) values ('Marco','marco@xyz.com','Male');

SELECT * from customers;

/* Update the table */
Update customers set DOB="19810401" where ID = 3;

SELECT * from customers;

Update customers set DOB="19950401", Email="nobody@xyz.com" where ID = 1;

/**************************************************************/
/*DELETE Command */
INSERT into customers (Name,Email,Gender,DOB) values ('Max','max24@xyz.com','Male','19920101');
SELECT * from customers;

DELETE from customers where ID=4;

/**************************************************************/
/*SELECT Command */
select * from customers;

select ID,Name,DOB from customers;
/*Filters*/
select * from customers where DOB<"20000101";
select * from customers where Gender="Male";
select ID,Email from customers where Gender="Male";

select * from customers limit 2;

/* Using multiple conditions for filtering */

select * from customers where DOB<"20000101" and Gender="male";
select * from customers where DOB<"20000101" or Gender="male";

/***********************************************************************/
CREATE TABLE employee (
    Id INT NOT NULL,
    Name VARCHAR(30) NOT NULL,
    Age INT NOT NULL,
    Address VARCHAR(200),
    Salary NUMERIC(30),
    City varchar(20),
    PRIMARY KEY (Id)
);

insert into employee values(1, "John",32, "New York", 12455,'NY');
insert into employee values(2, "Robert",25, "London", 48755,'NY');
insert into employee values(3, "Juan",28, "Paris", 13525,'LON');
insert into employee values(4, "Cello",18, "Jakarta", 78925,'LON');
insert into employee values(5, "Oscar",39, "Singapore", 13655,'LON');
insert into employee values(6, "Anshu",42, "Delhi", 12455,'KUL');
insert into employee values(7, "Rahul",21, "Kualalumpur", 78555,'KUL');

select * from employee;

/*Group by operation*/

select City,avg(salary) from employee group by City; 
select sum(Salary) from employee;
select min(Salary) from employee;
select max(Salary) from employee;
select avg(Salary) from employee;


/*order by clause*/
select * from employee order by Age; 
select * from employee order by Age desc;
select City,avg(salary) from employee group by City order by avg(Salary) desc;

select * from employee order by Salary,Age desc;
 
 /*to check the total number of rows in the data*/
 select count(*) from employee;
 


 






