create database Bai1;
use Bai1;
create table students(
	student_id int auto_increment primary key,
    full_name varchar(50)
);

create table subject(
	subject_id int auto_increment primary key,
	subject_name varchar(50),
    credits int,
    student_id INT NOT NULL,
 FOREIGN KEY (student_id) REFERENCES student(student_id)
);

create table goals(
    goal_id INT AUTO_INCREMENT PRIMARY KEY,
    goal_description VARCHAR(100) NOT NULL,
     subject_id INT NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES subject(subject_id)
);