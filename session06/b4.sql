create database b4_session06;
use b4_session06;

create table products (
    product_id int primary key,
    product_name varchar(255),
    price decimal(10,2)
);

create table order_items (
    order_id int,
    product_id int,
    quantity int,
    foreign key (product_id) references products(product_id)
);

insert into products (product_id, product_name, price) values
(1,'laptop dell',15000000),
(2,'chuột logitech',500000),
(3,'bàn phím cơ',1200000),
(4,'màn hình samsung',4500000),
(5,'tai nghe sony',3000000);

insert into order_items (order_id, product_id, quantity) values
(101,1,1),
(102,1,2),
(103,2,5),
(104,3,3),
(105,4,2),
(106,5,2),
(107,5,1);


select
    p.product_id,
    p.product_name,
    sum(oi.quantity) as total_sold
from products p
join order_items oi
on p.product_id = oi.product_id
group by p.product_id, p.product_name;


select
    p.product_id,
    p.product_name,
    sum(oi.quantity * p.price) as revenue,
    avg(p.price) as avg_price
from products p
join order_items oi
on p.product_id = oi.product_id
group by p.product_id, p.product_name;

select
    p.product_id,
    p.product_name,
    sum(oi.quantity * p.price) as revenue
from products p
join order_items oi
on p.product_id = oi.product_id
group by p.product_id, p.product_name
having sum(oi.quantity * p.price) > 5000000;
