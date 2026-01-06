create  database  b6_session07;
use  b6_session07;

create table orders
(
    id           int primary key,
    customer_id  int,
    order_data   date,
    total_amount decimal(10, 2)
);
insert into orders(id, customer_id, order_data, total_amount)
values (301, 1, '2025-01-05', 150000),
       (302, 1, '2025-01-10', 300000),
       (303, 2, '2025-01-12', 200000),
       (304, 3, '2025-01-15', 450000),
       (305, 3, '2025-01-18', 500000);

select customer_id
from orders
group by customer_id
having sum(total_amount) > (
    select avg(total_spent)
    from (
        select sum(total_amount) as total_spent
        from orders
        group by customer_id
    ) as temp
);
