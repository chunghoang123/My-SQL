create database bai3;

use bai3;

create table student(
	IdStudent int primary key,
    FullName varchar(20) not null
);

create table subjects(
	IdSubject int primary key, 
    FullSubject varchar(50) not null,
    Credit int not null
    
    constraint CK_Subject_Credit check ( credit > 0)
);