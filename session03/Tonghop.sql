create database bai10;
use bai10;
create table Student(
	IdStudent int primary key,
    FullName varchar(20) not null,
    DateOfBirth date,
    Email varchar(50) unique
);
create table Subject(
	IdSubject int primary key,
    NameSubject varchar(20) not null,
    Credit int not null
);

create table Enrollment(
	IdStudent int ,
    IdSubject int ,
    EnrollDate date,
    
    PRIMARY KEY (IdStudent, IdSubject),

    CONSTRAINT FK_Enroll_Student
        FOREIGN KEY (IdStudent) REFERENCES Student(IdStudent),

    CONSTRAINT FK_Enroll_Subject
        FOREIGN KEY (IdSubject) REFERENCES Subject(IdSubject)
    );
create table Score(
	IdStudent int ,
    IdSubject int ,
    DiemGK float not null,
    DiemCK float not null,
    DiemTB float not null,
    
     PRIMARY KEY (IdStudent, IdSubject),

    CONSTRAINT FK_Score_Student
        FOREIGN KEY (IdStudent) REFERENCES Student(IdStudent),

    CONSTRAINT FK_Score_Subject
        FOREIGN KEY (IdSubject) REFERENCES Subject(IdSubject)
);
INSERT INTO Student
VALUES (1, 'Nguyen Van A', '2003-05-10', 'a@gmail.com');
INSERT INTO Subject
VALUES (101, 'CSDL', 3);
INSERT INTO Enrollment
VALUES (1, 101, CURDATE());
INSERT INTO Score
VALUES (1, 101, 7.5, 8.5, (7.5 + 8.5) / 2);
UPDATE Score
SET DiemGK = 8,
    DiemCK = 9,
    DiemTB = (8 + 9) / 2
WHERE IdStudent = 1 
  AND IdSubject = 101;
DELETE FROM Score
WHERE IdStudent = 1
  AND IdSubject = 101;
DELETE FROM Enrollment
WHERE IdStudent = 1
  AND IdSubject = 101;
SELECT s.FullName, sb.NameSubject, e.EnrollDate
FROM Enrollment e
JOIN Student s ON e.IdStudent = s.IdStudent
JOIN Subject sb ON e.IdSubject = sb.IdSubject;
SELECT s.FullName, sb.NameSubject, sc.DiemGK, sc.DiemCK, sc.DiemTB
FROM Score sc
JOIN Student s ON sc.IdStudent = s.IdStudent
JOIN Subject sb ON sc.IdSubject = sb.IdSubject;
SELECT e.IdStudent, e.IdSubject
FROM Enrollment e
LEFT JOIN Score sc
ON e.IdStudent = sc.IdStudent
AND e.IdSubject = sc.IdSubject
WHERE sc.IdStudent IS NULL;
