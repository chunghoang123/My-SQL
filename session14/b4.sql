use social_network;

-- tạo bảng comments: lưu bình luận cho bài viết
create table comments (
    comment_id int auto_increment primary key,
    post_id int not null,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id)
);

-- thêm cột đếm số bình luận cho bảng posts
alter table posts
add column comments_count int default 0;

delimiter $$

-- procedure thêm bình luận, sử dụng savepoint
create procedure sp_post_comment (
    in p_post_id int,
    in p_user_id int,
    in p_content text
)
begin
    -- handler xử lý lỗi sql
    declare exit handler for sqlexception
    begin
        rollback to after_insert;
        commit;
    end;

    -- bắt đầu transaction
    start transaction;

    -- thêm bình luận
    insert into comments (post_id, user_id, content)
    values (p_post_id, p_user_id, p_content);

    -- savepoint sau khi insert thành công
    savepoint after_insert;

    -- cập nhật số lượng bình luận
    update posts
    set comments_count = comments_count + 1
    where post_id = p_post_id;

    -- commit transaction
    commit;
end$$

delimiter ;

-- test thêm bình luận thành công
call sp_post_comment(1, 1, 'bình luận đầu tiên');

-- tạo lỗi để test rollback về savepoint
alter table posts rename column comments_count to comments_count_bak;

call sp_post_comment(1, 1, 'test savepoint rollback');

-- khôi phục lại tên cột
alter table posts rename column comments_count_bak to comments_count;

-- kiểm tra bảng comments
select * from comments;

-- kiểm tra số lượng bình luận của bài viết
select post_id, comments_count
from posts
where post_id = 1;
