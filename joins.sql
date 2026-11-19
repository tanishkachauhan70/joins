Drop database if exists join_database;
CREATE DATABASE join_database;
USE join_database;

-- create two tables table1 and table2

CREATE TABLE table1 (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    city VARCHAR(50),
    phone_number VARCHAR(15)
);

CREATE TABLE table2 (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    city VARCHAR(50),
    salary DECIMAL(10, 2),
    address VARCHAR(100)
);


-- Insert Data into the Tables

-- Insert data into table1
INSERT INTO table1 (id, first_name, last_name, city, phone_number) VALUES
(1, 'Rahul', 'Sharma', 'Delhi', '9876543210'),
(2, 'Priya', 'Verma', 'Mumbai', '8765432109'),
(3, 'Amit', 'Patel', 'Ahmedabad', '7654321098'),
(4, 'Anjali', 'Singh', 'Kolkata', '6543210987'),
(5, 'Vijay', 'Kumar', 'Bangalore', '5432109876');

-- Insert data into table2
INSERT INTO table2 (id, first_name, last_name, city, salary, address) VALUES
(3, 'Amit', 'Patel', 'Ahmedabad', 75000.00, 'Street 21, Ahmedabad, Gujarat'),
(4, 'Anjali', 'Singh', 'Kolkata', 82000.00, 'Park Street, Kolkata, West Bengal'),
(5, 'Vijay', 'Kumar', 'Bangalore', 92000.00, 'MG Road, Bangalore, Karnataka'),
(6, 'Sanjay', 'Reddy', 'Hyderabad', 70000.00, 'Banjara Hills, Hyderabad, Telangana'),
(7, 'Megha', 'Iyer', 'Chennai', 88000.00, 'Anna Nagar, Chennai, Tamil Nadu');


CREATE TABLE employees_selfjoin (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100),
    manager_id INT
);

INSERT INTO employees_selfjoin (employee_id, name, manager_id) VALUES
(1, 'Alice', NULL),
(2, 'Bob', 1),
(3, 'Charlie', 1),
(4, 'David', 2),
(5, 'Eve', 2);

select 
t1.id,
t1.first_name,
t1.city,
t1.phone_number,
t2.salary
from table1 t1
inner join table2 t2
on t1.id = t2.id
where t2.salary > 75000
order by t2.salary desc;


select 
t1.id,
t1.first_name,
t1.city,
t2.salary,
t2.address
from table1 t1
left join table2 t2
on t1.id =t2.id
where t1.city in('edelhi','kolakata','bangalore')
order by t1.id asc;

select 
t2.id,
t2.first_name,
t2.salary,
t1.phone_number
from table1 as t1
right join table2 as t2
on t1.id = t2.id
where t2.salary >= 80000
order by t2.salary desc
limit 2;

select 
t2.id,
t2.first_name,
t2.salary,
t1.phone_number
from table1 t1
right join table2 t2
on t1.id = t2.id
where t2.salary >=80000
order by t2.salary desc
limit 2;

SELECT
    t1.id AS id,
    t1.first_name,
    t1.phone_number,
    t2.salary
FROM table1 AS t1
LEFT JOIN table2 AS t2
    ON t1.id = t2.id

UNION

SELECT
    t2.id AS id,
    t2.first_name,
    t1.phone_number,
    t2.salary
FROM table1 AS t1
RIGHT JOIN table2 AS t2
    ON t1.id = t2.id

ORDER BY id ASC;
 
 SELECT
    t1.id AS table1_id,
    t1.first_name AS table1_first_name,
    t2.id AS table2_id,
    t2.first_name AS table2_first_name
FROM table1 AS t1
CROSS JOIN table2 AS t2
ORDER BY
    t1.id ASC,
    t2.id ASC
LIMIT 10;

SELECT
    t1.*
FROM table1 AS t1
LEFT JOIN table2 AS t2
    ON t1.id = t2.id
WHERE t2.id IS NULL
ORDER BY t1.first_name ASC;

SELECT
    t2.*
FROM table1 AS t1
RIGHT JOIN table2 AS t2
    ON t1.id = t2.id
WHERE t1.id IS NULL
AND t2.salary > 75000
ORDER BY t2.salary DESC;

SELECT
    t1.id AS id,
    t1.first_name,
    'table1' AS source_table
FROM table1 AS t1
LEFT JOIN table2 AS t2
    ON t1.id = t2.id
WHERE t2.id IS NULL

UNION ALL

SELECT
    t2.id AS id,
    t2.first_name,
    'table2' AS source_table
FROM table1 AS t1
RIGHT JOIN table2 AS t2
    ON t1.id = t2.id
WHERE t1.id IS NULL

ORDER BY first_name ASC, id ASC
LIMIT 3;

SELECT
    t1.first_name,
    t1.last_name,
    t1.city,
    t1.phone_number,
    t2.salary
FROM table1 AS t1
INNER JOIN table2 AS t2
    ON t1.id = t2.id
WHERE t2.salary > 70000
ORDER BY
    t2.salary DESC,
    t1.id ASC
LIMIT 2;

SELECT
    e.employee_id AS employee_id,
    e.name AS employee_name,
    m.name AS manager_name
FROM employees_selfjoin 
INNER JOIN employees_selfjoin AS m
    ON e.manager_id = m.employee_id
WHERE m.name = 'Bob'
ORDER BY e.employee_id DESC
LIMIT 1;
