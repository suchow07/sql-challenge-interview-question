-- DAY 6 --
-- CHALLENGE INSPIRATION FROM: https://leetcode.com/problems/employees-whose-manager-left-the-company/description
-- TASK --
-- Find the IDs of the employees whose salary is strictly less than $30000
-- and whose manager left the company. When a manager leaves the company,
-- their information is deleted from the Employees table, but the reports still
-- have their manager_id set to the manager that left

-- Create the Employees table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY NOT NULL,
    name VARCHAR(255),
    manager_id INT,
    salary INT
);

-- Insert data into the Employees table
INSERT INTO Employees (employee_id, name, manager_id, salary)
VALUES
    (3, 'Mila', 9, 60301),
    (12, 'Antonella', null, 31000),
    (13, 'Emery', null, 67084),
    (1, 'Kalel', 11, 21241),
    (9, 'Mikaela', null, 50937),
    (11, 'Joziah', 6, 28485);
    
    
-- TASK --
-- Find the IDs of the employees whose salary is strictly less than $30000
-- and whose manager left the company. When a manager leaves the company,
-- their information is deleted from the Employees table, but the reports still
-- have their manager_id set to the manager that left

SELECT employee_id
FROM Employees
WHERE salary < 30000
AND 
manager_id NOT IN (SELECT employee_id FROM Employees)
ORDER BY employee_id;



DROP TABLE Employees;
    
    