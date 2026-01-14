drop database if exists social_full;
create database social_full;
use social_full;

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
    foreign key (user_id) references users(user_id) on delete cascade
);

create table likes (
    like_id int primary key auto_increment,
    user_id int,
    post_id int,
    liked_at datetime default now(),
    foreign key (user_id) references users(user_id) on delete cascade,
    foreign key (post_id) references posts(post_id) on delete cascade
);

create table friendships (
    follower_id int,
    followee_id int,
    status enum('pending','accepted') default 'accepted',
    primary key (follower_id, followee_id),
    foreign key (follower_id) references users(user_id) on delete cascade,
    foreign key (followee_id) references users(user_id) on delete cascade
);
delimiter $$

create trigger trg_friendships_insert
after insert on friendships
for each row
begin
    if new.status = 'accepted' then
        update users
        set follower_count = follower_count + 1
        where user_id = new.followee_id;
    end if;
end$$

create trigger trg_friendships_delete
after delete on friendships
for each row
begin
    if old.status = 'accepted' then
        update users
        set follower_count = follower_count - 1
        where user_id = old.followee_id;
    end if;
end$$

create trigger trg_friendships_update
after update on friendships
for each row
begin
    if old.status = 'pending' and new.status = 'accepted' then
        update users
        set follower_count = follower_count + 1
        where user_id = new.followee_id;
    end if;

    if old.status = 'accepted' and new.status = 'pending' then
        update users
        set follower_count = follower_count - 1
        where user_id = new.followee_id;
    end if;
end$$

delimiter ;
delimiter $$

create trigger trg_likes_insert
after insert on likes
for each row
begin
    update posts
    set like_count = like_count + 1
    where post_id = new.post_id;
end$$

create trigger trg_likes_delete
after delete on likes
for each row
begin
    update posts
    set like_count = like_count - 1
    where post_id = old.post_id;
end$$

create trigger trg_likes_update
after update on likes
for each row
begin
    if old.post_id <> new.post_id then
        update posts set like_count = like_count - 1 where post_id = old.post_id;
        update posts set like_count = like_count + 1 where post_id = new.post_id;
    end if;
end$$

delimiter ;
delimiter $$

create procedure follow_user(
    in p_follower_id int,
    in p_followee_id int,
    in p_status enum('pending','accepted')
)
begin
    if p_follower_id = p_followee_id then
        signal sqlstate '45000'
        set message_text = 'khong duoc tu follow chinh minh';
    end if;

    if exists (
        select 1 from friendships
        where follower_id = p_follower_id
        and followee_id = p_followee_id
    ) then
        signal sqlstate '45000'
        set message_text = 'da follow truoc do';
    end if;

    insert into friendships(follower_id, followee_id, status)
    values (p_follower_id, p_followee_id, p_status);
end$$

delimiter ;
delimiter $$

create procedure accept_follow(
    in p_follower_id int,
    in p_followee_id int
)
begin
    update friendships
    set status = 'accepted'
    where follower_id = p_follower_id
    and followee_id = p_followee_id
    and status = 'pending';
end$$

delimiter ;
delimiter $$

create procedure unfollow_user(
    in p_follower_id int,
    in p_followee_id int
)
begin
    delete from friendships
    where follower_id = p_follower_id
    and followee_id = p_followee_id;
end$$

delimiter ;
create view user_profile as
select
    u.user_id,
    u.username,
    u.follower_count,
    u.post_count,
    ifnull(sum(p.like_count), 0) as total_likes,
    group_concat(p.content order by p.created_at desc separator ' | ') as recent_posts
from users u
left join posts p on u.user_id = p.user_id
group by u.user_id, u.username, u.follower_count, u.post_count;
insert into users (username, email, created_at) values
('alice', 'alice@gmail.com', '2025-01-01'),
('bob', 'bob@gmail.com', '2025-01-02'),
('charlie', 'charlie@gmail.com', '2025-01-03');

insert into posts (user_id, content, created_at) values
(1, 'alice post 1', now()),
(1, 'alice post 2', now()),
(2, 'bob post 1', now());

update users set post_count = 2 where user_id = 1;
update users set post_count = 1 where user_id = 2;
call follow_user(2, 1, 'accepted');
call follow_user(3, 1, 'pending');
call follow_user(1, 2, 'accepted');
call accept_follow(3, 1);
insert into likes(user_id, post_id) values (2,1);
insert into likes(user_id, post_id) values (3,1);
insert into likes(user_id, post_id) values (1,3);
call unfollow_user(2, 1);
call unfollow_user(1, 1);
select * from users;
select * from posts;
select * from friendships;
select * from user_profile;
