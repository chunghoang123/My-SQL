use social_network_pro;

delimiter $$

create procedure notifyfriendsonnewpost(
    in p_user_id int,
    in p_content text
)
begin
    declare v_post_id int;
    declare v_full_name varchar(255);

    -- lấy full_name của người đăng
    select full_name
    into v_full_name
    from users
    where user_id = p_user_id;


    insert into posts (user_id, content, created_at)
    values (p_user_id, p_content, now());

    set v_post_id = last_insert_id();


    insert into notifications (user_id, type, content, created_at)
    select f.friend_id,
           'new_post',
           concat(v_full_name, ' da dang mot bai viet moi'),
           now()
    from friends f
    where f.user_id = p_user_id
      and f.status = 'accepted'
      and f.friend_id <> p_user_id;

    insert into notifications (user_id, type, content, created_at)
    select f.user_id,
           'new_post',
           concat(v_full_name, ' da dang mot bai viet moi'),
           now()
    from friends f
    where f.friend_id = p_user_id
      and f.status = 'accepted'
      and f.user_id <> p_user_id;

end $$

delimiter ;
call notifyfriendsonnewpost(3, 'day la bai viet moi cua toi');
select *
from notifications
where type = 'new_post'
order by created_at desc;
drop procedure if exists notifyfriendsonnewpost;
