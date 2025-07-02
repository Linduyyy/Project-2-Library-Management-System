-- Library Management System Project 2

-- create table branch
drop table if exists branch ;

CREATE TABLE branch 
(
	branch_id varchar(10) primary key,	
    manager_id	varchar(10),
    branch_address	varchar(30),
    contact_no varchar(15)
);

-- create table employees
drop table if exists employees ;

create table employees 
(
	emp_id	varchar(10) primary key,
    emp_name varchar(30),
    position varchar(30),
    salary	decimal(10,2),
    branch_id varchar(10)
);


-- create table members
DROP TABLES IF EXISTS members;
CREATE TABLE members 
(
	member_id VARCHAR(15) PRIMARY KEY,
    member_name VARCHAR(30),
    member_address VARCHAR(60),
    reg_date DATE
);

-- CREATE TABLE BOOKS
CREATE TABLE books 
(
	isbn VARCHAR(20) PRIMARY KEY,
    book_title VARCHAR(60),
    category VARCHAR(20),
    rental_price FLOAT,
	status VARCHAR(15),
    author VARCHAR (35),
    publisher VARCHAR(60)
);

-- create table issued_status
create table issued_status
(
	issued_id VARCHAR(10) PRIMARY KEY,
    issued_member_id VARCHAR(10),
    issued_book_name VARCHAR(75),
    issued_date DATE,
	issued_book_isbn VARCHAR(25),
    issued_emp_id VARCHAR(10)
);

-- create table return_status
CREATE TABLE return_status
(
	return_id VARCHAR(10) PRIMARY KEY,
    issued_id VARCHAR(10),
    return_book_name VARCHAR(75),
    return_date DATE,
    return_book_isbn VARCHAR(20)
);

-- FOREIGN key
ALTER TABLE issued_status
ADD CONSTRAINT fk_members
FOREIGN KEY (issued_member_id)
REFERENCES members(member_id); 

ALTER TABLE issued_status
ADD CONSTRAINT fk_books
FOREIGN KEY (issued_book_isbn)
REFERENCES books(isbn); 

ALTER TABLE issued_status
ADD CONSTRAINT fk_employees
FOREIGN KEY (issued_emp_id)
REFERENCES employees(emp_id); 

ALTER TABLE return_status
ADD CONSTRAINT fk_issued_status
FOREIGN KEY (issued_id)
REFERENCES issued_status(issued_id); 

ALTER TABLE employees
ADD CONSTRAINT fk_branch
FOREIGN KEY (branch_id)
REFERENCES branch(branch_id); 
