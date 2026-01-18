USE music_online;
create table user(
id int auto_increment primary key,
name varchar(100),
email varchar(100),
age int
);

SELECT
    g.guest_name,
    r.room_type,
    b.check_in
FROM bookings b
JOIN guests g ON b.guest_id = g.guest_id
JOIN rooms r ON b.room_id = r.room_id;

SELECT
    g.guest_name,
    COUNT(b.booking_id) AS total_bookings
FROM guests g
LEFT JOIN bookings b ON g.guest_id = b.guest_id
GROUP BY g.guest_id;

SELECT
    b.booking_id,
    g.guest_name,
    r.room_type,
    DATEDIFF(b.check_out, b.check_in) AS so_ngay_o,
    r.price_per_day,
    DATEDIFF(b.check_out, b.check_in) * r.price_per_day AS doanh_thu
FROM bookings b
JOIN guests g ON b.guest_id = g.guest_id
JOIN rooms r ON b.room_id = r.room_id;

SELECT
    r.room_type,
    SUM(DATEDIFF(b.check_out, b.check_in) * r.price_per_day) AS tong_doanh_thu
FROM bookings b
JOIN rSELECT
    g.guest_name,
    COUNT(b.booking_id) AS total_bookings
FROM guests g
JOIN bookings b ON g.guest_id = b.guest_id
GROUP BY g.guest_id
HAVING COUNT(b.booking_id) >= 2;ooms r ON b.room_id = r.room_id
GROUP BY r.room_type;

SELECT
    g.guest_name,
    COUNT(b.booking_id) AS total_bookings
FROM guests g
JOIN bookings b ON g.guest_id = b.guest_id
GROUP BY g.guest_id
HAVING COUNT(b.booking_id) >= 2;

SELECT
    r.room_type,
    COUNT(b.booking_id) AS total_bookings
FROM bookings b
JOIN rooms r ON b.room_id = r.room_id
GROUP BY r.room_type
ORDER BY total_bookings DESC
LIMIT 1;

SELECT *
FROM rooms
WHERE price_per_day > (
    SELECT AVG(price_per_day)
    FROM rooms
);

SELECT *
FROM guests
WHERE guest_id NOT IN (
    SELECT DISTINCT guest_id
    FROM bookings
);


SELECT
    r.room_id,
    r.room_type,
    COUNT(b.booking_id) AS total_bookings
FROM bookings b
JOIN rooms r ON b.room_id = r.room_id
GROUP BY r.room_id
HAVING COUNT(b.booking_id) = (
    SELECT MAX(booking_count)
    FROM (
        SELECT COUNT(*) AS booking_count
        FROM bookings
        GROUP BY room_id
    ) AS temp
);
