create database b2_session07;
use b2_session07;


create table products
(
    id    int primary key,
    name  varchar(100) not null,
    price decimal(10, 2)
);

create table order_items
(
    order_id   int,
    product_id int,
    quantity   int
);

insert into products(id, name, price)
values (1, 'Laptop Dell', 15000000),
       (2, 'Chuột Logitech', 500000),
       (3, 'Bàn phím cơ', 1200000),
       (4, 'Màn hình Samsung', 4500000),
       (5, 'Tai nghe Sony', 2500000),
       (6, 'USB 64GB', 300000),
       (7, 'Webcam Logitech', 1800000);

insert into order_items(order_id, product_id, quantity)
values (101, 1, 1),
       (101, 2, 2),
       (102, 3, 1),
       (103, 1, 1),
       (104, 5, 1),
       (105, 6, 3),
       (106, 2, 1);

select *
from products
where id in (select product_id from order_items);