create database ss5_b2;
use ss5_b2;
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    city VARCHAR(255),
    status ENUM('active', 'inactive') DEFAULT 'active'
);
INSERT INTO customer (full_name, email, city, status)
VALUES
('Nguyễn Văn A', 'vana@gmail.com', 'Hà Nội', 'active'),
('Trần Thị B', 'thib@gmail.com', 'Đà Nẵng', 'active'),
('Lê Văn C', 'vanc@gmail.com', 'TP.HCM', 'inactive');

SELECT * FROM customer;
select * from customer where city = 'TP.HCM';
select * from customer where city = 'Hà Nội';
select * from customer 
order by full_name asc;