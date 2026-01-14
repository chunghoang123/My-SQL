create database ts4;
use ts4;

create table users (
    user_id int primary key auto_increment,
    username varchar(50),
    email varchar(100)
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
    liked_at datetime default current_timestamp,
    foreign key (user_id) references users(user_id) on delete cascade,
    foreign key (post_id) references posts(post_id) on delete cascade
);

create table post_history (
    history_id int primary key auto_increment,
    post_id int,
    old_content text,
    new_content text,
    changed_at datetime,
    changed_by_user_id int,
    foreign key (post_id) references posts(post_id) on delete cascade
);

insert into users (username, email) values
('alice', 'alice@gmail.com'),
('bob', 'bob@gmail.com'),
('charlie', 'charlie@gmail.com');

insert into posts (user_id, content, created_at) values
(1, 'post 1 by alice', now()),
(2, 'post 1 by bob', now()),
(3, 'post 1 by charlie', now());

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

create trigger trg_before_update_post_history
before update on posts
for each row
begin
    if old.content <> new.content then
        insert into post_history (
            post_id,
            old_content,
            new_content,
            changed_at,
            changed_by_user_id
        ) values (
            old.post_id,
            old.content,
            new.content,
            now(),
            old.user_id
        );
    end if;
end$$

delimiter ;

insert into likes (user_id, post_id) values (2, 1);
insert into likes (user_id, post_id) values (3, 1);

select * from posts;

update posts set content = 'updated content for post 1' where post_id = 1;
update posts set content = 'updated content for post 2' where post_id = 2;

select * from post_history;

select * from posts;
