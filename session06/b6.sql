create database b6_session06;
use b6_session06;
create table products (
    product_id int primary key,
    product_name varchar(255),
    price decimal(10,2)
);

create table order_items (
    order_item_id int primary key,
    product_id int,
    quantity int,
    foreign key (product_id) references products(product_id)
);
insert into products (product_id, product_name, price) values
(1,'laptop dell',15000000),
(2,'chuột logitech',500000),
(3,'bàn phím cơ',1200000),
(4,'màn hình samsung',4500000),
(5,'tai nghe sony',3000000),
(6,'loa bluetooth',2500000);

insert into order_items (order_item_id, product_id, quantity) values
(1,1,3),
(2,1,4),
(3,1,5),
(4,2,10),
(5,2,15),
(6,3,8),
(7,3,5),
(8,4,6),
(9,4,5),
(10,5,7),
(11,5,6),
(12,6,4);
select
    p.product_name,
    sum(oi.quantity) as total_quantity_sold,
    sum(oi.quantity * p.price) as total_revenue,
    avg(p.price) as avg_price
from products p
join order_items oi
on p.product_id = oi.product_id
group by p.product_id, p.product_name
having sum(oi.quantity) >= 10
order by total_revenue desc
limit 5;
