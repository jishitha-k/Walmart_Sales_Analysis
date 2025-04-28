SELECT *
FROM Walmart_clean;

--- Count of values
SELECT COUNT(*)
FROM Walmart_clean;

-- Distinct categories in the table
SELECT DISTINCT category
FROM Walmart_clean;

-- Using groupby count number of values in each category
SELECT category, COUNT(*)
FROM Walmart_clean
GROUP BY category;

-- Distinct branch count
SELECT COUNT(DISTINCT Branch)
FROM Walmart_clean;

-- Find different payment method and number of transactions, number of qty sold
SELECT payment_method, COUNT(*) as num_payments, SUM(quantity) as num_of_quantity
FROM Walmart_clean
GROUP BY payment_method;

-- Identify the highest-rated category in each branch, displaying the branch, category 
SELECT *
FROM
    (   SELECT
        Branch,
        category,
        AVG(rating) as Avg_Rating,
        RANK() OVER(PARTITION BY Branch ORDER BY AVG(rating) DESC) as Branch_Rank
    FROM Walmart_clean
    GROUP BY Branch, category
) AS subquery
WHERE Branch_Rank = 1;

--Identify busiest day for each branch based on number of number of transactions
SELECT Branch, date, COUNT(*) as No_Transactions
FROM Walmart_clean
GROUP BY Branch, date;

-- Categorize sales into 3 groups Morning, Afternoon, and Evening. Find out number of invoices in each shift
SELECT
    CASE 
        WHEN DATEPART(HOUR, time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS day_time,
    COUNT(*) AS num_invoices
FROM Walmart_clean
GROUP BY
    CASE 
        WHEN DATEPART(HOUR, time) < 12 THEN 'Morning'
        WHEN DATEPART(HOUR, time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END
ORDER BY num_invoices;
