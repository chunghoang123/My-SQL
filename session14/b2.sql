
use social_network;
-- tạo bảng likes (lưu thông tin người dùng like bài viết)
create table likes (
    like_id int auto_increment primary key,
    post_id int not null,
    user_id int not null,
    constraint fk_likes_post
        foreign key (post_id) references posts(post_id),
    constraint fk_likes_user
        foreign key (user_id) references users(user_id),
    unique key unique_like (post_id, user_id)
);

-- thêm cột likes_count vào bảng posts
-- dùng để lưu tổng số lượt like của bài viết
alter table posts
add column likes_count int default 0;

-- TH1: like bài viết thành công (commit)

-- bắt đầu transaction
start transaction;

-- user_id = 1 thực hiện like bài viết post_id = 1
insert into likes (post_id, user_id)
values (1, 1);

-- tăng số lượt like của bài viết
update posts
set likes_count = likes_count + 1
where post_id = 1;

-- xác nhận transaction (lưu dữ liệu vĩnh viễn)
commit;

-- kiểm tra bảng likes
select * from likes;

-- kiểm tra số lượt like của bài viết
select post_id, likes_count
from posts
where post_id = 1;

-- TH2: like trùng → lỗi unique → rollback
-- bắt đầu transaction mới
start transaction;

-- user_id = 1 tiếp tục like lại post_id = 1
-- lỗi xảy ra do trùng unique (post_id, user_id)
insert into likes (post_id, user_id)
values (1, 1);

-- câu lệnh này sẽ không có tác dụng vì transaction bị lỗi
update posts
set likes_count = likes_count + 1
where post_id = 1;

-- hủy toàn bộ transaction do vi phạm ràng buộc unique
rollback;

-- kiểm tra: không có bản ghi like trùng được thêm
select *
from likes
where post_id = 1 and user_id = 1;

-- kiểm tra: likes_count không bị tăng sai
select post_id, likes_count
from posts
where post_id = 1;
