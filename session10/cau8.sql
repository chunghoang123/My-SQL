USE social_network_pro;

CREATE INDEX idx_user_gender ON users(gender);

CREATE VIEW view_highly_interactive_users AS
SELECT 
    u. user_id,
    u. username,
    COUNT(c. comment_id) AS comment_count
FROM users u
JOIN comments c ON u.user_id = c.user_id
GROUP BY u.user_id, u.username
HAVING COUNT(c.comment_id) > 5;

SELECT * FROM view_highly_interactive_users;

SELECT 
    v.username,
    v.comment_count AS sum_comment_user
FROM view_highly_interactive_users v
JOIN posts p ON v.user_id = p.user_id
GROUP BY v.username, v.comment_count
ORDER BY sum_comment_user DESC;