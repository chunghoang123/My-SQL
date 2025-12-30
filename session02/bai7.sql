CREATE DATABASE IF NOT EXISTS bai7;
USE bai7;

-- 1. Bảng Student
CREATE TABLE Student (
    MaSV VARCHAR(10) PRIMARY KEY,
    HoTen VARCHAR(100) NOT NULL
);

-- 2. Bảng Subject
CREATE TABLE Subject (
    MaMH VARCHAR(10) PRIMARY KEY,
    TenMH VARCHAR(100) NOT NULL
);

-- 3. Bảng Score
CREATE TABLE Score (
    MaSV VARCHAR(10) NOT NULL,
    MaMH VARCHAR(10) NOT NULL,
    DiemQuaTrinh DECIMAL(4,2) NOT NULL,	
    DiemCuoiKy DECIMAL(4,2) NOT NULL,

    PRIMARY KEY (MaSV, MaMH),

    CONSTRAINT CK_DiemQuaTrinh
        CHECK (DiemQuaTrinh BETWEEN 0 AND 10),

    CONSTRAINT CK_DiemCuoiKy
        CHECK (DiemCuoiKy BETWEEN 0 AND 10),

    CONSTRAINT FK_Score_Student
        FOREIGN KEY (MaSV)
        REFERENCES Student(MaSV)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT FK_Score_Subject
        FOREIGN KEY (MaMH)
        REFERENCES Subject(MaMH)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);
