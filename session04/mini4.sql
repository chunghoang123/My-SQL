create database if not exists btth_mini_4;
use btth_mini_4;


create table student (
    studentId int auto_increment primary key,
    fullName varchar(50) not null,
    dateOfBirth date not null,
    email varchar(50) not null unique
);


create table teacher (
    teacherId int auto_increment primary key,
    fullName varchar(50) not null,
    email varchar(50) not null unique
);

create table course (
    courseId int auto_increment primary key,
    courseName varchar(50) not null,
    description varchar(255),
    totalLessons int not null,
    credits int default 1,
    teacherId int not null,
    foreign key (teacherId) references teacher(teacherId)
);


create table enrollment (
    studentId int not null,
    courseId int not null,
    enrollDate date not null default (current_date),
    primary key (studentId, courseId),
    foreign key (studentId) references student(studentId),
    foreign key (courseId) references course(courseId)
);


create table score (
    studentId int not null,
    courseId int not null,
    progressScore decimal(4,2) not null default 0,
    finalScore decimal(4,2) not null default 0,
    primary key (studentId, courseId),
    foreign key (studentId) references student(studentId),
    foreign key (courseId) references course(courseId),
    check (progressScore between 0 and 10),
    check (finalScore between 0 and 10)
);

INSERT INTO student (fullName, dateOfBirth, email) VALUES
('Nguyen Van A', '2004-01-15', 'a@student.com'),
('Tran Thi B', '2004-03-20', 'b@student.com'),
('Le Van C', '2003-07-10', 'c@student.com'),
('Pham Thi D', '2004-11-05', 'd@student.com'),
('Hoang Van E', '2003-09-25', 'e@student.com');

INSERT INTO teacher (fullName, email) VALUES
('Dr. Nguyen Van X', 'x@teacher.com'),
('Dr. Tran Thi Y', 'y@teacher.com'),
('Dr. Le Van Z', 'z@teacher.com'),
('Dr. Pham Thi M', 'm@teacher.com'),
('Dr. Hoang Van N', 'n@teacher.com');

INSERT INTO course (courseName, description, totalLessons, credits, teacherId) VALUES
('Java Basic', 'Lap trinh Java co ban', 30, 3, 1),
('SQL Basic', 'Co so du lieu SQL', 25, 2, 2),
('Web HTML/CSS', 'Thiet ke web co ban', 20, 2, 3),
('JavaScript', 'Lap trinh JavaScript', 28, 3, 4),
('Data Structures', 'Cau truc du lieu', 35, 4, 5);


INSERT INTO enrollment (studentId, courseId) VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO score (studentId, courseId, progressScore, finalScore) VALUES
(1, 1, 7.5, 8.0),
(1, 2, 6.0, 7.0),
(2, 1, 8.0, 8.5),
(3, 3, 7.0, 7.5),
(4, 4, 6.5, 7.0),
(5, 5, 8.5, 9.0);

UPDATE student
SET email = 'new_a@student.com'
WHERE studentId = 1;

UPDATE course
SET description = 'Lap trinh Java tu co ban den nang cao'
WHERE courseId = 1;

UPDATE score
SET finalScore = 9.0
WHERE studentId = 1 AND courseId = 1;

DELETE FROM score
WHERE studentId = 1 AND courseId = 2;

DELETE FROM enrollment
WHERE studentId = 1 AND courseId = 2;

SELECT * FROM student;
SELECT * FROM teacher;
SELECT * FROM course;

SELECT s.fullName, c.courseName, e.enrollDate
FROM enrollment e
JOIN student s ON e.studentId = s.studentId
JOIN course c ON e.courseId = c.courseId;

SELECT s.fullName, c.courseName, sc.progressScore, sc.finalScore
FROM score sc
JOIN student s ON sc.studentId = s.studentId
JOIN course c ON sc.courseId = c.courseId;