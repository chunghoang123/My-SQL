create database bai5;
use bai5;
CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(50) UNIQUE
);
CREATE TABLE Subject (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(50) NOT NULL,
    credit INT NOT NULL,
    CONSTRAINT chk_credit CHECK (credit > 0)
);
CREATE TABLE Subject (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(50) NOT NULL,
    credit INT NOT NULL,
    CONSTRAINT chk_credit CHECK (credit > 0)
);
CREATE TABLE Score (
    student_id INT,
    subject_id INT,
    mid_score FLOAT NOT NULL,
    final_score FLOAT NOT NULL,

    PRIMARY KEY (student_id, subject_id),

    CONSTRAINT chk_mid CHECK (mid_score BETWEEN 0 AND 10),
    CONSTRAINT chk_final CHECK (final_score BETWEEN 0 AND 10),

    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
);
INSERT INTO Student VALUES
(1, 'Nguyen Van A', '2003-05-12', 'a@gmail.com'),
(2, 'Nguyen Van B', '2004-06-10', 'b@gmail.com'),
(3, 'Nguyen Van C', '2005-08-15', 'c@gmail.com');
INSERT INTO Subject VALUES
(101, 'Co so du lieu', 3),
(102, 'Lap trinh Java', 4),
(103, 'Mang may tinh', 3);
INSERT INTO Enrollment VALUES
(1, 101, '2024-09-01'),
(1, 102, '2024-09-01'),
(2, 101, '2024-09-02'),
(3, 103, '2024-09-03');
INSERT INTO Score VALUES
(1, 101, 7.5, 8.0),
(2, 101, 6.5, 8.5),
(1, 102, 8.0, 9.0);
UPDATE Score
SET final_score = 9.5
WHERE student_id = 1
  AND subject_id = 101;
SELECT s.student_id,
       s.full_name,
       sb.subject_name,
       sc.mid_score,
       sc.final_score
FROM Score sc
JOIN Student s ON sc.student_id = s.student_id
JOIN Subject sb ON sc.subject_id = sb.subject_id;
SELECT s.student_id,
       s.full_name,
       sb.subject_name,
       sc.final_score
FROM Score sc
JOIN Student s ON sc.student_id = s.student_id
JOIN Subject sb ON sc.subject_id = sb.subject_id
WHERE sc.final_score >= 8;
SELECT s.full_name,
       sb.subject_name,
       e.enroll_date
FROM Enrollment e
JOIN Student s ON e.student_id = s.student_id
JOIN Subject sb ON e.subject_id = sb.subject_id;
