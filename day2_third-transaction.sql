-- DAY 2 --
-- CHALLENGE INSPIRATION FROM: https://datalemur.com/questions/sql-third-transaction
-- CHALLENGE: Write a query to obtain the third transaction of every user. --

USE dataLemurDB;

CREATE TABLE transactions(
user_id INT,
spend DECIMAL(10,2),
transaction_date TIMESTAMP
);


INSERT INTO transactions VALUES (111, 100.50, '2022-01-08 12:00:00');
INSERT INTO transactions VALUES (111, 55.00, '2022-01-10 12:00:00');
INSERT INTO transactions VALUES (121, 36.00, '2022-01-18 12:00:00');
INSERT INTO transactions VALUES (145, 24.99, '2022-01-26 12:00:00');
INSERT INTO transactions VALUES (111, 89.60, '2022-02-05 12:00:00');
INSERT INTO transactions VALUES (145, 45.30, '2022-02-28 12:00:00');
INSERT INTO transactions VALUES (121, 22.20, '2022-04-01 12:00:00');
INSERT INTO transactions VALUES (121, 67.90, '2022-04-03 12:00:00');
INSERT INTO transactions VALUES (263, 156.00, '2022-04-11 12:00:00');
INSERT INTO transactions VALUES (230, 78.30, '2022-06-14 12:00:00');
INSERT INTO transactions VALUES (263, 68.12, '2022-07-11 12:00:00');
INSERT INTO transactions VALUES (263, 100.00, '2022-07-12 12:00:00');


SELECT * FROM transactions;

-- CHALLENGE: Write a query to obtain the third transaction of every user. --

SELECT 
	user_id, 
    spend,
    transaction_date
FROM
	(SELECT *,
	row_number() OVER(
				PARTITION BY user_id 
                ORDER BY transaction_date) as rn
FROM transactions) a
WHERE a.rn = 3;









