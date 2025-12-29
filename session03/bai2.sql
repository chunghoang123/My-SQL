
use bai2;


drop table Student;
create table Student(
	student_id int primary key,
    full_name varchar(20) not null,
    date_of_birth date,
    email varchar(50) unique
);

insert into Student(student_id,full_name,date_of_birth,email)
values('1', 'Nguyen Van A', '2003-05-12', 'a.nguyen@gmail.com');


insert into Student(student_id,full_name,date_of_birth,email)
values('2', 'Nguyen Van B', '2005-05-12', 'b.nguyen@gmail.com');


insert into Student(student_id,full_name,date_of_birth,email)
values('3', 'Nguyen Van C', '2005-08-12', 'c.nguyen@gmail.com');

update Student set email ='a.new@gmail.com'
where student_id = 1;
delete from Student
where Student_id = 2;

select * from Student;