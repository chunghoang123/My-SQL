create database if not exists mini_social_one;
use mini_social_one;

-- =========================
-- 1. bảng duy nhất
-- =========================
create table social_data (
    id int auto_increment primary key,

    record_type varchar(20) not null,
    -- user | post | like | friend | log

    user_id int,
    target_id int,

    username varchar(50),
    password varchar(255),
    email varchar(100),

    content text,
    status varchar(20),

    created_at datetime default current_timestamp
);

-- =========================
-- 2. đăng ký thành viên
-- =========================
delimiter $$

create procedure sp_register_user(
    in p_username varchar(50),
    in p_password varchar(255),
    in p_email varchar(100)
)
begin
    if exists (
        select 1 from social_data
        where record_type = 'user'
          and (username = p_username or email = p_email)
    ) then
        signal sqlstate '45000'
        set message_text = 'username or email already exists';
    end if;

    insert into social_data(record_type, username, password, email)
    values ('user', p_username, p_password, p_email);

    insert into social_data(record_type, content)
    values ('log', concat('register user ', p_username));
end$$

delimiter ;

-- =========================
-- 3. đăng bài viết
-- =========================
delimiter $$

create procedure sp_create_post(
    in p_user_id int,
    in p_content text
)
begin
    if p_content is null or length(trim(p_content)) = 0 then
        signal sqlstate '45000'
        set message_text = 'content empty';
    end if;

    insert into social_data(record_type, user_id, content)
    values ('post', p_user_id, p_content);

    insert into social_data(record_type, content)
    values ('log', concat('user ', p_user_id, ' create post'));
end$$

delimiter ;

-- =========================
-- 4. like / unlike bài viết
-- =========================
delimiter $$

create procedure sp_like_post(
    in p_user_id int,
    in p_post_id int
)
begin
    if exists (
        select 1 from social_data
        where record_type = 'like'
          and user_id = p_user_id
          and target_id = p_post_id
    ) then
        signal sqlstate '45000'
        set message_text = 'already liked';
    end if;

    insert into social_data(record_type, user_id, target_id)
    values ('like', p_user_id, p_post_id);

    insert into social_data(record_type, content)
    values ('log', concat('user ', p_user_id, ' like post ', p_post_id));
end$$

delimiter ;

delimiter $$

create procedure sp_unlike_post(
    in p_user_id int,
    in p_post_id int
)
begin
    delete from social_data
    where record_type = 'like'
      and user_id = p_user_id
      and target_id = p_post_id;

    insert into social_data(record_type, content)
    values ('log', concat('user ', p_user_id, ' unlike post ', p_post_id));
end$$

delimiter ;

-- =========================
-- 5. gửi lời mời kết bạn
-- =========================
delimiter $$

create procedure sp_send_friend_request(
    in p_user_id int,
    in p_friend_id int
)
begin
    if p_user_id = p_friend_id then
        signal sqlstate '45000'
        set message_text = 'cannot add yourself';
    end if;

    if exists (
        select 1 from social_data
        where record_type = 'friend'
          and user_id = p_user_id
          and target_id = p_friend_id
    ) then
        signal sqlstate '45000'
        set message_text = 'request exists';
    end if;

    insert into social_data(record_type, user_id, target_id, status)
    values ('friend', p_user_id, p_friend_id, 'pending');

    insert into social_data(record_type, content)
    values ('log', concat('friend request ', p_user_id, ' -> ', p_friend_id));
end$$

delimiter ;

-- =========================
-- 6. chấp nhận kết bạn
-- =========================
delimiter $$

create procedure sp_accept_friend(
    in p_user_id int,
    in p_friend_id int
)
begin
    update social_data
    set status = 'accepted'
    where record_type = 'friend'
      and user_id = p_friend_id
      and target_id = p_user_id;

    insert into social_data(record_type, user_id, target_id, status)
    values ('friend', p_user_id, p_friend_id, 'accepted');

    insert into social_data(record_type, content)
    values ('log', concat('friend accepted ', p_user_id, ' <-> ', p_friend_id));
end$$

delimiter ;

-- =========================
-- 7. xóa quan hệ bạn bè
-- =========================
delimiter $$

create procedure sp_delete_friend(
    in p_user_id int,
    in p_friend_id int
)
begin
    start transaction;

    delete from social_data
    where record_type = 'friend'
      and (
           (user_id = p_user_id and target_id = p_friend_id)
        or (user_id = p_friend_id and target_id = p_user_id)
      );

    if row_count() = 0 then
        rollback;
        signal sqlstate '45000'
        set message_text = 'relationship not found';
    end if;

    commit;
end$$

delimiter ;

-- =========================
-- 8. xóa bài viết
-- =========================
delimiter $$

create procedure sp_delete_post(
    in p_post_id int,
    in p_user_id int
)
begin
    start transaction;

    delete from social_data
    where id = p_post_id
      and record_type = 'post'
      and user_id = p_user_id;

    if row_count() = 0 then
        rollback;
        signal sqlstate '45000'
        set message_text = 'no permission';
    end if;

    delete from social_data
    where record_type = 'like'
      and target_id = p_post_id;

    commit;
end$$

delimiter ;

-- =========================
-- 9. xóa tài khoản
-- =========================
delimiter $$

create procedure sp_delete_user(
    in p_user_id int
)
begin
    start transaction;

    delete from social_data
    where user_id = p_user_id
       or target_id = p_user_id;

    commit;
end$$

delimiter ;
