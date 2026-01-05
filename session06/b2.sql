create database b2_session06;
use b2_session06;

create table customers (
    customer_id int primary key,
    full_name varchar(255),
    city varchar(255)
);

create table orders (
    order_id int primary key,
    customer_id int,
    order_date date,
    status enum('pending','completed','cancelled'),
    total_amount decimal(10,2),
    foreign key (customer_id) references customers(customer_id)
);

insert into customers (customer_id, full_name, city) values
(1,'nguyễn văn an','hà nội'),
(2,'trần thị bình','đà nẵng'),
(3,'lê văn cường','tp. hồ chí minh'),
(4,'phạm thị dung','hải phòng'),
(5,'hoàng văn em','cần thơ');

insert into orders (order_id, customer_id, order_date, status, total_amount) values
(101,1,'2025-01-01','completed',1500000),
(102,1,'2025-01-03','pending',2300000),
(103,2,'2025-01-05','completed',1800000),
(104,3,'2025-01-06','cancelled',900000),
(105,3,'2025-01-07','completed',3200000);

select
    c.customer_id,
    c.full_name,
    sum(o.total_amount) as total_spent
from customers c
join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.full_name;


select
    c.customer_id,
    c.full_name,
    max(o.total_amount) as max_order_value
from customers c
join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.full_name;


select
    c.customer_id,
    c.full_name,
    sum(o.total_amount) as total_spent
from customers c
join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.full_name
order by total_spent desc;
