use social_network_pro;

delimiter $$

create procedure createpostwithvalidation (
    in p_user_id int,
    in p_content text,
    out result_message varchar(255)
)
begin
    if char_length(p_content) < 5 then
        set result_message = 'noi dung qua ngan';
    else
        insert into posts (user_id, content, created_at)
        values (p_user_id, p_content, now());

        set result_message = 'them bai viet thanh cong';
    end if;
end $$

delimiter ;
call createpostwithvalidation(1, 'hi', @msg);
select @msg as result_message;
call createpostwithvalidation(1, 'day la mot bai viet hop le', @msg);
select @msg as result_message;
select *
from posts
order by created_at desc;
drop procedure if exists createpostwithvalidation;
