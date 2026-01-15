use social_network;

-- bảng delete_log: lưu lịch sử xóa bài viết
create table delete_log (
    log_id int auto_increment primary key,
    post_id int not null,
    deleted_by int not null,
    deleted_at datetime default current_timestamp
);

delimiter $$

-- procedure xóa bài viết (kèm like, comment, log)
create procedure sp_delete_post (
    in p_post_id int,
    in p_user_id int
)
proc_end: begin
    declare v_count int;

    -- handler xử lý lỗi sql
    declare exit handler for sqlexception
    begin
        rollback;
    end;

    -- bắt đầu transaction
    start transaction;

    -- kiểm tra bài viết tồn tại và thuộc về user
    select count(*) into v_count
    from posts
    where post_id = p_post_id
      and user_id = p_user_id;

    if v_count = 0 then
        rollback;
        leave proc_end;
    end if;

    -- xóa toàn bộ like của bài viết
    delete from likes
    where post_id = p_post_id;

    -- xóa toàn bộ comment của bài viết
    delete from comments
    where post_id = p_post_id;

    -- xóa bài viết
    delete from posts
    where post_id = p_post_id;

    -- cập nhật lại số lượng bài viết của user
    update users
    set posts_count = posts_count - 1
    where user_id = p_user_id
      and posts_count > 0;

    -- ghi log thao tác xóa
    insert into delete_log (post_id, deleted_by)
    values (p_post_id, p_user_id);

    -- commit transaction
    commit;
end$$

delimiter ;

-- test xóa bài viết hợp lệ
call sp_delete_post(1, 1);

-- test xóa bài viết không thuộc quyền user
call sp_delete_post(1, 2);

-- test xóa bài viết không tồn tại
call sp_delete_post(999, 1);

-- kiểm tra dữ liệu sau khi xóa
select * from posts;
select * from likes;
select * from comments;
select user_id, posts_count from users;
select * from delete_log;
