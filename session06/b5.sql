create database b5_session06;
use b5_session06;

create table customers (
    customer_id int primary key,
    full_name varchar(255),
    city varchar(255)
);

create table orders (
    order_id int primary key,
    customer_id int,
    order_date date,
    total_amount decimal(10,2),
    foreign key (customer_id) references customers(customer_id)
);
insert into customers (customer_id, full_name, city) values
(1,'nguyễn văn an','hà nội'),
(2,'trần thị bình','đà nẵng'),
(3,'lê văn cường','tp. hồ chí minh'),
(4,'phạm thị dung','hải phòng'),
(5,'hoàng văn em','cần thơ');

insert into orders (order_id, customer_id, order_date, total_amount) values
(101,1,'2025-01-01',3000000),
(102,1,'2025-01-05',3500000),
(103,1,'2025-01-10',4000000),
(104,2,'2025-01-03',2000000),
(105,2,'2025-01-08',2500000),
(106,3,'2025-01-02',5000000),
(107,3,'2025-01-06',4000000),
(108,3,'2025-01-12',3000000),
(109,4,'2025-01-04',1500000),
(110,5,'2025-01-07',1000000);
select
    c.customer_id,
    c.full_name,
    count(o.order_id) as total_orders,
    sum(o.total_amount) as total_spent,
    avg(o.total_amount) as avg_order_value
from customers c
join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.full_name
having count(o.order_id) >= 3
   and sum(o.total_amount) > 10000000
order by total_spent desc;
