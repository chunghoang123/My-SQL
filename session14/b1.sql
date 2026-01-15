create database social_network;
use social_network;

-- tạo bảng users
create table users
(
    user_id     int auto_increment primary key,
    username    varchar(50) not null,
    posts_count int default 0
);


-- tạo bảng posts
create table posts
(
    post_id    int auto_increment primary key,
    user_id    int  not null,
    content    text not null,
    created_at datetime default current_timestamp,
    foreign key (user_id) references users (user_id)
);

-- thêm dữ liệu mẫu vào bảng users
insert into users (username)
values ('alice'), -- user_id = 1
       ('bob');-- user_id = 2

-- TH1: transaction thành công (commit)

-- bắt đầu transaction
start transaction;

-- thêm bài viết cho user alice (user_id = 1)
insert into posts (user_id, content)
values (1, 'bài viết đầu tiên của alice');

-- cập nhật số lượng bài viết của alice
update users
set posts_count = posts_count + 1
where user_id = 1;

-- xác nhận transaction (lưu vĩnh viễn thay đổi)
commit;

-- kiểm tra bảng posts sau khi commit
select *
from posts;

-- kiểm tra thông tin user alice
select *
from users
where user_id = 1;

-- TH2: transaction lỗi → rollback

-- bắt đầu transaction mới
start transaction;

-- cố tình thêm bài viết cho user không tồn tại (user_id = 999)
-- lỗi foreign key sẽ xảy ra
insert into posts (user_id, content)
values (999, 'bài viết lỗi test rollback');

-- câu lệnh này cũng không có tác dụng vì user_id = 999 không tồn tại
update users
set posts_count = posts_count + 1
where user_id = 999;

-- hủy toàn bộ transaction do có lỗi
rollback;

-- kiểm tra: không có bài viết nào được thêm cho user_id = 999
select *
from posts
where user_id = 999;

-- kiểm tra: không có user nào có user_id = 999
select *
from users
where user_id = 999;
