create database Dang_ky1;
use Dang_ky1;

CREATE TABLE Enrollment (
    MaSV VARCHAR(10) NOT NULL,
    MaMH VARCHAR(10) NOT NULL,
    NgayDangKy DATE NOT NULL,

    PRIMARY KEY (MaSV, MaMH),

    CONSTRAINT FK_Enrollment_Student
        FOREIGN KEY (MaSV)
        REFERENCES Student(MaSV)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT FK_Enrollment_Subject
        FOREIGN KEY (MaMH)
        REFERENCES Subject(MaMH)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;
INSERT INTO Enrollment VALUES
('SV01', 'MH01', '2025-01-10'),
('SV01', 'MH02', '2025-01-11'),
('SV02', 'MH01', '2025-01-12');
