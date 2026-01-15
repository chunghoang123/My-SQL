use social_network;

create table  followers (
    follower_id int not null,
    followed_id int not null,
    primary key (follower_id, followed_id),
    foreign key (follower_id) references users(user_id),
    foreign key (followed_id) references users(user_id)
);
alter table users
add column following_count int default 0,
add column followers_count int default 0;

create table follow_log (
    log_id int auto_increment primary key,
    follower_id int,
    followed_id int,
    error_message varchar(255),
    created_at datetime default current_timestamp
);
delimiter $$

create procedure sp_follow_user (
    in p_follower_id int,
    in p_followed_id int
)
begin
    declare v_count int;

    start transaction;

    -- kiểm tra follower tồn tại
    select count(*) into v_count
    from users
    where user_id = p_follower_id;

    if v_count = 0 then
        insert into follow_log (follower_id, followed_id, error_message)
        values (p_follower_id, p_followed_id, 'follower does not exist');
        rollback;
        leave proc_end;
    end if;

    -- kiểm tra followed tồn tại
    select count(*) into v_count
    from users
    where user_id = p_followed_id;

    if v_count = 0 then
        insert into follow_log (follower_id, followed_id, error_message)
        values (p_follower_id, p_followed_id, 'followed user does not exist');
        rollback;
        leave proc_end;
    end if;

    -- không cho tự follow chính mình
    if p_follower_id = p_followed_id then
        insert into follow_log (follower_id, followed_id, error_message)
        values (p_follower_id, p_followed_id, 'cannot follow yourself');
        rollback;
        leave proc_end;
    end if;

    -- kiểm tra đã follow trước đó chưa
    select count(*) into v_count
    from followers
    where follower_id = p_follower_id
      and followed_id = p_followed_id;

    if v_count > 0 then
        insert into follow_log (follower_id, followed_id, error_message)
        values (p_follower_id, p_followed_id, 'already followed');
        rollback;
        leave proc_end;
    end if;

    -- insert follow
    insert into followers (follower_id, followed_id)
    values (p_follower_id, p_followed_id);

    -- cập nhật số lượng
    update users
    set following_count = following_count + 1
    where user_id = p_follower_id;

    update users
    set followers_count = followers_count + 1
    where user_id = p_followed_id;

    commit;

    proc_end: end;
end$$

delimiter ;
call sp_follow_user(1, 2);
call sp_follow_user(1, 2);
call sp_follow_user(1, 1);
call sp_follow_user(1, 999);
select * from followers;
select user_id, following_count, followers_count from users;
select * from follow_log;
