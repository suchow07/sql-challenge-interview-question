
-- ============================================================================

-- Department Top Three Salaries:

-- CHALLENGE INSPIRATION FROM: 
--            https://datalemur.com/questions/sql-third-transaction
-- =========
-- TASK --
-- =========
-- Write a query to obtain the third transaction of every user. 
-- Output the user id, spend and transaction date.


-- =============================================================================

CREATE TABLE Department (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);


CREATE TABLE EmpDetails (
    id INT PRIMARY KEY,
    employee VARCHAR(50),
    salary INT,
    departmentId INT
);


INSERT INTO Department (id, name) VALUES
(1, 'HR'),
(2, 'Sales');


INSERT INTO EmpDetails (id, employee, salary, departmentId) VALUES
(1, 'Ankit', 90000, 1),
(2, 'Serena', 85000, 1),
(3, 'Sachin', 50000, 2),
(4, 'Jenny', 70000, 2),
(5, 'Eva', 70000, 1),
(6, 'Ishan', 40000, 2),
(7, 'Leena', 75000, 2),
(8, 'Tim', 80000, 1),
(9, 'Rachel', 80000, 2),
(10, 'Suparna', 90000, 1);



-- SOLUTION

SELECT
  d.name AS Department
  , e.employee AS Employee
  , e.Salary
FROM (
SELECT 
  employee
  , salary
  , departmentId,
  DENSE_RANK() over(partition by departmentId order by salary desc) as rnk
from EmpDetails
      ) as e
JOIN Department d
ON e.departmentId = d.id
WHERE rnk <= 3;

