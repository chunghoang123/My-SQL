create database bai4;

use bai4;

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

create  table enrollment(
	IdStudents int not null,
    IdSubjects  int not null,
    RegistrationDate date not null,
    
    primary key (IdStudents, IdSubjects),
		constraint FK_Enrollment_student 
        foreign key (IdStudents) references student(IdStudent),
        
        constraint FK_Enrollment_IdSubject
			foreign key(IdSubjects) references subjects(IdSubject)
        
);