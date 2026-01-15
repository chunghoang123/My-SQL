use social_network;
create table  delete_log (
    log_id int auto_increment primary key,
    post_id int not null,
    deleted_by int not null,
    deleted_at datetime default current_timestamp
);
delimiter $$

create procedure sp_delete_post (
    in p_post_id int,
    in p_user_id int
)
proc_end: begin
    declare v_count int;

    -- handler nếu có lỗi sql
    declare exit handler for sqlexception
    begin
        rollback;
    end;

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

    -- xóa like
    delete from likes
    where post_id = p_post_id;

    -- xóa comment
    delete from comments
    where post_id = p_post_id;

    -- xóa bài viết
    delete from posts
    where post_id = p_post_id;

    -- cập nhật posts_count
    update users
    set posts_count = posts_count - 1
    where user_id = p_user_id
      and posts_count > 0;

    -- ghi log
    insert into delete_log (post_id, deleted_by)
    values (p_post_id, p_user_id);

    commit;
end$$

delimiter ;


delimiter ;
call sp_delete_post(1, 1);
call sp_delete_post(1, 2);
call sp_delete_post(999, 1);
select * from posts;
select * from likes;
select * from comments;
select user_id, posts_count from users;
select * from delete_log;
