create database b1_session07;
use b1_session07;

create table customers
(
    id_customer   int primary key,
    name_customer varchar(50)  not null,
    email         varchar(255) not null
);

create table orders
(
    id_order     int primary key,
    customer_id  int not null,
    order_data   date,
    total_amount decimal(10, 2)

);

insert into customers (id_customer, name_customer, email)
values (1, 'Nguyen Van A', 'a@gmail.com'),
       (2, 'Tran Thi B', 'b@gmail.com'),
       (3, 'Le Van C', 'c@gmail.com'),
       (4, 'Pham Thi D', 'd@gmail.com'),
       (5, 'Hoang Van E', 'e@gmail.com'),
       (6, 'Do Thi F', 'f@gmail.com'),
       (7, 'Vu Van G', 'g@gmail.com');

insert into orders(id_order, customer_id, order_data, total_amount)
values (101, 1, '2025-01-10', 150000),
       (102, 2, '2025-01-12', 200000),
       (103, 1, '2025-01-15', 350000),
       (104, 3, '2025-01-18', 120000),
       (105, 5, '2025-01-20', 500000),
       (106, 2, '2025-01-22', 180000),
       (107, 6, '2025-01-25', 220000);

select *
from customers
where id_customer in (select orders.customer_id from orders);