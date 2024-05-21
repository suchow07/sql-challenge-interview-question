-- DAY 4 --
-- CHALLENGE INSPIRATION FROM: https://datalemur.com/questions/odd-even-measurements
-- TASK --
-- Assume you're given a table with measurement values obtained from a Google sensor
-- over multiple days with measurements taken multiple times within each day.
-- Write a query to calculate the sum of odd-numbered and even-numbered measurements
-- separately for a particular day and display the results in two different columns.



CREATE TABLE measurements(
measurement_id INT,
measurement_value DECIMAL(8,2),
measurement_time DATETIME
);

INSERT INTO measurements VALUES
                            (131233,	1109.51, '2022-07-10 09:00:00'),
                            (135211, 1662.74, '2022-07-10 11:00:00'),
                            (143562, 1124.50, '2022-07-11 13:15:00'),
                            (346462, 1234.14, '2022-07-11 15:00:00'),
                            (124245, 1252.62, '2022-07-11 16:45:00'),
                            (523542, 1246.24, '2022-07-10 14:30:00'),
                            (143251, 1246.56, '2022-07-11 18:00:00'),
                            (141565, 1452.40, '2022-07-12 08:00:00'),
                            (253622, 1244.30, '2022-07-12 14:00:00'),
                            (353625, 1451.00, '2022-07-12 15:00:00');
                            
WITH cte_measurements AS (
SELECT 
	CAST(measurement_time AS DATE) AS measurement_day,
    measurement_value,
    ROW_NUMBER() OVER(PARTITION BY CAST(measurement_time AS DATE) 
					  ORDER BY measurement_time) AS row_num
FROM measurements)
SELECT 
	measurement_day,
	SUM(CASE WHEN row_num % 2 = 1 THEN measurement_value ELSE 0 END) AS odd_sum,
    SUM(CASE WHEN row_num % 2 = 0 THEN measurement_value ELSE 0 END) AS even_sum
FROM cte_measurements
GROUP BY measurement_day;

