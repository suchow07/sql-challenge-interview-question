-- DAY 6 --
-- CHALLENGE INSPIRATION FROM: https://leetcode.com/problems/managers-with-at-least-5-direct-reports/description
-- TASK --
-- Write a solution to find managers with at least five direct reports.
-- Return the result table in any order.

-- Create the table
CREATE TABLE Employee (
    id INT,
    name VARCHAR(50),
    department VARCHAR(50),
    managerId INT,
    PRIMARY KEY (id)
);

-- Insert data into the table
INSERT INTO Employee (id, name, department, managerId) VALUES
(101, 'John', 'A', NULL),
(102, 'Dan', 'A', 101),
(103, 'James', 'A', 101),
(104, 'Amy', 'A', 101),
(105, 'Anne', 'A', 101),
(106, 'Ron', 'B', 101);

-- Solution
SELECT name 
FROM Employee
WHERE id IN
( SELECT DISTINCT managerId 
FROM Employee
GROUP BY managerId
HAVING COUNT(managerId) >= 5
);

