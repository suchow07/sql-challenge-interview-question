-- DAY 9 --
-- CHALLENGE INSPIRATION FROM: https://leetcode.com/problems/restaurant-growth/description
-- =========
-- TASK --
-- =========
-- You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).
-- Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before).
-- average_amount should be rounded to two decimal places.
-- Return the result table ordered by visited_on in ascending order.
-- =============================================================================================================================
use datalemurdb;
-- Create Customer table
CREATE TABLE Customer (
    customer_id INT,
    name VARCHAR(255),
    visited_on DATE,
    amount INT
);

-- Insert data into Customer table
INSERT INTO Customer (customer_id, name, visited_on, amount) VALUES
(1, 'Jhon', '2019-01-01', 100),
(2, 'Daniel', '2019-01-02', 110),
(3, 'Jade', '2019-01-03', 120),
(4, 'Khaled', '2019-01-04', 130),
(5, 'Winston', '2019-01-05', 110),
(6, 'Elvis', '2019-01-06', 140),
(7, 'Anna', '2019-01-07', 150),
(8, 'Maria', '2019-01-08', 80),
(9, 'Jaze', '2019-01-09', 110),
(1, 'Jhon', '2019-01-10', 130),
(3, 'Jade', '2019-01-10', 150);

-- =========================================
 -- Solution 1  
 WITH Totals  AS (SELECT visited_on, sum(amount) as amount
FROM customer
GROUP BY visited_on
)
SELECT * FROM
(SELECT
    visited_on,
    SUM(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount,
    ROUND(AVG(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS average_amount
FROM Totals) as a
WHERE DATE_SUB(visited_on, INTERVAL 6 DAY) IN (SELECT visited_on FROM Totals)
GROUP BY
    visited_on, amount
ORDER BY
    visited_on;
 
    


-- =========================================
 -- Solution 2

SELECT 
    a.visited_on, 
    SUM(b.amount) AS amount, 
    ROUND((SUM(b.amount) / 7), 2) AS average_amount
FROM 
    ( SELECT visited_on, SUM(amount) AS amount
	  FROM Customer 
	  GROUP BY visited_on
    ) AS a,
    ( SELECT visited_on, SUM(amount) AS amount
	  FROM Customer 
	  GROUP BY visited_on ) AS b      
WHERE a.visited_on >= b.visited_on  AND
    DATEDIFF(a.visited_on, b.visited_on) <= 6
GROUP BY a.visited_on 
HAVING COUNT(DISTINCT b.visited_on) = 7;
    
-- =============================

