/*RFM Analysis*/
# create a new database for the project
create database rfm;
use rfm;
-- create a table to be able to load the data from csv file.

drop table maindata;

CREATE TABLE maindata (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description VARCHAR(20),
    Quantity NUMERIC(10),
    InvoiceDate DATETIME,
    UnitPrice NUMERIC(20),
    CustomerID VARCHAR(20),
    Country VARCHAR(20)
);

-- check whether the local infile is enabled or not
show global variables like "local_infile";
set global local_infile=1;

load data local infile "D:\\AI\\bootup\\BootUP-DS-ML\\OnlineRetail.csv" into table maindata 
character set latin1 fields terminated by ',' enclosed by '"' lines terminated by '\r\n' ignore 1 lines
(InvoiceNo,StockCode,Description,Quantity,@tmp_date,UnitPrice,CustomerID,Country)
set InvoiceDate = str_to_date(@tmp_date,'%d-%m-%Y %h:%i');

-- explore the data
select * from maindata;


select count(*) from maindata;

-- Calculate Recency - create a table - recency
drop table recency;
create table recency select customerid, Max(invoicedate) as last_order_date from maindata 
group by customerid order by last_order_date desc;

select * from recency;

select count(*) from recency;

-- create a frequency table
drop table frequency;
create table frequency select customerid as freq_cid, count(invoicedate) as frequency_order from maindata
group by customerid order by frequency_order desc;

select * from frequency;
select count(*) from frequency;

-- create a table from monetry
create table monetry select customerid, sum(quantity*unitprice) as monetry_value from maindata
group by customerid order by monetry_value desc;

select * from monetry;
select count(*) from monetry;

-- first join
create table table1 select customerid as cid,last_order_date,frequency_order from recency,frequency where recency.customerid = frequency.freq_cid;

select * from table1;

-- second join to create the master table
create table table2 select customerid, last_order_date, frequency_order, monetry_value from table1,monetry where
table1.cid = monetry.customerid;

select * from table2;
select count(*) from table2;

-- dropping the rows with missing values
select * from table2 where customerid is NULL or last_order_date is null or frequency_order is null or monetry_value is null;
DELETE FROM table2 
WHERE
    customerid IS NULL
    or customerid = ""
    OR last_order_date IS NULL
    OR frequency_order IS NULL
    OR monetry_value IS NULL;

select count(*) from table2;

select * from table2;

-- create a table11 - contaiing customers from 1st quartile of frequency and 1st quartile of monetry

select @length := count(*) from table2;

set @length = round(@length/4);
select @length;


create table rfm1 select customerid as cid,frequency_order from table2 order by frequency_order desc limit 805;
create table rfm2 select customerid,monetry_value from table2 order by monetry_value desc limit 805;

create table table11 select customerid,frequency_order,monetry_value from rfm1 inner join rfm2 on rfm1.cid = rfm2.customerid;

select count(*) from table11;

drop table rfm3;
create table rfm3 select customerid as cid,last_order_date from table2 order by last_order_date desc limit 805;
select * from rfm3;
-- finding the best customers - RFM = 111 
create table best_customers_111 select customerid, last_order_date, frequency_order,monetry_value from rfm3 inner join
table11 on rfm3.cid = table11.customerid;

select * from best_customers_111;
select count(*) from best_customers_111;

-- finding almost lost customers - 311;
create table rfm4 select customerid as cid,last_order_date from table2 order by last_order_date desc limit 1610,805;

create table almostlost_customers_311 select customerid, last_order_date, frequency_order,monetry_value from rfm4 inner join
table11 on rfm4.cid = table11.customerid;

select * from almostlost_customers_311;
select count(*) from almostlost_customers_311;

-- finding almost lost customers - 411;
create table rfm5 select customerid as cid,last_order_date from table2 order by last_order_date desc limit 2415,805;

create table lost_customers_411 select customerid, last_order_date, frequency_order,monetry_value from rfm5 inner join
table11 on rfm5.cid = table11.customerid;

select * from lost_customers_411;
select count(*) from lost_customers_411;



