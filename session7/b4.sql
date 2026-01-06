create database b4_session07;
use b4_session07;

create table customers
(
    id    int primary key,
    name  varchar(100),
    email varchar(100)
);

create table orders
(
    id           int primary key,
    customer_id  int,
    order_data   date,
    total_amount decimal(10, 2)
);

insert into customers(id, name, email)
values (1, 'Nguyen Van A', 'a@gmail.com'),
       (2, 'Tran Thi B', 'b@gmail.com'),
       (3, 'Le Van C', 'c@gmail.com'),
       (4, 'Pham Thi D', 'd@gmail.com'),
       (5, 'Hoang Van E', 'e@gmail.com');

insert into orders(id, customer_id, order_data, total_amount)
values (301, 1, '2025-01-05', 150000),
       (302, 1, '2025-01-10', 300000),
       (303, 2, '2025-01-12', 200000),
       (304, 3, '2025-01-15', 450000),
       (305, 3, '2025-01-18', 500000);


select name, (select count(*) from orders where orders.customer_id = customer_id) as order_count
from customers;