create database st3;
use st3;

create table users (
    user_id int primary key auto_increment,
    username varchar(50) unique not null,
    email varchar(100) unique not null,
    created_at date,
    follower_count int default 0,
    post_count int default 0
);

create table posts (
    post_id int primary key auto_increment,
    user_id int,
    content text,
    created_at datetime,
    like_count int default 0,
    constraint fk_user_post
        foreign key (user_id) references users(user_id)
        on delete cascade
);

create table likes (
    like_id int primary key auto_increment,
    user_id int,
    post_id int,
    liked_at datetime default current_timestamp,
    constraint fk_like_user foreign key (user_id) references users(user_id) on delete cascade,
    constraint fk_like_post foreign key (post_id) references posts(post_id) on delete cascade
);

insert into users (username, email, created_at) values
('alice', 'alice@example.com', '2025-01-01'),
('bob', 'bob@example.com', '2025-01-02'),
('charlie', 'charlie@example.com', '2025-01-03');

insert into posts (user_id, content, created_at) values
(1, 'post 1 by alice', '2025-01-10 10:00:00'),
(2, 'post 1 by bob', '2025-01-11 09:00:00'),
(3, 'post 1 by charlie', '2025-01-12 15:00:00');

delimiter $$

create trigger trg_after_insert_post
after insert on posts
for each row
begin
    update users
    set post_count = post_count + 1
    where user_id = new.user_id;
end$$

delimiter ;

delimiter $$

create trigger trg_after_delete_post
after delete on posts
for each row
begin
    update users
    set post_count = post_count - 1
    where user_id = old.user_id;
end$$

delimiter ;

delimiter $$

create trigger trg_before_insert_like
before insert on likes
for each row
begin
    declare post_owner int;

    select user_id into post_owner
    from posts
    where post_id = new.post_id;

    if new.user_id = post_owner then
        signal sqlstate '45000'
        set message_text = 'khong duoc like bai viet cua chinh minh';
    end if;
end$$

delimiter ;

delimiter $$

create trigger trg_after_insert_like
after insert on likes
for each row
begin
    update posts
    set like_count = like_count + 1
    where post_id = new.post_id;
end$$

delimiter ;

delimiter $$

create trigger trg_after_delete_like
after delete on likes
for each row
begin
    update posts
    set like_count = like_count - 1
    where post_id = old.post_id;
end$$

delimiter ;

delimiter $$

create trigger trg_after_update_like
after update on likes
for each row
begin
    if old.post_id <> new.post_id then
        update posts
        set like_count = like_count - 1
        where post_id = old.post_id;

        update posts
        set like_count = like_count + 1
        where post_id = new.post_id;
    end if;
end$$

delimiter ;

create view user_statistics as
select
    u.user_id,
    u.username,
    u.post_count,
    ifnull(sum(p.like_count), 0) as total_likes
from users u
left join posts p on u.user_id = p.user_id
group by u.user_id, u.username, u.post_count;

insert into likes (user_id, post_id) values (2, 1);
insert into likes (user_id, post_id) values (3, 1);

select * from posts where post_id = 1;

update likes set post_id = 2 where like_id = 1;

select * from posts where post_id in (1, 2);

delete from likes where like_id = 1;

select * from posts where post_id in (1, 2);

select * from user_statistics;
