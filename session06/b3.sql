create database b3_session06;
use b3_session06;

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
(101,1,'2025-01-01','completed',6000000),
(102,1,'2025-01-01','completed',5000000),
(103,2,'2025-01-03','completed',3000000),
(104,3,'2025-01-05','cancelled',4000000),
(105,3,'2025-01-05','completed',8000000),
(106,4,'2025-01-07','completed',4000000),
(107,5,'2025-01-07','completed',7000000);

select
    order_date as order_day,
    count(order_id) as total_orders,
    sum(total_amount) as total_revenue
from orders
where status = 'completed'
group by order_date
having sum(total_amount) > 10000000
order by total_revenue desc;
