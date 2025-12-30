create database bai1
use bai1;;


create table Student(
	student_id int primary key,
    full_name varchar(20) not null,
    date_of_birth date,
    email varchar(50) unique
);

insert into Student(student_id,full_name,date_of_birth,email)
values('01', 'Nguyen Van A', '2003-05-12', 'a.nguyen@gmail.com');


insert into Student(student_id,full_name,date_of_birth,email)
values('S02', 'Nguyen Van B', '2005-05-12', 'b.nguyen@gmail.com');


insert into Student(student_id,full_name,date_of_birth,email)
values('SV03', 'Nguyen Van C', '2005-08-12', 'c.nguyen@gmail.com');

select * from Student;
select student_id,full_name 
from Student;


