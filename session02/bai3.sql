CREATE DATABASE quan_ly_sinh_vien;
use quan_ly_sinh_vien;
create table Student (
MaSV varchar(10) primary key,
HoTen varchar(100) not null 
)engine = InnoDB;
CREATE TABLE Subject (
    MaMH VARCHAR(10) PRIMARY KEY,     
    TenMH VARCHAR(100) NOT NULL,        
    SoTinChi INT NOT NULL CHECK (SoTinChi > 0)  
) ENGINE=InnoDB;
INSERT INTO Student VALUES
('SV01', 'Nguyễn Văn A'),
('SV02', 'Trần Thị B');

INSERT INTO Subject VALUES
('MH01', 'Cơ sở dữ liệu', 3),
('MH02', 'Lập trình Java', 4);