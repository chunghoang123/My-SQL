create database ss5_b1;
use ss5_b1;
CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    status ENUM('active', 'inactive') DEFAULT 'active'
);
INSERT INTO product (product_name, price, stock, status)
VALUES
('Laptop Dell XPS 13', 25990000.00, 10, 'active'),
('Chuột Logitech G102', 450000.00, 50, 'active'),
('Bàn phím cơ AKKO', 1200000.00, 0, 'inactive');

select * from product;
select * from product where status = 'active';
select * from product where status = 'active'
order by price asc;
select * from product where price > 1000000;