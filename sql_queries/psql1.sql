SELECT * FROM walmart
LIMIT 5;

-- Walmart Project Queries


-- Business Problems
--Q.1 Find different payment method and number of transactions, number of qty sold

SELECT 
	payment_method,
	COUNT(*) as no_transaction,
	SUM(quantity) as no_qty
FROM walmart
GROUP BY payment_method;

-- Project Question #2
-- Identify the highest-rated category in each branch, displaying the branch, category
-- AVG RATING
SELECT 
    branch,
    category,
    avg_rating
FROM (
    SELECT
        branch,
        category,
        AVG(rating) AS avg_rating,
        ROW_NUMBER() OVER (
            PARTITION BY branch
            ORDER BY AVG(rating) DESC
        ) AS rn
    FROM walmart
    WHERE rating IS NOT NULL
    GROUP BY branch, category
) t
WHERE rn = 1;


-- Q.3 Identify the busiest day for each branch based on the number of transactions
SELECT
    branch,
    date,
    no_transactions
FROM (
	SELECT
		branch,
		date,
		COUNT(*) as no_transactions,
		RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) as rnk
	FROM walmart
	GROUP BY branch, date	
) t
WHERE rnk = 1
ORDER BY branch
-- Q. 4 
-- Calculate the total quantity of items sold per payment method. List payment_method and total_quantity.

SELECT 
	payment_method,
	COUNT(*) AS no_payments,
	SUM(quantity) AS total_quantity
FROM walmart
GROUP BY payment_method;

-- Q.5
-- Determine the average, minimum, and maximum rating of category for each city. 
-- List the city, average_rating, min_rating, and max_rating.

SELECT
	city,
	ROUND(AVG(rating)::numeric, 2) AS avg_rating,
	MIN(rating) AS min_rating,
	MAX(rating) AS max_rating
FROM walmart
GROUP BY city
ORDER BY avg_rating DESC, min_rating ASC, max_rating DESC;

-- Q.6
-- Calculate the total profit for each category by considering total_profit as
-- (unit_price * quantity * profit_margin). 
-- List category and total_profit, ordered from highest to lowest profit.





-- Q.7
-- Determine the most common payment method for each Branch. 
-- Display Branch and the preferred_payment_method.





-- Q.8
-- Categorize sales into 3 group MORNING, AFTERNOON, EVENING 
-- Find out each of the shift and number of invoices





-- 
-- #9 Identify 5 branch with highest decrese ratio in 
-- revevenue compare to last year(current year 2023 and last year 2022)

-- rdr == last_rev-cr_rev/ls_rev*100




-- 2022 sales
