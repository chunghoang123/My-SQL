
use bai6;

create table student(
	IdStudent int primary key,
    FullName varchar(20) not null
);

create table subjects(
	IdSubject int primary key, 
    FullSubject varchar(50) not null
);

create table Score(
	IdStudent int not null,
    IdSubject int not null,
    
    
    processScore float not null,
    finalScore float not null,
    
    primary key (Idstudent,Idsubject),
    constraint CK_ProcessScore check(processScore between 0 and 10),
    constraint CK_FinalScore check(finalScore between 0 and 10),
    
    foreign key(IdStudent) references student(IdStudent),
    foreign key(IdSubject) references subjects(IdSubject)
);