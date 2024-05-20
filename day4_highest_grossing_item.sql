-- DAY 4 --
-- CHALLENGE INSPIRATION FROM: https://datalemur.com/questions/sql-highest-grossing
-- TASK --
-- Assume you're given a table containing data on Amazon customers and their spending
-- on products in different category, write a query to identify the top two
-- highest-grossing products within each category in the year 2022. 
-- The output should include the category, product, and total spend.

CREATE TABLE product_spend(
				category VARCHAR(30),
                product VARCHAR(30),
                user_id INT,
                spend DECIMAL(7,2),
                transaction_date timestamp
);

INSERT INTO product_spend 
VALUES
 ('appliance',	'washing machine',	123,	219.80,	'2022-03-02 11:00:00'),
('electronics',	'vacuum',	178,	152.00,	'2022-04-05 10:00:00'),	
('electronics', 'wireless headset',	156,	249.90,	'2022-07-06 10:00:00'),
('electronics', 'vacuum',	        145,	189.00,	'2022-07-15 10:00:00'),
('electronics', 'computer mouse',	195, 45.00,	    '2022-07-01 11:00:00'),
('appliance', 'refrigerator',		165, 246.00,	'2021-12-26 12:00:00'	),
('appliance', 'refrigerator',		123, 299.99,	'2022-03-02 11:00:00'	),
('appliance', 'washing machine',	123, 220.00,	'2022-07-27 04:00:00'	),
('electronics', 'vacuum',		    156, 145.66,	'2022-08-10 04:00:00' ),
('electronics', 'wireless headset',	145, 198.00,	'2022-08-04 04:00:00'	),
('electronics', 'wireless headset',	215, 19.99,	    '2022-09-03 16:00:00'),
('appliance', 'microwave',		    169, 49.99,	'2022-08-28 16:00:00'),
('appliance', 'microwave',		    101, 34.49,	'2023-03-01 17:00:00'),
('electronics', '3.5mm headphone jack',	101, 7.99,	'2022-10-07 16:00:00'),
('appliance', 'microwave',	      101, 64.95, '2023-07-08 16:00:00');



SELECT category,
		product,
        total_spend
FROM (
	 SELECT category,
			product,
			SUM(spend) as total_spend,
			RANK() OVER(PARTITION BY category ORDER BY SUM(spend) DESC ) AS ranking
	 FROM product_spend
         WHERE YEAR(transaction_date) = 2022
	 GROUP BY category, product) ranked_product
WHERE ranking <= 2
ORDER BY category, total_spend DESC;


