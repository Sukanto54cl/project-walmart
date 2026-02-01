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

WITH highest_rated_cat AS (
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
	)
SELECT
    branch,
    category,
    avg_rating
FROM highest_rated_cat
WHERE rn = 1;


-- Q.3 Identify the busiest day for each branch based on the number of transactions

WITH busiest_day AS (
	SELECT
		branch,
		date,
		COUNT(*) as no_transactions,
		RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) as rnk
	FROM walmart
	GROUP BY branch, date	
)
SELECT
    branch,
    date,
    no_transactions
FROM busiest_day
WHERE rnk = 1
ORDER BY branch;

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

SELECT
	category,
	ROUND(SUM(unit_price * quantity * profit_margin)::numeric, 2) AS total_profit
FROM walmart
GROUP BY category
ORDER BY total_profit DESC;


-- Q.7
-- Determine the most common payment method for each Branch. 
-- Display Branch and the preferred_payment_method.

WITH ranked_payment AS (
    SELECT
        branch,
        payment_method,
        COUNT(*) AS cnt,
        ROW_NUMBER() OVER (
            PARTITION BY branch
            ORDER BY COUNT(*) DESC
        ) AS rn
    FROM walmart
    GROUP BY branch, payment_method
	)
SELECT
	branch,
	payment_method,
	cnt,
	rn
FROM ranked_payment
WHERE rn = 1
ORDER BY branch;

-- Q.8
-- Categorize sales into 3 group MORNING, AFTERNOON, EVENING 
-- Find out each of the shift and number of invoices

SELECT
	*,
	CASE
		WHEN time::time BETWEEN '00:00:00' AND '11:59:59' THEN 'MORNING'
		WHEN time::time BETWEEN '12:00:00' AND '16:59:59' THEN 'AFTERNOON'
		ELSE 'EVENING'
	END AS time_of_day
FROM walmart;

SELECT
	CASE
		WHEN time::time BETWEEN '00:00:00' AND '11:59:59' THEN 'MORNING'
		WHEN time::time BETWEEN '12:00:00' AND '16:59:59' THEN 'AFTERNOON'
		ELSE 'EVENING'
	END AS time_of_day,
	COUNT(*) as total_sales
FROM walmart
GROUP BY time_of_day
ORDER BY total_sales DESC;


-- 
-- #9 Identify 5 branch with highest decrese ratio in 
-- revevenue compare to last year(current year 2023 and last year 2022)

-- rdr == last_rev-cr_rev/ls_rev*100




-- 2022 sales

WITH revenue_2022 AS (
    SELECT 
        branch,
        SUM(total) AS revenue
    FROM walmart
    WHERE EXTRACT(YEAR FROM date::date) = 2022
    GROUP BY branch
),
revenue_2023 AS (
    SELECT 
        branch,
        SUM(total) AS revenue
    FROM walmart
    WHERE EXTRACT(YEAR FROM date::date) = 2023
    GROUP BY branch
)
SELECT 
    ls.branch,
    ls.revenue AS last_year_revenue,
    cs.revenue AS cr_year_revenue,
    ROUND(
        (ls.revenue - cs.revenue)::numeric
        / ls.revenue::numeric * 100,
        2
    ) AS rev_dec_ratio
FROM revenue_2022 ls
JOIN revenue_2023 cs
    ON ls.branch = cs.branch
WHERE ls.revenue > cs.revenue
ORDER BY rev_dec_ratio DESC
LIMIT 5;





