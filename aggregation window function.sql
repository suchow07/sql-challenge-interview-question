

CREATE TABLE sales (
    order_number INT NOT NULL,
    order_date DATE NOT NULL,
    salesperson_id INT NOT NULL,
    product_id VARCHAR(5) NOT NULL,
    amount FLOAT NOT NULL
);

-- Insert sample data into the 'sales_transactions' table
INSERT INTO sales (order_number, order_date, salesperson_id, product_id, amount) 
VALUES 
(1, '2023-01-01', 101, 'P001', 650),
(2, '2023-01-02', 102, 'P001', 1300),
(3, '2023-01-03', 103, 'P003', 925),
(4, '2023-01-04', 104, 'P002', 240),
(5, '2023-01-05', 102, 'P003', 1850),
(6, '2023-01-06', 103, 'P002', 960),
(7, '2023-01-07', 104, 'P002', 480),
(8, '2023-01-08', 104, 'P001', 1950),
(9, '2023-01-09', 103, 'P002', 1440),
(10, '2023-01-10', 104, 'P002', 720);

select * from sales;

-- total sales

SELECT 
	SUM(amount) AS total_amount
FROM sales;


-- Using Group by
SELECT 
	salesperson_id
	, SUM(amount) AS total_amount
FROM sales
GROUP BY	
	salesperson_id;



-- query without partition
SELECT 
    salesperson_id, 
    order_date, 
    product_id, 
    amount,
    SUM(amount) OVER() AS total_amount
FROM 
    sales;



-- total amount sold by salesperson_id
SELECT 
    salesperson_id, 
    order_date, 
    product_id, 
    amount, 
    SUM(amount) OVER (PARTITION BY salesperson_id) AS Total_sales
FROM 
    sales;


-- lowest amount by a salesperson
SELECT 
    salesperson_id, 
    order_date, 
    product_id, 
    amount, 
    MIN(amount) OVER (PARTITION BY salesperson_id) AS Total_sales
FROM 
    sales;


-- Calculating a percent of total
SELECT 
    salesperson_id, 
    order_date, 
    product_id, 
    amount, 
    ROUND(amount * 100.0 / SUM(amount) OVER () ,2) AS pct_of_total, 
    ROUND(amount * 100.0 / SUM(amount) OVER (PARTITION BY salesperson_id) ,2) AS pct_of_sp_total
FROM 
    sales;


-- Running sum Order by
	SELECT 
    salesperson_id, 
    order_date, 
    product_id, 
	amount, 
    SUM(amount) OVER (ORDER BY order_date) AS total_amount
FROM 
    sales;


-- Calculating Running Total Within a Window
SELECT 
    salesperson_id, 
    order_date, 
    product_id, 
    amount,
    SUM(amount) OVER (PARTITION BY salesperson_id ORDER BY order_date) AS total_amount
FROM 
    sales;


-- Rolling sales of Rows between 2 preceding and current row
SELECT 
    salesperson_id, 
    order_date, 
    product_id,
	amount,
    SUM(amount) 
      OVER (ORDER BY order_date 
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS total_amount
FROM 
    sales;


--  Moving average of sales over the last 3 days
SELECT 
    salesperson_id, 
    order_date, 
    product_id,
	amount,
    ROUND(AVG(amount) 
      OVER (ORDER BY order_date 
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) AS total_amount
FROM 
    sales;


-- Rows between 1 preceding and 1 following
SELECT 
    salesperson_id, 
    order_date, 
    product_id, 
    amount,
    SUM(amount) OVER (
				ORDER BY order_date 
				ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS total_amount
FROM 
    sales;

	
-- Rows between 2 preceding and 1 preceding
	SELECT 
    salesperson_id, 
    order_date, 
    product_id, 
    amount,
    SUM(amount) 
        OVER (ORDER BY order_date 
              ROWS BETWEEN 2 PRECEDING AND 1 PRECEDING) AS total_amount
	FROM 
		sales;


-- Rows between unbounded preceding and current row
	SELECT 
    salesperson_id, 
    order_date, 
    product_id, 
    amount,
    SUM(amount) 
        OVER(ORDER BY order_date 
             ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS total_amount
FROM 
    sales;




