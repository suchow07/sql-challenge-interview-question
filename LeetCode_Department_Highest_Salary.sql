
-- ============================================================================

-- Department Top Three Salaries:

-- CHALLENGE INSPIRATION FROM: 
--            https://leetcode.com/problems/department-highest-salary/solutions/1596227/184.-Department-Highest-Salary/
-- =========
-- TASK --
-- =========
-- Write a solution to find employees who have the highest salary in each of the departments.



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

-- SELECT * FROM Department;
-- SELECT * FROM Empdetails;


-- =======================================================================
-- SOLUTION 1


WITH cte AS (
    SELECT *,
           RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS rnk
    FROM EmpDetails
)

SELECT
    d.name AS Department,
    cte.employee AS Employee,
    cte.salary AS Salary
FROM cte
JOIN Department d ON cte.departmentId = d.id
WHERE cte.rnk = 1;


-- SOLUTION 2

 SELECT
    d.name as Department,
    e.employee AS Employees,
    e.Salary
FROM 
    EmpDetails e
    JOIN Department d
    ON e.departmentId = d.id
CROSS APPLY (
    SELECT MAX(Salary) AS MaxSalary
    FROM EmpDetails 
    WHERE departmentId = e.departmentId
) AS maxSalaries
WHERE e.Salary = maxSalaries.MaxSalary;









