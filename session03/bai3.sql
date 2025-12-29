
use bai3;

drop table Subject;

create table Subject(
	IdSubject int not null primary key,
    SubjectName varchar(50) not null,
    Credit int not null,
    
    
    constraint CHK_credit check(credit > 0 )
);
INSERT INTO Subject
VALUES (101, 'Co so du lieu', 3);

INSERT INTO Subject
VALUES (102, 'Lap trinh Java', 4);

INSERT INTO Subject
VALUES (103, 'Mang may tinh', 3);


update Subject set credit = '5' where IdSubject = 101;
update Subject set SubjectName ='lap trinh mang' where IdSubject = 102;

select * from Subject;