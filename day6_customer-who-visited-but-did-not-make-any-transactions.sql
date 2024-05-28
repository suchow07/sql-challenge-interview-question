-- DAY 6 --
-- CHALLENGE INSPIRATION FROM: https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/description
-- TASK --
-- Write a solution to find the IDs of the users who visited without making any
-- transactions and the number of times they made these types of visits.
-- Return the result table sorted in any order.

-- Create the table Visits
CREATE TABLE Visits (
    visit_id INT,
    customer_id INT,
    PRIMARY KEY (visit_id)
);

-- Insert data into the table
INSERT INTO Visits (visit_id, customer_id) VALUES
(1, 23),
(2, 9),
(4, 30),
(5, 54),
(6, 96),
(7, 54),
(8, 54);

-- Create the table CustomerTransaction
CREATE TABLE CustomerTransaction (
    transaction_id INT,
    visit_id INT,
    amount INT,
    PRIMARY KEY (transaction_id),
    FOREIGN KEY (visit_id) REFERENCES Visits(visit_id)
);

-- Insert data into the table
INSERT INTO CustomerTransaction (transaction_id, visit_id, amount) VALUES
(2, 5, 310),
(3, 5, 300),
(9, 5, 200),
(12, 1, 910),
(13, 2, 970);

-- TASK --
-- Write a solution to find the IDs of the users who visited without making any
-- transactions and the number of times they made these types of visits.
-- Return the result table sorted in any order.

-- # METHOD 1 USING LEFT JOIN

SELECT 
	v.customer_id,
	COUNT(v.customer_id) AS count_no_trans
FROM Visits v
LEFT JOIN 
	CustomerTransaction ct
ON v.visit_id = ct.visit_id
WHERE ct.transaction_id IS NULL
GROUP BY v.customer_id;


-- # METHOD 2 USING SUBQUERY

SELECT customer_id,
		COUNT(*) AS count_no_trans
FROM Visits
WHERE visit_id NOT IN 
          ( SELECT visit_id FROM CustomerTransaction
			)
GROUP BY customer_id;

