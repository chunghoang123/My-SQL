create database b3_session07;
use b2_session07;

create table orders
(
    id          int primary key,
    customer_id int,
    order_data  date,
    total_amout decimal(10, 2)
);
insert into orders(id, customer_id, order_data, total_amout)
values (201, 1, '2025-01-05', 150000),
       (202, 2, '2025-01-07', 300000),
       (203, 3, '2025-01-10', 450000),
       (204, 4, '2025-01-12', 200000),
       (205, 5, '2025-01-15', 600000);


select *
from orders
where total_amout > (select avg(total_amout) from orders);