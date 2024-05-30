-- DAY 8 --
-- CHALLENGE INSPIRATION FROM: https://leetcode.com/problems/last-person-to-fit-in-the-bus/description
-- =========
-- TASK --
-- =========
-- person_id (INT): A unique identifier for each person waiting in the queue.
-- person_name (VARCHAR): The name of the person waiting in the queue.
-- weight (INT): The weight of the person in kilograms.
-- turn (INT): Determines the order in which people will board the bus. A "turn" value of 1 denotes
-- the first person to board the bus, while a value of n denotes the last person to board.
-- There is a queue of people waiting to board a bus. However, the bus has a weight limit of 1000 kilograms,
-- so there may be some people who cannot board.
-- Write a solution to find the person_name of the last person that can fit on the bus without exceeding the weight limit.
-- The test cases are generated such that the first person does not exceed the weight limit.
-- =============================================================================================================================


CREATE TABLE Queue (
    person_id INT,
    person_name VARCHAR(255),
    weight INT,
    turn INT
);
INSERT INTO Queue (person_id, person_name, weight, turn)
VALUES
    (5, 'Alice', 250, 1),
    (4, 'Bob', 175, 5),
    (3, 'Alex', 350, 2),
    (6, 'John Cena', 400, 3),
    (1, 'Winston', 500, 6),
    (2, 'Marie', 200, 4);


-- Solution using Subquery
-- =======================

SELECT person_name
FROM (
	SELECT person_name,
		   turn,
           SUM(weight) OVER(ORDER BY turn) AS cumulative_weight
	FROM Queue ) AS  a
WHERE cumulative_weight <= 1000
ORDER BY turn DESC
LIMIT 1;

-- Solution using Common Table Expression
-- ========================================

WITH cte AS(
SELECT person_id, 
	person_name, 
    SUM(weight) OVER(ORDER BY turn) AS totals,
    turn
FROM Queue)
	SELECT person_name 
	FROM cte
    where totals <= 1000
    ORDER BY totals DESC
    LIMIT 1;
    
    

-- Solution using Join
-- ====================

SELECT a.person_name
FROM Queue a
LEFT JOIN Queue b
ON a.turn >= b.turn
GROUP BY a.person_name
HAVING SUM(b.weight) <= 1000
ORDER BY SUM(b.weight) DESC
LIMIT 1;


-- DROP TABLE Queue;



