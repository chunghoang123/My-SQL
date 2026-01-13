create database MXH;
use MXH;


create table users (
    user_id int auto_increment primary key,
    username varchar(50) not null unique,
    password varchar(255) not null,
    email varchar(100) not null unique,
    created_at datetime default current_timestamp
);

create table posts (
    post_id int auto_increment primary key,
    user_id int,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (user_id) references users(user_id)
);

create table comments (
    comment_id int auto_increment primary key,
    post_id int,
    user_id int,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id)
);

create table friends (
    user_id int,
    friend_id int,
    status varchar(20),
    check (status in ('pending', 'accepted')),
    foreign key (user_id) references users(user_id),
    foreign key (friend_id) references users(user_id)
);

create table likes (
    user_id int,
    post_id int,
    foreign key (user_id) references users(user_id),
    foreign key (post_id) references posts(post_id)
);



create index idx_users_username on users(username);
create index idx_posts_user on posts(user_id);
create index idx_posts_user_time on posts(user_id, created_at);
create index idx_likes_post on likes(post_id);



create view vw_public_users as
select user_id, username, created_at
from users;

create view vw_recent_posts as
select *
from posts
where created_at >= now() - interval 7 day;

create view vw_active_users as
select *
from users
where created_at >= '2024-01-01'
with check option;

create view vw_post_comments as
select c.content, u.username, c.created_at
from comments c
join users u on c.user_id = u.user_id;

create view vw_post_likes as
select post_id, count(*) as total_likes
from likes
group by post_id;

create view vw_top_posts as
select post_id, count(*) as total_likes
from likes
group by post_id
order by total_likes desc
limit 5;


delimiter $$

create procedure sp_create_post(
    in p_user_id int,
    in p_content text
)
begin
    if exists (select 1 from users where user_id = p_user_id) then
        insert into posts(user_id, content)
        values (p_user_id, p_content);
    else
        signal sqlstate '45000'
        set message_text = 'user not exists';
    end if;
end$$

create procedure sp_count_posts(
    in p_user_id int,
    out p_total int
)
begin
    select count(*) into p_total
    from posts
    where user_id = p_user_id;
end$$

create procedure sp_add_friend(
    in p_user_id int,
    in p_friend_id int
)
begin
    if p_user_id = p_friend_id then
        signal sqlstate '45000'
        set message_text = 'cannot add yourself';
    else
        insert into friends(user_id, friend_id, status)
        values (p_user_id, p_friend_id, 'pending');
    end if;
end$$

create procedure sp_suggest_friends(
    in p_user_id int,
    inout p_limit int
)
begin
    declare counter int default 0;

    while counter < p_limit do
        select user_id, username
        from users
        where user_id != p_user_id
        limit p_limit;

        set counter = counter + 1;
    end while;
end$$

create procedure sp_add_comment(
    in p_user_id int,
    in p_post_id int,
    in p_content text
)
begin
    if not exists (select 1 from users where user_id = p_user_id) then
        signal sqlstate '45000'
        set message_text = 'user not exists';
    elseif not exists (select 1 from posts where post_id = p_post_id) then
        signal sqlstate '45000'
        set message_text = 'post not exists';
    else
        insert into comments(user_id, post_id, content)
        values (p_user_id, p_post_id, p_content);
    end if;
end$$

create procedure sp_like_post(
    in p_user_id int,
    in p_post_id int
)
begin
    if exists (
        select 1 from likes
        where user_id = p_user_id
        and post_id = p_post_id
    ) then
        signal sqlstate '45000'
        set message_text = 'already liked';
    else
        insert into likes(user_id, post_id)
        values (p_user_id, p_post_id);
    end if;
end$$

create procedure sp_search_social(
    in p_option int,
    in p_keyword varchar(100)
)
begin
    if p_option = 1 then
        select * from users
        where username like concat('%', p_keyword, '%');
    elseif p_option = 2 then
        select * from posts
        where content like concat('%', p_keyword, '%');
    else
        signal sqlstate '45000'
        set message_text = 'invalid option';
    end if;
end$$

delimiter ;


insert into users(username, password, email)
values
('an', '123', 'an@gmail.com'),
('binh', '123', 'binh@gmail.com'),
('cuong', '123', 'cuong@gmail.com');

call sp_create_post(1, 'hello database');
call sp_create_post(2, 'learning sql');

call sp_add_comment(1, 1, 'good post');
call sp_like_post(2, 1);

call sp_search_social(1, 'an');
call sp_search_social(2, 'sql');
