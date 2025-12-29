USE bai4;

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(20) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(50) UNIQUE
);

CREATE TABLE Subject (
    IdSubject INT PRIMARY KEY,
    SubjectName VARCHAR(50) NOT NULL,
    Credit INT NOT NULL,
    CONSTRAINT CHK_credit CHECK (Credit > 0)
);

CREATE TABLE Enrollment (
    student_id INT,
    IdSubject INT,
    EnrollDate DATE,

    PRIMARY KEY (student_id, IdSubject),

    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (IdSubject) REFERENCES Subject(IdSubject)
);
INSERT INTO Student VALUES
(1, 'Nguyen Van A', '2003-05-12', 'a@gmail.com'),
(2, 'Nguyen Van B', '2004-06-10', 'b@gmail.com');

INSERT INTO Subject VALUES
(101, 'Co so du lieu', 3),
(102, 'Lap trinh Java', 4);

INSERT INTO Enrollment VALUES (1, 101, '2024-09-01');
INSERT INTO Enrollment VALUES (1, 102, '2024-09-01');
INSERT INTO Enrollment VALUES (2, 101, '2024-09-02');
SELECT s.student_id,
       s.full_name,
       sb.SubjectName,
       e.EnrollDate
FROM Enrollment e
JOIN Student s ON e.student_id = s.student_id
JOIN Subject sb ON e.IdSubject = sb.IdSubject;
SELECT s.full_name,
       sb.SubjectName,
       e.EnrollDate
FROM Enrollment e
JOIN Student s ON e.student_id = s.student_id
JOIN Subject sb ON e.IdSubject = sb.IdSubject
WHERE e.student_id = 1;

