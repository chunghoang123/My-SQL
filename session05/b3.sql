create database ss5_b3;
use ss5_b3;

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    order_date DATE NOT NULL,
    status ENUM('pending', 'completed', 'cancelled') DEFAULT 'pending'
);
INSERT INTO orders (customer_id, total_amount, order_date, status)
VALUES
(1, 1500000.00, '2025-01-01', 'completed'),
(2, 3200000.00, '2025-01-03', 'pending'),
(1, 890000.00, '2025-01-05', 'cancelled');
INSERT INTO orders (customer_id, total_amount, order_date, status)
VALUES
(3, 6000000.00, '2025-01-06', 'completed');
INSERT INTO orders (customer_id, total_amount, order_date, status)
VALUES
(4, 12.00, '2025-01-01', 'completed'),
(5, 334.00, '2025-01-03', 'pending'),
(6, 56.00, '2025-01-05', 'cancelled');
select * from orders 
where status = 'completed';
select * from orders
where total_amount > 5000000;

select * from orders
order by order_date desc
limit 5 offset 0;

select * from orders
where status = 'completed'  order by total_amount desc;