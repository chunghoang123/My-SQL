
create database user_validation_v2;
use user_validation_v2;

create table users (
    user_id int primary key auto_increment,
    username varchar(50) unique,
    email varchar(100) unique,
    created_at date
);

delimiter $$

create trigger trg_before_insert_users
before insert on users
for each row
begin
    if new.email not like '%@%.%' then
        signal sqlstate '45000'
        set message_text = 'email khong hop le';
    end if;

    if not (new.username regexp '^[a-zA-Z0-9_]+$') then
        signal sqlstate '45000'
        set message_text = 'username chua ky tu khong hop le';
    end if;
end$$

delimiter ;

delimiter $$

create procedure add_user(
    in p_username varchar(50),
    in p_email varchar(100),
    in p_created_at date
)
begin
    insert into users(username, email, created_at)
    values (p_username, p_email, p_created_at);
end$$

delimiter ;
call add_user('alice_01', 'alice@gmail.com', '2025-01-01');
call add_user('bob123', 'bob@yahoo.com', '2025-01-02');

select * from users;
