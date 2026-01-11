USE social_network_pro;

EXPLAIN ANALYZE
SELECT u.user_id, u.username, u.full_name, u.hometown, f.friend_id, f.status
FROM users u
LEFT JOIN friends f ON u.user_id = f.user_id
WHERE u.hometown = 'Hà Nội'
ORDER BY u.username DESC
LIMIT 3;

CREATE INDEX idx_hometown ON users(hometown);

EXPLAIN ANALYZE
SELECT u.user_id, u.username, u.full_name, u.hometown, f.friend_id, f.status
FROM users u
LEFT JOIN friends f ON u.user_id = f. user_id
WHERE u.hometown = 'Hà Nội'
ORDER BY u.username DESC
LIMIT 3;