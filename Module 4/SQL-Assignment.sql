
CREATE DATABASE IF NOT EXISTS student_db;
USE student_db;


DROP TABLE IF EXISTS ContactEmployee;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Contact;
DROP TABLE IF EXISTS Company;


CREATE TABLE Company (
    CompanyID INT PRIMARY KEY,
    Name VARCHAR(50),
    Industry VARCHAR(45),
    City VARCHAR(45),
    State VARCHAR(2),
    Phone VARCHAR(12)
);
SELECT * FROM Company;


CREATE TABLE Contact (
    ContactID INT PRIMARY KEY,
    CompanyID INT,
    FirstName VARCHAR(45),
    LastName VARCHAR(45),
    Street VARCHAR(45),
    City VARCHAR(45),
    State VARCHAR(2),
    Zip VARCHAR(10),
    Phone VARCHAR(12),
    FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID)
);
SELECT * FROM Contact;


CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(45),
    LastName VARCHAR(45),
    Salary DECIMAL(10, 2),
    HireDate DATE,
    JobTitle VARCHAR(25),
    Email VARCHAR(45),
    Phone VARCHAR(12)
);
SELECT * FROM Employee;


CREATE TABLE ContactEmployee (
    ContactEmployeeID INT PRIMARY KEY,
    EmployeeID INT,
    ContactID INT,
    ContactDate DATE,
    Description VARCHAR(500),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (ContactID) REFERENCES Contact(ContactID)
);
SELECT * FROM ContactEmployee;


# Company data
INSERT INTO Company VALUES
(1, 'Urban Outfitters, Inc.', 'Retail', 'Philadelphia', 'PA', '2155559000'),
(2, 'Toll Brothers', 'Construction', 'Horsham', 'PA', '6105554000');
SELECT * FROM Company;

# Contact data
INSERT INTO Contact VALUES
(1, 1, 'Dianne', 'Connor', '123 Pine St', 'Philadelphia', 'PA', '19103', '2155553000'),
(2, 2, 'Robert', 'Stone', '45 Main St', 'Horsham', 'PA', '19044', '6105554000');
SELECT * FROM Contact;

# Employee data
INSERT INTO Employee VALUES
(1, 'Lesley', 'Bland', 55000.00, '2015-05-10', 'Sales Rep', 'lesley@marketco.com', '2155557777'),
(2, 'Jack', 'Lee', 62000.00, '2014-03-12', 'Account Manager', 'jack@marketco.com', '2155558888');
SELECT * FROM Employee;

# ContactEmployee data
INSERT INTO ContactEmployee VALUES
(1, 1, 1, '2024-09-05', 'Initial meeting with Dianne Connor'),
(2, 2, 2, '2024-10-01', 'Follow-up with Robert Stone');
SELECT * FROM ContactEmployee;

UPDATE Employee
SET Phone = '215-555-8800'
WHERE FirstName = 'Lesley' AND LastName = 'Bland';
SELECT * FROM Employee;

UPDATE Company
SET Name = 'Urban Outfitters'
WHERE Name = 'Urban Outfitters, Inc.';
SELECT * FROM Company;


DELETE FROM ContactEmployee
WHERE ContactID = (
    SELECT ContactID FROM Contact WHERE FirstName='Dianne' AND LastName='Connor'
)
AND EmployeeID = (
    SELECT EmployeeID FROM Employee WHERE FirstName='Jack' AND LastName='Lee'
);
SELECT * FROM ContactEmployee;


SELECT e.FirstName, e.LastName
FROM Employee e
JOIN ContactEmployee ce ON e.EmployeeID = ce.EmployeeID
JOIN Contact c ON ce.ContactID = c.ContactID
JOIN Company co ON c.CompanyID = co.CompanyID
WHERE co.Name = 'Toll Brothers';

#Question-8
% (percent sign): means any number of characters
Example: WHERE Name LIKE 'J%' → finds names like Jack, John, James.

_ (underscore): means one character only
Example: WHERE Name LIKE '_ack' → finds Jack, Mack, etc.

#Question-9
Normalization means organizing data in a database so that there is no repetition and data is stored properly.

Main points:
Store each piece of data only once.
Make sure every table has a clear purpose.
Helps in saving space and keeping data accurate.

Main types:
1NF: No repeating columns, each cell has one value.
2NF: Every column depends on the full primary key.
3NF: No column depends on another non-key column.

#Question-10
A JOIN is used to combine data from two or more tables using a common column (like an ID).
Example:
Show employee names and the company they contacted — we use a JOIN between the Employee and Company tables.

#Question-11
DDL
Data Definition Language
Used to create or change tables
CREATE, ALTER, DROP

DML
Data Manipulation Language
Used to add, change, or remove data
INSERT, UPDATE, DELETE, SELECT

DCL
Data Control Language
Used to control access to data
GRANT, REVOKE

#Question-12
JOIN helps to get related data from multiple tables together.

Types of JOIN:
INNER JOIN: Shows only matching rows from both tables.
LEFT JOIN: Shows all from the left table, and matches from the right table.
RIGHT JOIN: Shows all from the right table, and matches from the left table.
FULL JOIN: Shows everything from both tables (use UNION in MySQL).
CROSS JOIN: Combines every row from one table with every row from another.

