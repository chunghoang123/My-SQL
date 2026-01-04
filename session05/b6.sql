create database ss5_b6;
use ss5_b6;
CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    status ENUM('active', 'inactive') DEFAULT 'active'
);
ALTER TABLE product
ADD sold_quantity INT NOT NULL DEFAULT 0;
INSERT INTO product (product_name, price, stock, sold_quantity, status) VALUES
('Laptop Dell XPS 13',        25990000.00, 10, 3,  'active'),
('Laptop HP Spectre x360',   28990000.00, 8,  2,  'active'),
('MacBook Air M2',           27990000.00, 12, 5,  'active'),
('MacBook Pro M1',           32990000.00, 6,  4,  'active'),
('Asus ROG Strix G15',       24990000.00, 5,  5,  'inactive'),
('Lenovo ThinkPad X1',       30990000.00, 7,  1,  'active'),
('Acer Swift 3',             17990000.00, 15, 6,  'active'),
('MSI Gaming GF63',          19990000.00, 9,  3,  'active'),
('Chuột Logitech G102',        450000.00, 50, 20, 'active'),
('Chuột Razer DeathAdder',    890000.00, 40, 15, 'active'),
('Bàn phím cơ AKKO 3087',    1200000.00, 30, 10, 'active'),
('Bàn phím cơ Keychron K6',  2190000.00, 20, 7,  'inactive'),
('Tai nghe Sony WH-1000XM5', 7990000.00, 10, 4,  'active'),
('Tai nghe JBL Tune 510BT',  1290000.00, 25, 12, 'active'),
('Màn hình LG UltraGear 27"', 6990000.00, 8,  2,  'active');


select * from product 
where status = 'active' and price between 1000000 and 3000000
order by price asc
limit 10 offset 0 
;

select * from product 
where status = 'active' and price between 1000000 and 3000000
order by price asc
limit 10 offset 10 
;