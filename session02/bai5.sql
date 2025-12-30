create database bai5;
USE bai5;
create table Teacher(
	IdTeacher int primary key,
    FullName varchar(20) not null,
    Email varchar(50) not null unique
);
create table subjects(
	IdSubject int primary key, 
    FullSubject varchar(50) not null,
    Credit int not null,
    
    
    IdTeacher int not null, 
    foreign key (IdTeacher) references Teacher(IdTeacher)
);