-- DAY 6 --
-- CHALLENGE INSPIRATION FROM: https://leetcode.com/problems/product-price-at-a-given-date/description/
-- TASK --
-- Write a solution to find the prices of all products on 2019-08-16. 
-- Assume the price of all products before any change is 10.
-- Return the result in any order

CREATE TABLE Products(
product_id int,
new_price decimal(5,2),
change_date date
);

INSERT INTO Products VALUES 
	(1, 20.50, '2019-08-14'),
	(2, 50.99, '2019-08-14'),
	(1, 30.55, '2019-08-15'),
	(1, 36.78, '2019-08-16'),
	(2,67.75, '2019-08-17'),
	(3, 15.90, '2019-08-18');


-- SOLUTION:
    
    SELECT 
    product_id, 
    COALESCE(
        (SELECT new_price FROM Products 
        WHERE product_id = p.product_id AND 
               change_date <= '2019-08-16' 
               ORDER BY change_date DESC LIMIT 1), 
		10
    ) AS price
FROM 
    (SELECT DISTINCT product_id FROM Products) AS p;

















