
use database "INEURON_ANANDJHA";
create or replace table Assignment1(
 order_id varchar(60) ,
 order_date varchar(60),
 ship_date varchar(60),
 ship_mode varchar(60),
 customer_name varchar(60),
 segment varchar(60),
 state varchar(60),
 country varchar(60),
 market varchar(60),
 region varchar(60),
 product_id varchar(60),
 category varchar(60),
 sub_category varchar(60),
 product_name varchar(200),
 sales int,
 quantity int,
 discount float,
 profit float,
 shipping_cost float,
 order_priority varchar,
 year number(10,0)
);
select * from assignment1;

Describe table assignment1;



create table assignment1copy as select * from assignment1;
select * from assignment1copy;
Describe tableassignment1copy;
select get_ddl('table','assignment1copy');
Describe table assignment1;


--1 .SET PRIMARY KEY.
alter table assignment1
add primary key (order_id);

--2. CHECK THE ORDER DATE AND SHIP DATE TYPE AND THINK IN WHICH DATA TYPE YOU HAVE TO CHANGE.
Describe table assignment1;


--here the datatype is set as varchar we will cahnge it to Date type
select to_char(to_date(order_date,'dd-mm-yyyy')) from assignment1;
ALTER TABLE assignment1
add column orders_date date ;

update assignment1
set orders_date = to_date(order_date,'dd-mm-yyyy')
where order_id = order_id;

ALTER TABLE assignment1
add column shipping_date date ;

update assignment1
set shipping_date = to_date(ship_date,'dd-mm-yyyy')
where order_id = order_id;

alter table assignment1
drop column ship_date;

alter table assignment1
drop column order_date;



select * from assignment1;
select * from assignment1copy;

--3. EXTACT THE LAST NUMBER AFTER THE - AND CREATE OTHER COLUMN AND UPDATE IT.

alter table assignment1
add column Id_number varchar(20) ;
select * from assignment1;
update assignment1
set Id_number = substr(order_id,9,20)
where order_id = order_id;

--4.  FLAG ,IF DISCOUNT IS GREATER THEN 0 THEN  YES ELSE FALSE AND PUT IT IN NEW COLUMN FRO EVERY ORDER ID.
select case
when discount > 0 then 'Yes'
else 'False'
end as discount_greater_than_zero ,* from assignment1;

--5.  FIND OUT THE FINAL PROFIT AND PUT IT IN COLUMN FOR EVERY ORDER ID.
alter table assignment1
add column Final_profit number(20,5);

select * from assignment1;

update assignment1
set final_profit = profit - SHIPPING_COST
where order_id = order_id;

--6.  FIND OUT HOW MUCH DAYS TAKEN FOR EACH ORDER TO PROCESS FOR THE SHIPMENT FOR EVERY ORDER ID.
select *,(shipping_date - orders_date) as date_difference from assignment1;

--7 . FLAG THE PROCESS DAY AS BY RATING IF IT TAKES LESS OR EQUAL 3  DAYS MAKE 5,
--LESS OR EQUAL THAN 6 DAYS BUT MORE THAN 3 MAKE 4,LESS THAN 10 BUT MORE THAN 6 MAKE 3,MORE THAN 10 MAKE IT 2 FOR EVERY ORDER ID.

select *,(shipping_date - orders_date) as date_difference ,
case 
when date_difference<=3 then 5
when date_difference > 3 and date_difference<=6  then 4
when date_difference > 6 and date_difference<=10 then 3
else 2
end as rating_By_5
from assignment1;
