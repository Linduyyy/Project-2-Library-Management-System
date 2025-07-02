# Library Managment System Using SQL Project

## Project Overview

**Project Title**: Library Management System

**Level**: Intermediate

**Database**: project_2_library_db

**Software**: MySQL

This project demonstrates the implementation of a Library Management System using SQL. It includes creating and managing tables, performing CRUD operations, and executing advanced SQL queries. The goal is to showcase skills in database design, manipulation, and querying.

![library-flat-color-illustration-vector](https://github.com/user-attachments/assets/d5a4a6bc-9fd6-4cf7-9ebf-5971d20534f5)

## Objectives
1. **Set up the Library Management System Database**: Create and populate the database with tables for branches, employees, members, books, issued status, and return status.
2. **CRUD Operation**: Perform Create, Read, Update, and Delete operations on the data.
3. **CTAS (Create Table As Select)**: Utilize CTAS to create new tables based on query results.
4. **Advanced SQL Queries**: Develop complex queries to analyze and retrieve spesific data.

## Project Structure

### 1. Database Setup
![Screenshot 2025-06-05 160233](https://github.com/user-attachments/assets/1d692c0b-0800-4fde-ae27-40d1ce0d04b4)

- **Database Creation**: Created a database named `project_2_library_db`
- **Table Creation**: Created tables for branches, employees, members, books, issued status, and return status. Each table includes relevant columns and relationships.

```SQL
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

-- create table books
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
```

### 2. CRUD Operations

- **Create**: Inserted sample records into the `books` table.
- **Read**: Retvieved and displayed data from various tables.
- **Update**: Updated records in the `employees` table.
- **Delete**: Removed records from the `member table as needed.

**Task 1: Create a New Book Record**-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

```SQL
INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
```

**Task 2: Update an Existing Member's Address**

```SQL
UPDATE members
SET member_address = '125 Oak St'
WHERE member_id = 'C103';
```

**Task 3: Delete a Record from the Issued Status Table** -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

```SQL
DELETE FROM issued_status
WHERE issued_id = 'IS121';
```

**Task 4: Retrieve All Books Issued by a Spesific Employee** --Objective: Select all books issued by the employee with emp_id = 'E101'.

```SQL
SELECT * FROM issued_status
WHERE issued_emp_id = 'E101';
```

**Task 5: List Members Who Have Issued More Than One Book**

```SQL
SELECT issued_emp_id, count(*)
FROM issued_status
GROUP BY 1
HAVING count(*) > 1
ORDER BY 2;
```

### 3. CTAS (Create Table As Select)

**Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt

```SQL
create table books_issued as
select b.isbn, b.book_title, count(ist.issued_id) as issue_count
from issued_status ist
join books b on b.isbn = ist.issued_book_isbn
group by 1,2;
```

### 4. Data Analysis & Findings
The following SQL queries were used to address spesific questions:

**Task 7: Retrieve All Books in a Spesific Category**:
```SQL
SELECT * FROM books
WHERE category = 'Fantasy';
```
**Task 8: Find Total Rental Income by Category**:
```SQL
SELECT category, sum(rental_price)
FROM books
GROUP BY 1
ORDER BY 2 DESC;
```

**Task 9: List Members Who Registered in the Last 1000 Days**:
```SQL
SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL 1000 DAY; 
```

**Task 10: List Employees with Their Branch Manager's Name and their branch details**
```SQL
select e1.*, b.manager_id, e2.emp_name as manager
from employees e1
join branch b on b.branch_id = e1.branch_id
join employees e2 on b.manager_id = e2.emp_id;
```

**Task 11: Create a Table of Books with Rental Price Above a Certain Threshold**
```SQL
create table books_expensive as
select * from books
where rental_price >= 7;
```

## Advanced SQL Operations
**Task 12: Identify Members with Overdue Books**  
Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's_id, member's name, book title, issue date, and days overdue.

**Task 13: Update Book Status on Return**  
Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).

**Task 14: Branch Performance Report**  
Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.

**Task 15: CTAS: Create a Table of Active Members**  
Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 2 months.

**Task 16: Find Employees with the Most Book Issues Processed**  
Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.

**Task 17: Identify Members Issuing High-Risk Books**  
Write a query to identify members who have issued books more than twice with the status "damaged" in the books table. Display the member name, book title, and the number of times they've issued damaged books.    


**Task 18: Stored Procedure**
Objective:
Create a stored procedure to manage the status of books in a library system.
Description:
Write a stored procedure that updates the status of a book in the library based on its issuance. The procedure should function as follows:
The stored procedure should take the book_id as an input parameter.
The procedure should first check if the book is available (status = 'yes').
If the book is available, it should be issued, and the status in the books table should be updated to 'no'.
If the book is not available (status = 'no'), the procedure should return an error message indicating that the book is currently not available.

**Task 20: Create Table As Select (CTAS)**
Objective: Create a CTAS (Create Table As Select) query to identify overdue books and calculate fines.

Description: Write a CTAS query to create a new table that lists each member and the books they have issued but not returned within 30 days. The table should include:
    The number of overdue books.
    The total fines, with each day's fine calculated at $0.50.
    The number of books issued by each member.
    The resulting table should show:
    Member ID
    Number of overdue books
    Total fines
