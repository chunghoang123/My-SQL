
use btth;


drop table Reader;
drop table Borrow;
create table Reader(
	reader_id int  auto_increment primary key,
    reader_name varchar(100) not null,
    phone varchar(15) unique,
    register_date date default(current_date)
);
create table Book(
	book_id int auto_increment primary key,
    book_title varchar(150) not null,
    author varchar(100) not null,
    publish_year int check (publish_year >= 1900)
);

create table Borrow(
	reader_id int, 
    book_id int ,
    borrow_date date default(current_date),
	return_date date,
    
    foreign key(reader_id) references reader(reader_id),
    foreign key(book_id) references book(book_id),
    
    check (return_date is null or return_date >= borrow_date)
);

alter table Reader add email varchar(100) unique;

alter table Book modify author varchar(150) not null;


insert into Reader (reader_id, reader_name, phone, email, register_date)
values
(1,'Nguyễn Văn An','0901234567','an.nguyen@gmail.com','2024-09-01'),
(2,'Trần Thị Bình','0912345678','binh.tran@gmail.com','2024-09-05'),
(3,'Lê Minh Châu','09012345613','chau.le@gmail.com','2023-09-01');


insert into Book(book_id,book_title,author,publish_year)
value
(101,'Lập trình C căn bản','Nguyễn Văn A','2018'),
(102,'Cơ sở dữ liệu','Nguyễn Văn B','2015'),
(103,'Lập trình Java ','Nguyễn Văn C','2011'),	
(104,'Hệ quản trị MySQL','Nguyễn Văn D','2019');

insert into Borrow(reader_id,book_id,borrow_date,return_date)
value
(1,'101','2024-09-15',''),
(1,'102','2024-09-15','2024-09-25'),
(2,'103','2024-09-18','');



select *from Reader;
select *from Book;
select *from Borrow;



