CREATE DATABASE bai2;
USE bai2;

CREATE TABLE Class (
    IdClass INT PRIMARY KEY,
    NameClass VARCHAR(20) NOT NULL,
    SchoolYear VARCHAR(20) NOT NULL
);

CREATE TABLE Student (
    IdStudent INT PRIMARY KEY,
    FullName VARCHAR(20) NOT NULL,
    DateOfBirth DATE NOT NULL,
    IdClass INT NOT NULL,

    CONSTRAINT FK_Student_Class
        FOREIGN KEY (IdClass)
        REFERENCES Class(IdClass)
);
